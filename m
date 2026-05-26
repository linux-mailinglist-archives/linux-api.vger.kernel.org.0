Return-Path: <linux-api+bounces-6409-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAyXDekXFWqQSgcAu9opvQ
	(envelope-from <linux-api+bounces-6409-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 05:47:53 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA65D073B
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 05:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 319933013B7F
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 03:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080C3A8722;
	Tue, 26 May 2026 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmtVWfiM"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF42E5B2A;
	Tue, 26 May 2026 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779767269; cv=none; b=Fhkn9lTudLqasg3u6/PQ+PyGtBZzb1wEG925cGrQdBLBmZsvvCnPrATIwLBnk1h5OF1Owqp/oD+FZ4BbrwvSKYFKp14/9IPjpD+iWWkV3YhvCIMKfXwaDaGHFjZn8f82FaKjdWZqO3GO/5zF8FSMxdjXyCZQGazpERgvBwGc4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779767269; c=relaxed/simple;
	bh=rS3J5xEsHvuFU6637V2Jj3mVEfTmVLyNLytSDMCGf74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pREIakERpymy0xlDPz5vk0MDlHbQGG/yCoazH/3h5Q6KYFXvuguh1HdPTCQ4lJfqS4eBb6ASPTJBq69SwxRcd9K91pMf8W3rXnGGfcAeDcKbMutaSbDATTl8CMU1wuBF2wEIVQDw0ZHWrUrXAK47rInt7rZOzkRHt7TlM4kyJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmtVWfiM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B481F000E9;
	Tue, 26 May 2026 03:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779767268;
	bh=DxyY+bYQ0Eo648ljGRU7X1Wi24vXYHPFWC0Fu00rbQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nmtVWfiMTmNf6D+IX+7K3ePXqNYLegK8TT6JQ1uNfPCg1/lZNl1hdy2I9ZyVlBdqc
	 XUGbbL3VR3ElWJPiiOgM97mnVnP0BqU2QD0SV2hFa2Eib8ci6/5rLW9rls6OtN4nk3
	 uIGXqzOAXE8tKcd13d5ANdSxe7aDhjCbF1akk4opPo99gdBrvU8MtwuU7j2b1g+TXX
	 fqYRTf5visUjVSFpVAG9EwuqGwtJkX1CPP6lnk6zNbZpnGVVigaaOGODi3dYe5/kPY
	 t5yaYxKVlUmVmfPF7Mr+6NnK8zrgsv5stXOUaO6dCmRV40JC5G6bXFk3A4WQ5NnPEz
	 s9pYjIfB/RoEQ==
Date: Tue, 26 May 2026 03:47:46 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahUX4tBeLykdQNxY@google.com>
References: <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com>
 <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
 <ahUF7HqSKFJ422bU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahUF7HqSKFJ422bU@casper.infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6409-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A9CA65D073B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/26, Matthew Wilcox wrote:
> On Tue, May 26, 2026 at 01:21:33AM +0000, Jaegeuk Kim wrote:
> > On 05/24, Christoph Hellwig wrote:
> > > On Fri, May 22, 2026 at 02:04:59PM +0000, Jaegeuk Kim wrote:
> > > > This was a quick buddyinfo right after booting the device.
> > > > 
> > > > Before:
> > > > Node 0, zone   Normal  22684  42284  28704  16901   9515   4566   1854    673    181     36    758
> > > > 
> > > > After disabling EROFS large folio:
> > > > Node 0, zone   Normal   8486   4732   2175   1161    697    272     82     19      3      1    856
> > > 
> > > And what are you trying to say us with that?
> > 
> > This means, high-order pages were used up by EROFS which sets large folio by
> > default. So, I wanted to say the concern was based on actual data which was what
> > Mattew asked.
> 
> This isn't that though.  What you actually need is to show that high order
> allocations are _failing_.  The MM is far more complicated than you seem
> to understand.  There isn't a fixed number of large folios available;
> when we try to allocate memory, we do reclaim.  And if there's large
> folios on the LRU list, you'll get them.
> 
> If what you want is large folios readily available, then what you want
> is large folios used _everywhere_ because then they're easy to get!
> If there's small folios in use, you need to reclaim a lot of memory in
> order to reassemble large folios (it's the birthday paradox, similar to
> the hash collision problem).

Thanks for the feedback. Actually, I tried to do compact_memory before doing
read() for AI loading, but I got complaints where it took hundreds milliseconds
to run that compact_memory. Is there a good way to secure high-order pages before
that read()? It was quite hard to project when it will happen.

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

