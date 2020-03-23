Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8925718F093
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2020 09:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgCWIFO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 04:05:14 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34878 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgCWIFO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Mar 2020 04:05:14 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200323080511epoutp0417be27baddb47688644854d9c7d61aa2~_4EZu04Ib1426914269epoutp04r
        for <linux-api@vger.kernel.org>; Mon, 23 Mar 2020 08:05:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200323080511epoutp0417be27baddb47688644854d9c7d61aa2~_4EZu04Ib1426914269epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584950712;
        bh=TRbGcx9ZV+IqrIG8JwLR8QmselJK4B5I11L2jHQXF2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkPTNkKW34Nr83/BA5jeRhsaATENKf7iFNm1BaH+7DxMD2SCaGXKPIHvhiQJpQO+H
         o/OZNqqvR7HMGcGYOuu3OyOWBpZpUGaP1MKAhWR52iEnogSbxSXHPN47Urcj5OGYd+
         1xCKW0y37hWvKjCQci8RgDufF48soNuViO4xMVys=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200323080511epcas1p2d7cdcc4edcce296e22135a322e7c704b~_4EZI67xg2102421024epcas1p2l;
        Mon, 23 Mar 2020 08:05:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48m6PL2KbPzMqYkd; Mon, 23 Mar
        2020 08:05:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.2A.04074.4BD687E5; Mon, 23 Mar 2020 17:05:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477~_4EWBfKY43019030190epcas1p3C;
        Mon, 23 Mar 2020 08:05:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200323080507epsmtrp18e52c71f3a54794974a1c99e59279abe~_4EWAYGbR0063700637epsmtrp1e;
        Mon, 23 Mar 2020 08:05:07 +0000 (GMT)
X-AuditID: b6c32a39-58bff70000000fea-59-5e786db4b413
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.15.04158.3BD687E5; Mon, 23 Mar 2020 17:05:07 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200323080507epsmtip15ad9b6907ccc4b094399b05cc333e9db~_4EVz4Cu80126401264epsmtip1M;
        Mon, 23 Mar 2020 08:05:07 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     gregkh@linuxfoundation.org, leon@kernel.org, vbabka@suse.cz,
        adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RFC PATCH v2 1/3] meminfo_extra: introduce meminfo extra
Date:   Mon, 23 Mar 2020 17:05:01 +0900
Message-Id: <20200323080503.6224-2-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200323080503.6224-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHd9/re6+Y1rxU507QIL5EJi5ASy1eN7roZpY3xjIWEk32B+wF
        bihZf7z0FaUkGyCEKAhUonEiGATFDXGQtnEgCEuBsc3FLhB/xhK3bCZzExIM4srUtX0a99/3
        nPP55px77r1a2jDBJmvLnR7idkp2gV2luTiRnpERdFQWGX2P0/Dx2jzcMdDP4vDdKIvregZY
        3BQ4gXDzwn0Kn5u/gvDIlSUKfz36mMJHo2dpHFg+yOLZSx0snut/xuDepQUOD9a3c/g3XxuF
        f4o85PDJ2ha00yAOt0c40d93iBX9i22ceOf6KCv+8OWKRhzv7OfEwJlqcWHsGiu2BPuQ+HPX
        JCcOLwYY8aE/pUD3iT3XRqRS4k4lzhJXabmzzCp8UFj8brElx2jKMO3A24VUp+QgVmF3fkHG
        e+X22PGE1H2SvSKWKpAURch6O9ftqvCQVJtL8VgFIpfaZZNRzlQkh1LhLMsscTneNBmN2ZYY
        +and9uBUA5LbtlROjebVoJ5NjShJC/w2aDn0O9uIVmkN/BCCu7VTlBosIhj86lukBo8QnJs5
        wr6wHPc/ouPawF9GEJrVqNAygtsBHxcvsPwbsNDVxsQLa/lWCroj3QmK5i8g6GuMUHFqDf8O
        HJ3uSWgNvxlunfehuNbzuTAyORczaGPtNsLpZ4luSbwVxmZuJ4YFvpeDiSc+Wh1pNxxonqZU
        vQbuTwc5VSfDn60NnGqoQ/DgRACpQT2CiL8ZqZQZmg//Qse70Xw6DFzKUtObYHilM4HQ/GqY
        XzrMqAPp4WCDQUXSoP7eEqPqDfDk6b3niAjhp2nqVnwIVmbnOR9KaX/ZoAuhPrSOyIqjjCgm
        2fL/K/OjxAPeumMIfX81P4R4LRJ0+pqm/UUGRtqneB0hBFpaWKsPkMoig75U8lYRt6vYXWEn
        SghZYps8Qie/WuKKfQenp9hkyTabzXhbzvYci1l4TX/shr3IwJdJHvIZITJxv/BR2qTkGjTl
        XRmp2x+2tO/6lQluGY/ezPqusHPPeKPjj4+Oee9UzWd/PNAQXW898NepLy6mb2Y+t/1Ipxv9
        ryxfXj24YedbHZNM0573T+49f+bflLzqdeAdzNQFpTAUZsmhIX3361UzH16IhpfH5lqb1peQ
        7NGUq3v1/5y9Jef/rZvurdZ90wqCRrFJpq20W5H+A+pzAAXWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnO7m3Io4g9e9FhbTG70s5qxfw2Zx
        /sEvNovmxevZLLo3z2S06H3/isli+bvTjBa7T39lsli55weTxZRfS5ktNn/vYLO4vGsOm8W9
        Nf9ZLZZ9fc9usaFlFrvFowmTmCxO3f3MbjG7sY/RQchj56y77B6bVnWyeWz6NInd4861PWwe
        J2b8ZvHYP3cNu8fmJfUe7/ddZfPo27KK0ePMgiPsHjs/bWb1+LxJLoAnissmJTUnsyy1SN8u
        gSvj7bw2xoJJGhVH93g1MC5W7GLk5JAQMJGYvukbcxcjF4eQwG5GibOLvzNDJGQk3px/ytLF
        yAFkC0scPlwMUfOVUWLnywVgNWwC2hLvF0xiBbFFBOYzSfS384MUMQtsZpSYuLSZBSQhLOAk
        MeX4YiYQm0VAVeLm6gmMIDavgI3E7iP3oBbISyz8DzaTU8BWYt+lW2wgthBQydbuZ8wTGPkW
        MDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjhEtrR2MJ07EH2IU4GBU4uG90Vse
        J8SaWFZcmXuIUYKDWUmEd3NqRZwQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZ
        qakFqUUwWSYOTqkGRqZv3/ZucD51/AabsuIKsz+K8/o4tPaoi8y689E7Tf7hdMnd6qJJby6v
        lZf75Vjv+fJq974tJjUpTsbT3yzO2he+jl84IXTRrFXzPvxwjbjEeCVsgbfw2/0TFd8XuJw2
        ncjENH2VdF3fR/ELdivEdu7Z8CMsnkHjSPTPIq0XMxbob3nk2/KIS1qJpTgj0VCLuag4EQC6
        tjChjQIAAA==
X-CMS-MailID: 20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
        <CGME20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477@epcas1p3.samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Provide APIs to drivers so that they can show its memory usage on
/proc/meminfo_extra.

int register_meminfo_extra(atomic_long_t *val, int shift,
			   const char *name);
int unregister_meminfo_extra(atomic_long_t *val);

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
v2: move to /proc/meminfo_extra as a new file, meminfo_extra.c
    use rcu to reduce lock overhead
v1: print info at /proc/meminfo
---
 fs/proc/Makefile        |   1 +
 fs/proc/meminfo_extra.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h      |   4 ++
 mm/page_alloc.c         |   1 +
 4 files changed, 129 insertions(+)
 create mode 100644 fs/proc/meminfo_extra.c

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..83d2f55591c6 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -19,6 +19,7 @@ proc-y	+= devices.o
 proc-y	+= interrupts.o
 proc-y	+= loadavg.o
 proc-y	+= meminfo.o
+proc-y	+= meminfo_extra.o
 proc-y	+= stat.o
 proc-y	+= uptime.o
 proc-y	+= util.o
diff --git a/fs/proc/meminfo_extra.c b/fs/proc/meminfo_extra.c
new file mode 100644
index 000000000000..bd3f0d2b7fb7
--- /dev/null
+++ b/fs/proc/meminfo_extra.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+
+static void show_val_kb(struct seq_file *m, const char *s, unsigned long num)
+{
+	seq_put_decimal_ull_width(m, s, num << (PAGE_SHIFT - 10), 8);
+	seq_write(m, " kB\n", 4);
+}
+
+static LIST_HEAD(meminfo_head);
+static DEFINE_SPINLOCK(meminfo_lock);
+
+#define NAME_SIZE      15
+#define NAME_BUF_SIZE  (NAME_SIZE + 2) /* ':' and '\0' */
+
+struct meminfo_extra {
+	struct list_head list;
+	atomic_long_t *val;
+	int shift_for_page;
+	char name[NAME_BUF_SIZE];
+	char name_pad[NAME_BUF_SIZE];
+};
+
+int register_meminfo_extra(atomic_long_t *val, int shift, const char *name)
+{
+	struct meminfo_extra *meminfo, *memtemp;
+	int len;
+	int error = 0;
+
+	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
+	if (!meminfo) {
+		error = -ENOMEM;
+		goto out;
+	}
+
+	meminfo->val = val;
+	meminfo->shift_for_page = shift;
+	strncpy(meminfo->name, name, NAME_SIZE);
+	len = strlen(meminfo->name);
+	meminfo->name[len] = ':';
+	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
+	while (++len < NAME_BUF_SIZE - 1)
+		meminfo->name_pad[len] = ' ';
+
+	spin_lock(&meminfo_lock);
+	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
+		if (memtemp->val == val) {
+			error = -EINVAL;
+			break;
+		}
+	}
+	if (!error)
+		list_add_tail_rcu(&meminfo->list, &meminfo_head);
+	spin_unlock(&meminfo_lock);
+	if (error)
+		kfree(meminfo);
+out:
+
+	return error;
+}
+EXPORT_SYMBOL(register_meminfo_extra);
+
+int unregister_meminfo_extra(atomic_long_t *val)
+{
+	struct meminfo_extra *memtemp;
+	int error = -EINVAL;
+
+	spin_lock(&meminfo_lock);
+	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
+		if (memtemp->val == val) {
+			list_del_rcu(&memtemp->list);
+			error = 0;
+			break;
+		}
+	}
+	spin_unlock(&meminfo_lock);
+	if (!error) {
+		synchronize_rcu();
+		kfree(memtemp);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(unregister_meminfo_extra);
+
+static void __meminfo_extra(struct seq_file *m)
+{
+	struct meminfo_extra *memtemp;
+	unsigned long nr_page;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
+		nr_page = (unsigned long)atomic_long_read(memtemp->val);
+		nr_page = nr_page >> memtemp->shift_for_page;
+		if (m)
+			show_val_kb(m, memtemp->name_pad, nr_page);
+		else
+			pr_cont("%s%lukB ", memtemp->name, nr_page);
+	}
+	rcu_read_unlock();
+}
+
+void show_meminfo_extra(void)
+{
+	__meminfo_extra(NULL);
+}
+
+static int meminfo_extra_proc_show(struct seq_file *m, void *v)
+{
+	__meminfo_extra(m);
+
+	return 0;
+}
+
+static int __init proc_meminfo_extra_init(void)
+{
+	proc_create_single("meminfo_extra", 0, NULL, meminfo_extra_proc_show);
+	return 0;
+}
+fs_initcall(proc_meminfo_extra_init);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..55317161ab57 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2898,6 +2898,10 @@ void __init setup_nr_node_ids(void);
 static inline void setup_nr_node_ids(void) {}
 #endif
 
+void show_meminfo_extra(void);
+int register_meminfo_extra(atomic_long_t *val, int shift, const char *name);
+int unregister_meminfo_extra(atomic_long_t *val);
+
 extern int memcmp_pages(struct page *page1, struct page *page2);
 
 static inline int pages_identical(struct page *page1, struct page *page2)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..db1be9a39783 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5229,6 +5229,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 	struct zone *zone;
 	pg_data_t *pgdat;
 
+	show_meminfo_extra();
 	for_each_populated_zone(zone) {
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
-- 
2.13.7

