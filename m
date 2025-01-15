Return-Path: <linux-api+bounces-3016-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4064A12B0E
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 19:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8643166943
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877401D5165;
	Wed, 15 Jan 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MvvBnS0A"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB264161321
	for <linux-api@vger.kernel.org>; Wed, 15 Jan 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966455; cv=none; b=ZpShm3mE7kN7ztpdZjguR9mrWI2Qko5TZHaumY79pw53iOqr8N0N16lHeeLSk2AscRwWNudEBE5XyJe3HuVCzX/rMurWjOstcdzhJQv9RrTrHOC6Cz2KmVXGtH8Yx7hmPzi0ihhPDTy8HRhcyL1fGUi29/fIfkDe9WQeIpcFTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966455; c=relaxed/simple;
	bh=ULYV6vPS38W6ety7Kx46JofgK8h7cFKQee0mLC8CXaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+maMyCkcePPVe7YhbuDeHflxgAN2B0C4w3BDu1FAj2JNjeoEJ5yp2B1G1oS+AANMPjle/1g4UGIhVCJG9/2PrXtrzApgwuxcrzOpD3Nzt77YjYNbF0FN5EwbrmFiVp6Q+wdJTLLrZEzG5CQzwhnSVuWguJDIoodXpcxIBql+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MvvBnS0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736966452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULYV6vPS38W6ety7Kx46JofgK8h7cFKQee0mLC8CXaw=;
	b=MvvBnS0ABTEly7jLHuTnE3g/TOmCII+FX+miRNxwFvgiYDIjLrjWaauvspGrS4U/FTYwex
	qatS8eVyjP1vFlYJlrv8lmo+6cPz6r5p3pk7wuY5gsZcktv8s4MpDMklaVPsK1TG++Of/j
	u9imXoGcInMxfsSSuNnswgppdFUwzBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-J7KBZUA8N2WRE87S8xnsbQ-1; Wed,
 15 Jan 2025 13:40:49 -0500
X-MC-Unique: J7KBZUA8N2WRE87S8xnsbQ-1
X-Mimecast-MFC-AGG-ID: J7KBZUA8N2WRE87S8xnsbQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F23961956083;
	Wed, 15 Jan 2025 18:40:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.35])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 23A7A19560AA;
	Wed, 15 Jan 2025 18:40:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 19:40:20 +0100 (CET)
Date: Wed, 15 Jan 2025 19:40:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250115184011.GA21801@redhat.com>
References: <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com>
 <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com>
 <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/15, Alexei Starovoitov wrote:
>
> On Wed, Jan 15, 2025 at 7:06 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Or we can change __secure_computing() to do nothing if
> > this_syscall == __NR_uretprobe.
>
> I think that's the best way forward.
> seccomp already allowlists sigreturn syscall.

Only if SECCOMP_MODE_STRICT. But it won't help if we add __NR_uretprobe
into into mode1_syscalls/mode1_syscalls_32.

SECCOMP_MODE_FILTER can do anything. Just I guess nobody tries to offend
sigreturn for obvious reasons.

But yes, perhaps we do not have a better solution.

Oleg.


