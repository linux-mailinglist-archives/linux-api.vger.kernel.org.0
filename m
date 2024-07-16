Return-Path: <linux-api+bounces-1976-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBBA932A25
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2024 17:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C483D1F22F9F
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2024 15:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2D19DF9D;
	Tue, 16 Jul 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrGJz3wY"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B819DF8C
	for <linux-api@vger.kernel.org>; Tue, 16 Jul 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142816; cv=none; b=kCPvKhtBTauw25BiifccqYtNnRIk8a9LLlSQJSblQaHOC8LFnluuBjsZoxJF5+aXYFfbic6vIM0g39frTQhJJmU0E51/W0V7R9O9QmmqHAgl+Jz5j/qp3mxwLvKfEvw/nryn11MIXKPZk6SaXJJwJaauMVVuf8n9l5s10sl3CCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142816; c=relaxed/simple;
	bh=fAJSSHRy2HkDoavN0Q2gCNvHpyce9GiiiYcHR48T8Lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7+MMpBh2HW7w8vt7Oy73CluCihafQdG/MF8Dkrv8YWvWT8Q/6jO9uVan0jG+4CSOr75l8JxmsAJTOZvgSP/EVuqpZMfB87nhhmc5NWToC0wHhq9t3FqzpYvPJheaaSjrRkRtM0EvDsPhFW8BcCtTToJVGru7p9s3whvMxs/eXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrGJz3wY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721142813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqVzjxaUWHCkKMYhonuIdrJ0/aineuTUeeo5KfgCHPU=;
	b=LrGJz3wY7Worx5mbSBpysY0ThrlopwG+p9T+gcqinVHvQja5yhrHlAMoIVr1klPaNGIobY
	PHE7kYRJnZ0wimnGgZds2k3t0hfdm4fKA8si4ru4M+7TDt9UpNydJ4O/zWBFnqcapXlfoR
	TVUoB05eBfn+slNqPNQvYVwfhKDFoSA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-klP_s3f7NNmrkDZ9C26Eww-1; Tue,
 16 Jul 2024 11:13:29 -0400
X-MC-Unique: klP_s3f7NNmrkDZ9C26Eww-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF74519560A2;
	Tue, 16 Jul 2024 15:13:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BFE1195605A;
	Tue, 16 Jul 2024 15:13:24 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "Soni \"They/Them\" L." <fakedme@gmail.com>
Cc: linux-api@vger.kernel.org
Subject: Re: mprotect PROT_SIGNAL
In-Reply-To: <f01d236a-e713-4953-be8b-1484201f8190@gmail.com> (Soni L.'s
	message of "Tue, 9 Jul 2024 13:44:36 -0300")
References: <f01d236a-e713-4953-be8b-1484201f8190@gmail.com>
Date: Tue, 16 Jul 2024 17:13:22 +0200
Message-ID: <87ikx5z7xp.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

* Soni L.:

> we'd like an mprotect PROT_SIGNAL flag for a compiler we're making
>
> PROT_SIGNAL - marks the pages as unmapped while running signal handlers
>
> this would be very useful, do you think you could provide it?
>
> (not much more to say about it, it's supposed to do what it says on
> the tin, we want to unmap pages in signal handlers so as to catch bugs
> without causing memory corruption.)

The challenge is going to be to detect abnormal exit from the signal
handler.

You can already get some of this behavior to today with memory
protection keys, on x86-64 at least.  (I consider this a glitch in the
implementation, it makes it less useful.)  Access is revoked
automatically when the hander is invoked.  However, access is not
restored if you jump out of the handler using longjmp or by throwing an
exception.

Thanks,
Florian


