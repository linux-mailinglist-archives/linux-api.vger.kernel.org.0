Return-Path: <linux-api+bounces-3012-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C388A128E0
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 17:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD05B18870F6
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 16:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14799160799;
	Wed, 15 Jan 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8XTz2wt"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B81553BB
	for <linux-api@vger.kernel.org>; Wed, 15 Jan 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959126; cv=none; b=DufciLSqOBIwFZAWZJAL4uCsdxGZoN8YQFbd4j5E81NrNcQIVL23LivhuRfj5TfjrzA0CMuPrm9+SjE15Mk+mJQ2uWCZbdY0AWcJw+GviEf8xH7R05Usg9JgUBCJin6ej7qpMdGwsi2fAfGCT+9EXy/cEXDtyQ2V0qbLYphMtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959126; c=relaxed/simple;
	bh=WhTPuMtPUGlEUfb47H351mVC8OQPPJnO2AflZxxVxoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2Mew+2WueO3qeUAP5Y4UNwYeg444716z0nd0GYPvEy0lyeqRhX7seXP4JOaU0Ng7YyxNKDiHqpdSSsoQOY7bovdSC6U3EbQpJy3h7YLqbK/va9HmCGH06Nv0Ll/Ix642LqkxZpK6A/L7c9LFr1R1QdlNgRo65DKGFlcyGeJBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8XTz2wt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736959122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERPyuR9xk9MAs0lvW+jsCztNMlwAElOZ9fxL6fdKsBY=;
	b=U8XTz2wtQB0NdxFP+LPp51sigFe2B2f9rPOUrIrQRvxv6mAKZKmFz3qjdL6luI96wWIumX
	sV1MGY5aL3B9jzP3eYCY83JBXctGJik+Op7nDC7gdNZMHB4hDjkaQY+h/a8QGEZRTO29YL
	+r0n2OXhhNozw3tb42BLj+Y3JDNphlM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-r8i9OhHvMmGonxnPsTIjPA-1; Wed,
 15 Jan 2025 11:38:41 -0500
X-MC-Unique: r8i9OhHvMmGonxnPsTIjPA-1
X-Mimecast-MFC-AGG-ID: r8i9OhHvMmGonxnPsTIjPA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94BB1955F69;
	Wed, 15 Jan 2025 16:38:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E652E19560AB;
	Wed, 15 Jan 2025 16:38:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 17:38:14 +0100 (CET)
Date: Wed, 15 Jan 2025 17:38:09 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250115163809.GC11980@redhat.com>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113171208.GF589@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Dmitry,

I can't review the non-x86 changes in 1/7 - 4/7.

As for this and the previous patch I see nothing bad after a quick glance.

Just I have some concerns about the "future extensions", I'll write another
email tomorrow. In particualar, I personally hate the very idea of
copy_struct_from_user/check_zeroed_user ;)

On 01/13, Dmitry V. Levin wrote:
>
> +ptrace_set_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
> +			      struct ptrace_syscall_info *info)
> +{
> +	unsigned long args[ARRAY_SIZE(info->entry.args)];
> +	int nr = info->entry.nr;
> +	int i;
> +
> +	if (nr != info->entry.nr)
> +		return -ERANGE;
> +
> +	for (i = 0; i < ARRAY_SIZE(args); i++) {
> +		args[i] = info->entry.args[i];
> +		if (args[i] != info->entry.args[i])
> +			return -ERANGE;
> +	}
> +
> +	syscall_set_nr(child, regs, nr);
> +	/*
> +	 * If the syscall number is set to -1, setting syscall arguments is not
> +	 * just pointless, it would also clobber the syscall return value on
> +	 * those architectures that share the same register both for the first
> +	 * argument of syscall and its return value.
> +	 */
> +	if (nr != -1)
> +		syscall_set_arguments(child, regs, args);

Thanks, much better than I tried to suggest in my reply to V1.

But may be

	if (syscall_get_nr() != -1)
		syscall_set_arguments(...);

will look a bit more consistent?

Oleg.


