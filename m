Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A0728F907
	for <lists+linux-api@lfdr.de>; Thu, 15 Oct 2020 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391293AbgJOTAY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Oct 2020 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391292AbgJOTAX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Oct 2020 15:00:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF87C061755;
        Thu, 15 Oct 2020 12:00:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g12so4910497wrp.10;
        Thu, 15 Oct 2020 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LtnFpFZ6Eux9pZL1tvnlYFv1q6tc9+T02TAa4IMAPEs=;
        b=MDVAXh5LbJMffglNpS5omNCG8K4I1h2dvPDEEB17Kpi3RMF/07K019/kC99g2XepjS
         xPikUHiTQ3NtAwmmJd2DF7JQYpAgsVTCjYy2VOe2yZMBV5AF3TOOS8XUqizE/oq7BR/V
         03h1ijB8Bp6LLYbzvZIfoeY11WsPEfkwwKP8VexOV1lltRQI9QE+7NEB8Nnr7j0mYKEI
         vl7H8OrzhRX4va2cDgYvZqrvawG80knndqet4fY4LPH68BrCrOz8lFHJtPvt7tveTpD5
         pXXB8goZWxkuVlFVmsBMf8jTnbuNVdxueGe1v1lRki2DEu5vDA+fcWNTfGRnoDYQcVqn
         GCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LtnFpFZ6Eux9pZL1tvnlYFv1q6tc9+T02TAa4IMAPEs=;
        b=PbooII6D+XTVQuezOY8l6vbUNRRvMDkLiQMU2ywKy+JwPmqSfPhw3yVOxnYHfpWCNI
         ug44pEC4Vh3v+zT16dbZ8i+98f/K+edQi4aa32d1lso6QrfqUfVPPja1ip9SS+xh4Vku
         twCmoS+OjmI9A/GO4JtDJ5CDyq4DwfPgYedc3k/I+Uh3PSh/Lldy0WnZ6/IYM4Z4Nrvg
         TL6U21h1JtVJ9D4YVfBqASTqkAhDIuAKifhRFmMyetpunaadeNXvsMRk9/re2EqCGYIP
         ZbcWtSePTvfoIQN/gRAX1vIHAPXWuWeyZ3qhYCTWU/AOhqMw0XaJyL03ypUOhS/5htj9
         GREw==
X-Gm-Message-State: AOAM5334YCYc8+0K7fDQN2/zbIjcG1R/x2eP7lokuOzGum8uPjWmAmQO
        wIpGdpIZ2BI6P9PB5+Vjc32jo1mjkK01gQ==
X-Google-Smtp-Source: ABdhPJy2G92cXrzENPYaER413jANkBxArMBX2o6QwdRQyx6MdgMmLN8jW5peq4v6G8MxoKr4qUSlow==
X-Received: by 2002:a5d:6110:: with SMTP id v16mr6312237wrt.219.1602788420527;
        Thu, 15 Oct 2020 12:00:20 -0700 (PDT)
Received: from dell5510.suse.de ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id r3sm261146wrm.51.2020.10.15.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 12:00:19 -0700 (PDT)
From:   Petr Vorel <petr.vorel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>, Rich Felker <dalias@aerifal.cx>,
        musl@lists.openwall.com, Peter Korsgaard <peter@korsgaard.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: [PATCH v3 1/1] uapi: Move constants from <linux/kernel.h> to <linux/const.h>
Date:   Thu, 15 Oct 2020 21:00:13 +0200
Message-Id: <20201015190013.8901-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

and include <linux/const.h> in UAPI headers instead of <linux/kernel.h>.

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
Changes v2->v3:
* Move things to <linux/const.h> instead of creating new header
<linux/align.h>.

Kind regards,
Petr

 include/uapi/linux/const.h              | 5 +++++
 include/uapi/linux/ethtool.h            | 2 +-
 include/uapi/linux/kernel.h             | 9 +--------
 include/uapi/linux/lightnvm.h           | 2 +-
 include/uapi/linux/mroute6.h            | 2 +-
 include/uapi/linux/netfilter/x_tables.h | 2 +-
 include/uapi/linux/netlink.h            | 2 +-
 include/uapi/linux/sysctl.h             | 2 +-
 8 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index 5ed721ad5b19..af2a44c08683 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,4 +28,9 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
+
+#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
 #endif /* _UAPI_LINUX_CONST_H */
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b4f2d134e713..0a9cced74e6d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -14,7 +14,7 @@
 #ifndef _UAPI_LINUX_ETHTOOL_H
 #define _UAPI_LINUX_ETHTOOL_H
 
-#include <linux/kernel.h>
+#include <linux/const.h>
 #include <linux/types.h>
 #include <linux/if_ether.h>
 
diff --git a/include/uapi/linux/kernel.h b/include/uapi/linux/kernel.h
index 0ff8f7477847..fadf2db71fe8 100644
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
+#include <linux/const.h>
 
 #endif /* _UAPI_LINUX_KERNEL_H */
diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
index f9a1be7fc696..ead2e72e5c88 100644
--- a/include/uapi/linux/lightnvm.h
+++ b/include/uapi/linux/lightnvm.h
@@ -21,7 +21,7 @@
 #define _UAPI_LINUX_LIGHTNVM_H
 
 #ifdef __KERNEL__
-#include <linux/kernel.h>
+#include <linux/const.h>
 #include <linux/ioctl.h>
 #else /* __KERNEL__ */
 #include <stdio.h>
diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
index c36177a86516..a1fd6173e2db 100644
--- a/include/uapi/linux/mroute6.h
+++ b/include/uapi/linux/mroute6.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI__LINUX_MROUTE6_H
 #define _UAPI__LINUX_MROUTE6_H
 
-#include <linux/kernel.h>
+#include <linux/const.h>
 #include <linux/types.h>
 #include <linux/sockios.h>
 #include <linux/in6.h>		/* For struct sockaddr_in6. */
diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux/netfilter/x_tables.h
index a8283f7dbc51..b8c6bb233ac1 100644
--- a/include/uapi/linux/netfilter/x_tables.h
+++ b/include/uapi/linux/netfilter/x_tables.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #ifndef _UAPI_X_TABLES_H
 #define _UAPI_X_TABLES_H
-#include <linux/kernel.h>
+#include <linux/const.h>
 #include <linux/types.h>
 
 #define XT_FUNCTION_MAXNAMELEN 30
diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index eac8a6a648ea..7ba6d3b9cdec 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI__LINUX_NETLINK_H
 #define _UAPI__LINUX_NETLINK_H
 
-#include <linux/kernel.h>
+#include <linux/const.h>
 #include <linux/socket.h> /* for __kernel_sa_family_t */
 #include <linux/types.h>
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 27c1ed2822e6..458179df9b27 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -23,7 +23,7 @@
 #ifndef _UAPI_LINUX_SYSCTL_H
 #define _UAPI_LINUX_SYSCTL_H
 
-#include <linux/kernel.h>
+#include <linux/const.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 
-- 
2.28.0

