Return-Path: <linux-api+bounces-3083-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E810A18233
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2025 17:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFBB3AB31E
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA9618872A;
	Tue, 21 Jan 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxjHp6F2"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076072E822
	for <linux-api@vger.kernel.org>; Tue, 21 Jan 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477924; cv=none; b=M+QiUuOnTRr6fBFvYlzwbc9T7MMV77yT9mdCDFheL+6iT/S+dl+01X3EJzS9OI8MAAdvPGx9qcu9tNKoyQym4ez4sA26S7Klh8zoLa0lziVKCDMS+E/BeYonoE8bCuO0O9eYPc+WRGBRsDif79yGYxpdMhr4HrQc7lTMKJwuqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477924; c=relaxed/simple;
	bh=XO/Ymj0ibVxkJr0ihO0VzEhAo9m9O2dsS+oq11HBXQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p80DoZwoVbWIYTOyNomBy4G/h5mnjffNVE4TISNvT/GyU3Kul78rfK0RMiCISzOGiVyjvoi3+YliSVfP+1ilEp/V1H4JPWb3W/M+BTU5Dp9BmNCOJbcznpeHB/rIrPtHjoE1B5C7WAnyikKSVcidLHBGZlczSRJeobt7Ts4/piI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxjHp6F2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737477921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLVsHBbZSrA/NKOjlCOjlNdrdUsp4BXx8cgZinvUkW0=;
	b=fxjHp6F2DG5aD28JnvEWrVauFPvuPbvosa73R/POdyHgTe3frN7yr/Z2PK1AOQdawJWqhA
	Ykk1nm5VgkUtOCQZKHHlKnVWUl16VbeFIda9tJytW6bTrl/s4jptn2MrAdwJdojNZILmu9
	ehNa8Q9AU2xiwflOKJ2R35q0la7/Ln4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-sO44-CrMMTaemhFpBg_rog-1; Tue,
 21 Jan 2025 11:45:17 -0500
X-MC-Unique: sO44-CrMMTaemhFpBg_rog-1
X-Mimecast-MFC-AGG-ID: sO44-CrMMTaemhFpBg_rog
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 403171956066;
	Tue, 21 Jan 2025 16:45:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 11A5019560A7;
	Tue, 21 Jan 2025 16:45:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 21 Jan 2025 17:44:46 +0100 (CET)
Date: Tue, 21 Jan 2025 17:44:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Eyal Birger <eyal.birger@gmail.com>,
	Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org,
	ldv@strace.io, mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rafi@rbk.io, shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250121164435.GA17215@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook>
 <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
 <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <Z4-xeFH0Mgo3llga@krava>
 <20250121111631.6e830edd@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121111631.6e830edd@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/21, Steven Rostedt wrote:
>
> I think this may have been mentioned, but is there a way that the kernel
> could know that this system call is being monitored by seccomp, and if so,
> just stick with the interrupt version? If not, enable the system call?

Consider

	int func_to_uretprobe()
	{
		seccomp(SECCOMP_SET_MODE_STRICT/whatever);
		return 123;
	}

by the time it is called, the kernel can't know that this function will
call seccomp/install-the-filters/etc, so prepare_uretprobe() can't know
if it is safe to use uretprobe or not.

Oleg.


