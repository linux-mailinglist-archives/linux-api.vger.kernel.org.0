Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0686039C9D6
	for <lists+linux-api@lfdr.de>; Sat,  5 Jun 2021 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFEQ2t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Jun 2021 12:28:49 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46798 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEQ2t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Jun 2021 12:28:49 -0400
Received: by mail-ej1-f67.google.com with SMTP id b9so19194971ejc.13;
        Sat, 05 Jun 2021 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PftSLZKR87WaT3//GeiQ8fZCHGuz2ewkTRNYI7wgal0=;
        b=uRy7CW77oAo5ZffE+Gt6hLZLVWWwQApKYKrdGXNg4axd9Qz0TKz2a8IUR2zxVydaBy
         qD5KxH/44ZU9KHn73LfQIBvqN6M0f4iH+ehsxJJbzC4Ww63gobAGJB0nryKI2dLD3gHy
         zD5KT2e1k8woRR43W2jYgBip8hE1T98oEFQuC++uCqfT5HB1b8A6fIv0q4S+AhEdJfhs
         7STV/IK+Q3zDzdwJSiQydmbMj4VC1diqRIFYtSjhk7wPE2Cv5ppyT9Qig5GX4olElrKG
         PnzW6aHuvdSySqPmNgKOAIwWCs85bi3E1uOpgC+m33Fp8r08UM14tNHE64ygcybyLhcP
         z9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PftSLZKR87WaT3//GeiQ8fZCHGuz2ewkTRNYI7wgal0=;
        b=pKpAg3hBDnTIs4FpV2RLv1KPAb8p/Vr4vN6j/00oX9kwo2pLc2PXuZSumTRimm3h94
         xTQvZOMFnTorLI/gAeLBaZQE5m8SPzv8T5Rs5lti+7q9zC62SxGIkiau7MOMjDgZXGd+
         zcK7zMJbJNG/vB6gLrx9bTUDU+hW4hD0iiVwm2uorEb7l9w2eZA+jD+dFa9IrDubLsHQ
         2gIS62xUjbHRTOJsaI1isCtz+Gp1Rg/nXSVTm4+BQleG+qc0HssQtv9yBw4iFULkjCrR
         wBy293A7m35CB2faaKMj4IbsCnJZr9+LhU1lKKG8+9GiFkuTo1A2bThZpUKAJsbW5v4L
         dISA==
X-Gm-Message-State: AOAM530waCNTmMFEB80ofdCMyh50rWSYI0bIUo3whVQAtRDcaFsQIB4Q
        IE8CPZckCmKj5QXInxOvU/c=
X-Google-Smtp-Source: ABdhPJzzbD+81wPAExrqbmkmituYVFhTf7MoH6n91v9gJ5J10ew6Ej1qH7RxJwjR4nS2Q2ZRcpoiLQ==
X-Received: by 2002:a17:906:b24a:: with SMTP id ce10mr9887364ejb.83.1622910346631;
        Sat, 05 Jun 2021 09:25:46 -0700 (PDT)
Received: from localhost.localdomain ([51.15.127.58])
        by smtp.gmail.com with ESMTPSA id r21sm5139434edy.78.2021.06.05.09.25.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 09:25:46 -0700 (PDT)
From:   yongw.pur@gmail.com
To:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, linux-api@vger.kernel.org
Cc:     wangyong <yongw.pur@gmail.com>
Subject: [RFC PATCH V2] zram:calculate available memory when zram is used
Date:   Sat,  5 Jun 2021 09:24:00 -0700
Message-Id: <1622910240-4621-1-git-send-email-yongw.pur@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: wangyong <yongw.pur@gmail.com>

When zram is used, available+Swap free memory is obviously
bigger than we actually can use, because zram can compress
memory by compression algorithm and zram compressed data
will occupy memory too.

So, we can count the compression ratio of zram in the kernel.
The space will be saved by zram and other swap device are
calculated as follows:
zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
We can evaluate the available memory of the whole system as:
MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfree]

Add an entry to the /proc/meminfo file, returns swap will save space.
Which name is more appropriate is still under consideration.
There are several alternative names: SwapAvailable, SwapSaved,
SwapCompressible

Signed-off-by: wangyong <yongw.pur@gmail.com>
---
 drivers/block/zram/zcomp.h    |  1 +
 drivers/block/zram/zram_drv.c | 19 +++++++++
 drivers/block/zram/zram_drv.h |  1 +
 fs/proc/meminfo.c             |  1 +
 include/linux/swap.h          | 10 +++++
 mm/swapfile.c                 | 95 +++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  1 +
 7 files changed, 128 insertions(+)

diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 40f6420..deb2dbf 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -40,4 +40,5 @@ int zcomp_decompress(struct zcomp_strm *zstrm,
 		const void *src, unsigned int src_len, void *dst);
 
 bool zcomp_set_max_streams(struct zcomp *comp, int num_strm);
+int get_zram_major(void);
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
index bb48893..798f09b 100644
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
@@ -689,6 +691,14 @@ static inline swp_entry_t get_swap_page(struct page *page)
 	return entry;
 }
 
+void update_zram_zstats(void)
+{
+}
+
+u64 count_avail_swaps(void)
+{
+}
+
 #endif /* CONFIG_SWAP */
 
 #ifdef CONFIG_THP_SWAP
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1e07d1c..fc934845 100644
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
+		}
+	} else
+		result += (si->pages << (PAGE_SHIFT - 10))
+				- (si->inuse_pages << (PAGE_SHIFT - 10));
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
+	struct zram *z;
+	struct zram_stats *stat;
+	int ratio;
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

