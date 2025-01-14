Return-Path: <linux-api+bounces-2985-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1A6A10536
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2025 12:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BACD162058
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2025 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488F231C9A;
	Tue, 14 Jan 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWgxlCQu"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC452500DE
	for <linux-api@vger.kernel.org>; Tue, 14 Jan 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736853714; cv=none; b=o0yFilVdxhcVCCK2H+nKp0Yh5TIJ8JL2SwSX3TYh2r/M4GBXXk2OUlME7FxvnouJSeu4ObUhvXvLhcnkx48CvekYU8BwtxkoCQi7FDOS4StlsKr56r3h3FmB+G0LUllEcxW/Wd+yO5a/DoFtImK2ENztpDWoK47u5y83NtRaS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736853714; c=relaxed/simple;
	bh=5JFAfkPR+Ike3FMmbmMZs5Ka5jUJg7zx9lp5Nr+ajQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EscD9cbvEwh2MXJYaD8pxHh29S29UYPZO5XhvjDojZh/cUdyaABlKCX9zg0merohptbx/XeJJPL3LRolcAq0MIXUyoWfhGDL6dC1GwODKi5ZblvPmJ0+xWKtrZHAjEQ923l5XyeTh0p+85XjqoygH6woenUjOVuok7fj94WXYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWgxlCQu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736853711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gKIV4YzdGrCw0FjbYvth1lwU1z2n2sZ8xFygOnMWM/Q=;
	b=iWgxlCQui7p8H+QLBZiT4TZ9Jx+EMxnBhgaxk8PVORHrf9BpH5hKIXLgcIVP8kNOyFVJdh
	plIUcrhNysdReJEPXlq7NTwev8ZpQNDI+eqW5tHgb3v4Ay8HMVpw43TCW9Vru8Fhodj0EY
	UB/E/uWHQAY0vFPr5giFOP8BEeQapvk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-MOulm-YXPBixk34LJI9Atw-1; Tue,
 14 Jan 2025 06:21:44 -0500
X-MC-Unique: MOulm-YXPBixk34LJI9Atw-1
X-Mimecast-MFC-AGG-ID: MOulm-YXPBixk34LJI9Atw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3656D195605E;
	Tue, 14 Jan 2025 11:21:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C67BB3003FD1;
	Tue, 14 Jan 2025 11:21:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 12:21:16 +0100 (CET)
Date: Tue, 14 Jan 2025 12:21:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250114112106.GC19816@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114190521.0b69a1af64cac41106101154@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114190521.0b69a1af64cac41106101154@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/14, Masami Hiramatsu wrote:
>
> On Tue, 14 Jan 2025 10:22:20 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
>
> > @@ -418,6 +439,9 @@ SYSCALL_DEFINE0(uretprobe)
> >  	regs->r11 = regs->flags;
> >  	regs->cx  = regs->ip;
> >
> > +	/* zero rbx to signal trampoline that uretprobe syscall was executed */
> > +	regs->bx  = 0;
>
> Can we just return -ENOSYS as like as other syscall instead of
> using rbx as a side channel?
> We can carefully check the return address is not -ERRNO when set up
> and reserve the -ENOSYS for this use case.

Not sure I understand...

But please not that the uretprobed function can return any value
including -ENOSYS, and this is what sys_uretprobe() has to return.

Oleg.


