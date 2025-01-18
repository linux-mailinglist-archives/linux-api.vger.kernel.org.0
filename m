Return-Path: <linux-api+bounces-3056-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B5A15D8F
	for <lists+linux-api@lfdr.de>; Sat, 18 Jan 2025 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02827166F0B
	for <lists+linux-api@lfdr.de>; Sat, 18 Jan 2025 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893E19B59C;
	Sat, 18 Jan 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsuhhWDK"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59F199EBB
	for <linux-api@vger.kernel.org>; Sat, 18 Jan 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737212751; cv=none; b=JXTkkv8Dmjqw6XXWV0+iCS322I+F0m5N5CHDHKtRKKcqnIFJnZpWlsVSbofH+UrjdAQ2X5u9I7QtoYBu3/aJ2BmdnAhD/FF2fx0avkZYRe1z7KJ9wb6jrP170erDUeJiDhdOgyr7NNdJ1dTOyj/Z4bYyEZ/kf4oVzfUlNfkWFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737212751; c=relaxed/simple;
	bh=FB5tEY/SIGgEcj+wCphizTJs+zgzCCFaTisQu4Io4D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWoJ/qdPnv3w+RjpOvpg2tUkHWg14kxIANakWf+EZQwxOtKhJEqxbYjSl9ixxMxdNGlkaXtiKykt5nLJdjX1VmGyMJrXspaI8aOpGcpTo6H4GE1dsCeGn/cG4Gbu577pP4IIwvmyqId1tNKpxEYpLB/VPtxO2569OEAs6Sx2by8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsuhhWDK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737212748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FB5tEY/SIGgEcj+wCphizTJs+zgzCCFaTisQu4Io4D8=;
	b=KsuhhWDK95iM5PtGmDHzMUPFzqW6bxDKq59GzOh8jet3YXl4z8qKTfw4Q9wSsSnV2fcZWf
	qvrw5ilhe25RGidFE9U4Dxi16nQ8Stxixjc4MzBLLeMYMGcMmgTtDFWUnXtBs1830uwNKz
	415JxZkqdSNnKbKgkJOHVC/bZUmJjNg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-kWG6VUqGNcauERNYzyMBkQ-1; Sat,
 18 Jan 2025 10:05:42 -0500
X-MC-Unique: kWG6VUqGNcauERNYzyMBkQ-1
X-Mimecast-MFC-AGG-ID: kWG6VUqGNcauERNYzyMBkQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EAA119560B1;
	Sat, 18 Jan 2025 15:05:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AFEAD195608A;
	Sat, 18 Jan 2025 15:05:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 18 Jan 2025 16:05:12 +0100 (CET)
Date: Sat, 18 Jan 2025 16:05:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org, andrii@kernel.org,
	jolsa@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com,
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com,
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de,
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Dmitry V. Levin" <ldv@strace.io>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250118150500.GB21464@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <20250117013927.GB2610@redhat.com>
 <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
 <20250117140924.GA21203@redhat.com>
 <CAEf4BzYhcG8waFMFoQS5dFWVkQGP6ed_0mwGTK4quN5+6-8XuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYhcG8waFMFoQS5dFWVkQGP6ed_0mwGTK4quN5+6-8XuA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/17, Andrii Nakryiko wrote:
>
> On Fri, Jan 17, 2025 at 6:10 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > We can, and this is what I tried to suggest from the very beginning.
> > But I agree with Eyal who decided to send the most trivial fix for
> > -stable, we can add the helper later.
> >
> > I don't think it should live in uprobes.h and I'd prefer something
> > like arch_seccomp_ignored(int) but I won't insist.
>
> yep, I think this is the way, keeping it as a general category. Should
> we also put rt_sigreturn there explicitly as well? Also, wouldn't it
> be better to have it as a non-arch-specific function for something
> like rt_sigreturn where defining it per each arch is cumbersome, and
> have the default implementation also call into an arch-specific
> function?

I personally don't think we should exclude rt_sigreturn. and I guess
we can't do it in a arch-agnostic way, think of __NR_ia32_sigreturn.

However. These are all good questions that need a separate discussion.
Plus the SECCOMP_RET_TRACE/strace issue raised by Dmitry. And probably
even more.

But IMO it would be better to push the trivial (and urgent) fix to
-stable first, then discuss the possible cleanups/improvements.

What do you think?

Oleg.


