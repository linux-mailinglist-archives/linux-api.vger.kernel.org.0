Return-Path: <linux-api+bounces-3011-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD049A127E0
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 16:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECED7164724
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22441161311;
	Wed, 15 Jan 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgQvm9+Q"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71597158527
	for <linux-api@vger.kernel.org>; Wed, 15 Jan 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956360; cv=none; b=LAUJoyy5IfBS+kfTeCOjRshe7/oOiBz3Ct1nN/lfXn5oYTnu/e+bMySuhMyUhj/oemcyFjAJZcnRKutVzKcGSSALsUCwT6e8C4qZlWuo0qGlkta0C6VX2A8DEB/kcNskal8hPaezVNnZIMv1r5L69Lgejdn74t3539PnOKijYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956360; c=relaxed/simple;
	bh=OLiyJXUVPiOWpx+CfgXGe7fdVxM/3FU3rsesfzAiLhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZugHB6xWwQTIqQCwGaA/h7rQSQgha38+4Qp8MKG74kIMAknuXJQJwE6ZvfcUWB1jc0yNGMkdDrx9ztpVLevll3nRqOddTKcbdOYz6vaFxSgv9Ks/z/U20mtSaa51H6UQRKvQeq9Pj0TZUtREzgWbeuoBczSMZc/sqjRhdGanXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgQvm9+Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736956357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLiyJXUVPiOWpx+CfgXGe7fdVxM/3FU3rsesfzAiLhs=;
	b=PgQvm9+QldUxHAQD8KkzeeoXDIzy1XRuOuF8WHRQYdA7EQ50j/D2XfE0lTRF2W+O0KUBB3
	ET2m3eomNSsljJuoaSYN7qnMYN6cJZ7jYO2d9muTAFc+GdL7GhyS/lylu/w35p0Nez9heq
	NfOJasN+SbgRITfrXnvyznGqr1NlM44=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-zHUsd3CiMfGI3sJwRhouBw-1; Wed,
 15 Jan 2025 10:52:31 -0500
X-MC-Unique: zHUsd3CiMfGI3sJwRhouBw-1
X-Mimecast-MFC-AGG-ID: zHUsd3CiMfGI3sJwRhouBw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 202621955DB8;
	Wed, 15 Jan 2025 15:52:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B2C5819560AD;
	Wed, 15 Jan 2025 15:52:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 16:52:02 +0100 (CET)
Date: Wed, 15 Jan 2025 16:51:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc: Eyal Birger <eyal.birger@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Sarai Aleksa <cyphar@cyphar.com>,
	mhiramat@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
	rafi@rbk.io
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250115155153.GB11980@redhat.com>
References: <CAEf4BzZquQBW1DuEmfhUTicoyHOeEpT6FG7VBR-kG35f7Rb5Zw@mail.gmail.com>
 <EBE7D529-5418-4BD6-B9B5-64BE0FBE8569@gmail.com>
 <20250115005012.GA10946@redhat.com>
 <67874b84.7b0a0220.3935f4.1f48@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67874b84.7b0a0220.3935f4.1f48@mx.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/15, Shmulik Ladkani wrote:
>
> IMO There are 2 problematic aspects with ff474a78cef5
> ("uprobe: Add uretprobe syscall to speed up return probe").
>
> The first, as Eyal mentioned, is the kernel regression: There are
> endless systems out there (iaas and paas) that have both
> telementry/instrumentation/tracing software (utilizing uprobes) and
> container environments (duch as docker) that enforce syscall
> restrictions on their workloads.
> These systems worked so far, and with kernels having ff474a78cef5 the
> workloads processes fault.

Again, I have to agree. The kernel should not break userspace.

But,

> The second, is the fact that ff474a78cef5 (which adds a new syscall
> invocation to the uretprobe trampoline) *exposes an internal kernel
> implementation* to the userspace system:

I disagree...

> There are millions of binaries/libraries out there that *never issue*
> the new syscall: they simply do not have that call in their
> instructions. Take for example hello-world.

And they should never use this syscall,

> However, once hello-world is traced (with software utilizing
> uprobes) hello-world *unknowingly* DO issue the new syscall, just
> because the kernel decided to implement its uretprobe trampoline using
> a new syscall - a mechanism that should be completely transparent and
> seamless to the user program.

IMO, sys_uretprobe() doesn't really differ from sys_sigreturn() in this
respect.

> This is totally unexpected, and to ask a system admin to "guess" whether
> hello-world is "going to issue the syscall despite the fact that
> such invocation does not exist in its own code at all" (and set seccomp
> permissions accordingly) is asking for the admin to know the exact
> *internal mechanisms* that the kernel use for implemeting the
> trampolines.

Well, man 2 uretprobe can help ;)

> we
> shoudn't add any instruction (such as a syscall) that isn't *completely
> transparent* to the userspace program.

We can't make it *completely transparent*, but it is easy to hide this
syscall from seccomp (and/or ptrace).

And this will fix the problem. But I don't feel this is the right solution.

Oleg.


