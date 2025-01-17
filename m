Return-Path: <linux-api+bounces-3038-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BD6A147D1
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 02:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8211628EC
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 01:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504651E131B;
	Fri, 17 Jan 2025 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHxz0MRk"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8BD1E1041
	for <linux-api@vger.kernel.org>; Fri, 17 Jan 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737079096; cv=none; b=uPwVOZPP0dVUrNRHzIF6uWu5prXUZ9MnY29txmG+2JdwfXA/XyaYlxqYS5900GUTA22F0ajGy/XxbiuJpdGatRcXWNWtkLINpBlwnDNbdsT4ShDk1Uozz75KtpiIQ03lXc4UDPSvu2OktEMBKfFOLU263C6JG8ox95S/MTW3sqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737079096; c=relaxed/simple;
	bh=tZBMe7hsllXa6wEpfhptetZi+ORC3sZIaG466/S0AbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl0ebnaB+SmNwTh0OHRkogVXoUTSi42+/3j4UVSpPqKVxCe3i71GWusLC6vILbRA9Bx22SVt9bZQVWpncg6KkcOPzS9AkjFx7pZ9V5KY64UDyrhfuqpFQiwZP3liBzjzmYEIz0Xo4XiMsNlKunQtROnw7mQfaSF7jhjJkDKju+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHxz0MRk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737079093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mt8xw8B5mfo1deQgOjWMFb4U7SO5Mz5Ng06hHHQ+kB8=;
	b=CHxz0MRkT8GAn6BZgIrXhzndpXtVOlP77TG+aCzV+c4OGEjHbI9UpxWt0565/IMP53cT5I
	dEgPJv9H3LFZ5FsuXfIs9yHuemryPU2m8UWpYAaF63P6j5qNd5zBXNX2kTLXL1QiZuSDvP
	SLQ470fnBljlDJJpqbJLoxhbHvvlodI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-MxBZeht-NgOE2gnlLJC6kg-1; Thu,
 16 Jan 2025 20:58:08 -0500
X-MC-Unique: MxBZeht-NgOE2gnlLJC6kg-1
X-Mimecast-MFC-AGG-ID: MxBZeht-NgOE2gnlLJC6kg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D13D19560A1;
	Fri, 17 Jan 2025 01:58:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F15BF195608A;
	Fri, 17 Jan 2025 01:57:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 17 Jan 2025 02:57:39 +0100 (CET)
Date: Fri, 17 Jan 2025 02:57:30 +0100
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
Message-ID: <20250117015730.GC2610@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114190521.0b69a1af64cac41106101154@kernel.org>
 <20250114112106.GC19816@redhat.com>
 <Z4Zy6W6z3ICp6SdJ@krava>
 <20250117102307.cf919a0e7e59e3df0ddbcd3c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117102307.cf919a0e7e59e3df0ddbcd3c@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 01/17, Masami Hiramatsu wrote:
>
> On Tue, 14 Jan 2025 15:21:29 +0100
> Jiri Olsa <olsajiri@gmail.com> wrote:
>
> > On Tue, Jan 14, 2025 at 12:21:07PM +0100, Oleg Nesterov wrote:
> > >
> > > But please not that the uretprobed function can return any value
> > > including -ENOSYS, and this is what sys_uretprobe() has to return.
> >
> > right, uretprobe syscall returns value of the uretprobed function,
> > so we can't use any reserved value
>
> We can make uretprobe (entry) fail if the return value is one of
> errno or NULL, because it *knows* what the return value here.

I fail to understand... Could you spell please?

But whatever you meant, I don't think it is right, sorry.. please
correct me.

"it *knows*". Who it? How can it know??? I'd say "it" can't know,
but probably I missed your point.

Not to mention it doesn't really matter. It is not safe to even try
to do

	movq $__NR_uretprobe, %rax
	syscall

if the probed task has seccomp filters.

Oleg.


