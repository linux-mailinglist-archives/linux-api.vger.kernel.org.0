Return-Path: <linux-api+bounces-6384-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B/NLuFmEGoKXAYAu9opvQ
	(envelope-from <linux-api+bounces-6384-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 16:23:29 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF155B6122
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D6A30477E8
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49D413247;
	Fri, 22 May 2026 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxNBYUYp"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C441C313;
	Fri, 22 May 2026 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458710; cv=none; b=BHwNaqUrv3zpEG0+dChKO/GCZeE24Az1uWFZpArHq4LDOyXbipc/xiZVOv0yEul3nHwlW35Fyhl601JrifunO1H/HOkAzsP0vhs+Atriv1pzmQEPCTtRX1zJ0fSHU3BJuldWZfz/hnHBzPEsBr655nVjUhY6FT5bcwwxO/Xs8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458710; c=relaxed/simple;
	bh=2UZjwiT2X1cW7AhTepmwlyEVOZvzDO0GFHHZ7F3hu2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp7LQzxyXcvBWxx8f7fZ26XMoIMFbsTCcFgvfv0yvxOoS1jzvwh/lqaGvDXLpFs5/AsqTn5Iym+B4el+0OS0Fs1YBytl6Y7diudd0z1+tZiKBGpH+TD5N1oQ/QgiTcs1zYRwV9Sq/vkKA7KQ6qzLfp0yRDI8qcFZ6jLRNg/+Hxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxNBYUYp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490CD1F000E9;
	Fri, 22 May 2026 14:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779458701;
	bh=6Ie8d2ZAmeBfN3v2/FX4Pbrv/H8u5AdvngzMgJa2Mf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mxNBYUYpnAWw8vEEAYBoOy4sKcHYDEtI47yZ4w+/tWMhgmVlXSO42ghF4ocDrA/Aa
	 qEOD7hdtIQYl+6j50auuLdIOl4bUcsbtT55PmICGuXR7SyMh2ebncRH9j18harNy5s
	 qlg/hCMCHbwEcgsALFwbKABqFNiMuxZd3EMh9xh0gVby+C5KXSKR84QkV32rnI8LT2
	 0bJ3nVYCp8E/zU5w0An8h/WG1g338+A/m44oNUI74RvF777xYt+qVpBF6hWgaauV0t
	 7bt0Lz1+iQNY/540jiITxZLdfliZjCalbs6kr6IUzf0TtDKSgYbup6xFpsqphGMUf0
	 SoRh5hhyPT4Fw==
Date: Fri, 22 May 2026 14:04:59 +0000
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
Message-ID: <ahBii6bk0KbK_NHV@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahBSXyOi9b1jxNkX@casper.infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6384-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0BF155B6122
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/22, Matthew Wilcox wrote:
> On Fri, May 22, 2026 at 03:59:45AM +0000, Jaegeuk Kim wrote:
> > On 05/21, Matthew Wilcox wrote:
> > > On Thu, May 21, 2026 at 11:57:48AM -0400, Theodore Tso wrote:
> > > > So let me get this straight.  This is a magic xattr interface which is
> > > > not even persisted in the file system, but instead sets a 32-bit
> > > > bitmask in the struct inode which disappears once the inode gets
> > > > flushed from the inode stack.  And it uses a generic xattr name,
> > > > "user.fadvise".
> > > > 
> > > > There's no way in *hell* any other file system is likely to adopt such
> > > > a broken interface, so why didn't you just use an ioctl to set this
> > > > magic f2fs-specific flag?
> > > 
> > > I mean, yes, this API is horrendous.  But it's just another example of
> > > f2fs thinking it's somehow special and not just enabling large folios
> > > like other filesystems do.  This hurts everyone, not just people who use
> > > f2fs.
> > 
> > >From the production viewpoint, I raised a concern on setting large folio by
> > default, since that exhausts lots of high-order pages, which were needed for
> > essential system services and critical apps.
> 
> Random fears or actual data?

This was a quick buddyinfo right after booting the device.

Before:
Node 0, zone   Normal  22684  42284  28704  16901   9515   4566   1854    673    181     36    758

After disabling EROFS large folio:
Node 0, zone   Normal   8486   4732   2175   1161    697    272     82     19      3      1    856

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

