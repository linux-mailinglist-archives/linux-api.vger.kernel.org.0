Return-Path: <linux-api+bounces-3110-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FDA23146
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2025 16:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479ED3A6B4E
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2025 15:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CAF1E9B03;
	Thu, 30 Jan 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcGZ36uK"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D01E1C22
	for <linux-api@vger.kernel.org>; Thu, 30 Jan 2025 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252673; cv=none; b=On/MgktDkmBCRtnw2q9wD8zOA+NainZlzI9on/wJuXrRIQR9L0QwhjcGwnTz2EbpOKZey7LcuudaX9xvqB2qBmxGp0NsltOsAu7/tX21Gy9HeiRStAMAylmxmJwg49/pFlrkhCa3fx9sB5nzrPLoUrpA6O6ZHvcBxdO/9+UInPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252673; c=relaxed/simple;
	bh=ZkXlZnXCEZfUvPemo0Bdv/SbSJ+SxapGl1P5igcP9F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrDe0b7f8iAd+Gn/7PhvmRdN7fhhOnDjYhcE5+gS0GbUXrZH/JYf2VDQSvthAg1PzvqWUzhcq2G1CEFLMuXENmyuizK5ovknwhjLvUucjgWfZwQYXYpJklqVpgDbdF5JNiptpldrX7JNZ2yBASqqduMxILoMv7F8IytZU+ReQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcGZ36uK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738252671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkXlZnXCEZfUvPemo0Bdv/SbSJ+SxapGl1P5igcP9F8=;
	b=gcGZ36uK5+/2YIb5vBn6aomckKvsRH90KXz8F7xBKFbazjulB4ctYIWT1QqYKxeb7F1o7B
	43oppLokhut41v90ATvM5MfSyXlUGP/F1wV1Q/Tkl3H6a7JMLP5nne3y/EQ8DSgYUEAnE1
	XNmROz9fWDBwiDSNFNaaBVXsNydGaT0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-MkvLibgYMx2BoPEK3NL3kA-1; Thu,
 30 Jan 2025 10:57:49 -0500
X-MC-Unique: MkvLibgYMx2BoPEK3NL3kA-1
X-Mimecast-MFC-AGG-ID: MkvLibgYMx2BoPEK3NL3kA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C15C21956052;
	Thu, 30 Jan 2025 15:57:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.195])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 96735180094D;
	Thu, 30 Jan 2025 15:57:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Jan 2025 16:57:19 +0100 (CET)
Date: Thu, 30 Jan 2025 16:57:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
	luto@amacapital.net, wad@chromium.org, mhiramat@kernel.org,
	andrii@kernel.org, alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250130155708.GD18488@redhat.com>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook>
 <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
 <Z5s3S5X8FYJDAHfR@krava>
 <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 01/30, Eyal Birger wrote:
>
> Personally I'd prefer to limit the scope of this fix to the problem we
> are aware of, and not possible problems should someone decide to reimplement
> uretprobes on different archs in a different way. Especially as this fix needs
> to be backmerged to stable kernels.

+1

Oleg.


