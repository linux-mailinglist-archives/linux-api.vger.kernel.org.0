Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62828095A
	for <lists+linux-api@lfdr.de>; Thu,  1 Oct 2020 23:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgJAVUC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Oct 2020 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgJAVUB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Oct 2020 17:20:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74283C0613D0;
        Thu,  1 Oct 2020 14:20:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so287743wrs.5;
        Thu, 01 Oct 2020 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92mK7zBHisCWLSyJKdx4TrhYPHWohdb3930tufPI2eQ=;
        b=Fb3HmbV7xJzzE55ouXOFztkTWp0bKdRdgzVsp6GqE2lJqMrMp7xLRTFVhBgLBnGqAR
         k/XIcp5tNhCvReHQeIl0YIihMYd72fmXqIC5rD4HGYrCXGW8imJTH816gR0KauZGdE/N
         G4HCILSEZgX3W/ODY9Gr+zfmQjzcedJOGlfCdi1Gead/7PyfPo02AYI+5TqQjmLelOUk
         cVeFILE2TCSZ+A3bL0Fq+Sh2MC3hOHMp+1yaIWd7RbKpu4OwbT2LBPcv4QcmP/p1xT0G
         nhNMajuz75wAV6iThjbsGTirHOzhC1plmyD29GVH2GT/bNCyk6kwt9VMGiMAfcvvxwQo
         e5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=92mK7zBHisCWLSyJKdx4TrhYPHWohdb3930tufPI2eQ=;
        b=Ab8IEqskowxuIdd+EdZWpv61hw5T3eUmqf1mKAqd7gmqZN5FFtqyogWyz9naNSe7X4
         iUqxzR8GVTLcEoeJ6w8i2PqTLW86ga3uaJBH/H0BD7r+Mmh3zSom0gvTqSzXwnpbPlmE
         VWtkqFssaTwX0BNi90BqvDit+oFl+AhJl1XQ4AnXqlWEvl3tr6CnIuZyXczHRqzDBwq/
         hKffQAqnsnUqGXr+RLyMM7OgicL/bVVhr/AQvnfzQyW+Th7+ADDcNlLjTrGPMK2d3ynd
         b0m4eIkBSpJTBZvB6sZVu5jGqOIXyzDdxZ65ev8kkpgrc7GUEl3K4lBPMguzTfA6UyFv
         oE5Q==
X-Gm-Message-State: AOAM5328JfpDxPb6T4G20r5hgmQ/4EnI9NmBq5Fp7496mRNABA5AnKM6
        F8DS0sZl1z9kTFYBGphROpiOTpIGIw9K4Q==
X-Google-Smtp-Source: ABdhPJx+5C2pl861hVRnpuxaeLSGcq52n+kjey8zmxUpkImCEOo8imG9vXHMS48cPyOtB3hf0HhJ3g==
X-Received: by 2002:adf:9124:: with SMTP id j33mr11044813wrj.272.1601587199869;
        Thu, 01 Oct 2020 14:19:59 -0700 (PDT)
Received: from dell5510.suse.de ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id l3sm1664763wmh.27.2020.10.01.14.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 14:19:59 -0700 (PDT)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>, Rich Felker <dalias@aerifal.cx>,
        musl@lists.openwall.com, Peter Korsgaard <peter@korsgaard.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: [RFC PATCH v2 1/1] uapi: Introduce <linux/align.h>
Date:   Thu,  1 Oct 2020 23:19:42 +0200
Message-Id: <20201001211942.13336-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

move there code from <linux/kernel.h>,
and include it in UAPI headers instead of <linux/kernel.h>.

The reason is to avoid indirect <linux/sysinfo.h> include when using
some network headers: <linux/netlink.h> or others -> <linux/kernel.h>
-> <linux/sysinfo.h>.

This indirect include causes on MUSL redefinition of struct sysinfo when
included both <sys/sysinfo.h> and some of UAPI headers:

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

Suggested-by: Rich Felker <dalias@aerifal.cx>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Changes v1->v2:
* Move kernel.h content into new header in order not break the existing
contract with glibc.

Background: long standing problem: python-psutil [1], iproute2 [2],
even for glibc in the past [3].

Kind regards,
Petr

[1] https://git.buildroot.net/buildroot/commit/?id=ab930190d7754b7f5fdda115b2069d00f1320861
[2] http://patchwork.ozlabs.org/project/netdev/patch/602128d22db86bd67e11dec8fe40a73832c222c9.1559230347.git.baruch@tkos.co.il/
[3] https://www.mail-archive.com/busybox@busybox.net/msg15363.html

 include/uapi/linux/align.h              | 10 ++++++++++
 include/uapi/linux/ethtool.h            |  2 +-
 include/uapi/linux/kernel.h             |  9 +--------
 include/uapi/linux/lightnvm.h           |  2 +-
 include/uapi/linux/mroute6.h            |  2 +-
 include/uapi/linux/netfilter/x_tables.h |  2 +-
 include/uapi/linux/netlink.h            |  2 +-
 include/uapi/linux/sysctl.h             |  2 +-
 8 files changed, 17 insertions(+), 14 deletions(-)
 create mode 100644 include/uapi/linux/align.h

diff --git a/include/uapi/linux/align.h b/include/uapi/linux/align.h
new file mode 100644
index 000000000000..6d2fef859d03
--- /dev/null
+++ b/include/uapi/linux/align.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_ALIGN_H
+#define _UAPI_LINUX_ALIGN_H
+
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+
+#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
+#endif /* _UAPI_LINUX_ALIGN_H */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b4f2d134e713..73ca97a6ec86 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -14,7 +14,7 @@
 #ifndef _UAPI_LINUX_ETHTOOL_H
 #define _UAPI_LINUX_ETHTOOL_H
 
-#include <linux/kernel.h>
+#include <linux/align.h>
 #include <linux/types.h>
 #include <linux/if_ether.h>
 
diff --git a/include/uapi/linux/kernel.h b/include/uapi/linux/kernel.h
index 0ff8f7477847..15f70c510311 100644
--- a/include/uapi/linux/kernel.h
+++ b/include/uapi/linux/kernel.h
@@ -3,13 +3,6 @@
 #define _UAPI_LINUX_KERNEL_H
 
 #include <linux/sysinfo.h>
-
-/*
- * 'kernel.h' contains some often-used function prototypes etc
- */
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
-#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
-
-#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+#include <linux/align.h>
 
 #endif /* _UAPI_LINUX_KERNEL_H */
diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
index f9a1be7fc696..d686cd576a24 100644
--- a/include/uapi/linux/lightnvm.h
+++ b/include/uapi/linux/lightnvm.h
@@ -21,7 +21,7 @@
 #define _UAPI_LINUX_LIGHTNVM_H
 
 #ifdef __KERNEL__
-#include <linux/kernel.h>
+#include <linux/align.h>
 #include <linux/ioctl.h>
 #else /* __KERNEL__ */
 #include <stdio.h>
diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
index c36177a86516..e638aaefbe7f 100644
--- a/include/uapi/linux/mroute6.h
+++ b/include/uapi/linux/mroute6.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI__LINUX_MROUTE6_H
 #define _UAPI__LINUX_MROUTE6_H
 
-#include <linux/kernel.h>
+#include <linux/align.h>
 #include <linux/types.h>
 #include <linux/sockios.h>
 #include <linux/in6.h>		/* For struct sockaddr_in6. */
diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux/netfilter/x_tables.h
index a8283f7dbc51..c49d7a630d05 100644
--- a/include/uapi/linux/netfilter/x_tables.h
+++ b/include/uapi/linux/netfilter/x_tables.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _UAPI_X_TABLES_H
 #define _UAPI_X_TABLES_H
-#include <linux/kernel.h>
+#include <linux/align.h>
 #include <linux/types.h>
 
 #define XT_FUNCTION_MAXNAMELEN 30
diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index eac8a6a648ea..2ff384e9bf00 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI__LINUX_NETLINK_H
 #define _UAPI__LINUX_NETLINK_H
 
-#include <linux/kernel.h>
+#include <linux/align.h>
 #include <linux/socket.h> /* for __kernel_sa_family_t */
 #include <linux/types.h>
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 27c1ed2822e6..18360ea6dd4e 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -23,7 +23,7 @@
 #ifndef _UAPI_LINUX_SYSCTL_H
 #define _UAPI_LINUX_SYSCTL_H
 
-#include <linux/kernel.h>
+#include <linux/align.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 
-- 
2.28.0

