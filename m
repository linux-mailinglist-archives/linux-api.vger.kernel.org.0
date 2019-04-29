Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F855E398
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfD2NUF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 09:20:05 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2NUF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 09:20:05 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJEAV-1h5Lf60mV9-00KgpJ; Mon, 29 Apr 2019 15:19:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joseph Myers <joseph@codesourcery.com>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Lukasz Majewski <lukma@denx.de>,
        Stepan Golosunov <stepan@golosunov.pp.ru>
Subject: [PATCH 1/2] y2038: make CONFIG_64BIT_TIME unconditional
Date:   Mon, 29 Apr 2019 15:19:37 +0200
Message-Id: <20190429131951.471701-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nBLpCCNCMR99+fCmBXHOH58gVJdN2wfMwd8ZK1AgDntxkLTNmLD
 WN0VU/yhDIZeW8y2iiRYPk8AWxzzNGHqB5BBQYH5gP/5YWSEBi6Bgdb4/ViAc+5I8dWtwGJ
 QV/FYqC35NYTIrysuCP5DCyIvBIZWThb3BbOCsAAOfux8JuuiGyzkaeQPytbHDv4b5syXbH
 FFUzrEaqWIQL92wHXq2rA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oxuC7Va9fRA=:S3nRGt+A7184wfoMyT3NBQ
 BhsDGcjTPGdIswSIE7hqeAYfaTHFnYGS/KtgU9HX8DaNJPByzzObxXtmrd4lhOUQVuyNv6jRS
 eSkgBZpe2IAzi8rsu6B8W8WNs8EPiwgGq3i4MqL6TT6Dnn5g2sHH1gse2W5HosSu6CWbTIBzc
 jOQ4txfCcDwawnB+Sq9CVf0wY6r+4w3oU66FJvlkDQQCJvZTyUm0RuUwAGstElf72EmPdX0Qx
 S9sAMLIST6Y41fwJAICbmSMxoBGC0HofXSCdXzuEAeC+gAXR+ZcwwM9DS6Z9Aw841jqwTLfWP
 z26by8DM+JY8lIjgCDwPq6QZIdsvlTac9JKyodsfvTTD+d1Ogu/1SZefLTMon+rFL+nDYIfGJ
 J1G46BThvKgLbnkBXAIqojzs5uSc3kxUIo+xeSHrZbnfVttLsNccvo5M8kn+1dos3oTMEZ5yS
 T84mjBqJlaqG2oahAMb15Y34lhyZzQ8tLhcomn4RdwubM0pGAzliEAJhLVZ2IkLZuk/Crnqwf
 ZiHCy1UVM0EjFD8SkxunGtLJh1ZxneWufGcrmk+z9XghD2OydZYCQtXhLtNdVRf6gjQinGYMZ
 S147O8YhHLAgWCDnFNn0IujNGrSfEeytQv2M/3sr9YRVxYp1JABX849UVQjpL39/CQSW7AV0E
 7ClFiqwr5e412aK7KHBwvWNse0eeuG4JIYIqpc9pVl6qy1NKyEf9+lBbs7r2U3cBZM4pYt9n4
 1EcgO0sLBEYu2Ye/WLCPVQw+8ZGaRA6YEwBhtA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As Stepan Golosunov points out, we made a small mistake in the
get_timespec64() function in the kernel. It was originally added under
the assumption that CONFIG_64BIT_TIME would get enabled on all 32-bit
and 64-bit architectures, but when I did the conversion, I only turned
it on for 32-bit ones.

The effect is that the get_timespec64() function never clears the upper
half of the tv_nsec field for 32-bit tasks in compat mode. Clearing this
is required for POSIX compliant behavior of functions that pass a
'timespec' structure with a 64-bit tv_sec and a 32-bit tv_nsec, plus
uninitialized padding.

The easiest fix for linux-5.1 is to just make the Kconfig symbol
unconditional, as it was originally intended. As a follow-up,
we should remove any #ifdef CONFIG_64BIT_TIME completely.

Note: for native 32-bit mode, no change is needed, this works as
designed and user space should never need to clear the upper 32
bits of the tv_nsec field, in or out of the kernel.

Fixes: 00bf25d693e7 ("y2038: use time32 syscall names on 32-bit")
Link: https://lore.kernel.org/lkml/20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru/
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Stepan Golosunov <stepan@golosunov.pp.ru>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please apply this one as a bugfix for 5.1
---
 arch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 33687dddd86a..9092e0ffe4d3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -764,7 +764,7 @@ config COMPAT_OLD_SIGACTION
 	bool
 
 config 64BIT_TIME
-	def_bool ARCH_HAS_64BIT_TIME
+	def_bool y
 	help
 	  This should be selected by all architectures that need to support
 	  new system calls with a 64-bit time_t. This is relevant on all 32-bit
-- 
2.20.0

