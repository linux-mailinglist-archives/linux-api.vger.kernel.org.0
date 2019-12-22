Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E891F128D18
	for <lists+linux-api@lfdr.de>; Sun, 22 Dec 2019 07:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfLVGKY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 22 Dec 2019 01:10:24 -0500
Received: from mail.wilcox-tech.com ([45.32.83.9]:41174 "EHLO
        mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfLVGKY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 22 Dec 2019 01:10:24 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2019 01:10:24 EST
Received: (qmail 5598 invoked from network); 22 Dec 2019 06:03:40 -0000
Received: from localhost (HELO gwyn.foxkit.us) (awilcox@wilcox-tech.com@127.0.0.1)
  by localhost with ESMTPA; 22 Dec 2019 06:03:40 -0000
From:   "A. Wilcox" <AWilcox@Wilcox-Tech.com>
To:     netdev@vger.kernel.org, linux-api@vger.kernel.org,
        musl@lists.openwall.com
Cc:     "A. Wilcox" <AWilcox@Wilcox-Tech.com>
Subject: [PATCH] uapi: Prevent redefinition of struct iphdr
Date:   Sun, 22 Dec 2019 00:02:27 -0600
Message-Id: <20191222060227.7089-1-AWilcox@Wilcox-Tech.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As with struct ethhdr, the musl libc provides its own definition of the
iphdr struct.  This guard ensures software like net-tools builds correctly
on the musl libc.

The __UAPI_DEF_IPHDR definition is in ip.h itself to prevent the issue in
commit da360299b673 ("uapi/if_ether.h: move __UAPI_DEF_ETHHDR libc define")
from being seen here.

Signed-off-by: A. Wilcox <AWilcox@Wilcox-Tech.com>
---
 include/uapi/linux/ip.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/ip.h b/include/uapi/linux/ip.h
index e42d13b55cf3..d34a0d295672 100644
--- a/include/uapi/linux/ip.h
+++ b/include/uapi/linux/ip.h
@@ -83,6 +83,13 @@
 
 #define IPV4_BEET_PHMAXLEN 8
 
+/* Allow libcs to deactivate this - musl has its own copy in <netinet/ip.h> */
+
+#ifndef __UAPI_DEF_IPHDR
+#define __UAPI_DEF_IPHDR	1
+#endif
+
+#if __UAPI_DEF_IPHDR
 struct iphdr {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 	__u8	ihl:4,
@@ -104,6 +111,7 @@ struct iphdr {
 	__be32	daddr;
 	/*The options start here. */
 };
+#endif
 
 
 struct ip_auth_hdr {
-- 
2.22.1

