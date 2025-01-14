Return-Path: <linux-api+bounces-2997-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFFA11236
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2025 21:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1392A1629BB
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2025 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212E20C47A;
	Tue, 14 Jan 2025 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fc78tHn9"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17E1FF5E9
	for <linux-api@vger.kernel.org>; Tue, 14 Jan 2025 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887207; cv=none; b=aniDu5rNha8Ni0Q5TO3MlUVV5LLrhCGfw+cyDW9hKGGQPUenYOgIeO5a52grM1XQQGBsGOiSoiEliZbpEM1f3W9k5grMDIgL9VlUp6dDFq88hfNMeXgdlOZKIedQq1xvZtfT8pYTemnT3Waf/lKzxJrb5d14GYGWppYH09uV6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887207; c=relaxed/simple;
	bh=iGtvFc/Jy4BJY0LRoDaVaXzDrDXFuoFF7wBMz6Gftpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uStp75XrYAnKQwNWWuuE/4OBH4+YvGMYTVUl574qAIBgNZUtKJYnMX9/Q+1HXE4mAAMcLV3ksFY/Oo5GrcpjYoTMxyk1O2dZ8kxd4Kx7iDe54YWWtnOu7uXSWhR0L6k3305rb1bQfCl+UzhZRqmjWT77n5a7VHlMrkF9faJes7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fc78tHn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736887205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iGtvFc/Jy4BJY0LRoDaVaXzDrDXFuoFF7wBMz6Gftpg=;
	b=Fc78tHn99GLhzsoZWYej40K6cIIaG46CzcMl+9xt1AVelq9aRt/Bb2J6cr0aj4rPtdNaWF
	tzu5zrH3K7l64HXiqHOfauHFDExcZMxDiSzwajETKXBfKJEJvQb/59EQytRdLYTW57/sLG
	dUi0cori0AwFtlecMs3KTG9aruZt9aw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-8PfkFcqLMTezb9LkqFK0JQ-1; Tue,
 14 Jan 2025 15:40:00 -0500
X-MC-Unique: 8PfkFcqLMTezb9LkqFK0JQ-1
X-Mimecast-MFC-AGG-ID: 8PfkFcqLMTezb9LkqFK0JQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D77FD19560B3;
	Tue, 14 Jan 2025 20:39:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EC0A919560AA;
	Tue, 14 Jan 2025 20:39:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 21:39:31 +0100 (CET)
Date: Tue, 14 Jan 2025 21:39:22 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Eyal Birger <eyal.birger@gmail.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250114203922.GA5051@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <20250114105802.GA19816@redhat.com>
 <Z4ZyYudZSD92DPiF@krava>
 <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZoa6gBQzfPLeMTQu+s=GqVdmihFdb1BHkcPPQMFQp+MQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/14, Andrii Nakryiko wrote:
>
> Should we just fix whoever is blocking kernel-internal special syscall
> (sys_uretprobe)?

Well, we can add __NR_uretprobe to mode1_syscalls[] but this won't
really help.

We can't "fix" the existing user-space setups which can nack any
"unnecessary/unknown" syscall.

> What would happen if someone blocked that other
> special kernel-internal syscall for signal handling (can't remember
> the name,

sys_rt_sigreturn().

Yes, the task will crash after return from the signal handler if this
syscall is filtered out.

But, unlike sys_uretprobe(), sys_rt_sigreturn() is old, so the existing
setups must know that sigreturn() should be respected...

Oleg.


