Return-Path: <linux-api+bounces-5189-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF2EC45CFE
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 11:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09A154EFEE6
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D439303C8D;
	Mon, 10 Nov 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2z3EYUv"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1F302150
	for <linux-api@vger.kernel.org>; Mon, 10 Nov 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768819; cv=none; b=fH8JcKlKXInHQV7PI6GlFEquv/gWqJACyDoshaLKCdkrxeUED5uotSWgH7IUfVr2v7ccAR9z4hLxbJTgMml5BbR/x572qE9Yu6no74X90NvEB8BqDO/rNk9kMuhzCHVeg5uioynzs7vNam9vylqY/n5YCUoAB90g/pbKQypXpts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768819; c=relaxed/simple;
	bh=EUyWiFScXgn7F+DcQZB+wlycuEGGy1JbALp62E/f+/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RuquXQdSEcdt7Ewxbca1n7lo3k+AH9lJr+HSsujPrTtmrAORf7wjuR+FbQIL/hIKGmtLKUWpgWk/lS2mv9pkMuaQygFkkCwqqWxIgavXFSGxrzCBPBHKEA62516ZnGL0YIFNjw+nJzPDP1gZtUTp/fIvj8L/vYF+TjUSDUvHzz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2z3EYUv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762768815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5BK2s5k5pjxYUQWQQfjtI+MbVzxOLhifTPfdi+okfg=;
	b=V2z3EYUveLab5i2zeURX9aqkW+HbA3JAJuZSC9vJRhOWBQ3Ytm3n6c8pydmYKQKN9z2GtI
	veJUXYsKIdbcQFd0iF9H35pTvDp8LRy6ZOfhtTmFIRHoFtx7Jtj9Z6vnML2GaJlx71cq6i
	CT5s1VwJFQ41bNwEmd3htbjsD4w+A1I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-oaolRIKTPUmdDjOW3kvC2g-1; Mon,
 10 Nov 2025 05:00:12 -0500
X-MC-Unique: oaolRIKTPUmdDjOW3kvC2g-1
X-Mimecast-MFC-AGG-ID: oaolRIKTPUmdDjOW3kvC2g_1762768810
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEF01195605F;
	Mon, 10 Nov 2025 10:00:10 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 272901800361;
	Mon, 10 Nov 2025 10:00:05 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>,  Hans Holmberg
 <hans.holmberg@wdc.com>,  linux-xfs@vger.kernel.org,  Carlos Maiolino
 <cem@kernel.org>,  Dave Chinner <david@fromorbit.com>,  "Darrick J . Wong"
 <djwong@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
  libc-alpha@sourceware.org
Subject: Re: truncatat? was, Re: [RFC] xfs: fake fallocate success for
 always CoW inodes
In-Reply-To: <20251110094829.GA24081@lst.de> (Christoph Hellwig's message of
	"Mon, 10 Nov 2025 10:48:29 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
	<20251110093140.GA22674@lst.de> <20251110094829.GA24081@lst.de>
Date: Mon, 10 Nov 2025 11:00:03 +0100
Message-ID: <lhu5xbiyzq4.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Christoph Hellwig:

> On Mon, Nov 10, 2025 at 10:31:40AM +0100, Christoph Hellwig wrote:
>> fallocate seems like an odd interface choice for that, but given that
>> (f)truncate doesn't have a flags argument that might still be the
>> least unexpected version.
>> 
>> > Maybe add two flags, one for the ftruncate replacement, and one that
>> > instructs the file system that the range will be used with mmap soon?
>> > I expect this could be useful information to the file system.  We
>> > wouldn't use it in posix_fallocate, but applications calling fallocate
>> > directly might.
>> 
>> What do you think "to be used with mmap" flag could be useful for
>> in the file system?  For file systems mmap I/O isn't very different
>> from other use cases.
>
> The usual way to pass extra flags was the flats at for the *at syscalls.
> truncate doesn't have that, and I wonder if there would be uses for
> that?  Because if so that feels like the right way to add that feature.
> OTOH a quick internet search only pointed to a single question about it,
> which was related to other confusion in the use of (f)truncate.
>
> While adding a new system call can be rather cumbersome, the advantage
> would be that we could implement the "only increase file size" flag
> in common code and it would work on all file systems for kernels that
> support the system call.

There are some references to ftruncateat:

  <https://codesearch.debian.net/search?q=ftruncateat&literal=1>

I don't have a particularly strong opinion on the choice of interface.
I can't find anything in the Austin Group tracker that suggests that
they are considering standardizing ftruncateat without a flags argument.

Thanks,
Florian


