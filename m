Return-Path: <linux-api+bounces-3071-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEDAA17365
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2025 20:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF2C7A2B7E
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2025 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0A1F03C4;
	Mon, 20 Jan 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWZxoEra"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A501EF0A0
	for <linux-api@vger.kernel.org>; Mon, 20 Jan 2025 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403041; cv=none; b=Eah4pMEgkSQyElmjmDIVmyWghzf5WPpqgjwsVzR3rH6BkDRXRFf7rX+VnXB/CwOK9pKEnLCl1C9tqlpqORdkma1YCJ6zfDk0GmkDeluKZp+UnW5GA46A8NFKXIBs0vd4nlPDNa8rMUctbWSZ0Q7c1U1epjVcfQJPyuRFALfMiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403041; c=relaxed/simple;
	bh=BgVWQGkb3MGaWMQfz3fct1oNhAoIK4rllFKjOeU1a5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfgVGxuiyozVdf8x07GM2aO60xnVkjgmSu/oOEYt+b11wKg5bT16SFJmKFMywHhhOUJBwUmvo1OR7lGcLADVNKUFKjIdv5EMiRMw8Y+HRfa91anpwrY2QkvFzH4rOk0XF43D5cq3H67w0zOUH6Ptiwm8VJFMft3UJXxnAH5wULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWZxoEra; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737403038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVeo8jm8HuuzVk1MAMMqmhpFdFHEjXoUfJbBYg8NeNg=;
	b=eWZxoEraI4jg0ic1w7hjoo5HzhipC2o+qN9vPo3rEm7UAbyQTC4zhZAk5HonlnGAE81JgV
	aEL1wb1CQyO/XDfCXk6J0Q9N2zExAjpvBZcvryzeD6u3mIAOmzqBtmcR4fwoM5rk+uL5Kr
	+kbzSMJV395S3OW2hjvsXrdAa7UudsY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-kFQjzSOKPxm_aB1ToJ27kA-1; Mon,
 20 Jan 2025 14:57:12 -0500
X-MC-Unique: kFQjzSOKPxm_aB1ToJ27kA-1
X-Mimecast-MFC-AGG-ID: kFQjzSOKPxm_aB1ToJ27kA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58D0C19560B8;
	Mon, 20 Jan 2025 19:57:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.104])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D645819560AD;
	Mon, 20 Jan 2025 19:57:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 20 Jan 2025 20:56:45 +0100 (CET)
Date: Mon, 20 Jan 2025 20:56:40 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250120195640.GE7432@redhat.com>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
 <20250117144556.GB21203@redhat.com>
 <20250117150627.GA15109@strace.io>
 <20250117153258.GC21203@redhat.com>
 <20250117162255.GA15597@strace.io>
 <20250118141341.GA21464@redhat.com>
 <20250119124427.GA3487@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119124427.GA3487@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/19, Dmitry V. Levin wrote:
>
> On Sat, Jan 18, 2025 at 03:13:42PM +0100, Oleg Nesterov wrote:
> > On 01/17, Dmitry V. Levin wrote:
> [...]
> > > For example, on x86_64 sizeof(struct ptrace_syscall_info) is currently 88,
> > > while on x86 it is 84.
> >
> > Not good, but too late to complain...
>
> Actually, I don't think it's too late to add an extra __u32 padding
> there since it wouldn't affect PTRACE_GET_SYSCALL_INFO.

Hmm, indeed thanks for correcting me. I forgot that ptrace_get_syscall_info()
returns actual_size, not sizeof().

> I can add an explicit padding to the structure if you say
> you like it better this way.

I dunno, up to you...

Well if we add "__u32 padding" at the end, we can probably use sizeof(info)
instead of min_size = offsetofend(struct ptrace_syscall_info, seccomp.ret_data)
in ptrace_set_syscall_info(), but then it probably makes sense to check
info->padding == 0 (just like info.flags || info.reserved) and rename this
member to reserved2.

Again, up to you, I don't know.

> > Currently we have PTRACE_SYSCALL_INFO_SIZE_VER0, when we add the new
> > "artificial" member we will have PTRACE_SYSCALL_INFO_SIZE_VER1. Granted,
> > this way set_syscall_info() can't use sizeof(info), it should do
> >
> > 	ptrace(PTRACE_SET_SYSCALL_INFO, PTRACE_SYSCALL_INFO_SIZE_VER1, info);
> >
> > and the kernel needs more checks, but this is what I had in mind when I said
> > that the 1st version can just require "user_size == PTRACE_SYSCALL_INFO_SIZE_VER0".
>
> ... it wouldn't be a big deal for user-space to specify also an
> appropriate "user_size", e.g. PTRACE_SYSCALL_INFO_SIZE_VER1 when it starts
> using the interface available since VER1, but it wouldn't help user-space
> programs either as they would have to update "op" and/or "flags" anyway,

Sure, and yes, "flags" is needed anyway.

> and "user_size" would become just yet another detail they have to care
> about.

True.

It is not that I ever thought that my suggestion could "help user-space".
Not at all. Just imo it would be better to fail "early" on the older kernel
in the case when user-space expects the "extended" API, even if flags == 0.
And no, it is not that I am 100% sure it would be always better.

So let me repeat: please do what you think is right, I won't argue. I just
tried to understand your points and explain mine to ensure we more or less
understand each other.

Oleg.


