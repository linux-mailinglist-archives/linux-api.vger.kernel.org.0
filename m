Return-Path: <linux-api+bounces-3019-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A854FA12B8A
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D4F1886225
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2025 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C091D63C7;
	Wed, 15 Jan 2025 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYpzXDla"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C124A7CC
	for <linux-api@vger.kernel.org>; Wed, 15 Jan 2025 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736968240; cv=none; b=ZFMdVJ6Mi4sUgi2uiloG9aXj0GzT7GhKwUGM+zESkPaUSOhhN1uwpWV8cf3UezurcZScIvDZPKKUTkzLgk7bNgsGI4XJmxngrp8c+0YClYoMU1eP8l4FTu4j7N3+GYyQOJAhkRIo9/7WsdqIe8EijXwtWyCqgfKnyRuCGYATSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736968240; c=relaxed/simple;
	bh=aoUXftjPF0ncusteObCq4uN4fjB0eaRntK097Q/X2Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTDvWY6lFpmJRH/wRzBhxYkfm962o6d1mBaK3mkElb7T+qKvwrsH3e8rKYTVE/pqs42jr0PL89JndP0sTOeZyXgssmTDb450ejVMNMVkIKlQK7z5eLJktQtjkMvY6LsDoZjVjHeCh6uQrJysqUqOVHe/rrhzBIwF2yR4vLPvFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYpzXDla; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736968238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxMeLnCKnxjpk66xjwEEsijZnLziZFS8E4S1/ZSzGRw=;
	b=BYpzXDlasYmxW1IZbCQBF1MiJKDX/88CYLA9xTppjQbqL/FZRRXkhzBhk0CPZJHFkbK5mz
	j0k0kWGYL4EafH+BFAvLtq2lktm7HjBL6IlGolyxHUc/6sZ8spdaMvedOcVrSSV1hFvby5
	pWzXmgB64ydBQmToaq1LSFl7A/D/OtI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-t6QyXQf6OIOL-O5XpkcvFg-1; Wed,
 15 Jan 2025 14:10:35 -0500
X-MC-Unique: t6QyXQf6OIOL-O5XpkcvFg-1
X-Mimecast-MFC-AGG-ID: t6QyXQf6OIOL-O5XpkcvFg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC5CB1956056;
	Wed, 15 Jan 2025 19:10:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.35])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A18D719560AA;
	Wed, 15 Jan 2025 19:10:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 20:10:08 +0100 (CET)
Date: Wed, 15 Jan 2025 20:10:03 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250115191002.GC21801@redhat.com>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250115163809.GC11980@redhat.com>
 <20250115173642.GA25129@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115173642.GA25129@strace.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/15, Dmitry V. Levin wrote:
>
> On Wed, Jan 15, 2025 at 05:38:09PM +0100, Oleg Nesterov wrote:
> >
> > But may be
> >
> > 	if (syscall_get_nr() != -1)
> > 		syscall_set_arguments(...);
> >
> > will look a bit more consistent?
>
> I'm sorry, but I didn't follow.  As we've just set the syscall number with
> syscall_set_nr(), why would we want to call syscall_get_nr() right after
> that to obtain the syscall number?

Mostly for grep. We have more syscall_get_nr() != -1 checks. Even right after
syscall_set_nr-like code, see putreg32().

I think this needs another helper (which can have more users) and some cleanups.

But this is another issue, so please forget. I agree that syscall_get_nr() in
this code will probably just add the unnecessary confusion.

Oleg.


