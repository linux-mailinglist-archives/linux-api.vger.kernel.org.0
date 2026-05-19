Return-Path: <linux-api+bounces-6356-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPwVOOdODGpIeQUAu9opvQ
	(envelope-from <linux-api+bounces-6356-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 13:52:07 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0965357E0EF
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 13:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ABE8300F118
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86632FA2B;
	Tue, 19 May 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tXEKd5Zp"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90C327C18;
	Tue, 19 May 2026 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191150; cv=none; b=twGOHEQD8LD+msarR8cU0eunedpbXwADQlGtFtqnfW62kFF6mLYtel8mvIHqxHx42b3WNlX/pej4HkGFNkSEFyuTz0KRv2xT0fSrDEDyTi0OsY6UGT2zkhJe6DxGN6DCLWafxsV+It2NgI+ARbTlgB62aghgDw4zW0gOyRH1oX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191150; c=relaxed/simple;
	bh=XvdEr0rtAUsaaj2FAPBy2EvPnAR8lN42xH2FKDhdjdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uzr/F5HK9neYJQ9zC9grNEC6C0HSeLKCUUaFmsuhC0jB84XXmsPuUkoMqUgO/5Vs9ugr3T/BdTkkdjqHds18QYEtAwPWuYD+bfG7IcVm3jWy8gNj4tc+jOEZ7PKdTJmDCbxZuF/iOQWucgHOXQfKXGvdAzc95KEnllSfZ9hkbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tXEKd5Zp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EQ/emdE6PrcLuK4Ml8PaAderGWf9M+zIFLx4mSWMk2w=; b=tXEKd5ZpSP2QHPW+qSdvowSKog
	ZJ29pKc3JWGSCzVgxsHyTr7jsRSOsMLA+pTGUJD/l8UNQRDMmA+eGf+n1v+MQF30TPQDgO1g7iylV
	Ghc3yJguxxKMWBTIuIa45/VJ8qw97Tl+LzfFID4s8H/fO9LAgj3A821izn9Cxa8k6edkgpOwsdHoo
	+nythdIGy4UC0jKZAPFus8J59tju2yfNGI/8TDHqhBeD0GzV2d8UKBjbPqZZGAAGbob1UU1S/fBJK
	Qyo2sjSLzGU4WsTzZ9QXW0kascnVa/gyfk3PvqVfRr0Q+7AGlwyCUX7UvH1eIjhnpW+6SqzW3oHlz
	bJJKbKiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPItP-00000001N45-16cr;
	Tue, 19 May 2026 11:45:47 +0000
Date: Tue, 19 May 2026 04:45:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Christoph Hellwig <hch@infradead.org>,
	Cyber_black <Cyberblackk@proton.me>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-api@vger.kernel.org
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
Message-ID: <agxNa6Whf_tcm3o6@infradead.org>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org>
 <20260518162048.GC9531@frogsfrogsfrogs>
 <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com>
 <20260519033126.GD9531@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519033126.GD9531@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6356-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 0965357E0EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 08:31:26PM -0700, Darrick J. Wong wrote:
> > The only way that I'm personally aware of to determine whether ranges
> > in two files are reflinked to each other (and the only efficient way
> > to find identical blocks to, say, archive a large directory without
> > reading all the contents) is FIEMAP.  I wrote some code to do this
> > awhile back (not in production use).  Yes, I realize that it might
> > have issues with dirty page cache.
> > 
> > Is there some other way to do this?  Could an API be added that
> > efficiently answers the actual question without revealing information
> > that shouldn't be revealed?
> 
> Well, yes, we *could* make yet another ioctl, but we could also just run
> fe_physical through a one-way u64 hash function and set
> FIEMAP_EXTENT_UNKNOWN if (say) you don't have CAP_SYS_RAWIO or
> something.  Then your comparison function might still work... maybe?

What is the actual use case for that dedup detection?  I.e. what is
considered duplicate?  Does the application already have candidate
ranges or does it scan the output for all fіles?

For xfs the rmap can directly tell you what is shared, but I can't think
of a good way to expose that, but part of that might be that I don't
understand what question is asked and why.

Note the FIEMAP output can give you the wrong answer, e.g. with XFS
and multiple devices, or for file systems that can do tail packing and
have small amounts of data for multiple files in the same block.

> Also note that FIEMAP still doesn't report devices, so you're still
> playing with fire on multi-device reflink-aware filesystems like XFS.

or even on f2fs despite the lack of reflink support if the caller is
dumb enough.  All that of course depends on what the caller is doing
based on the FIEMAP output.


