Return-Path: <linux-api+bounces-4718-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C6CB44F5C
	for <lists+linux-api@lfdr.de>; Fri,  5 Sep 2025 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25A3188A932
	for <lists+linux-api@lfdr.de>; Fri,  5 Sep 2025 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC752F3C28;
	Fri,  5 Sep 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmlbqCor"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E962F49F8
	for <linux-api@vger.kernel.org>; Fri,  5 Sep 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056792; cv=none; b=KHplL9p4gHQ7gaM7Zj2+P5jKC3TEShEJeQc4TtBTEOcwUwB05AeyAHPeIt9RxH6J/jvdwUThJdfqAq6gqY6muG5d+RzOZyn5T8ZT42NJvoPKiEGiCXkfES3h3TKkA/Tgq6FsM0iZuvIEI3U0fiCFALBUkEoiFhhTAQ0LZG42DR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056792; c=relaxed/simple;
	bh=Suw09eB9ppiB6UfNyAOxsVIseQRG6XKcK1nA3C87n6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mwMQcR5DHcJvNvtMb9dpCFOaZfQyK1NgORw1GgbqxCyVmmdJAYwDOYra0dSqLBq8z3fsa02bpJKjVzbSiPhXwjALkyzlIeF3faTQPfsUZ8R56IV+/8qtHOdBV9uYhOrZUTap8q3gMdtm9zQaXVM+aFxwmYRPuuLZzOnWPaFf44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmlbqCor; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757056790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOWBvlmAC8pfNTMOXHdIcb1vSYRLonZ1V+4KR+bduoU=;
	b=BmlbqCorFw7lXtWo5sQBr/0CqXsNn6+FRHPaVKusSLOxggmllTI3E90IZB+yHI34tB8kjp
	LKX3nNgNccvrQI7U7HBswj/M2x/XRcB0C6sTSfvo+PyL2gHdKzdYg9Xo9N5FJ71bbCAY5Q
	1Gk8zmEuet16baap5GuOxapX2o821dM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-Y2iy0qCyNs-1PW5mQz-4kA-1; Fri,
 05 Sep 2025 03:19:43 -0400
X-MC-Unique: Y2iy0qCyNs-1PW5mQz-4kA-1
X-Mimecast-MFC-AGG-ID: Y2iy0qCyNs-1PW5mQz-4kA_1757056781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D9AB195608E;
	Fri,  5 Sep 2025 07:19:41 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.104])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD9F419560B8;
	Fri,  5 Sep 2025 07:19:36 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>,  linux-fsdevel@vger.kernel.org,
  patches@lists.linux.dev,  Jeff Layton <jlayton@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  Alexander Aring <alex.aring@gmail.com>,  Josef
 Bacik <josef@toxicpanda.com>,  Aleksa Sarai <cyphar@cyphar.com>,  Jan Kara
 <jack@suse.cz>,  Christian Brauner <brauner@kernel.org>,  Matthew Wilcox
 <willy@infradead.org>,  David Howells <dhowells@redhat.com>,
  linux-api@vger.kernel.org
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
In-Reply-To: <b35f0ff7-8ffb-400f-b537-d15e83319808@infradead.org> (Randy
	Dunlap's message of "Thu, 4 Sep 2025 14:52:34 -0700")
References: <20250904062215.2362311-1-rdunlap@infradead.org>
	<CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
	<lhua53auk7q.fsf@oldenburg.str.redhat.com>
	<b35f0ff7-8ffb-400f-b537-d15e83319808@infradead.org>
Date: Fri, 05 Sep 2025 09:19:33 +0200
Message-ID: <lhu7bydv01m.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Randy Dunlap:

> On 9/4/25 11:49 AM, Florian Weimer wrote:
>> * Amir Goldstein:
>> 
>>> I find this end result a bit odd, but I don't want to suggest another variant
>>> I already proposed one in v2 review [1] that maybe you did not like.
>>> It's fine.
>>> I'll let Aleksa and Christian chime in to decide on if and how they want this
>>> comment to look or if we should just delete these definitions and be done with
>>> this episode.
>> 
>> We should fix the definition in glibc to be identical token-wise to the
>> kernel's.
>
> That's probably a good suggestion...
> while I tried the reverse of that and Amir opposed.

It's certainly odd that the kernel uses different token sequences for
defining AT_RENAME_* and RENAME_*.  But it's probably too late to fix
that.

Here's the glibc patch:

  [PATCH] libio: Define AT_RENAME_* with the same tokens as Linux
  <https://inbox.sourceware.org/libc-alpha/lhubjnpv03o.fsf@oldenburg.str.redhat.com/T/#u>

Thanks,
Florian


