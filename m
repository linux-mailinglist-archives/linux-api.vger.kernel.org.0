Return-Path: <linux-api+bounces-855-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963A84BC4D
	for <lists+linux-api@lfdr.de>; Tue,  6 Feb 2024 18:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BFB287E6C
	for <lists+linux-api@lfdr.de>; Tue,  6 Feb 2024 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A313AC8;
	Tue,  6 Feb 2024 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7QI+w3g"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65714013
	for <linux-api@vger.kernel.org>; Tue,  6 Feb 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241127; cv=none; b=BKobfq0MYGxnOqwSEKJy8fRXm76Wlp/cjNHyLq7jmQ89x3fsFJNW2ajM+1fKy5Wkcz21fX8DwUckU6a02vU4zXzxQ/Yh1lKdyjJ9l3Tw3HsHedXtSz0P4EF/EfKudOSo+ZzdK+qqev1tHM7qeXYIOJKfTvoo30XgcS85jCxYliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241127; c=relaxed/simple;
	bh=yQUOCOFxQ1trgskQ6RJ5rgvYAiOivGJSqWUAZbzNQlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBaOR9DFA+GnQ0oh07dpzGWiwWqxBqiBke9vGHFJ5aNMVeFmkxHt+2gTP4ZZHGkKEa8KKOYtI/0dK1Il9tc5K1H2AL6hctUPoVApXmUe872Z1otj+MMSZ+JEEdqa+ICnLKu3Z9PgYUX6K6j3v6uDhlodH8kcnzoOreiNWfWcz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7QI+w3g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707241125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eKVsLWwsKPgnzmmex/I3IzcymtKT43xKlS15bvI8Q8=;
	b=W7QI+w3g1+HU8c343ckKNJFfxgkUEH2OlIzJNDCQZLbESM4xM8QvfapjYmg5KEnmLl1wKg
	cPWXN1iiGA8RaEFL7nwZeTpQgy5TesjR+wUqxVMHU8/X25Kd+RRH6203/1RGhSZTmdzHNy
	S87G7O3thd8HhmY+UKzd6wPbyE0XWsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-rJ6TbiRxOUynthcBAac81A-1; Tue, 06 Feb 2024 12:38:41 -0500
X-MC-Unique: rJ6TbiRxOUynthcBAac81A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D605879842;
	Tue,  6 Feb 2024 17:38:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.46])
	by smtp.corp.redhat.com (Postfix) with SMTP id A2383111F9;
	Tue,  6 Feb 2024 17:38:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 Feb 2024 18:37:25 +0100 (CET)
Date: Tue, 6 Feb 2024 18:37:22 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240206173722.GA3593@redhat.com>
References: <20240206164308.62620-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206164308.62620-1-tycho@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 02/06, Tycho Andersen wrote:
>
> From: Tycho Andersen <tandersen@netflix.com>
>
> We can get EBADF from __pidfd_fget() if a task is currently exiting, which
> might be confusing.

agreed, because EBADF looks as if the "fd" argument was wrong,

> Let's check PF_EXITING, and just report ESRCH if so.

agreed, we can pretend that the task has already exited,

But:

> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -688,7 +688,7 @@ static int pidfd_getfd(struct pid *pid, int fd)
>  	int ret;
>  
>  	task = get_pid_task(pid, PIDTYPE_PID);
> -	if (!task)
> +	if (!task || task->flags & PF_EXITING)
>  		return -ESRCH;

This looks racy. Suppose that pidfd_getfd() races with the exiting task.

It is possible that this task sets PF_EXITING and does exit_files()
after the "task->flags & PF_EXITING" check above and before pidfd_getfd()
does __pidfd_fget(), in this case pidfd_getfd() still returns the same
EBADF we want to avoid.

Perhaps we can change pidfd_getfd() to do

	if (IS_ERR(file))
		return (task->flags & PF_EXITING) ? -ESRCH : PTR_ERR(file);

instead?

This needs a comment to explain the PF_EXITING check. And perhaps another
comment to explain that we can't miss PF_EXITING if the target task has
already passed exit_files, both exit_files() and fget_task() take the same
task_lock(task).

What do you think?

Oleg.


