Return-Path: <linux-api+bounces-2983-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266CBA104CF
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2025 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434D01617EB
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2025 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5B20F967;
	Tue, 14 Jan 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi5Qiu5C"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4DB20F965
	for <linux-api@vger.kernel.org>; Tue, 14 Jan 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852326; cv=none; b=JALxiqnxRa/PQa/kD+FN+xWS3v+E/2mSs3q6JIbOPKliSU7ykgiEkeAh9QETSGJ+GIkrAdlSQ68L+yzAVWa10fnEtxpFZfES0vLg/evl2QbyLGPGEPNRIiFPpxYnw4+A1gRkDGOJJRCndQNAAXEBLIRluiXmPpTWXASQjn6+SRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852326; c=relaxed/simple;
	bh=CDlN7XeLMc5wKHa78wNZH+/KCPVOOdmkQjekUXFSVeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+IA1SMa4YrhwdFfzzuMJVZf7T58tHtiBOZ8vRFWUvDieR4MipGCofCD7lC1NfVvdXDBAc622lHJmkWXOqhvVGq+LZ7jR8QTydc7BfCgLvuyde+sfjhRdhGIGxoH2RFs/Gn4iv+Pe9k6eVzEyxtDzU+pA1kkNO9xU64B2GSloiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fi5Qiu5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736852323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GKCT9kny4FnzLsqNvrdoNjDnV3GJ31A58ozcfY9C4G8=;
	b=Fi5Qiu5CWSykY2+3PLePkCDtjBPEWy2GjUrbs3IqfcykggIh0dkYMa/nc67HzaJeh9eJCn
	lVB3PcjNmS9y4rqTZtuHjJ2POfp8X2bPlQU+C87zO4UD0cDdLyKYhR71JDUEHKpHjP6CuS
	nVW+C2TvJ0Psa7q+RohqDXti8uRLnbc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-qVgEKAESOy-FAG9Od0Cnlg-1; Tue,
 14 Jan 2025 05:58:41 -0500
X-MC-Unique: qVgEKAESOy-FAG9Od0Cnlg-1
X-Mimecast-MFC-AGG-ID: qVgEKAESOy-FAG9Od0Cnlg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A828819560A2;
	Tue, 14 Jan 2025 10:58:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 44FBB30001BE;
	Tue, 14 Jan 2025 10:58:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 11:58:12 +0100 (CET)
Date: Tue, 14 Jan 2025 11:58:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Eyal Birger <eyal.birger@gmail.com>,
	mhiramat@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <20250114105802.GA19816@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4YszJfOvFEAaKjF@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/14, Jiri Olsa wrote:
>
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -315,14 +315,25 @@ asm (
>  	".global uretprobe_trampoline_entry\n"
>  	"uretprobe_trampoline_entry:\n"
>  	"pushq %rax\n"
> +	"pushq %rbx\n"
>  	"pushq %rcx\n"
>  	"pushq %r11\n"
> +	"movq $1, %rbx\n"
>  	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
>  	"syscall\n"
>  	".global uretprobe_syscall_check\n"
>  	"uretprobe_syscall_check:\n"
> +	"or %rbx,%rbx\n"
> +	"jz uretprobe_syscall_return\n"
>  	"popq %r11\n"
>  	"popq %rcx\n"
> +	"popq %rbx\n"
> +	"popq %rax\n"
> +	"int3\n"
> +	"uretprobe_syscall_return:\n"
> +	"popq %r11\n"
> +	"popq %rcx\n"
> +	"popq %rbx\n"

But why do we need to abuse %rbx? Can't uretprobe_trampoline_entry do

	syscall

// int3_section, in case sys_uretprobe() doesn't work
	popq %r11
	popq %rcx
	popq %rax
	int3

uretprobe_syscall_return:
	popq %r11
	popq %rcx
	popq %rbx
	retq

and change sys_uretprobe() to do

	- regs->ip = ip;
	+ regs->ip = ip + sizeof(int3_section);

?

Oleg.


