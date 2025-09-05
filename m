Return-Path: <linux-api+bounces-4721-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C4B45395
	for <lists+linux-api@lfdr.de>; Fri,  5 Sep 2025 11:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2559F7AD067
	for <lists+linux-api@lfdr.de>; Fri,  5 Sep 2025 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A628137C;
	Fri,  5 Sep 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7W009HW"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C3283683
	for <linux-api@vger.kernel.org>; Fri,  5 Sep 2025 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065306; cv=none; b=tp9IpHGxehD7lcHQlACWaz/Bi/gfnIHcY4uIMXHGnU8pGi+IJYu50frJd/yqc6ndHW/f57xMoxycJCsaGqXMe3Ngkom7c5IIOOUBq4tQWzVG7q+G1pa6Dl/1O+1Hefaz8ElAZlF3MwNFWgrXMUh0/u3zCfiVGKgsL4+RgaIvw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065306; c=relaxed/simple;
	bh=xK0X5ybXdU7CZSUGGi0MOJLoE7ekQvmtxtU/O/I8VeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZSI5kxQSvr4SjNwBoK6lGDf9UNQb/2S8AJkWp7UcKlhfXrgazU+8u0LCrbbQRNSL+2aRlZK/r6XIxfTKi3bNiX+JbKNlh+tl5lkJo13+xrqwv2OL1R3KEtOS0Dh4nkO++0Zj0O6zwu7kJSDDAsDJqhv2O/FHviWOvM7CJ7r+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7W009HW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757065304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhBFGiEZQECiCXPQgfE0yM1j7Y3xE+crwyDfNzUa1yA=;
	b=g7W009HWNBxeqBFew5Z8Xj8IsBBGRkOPkZeQyTSJsCfO1akrwOIiRAyawDpD+DEj/Z78c4
	s2rIjoWjBtyawQPScnsaUOJW9sTx0F+kHpfvaZQZz6Jn2F/t59P7SoCv0iYb401qwgQaS/
	m/YXSt9f6+UGwDvYTLiWOUA4o89vd9w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-BiEXApicPY29oj70ntVMgQ-1; Fri,
 05 Sep 2025 05:41:38 -0400
X-MC-Unique: BiEXApicPY29oj70ntVMgQ-1
X-Mimecast-MFC-AGG-ID: BiEXApicPY29oj70ntVMgQ_1757065297
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EC83180034F;
	Fri,  5 Sep 2025 09:41:36 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.104])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D09419540EB;
	Fri,  5 Sep 2025 09:41:30 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,  linux-fsdevel@vger.kernel.org,
  patches@lists.linux.dev,  Jeff Layton <jlayton@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  Alexander Aring <alex.aring@gmail.com>,  Josef
 Bacik <josef@toxicpanda.com>,  Jan Kara <jack@suse.cz>,  Christian Brauner
 <brauner@kernel.org>,  Matthew Wilcox <willy@infradead.org>,  David
 Howells <dhowells@redhat.com>,  linux-api@vger.kernel.org,  Kees Cook
 <kees@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
In-Reply-To: <CAOQ4uxjcLDUcfdp72cpQcDQEtZaaR4G+P8oPXL_HbotFirGrKQ@mail.gmail.com>
	(Amir Goldstein's message of "Fri, 5 Sep 2025 11:17:30 +0200")
References: <20250904062215.2362311-1-rdunlap@infradead.org>
	<CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
	<2025-09-05-armless-uneaten-venture-denizen-HnoIhR@cyphar.com>
	<CAOQ4uxjcLDUcfdp72cpQcDQEtZaaR4G+P8oPXL_HbotFirGrKQ@mail.gmail.com>
Date: Fri, 05 Sep 2025 11:41:27 +0200
Message-ID: <lhutt1htewo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Amir Goldstein:

>> If it's too much effort to synchronise them between glibc then it's
>> better to just close the book on this whole chapter (even though my
>> impression is that glibc made a mistake or two when adding the
>> definitions).
>
> Considering that glibc has this fix lined up:
> https://inbox.sourceware.org/libc-alpha/lhubjnpv03o.fsf@oldenburg.str.redhat.com/
>
> Do we need to do anything at all?
>
> Florian,
>
> I am not that familiar with packaging and distributions of glibc
> headers and kernel headers to downstream users.

I don't think kernel changes are necessary or desirable at this point.
The glibc change went into glibc 2.42 only, and at this point in time,
all distributions shipping 2.42 (few of them do) are pretty much
guaranteed to pick up fixes from the 2.42 stable release branch
regularly.  So if we get this into glibc 2.43 and backport it to 2.42,
the problem should disappear quite soon from a developer's perspective.

Thanks,
Florian


