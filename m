Return-Path: <linux-api+bounces-1243-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58289C981
	for <lists+linux-api@lfdr.de>; Mon,  8 Apr 2024 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766F7B24AAA
	for <lists+linux-api@lfdr.de>; Mon,  8 Apr 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB51C1422D9;
	Mon,  8 Apr 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRRyJiAS"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21737D40E
	for <linux-api@vger.kernel.org>; Mon,  8 Apr 2024 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593480; cv=none; b=UrS4vvVuJ1R3mSi3gmoc+tx0TManvU5unXkhTN2x3eU9ZRB850FN4F0YBmQidySzJUlYBfKLnlHflot/nh9sjHjFlCbeZjEo7ymh7s2KPtfSV2JaA65M2lR0w2pR4qqIbrjZ4+TsLbgbEDHbdB877N2n9d1/o2pfhJr4OcjbITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593480; c=relaxed/simple;
	bh=6NRTUPWf9ZckeTf7WPy0hIku+8O5n7NUx2nXUXIzsaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avPlAU0JmSBevEk2yuZqu0KVSTSJCghpcnW9os37fWsrN68ky2KIMnNIzk6TvCQ2juQYuFXM+5wHmYKrEDw04N6XKC6Xr2gUvh/9uaBzVC1dE66Y1oYAYX8TcmQXT6+Dg2Qg+JxWrL3QmO+MJYsb4Hl7k+6udcMh5uwer+MEWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRRyJiAS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712593477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E5neF0ydYd9cA1bevZzf7K+VGoZTfl5uVcOrP5Gq8CQ=;
	b=KRRyJiASYq5rDzYCETZNY8kCAad+KtgQzAdxrjjB44Ya4Fy4SRea8D6MVYqZEHM9WfW+gB
	dCAHS39+bk5C0U14Iu5OiWWqGskONcqfwrh/hoZOaXFRWKQhwxxtmJIjv8Kj4QUtjX56XT
	lG0C+yNwzSc8LUXl/CkCJXf3Ar66BFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-3OhbNXdPOOqOD_zgQDw3sA-1; Mon, 08 Apr 2024 12:24:34 -0400
X-MC-Unique: 3OhbNXdPOOqOD_zgQDw3sA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 807C180021A;
	Mon,  8 Apr 2024 16:24:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.180])
	by smtp.corp.redhat.com (Postfix) with SMTP id 959671C06667;
	Mon,  8 Apr 2024 16:24:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  8 Apr 2024 18:23:08 +0200 (CEST)
Date: Mon, 8 Apr 2024 18:22:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <20240408162258.GC25058@redhat.com>
References: <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
 <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
 <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
 <20240404161108.GG7153@redhat.com>
 <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
 <Zg-8r63tPSkuhN7p@krava>
 <20240405110230.GA22839@redhat.com>
 <ZhQVBYQYr5ph33Uu@krava>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQVBYQYr5ph33Uu@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 04/08, Jiri Olsa wrote:
>
> On Fri, Apr 05, 2024 at 01:02:30PM +0200, Oleg Nesterov wrote:
> >
> > And what should sys_uretprobe() do if it is not called from the trampoline?
> > I'd prefer force_sig(SIGILL) to punish the abuser ;) OK, OK, EINVAL.
>
> so the similar behaviour with int3 ends up with immediate SIGTRAP
> and not invoking pending uretprobe consumers, like:
>
>   - setup uretprobe for foo
>   - foo() {
>       executes int 3 -> sends SIGTRAP
>     }
>
> because the int3 handler checks if it got executed from the uretprobe's
> trampoline.

... or the task has uprobe at this address

> if not it treats that int3 as regular trap

Yes this mimics the "default" behaviour without uprobes/uretprobes

> so I think we should mimic int3 behaviour and:
>
>   - setup uretprobe for foo
>   - foo() {
>      uretprobe_syscall -> check if we got executed from uretprobe's
>      trampoline and send SIGILL if that's not the case

Agreed,

> I think it's better to have the offending process killed right away,
> rather than having more undefined behaviour, waiting for final 'ret'
> instruction that jumps to uretprobe trampoline and causes SIGILL

Agreed. In fact I think it should be also killed if copy_to/from_user()
fails by the same reason.

Oleg.


