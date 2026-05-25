Return-Path: <linux-api+bounces-6395-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDd3DiTfE2p7GwcAu9opvQ
	(envelope-from <linux-api+bounces-6395-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 07:33:24 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F765C5EDF
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 07:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B1A3008232
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 05:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69423290AF;
	Mon, 25 May 2026 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kznearcp"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D054317D;
	Mon, 25 May 2026 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687201; cv=none; b=lXw5WrHrADnH1TLT5DaBuFMfHDaG4gtjDGnWItiC6E10qjlC4gRsUT5FJP91kCUaJSczdxKO9NoW3TEVQPI4F+q7tvf9aCukfNJwqRc6mlmx0r91r19kEN4GvFGGlBM4D6bmUmo03PpDxS3BJXTg23Ocpk2IA2okr2stooEhNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687201; c=relaxed/simple;
	bh=1zyqSZ4EgClwLQCRqD96bpFbUFCicgrp8sYVN/JM0HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqSOZLNsSoq258NQqR4k2Y2Fmf4spLMfQA9XOuBiVrlqPu1FAoVC8IiTU+IPVXuCK+Gd0vxWTYhG7ygAWJs+X0VV1iKFel9X4vau7F23gW+6b3cQJrhmX58MOQUBt57VKc83Xi9OCfnvnAjZGkXOFWVpaHrUGOq6FOsWNI4r4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kznearcp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0bbsGXQA2Mj+nrlW165zZsFLFN3irgVxgS7TeXjE53w=; b=Kznearcpcs9i/PRGhFOeR6hgVW
	a+SLcGlueIidtwUZlbwnl9fk5676i/rEJRV1t4OJUBy/qAIeLnWHw3tdS+W7oLGZNzRDPpkKZuNEv
	+PGVGsXdXBj2BjuoOm6vFpB+/3H1eUK0CCmPW1XF/szA/dGMBHa6Rkd+nX/T45UKQVI67xT6Ch+xZ
	7PpSRHf/Z78qHejdjmKKgfZ8us6De96teat2eNXpBZNi/4jKQcV+Jg4O9hpXRzFUKjIgn+nWAUF3M
	5WithsXwRU9g8RhhjqiXqZSqZe54/bJozXoNQ2j9IAGgYngrjgRS8tVCVwEsLtIRimdRiCE+YgCGf
	MzQu7rpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRNwF-0000000GKVS-2MYS;
	Mon, 25 May 2026 05:33:19 +0000
Date: Sun, 24 May 2026 22:33:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Cyber_black <Cyberblackk@proton.me>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-api@vger.kernel.org
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
Message-ID: <ahPfH18UeBvCScLG@infradead.org>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org>
 <20260518162048.GC9531@frogsfrogsfrogs>
 <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com>
 <20260519033126.GD9531@frogsfrogsfrogs>
 <CALCETrXWuMJstpkDhV4eKTwbRhQAQ0RZTkkFN=+oXrkiShgx1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXWuMJstpkDhV4eKTwbRhQAQ0RZTkkFN=+oXrkiShgx1A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6395-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B0F765C5EDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 01:51:53PM -0700, Andy Lutomirski wrote:
> >
> > Also note that FIEMAP still doesn't report devices, so you're still
> > playing with fire on multi-device reflink-aware filesystems like XFS.
> >
> 
> A hash would be fine for me.
> 
> But really a nicer interface would translate logical ranges in a file
> to some range identifier, where:

All this sounds really complicated and probably not doable.  But you
haven't answered the basic question, which is if your use cases already
has candidates and you just want to confirm them, or if you are
iterating all file logical to physical mappings in the file systems?

Can you explain your highlevel use case a bit?


