Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1929D45F6BE
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 23:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhKZWM5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 17:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbhKZWK5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 17:10:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86CDC06173E;
        Fri, 26 Nov 2021 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wx8LefqrmaL7hNN7/gVpJleg+PonaO/cczr6R2BoD00=; b=OZq1Qoyl8UMeOifsrrdF/RyTDD
        pzYzJpPls4qfWAvlDSvhaqpS+B9r7Th236tq1LmAv78J3/lhxwvNqb7r7eNRyL5c77W08oKrWsWDY
        RpNPr1uTizkMcpvfkmd6rMivZipaj2Tdvmrf1wj4KoPxh+qan1cpQM3poyntYuvwMPt/pvZa2L9Wm
        Pibf1cVfUpDHEm2ZoDzcbhrbInTW+h/X5BlYzbbBVqMLZXYGEy5W0GyALx/PAWeTtYwjJqpgsfsgH
        QXu0968ZDUA5fAnRKaoLUVIDl+9KXrLOc7r6dCPbr6t1UFeFkyF4qIUVp4f3Q3odm0qhCJ7FvpYCu
        4h239dsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqjNR-00CLFd-80; Fri, 26 Nov 2021 22:07:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27F5E300093;
        Fri, 26 Nov 2021 23:07:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0743C2DC70762; Fri, 26 Nov 2021 23:07:29 +0100 (CET)
Date:   Fri, 26 Nov 2021 23:07:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <YaFaoQsIBUmq1S/q@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <87a6hqhbgh.ffs@tglx>
 <YaFY0KqfPhmZjK7n@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaFY0KqfPhmZjK7n@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 26, 2021 at 10:59:44PM +0100, Peter Zijlstra wrote:

> That seems to loose the freezable crud.. then again, since we're
> interruptible, that shouldn't matter. Lemme go do that.


---

--- a/kernel/sched/umcg.c
+++ b/kernel/sched/umcg.c
@@ -52,7 +52,7 @@ static int umcg_pin_pages(void)
 
 	server = umcg_get_task(server_tid);
 	if (!server)
-		return -EINVAL;
+		return -ESRCH;
 
 	if (pin_user_pages_fast((unsigned long)self, 1, 0,
 				&tsk->umcg_worker_page) != 1)
@@ -358,18 +358,10 @@ int umcg_wait(u64 timo)
 {
 	struct task_struct *tsk = current;
 	struct umcg_task __user *self = tsk->umcg_task;
-	struct hrtimer_sleeper timeout;
 	struct page *page = NULL;
 	u32 state;
 	int ret;
 
-	if (timo) {
-		hrtimer_init_sleeper_on_stack(&timeout, tsk->umcg_clock,
-					      HRTIMER_MODE_ABS);
-		hrtimer_set_expires_range_ns(&timeout.timer, (s64)timo,
-					     tsk->timer_slack_ns);
-	}
-
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -415,22 +407,16 @@ int umcg_wait(u64 timo)
 			break;
 		}
 
-		if (timo)
-			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
-
-		freezable_schedule();
-
-		ret = -ETIMEDOUT;
-		if (timo && !timeout.task)
+		if (!schedule_hrtimeout_range_clock(timo ? &timo : NULL,
+						    tsk->timer_slack_ns,
+						    HRTIMER_MODE_ABS,
+						    tsk->umcg_clock)) {
+			ret = -ETIMEDOUT;
 			break;
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 
-	if (timo) {
-		hrtimer_cancel(&timeout.timer);
-		destroy_hrtimer_on_stack(&timeout.timer);
-	}
-
 	return ret;
 }
 
@@ -515,7 +501,8 @@ void umcg_notify_resume(struct pt_regs *
 		goto done;
 
 	if (state & UMCG_TF_PREEMPT) {
-		umcg_pin_pages();
+		if (umcg_pin_pages())
+			goto die;
 
 		if (umcg_update_state(tsk, UMCG_TASK_RUNNING,
 				      UMCG_TASK_RUNNABLE, &next_tid))
@@ -586,7 +573,9 @@ SYSCALL_DEFINE2(umcg_wait, u32, flags, u
 		tsk->flags &= ~PF_UMCG_WORKER;
 
 	/* see umcg_sys_{enter,exit}() */
-	umcg_pin_pages();
+	ret = umcg_pin_pages();
+	if (ret)
+		return ret;
 
 	ret = umcg_update_state(tsk, UMCG_TASK_RUNNING, UMCG_TASK_RUNNABLE, &next_tid);
 	if (ret)
