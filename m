Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2397140C752
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbhIOOVd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbhIOOVb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 10:21:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0293FC061768;
        Wed, 15 Sep 2021 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=aOSyjY8L3JGEJsTW71NMYw24sGgHMmZonbCxsS9p7Z8=; b=sSLzUg6AJ/rs2CFzGBUqxvqPd5
        7beYjiHOtZbxykDDVXPUEJqTJMbAE4lG0fGu9mpIROsKpOxaKb6dLFzT9WWzKXk3mANsbrXcCZt3h
        BQcysbTKUg7TbpUjTKHZRnfkGJLcihtOebyI3bM18aIzUrwvbd0vwRj/CIjMjRoGLmQGOW6eNumKm
        oHLkI8Gkiz73PLfw7OVLmSPb72RGdYqKEBnudp1MZzvO/Q7feRIaadAWzrltvWd7QtK/joLqlpWmD
        KTYE9wbVRrVQCF6srjB70i6tdeSePlsunJGL/mxNaam4cbjGWvsXkRrCJquRyeVai/DLWU+eq3BtT
        XYPIFQiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQVjA-00Fk3l-6Z; Wed, 15 Sep 2021 14:17:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25625300C07;
        Wed, 15 Sep 2021 16:17:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 180EE28B2AE8B; Wed, 15 Sep 2021 16:17:29 +0200 (CEST)
Message-ID: <20210915141525.356307673@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 15 Sep 2021 16:07:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     andrealmeid@collabora.com, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de
Subject: [PATCH 12/20] futex: Rename mark_wake_futex()
References: <20210915140710.596174479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In order to prepare introducing these symbols into the global
namespace; rename:

  s/mark_wake_futex/futex_wake_mark/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -732,7 +732,7 @@ static void __futex_unqueue(struct futex
  * must ensure to later call wake_up_q() for the actual
  * wakeups to occur.
  */
-static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
+static void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
 {
 	struct task_struct *p = q->task;
 
@@ -818,7 +818,7 @@ int futex_wake(u32 __user *uaddr, unsign
 			if (!(this->bitset & bitset))
 				continue;
 
-			mark_wake_futex(&wake_q, this);
+			futex_wake_mark(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -933,7 +933,7 @@ int futex_wake_op(u32 __user *uaddr1, un
 				ret = -EINVAL;
 				goto out_unlock;
 			}
-			mark_wake_futex(&wake_q, this);
+			futex_wake_mark(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -947,7 +947,7 @@ int futex_wake_op(u32 __user *uaddr1, un
 					ret = -EINVAL;
 					goto out_unlock;
 				}
-				mark_wake_futex(&wake_q, this);
+				futex_wake_mark(&wake_q, this);
 				if (++op_ret >= nr_wake2)
 					break;
 			}
@@ -1489,7 +1489,7 @@ int futex_requeue(u32 __user *uaddr1, un
 		/* Plain futexes just wake or requeue and are done */
 		if (!requeue_pi) {
 			if (++task_count <= nr_wake)
-				mark_wake_futex(&wake_q, this);
+				futex_wake_mark(&wake_q, this);
 			else
 				requeue_futex(this, hb1, hb2, &key2);
 			continue;


