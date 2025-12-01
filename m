Return-Path: <linux-api+bounces-5530-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 694C3C9816A
	for <lists+linux-api@lfdr.de>; Mon, 01 Dec 2025 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11CB4342B92
	for <lists+linux-api@lfdr.de>; Mon,  1 Dec 2025 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D57332916;
	Mon,  1 Dec 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="GpwTwafB"
X-Original-To: linux-api@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220B31B126;
	Mon,  1 Dec 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764603920; cv=none; b=o+03tHBnRl+7LqUgkMBSd878QlcpInlwApI8MgmKjYOysRZ2X0RjVZKZ6hwtGK57gM6cInoe2K2jpAEJ4mT2t4tThJ62Nn459iYy1URB7WkV+keZvMMg6+9EX/1GjKidhMSYlu5AEgiFnYXuTwq7h7mO3lNMytf2xjagkq+YRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764603920; c=relaxed/simple;
	bh=F5KsvJt0aESoPeYff5ES9RuqYUwKqHBZMfOX9GrEZOE=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=XBAvgMyHddNtgcKvP8Jn6p9qHNbJq+bYzdBVAMe96xdg+cNdFcIvh0A4k+wPThelxqTVSjgQRwWsCCNFwFtf66Y2Xr2LEmx8WSt0YfxNZuK9wN/gOt3dzjKe32a20+PnjLcavEHyZ8YBCkMtYLE2XtHgdcNSi13Yur4oLeJOjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=GpwTwafB; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Content-Transfer-Encoding:MIME-Version:Reply-To;
	bh=5rvrHVptciQcXtW9TY3+t1mvNYuoGKCLbslFgmhg1k4=; b=GpwTwafBRI/+3lONEduWwxKRKU
	hZUgxzfZKQN+zLFJL+vSY+0Xcnwb404pHIomVbTeI1U5/Pxz19ELrSXxMmrq8MttSCiuWVT2wuz3x
	63dX435P3ClUhpJwSrI0HGUyXsqPuX1f30Fl9sC/Md1b9FjZTNUdKXuibjTsZMxbpXUrGdfcUAoLr
	H1+SxnfWXpn/mdJ4Hs1DEEbXjKBJVwTaspHYTnR/v4w7IC7Xfaz3maT4Z6IOEueQJXBvr2jK2KFyY
	Hu1K37+MHJOBt4Kltnz25W/AAwtc3Q+tV1h9F4p/q/yJPsXKXGE4Svb/NPKYcI0N35m0yg49o7KKX
	Nx/rxVqA==;
Received: from [167.98.27.226] (helo=localhost)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vQ5XH-008XVy-ET; Mon, 01 Dec 2025 15:09:56 +0000
Date: Mon, 01 Dec 2025 16:09:55 +0100
Message-ID: <f852d21a353b7a49768df707051fbe69@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH] sched/deadline: Add reporting of runtime left & abs
 deadline to sched_getattr() for DEADLINE tasks
To: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Tommaso Cucinotta
	<tommaso.cucinotta@santannapisa.it>, Tommaso Cucinotta
	<tommaso.cucinotta@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>
In-Reply-To: <20250912053937.31636-2-tommaso.cucinotta@santannapisa.it>
References: <20250912053937.31636-1-tommaso.cucinotta@santannapisa.it>
	<20250912053937.31636-2-tommaso.cucinotta@santannapisa.it>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>

Hi Tommaso,

On Fri, 12 Sep 2025 07:38:29 +0200, Tommaso Cucinotta <tommaso.cucinotta@gmail.com> wrote:
> The SCHED_DEADLINE scheduler allows reading the statically configured
> run-time, deadline, and period parameters through the sched_getattr()
> system call. However, there is no immediate way to access, from user space,
> the current parameters used within the scheduler: the instantaneous runtime
> left in the current cycle, as well as the current absolute deadline.
> 
> The `flags' sched_getattr() parameter, so far mandated to contain zero,
> now supports the SCHED_GETATTR_FLAG_DL_DYNAMIC=1 flag, to request
> retrieval of the leftover runtime and absolute deadline, converted to a
> CLOCK_MONOTONIC reference, instead of the statically configured parameters.
> 
> This feature is useful for adaptive SCHED_DEADLINE tasks that need to
> modify their behavior depending on whether or not there is enough runtime
> left in the current period, and/or what is the current absolute deadline.
> 
> Notes:
> - before returning the instantaneous parameters, the runtime is updated;
> - the abs deadline is returned shifted from rq_clock() to ktime_get_ns(),
>   in CLOCK_MONOTONIC reference; this causes multiple invocations from the
>   same period to return values that may differ for a few ns (showing some
>   small drift), albeit the deadline doesn't move, in rq_clock() reference;
> - the abs deadline value returned to user-space, as unsigned 64-bit value,
>   can represent nearly 585 years since boot time;
> - setting flags=0 provides the old behavior (retrieve static parameters).
> 
> See also the notes from discussion held at OSPM 2025 on the topic
> "Making user space aware of current deadline-scheduler parameters".
> 
> Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
> ...

I tested your patch and I can confirm I could retrieve the remaining runtime and
absolute deadline values via sched_gettattr() as you mentioned in your cover
letter. I'm involved in a project where the deadline scheduler is used in
critical realtime applications, which are monitored in order to let the system
react in case of misbehaviours, for instance if the applications overrun their
WCET or miss their expected deadlines.

On top of your reasons explained at OSPM 2025, I think this patch could be also
useful in regards of monitoring as it would let userspace retrieve a more
accurate runtime value compared to the typical estimation calculated via the
clock_gettime(CLOCK_THREAD_CPUTIME_ID). To my understanding, the runtime_left
retrieved with sched_gettattr() is also more representative of the actual task
remaining budget when the runtime is scaled in dl_scaled_delta_exec() to
calculate the time invariant task utilization [1] for energy-aware scheduling
[2]. Moreover, this patch would allow the application to determine deadline
misses.

Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>

Best regards,
Matteo Martelli

[1]: https://www.kernel.org/doc/html/v6.17/scheduler/sched-capacity.html#frequency-invariance
[2]: https://www.kernel.org/doc/html/v6.17/scheduler/sched-deadline.html#energy-aware-scheduling


