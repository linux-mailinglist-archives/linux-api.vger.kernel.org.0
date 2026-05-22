Return-Path: <linux-api+bounces-6378-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDmwIGfTD2p1QAYAu9opvQ
	(envelope-from <linux-api+bounces-6378-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 05:54:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C55AE696
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 05:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81D323011100
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 03:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84058349CE0;
	Fri, 22 May 2026 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fld1ypw9"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5F2D6E66;
	Fri, 22 May 2026 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422015; cv=none; b=U/YrYNFoye7eC1EJywlNighflbbIylzobshAuTSBjRft6IZpU57BWq2Vpd5Bqd+JPHY6Fprmk7NHz6snRmXCPYF+pkhGiRq+BBZg19qIU3CAGcMyEfbBMqY0hlRTuSG+2GTKhd6ySQuBk0PLFIus6kKmlNRm7F1/3RnGU8N9wZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422015; c=relaxed/simple;
	bh=z8xJgwMXu4yr5/7Jz4e9+O7bv7Cb81vDb98T8Xt0Qpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s45uWY2vvgI4+Z3vngT5s6cXzWT33x8jj6SvOJSJVIdEidKh8bftvu2ASYeKQ4UmUyKCLpdrXB2e6fSZUJZJHGUHlrb/BGHJ6KPsYzAUP4jjZX7J/WtVMXxMZvH1ndpy8vWPvuWn4okKXzFKRAEqnVDwjTwaD0+KAWSg+p5h3zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fld1ypw9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CA61F000E9;
	Fri, 22 May 2026 03:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779422014;
	bh=kB9u/fd5oqOyzn/d56rzTMKcyf+Gut0U9mtxblKihAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fld1ypw9APN84jvJm1OOVi3+ZHhpiCqzC8QK3ifg0qLQZgEH8RQwQdH9O+qgnCYrc
	 Sl4P80xhdmTewu6/ueUPwz49MOXYxB6UBItK5OTQ0jNrXM+RhuWFzcbq8/AWs+iJAF
	 sWwz/T9UUHbDSE6lBJmFzuV/C0rrwCCV/lVPg4G1C8T1NTPTVkDkijsvMe8RDW8nZA
	 LZLL7Urvwe4SUWrAFQbjev8VcLMOGCOX2SkHENYXY+5glXf5Ca4NrlNsci9Of0Z5lp
	 wuu95IWJCelZn/vv77Jo3iZBmgg6TAwqcTk9PAgwVxz35w1q73aBen2fJCrKohTcUa
	 sPyncu6PC/Yqw==
Date: Thu, 21 May 2026 22:53:31 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <20260522035331.GE5937@quark>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag_OVwPF49LSZ7rz@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6378-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 124C55AE696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 03:32:39AM +0000, Jaegeuk Kim wrote:
> On 05/21, Theodore Tso wrote:
> > On Thu, May 21, 2026 at 01:51:08AM -0700, Christoph Hellwig wrote:
> > > > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > > > patch.  There's no justification for why f2fs is so special that it
> > > > needs this.  What the hell is going on?  You know this is not the way to
> > > > get code merged into Linux.
> > > 
> > > None of this got properly answers, and this broken interface now landed
> > > in linux-next. IT is offloading a user.* xattr which is free-form
> > > user data with semantics that are weird to say it very nicely.
> > > 
> > > All this was done against the advice in the mailing list discussion.
> > 
> > So let me get this straight.  This is a magic xattr interface which is
> > not even persisted in the file system, but instead sets a 32-bit
> > bitmask in the struct inode which disappears once the inode gets
> > flushed from the inode stack.  And it uses a generic xattr name,
> > "user.fadvise".
> > 
> > There's no way in *hell* any other file system is likely to adopt such
> > a broken interface, so why didn't you just use an ioctl to set this
> > magic f2fs-specific flag?
> 
> I went this route because Android heavily restricts ioctl() permissions
> and we needed broader access for this to work within the framework.

It's straightforward (2 lines I think) to update Android's SELinux
policy to allow an ioctl in all domains.  So that doesn't seem like a
reason to not use an ioctl.  In fact this is actually a reason *to* use
an ioctl, as it shows that ioctls can be allowed/denied independently as
needed, whereas xattrs just use the file write permission.

- Eric

