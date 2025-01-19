Return-Path: <linux-api+bounces-3063-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72593A161AB
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2025 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42C73A1455
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2025 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15B1DED4B;
	Sun, 19 Jan 2025 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCRoIb6S"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887BF1DE8A3
	for <linux-api@vger.kernel.org>; Sun, 19 Jan 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737290473; cv=none; b=MlOH5yupOfqw5/ps2rlEOMm4i2N0trEvXavogWl7fWLZ0NggcT+Knr8FDVhUhWUXjbHEwedkeojrK6/Y8+KH4kDq1VCuXo4hJf9tZPRkWDnZNR8BffhHUHhGRWmmMN6XMfpdAcRCt1IBb/DGCHZONpbhWcZPRKrsf9in4Tel/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737290473; c=relaxed/simple;
	bh=cepSb96XivIm4eGLRHvebHTN7tOx/koTTYcOdbP/DVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA+bCL5fw6totuYWMZlpr0YrYtGBR40ZXtICNkbeLJz317R8T0T8SYLvG9ZsuE772DpM0aHjDj/+5mcDuoIhKEdrBOnoO/PRjuZxmBlphZ5ap60LTWsZQVNYnuVvbu0qnimrWmy4EDOzN3ygqtAja51JT69nK5JvBTUw8jXTsu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCRoIb6S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737290470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+FKBoNA/hVYLdo6ACZeCZuwo39tM3fO2b0asISNi1o=;
	b=XCRoIb6S9H/UqRUg/wWW8L5SuvTVh6Zcs2Q7sSTeJFFseB6YmCaCZ6d3xIl9wn5E6vKCA6
	tI0qoguEoNd9ABBBi8NAHXRHe/NME2uoFM+v82X+S+SHNgvNaBsNfcVb/z1yUu7TX/VhF1
	c+uNI7UJITgVP5MNykfjLEBc04PZDek=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-tU4GYsWfMCWsMNlvD76xTQ-1; Sun,
 19 Jan 2025 07:41:03 -0500
X-MC-Unique: tU4GYsWfMCWsMNlvD76xTQ-1
X-Mimecast-MFC-AGG-ID: tU4GYsWfMCWsMNlvD76xTQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81E4819560AA;
	Sun, 19 Jan 2025 12:40:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5C4711955F10;
	Sun, 19 Jan 2025 12:40:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 19 Jan 2025 13:40:33 +0100 (CET)
Date: Sun, 19 Jan 2025 13:40:22 +0100
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
Message-ID: <20250119123955.GA5281@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501181212.4C515DA02@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 01/18, Kees Cook wrote:
>
> On Thu, Jan 16, 2025 at 04:55:39PM -0800, Eyal Birger wrote:
> > Since uretprobe is a "kernel implementation detail" system call which is
> > not used by userspace application code directly, it is impractical and
> > there's very little point in forcing all userspace applications to
> > explicitly allow it in order to avoid crashing tracked processes.
>
> How is this any different from sigreturn, rt_sigreturn, or
> restart_syscall? These are all handled explicitly by userspace filters
> already, and I don't see why uretprobe should be any different.

The only difference is that sys_uretprobe() is new and existing setups
doesn't know about it. Suppose you have

	int func(void)
	{
		return 123;
	}

	int main(void)
	{
		seccomp(SECCOMP_SET_MODE_STRICT, 0,0);
		for (;;)
			func();
	}

and it runs with func() uretprobed.

If you install the new kernel, this application will crash immediately.

I understand your objections, but what do you think we can do instead?
I don't think a new "try_to_speedup_uretprobes_at_your_own_risk" sysctl
makes sense, it will be almost never enabled...

Oleg.


