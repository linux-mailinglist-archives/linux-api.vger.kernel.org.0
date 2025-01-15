Return-Path: <linux-api+bounces-3018-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9567AA12B6F
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 20:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312863A071D
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488151D86FF;
	Wed, 15 Jan 2025 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDNrUGFH"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A31D7998
	for <linux-api@vger.kernel.org>; Wed, 15 Jan 2025 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967833; cv=none; b=OWArTQP28GvQUyBpTpY8iyn4PKVI4RYzGNgZK6vUAhPyYit6UFSIUy5ehLYJCziMOpyYW+yK20SP4882OE/6Wk2KO5BU8/cPSxz75l9zHmjdUZKaDs4ooB+ZAhmxA0c94C8goAW7IoZ+beeHTn+eFPLv+ZTTGsrY7nWD8ZQ0mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967833; c=relaxed/simple;
	bh=BBKSHK8KSd2buL5pbJ8xO8WsCp7GYMHvslpO2KIaoQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meMtSDDZ+M+hW4swtMsCeJAUI6vnJXvVN9yw3ksHIaoRhPHLc/2fRnc7FMR+vgb20gXGADcjb9A4nwKDYvTNWFKAnGbEuOXKasYPB+naLqyd6pulkgQZmVr0PpGaB8p+cx0JKFUSfMF4YikXbzRf2Z7YOcL2sD9IyB+2BY/ZOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDNrUGFH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736967830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qYYRC3Sr2G9O7qD5vlzHOVTE1CaKcq2wNHa/9Za5ETQ=;
	b=HDNrUGFHZzFlj39x8aQKeyUPUD8Omwf/AG90tZP890TeZCtXCjtlggf+mZidRhSC0KDLvd
	XHJOYXrfDyk9tc3QdS+o7bZEjyMfHWsqpOetD4lpG337j1c8O5OUYsE3CdBY++oZCzVVBF
	e65M8MxhJPQueUlvxriLYksXN1Yx5I4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-04Pu3tqpMdy-5dpiPsJY7Q-1; Wed,
 15 Jan 2025 14:03:43 -0500
X-MC-Unique: 04Pu3tqpMdy-5dpiPsJY7Q-1
X-Mimecast-MFC-AGG-ID: 04Pu3tqpMdy-5dpiPsJY7Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DBC41956073;
	Wed, 15 Jan 2025 19:03:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.35])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B51A619560A3;
	Wed, 15 Jan 2025 19:03:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 20:03:14 +0100 (CET)
Date: Wed, 15 Jan 2025 20:03:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
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
Message-ID: <20250115190304.GB21801@redhat.com>
References: <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com>
 <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com>
 <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com>
 <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/15, Eyal Birger wrote:
>
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1359,6 +1359,9 @@ int __secure_computing(const struct seccomp_data *sd)
>         this_syscall = sd ? sd->nr :
>                 syscall_get_nr(current, current_pt_regs());
>
> +       if (this_syscall == __NR_uretprobe)
> +               return 0;
> +

Yes, this is what I meant. But we need the new arch-dependent helper.

Oleg.


