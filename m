Return-Path: <linux-api+bounces-208-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38C801023
	for <lists+linux-api@lfdr.de>; Fri,  1 Dec 2023 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC9B21018
	for <lists+linux-api@lfdr.de>; Fri,  1 Dec 2023 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B264CDFB;
	Fri,  1 Dec 2023 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="ICDRAV1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kA9fc0Ix"
X-Original-To: linux-api@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B010E4;
	Fri,  1 Dec 2023 08:31:43 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id AC72B3200B4A;
	Fri,  1 Dec 2023 11:31:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 01 Dec 2023 11:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701448302; x=1701534702; bh=C2
	Y0gaUdgFqndLTP/soczxZ/uabrIF0SdWstDCI27xM=; b=ICDRAV1H1ss/mZYIdG
	KoBPQ6QefiW04MDvPjpMOXEbld27B0s9t985tuF33RU/krZYXZT1/iH/7S9hBjtp
	tmxOGqdG+YFxH6fIFNSD4p40GbpiEOZIv36BFl/UOGYSNR4o0AzJV/o8TH5TNSWk
	EkffS9G3D0leip1R045pJUeNIyUM3mcV6bVGPF72+NynWjujIPtteRtuRtjZfAwV
	2z5f2CMHNj9hNsLCkpf0K2J5NGATl+bKEetcCiYmkzwOt7pT7KdQ+khU0X1SHWVD
	JFUOPSCgCNJtetWjbir6cT6KN9ki12/CM/dW4liw3CU1ocJ1cum50fLntmdxuqlh
	nFBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701448302; x=1701534702; bh=C2Y0gaUdgFqnd
	LTP/soczxZ/uabrIF0SdWstDCI27xM=; b=kA9fc0Ixhg2tmOPZe10MVIs+EwBvL
	P7pFYj28rJZ2C+Mve1gqmg3sNUzuVQJDK6t5T5GoRRUYicDYCpfrQWLC/2/dOpH2
	PxrOfH6FQ3aggywD34jyA1+Ygu43Cu4ZOWHt39L3X//gWqVTn0dgilKfqPmGtwlo
	NTsCws4m3201VPuTo93yLmj4ZpUrXePImE0/gzxQ9KYLM5s0QMc5FplgGveu07zr
	NiOcjpDaSTSPjZlgaSaHNOBd4BcAogbhGRp+zJ7FqVU8xlUgIWvR1KwbZHHkbSZs
	vlJbh4JpTVEg1P+DTWkU259lD39Ovsdgcs8WUEtbn8OxqDukseh1x/Mtw==
X-ME-Sender: <xms:bQpqZW5IMY4Z9fMia7Dc-vSDuAht_O1Wn812H56JK9ffw2dwfS-9ZA>
    <xme:bQpqZf7GbEOYgT-5gqhBGqtf_0igNWgh3FKQokl6dIcyIHfgiCzDuBWwOQGG4KKrJ
    cZk-eQJ4h99D9YTGgQ>
X-ME-Received: <xmr:bQpqZVdGoR2uTUoqu_XrLwekQPFmkWMwvHJFsTUPG4zty2eszc3NpnvvY-80fCOK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:bQpqZTKJ9BHKvlX_MVyfEZsTUbBWZuWqB9JvCh-8XLqUlOGULi4g8g>
    <xmx:bQpqZaIavWqD_RiQMYlMYa2jEudttmlAOLXjGJ5pSXlT4u6M4RAYyw>
    <xmx:bQpqZUx_sOJRs9y0fwK1FdJfAc1hZ87qtPC7JUO5W_1QA-NRlyA50A>
    <xmx:bgpqZfGVD_jkf8PwXUDBGHNCcjazR6w9rC9tis6NY97iCvwR_DtRfg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 11:31:41 -0500 (EST)
Date: Fri, 1 Dec 2023 09:31:40 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <ZWoKbHJ0152tiGeD@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <20231130173938.GA21808@redhat.com>
 <ZWjM6trZ6uw6yBza@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWjM6trZ6uw6yBza@tycho.pizza>

On Thu, Nov 30, 2023 at 10:57:01AM -0700, Tycho Andersen wrote:
> On Thu, Nov 30, 2023 at 06:39:39PM +0100, Oleg Nesterov wrote:
> > I think that wake_up_all(wait_pidfd) should have a single caller,
> > do_notify_pidfd(). This probably means it should be shiftef from
> > do_notify_parent() to exit_notify(), I am not sure...

Indeed, below passes the tests without issue and is much less ugly.
I'll respin with that later next week sometime.

Thanks,

Tycho


diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3499c1a8b929..04c4423ebed0 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -332,6 +332,7 @@ extern int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr, struct pid *,
 extern int kill_pgrp(struct pid *pid, int sig, int priv);
 extern int kill_pid(struct pid *pid, int sig, int priv);
 extern __must_check bool do_notify_parent(struct task_struct *, int);
+extern void do_notify_pidfd(struct task_struct *);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
 extern void force_sig(int);
 extern void force_fatal_sig(int);
diff --git a/kernel/exit.c b/kernel/exit.c
index 34eeefc7ee21..fd6048c20c48 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -769,6 +769,8 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 		wake_up_process(tsk->signal->group_exec_task);
 	write_unlock_irq(&tasklist_lock);
 
+	do_notify_pidfd(tsk);
+
 	list_for_each_entry_safe(p, n, &dead, ptrace_entry) {
 		list_del_init(&p->ptrace_entry);
 		release_task(p);
diff --git a/kernel/signal.c b/kernel/signal.c
index 47a7602dfe8d..7b3a1e147225 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2028,7 +2028,7 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-static void do_notify_pidfd(struct task_struct *task)
+void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
 
@@ -2060,9 +2060,6 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
-	/* Wake up all pidfd waiters */
-	do_notify_pidfd(tsk);
-
 	if (sig != SIGCHLD) {
 		/*
 		 * This is only possible if parent == real_parent.

