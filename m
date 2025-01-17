Return-Path: <linux-api+bounces-3037-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31CA147A4
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 02:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9133B16BC2E
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48786337;
	Fri, 17 Jan 2025 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sf91Gs+C"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6DB7083A
	for <linux-api@vger.kernel.org>; Fri, 17 Jan 2025 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078016; cv=none; b=fo1kiPrlX1ymPNUDzoW7o28kXtEtv+OKqOrC7LRIf3ML8yrRYf+1kccqJDGCWOkopY6uHn4Zkwc74EijkGc/nTuQ1OlKczAIxnL2k+PZ7OfiU2nUGcqYllZNj5JggVSdtQ5V9dRH8x5OgMQtBat/qvcIy17Mtm7wSE6Da4+dJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078016; c=relaxed/simple;
	bh=TKJzr0OhYmz+MamxDkfKOjlqzLok1X/zkroGwhHT/q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So7aCcGYsG+k2FZqIoUTiz8ZUOfFlPwf+rwyI8VUS/SD+EPaYpIVwiX/+RHwfhPlLvrrQO89hBtcsyELtZM+KabOiX0psoD98diomtc763KZsOW31U3FELGPbRGqWLQ75so1fbBRWpFdAm6dx11k9DN6mojPQ4RH/NWmGiwXudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sf91Gs+C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737078014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQy/sgLNUMS5fRTHYjN4T8wUXZQCjsvCjzoYC0ySohE=;
	b=Sf91Gs+ClwRaauXFnIEqIcqxaptkD5ByzeixeG/QVMZreNdLjYbfFzq/e9aYl2AxQisy0s
	eZnFMRpG7JTggnRwfApwFmAbn+M41kmekceh1qFqJhuLUMY2TGq5J+4SPyeO3usCi5ZyMX
	J7nm3MMbbQcyJCBP+XwQzEEbzhYqAzA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-gQ6bp8kSPHCE_E90amJsbw-1; Thu,
 16 Jan 2025 20:40:07 -0500
X-MC-Unique: gQ6bp8kSPHCE_E90amJsbw-1
X-Mimecast-MFC-AGG-ID: gQ6bp8kSPHCE_E90amJsbw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7A9F1955DC9;
	Fri, 17 Jan 2025 01:40:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6402519560A3;
	Fri, 17 Jan 2025 01:39:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 17 Jan 2025 02:39:38 +0100 (CET)
Date: Fri, 17 Jan 2025 02:39:28 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250117013927.GB2610@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117005539.325887-1-eyal.birger@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/16, Eyal Birger wrote:
>
> Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> Reported-by: Rafael Buchbinder <rafi@rbk.io>
> Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com/
> Cc: stable@vger.kernel.org
...
> @@ -1359,6 +1359,11 @@ int __secure_computing(const struct seccomp_data *sd)
>  	this_syscall = sd ? sd->nr :
>  		syscall_get_nr(current, current_pt_regs());
>
> +#ifdef CONFIG_X86_64
> +	if (unlikely(this_syscall == __NR_uretprobe) && !in_ia32_syscall())
> +		return 0;
> +#endif

Acked-by: Oleg Nesterov <oleg@redhat.com>


A note for the seccomp maintainers...

I don't know what do you think, but I agree in advance that the very fact this
patch adds "#ifdef CONFIG_X86_64" into __secure_computing() doesn't look nice.

The problem is that we need a simple patch for -stable which fixes the real
problem. We can cleanup this logic later, I think.

Oleg.


