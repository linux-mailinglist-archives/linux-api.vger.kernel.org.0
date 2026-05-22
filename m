Return-Path: <linux-api+bounces-6382-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H9aABcrEGo1UgYAu9opvQ
	(envelope-from <linux-api+bounces-6382-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 12:08:23 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A35B1B4F
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 12:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32DC4309C279
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA553C585E;
	Fri, 22 May 2026 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuTE1gQM"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9323BED61;
	Fri, 22 May 2026 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444094; cv=none; b=oYVOyCI+2qLP83XdMfeiL0+Xgb3++qWT6ryOiAScrIq/z+xBeUOzEI0julY6cXyGWKHZWCNbWZ9VRLdy9mhpYbqfXrYUYL1JPfpj8+UCwGil8jwM3ljMnkrYbUCevz/7L4YWvllY6Ct0VG+In7ethjx8X5elNmA2SM2Wmpl7KLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444094; c=relaxed/simple;
	bh=1DLZ37kHhU1rHpEQEUMqDeqagX+iutwlVMzplz9dpLo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=FmORhYC03B6Esa/zyrE8KSe9C5DATKun7SJQyPZTP+Ub+i3OTiyU62jKHxFefRamnryeMGM6rEWQPX6uWj9q8N67hTP3o5onRo5W1hpJiIqp5VOZF91XtLVDHejnqERgQcWgfd1lvDRtJylHSOd3nLCfp87si2f8mZAOyU5SD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuTE1gQM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9161F000E9;
	Fri, 22 May 2026 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779444093;
	bh=ZUJJoHYpPqVRUhbcG+UWt+HVEM6K0BEVeHttssE5XbE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=DuTE1gQME7Jx//aKkceOJJnFYFECfnCnzPz6WQ0+Dp1jSLdzAgLScIoL2da/3pkoS
	 0A6vEGBqorCPVj6OCamZ8Tfap/3bnyQX+QmtZGZYeab5qlRw2+vKDqPID9QGVpxLq7
	 fAkTaGwnH25Eid1nQdCkxa0+qwbaG9XTztNh48zJNgAVodlmZKw3AJPnuoto5YaBSi
	 as7U27VbiP6G7JIBlfB9UHDpgqrmCMlnWiimFah3MEIvnkTcLPk+KFFH3eIUn6YIM2
	 yMbsk5vo9eYS0GYxc+yq2QBSOhiM0zrahxQlsLXfMFeVAsL+oJMd1SzAOMET+BPVGu
	 4g0lyvd0Kh0cg==
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Tso <tytso@mit.edu>, 
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>, 
 Christian Brauner <christian@brauner.io>
In-Reply-To: <20260522035331.GE5937@quark>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com> <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan> <ag_OVwPF49LSZ7rz@google.com>
 <20260522035331.GE5937@quark>
Date: Fri, 22 May 2026 12:01:29 +0200
Message-Id: <20260522-popkultur-spagat-beziffern-00f57ebc8fca@brauner>
X-Mailer: b4 0.16-dev-05c9c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1DLZ37kHhU1rHpEQEUMqDeqagX+iutwlVMzplz9dpLo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJaFa9032xQZB1ooTgrtQMj6mneF33Vt/Y9yTNLOL2p
 qCTQa1fO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbir8bI8LJK6YxQ3bHfec9e
 ue9dfSWkodnjwV+3YsOzy9zq2uxnnmZkuDmb/9RHxd64GRJ/ebK9ktU0E/gn7vSzNhBZq2mq05j
 PDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6382-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 621A35B1B4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-21 22:53 -0500, Eric Biggers wrote:
> On Fri, May 22, 2026 at 03:32:39AM +0000, Jaegeuk Kim wrote:
> > On 05/21, Theodore Tso wrote:
> > > On Thu, May 21, 2026 at 01:51:08AM -0700, Christoph Hellwig wrote:
> > > > > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > > > > patch.  There's no justification for why f2fs is so special that it
> > > > > needs this.  What the hell is going on?  You know this is not the way to
> > > > > get code merged into Linux.
> > > > 
> > > > None of this got properly answers, and this broken interface now landed
> > > > in linux-next. IT is offloading a user.* xattr which is free-form
> > > > user data with semantics that are weird to say it very nicely.
> > > > 
> > > > All this was done against the advice in the mailing list discussion.
> > > 
> > > So let me get this straight.  This is a magic xattr interface which is
> > > not even persisted in the file system, but instead sets a 32-bit
> > > bitmask in the struct inode which disappears once the inode gets
> > > flushed from the inode stack.  And it uses a generic xattr name,
> > > "user.fadvise".
> > > 
> > > There's no way in *hell* any other file system is likely to adopt such
> > > a broken interface, so why didn't you just use an ioctl to set this
> > > magic f2fs-specific flag?
> > 
> > I went this route because Android heavily restricts ioctl() permissions
> > and we needed broader access for this to work within the framework.
> 
> It's straightforward (2 lines I think) to update Android's SELinux
> policy to allow an ioctl in all domains.  So that doesn't seem like a
> reason to not use an ioctl.  In fact this is actually a reason *to* use
> an ioctl, as it shows that ioctls can be allowed/denied independently as
> needed, whereas xattrs just use the file write permission.

Thank you, I very much agree.


