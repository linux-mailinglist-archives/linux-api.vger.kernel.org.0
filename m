Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F37988778
	for <lists+linux-api@lfdr.de>; Sat, 10 Aug 2019 03:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfHJBLV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Aug 2019 21:11:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52259 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfHJBLU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Aug 2019 21:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565399481; x=1596935481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yQceK3/V3Cf5JbjAk6qUXyXC7lhvWPiZyRnbVaEtT04=;
  b=NaDArKKDLHdIr61R/frIcql/gtYcZD5c8+c2SivnTljUFYk2ryCyqnhF
   GtOZJmT4kZW2bHLsXF95X9cingl0FHf15tNj+pCNsa3CA64KKhVBHYBYQ
   GtjDCaeGK1Ojd8uMSrAXmMapW8eA2ufzab9nTBvrtO2NPKtzrSDV7SyS1
   c2EJGTjV8pozNWRBxsloeO0jq21otKvxfNA+K/rS9+s7cC2Xjzg3iB0Iq
   w3ZhmA6WmuOiGyCdKY37l4jl5Ap1bexSpimnv8qNA5kCa3/5NaeMESAkx
   NbR6d0/TnAKPj+zWrRr4bRoGLoXBObYTp04bSxmNSVqI/7HnVsZtrU2HO
   w==;
IronPort-SDR: 2HRR/3Bw1psyVwdsB2HIFyn2/aZ6SpCSbzbcBLBHQt0BZRxgZC5GILARzN9ZkIiUf2evKoTOS3
 RIKg6j95JuCH2Tnorut2bWnC+P0cFGr/r2wQT6QqJR25jz0mibsTuOIpWmunbSaU8/X38ObZVA
 bfvJEys6U1Rwg5eKOajWqA+N7tR8M0k+UjsahKVd3iwpmf57r+hRH5GpGp5m6jd6snja5jkk/Z
 zv+OEeuqhso9UjLrt2E28bbJnn1el9kShqSMwjdjcWxeHF8PDlwuGwUGAepPXWMU66VrFkoLnw
 kmg=
X-IronPort-AV: E=Sophos;i="5.64,367,1559491200"; 
   d="scan'208";a="115535735"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2019 09:11:20 +0800
IronPort-SDR: 62B/wkC5xWGF1+cBHIuROgzvocCd3YYlhbqN5HDzxoJP1uu0lNDT/BaDN2Pfxzpi61j2uRY5Cx
 Dc+x6niRlmgeH2q9A+uor6bhvt39JP4RV1HkRjWEmu3wso+BlIsK4JvtnP5+YPLBsSaniBNe3q
 kix3lc+ZxcIjJG6Q5C2P+jnBN5/bwGHh9yMCIjXYbIrUddkdvPN1+YjBWiIwMtrjeQuD9KGDlr
 dusrIDy5KlLFQZJZ1hVsMPUho2K2m+8Wwe5VOcVXIG2etOLD8cCMQdvG2SXHx7cwNGG4ee+tfj
 lToM7ZTlEgZJhKo6vzTY7Khk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 18:09:00 -0700
IronPort-SDR: QZOA+Xj6nnRQPCxOxwTowcLS4sv1J82ej5/+kLTK+uq/j+lRm+daXvHcidfqs+GRgpMot2+wRP
 ODpIXi+cdOb9LVFpWE6/+ooiXKrHvOnUMK+nt+TWkqXGrz1amYh9tjVkE4GL+Q2dVpN6tDNN8M
 Cxnic+etw4w80PZBN4yH9wdLaujHdGlO3lUqBLkCY3bVrVFFZZ3bssjkI//AYbIn7sskqVCflT
 1XjWxRRHVTBDKElhHsc5xRw9ofbSlLzOimatGca+SI5X0X7CqZM0sZgwq7hE9r5EgV8NydMWyc
 gnw=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.58])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Aug 2019 18:11:19 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        arnd@arndb.de
Cc:     deepa.kernel@gmail.com, alistair23@gmail.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] syscalls: Update the syscall #defines to match uapi
Date:   Fri,  9 Aug 2019 18:07:58 -0700
Message-Id: <20190810010758.16407-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Update the #defines around sys_fstat64() and sys_fstatat64() to match
the #defines around the __NR3264_fstatat and __NR3264_fstat definitions
in include/uapi/asm-generic/unistd.h. This avoids compiler failures if
one is defined.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2bcef4c70183..e4bf5e480d60 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -512,7 +512,7 @@ asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *bu
 asmlinkage long sys_newfstatat(int dfd, const char __user *filename,
 			       struct stat __user *statbuf, int flag);
 asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf);
-#if defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_COMPAT_STAT64)
+#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
 asmlinkage long sys_fstat64(unsigned long fd, struct stat64 __user *statbuf);
 asmlinkage long sys_fstatat64(int dfd, const char __user *filename,
 			       struct stat64 __user *statbuf, int flag);
-- 
2.22.0

