Return-Path: <linux-api+bounces-3046-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F0A152EB
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 16:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F4D164C15
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B71957FC;
	Fri, 17 Jan 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcppEW1y"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E811422A8
	for <linux-api@vger.kernel.org>; Fri, 17 Jan 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128017; cv=none; b=QgdVxnvuk1ICryHQf/fScGCOfae4bt4u5QFJj+HhRCCyjC67EtgBtl0Cyd4bQodtNFWEmi9fnoBWpHgJz6y7m9edqmsnneBwkzPCnqOeh40XyMTrhyqyqP03hA5uiqIxofbc93kF1qE18kIsX19NlP6ZzdRWyF+mfsBm+h7h0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128017; c=relaxed/simple;
	bh=quxGhZaBHuwTFjMvQtmzd6rxCuLrGvS8GeXc34oD13Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ69e+6mcZ572EDig3gzJeGAgvIAeirNlzkfQLclI/M3R2zcz3xLwCfKMkJVykw+yAFJZo+fC4nm0awAlUXfTCw10UNlxdQLmFxHHtjsVVInQuFeNsg10i0uf1VzMFLSxeHe+GdDWqtToiDmNmvizJW8uLMHP6kVJuShtzvCix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcppEW1y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737128014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=quxGhZaBHuwTFjMvQtmzd6rxCuLrGvS8GeXc34oD13Y=;
	b=KcppEW1yIrNnQHHIAdwT3npwU6zDTU6i/ZeCXBWPObT71b4V/aDimaSiYahSLqErj8hpxl
	isB28OHH7NXNM86iMJqBgq5y/SfWAN+2XQPmAeQjuSyTh5fROSoywELwZ6LO0TRddRTRHH
	TS4zOzgTod32FWLPVta3T30grZEVBH8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-6O5lg2L7PtaaNB9hG91bjQ-1; Fri,
 17 Jan 2025 10:33:30 -0500
X-MC-Unique: 6O5lg2L7PtaaNB9hG91bjQ-1
X-Mimecast-MFC-AGG-ID: 6O5lg2L7PtaaNB9hG91bjQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED64C1956056;
	Fri, 17 Jan 2025 15:33:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9325719560A3;
	Fri, 17 Jan 2025 15:33:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 17 Jan 2025 16:33:03 +0100 (CET)
Date: Fri, 17 Jan 2025 16:32:59 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250117153258.GC21203@redhat.com>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
 <20250117144556.GB21203@redhat.com>
 <20250117150627.GA15109@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117150627.GA15109@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Dmitry,

You certainly understand the user-space needs much better than me.
I am just trying to understand your point.

On 01/17, Dmitry V. Levin wrote:
>
> We should accept larger user_size from the very beginning, so that in case
> the structure grows in the future, the userspace that sicks to the current
> set of supported features would be still able to work with older kernels.

This is what I can't understand, perhaps I have a blind spot here ;)

Could you provide an example (even absolutely artificial) of possible extension
which can help me to understand?

> We cannot just use sizeof(info) because it depends on the alignment of
> __u64.

Hmm why? I thought that the kernel already depends on the "natural" alignment?
And if we can't, then PTRACE_SYSCALL_INFO_SIZE_VER0 added by this patch makes
no sense?

Sorry I guess I must have missed something, I am sick today.

> Also, I don't think we need to fill with zeroes the trailing
> padding bytes of the structure as we are not going to use them in any way.

At least we seem to agree here ;)

Oleg.


