Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3B1D54D4
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2020 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgEOPhA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 May 2020 11:37:00 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:47704 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgEOPg7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 May 2020 11:36:59 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 231D22E14BF;
        Fri, 15 May 2020 18:36:52 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id aabq3ATbRs-ampGXsHa;
        Fri, 15 May 2020 18:36:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1589557012; bh=6FY4knOleMpXky40W+HxLYfM4E1Bv3vZkreAoWAGMIg=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=Ot7oERu5ZSm7ZAxFFmwsShAPsbb4nYYg45KcoBQOtFvIJoaVOJgelxbt29bl2pKlP
         c5+M3xibGZgBBAJT6mFZgDypjrFcNn3W4FOdGYETJYu/T1cmpS1yNPJ/yv1uNjYLQ3
         VOjnnK6tZOIjkxuV7APba9/nTEfjGSBDTaVijeoQ=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:8::1:9])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id v3Wo6qoLe5-amWCAVNL;
        Fri, 15 May 2020 18:36:48 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH] futex: send SIGBUS if argument is not aligned on a four-byte
 boundary
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Maxim Samoylov <max7255@yandex-team.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Date:   Fri, 15 May 2020 18:36:47 +0300
Message-ID: <158955700764.647498.18025770126733698386.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Userspace implementations of mutexes (including glibc) in some cases
retries operation without checking error code from syscall futex.
This is good for performance because most errors are impossible when
locking code trusts itself.

Some errors which could came from outer code are handled automatically,
for example invalid address triggers SIGSEGV on atomic fast path.

But one case turns into nasty busy-loop: when address is unaligned.
futex(FUTEX_WAIT) returns EINVAL immediately and loop goes to retry.

Example which loops inside second call rather than hung peacefully:

#include <stdlib.h>
#include <pthread.h>

int main(int argc, char **argv)
{
	char buf[sizeof(pthread_mutex_t) + 1];
	pthread_mutex_t *mutex = (pthread_mutex_t *)(buf + 1);

	pthread_mutex_init(mutex, NULL);
	pthread_mutex_lock(mutex);
	pthread_mutex_lock(mutex);
}

It seems there is no practical usage for calling syscall futex for
unaligned address. This may be only bug in user space. Let's help
and handle this gracefully without adding extra code on fast path.

This patch sends SIGBUS signal to slay task and break busy-loop.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reported-by: Maxim Samoylov <max7255@yandex-team.ru>
---
 kernel/futex.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index b59532862bc0..8a6d35fa56bc 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -508,10 +508,21 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
 
 	/*
 	 * The futex address must be "naturally" aligned.
+	 * Also send signal to break busy-loop if user-space ignore error.
+	 * EFAULT case should trigger SIGSEGV at access from user-space.
 	 */
 	key->both.offset = address % PAGE_SIZE;
-	if (unlikely((address % sizeof(u32)) != 0))
+	if (unlikely((address % sizeof(u32)) != 0)) {
+		struct kernel_siginfo info;
+
+		clear_siginfo(&info);
+		info.si_signo = SIGBUS;
+		info.si_code  = BUS_ADRALN;
+		info.si_addr  = uaddr;
+		force_sig_info(&info);
+
 		return -EINVAL;
+	}
 	address -= key->both.offset;
 
 	if (unlikely(!access_ok(uaddr, sizeof(u32))))

