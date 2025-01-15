Return-Path: <linux-api+bounces-3009-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39278A126DF
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 16:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A7A1885A60
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972A86354;
	Wed, 15 Jan 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmEp0ivl"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6120326
	for <linux-api@vger.kernel.org>; Wed, 15 Jan 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953612; cv=none; b=GDonr6xJG3vNdJh4tf3tbgawd4fGZlyd0GTQfdG7QRylAeJH3BEzzz7O61lnnTLryvUzOD3A7re2SZPhJGORiXb0LRkJs9hb1XCiK8W3XALtgbpmdN2H5GnSx3JutzH5O4rpQOPqzJZeuDUshiv6hkWEkkX5pF0Gu+tyxWxTRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953612; c=relaxed/simple;
	bh=ruXm3GwWSRO7cfPH2em1+ggx/3wul5ki73+B7i4Ubjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMjm1VHAJIqF/ZFwDYyaPEGX17YfoS/3g21QiCw4Xc+5APUhxYw3r1jmqE3w0l/C0gJ1ATzQ+p3qmgRLzSZOZKc1dGpiJWTJLcB+nQybQio3R71Ap0DubcMTCEFtTuCt8J88Zi6DkPw3xk0rWXnLQB0MdG8X3J22eXLLQ7IDYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmEp0ivl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736953609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3r2M9S+yWLkHCYFD8BRRAu7UcanN7f8eRTtVxwZV0g=;
	b=EmEp0ivlQBZ0xYNEOJvFDnLQhuUQy6VTZp6PTxsgyWWpbxWHTKo2A+T3MpFGoh4/WnZO7K
	ZWePbR4gPJMF0FQdsw/NaYz7p3kF9MrNC0ruuBvEBMYCnifpUuQjtsYW6yKhuQ/Hlrr9wZ
	70UJ18vuLgAx/PjySJYOiSXVvfHPye0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-vsNLaPoUNp2-nLJGDYdKvQ-1; Wed,
 15 Jan 2025 10:06:45 -0500
X-MC-Unique: vsNLaPoUNp2-nLJGDYdKvQ-1
X-Mimecast-MFC-AGG-ID: vsNLaPoUNp2-nLJGDYdKvQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 957CF19560B1;
	Wed, 15 Jan 2025 15:06:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AA29319560A3;
	Wed, 15 Jan 2025 15:06:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 16:06:17 +0100 (CET)
Date: Wed, 15 Jan 2025 16:06:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
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
Message-ID: <20250115150607.GA11980@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com>
 <Z4eBs0-kJ3iVZjXL@krava>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4eBs0-kJ3iVZjXL@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/15, Jiri Olsa wrote:
>
> On Tue, Jan 14, 2025 at 06:25:20PM +0100, Oleg Nesterov wrote:
> >
> > Sorry, I don't understand... What exactly we can do? Aside from checking
> > IS_ENABLED(CONFIG_SECCOMP) in arch_uprobe_trampoline() ?
>
> I need to check more on seccomp, but I imagine we could do following:
>   - when seccomp filter is installed we could check uprobe trampoline
>     and if it's already installed we change it to int3 trampoline
>   - when uprobe trampoline is getting installed we check if there's
>     seccomp filter installed for task and we use int3 trampoline

I still don't understand... But whatever you meant, I doubt it can work.

> other than that I guess we will have to add sysctl to enable uretprobe
> trampoline..

Or we can change __secure_computing() to do nothing if
this_syscall == __NR_uretprobe. Or even change syscall_trace_enter/exit
to do this check.

But I don't really like this idea, I don't feel this is the right solution...

Oleg.


