Return-Path: <linux-api+bounces-3081-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69D4A18121
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2025 16:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD54188BA3B
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CD61F4713;
	Tue, 21 Jan 2025 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO2wl5wd"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268ED1F4299
	for <linux-api@vger.kernel.org>; Tue, 21 Jan 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473375; cv=none; b=qe4dxcjzlYlt2G+70vqZOIXkZt9FXsNkJXp2UZCvqHH3wbCesp4tRnQImp9x612OJun77z27GcWFKBL1t9f/q/Uxld9qsbWjZVnPcNT0xSS2IgeHPutVSFBRzB1AgtSXpEWh1UYD8MiMmxG+gqXz2SuDbYDI604uNSehDgZHzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473375; c=relaxed/simple;
	bh=rRdlSEuIlKqdrfnuUR/QAUCw5t4cYuBzo0hVt20kNjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7s3W1yzB6B2msSFJcEv83DPVEV8MmrHOb5y0pcps1+IqgRqwcQy5L1eJfBRZoSAj8dF80lgRWyo1MUanKp875UgTWBtoc41shbqiUF7QYWcExttpBM5MX9S42QAZFMoDsbwDYHTBGtk4+JOvOAAFl8wPyxe8vHW0dneT3GMVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bO2wl5wd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737473373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nKhFItvInbGy3x2gDKCK0wEWBuvzDIeDEmci5k4cFk=;
	b=bO2wl5wd/AmxcHSDJk17m/cRHTkg/b/0WtoC6cEUuMVGxGTk1h7z8mwDcyabzdTc7mNzV5
	xVQC2lbHvfdIUxUs3QWp8QWUqYLrM3Odx95O0ZpYXnXuok3GZugwZjiIdUUb4f0wKC0Gq5
	GuJeTKVt82fAl7lbPo3CWmfofURvtsI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-nzKq0IOnPwqlDunPUEV6iQ-1; Tue,
 21 Jan 2025 10:29:28 -0500
X-MC-Unique: nzKq0IOnPwqlDunPUEV6iQ-1
X-Mimecast-MFC-AGG-ID: nzKq0IOnPwqlDunPUEV6iQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4225619560A3;
	Tue, 21 Jan 2025 15:29:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D03A61956094;
	Tue, 21 Jan 2025 15:29:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 21 Jan 2025 16:28:54 +0100 (CET)
Date: Tue, 21 Jan 2025 16:28:43 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>, luto@amacapital.net,
	wad@chromium.org, ldv@strace.io, mhiramat@kernel.org,
	andrii@kernel.org, jolsa@kernel.org, alexei.starovoitov@gmail.com,
	olsajiri@gmail.com, cyphar@cyphar.com, songliubraving@fb.com,
	yhs@fb.com, john.fastabend@gmail.com, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net,
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org,
	rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250121152843.GC3422@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <20250119123955.GA5281@redhat.com>
 <202501201331.83DB01794@keescook>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501201331.83DB01794@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/20, Kees Cook wrote:
>
> > The only difference is that sys_uretprobe() is new and existing setups
> > doesn't know about it. Suppose you have
> >
> > 	int func(void)
> > 	{
> > 		return 123;
> > 	}
> >
> > 	int main(void)
> > 	{
> > 		seccomp(SECCOMP_SET_MODE_STRICT, 0,0);
> > 		for (;;)
> > 			func();
> > 	}
> >
> > and it runs with func() uretprobed.
> >
> > If you install the new kernel, this application will crash immediately.
> >
> > I understand your objections, but what do you think we can do instead?
> > I don't think a new "try_to_speedup_uretprobes_at_your_own_risk" sysctl
> > makes sense, it will be almost never enabled...
>
> This seems like a uretprobes design problem. If it's going to use
> syscalls, it must take things like seccomp into account.

True. I reviewed that patch, and I forgot about seccomp too.

> SECCOMP_SET_MODE_STRICT will also crash in the face of syscall_restart...

Yes, I guess SECCOMP_SET_MODE_STRICT assumes that read/write can't return
ERESTART_RESTARTBLOCK.

But again, what can we do right now?

I do not like the idea to revert the patch which adds sys_uretprobe().
Don't get me wrong, I do not use uprobes, so personally I don't really
care about the performance improvements it adds. Not to mention FRED,
although I have no idea when it will be available.

Lets forget about sys_uretprobe(). Lets suppose the kernel doesn't have
ERESTART_RESTARTBLOCK/sys_restart_syscall and we want to add this feature
today.

How do you think we can do this without breaking the existing setups which
use seccomp ?

Oleg.


