Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8839F24A
	for <lists+linux-api@lfdr.de>; Tue,  8 Jun 2021 11:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFHJ35 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 8 Jun 2021 05:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHJ34 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 8 Jun 2021 05:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72D166124C;
        Tue,  8 Jun 2021 09:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623144484;
        bh=u/yn7qdyg2jplF/gHxRTO0ZByTH2g4Z41ES/bS2ZEpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vtlPXWHw03L/hDmiA5HUErLr5DckpuwpDtSY6cbWuMI9ey8p5BwoEf8QH0IFQ71FC
         +BG2oHucIybGH7+JBhwG/k4l3j3bhUNsuh4yWD3cOEy//fBTyCi3JStstMsH8TRA0n
         s2owd6UyymeLJCI3V1vEuD+gzCFu1R7uFRbjOTpo=
Date:   Tue, 8 Jun 2021 11:28:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yongw.pur@gmail.com
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, linux-api@vger.kernel.org,
        lu.zhongjun@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.wenya1@zte.com.cn, wang.yong12@zte.com.cn
Subject: Re: [RFC PATCH V3] zram:calculate available memory when zram is used
Message-ID: <YL84IUIQ0XAvv16D@kroah.com>
References: <1623080354-21453-1-git-send-email-yongw.pur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623080354-21453-1-git-send-email-yongw.pur@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 07, 2021 at 08:39:14AM -0700, yongw.pur@gmail.com wrote:
> From: wangyong <wang.yong12@zte.com.cn>
> 
> When zram is used, available+Swap free memory is obviously bigger than we
> actually can use, because zram can compress memory by compression
> algorithm and zram compressed data will occupy memory too.
> 
> So, we can count the compression ratio of zram in the kernel. The space
> will be saved by zram and other swap device are calculated as follows:
> zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
> We can evaluate the available memory of the whole system as:
> MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfree]
> 
> Add an entry to the /proc/meminfo file, returns swap will save space.
> Which name is more appropriate is still under consideration.
> There are several alternative names: SwapAvailable, SwapSaved,
> SwapCompressible, Which is better?
> 
> Adding new entries has little effect on user program, since parsers
> usually parse by keywords
> 
> Changes from v2:
> *Add interface description document
> *Other mistakes and problems fix
> 
> Changes from v1:
> *Use a new interface to return memory savings when using swap devices
> *Zram add min_compr_ratio attr

These "Changes" need to go below the --- line please.

> 
> Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> ---
>  Documentation/admin-guide/blockdev/zram.rst |  6 ++
>  Documentation/filesystems/proc.rst          |  4 ++
>  drivers/block/zram/zcomp.h                  |  8 +++
>  drivers/block/zram/zram_drv.c               | 19 ++++++
>  drivers/block/zram/zram_drv.h               |  1 +
>  fs/proc/meminfo.c                           |  1 +
>  include/linux/swap.h                        | 11 ++++
>  mm/swapfile.c                               | 95 +++++++++++++++++++++++++++++
>  mm/vmscan.c                                 |  1 +
>  9 files changed, 146 insertions(+)
> 
> diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> index 700329d..3b7c4c4 100644
> --- a/Documentation/admin-guide/blockdev/zram.rst
> +++ b/Documentation/admin-guide/blockdev/zram.rst
> @@ -283,6 +283,12 @@ a single line of text and contains the following stats separated by whitespace:
>  		Unit: 4K bytes
>   ============== =============================================================
>  
> +File /sys/block/zram<id>/min_compr_ratio
> +
> +The min_compr_ratio file represents the min_compr_ratio during zram swapping out.The calculation formula is as follows:
> +(orig_size * 100) / compr_data_size
> +
> +


sysfs files need to be documented in Documentation/ABI/ files.  You can
reference them in other documentation files, but they need to be in the
ABI/ directory as well.

Also please wrap your lines at the proper length and use a ' ' after a
'.'




>  9) Deactivate
>  =============
>  
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 042c418..15d35ae 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -961,6 +961,7 @@ You may not have all of these fields.
>      LowFree:          4432 kB
>      SwapTotal:           0 kB
>      SwapFree:            0 kB
> +    SwapAvailable:       0 kB
>      Dirty:             968 kB
>      Writeback:           0 kB
>      AnonPages:      861800 kB
> @@ -1032,6 +1033,9 @@ SwapTotal
>  SwapFree
>                Memory which has been evicted from RAM, and is temporarily
>                on the disk
> +SwapAvailable
> +              The memory savings when use swap devices. it takes zram
> +              compression ratio into considerations, when zram is used    

Trailing whitespace?

Did you run your patch through scripts/checkpatch.pl first before
sending it out?


>  Dirty
>                Memory which is waiting to get written back to the disk
>  Writeback
> diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
> index 40f6420..9c9cb96 100644
> --- a/drivers/block/zram/zcomp.h
> +++ b/drivers/block/zram/zcomp.h
> @@ -40,4 +40,12 @@ int zcomp_decompress(struct zcomp_strm *zstrm,
>  		const void *src, unsigned int src_len, void *dst);
>  
>  bool zcomp_set_max_streams(struct zcomp *comp, int num_strm);
> +#ifdef CONFIG_ZRAM
> +int get_zram_major(void);
> +#else
> +int get_zram_major(void)
> +{
> +	return -1;
> +}
> +#endif
>  #endif /* _ZCOMP_H_ */
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fcaf275..8f527e0 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -59,6 +59,10 @@ static void zram_free_page(struct zram *zram, size_t index);
>  static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
>  				u32 index, int offset, struct bio *bio);
>  
> +int get_zram_major(void)
> +{
> +	return zram_major;

Why does anyone need the zram major number?


> +}
>  
>  static int zram_slot_trylock(struct zram *zram, u32 index)
>  {
> @@ -1040,6 +1044,19 @@ static ssize_t compact_store(struct device *dev,
>  	return len;
>  }
>  
> +static ssize_t min_compr_ratio_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	ssize_t ret;
> +
> +	down_read(&zram->init_lock);
> +	ret = scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&zram->stats.min_compr_ratio));
> +	up_read(&zram->init_lock);

You are using an atomic variable _AND_ a read lock?  Are you sure that
makes sense?

And please use sysfs_emit() for sysfs files.


> +
> +	return ret;
> +}
> +
>  static ssize_t io_stat_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> @@ -1132,6 +1149,7 @@ static ssize_t debug_stat_show(struct device *dev,
>  	return ret;
>  }
>  
> +static DEVICE_ATTR_RO(min_compr_ratio);
>  static DEVICE_ATTR_RO(io_stat);
>  static DEVICE_ATTR_RO(mm_stat);
>  #ifdef CONFIG_ZRAM_WRITEBACK
> @@ -1859,6 +1877,7 @@ static struct attribute *zram_disk_attrs[] = {
>  	&dev_attr_idle.attr,
>  	&dev_attr_max_comp_streams.attr,
>  	&dev_attr_comp_algorithm.attr,
> +	&dev_attr_min_compr_ratio.attr,
>  #ifdef CONFIG_ZRAM_WRITEBACK
>  	&dev_attr_backing_dev.attr,
>  	&dev_attr_writeback.attr,
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 80c3b43..5717e06 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -88,6 +88,7 @@ struct zram_stats {
>  	atomic64_t bd_reads;		/* no. of reads from backing device */
>  	atomic64_t bd_writes;		/* no. of writes from backing device */
>  #endif
> +	atomic_t min_compr_ratio;
>  };
>  
>  struct zram {
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c..34a174b 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -86,6 +86,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  
>  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
>  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> +	show_val_kb(m, "SwapAvailable:	", count_avail_swaps());
>  	show_val_kb(m, "Dirty:          ",
>  		    global_node_page_state(NR_FILE_DIRTY));
>  	show_val_kb(m, "Writeback:      ",
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index bb48893..deed141 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -515,6 +515,8 @@ extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
>  extern void exit_swap_address_space(unsigned int type);
>  extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
>  sector_t swap_page_sector(struct page *page);
> +extern void update_zram_zstats(void);
> +extern u64 count_avail_swaps(void);
>  
>  static inline void put_swap_device(struct swap_info_struct *si)
>  {
> @@ -689,6 +691,15 @@ static inline swp_entry_t get_swap_page(struct page *page)
>  	return entry;
>  }
>  
> +void update_zram_zstats(void)
> +{
> +}
> +
> +u64 count_avail_swaps(void)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_SWAP */
>  
>  #ifdef CONFIG_THP_SWAP
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1e07d1c..5ce5100 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -44,6 +44,7 @@
>  #include <asm/tlbflush.h>
>  #include <linux/swapops.h>
>  #include <linux/swap_cgroup.h>
> +#include "../drivers/block/zram/zram_drv.h"

That's a big hint that this is not correct, please do not do this :(

The core kernel should not depend on a random block driver's code.

thanks,

greg k-h
