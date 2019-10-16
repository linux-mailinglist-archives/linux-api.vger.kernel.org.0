Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2FD90D1
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 14:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbfJPM1n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 08:27:43 -0400
Received: from ozlabs.org ([203.11.71.1]:45345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387949AbfJPM1n (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Oct 2019 08:27:43 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46tWlc6CbSz9sPJ; Wed, 16 Oct 2019 23:27:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1571228860;
        bh=0CL8O2FrNB/9PtFz/8vuGV2CHb6F2bzsNoCytwnYtz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJGlgjT9rwbBWpiGHUDk6KMB0ErJGPZ3A9jJMY3IRWH/8OT1+F3KiQqTvxWwXoVUO
         DI+FZCfQ5HyCEgBZGCPDnkjufhfTv/Zol/5xiFdhv3RalxwmuwqJznFiU/t2ROGwZl
         dul2tJ05/qamEGCCwj88LEaA6f6SLyVVlVXqrDOBWslFJ4BeVBzE9naAmkN2zd8NiA
         Z48BS9zQQ0wbz6zisb8Uzopb9/XDs4CqUEctSStlo1kaN2jZq6Up9uTbpfeqeo2nB3
         4OLN3ywN8ii/KpA33+inPVmWBqCDXhK0L+PnWn0FTGCiRAeVp36idRSY4cEbPxTaxm
         K9tcDO1C5dyGA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     cyphar@cyphar.com
Cc:     mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, christian@brauner.io, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usercopy: Avoid soft lockups in test_check_nonzero_user()
Date:   Wed, 16 Oct 2019 23:27:32 +1100
Message-Id: <20191016122732.13467-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011022447.24249-1-mpe@ellerman.id.au>
References: <20191011022447.24249-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On a machine with a 64K PAGE_SIZE, the nested for loops in
test_check_nonzero_user() can lead to soft lockups, eg:

  watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [modprobe:611]
  Modules linked in: test_user_copy(+) vmx_crypto gf128mul crc32c_vpmsum virtio_balloon ip_tables x_tables autofs4
  CPU: 4 PID: 611 Comm: modprobe Tainted: G             L    5.4.0-rc1-gcc-8.2.0-00001-gf5a1a536fa14-dirty #1151
  ...
  NIP __might_sleep+0x20/0xc0
  LR  __might_fault+0x40/0x60
  Call Trace:
    check_zeroed_user+0x12c/0x200
    test_user_copy_init+0x67c/0x1210 [test_user_copy]
    do_one_initcall+0x60/0x340
    do_init_module+0x7c/0x2f0
    load_module+0x2d94/0x30e0
    __do_sys_finit_module+0xc8/0x150
    system_call+0x5c/0x68

Even with a 4K PAGE_SIZE the test takes multiple seconds. Instead
tweak it to only scan a 1024 byte region, but make it cross the
page boundary.

Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 lib/test_user_copy.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

v2: Rework calculation to just use PAGE_SIZE directly.
    Rebase onto Christian's tree.

diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
index ad2372727b1b..5ff04d8fe971 100644
--- a/lib/test_user_copy.c
+++ b/lib/test_user_copy.c
@@ -47,9 +47,25 @@ static bool is_zeroed(void *from, size_t size)
 static int test_check_nonzero_user(char *kmem, char __user *umem, size_t size)
 {
 	int ret = 0;
-	size_t start, end, i;
-	size_t zero_start = size / 4;
-	size_t zero_end = size - zero_start;
+	size_t start, end, i, zero_start, zero_end;
+
+	if (test(size < 2 * PAGE_SIZE, "buffer too small"))
+		return -EINVAL;
+
+	/*
+	 * We want to cross a page boundary to exercise the code more
+	 * effectively. We also don't want to make the size we scan too large,
+	 * otherwise the test can take a long time and cause soft lockups. So
+	 * scan a 1024 byte region across the page boundary.
+	 */
+	size = 1024;
+	start = PAGE_SIZE - (size / 2);
+
+	kmem += start;
+	umem += start;
+
+	zero_start = size / 4;
+	zero_end = size - zero_start;
 
 	/*
 	 * We conduct a series of check_nonzero_user() tests on a block of
-- 
2.21.0

