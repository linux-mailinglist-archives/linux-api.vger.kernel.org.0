Return-Path: <linux-api+bounces-3925-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89747ADBC11
	for <lists+linux-api@lfdr.de>; Mon, 16 Jun 2025 23:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38086175148
	for <lists+linux-api@lfdr.de>; Mon, 16 Jun 2025 21:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2490A22D781;
	Mon, 16 Jun 2025 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRc9Kqjm"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512121882F
	for <linux-api@vger.kernel.org>; Mon, 16 Jun 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750109981; cv=none; b=ol3t9go32PUn6NqQ+bUPr/gu1KXJudQHqu7CE0edkTjfspGjR66gFxJ5kBEJCayUEdCLtbTWcXHkdN93XIsaDjrHGo0X4/4NY63avNXkvBxPG3QsDzj3hsSOU5McqID4C+RvF8T4tJDQ9GCN8WHxqqpv9qBh89JXxam3kuF9CPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750109981; c=relaxed/simple;
	bh=QzEAQtt+aGVKhfuj29JZWjtEC6tULjxy17FvlP6qNUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7NHEJeXczEnx5jImAE8aoGYhSdrI1iDruhFxG9i6MMxd5fjE9M6Wp+pVE701Cb4FeyxPtEa5t0X1NudYC7vslXGfs0xJcco3sC65Aop0okalX5FLDQu6pkfLKpKT1vEMqSy4VaJeM/y6eE31qldoSWax6dA5vgIZi6uqIodMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRc9Kqjm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750109979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85/1d0wMBmqSkLyQ+YALVO6DwSoPhRMSYMFI4xK3lME=;
	b=fRc9KqjmyfDyZJ3YiBXIDOq5HLntdB7pOFtxrWAiDu7QvdBqsdvHtpYXWxB8E1FAnSZ31v
	UYEMpbd1Zk7ih81Rm/jWRBf+KmPA24ZCxq5Ay3UnUXVw5JiyN0kl39hjtnpfzeIwoxzM+5
	JSUHIVPpdMn9J122YQJLxPA+nSAic5w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-pNs-wQ-kNM-C4ozlsqgRlA-1; Mon,
 16 Jun 2025 17:39:37 -0400
X-MC-Unique: pNs-wQ-kNM-C4ozlsqgRlA-1
X-Mimecast-MFC-AGG-ID: pNs-wQ-kNM-C4ozlsqgRlA_1750109976
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B9E51956089;
	Mon, 16 Jun 2025 21:39:36 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24E5C30001B1;
	Mon, 16 Jun 2025 21:39:33 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
  workflows@vger.kernel.org,  tools@kernel.org
Subject: Re: [RFC 08/19] exec: add API specification for execve
In-Reply-To: <20250614134858.790460-9-sashal@kernel.org> (Sasha Levin's
	message of "Sat, 14 Jun 2025 09:48:47 -0400")
References: <20250614134858.790460-1-sashal@kernel.org>
	<20250614134858.790460-9-sashal@kernel.org>
Date: Mon, 16 Jun 2025 23:39:31 +0200
Message-ID: <87ikkvv018.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Sasha Levin:

> +	KAPI_RETURN("long", "Does not return on success; returns -1 on error")
> +		.type = KAPI_TYPE_INT,
> +		.check_type = KAPI_RETURN_ERROR_CHECK,
> +	KAPI_RETURN_END

Is the -1 part correct?

Many later errors during execve are not recoverable and result in execve
succeeding (nominally) and a fatal signal being delivered to the process
instead.  Not sure if the description covers that.

What about the effect of unblocking a parent thread that has vfork'ed?

Thanks,
Florian


