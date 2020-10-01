Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29273280813
	for <lists+linux-api@lfdr.de>; Thu,  1 Oct 2020 21:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgJATwu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Oct 2020 15:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgJATwu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Oct 2020 15:52:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D21C0613D0;
        Thu,  1 Oct 2020 12:52:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so61127wrx.7;
        Thu, 01 Oct 2020 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJc6n7J9BQbGIPDfHST0UIzxn6TBz7z+s2UfbvXIFRE=;
        b=KhS7zqcj3kiX9syu3bz6eYyGQApOMzgk0JNVm98yQNpQPH5nZN3Dm9LprI1byYmfjG
         mMWdGOIotmfgrtDn9PXXEv6wMkC8oJDTb62Z4GabZz5Mp62IESH+yUkPP52GOqh3hf0T
         EcAwqApndo8bSOBWIkIU/AAhr98JN3hh6yVcwD8ILmlwgYjFbz9qAFnq+CdMrNr5R4RX
         Am4B3MuAOKeQZh8n/lA2/nlktaYTefrO9vKz21eXTdw0+msOYOPjE0GniHkFAJFSNOgP
         NTQFGYy1hFXr1p7TkwizzJIl95omw0ZNKq18Lnwkr7SrX+3XdV7yLX2cb3m7o8BH9Vq1
         VgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PJc6n7J9BQbGIPDfHST0UIzxn6TBz7z+s2UfbvXIFRE=;
        b=b63Whj9qRLsKlXNYEXOkNb4CM66f5OtvIgPo0zowQY8VEeqH4U8LHF60w8YIvCKiOL
         FDWfI6BdrBQBoj2E85YUTWTFR6Hz5fwAb0e88DyfnKleMsUg2CvKuzLjDDH24DuvR1b8
         Zc3vGVyfKsHSurddH1INwjhDU1KWrs5tMT7UTaaEl+zGYM07qNCCYrDNyZIAM0fN7fAn
         IC7TMoskYew6cuiMQOTXyHDYoL9GkgejZmfvxv5dtto2bj8+8H/c+QwsqXRc+9PFW7oq
         Y/9RvqIbUJJMcaoJAQzt+2uu/823IPXGSH+pZJZFnSE9AYTXsizGLR2sD72yxDcAP8Ox
         gkPg==
X-Gm-Message-State: AOAM531ynUKmPJpBZa6J8v5fnRYjI2NhZqjzWH6WdHBBPKyQSKgn/J9Y
        tI4ljYbCYOKaQy2P94PUD/PZrylDG0QnHw==
X-Google-Smtp-Source: ABdhPJwrqilKtnbwHnlpFsAI1/LHcHpR2zkDVvpGWVT4AWBa0cBmXi7MfQjKytkpgKTcRoJVSkbCXA==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr10840302wrq.297.1601581968344;
        Thu, 01 Oct 2020 12:52:48 -0700 (PDT)
Received: from dell5510.suse.de ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id o129sm1500691wmb.25.2020.10.01.12.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:52:47 -0700 (PDT)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>, Rich Felker <dalias@aerifal.cx>,
        musl@lists.openwall.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, Peter Korsgaard <peter@korsgaard.com>,
        Florian Weimer <fweimer@redhat.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/1] uapi: Don't include <linux/sysinfo.h> in <linux/kernel.h>
Date:   Thu,  1 Oct 2020 21:52:31 +0200
Message-Id: <20201001195231.17226-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+ update code where needed (include <linux/sysinfo.h> in code which
included <linux/kernel.h> only to get struct sysinfo or SI_LOAD_SHIFT).

The reason is to avoid indirect <linux/sysinfo.h> include when using
some network headers: <linux/netlink.h> or others [1] ->
<linux/kernel.h> -> <linux/sysinfo.h>.

This indirect include causes redefinition of struct sysinfo when
included both <sys/sysinfo.h> and some of network headers:

In file included from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/kernel.h:5,
                 from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/netlink.h:5,
                 from ../include/tst_netlink.h:14,
                 from tst_crypto.c:13:
x86_64-buildroot-linux-musl/sysroot/usr/include/linux/sysinfo.h:8:8: error: redefinition of ‘struct sysinfo’
 struct sysinfo {
        ^~~~~~~
In file included from ../include/tst_safe_macros.h:15,
                 from ../include/tst_test.h:93,
                 from tst_crypto.c:11:
x86_64-buildroot-linux-musl/sysroot/usr/include/sys/sysinfo.h:10:8: note: originally defined here

[1] or <linux/sysctl.h>, <linux/ethtool.h>, <linux/mroute6.h>, <linux/ethtool.h>

Suggested-by: Rich Felker <dalias@aerifal.cx>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Hi,

this looks to be long standing problem: python-psutil [2], iproute2 [3],
even for glibc in the past [4] and it tried to be solved before [5].

This will require glibc fix after:

+++ sysdeps/unix/sysv/linux/sys/sysinfo.h
@@ -21,7 +21,7 @@
 #include <features.h>

 /* Get sysinfo structure from kernel header.  */
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>

 __BEGIN_DECLS


Kind regards,
Petr

[2] https://git.buildroot.net/buildroot/commit/?id=ab930190d7754b7f5fdda115b2069d00f1320861
[3] http://patchwork.ozlabs.org/project/netdev/patch/602128d22db86bd67e11dec8fe40a73832c222c9.1559230347.git.baruch@tkos.co.il/
[4] https://www.mail-archive.com/busybox@busybox.net/msg15363.html
[5] https://lore.kernel.org/patchwork/patch/449607/

 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 fs/eventpoll.c                      | 2 +-
 fs/proc/meminfo.c                   | 2 +-
 include/linux/mm.h                  | 1 +
 include/uapi/linux/kernel.h         | 2 --
 kernel/debug/kdb/kdb_main.c         | 2 +-
 kernel/sys.c                        | 2 +-
 mm/page_alloc.c                     | 2 +-
 net/ipv4/inetpeer.c                 | 2 +-
 net/rds/ib_recv.c                   | 2 +-
 10 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8062bd99add8..6c84c92e5112 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -43,7 +43,7 @@
  * USA.
  */
 
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/init.h>
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8107e06d7f6f..a4c2e199f9ea 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
 #include <linux/file.h>
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 887a5532e449..c80e42e1eaf9 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b2f370f0b420..4ac1af86db59 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -7,6 +7,7 @@
 #ifdef __KERNEL__
 
 #include <linux/mmdebug.h>
+#include <linux/sysinfo.h>
 #include <linux/gfp.h>
 #include <linux/bug.h>
 #include <linux/list.h>
diff --git a/include/uapi/linux/kernel.h b/include/uapi/linux/kernel.h
index 0ff8f7477847..e95f8cd801cd 100644
--- a/include/uapi/linux/kernel.h
+++ b/include/uapi/linux/kernel.h
@@ -2,8 +2,6 @@
 #ifndef _UAPI_LINUX_KERNEL_H
 #define _UAPI_LINUX_KERNEL_H
 
-#include <linux/sysinfo.h>
-
 /*
  * 'kernel.h' contains some often-used function prototypes etc
  */
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 5c7949061671..3193b9dd90e8 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -14,7 +14,7 @@
 #include <linux/ctype.h>
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>
 #include <linux/kmsg_dump.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
diff --git a/kernel/sys.c b/kernel/sys.c
index ab6c409b1159..9a3ee7ba84a7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -16,7 +16,7 @@
 #include <linux/kmod.h>
 #include <linux/perf_event.h>
 #include <linux/resource.h>
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>
 #include <linux/workqueue.h>
 #include <linux/capability.h>
 #include <linux/device.h>
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..42e14c5392a6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -24,7 +24,7 @@
 #include <linux/jiffies.h>
 #include <linux/memblock.h>
 #include <linux/compiler.h>
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>
 #include <linux/kasan.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index ff327a62c9ce..1c7385dab1c4 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -15,7 +15,7 @@
 #include <linux/random.h>
 #include <linux/timer.h>
 #include <linux/time.h>
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>
 #include <linux/mm.h>
 #include <linux/net.h>
 #include <linux/workqueue.h>
diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index 694d411dc72f..81425a2863e0 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -30,7 +30,7 @@
  * SOFTWARE.
  *
  */
-#include <linux/kernel.h>
+#include <linux/sysinfo.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
-- 
2.28.0

