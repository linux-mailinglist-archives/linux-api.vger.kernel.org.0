Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8539E0D8
	for <lists+linux-api@lfdr.de>; Mon,  7 Jun 2021 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhFGPmk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Jun 2021 11:42:40 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:35412 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhFGPmg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Jun 2021 11:42:36 -0400
Received: by mail-wr1-f49.google.com with SMTP id m18so18157496wrv.2;
        Mon, 07 Jun 2021 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=e+6c8kVwmLzKStz3B+1pPnge8yfvOLAEEUvChe29Yok=;
        b=aPo68zlTkT3CK/pz/I23UfoWafxdJ53RJ90y3E40+NghgvmiPc32lYBSVBG6FEbVEx
         MDn4eYqqX0pK5WAO6Ci0v6hW3uptrqwaBSSfL0QjDZQBINn2Ui9Dk7wk0IzY36QZOsvF
         7A28IdECmi6hZl0zRGu+72y177N138mXWkzgGB0f1yILBLJBV1giiTXp5KvaR2W0uQgv
         fBPsGSFpA2e30rJncjngi7xF5M4FagB5nuycPnRn7+7Y30OXlYvkuDYTBqLoQyy0/v/K
         gO1lbJ1WtZrWd8jUwiGhWhhZiqCgijnGlWJcKo+DTc2TI/2ZpFucwnmtyBt6Y+kxfH3E
         aCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=e+6c8kVwmLzKStz3B+1pPnge8yfvOLAEEUvChe29Yok=;
        b=k5H8OoHB8rz6btZxL8ouH15al6P01UAvjiIUp11jdSWaCOdDrGDfz8jJ8xJ5j959/A
         aLQ0uRwLgQzALhf/+fAq1iR6V6TfXf2fBztML95i3B5iwOb1SCb0lV2BmZvKDBAP1suw
         80O/3qVLZ2UiL27MLhGUKTMeox2jFSx4U9TypaadKX+yWGH6aU2VPpE2tKhnxjyR+iYW
         DDPhDMcPg3qJCEU9agyY7vZ4hXUC77DM6St4Gaz9YB8hc6oCQQ3iPwlBmzQkuEfFOj/r
         sVD2hiGi1Xd2Wvru2kEYyu+qarla4MEpadOfyzM6Ym1ccCDkj4nQ+kmk9P3OllMuoDa/
         nn1Q==
X-Gm-Message-State: AOAM531XuFXb0NDxFzhUJyd4+MIBVBBXD8KMGB6kZu+Yb5+OGAVUhxls
        Ciy4QiW0LEh1zmxMbmwsS6k=
X-Google-Smtp-Source: ABdhPJwD/5fxeR3NV9o06uaTryCgjvOcYh0BddQvw4di/5je5agdFdbofZcu12xTDZl7A8Dxs0t91Q==
X-Received: by 2002:adf:bc07:: with SMTP id s7mr17921681wrg.301.1623080372639;
        Mon, 07 Jun 2021 08:39:32 -0700 (PDT)
Received: from localhost.localdomain ([51.15.54.131])
        by smtp.gmail.com with ESMTPSA id t12sm21068281wre.9.2021.06.07.08.39.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 08:39:32 -0700 (PDT)
From:   yongw.pur@gmail.com
To:     gregkh@linuxfoundation.org, minchan@kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, axboe@kernel.dk,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        david@redhat.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, linux-api@vger.kernel.org,
        lu.zhongjun@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.wenya1@zte.com.cn, wang.yong12@zte.com.cn
Subject: [RFC PATCH V3] zram:calculate available memory when zram is used
Date:   Mon,  7 Jun 2021 08:39:14 -0700
Message-Id: <1623080354-21453-1-git-send-email-yongw.pur@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

When zram is used, available+Swap free memory is obviously bigger than we
actually can use, because zram can compress memory by compression
algorithm and zram compressed data will occupy memory too.

So, we can count the compression ratio of zram in the kernel. The space
will be saved by zram and other swap device are calculated as follows:
zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
We can evaluate the available memory of the whole system as:
MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfree]

Add an entry to the /proc/meminfo file, returns swap will save space.
Which name is more appropriate is still under consideration.
There are several alternative names: SwapAvailable, SwapSaved,
SwapCompressible, Which is better?

Adding new entries has little effect on user program, since parsers
usually parse by keywords

Changes from v2:
*Add interface description document
*Other mistakes and problems fix

Changes from v1:
*Use a new interface to return memory savings when using swap devices
*Zram add min_compr_ratio attr

Signed-off-by: wangyong <wang.yong12@zte.com.cn>
---
 Documentation/admin-guide/blockdev/zram.rst |  6 ++
 Documentation/filesystems/proc.rst          |  4 ++
 drivers/block/zram/zcomp.h                  |  8 +++
 drivers/block/zram/zram_drv.c               | 19 ++++++
 drivers/block/zram/zram_drv.h               |  1 +
 fs/proc/meminfo.c                           |  1 +
 include/linux/swap.h                        | 11 ++++
 mm/swapfile.c                               | 95 +++++++++++++++++++++++++++++
 mm/vmscan.c                                 |  1 +
 9 files changed, 146 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 700329d..3b7c4c4 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -283,6 +283,12 @@ a single line of text and contains the following stats separated by whitespace:
 		Unit: 4K bytes
  ============== =============================================================
 
+File /sys/block/zram<id>/min_compr_ratio
+
+The min_compr_ratio file represents the min_compr_ratio during zram swapping out.The calculation formula is as follows:
+(orig_size * 100) / compr_data_size
+
+
 9) Deactivate
 =============
 
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 042c418..15d35ae 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -961,6 +961,7 @@ You may not have all of these fields.
     LowFree:          4432 kB
     SwapTotal:           0 kB
     SwapFree:            0 kB
+    SwapAvailable:       0 kB
     Dirty:             968 kB
     Writeback:           0 kB
     AnonPages:      861800 kB
@@ -1032,6 +1033,9 @@ SwapTotal
 SwapFree
               Memory which has been evicted from RAM, and is temporarily
               on the disk
+SwapAvailable
+              The memory savings when use swap devices. it takes zram
+              compression ratio into considerations, when zram is used    
 Dirty
               Memory which is waiting to get written back to the disk
 Writeback
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 40f6420..9c9cb96 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -40,4 +40,12 @@ int zcomp_decompress(struct zcomp_strm *zstrm,
 		const void *src, unsigned int src_len, void *dst);
 
 bool zcomp_set_max_streams(struct zcomp *comp, int num_strm);
+#ifdef CONFIG_ZRAM
+int get_zram_major(void);
+#else
+int get_zram_major(void)
+{
+	return -1;
+}
+#endif
 #endif /* _ZCOMP_H_ */
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf275..8f527e0 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -59,6 +59,10 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
 				u32 index, int offset, struct bio *bio);
 
+int get_zram_major(void)
+{
+	return zram_major;
+}
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -1040,6 +1044,19 @@ static ssize_t compact_store(struct device *dev,
 	return len;
 }
 
+static ssize_t min_compr_ratio_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ssize_t ret;
+
+	down_read(&zram->init_lock);
+	ret = scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&zram->stats.min_compr_ratio));
+	up_read(&zram->init_lock);
+
+	return ret;
+}
+
 static ssize_t io_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1132,6 +1149,7 @@ static ssize_t debug_stat_show(struct device *dev,
 	return ret;
 }
 
+static DEVICE_ATTR_RO(min_compr_ratio);
 static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
 #ifdef CONFIG_ZRAM_WRITEBACK
@@ -1859,6 +1877,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_idle.attr,
 	&dev_attr_max_comp_streams.attr,
 	&dev_attr_comp_algorithm.attr,
+	&dev_attr_min_compr_ratio.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
 	&dev_attr_writeback.attr,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 80c3b43..5717e06 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -88,6 +88,7 @@ struct zram_stats {
 	atomic64_t bd_reads;		/* no. of reads from backing device */
 	atomic64_t bd_writes;		/* no. of writes from backing device */
 #endif
+	atomic_t min_compr_ratio;
 };
 
 struct zram {
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6fa761c..34a174b 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -86,6 +86,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	show_val_kb(m, "SwapTotal:      ", i.totalswap);
 	show_val_kb(m, "SwapFree:       ", i.freeswap);
+	show_val_kb(m, "SwapAvailable:	", count_avail_swaps());
 	show_val_kb(m, "Dirty:          ",
 		    global_node_page_state(NR_FILE_DIRTY));
 	show_val_kb(m, "Writeback:      ",
diff --git a/include/linux/swap.h b/include/linux/swap.h
index bb48893..deed141 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -515,6 +515,8 @@ extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
 extern void exit_swap_address_space(unsigned int type);
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_page_sector(struct page *page);
+extern void update_zram_zstats(void);
+extern u64 count_avail_swaps(void);
 
 static inline void put_swap_device(struct swap_info_struct *si)
 {
@@ -689,6 +691,15 @@ static inline swp_entry_t get_swap_page(struct page *page)
 	return entry;
 }
 
+void update_zram_zstats(void)
+{
+}
+
+u64 count_avail_swaps(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SWAP */
 
 #ifdef CONFIG_THP_SWAP
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1e07d1c..5ce5100 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -44,6 +44,7 @@
 #include <asm/tlbflush.h>
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
+#include "../drivers/block/zram/zram_drv.h"
 
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
@@ -3387,6 +3388,100 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	return error;
 }
 
+u64 count_avail_swap(struct swap_info_struct *si)
+{
+	u64 result;
+	struct zram *z;
+	unsigned int free;
+	unsigned int ratio;
+
+	result = 0;
+	if (!si)
+		return 0;
+
+	//zram calculate available mem
+	if (si->flags & SWP_USED && si->swap_map) {
+		if (si->bdev->bd_disk->major == get_zram_major()) {
+			z = (struct zram *)si->bdev->bd_disk->private_data;
+			down_read(&z->init_lock);
+			ratio = atomic_read(&z->stats.min_compr_ratio);
+			free = (si->pages << (PAGE_SHIFT - 10))
+				- (si->inuse_pages << (PAGE_SHIFT - 10));
+			if (!ratio)
+				result += free / 2;
+			else
+				result = free * (100 - 10000 / ratio) / 100;
+			up_read(&z->init_lock);
+		} else
+			result += (si->pages << (PAGE_SHIFT - 10))
+					- (si->inuse_pages << (PAGE_SHIFT - 10));
+	}
+
+	return result;
+}
+
+u64 count_avail_swaps(void)
+{
+	int type;
+	u64 result;
+	struct swap_info_struct *si;
+
+	result = 0;
+	spin_lock(&swap_lock);
+	for (type = 0; type < nr_swapfiles; type++) {
+		si = swap_info[type];
+		spin_lock(&si->lock);
+		result += count_avail_swap(si);
+		spin_unlock(&si->lock);
+	}
+	spin_unlock(&swap_lock);
+
+	return result;
+}
+
+void update_zram_zstat(struct swap_info_struct *si)
+{
+	int ratio;
+	struct zram *z;
+	struct zram_stats *stat;
+	u64 orig_size, compr_data_size;
+
+	if (!si)
+		return;
+
+	//update zram min compress ratio
+	if (si->flags & SWP_USED && si->swap_map) {
+		if (si->bdev->bd_disk->major == get_zram_major()) {
+			z = (struct zram *)si->bdev->bd_disk->private_data;
+			down_read(&z->init_lock);
+			stat = &z->stats;
+			ratio = atomic_read(&stat->min_compr_ratio);
+			orig_size = atomic64_read(&stat->pages_stored) << PAGE_SHIFT;
+			compr_data_size = atomic64_read(&stat->compr_data_size);
+			if (compr_data_size && (!ratio
+					    || ((orig_size * 100) / compr_data_size < ratio)))
+				atomic_set(&stat->min_compr_ratio,
+					   (orig_size * 100) / compr_data_size);
+			up_read(&z->init_lock);
+		}
+	}
+}
+
+void update_zram_zstats(void)
+{
+	int type;
+	struct swap_info_struct *si;
+
+	spin_lock(&swap_lock);
+	for (type = 0; type < nr_swapfiles; type++) {
+		si = swap_info[type];
+		spin_lock(&si->lock);
+		update_zram_zstat(si);
+		spin_unlock(&si->lock);
+	}
+	spin_unlock(&swap_lock);
+}
+
 void si_swapinfo(struct sysinfo *val)
 {
 	unsigned int type;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb31452..ffaf59b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4159,6 +4159,7 @@ static int kswapd(void *p)
 						alloc_order);
 		reclaim_order = balance_pgdat(pgdat, alloc_order,
 						highest_zoneidx);
+		update_zram_zstats();
 		if (reclaim_order < alloc_order)
 			goto kswapd_try_sleep;
 	}
-- 
2.7.4

