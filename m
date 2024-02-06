Return-Path: <linux-api+bounces-861-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C284BE15
	for <lists+linux-api@lfdr.de>; Tue,  6 Feb 2024 20:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6309F1C22AC5
	for <lists+linux-api@lfdr.de>; Tue,  6 Feb 2024 19:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A61400F;
	Tue,  6 Feb 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRWOBs9k"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A821B7F0
	for <linux-api@vger.kernel.org>; Tue,  6 Feb 2024 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247639; cv=none; b=eMo8N9+b6g0aR/QjRGEWc9CKT1SkIjK9CP9ju8GxBrXwkx7LjKJwm2KYK7Qi1XeKaFwMdjRTd+o7CiuVSBwfa0fxpp8mS3O4lDAp5bMm6LdTrl4UCCkTitAQOLMjyhW39nFH/gLLzHiQdwj0JWUcyLeN3ytYUEHJWmapqOfRD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247639; c=relaxed/simple;
	bh=AROLcne/Zq10AQJLNHGj6fYDE/CKNNGjHYS5FckbS0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsTCpe1Vp5Sg/eiieW0nCj0tTcBncAoTRpwfEMNvsIXFi/sqGRKz6ipq9mHGt5VcEgX7do5/JI/eBEq5+1CgWRpa6an4BpqmjBXTSZsIUUUT3PINxHfNhnpltEX0y1Y+wOAG8Ilb0Y8VB17K3zGJfs4KLz2p+uMD6lKqCO+Gt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VRWOBs9k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707247636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AROLcne/Zq10AQJLNHGj6fYDE/CKNNGjHYS5FckbS0c=;
	b=VRWOBs9kbRgDHacaIhe2mRCaShzWdI6Tl5h96I7iZlkhIFrpOHodSyWjnOEnssDqTG1ZDP
	RvjQzuEB8KhiYHm3a9ukZP2vf20RMenpIrfuBJYu1r3zFnrQzUVOMTwd9Hjvg2aJyDjLAe
	J8vqT2ZDu0+UkRuw0+f4WQItWloxYT4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-Nk5j75SXM7mGD_sDN7ATMA-1; Tue, 06 Feb 2024 14:27:13 -0500
X-MC-Unique: Nk5j75SXM7mGD_sDN7ATMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0AB3879849;
	Tue,  6 Feb 2024 19:27:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.46])
	by smtp.corp.redhat.com (Postfix) with SMTP id F2BEFAC1D;
	Tue,  6 Feb 2024 19:27:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 Feb 2024 20:25:57 +0100 (CET)
Date: Tue, 6 Feb 2024 20:25:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240206192553.GC3593@redhat.com>
References: <20240206164308.62620-1-tycho@tycho.pizza>
 <20240206173722.GA3593@redhat.com>
 <20240206180607.GB3593@redhat.com>
 <ZcJ13uLxD6rTqqZZ@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcJ13uLxD6rTqqZZ@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 02/06, Tycho Andersen wrote:

> On Tue, Feb 06, 2024 at 07:06:07PM +0100, Oleg Nesterov wrote:
> > Or we can check task->files != NULL rather than PF_EXITING.
> >
> > To me this looks even better, but looks more confusing without a comment.
> > OTOH, imo this needs a comment anyway ;)
>
> I thought about this, but I didn't really understand the null check in
> exit_files();

I guess task->files can be NULL at least if it was cloned with
kernel_clone_args->no_files == T

> if it can really be called more than once,

I don't think this is possible. Well, unless the exiting task hits
a BUG() after exit_files() and calls do_exit() recursively.

> are there
> other cases where task->files == NULL that we really should report
> EBADF?

I don't think so...

If nothing else, sys_close() dereferences current->files without any
checks, so I think task->files == NULL is simply impossible if this
task is a userspace process/thread until it exits.

But Tycho, I won't insist. If you prefer to check PF_EXITING, I am fine.

Oleg.


