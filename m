Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E423A4B0A
	for <lists+linux-api@lfdr.de>; Sat, 12 Jun 2021 01:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFKXDq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Jun 2021 19:03:46 -0400
Received: from mail.klausen.dk ([157.90.24.29]:53294 "EHLO mail.klausen.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhFKXDq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Jun 2021 19:03:46 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jun 2021 19:03:45 EDT
Subject: Re: [PATCH v5 11/11] loop: Add LOOP_CONFIGURE ioctl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klausen.dk; s=dkim;
        t=1623452065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgLFKfLGzYu14ZiloJfDFndNFiDm2vYwSH1kUfP2Vw0=;
        b=H5Aa62Up/Pyj7Lz6ofQQgYiFTcEqZdupILKfzB95O0G5iiy7TMYIY06ZPFC98UmvefqJ0F
        yKoDmFxJi21HFUdqDJ0dZcrg4BlvfTJfEGp+WDpzMNQcU6h8bthuCHKYRsFJXHNPfpTHv0
        D5ViA0hBw2JHuyMFNAX5dachYAq6nvQ=
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
References: <20200513133845.244903-1-maco@android.com>
 <20200513133845.244903-12-maco@android.com>
From:   Kristian Klausen <kristian@klausen.dk>
Message-ID: <c24d7aab-a2f8-f87b-c944-046b6d059e37@klausen.dk>
Date:   Sat, 12 Jun 2021 00:54:24 +0200
MIME-Version: 1.0
In-Reply-To: <20200513133845.244903-12-maco@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 13.05.2020 15.38, Martijn Coenen wrote:
> This allows userspace to completely setup a loop device with a single
> ioctl, removing the in-between state where the device can be partially
> configured - eg the loop device has a backing file associated with it,
> but is reading from the wrong offset.
>
> Besides removing the intermediate state, another big benefit of this
> ioctl is that LOOP_SET_STATUS can be slow; the main reason for this
> slowness is that LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to
> freeze the associated queue; this requires waiting for RCU
> synchronization, which I've measured can take about 15-20ms on this
> device on average.
>
> In addition to doing what LOOP_SET_STATUS can do, LOOP_CONFIGURE can
> also be used to:
> - Set the correct block size immediately by setting
>    loop_config.block_size (avoids LOOP_SET_BLOCK_SIZE)
> - Explicitly request direct I/O mode by setting LO_FLAGS_DIRECT_IO
>    in loop_config.info.lo_flags (avoids LOOP_SET_DIRECT_IO)
> - Explicitly request read-only mode by setting LO_FLAGS_READ_ONLY
>    in loop_config.info.lo_flags
>
> Here's setting up ~70 regular loop devices with an offset on an x86
> Android device, using LOOP_SET_FD and LOOP_SET_STATUS:
>
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>      0m03.40s real     0m00.02s user     0m00.03s system
>
> Here's configuring ~70 devices in the same way, but using a modified
> losetup that uses the new LOOP_CONFIGURE ioctl:
>
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>      0m01.94s real     0m00.01s user     0m00.01s system
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>   drivers/block/loop.c      | 104 ++++++++++++++++++++++++++++----------
>   include/uapi/linux/loop.h |  21 ++++++++
>   2 files changed, 97 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 13518ba191f5..a565c5aafa52 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -228,6 +228,19 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>   		blk_mq_unfreeze_queue(lo->lo_queue);
>   }
>   
> +/**
> + * loop_validate_block_size() - validates the passed in block size
> + * @bsize: size to validate
> + */
> +static int
> +loop_validate_block_size(unsigned short bsize)
> +{
> +	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   /**
>    * loop_set_size() - sets device size and notifies userspace
>    * @lo: struct loop_device to set the size for
> @@ -1050,23 +1063,24 @@ loop_set_status_from_info(struct loop_device *lo,
>   	return 0;
>   }
>   
> -static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> -		       struct block_device *bdev, unsigned int arg)
> +static int loop_configure(struct loop_device *lo, fmode_t mode,
> +			  struct block_device *bdev,
> +			  const struct loop_config *config)
>   {
>   	struct file	*file;
>   	struct inode	*inode;
>   	struct address_space *mapping;
>   	struct block_device *claimed_bdev = NULL;
> -	int		lo_flags = 0;
>   	int		error;
>   	loff_t		size;
>   	bool		partscan;
> +	unsigned short  bsize;
>   
>   	/* This is safe, since we have a reference from open(). */
>   	__module_get(THIS_MODULE);
>   
>   	error = -EBADF;
> -	file = fget(arg);
> +	file = fget(config->fd);
>   	if (!file)
>   		goto out;
>   
> @@ -1075,7 +1089,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>   	 * here to avoid changing device under exclusive owner.
>   	 */
>   	if (!(mode & FMODE_EXCL)) {
> -		claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
> +		claimed_bdev = bd_start_claiming(bdev, loop_configure);
>   		if (IS_ERR(claimed_bdev)) {
>   			error = PTR_ERR(claimed_bdev);
>   			goto out_putf;
> @@ -1097,11 +1111,26 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>   	mapping = file->f_mapping;
>   	inode = mapping->host;
>   
> +	size = get_loop_size(lo, file);
> +
> +	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
> +		error = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	if (config->block_size) {
> +		error = loop_validate_block_size(config->block_size);
> +		if (error)
> +			goto out_unlock;
> +	}
> +
> +	error = loop_set_status_from_info(lo, &config->info);

loop_set_status_from_info() doesn't call loop_config_discard() nor does 
loop_configure(), I assume it should be called?

I'm asking because I upgraded to util-linux 2.37 which use the new 
LOOP_CONFIGURE ioctl and fstrim is complaining that "the discard 
operation is not supported" and the missing call of 
loop_config_discard() stood out. Sadly I haven't been able to reproduce 
the issue reliably outside CI (yet).

> +	if (error)
> +		goto out_unlock;
> +
>   	if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
>   	    !file->f_op->write_iter)
> -		lo_flags |= LO_FLAGS_READ_ONLY;
> -
> -	size = get_loop_size(lo, file);
> +		lo->lo_flags |= LO_FLAGS_READ_ONLY;
>   
>   	error = loop_prepare_queue(lo);
>   	if (error)
>
