Return-Path: <linux-api+bounces-6353-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGpSKZLZC2p8PQUAu9opvQ
	(envelope-from <linux-api+bounces-6353-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 05:31:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D3A576D4D
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 05:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DE7D304291C
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 03:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9D24679C;
	Tue, 19 May 2026 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0+gOaCU"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848D1DDC33;
	Tue, 19 May 2026 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161487; cv=none; b=Y3XVvIUz7BIHNdqsMVFDr8FiwaQm+SEyJXsEO3harvmd49/O7qy9aA+CcEzFoUj6cif3DPFtFz4K66ZpvBSMfvsovmP+MvBCL4emZrTQawrRSogHgd4cu8zs/UeMEKj2TEx2E6LeuDcT+OAJsrkEE3s6Tv57bYRRMet59xTG7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161487; c=relaxed/simple;
	bh=kTGkqRB+Z94KPJ1zIV7OK1I5KYQG4zg5zfpxDcqli+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnwMEEbT+TfVzIDfy67ZuKGMFcOdZwscvkI7X/qTXTXP4jgLMrJJyOeL9sKGNstFusITiDv9S+jWpsIi8OwcpxToqPrjNlHlZ/m45JdtRYETXjgpHmXahMHYgNVwiAswQaxxAXDv1ZOPBEKIuVuG2LtOfk2h10Nh3fNj0KXdW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0+gOaCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEBAC2BCB3;
	Tue, 19 May 2026 03:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779161487;
	bh=kTGkqRB+Z94KPJ1zIV7OK1I5KYQG4zg5zfpxDcqli+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0+gOaCUl3celfwf6kjRbKJEdd7td1jV7euSKvE6vvIQ4TxjtEoq3/GN0mPM5EX8l
	 hlhhb0/mEQa5sIk9Oi6K5egOLS1rhqsftD3XLbFOf3cOLtC8ZpWMLpkLSRsOde7PO+
	 9mTC+tjw2RATs2ZpXC45vQRYiGiLAr0VWDQd/7wnhgusID/VZ1VEhg0LRCyJTFdgV8
	 4eMwwLhtv1g5knqoNjOwvOgiH3gu5MPk8PLoreNX3npP4iA5YfEY1yV4/k6Nom9kpg
	 VvqXeJshszeqcYIKRptVg1WHHBrPhGUpkMtGsPnEdRg0L0gL7obbKDqv5cgNaiDZGE
	 BEc5zWW9Whbmg==
Date: Mon, 18 May 2026 20:31:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Cyber_black <Cyberblackk@proton.me>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-api@vger.kernel.org
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
Message-ID: <20260519033126.GD9531@frogsfrogsfrogs>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org>
 <20260518162048.GC9531@frogsfrogsfrogs>
 <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6353-lists,linux-api=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 22D3A576D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:22:42AM -0700, Andy Lutomirski wrote:
> On Mon, May 18, 2026 at 9:21 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
> > > On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
> > > > Option B) Add a capability check to ioctl_fiemap() to match FIBMAP.
> > > > This restores the intended restriction, at the cost of breaking
> > > > unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefrag).
> > > > This option is a larger ABI impact and likely undesirable.
> > > >
> > > > The preferred fix is Option A, since FIEMAP has been available
> > > > unprivileged since 2008 with no reported security issues, and read
> > > > access to physical block layout is already implicitly available
> > > > through open() permission on the file.
> > >
> > > No, FIEMAP really should not be available unprivileged.  So I think B is
> > > the right thing.  Can you send a proper patch with a proper signoff?
> >
> > For anyone who might be relying on FIEMAP output to find sparse regions
> > -- don't.  FIEMAP is a lowlevel fs debugging interface; it won't tell
> > you about dirty pagecache backed by unwritten disk space.  cp was burned
> > by that a decade and a half ago.
> >
> 
> The only way that I'm personally aware of to determine whether ranges
> in two files are reflinked to each other (and the only efficient way
> to find identical blocks to, say, archive a large directory without
> reading all the contents) is FIEMAP.  I wrote some code to do this
> awhile back (not in production use).  Yes, I realize that it might
> have issues with dirty page cache.
> 
> Is there some other way to do this?  Could an API be added that
> efficiently answers the actual question without revealing information
> that shouldn't be revealed?

Well, yes, we *could* make yet another ioctl, but we could also just run
fe_physical through a one-way u64 hash function and set
FIEMAP_EXTENT_UNKNOWN if (say) you don't have CAP_SYS_RAWIO or
something.  Then your comparison function might still work... maybe?

OTOH nobody really wants Linus roaring at them, so we might all just do
absolutely nothing.

Also note that FIEMAP still doesn't report devices, so you're still
playing with fire on multi-device reflink-aware filesystems like XFS.

--D

