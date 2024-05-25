Return-Path: <linux-api+bounces-1600-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFDE8CEE52
	for <lists+linux-api@lfdr.de>; Sat, 25 May 2024 11:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9558C281744
	for <lists+linux-api@lfdr.de>; Sat, 25 May 2024 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66C18E02;
	Sat, 25 May 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amohnak0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8592138E;
	Sat, 25 May 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716629810; cv=none; b=ZUaywR+m1u2bbv/ntFovIX6UO7f6iF/0CzTgvwFGIehQw5iU6PdIo6hc0XI2MtqQzFWSOuUcxSSuNlcc01ZG3hmYA76taWdHrj7vnT+U4TzomScELzown2Rvx/9urb4tL26jvmO1cvP+2i3uIgvnBLQKXYB4RiI4Kr8dQnth/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716629810; c=relaxed/simple;
	bh=pQpeTi6siEV6rFeyxPzAwxCYGJfNCUqYmCH8NQkLsDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAHt/M7LTLhOw1ZvBcy+z8pUPnmkXuq7eYCb72OrlgBU/D3XEGr7O+HC0uEKW3SEO0vsHz5ExRknv0FvQzq93xnxVOC87BpyQVoXd7wBJw3rnigfgac1hzQcF97hOkdVKnjiFjTiRswO+auMEhiKW7UOi7AXJq9fcwUHubReGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amohnak0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6266ffc751so185688366b.1;
        Sat, 25 May 2024 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716629807; x=1717234607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6/0Bm3p3aJtdGSNkJ6MTNrzbMRZn1VWF9H8hcsobTro=;
        b=Amohnak0hSfHhIx9tx577UsdKgTz5bma6vHsutuYCS2eLRcm5AADqsdkF+8P1uf3M6
         PRD5aUM1i3A+I2VxEuLuYs/r1mhJptzL9/g6R92iUZG8LpkY3ZF1N+tIf9cA+3fV0eR1
         vGHUiX+koM+ZGGRabOJGALWOH56OsF6wwk3z3KgaAM15LpLcwNDZ2BInyGJN+C0KGj+o
         YbgKY6TRlanpYJ+DOuqI+qsRc178GiHHDj7WSDEIvAdATmKqXgKI8dl5QQUzXkU9Q2fr
         eM49QS7VBc5E7o6gX3Ds5RzbSoij1yzNnU58+bqYMKijvOXG0tltdJ1oSargi4FlcbOH
         muBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716629807; x=1717234607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/0Bm3p3aJtdGSNkJ6MTNrzbMRZn1VWF9H8hcsobTro=;
        b=g3n2QPhY6jhtAaNWZmdZOvmVTNtLeX5wdCP5S0Vhw0uPW9vLUSU61EHAWut6aoBWJm
         CI1Uk8Ud9b64Y45Lcm4wr18VeS3kSVsCtIhieRXq6ElAZfQmV/dV0z/1zmXdXh+yO+/H
         5sbRGP3wAUkHq4y96N8AGkRCI2BNNfwoWkWhE0DnVe8OBHbsW6E67fpaT5PMuHh56nn3
         5r4zYIRvNVhGwYRsdxn118psv8cGV0Cj5QmUHIjc2G6Yx26zfRim65MbvQ/eswkcCwAC
         xYHN3t4dYPiX/XZSeftssLxCK360C1VtDPkQH0L2ImFkqZRTFIftMZUlb2qUWBxnMjxZ
         EMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf0PMRZ2EruyojFUI6fnzbYOOVgpALLGYGRsGdDh+krwmyoyOrIm/9Pju5EXrtHATWzvmcPXxyQiRJkJcH15Pd/Y3RyY+e3kSpozaRtUjOlIa6nzpHDX2UyZrmwXkS/14Dy0Qtuzzt
X-Gm-Message-State: AOJu0YyKt56OEA0asI95x51msHhRl5uPkEDQCelNFa4d0RJ+/VFFcwWb
	H2itEdaAG96J6xjbLO7jOd1kV6EKnDQOblP4eM7addVuRdxBisdS
X-Google-Smtp-Source: AGHT+IHAMkKJLhC2g+y/zJiU6OfpF7BfwsiJiaBUDwFxEIceHSm+Fz7e91BijhHDBFZ1LflM1y3Tew==
X-Received: by 2002:a17:906:4103:b0:a59:d243:945 with SMTP id a640c23a62f3a-a6265114947mr291660166b.57.1716629806812;
        Sat, 25 May 2024 02:36:46 -0700 (PDT)
Received: from f (cst-prg-19-178.cust.vodafone.cz. [46.135.19.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8da2asm235849766b.179.2024.05.25.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 02:36:45 -0700 (PDT)
Date: Sat, 25 May 2024 11:36:33 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>, 
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com, carlos@redhat.com, 
	Peter Oskolkov <posk@posk.io>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Chris Kennelly <ckennelly@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, libc-alpha@sourceware.org, 
	Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	Noah Goldstein <goldstein.w.n@gmail.com>, Daniel Colascione <dancol@google.com>, longman@redhat.com, 
	kernel-dev@igalia.com
Subject: Re: [PATCH v2 1/1] futex: Add FUTEX_SPIN operation
Message-ID: <wzciz6bgg6yd2kzyzacm7c7mpwq6ajgnxnyhqhdwxi7oj3vgb5@e2meygmexy6u>
References: <20240523200704.281514-1-andrealmeid@igalia.com>
 <20240523200704.281514-2-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523200704.281514-2-andrealmeid@igalia.com>

On Thu, May 23, 2024 at 05:07:04PM -0300, André Almeida wrote:
> Add a new mode for futex wait, the futex spin.
> 

I'll note that currently individuals who want to reduce performance
degradation due to contention in userspace either handroll some
speculative spinning + futex usage or straight up only spin, which btw
is a massive pet peeve of mine.

With this in mind the real reference point justifying this mechanism (or
showing it not being good enough to warrant inclusion) is a case where
all participating threads are on cpu and spinning is done in userspace
(in a sensible manner). Of course there is more than one way to spin,
but that is a minor point in the grand scheme of things.

The benchmark you linked in the cover letter definitely would use some
improvement, it was mentioned elsewhere that some of the time is spent
just waiting for threads to be created. The usual way to handle this is
by parking everyone on a barrier before the measurement starts.  You can
use will-it-scale as an example how to do it, or better yet plug your
stuff into it as testcases instead. It even already has some contested
pthread mutex benchmarks.

So I would say proper test matrix would include pthread mutexes as is,
FUTEX2_SPIN and mere spinning (just load + cpu_relax, I can ship you
with sample code for will-it-scale if you want).

Even the best possible variant of FUTEX2_SPIN has to do worse than mere
spinning in userspace -- in a HT setup it hinders execution by coming
here instead of just cpu_relax-ing, and that aside it may be introducing
dead time where the lock is free to use by the cpu is busy going in and
out of the kernel. The question is if it is going to do well enough to
persuade people to not bother with their own hacks, which it plausibly
will.

> Given the FUTEX2_SPIN flag, parse the futex value as the TID of the lock
> owner. Then, before going to the normal wait path, spins while the lock
> owner is running in a different CPU, to avoid the whole context switch
> operation and to quickly return to userspace. If the lock owner is not
> running, just sleep as the normal futex wait path.
> 

Syscall costs are so high that by the time you get to this code chances
are decent the owner already released the lock and it is now being held
by someone else, also see below.

> +static int futex_spin(struct futex_hash_bucket *hb, struct futex_q *q,
> +		       struct hrtimer_sleeper *timeout, u32 uval)
> +{
> +	struct task_struct *p;
> +	pid_t pid = uval & FUTEX_TID_MASK;
> +
> +	p = find_get_task_by_vpid(pid);
> +

In order to even get here all prospective spinners have to serialize on
a spinlock. Then they further dirty a process by grabbing a ref on it.
This seriously hinders the mechanism but is avoidable.

> +	/* no task found, maybe it already exited */
> +	if (!p) {
> +		futex_q_unlock(hb);
> +		return -EAGAIN;
> +	}
> +
> +	/* can't spin in a kernel task */
> +	if (unlikely(p->flags & PF_KTHREAD)) {
> +		put_task_struct(p);
> +		futex_q_unlock(hb);
> +		return -EPERM;
> +	}
> +
> +	futex_queue(q, hb);
> +
> +	if (timeout)
> +		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
> +
> +	while (1) {
> +		if (likely(!plist_node_empty(&q->list))) {
> +			if (timeout && !timeout->task)
> +				goto exit;
> +
> +			if (task_on_cpu(p)) {
> +				/* spin */

cpu_relax() is the thing to do here, it was already mentioned by someone
else.

My comment is that as mentioned above the lock owner by now may be
different. So to my reading this spins on the lock as long as p is
running, which may not even be holding it at the moment. Worse, by now
the p task may also be spinning in this very place.

That is to say I don't believe passing TID as an argument to the
syscall is a viable approach.

Instead this code will have to read the futex value on its own every
time (with a special accessor which does not allow for page faults) and
do the find_get_task_by_vpid + task_on_cpu combo under RCU (no refing of
the proc).

The queue locking would also be dodged, except for the case where the
code decides to go off cpu.

Short of something like that imho this has no hopes of competing with
userspace spinning.

