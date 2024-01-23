Return-Path: <linux-api+bounces-580-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203328399E7
	for <lists+linux-api@lfdr.de>; Tue, 23 Jan 2024 20:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A609E285CE6
	for <lists+linux-api@lfdr.de>; Tue, 23 Jan 2024 19:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAE82D77;
	Tue, 23 Jan 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5cOUJdh"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E43823D4
	for <linux-api@vger.kernel.org>; Tue, 23 Jan 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039849; cv=none; b=Xaxz3GBC3H/FLXnlbnW25kgrJOAiXHzdx5wqL9uIfOYx3xSl3AO1k6WMMzIvazJQYJp0Y7QAtH/bLzBOb7I4VDtoiiXtinDrYfsPee5x9ThXTVTi16N49tg+9fb8mjhRKmiPXXYgOatE/aHhk8GjfsnzERz6o1Ax2+vTvJT4/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039849; c=relaxed/simple;
	bh=eHkPR3/xKx5knTznkRRWuM3jQAUkvV0DDAKaVcE10cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzLCwklDTuONzsiKT/CGbRbg3XePoXgG1XkwloQBoEu2ZBLNiDahvak9yPYUW9ZKpxZ8gzW6+87jDo6yT52oVeCFuSMaDm3n3t03pCgcLZRxi5mhYPFqJPTlcQSDQrivaN0ingNPQcz+dlfjzg22tNG/cMlFfZrFAfhB+dFwV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5cOUJdh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706039847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vwh8XXykxSRKxJ8L9h/647T2KFRZBxRZj81Ie4/Uls=;
	b=Z5cOUJdhuIdTMgDet67EWWB0iCHCEwIi6U06OfoZHWSGKsXxadfYry2dI1Gtpjr7TDwLEY
	10WUYFSFzLWwEHFlsIGCCQHPlq0UMMIkSWhDAiZrB3znhbV5V6wXWnOuGNDSozKoZr0z/p
	nJtuCsYRhCysow+XX/LwjvNPCbUaE6o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-JItt-U_pOjajNrstXhT0bQ-1; Tue, 23 Jan 2024 14:57:24 -0500
X-MC-Unique: JItt-U_pOjajNrstXhT0bQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4F9C10AFA03;
	Tue, 23 Jan 2024 19:57:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.197])
	by smtp.corp.redhat.com (Postfix) with SMTP id 82BEB2026D66;
	Tue, 23 Jan 2024 19:57:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 23 Jan 2024 20:56:10 +0100 (CET)
Date: Tue, 23 Jan 2024 20:56:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v3 1/3] pidfd: allow pidfd_open() on non-thread-group
 leaders
Message-ID: <20240123195608.GB9978@redhat.com>
References: <20240123153452.170866-1-tycho@tycho.pizza>
 <20240123153452.170866-2-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153452.170866-2-tycho@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Too late for me, but I don't understand this patch after a quick glance.
perhaps I missed something...

On 01/23, Tycho Andersen wrote:
>
> @@ -256,6 +256,17 @@ void release_task(struct task_struct *p)
>  	write_lock_irq(&tasklist_lock);
>  	ptrace_release_task(p);
>  	thread_pid = get_pid(p->thread_pid);
> +
> +	/*
> +	 * If we're not the leader, notify any waiters on our pidfds. Note that
> +	 * we don't want to notify the leader until /everyone/ in the thread
> +	 * group is dead, viz. the condition below.
> +	 *
> +	 * We have to do this here, since __exit_signal() will
> +	 * __unhash_processes(), and break do_notify_pidfd()'s lookup.
> +	 */
> +	if (!thread_group_leader(p))
> +		do_notify_pidfd(p);

This doesn't look consistent.

If the task is a group leader do_notify_pidfd() is called by exit_notify()
when it becomes a zombie (if no other threads), before it is reaped by its
parent (unless autoreap).

If it is a sub-thread, it is called by release_task() above. Note that a
sub-thread can become a zombie too if it is traced.

>  	__exit_signal(p);

and,  do_notify_pidfd() is called before __exit_signal() which does
__unhash_process() -> detach_pid(PIDTYPE_PID).

Doesn't this mean that pidfd_poll() can hang? thread_group_exited()
won't return true after do_notify_pidfd() above, not to mention that
thread_group_empty() is not possible if !thread_group_leader().

So. When do we want to do do_notify_pidfd() ? Whe the task (leader or not)
becomes a zombie (passes exit_notify) or when it is reaped by release_task?

Either way pidfd_poll() needs more changes with this patch and it can't
use thread_group_exited(). If do_notify_pidfd() is called by release_task()
after __exit_signal(), it can just check pid_has_task(PIDTYPE_PID).

Oleg.


