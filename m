Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD95F1CED32
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2020 08:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgELGq6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 May 2020 02:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgELGq5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 May 2020 02:46:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33781C061A0C
        for <linux-api@vger.kernel.org>; Mon, 11 May 2020 23:46:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h4so12288197ljg.12
        for <linux-api@vger.kernel.org>; Mon, 11 May 2020 23:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeTZxP3dnM+h84TinjF6yyznuz49WCl2s79pVqj9q+0=;
        b=ATbwFTBSuTvplUyJOlciI7Lp1ImnKy2Z1dcR75tuR61TLZi/Y+DMPIn2I7YADoi13z
         i5cWXmjznF3j2ihvlbapAJyGJUz5zuEwMRbU212gx1f1T+CHWh6CTP+E1PIHHPiw0hmB
         n3Kl9kwm4JImiY6eC6B2xBmj5+ubeF2Pnq7cum06+dHiPgqhM1drBZJ7L3dCCBcHduFt
         NNKk1qcVWkD1djsa878pDg0CCOfqbJrmHE7MPdaWK6f7SaTy9pGL09F4NYvR1c9KElga
         laqWxmtcaFId7m5CbUzIfxq4nnbuV44xs5BTaEYEMh63twJEUzKEElaF+N+301C2lSuh
         kKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeTZxP3dnM+h84TinjF6yyznuz49WCl2s79pVqj9q+0=;
        b=ZSwJYhyMkpLPlF3GgVVCsfdPJhzmeifcyMBD65htpdvW3g6VpTXudCUqUhWVz/FWSr
         LhoY8MQyrbsoLMkly6zbMNkwQh0I9Y5G+ZZvgmKeIa1J7eEnwpU3p7qGF1FvI3YYbb98
         PfsHFZzkgQDKxUaXhITxi6oij2y/eOYMKlhUvWxouaopiZbaUkII+ESvpC5JEqRAgruY
         X8pJ6ky8v7FPYnkL5ijNLplBldE+ajxmz0qj1/BhoOG5LyQKk/yP1VmomJwE03WE2vo8
         D6qmMRTezTkRU10npViAq6SOsam12t5+Pe8poKZUnDz1/uLi2tvdR3iT33qc7Eoh8AEf
         3/Wg==
X-Gm-Message-State: AOAM530b+NvuIZc5yv7Gj4Icpn2auwk0rQaFPXuPFoEeaO8grS0l+C4y
        jHkf/xEee2CzvdiF6b/fkXsUAV8PQJH99Bl8fbSTkg==
X-Google-Smtp-Source: ABdhPJyZtuY9qCsHGIEz3JTPAzAjn0vfQh8ys7kF9BrqFVxmJMzK14yWT2xR6+ZOWqx/tt/hhhUEeM5HlaFKR9ToatY=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr13052701ljk.134.1589266015481;
 Mon, 11 May 2020 23:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
In-Reply-To: <20200429140341.13294-11-maco@android.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 12 May 2020 08:46:44 +0200
Message-ID: <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Jens,

What do you think of this series?

Thanks,
Martijn

On Wed, Apr 29, 2020 at 4:03 PM Martijn Coenen <maco@android.com> wrote:
>
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
>   loop_config.block_size (avoids LOOP_SET_BLOCK_SIZE)
> - Explicitly request direct I/O mode by setting LO_FLAGS_DIRECT_IO
>   in loop_config.info.lo_flags (avoids LOOP_SET_DIRECT_IO)
> - Explicitly request read-only mode by setting LO_FLAGS_READ_ONLY
>   in loop_config.info.lo_flags
>
> Here's setting up ~70 regular loop devices with an offset on an x86
> Android device, using LOOP_SET_FD and LOOP_SET_STATUS:
>
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>     0m03.40s real     0m00.02s user     0m00.03s system
>
> Here's configuring ~70 devices in the same way, but using a modified
> losetup that uses the new LOOP_CONFIGURE ioctl:
>
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>     0m01.94s real     0m00.01s user     0m00.01s system
>
> Signed-off-by: Martijn Coenen <maco@android.com>
> ---
>  drivers/block/loop.c      | 107 +++++++++++++++++++++++++++-----------
>  include/uapi/linux/loop.h |  21 ++++++++
>  2 files changed, 99 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index cfbdd99fdb1a..a353ce55fd18 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -241,6 +241,19 @@ loop_validate_size(loff_t size)
>         return 0;
>  }
>
> +/**
> + * loop_validate_block_size() - validates the passed in block size
> + * @bsize: size to validate
> + */
> +static int
> +loop_validate_block_size(unsigned short bsize)
> +{
> +       if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  /**
>   * loop_set_size() - sets device size and notifies userspace
>   * @lo: struct loop_device to set the size for
> @@ -1063,23 +1076,24 @@ loop_set_status_from_info(struct loop_device *lo,
>         return 0;
>  }
>
> -static int loop_set_fd(struct loop_device *lo, fmode_t mode,
> -                      struct block_device *bdev, unsigned int arg)
> +static int loop_configure(struct loop_device *lo, fmode_t mode,
> +                         struct block_device *bdev,
> +                         const struct loop_config *config)
>  {
>         struct file     *file;
>         struct inode    *inode;
>         struct address_space *mapping;
>         struct block_device *claimed_bdev = NULL;
> -       int             lo_flags = 0;
>         int             error;
>         loff_t          size;
>         bool            partscan;
> +       unsigned short  bsize;
>
>         /* This is safe, since we have a reference from open(). */
>         __module_get(THIS_MODULE);
>
>         error = -EBADF;
> -       file = fget(arg);
> +       file = fget(config->fd);
>         if (!file)
>                 goto out;
>
> @@ -1088,7 +1102,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>          * here to avoid changing device under exclusive owner.
>          */
>         if (!(mode & FMODE_EXCL)) {
> -               claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
> +               claimed_bdev = bd_start_claiming(bdev, loop_configure);
>                 if (IS_ERR(claimed_bdev)) {
>                         error = PTR_ERR(claimed_bdev);
>                         goto out_putf;
> @@ -1110,44 +1124,58 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>         mapping = file->f_mapping;
>         inode = mapping->host;
>
> -       if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
> -           !file->f_op->write_iter)
> -               lo_flags |= LO_FLAGS_READ_ONLY;
> -
>         size = get_loop_size(lo, file);
>         error = loop_validate_size(size);
>         if (error)
>                 goto out_unlock;
> +
> +       if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
> +               error = -EINVAL;
> +               goto out_unlock;
> +       }
> +
> +       if (config->block_size) {
> +               error = loop_validate_block_size(config->block_size);
> +               if (error)
> +                       goto out_unlock;
> +       }
> +
> +       error = loop_set_status_from_info(lo, &config->info);
> +       if (error)
> +               goto out_unlock;
> +
> +       if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
> +           !file->f_op->write_iter)
> +               lo->lo_flags |= LO_FLAGS_READ_ONLY;
> +
>         error = loop_prepare_queue(lo);
>         if (error)
>                 goto out_unlock;
>
>         error = 0;
>
> -       set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
> +       set_device_ro(bdev, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
>
> -       lo->use_dio = false;
> +       lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
>         lo->lo_device = bdev;
> -       lo->lo_flags = lo_flags;
>         lo->lo_backing_file = file;
> -       lo->transfer = NULL;
> -       lo->ioctl = NULL;
> -       lo->lo_sizelimit = 0;
>         lo->old_gfp_mask = mapping_gfp_mask(mapping);
>         mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
>
> -       if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
> +       if (!(lo->lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
>                 blk_queue_write_cache(lo->lo_queue, true, false);
>
> -       if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
> +       if (config->block_size)
> +               bsize = config->block_size;
> +       else if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev)
>                 /* In case of direct I/O, match underlying block size */
> -               unsigned short bsize = bdev_logical_block_size(
> -                       inode->i_sb->s_bdev);
> +               bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
> +       else
> +               bsize = 512;
>
> -               blk_queue_logical_block_size(lo->lo_queue, bsize);
> -               blk_queue_physical_block_size(lo->lo_queue, bsize);
> -               blk_queue_io_min(lo->lo_queue, bsize);
> -       }
> +       blk_queue_logical_block_size(lo->lo_queue, bsize);
> +       blk_queue_physical_block_size(lo->lo_queue, bsize);
> +       blk_queue_io_min(lo->lo_queue, bsize);
>
>         loop_update_rotational(lo);
>         loop_update_dio(lo);
> @@ -1170,14 +1198,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>         if (partscan)
>                 loop_reread_partitions(lo, bdev);
>         if (claimed_bdev)
> -               bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
> +               bd_abort_claiming(bdev, claimed_bdev, loop_configure);
>         return 0;
>
>  out_unlock:
>         mutex_unlock(&loop_ctl_mutex);
>  out_bdev:
>         if (claimed_bdev)
> -               bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
> +               bd_abort_claiming(bdev, claimed_bdev, loop_configure);
>  out_putf:
>         fput(file);
>  out:
> @@ -1607,8 +1635,9 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
>         if (lo->lo_state != Lo_bound)
>                 return -ENXIO;
>
> -       if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
> -               return -EINVAL;
> +       err = loop_validate_block_size(arg);
> +       if (err)
> +               return err;
>
>         if (lo->lo_queue->limits.logical_block_size == arg)
>                 return 0;
> @@ -1670,8 +1699,27 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>         int err;
>
>         switch (cmd) {
> -       case LOOP_SET_FD:
> -               return loop_set_fd(lo, mode, bdev, arg);
> +       case LOOP_SET_FD: {
> +               /*
> +                * Legacy case - pass in a zeroed out struct loop_config with
> +                * only the file descriptor set , which corresponds with the
> +                * default parameters we'd have used otherwise.
> +                */
> +               struct loop_config config;
> +
> +               memset(&config, 0, sizeof(config));
> +               config.fd = arg;
> +
> +               return loop_configure(lo, mode, bdev, &config);
> +       }
> +       case LOOP_CONFIGURE: {
> +               struct loop_config config;
> +
> +               if (copy_from_user(&config, argp, sizeof(config)))
> +                       return -EFAULT;
> +
> +               return loop_configure(lo, mode, bdev, &config);
> +       }
>         case LOOP_CHANGE_FD:
>                 return loop_change_fd(lo, bdev, arg);
>         case LOOP_CLR_FD:
> @@ -1843,6 +1891,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>         case LOOP_CLR_FD:
>         case LOOP_GET_STATUS64:
>         case LOOP_SET_STATUS64:
> +       case LOOP_CONFIGURE:
>                 arg = (unsigned long) compat_ptr(arg);
>                 /* fall through */
>         case LOOP_SET_FD:
> diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
> index 6b32fee80ce0..24a1c45bd1ae 100644
> --- a/include/uapi/linux/loop.h
> +++ b/include/uapi/linux/loop.h
> @@ -31,6 +31,10 @@ enum {
>  /* LO_FLAGS that can be cleared using LOOP_SET_STATUS(64) */
>  #define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR)
>
> +/* LO_FLAGS that can be set using LOOP_CONFIGURE */
> +#define LOOP_CONFIGURE_SETTABLE_FLAGS (LO_FLAGS_READ_ONLY | LO_FLAGS_AUTOCLEAR \
> +                                      | LO_FLAGS_PARTSCAN | LO_FLAGS_DIRECT_IO)
> +
>  #include <asm/posix_types.h>   /* for __kernel_old_dev_t */
>  #include <linux/types.h>       /* for __u64 */
>
> @@ -66,6 +70,22 @@ struct loop_info64 {
>         __u64              lo_init[2];
>  };
>
> +/**
> + * struct loop_config - Complete configuration for a loop device.
> + * @fd: fd of the file to be used as a backing file for the loop device.
> + * @block_size: block size to use; ignored if 0.
> + * @info: struct loop_info64 to configure the loop device with.
> + *
> + * This structure is used with the LOOP_CONFIGURE ioctl, and can be used to
> + * atomically setup and configure all loop device parameters at once.
> + */
> +struct loop_config {
> +       __u32                   fd;
> +       __u32                   block_size;
> +       struct loop_info64      info;
> +       __u64                   __reserved[8];
> +};
> +
>  /*
>   * Loop filter types
>   */
> @@ -96,6 +116,7 @@ struct loop_info64 {
>  #define LOOP_SET_CAPACITY      0x4C07
>  #define LOOP_SET_DIRECT_IO     0x4C08
>  #define LOOP_SET_BLOCK_SIZE    0x4C09
> +#define LOOP_CONFIGURE         0x4C0A
>
>  /* /dev/loop-control interface */
>  #define LOOP_CTL_ADD           0x4C80
> --
> 2.26.2.303.gf8c07b1a785-goog
>
