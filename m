Return-Path: <linux-api+bounces-828-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B90848573
	for <lists+linux-api@lfdr.de>; Sat,  3 Feb 2024 13:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468F8289101
	for <lists+linux-api@lfdr.de>; Sat,  3 Feb 2024 12:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF55D908;
	Sat,  3 Feb 2024 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAVE034x"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061A5C8F8
	for <linux-api@vger.kernel.org>; Sat,  3 Feb 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706961952; cv=none; b=tfuy3aCzIhDhCqhqAUDrVHPSq5m8OxSh5ZuNuwkWKXN2bLMwA2THnAKmfotkwmw0Lsa1zleWHk26e4NIcVs6iDJfB1xZswy5QdVAx/+TrL6luB0Z3PiFGRX1mbcx40JG2O6A3g50vrwBGem0UY9D7SRFaGrLo4EArLdPkJbszG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706961952; c=relaxed/simple;
	bh=4N6u89cf+F03UpwkJFE+VlZv032k1fSw3iQLQC00Ba8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkTdxWguSpOqH2fpSX1MtWG+gFggB/5ex/Yy1vKz46z7EapgZv9USgxRcNaMDm3bO/USYMvd01SY3jMdtmLN4mBjzwOjlReQc37p4TvQ53W2oAUM5VOZFa5Nmt1LrQKhSSzEN6mWXb0kdwKLC+i9l2fyrEZs1Ttvscddnu2XVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAVE034x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706961948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbI2eS5Hr20zr/SF7iQvl7dOfMS34w2zMpG0aCO1sHI=;
	b=AAVE034x7omrp6zStZNhDr1O9Z7916UG6P/VeswebaIqcvaFfjNJQOCUXYsdtp5lOVk3jX
	WVllO7Tvn/sJNMCyj7MBbfQCMrk0OmaY6csctEguHI0whrjWvjXf+UMqvFPVIVKIkisjuO
	MsqLFrud+mmGgwy6qvvaHy9f7WFzRDg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-MxdKvUX9NcmcNbgJlejw6g-1; Sat, 03 Feb 2024 07:05:44 -0500
X-MC-Unique: MxdKvUX9NcmcNbgJlejw6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC353827E54;
	Sat,  3 Feb 2024 12:05:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.56])
	by smtp.corp.redhat.com (Postfix) with SMTP id 2CF64492BC6;
	Sat,  3 Feb 2024 12:05:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  3 Feb 2024 13:04:28 +0100 (CET)
Date: Sat, 3 Feb 2024 13:04:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pidfd_poll: report POLLHUP when pid_task() == NULL
Message-ID: <20240203120425.GA30029@redhat.com>
References: <20240202131147.GA25988@redhat.com>
 <20240202131226.GA26018@redhat.com>
 <20240202-arbeit-fruchtig-26880564a21a@brauner>
 <20240202160704.GA5850@redhat.com>
 <20240202-lackmantel-vervielfachen-4c0f0374219b@brauner>
 <20240202190529.GA28818@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202190529.GA28818@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Christian, I apologize for my terse and unclear emails yesterday,
I was a bit busy.

On 02/02, Oleg Nesterov wrote:
>
> On 02/02, Christian Brauner wrote:
> >
> > > I think we need a simpler patch. I was going to send it as 4/4, but I'd
> > > like to think more, _perhaps_ we can also discriminate the PIDFD_THREAD
> > > and non-PIDFD_THREAD waiters. I'll try to make the patch(es) tomorrow or
> >
> > Right, I didn't go that far.

OK, so lets forget about the PIDFD_THREAD waiters for the moment.
Then everything is trivial, please see below.

> > > 	1. we can't use wake_up_poll(), it passes nr_exclusive => 1
> >
> > Bah. So we need the same stuff we did for io_uring and use
> > __wake_up() directly. Or we add wake_up_all_poll() and convert the other
> > three callsites:
>
> ...
>
> > +#define wake_up_all_poll(x, m)                                                 \
> > +       __wake_up(x, TASK_NORMAL, 0, poll_to_key(m))
>
> Agreed, but I think this + s/wake_up/wake_up_all_poll/ conversions
> need a separate patch.

And if it was not clear I like this change! In fact I thought about
the new helper too, but I didn't realize that it already have the
users.

> > -void do_notify_pidfd(struct task_struct *task)
> > +void pidfd_wake_up_poll(struct task_struct *task, bool dead)
> >  {
> > -	struct pid *pid;
> > -
> >  	WARN_ON(task->exit_state == 0);
> > -	pid = task_pid(task);
> > -	wake_up_all(&pid->wait_pidfd);
> > +	WARN_ON(mask == 0);
> > +	wake_up_all_poll(&task_pid(task)->wait_pidfd,
> > +			 EPOLLIN | EPOLLRDNORM | dead ? EPOLLHUP : 0);
>
> No...
>
> This is still overcomplicated and is not right.
                                ^^^^^^^^^^^^^^^^
Sorry, sorry, I misread your change, "dead" is always false so it has
no effect and thus the change is correct.

But why do we need this arg? All we need is the trivial one-liner:

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2025,7 +2025,8 @@ void do_notify_pidfd(struct task_struct *task)
 
 	WARN_ON(task->exit_state == 0);
 	pid = task_pid(task);
-	wake_up_all(&pid->wait_pidfd);
+	__wake_up(&pid->wait_pidfd, TASK_NORMAL, 0,
+		  poll_to_key(EPOLLIN | EPOLLRDNORM));
 }
 
 /*

and I was going to send the patch above as 4/4, but then decided
to delay it, see below.

We can rename do_notify_pidfd() if you wish, and of course the
new wake_up_all_poll() helper you proposed makes sense, but this
is another story.

As for __change_pid(). In this case wake_up_all() is fine, we can
change it to use wake_up_all_poll() too for consistency, but this
is not strictly necessary and in fact "key = 0" makes a bit more
sense imo.

And just in case... previously I said that (perhaps) it can use
__wake_up_pollfree() but no, this would be obviously wrong.

------------------------------------------------------------------
Now let's recall about the PIDFD_THREAD waiters. exit_notify() does
		
	/*
	 * sub-thread or delay_group_leader(), wake up the
	 * PIDFD_THREAD waiters.
	 */
	if (!thread_group_empty(tsk))
		do_notify_pidfd(tsk);

and it would be nice to not wakeup the non-PIDFD_THREAD waiters.

I was thinking about something like the changes below but

	- I am NOT sure it will work! I need to read the code
	  in fs/select.c

	- in fact I am not sure this makes a lot of sense, and
	  the hack in pidfd_poll() doesn't look very nice even
	  _if_ it can work.

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2081,6 +2081,13 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	struct task_struct *task;
 	__poll_t poll_flags = 0;
 
+	if (thread && pts && pts->_qproc) {
+		// We are not registered yet. Update the key to mark
+		// us a a PIDFD_THREAD waiter, __pollwait() will copy
+		// this ->_key to poll_table_entry->key.
+		if (pts->_key & EPOLLIN) // exclude the POLLHUP-only waiters
+			pts->_key |= EPOLLMSG; // random flag
+	}
 	poll_wait(file, &pid->wait_pidfd, pts);
 	/*
 	 * Depending on PIDFD_THREAD, inform pollers when the thread

Now, do_notify_pidfd() can do

	if (!thread_group_empty(tsk))
		mask = EPOLLMSG; // matches the hack in pidfd_poll
	else
		mask = EPOLLIN | EPOLLRDNORM;

	__wake_up(..., poll_to_key(mask));

Yes, in this case it makes more sense to pass !thread_group_empty()
as a "bool thread" argument.

---------------------------------------------------------------------

What do you think?

I am starting to think that I shouldn't have delayed the 1st trivial
change. Feel free to push it, with or without rename, with or without
the new wake_up_all_poll() helper, I am fine either way. But please
don't add the new "int dead" argument, afaics it makes no sense.

Thanks,

Oleg.


