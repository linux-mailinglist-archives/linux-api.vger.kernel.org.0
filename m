Return-Path: <linux-api+bounces-2276-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D25968719
	for <lists+linux-api@lfdr.de>; Mon,  2 Sep 2024 14:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7E11F24512
	for <lists+linux-api@lfdr.de>; Mon,  2 Sep 2024 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD620010F;
	Mon,  2 Sep 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA+a4TzH"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC8200101
	for <linux-api@vger.kernel.org>; Mon,  2 Sep 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278868; cv=none; b=XevLrQPouoNB3hHFbPWbxakLiVgZdtwHZSmq4rQc1cdBlxvJyZrLau2GuOmoZzBbTauAcQdNOep2hN+leohwKRoKV8J6ddiFTDscw9Gbdw00s2IVhMIord77UDESH5XYDasbcTZ6WW1LMqpZ853FJujT4jSl4kCJBAfwXNOJSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278868; c=relaxed/simple;
	bh=cNfn8v57qzoh4X8pwiukWydCJ1lDZU4LMycDmGx9rY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ceX5fYftEkAjNkRak3oduDu1laQAXW7qsVCoetnCjO0c0K/dy5f3zJm6YxbzmX1gCNVfPgXfx0aSVPCHq6AIrW3L/Q3UjcjbdJb9r1NKGIG3YTpxOqnYZC7PY0BNB/Hi141Q+032qjYbZvgiNmIieuCBilW+a120cSQoWQPHGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA+a4TzH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725278865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjOW0E49Yqw0mfiCURQMWGxKRTpi1ev/eO7YHhvgkrY=;
	b=RA+a4TzHDooF9t2syeJfnaOAtINCfXQebUq8fbaeU+9O2ajFEGDpIBi8O/qGO7trFvJT3n
	vxY+PQvc+14nNo2WQAoZuRmlZAD7VH9eokd0JYtoLZ1WL7WdSPGPqkub+WVeR8yGaXvqG6
	jaa7RhMd4pEUlR8w8KmzkVDrvQLk53I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-CfVNYkG0OgOLqsUrGaZQyA-1; Mon,
 02 Sep 2024 08:07:44 -0400
X-MC-Unique: CfVNYkG0OgOLqsUrGaZQyA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46F441956080;
	Mon,  2 Sep 2024 12:07:42 +0000 (UTC)
Received: from oldenburg3.str.redhat.com (unknown [10.39.194.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29DF61956048;
	Mon,  2 Sep 2024 12:07:39 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Rich Felker <dalias@libc.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,  linux-api@vger.kernel.org,
  libc-alpha@sourceware.org,  musl@lists.openwall.com
Subject: Re: [musl] AT_MINSIGSTKSZ mismatched interpretation kernel vs libc
In-Reply-To: <20240831154101.GN32249@brightrain.aerifal.cx> (Rich Felker's
	message of "Sat, 31 Aug 2024 11:41:02 -0400")
References: <20240829205436.GA14562@brightrain.aerifal.cx>
	<20240831092902.GA2724612@port70.net>
	<20240831150241.GP10433@brightrain.aerifal.cx>
	<CAMe9rOqSSX_YP7dq5WK7vDyrQ5RP6nUNrim-8FjJi1X_8NfAvg@mail.gmail.com>
	<20240831154101.GN32249@brightrain.aerifal.cx>
Date: Mon, 02 Sep 2024 14:07:36 +0200
Message-ID: <87v7zetg1j.fsf@oldenburg3.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Rich Felker:

> This is ambiguously worded (does "operating system" mean kernel?) and
> does not agree with POSIX, which defines it as:
>
>     Minimum stack size for a signal handler.
>
> And otherwise just specifies that sigaltstack shall fail if given a
> smaller size.
>
> The POSIX definition is also underspecified but it's clear that it
> should be possible to execute at least a do-nothing signal handler
> (like one which immediately returns and whose sole purpose is to
> induce EINTR when intalled without SA_RESTART), or even a minimal one
> that does something like storing to a global variable, with such a
> small stack. Allowing a size where even a do-nothing signal handler
> results in a memory-clobbering overflow or access fault seems
> non-conforming to me.

POSIX does not specify what happens on a stack overflow (or more
generally, if most resource limits are exceeded), so I think the
behavior is conforming on a technicality.

Thanks,
Florian


