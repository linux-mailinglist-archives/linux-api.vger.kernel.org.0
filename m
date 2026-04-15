Return-Path: <linux-api+bounces-6093-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w0ymKyMk4GnYcwAAu9opvQ
	(envelope-from <linux-api+bounces-6093-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 01:49:55 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B60409179
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 01:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E7F73024547
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 23:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84490329371;
	Wed, 15 Apr 2026 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge9Qbkzs"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107C277026;
	Wed, 15 Apr 2026 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776296991; cv=none; b=KOW/vpTWb0XHMdqzfWPaG/4HdjHGwwmhHSffflSNXMGNNgFkfELTun3Hdc3SkuYpRn3lUUW2fJAvlAkX/wz/yNDn7htAHshxM5YfjBlDWBHCq8chUm3Ldcchk+9hEliN0sH++eiO7xWZhQ6j5iV0cQzb3GTiTHnXMeEGTh84yo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776296991; c=relaxed/simple;
	bh=bhzPcr54kj93Lar47tpSoGS//g7BeP0fXCsSgCGIxx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMzohb4dQxcNSKknq1e/t7fTJGzBzo36oTMSa36Ws5VCBPLJKhZ1d2XUq9TxuiOSKtccI9WeLa3dYlUYRuUjCqPXZKvaI3Uw16Ul2XtuumMBSGcPGyIdwQn5//aIOq/myVvrqCCKQHvK0azyMavvU+wA0AjJ7XqQDt1VJVqGquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge9Qbkzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FA5C19424;
	Wed, 15 Apr 2026 23:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776296991;
	bh=bhzPcr54kj93Lar47tpSoGS//g7BeP0fXCsSgCGIxx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ge9QbkzscZBvCjcBhgKDz2GqrcXm/RrpTicTJ1C2AxNrzFCS+cW8ACjvA07sMrKqC
	 xczyLQTyKLi34rLkm0xjlzT2PHoDxArNE0y3v6NHbmv8nEVa5BTRhUTBUb07fCTh82
	 Q4xApYXqDybkAxwRJDqeViTN8mLxeZ5xw7bMwla0ea4V1SVp18q7wo7MQ1+kL2AvkV
	 vliMPs6Hvdt97hstZPQ3/HWpfeCPidYKckDGF/xGw5r1yT4fTBoXvrL/ShTbuJUbcq
	 6EdGABII3cr46jiuv2XfvazrXocFUOk3aNhbgl6MU74pARV3gd5SXMf/zoQHSHSjfM
	 6Akb1rdBni93Q==
Date: Wed, 15 Apr 2026 16:49:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
Message-ID: <20260415234950.GC114184@frogsfrogsfrogs>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <aeAK8mFxzgMOepmZ@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeAK8mFxzgMOepmZ@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6093-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 34B60409179
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 10:02:26PM +0000, Jaegeuk Kim wrote:
> On 04/15, Matthew Wilcox wrote:
> > On Wed, Apr 15, 2026 at 04:44:04PM +0000, Jaegeuk Kim wrote:
> > > On 04/14, Christoph Hellwig wrote:
> > > > Please add the relevant mailing lists when adding new user interfaces.
> > > > 
> > > > And I'm not sure hacks working around the proper large folio
> > > > implementation are something that should be merged upstream.
> > > 
> > > Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
> > > I'm not sure it's acceptable or not. 
> > 
> > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > patch.  There's no justification for why f2fs is so special that it
> > needs this.  What the hell is going on?  You know this is not the way to
> > get code merged into Linux.
> 
> I added two ideas in that email. Have you even tried to understand?

You want to establish "user.fadvise" as an extended attribute containing
a bitmask.  The sole bit defined in that attribute means "use large
folios", but you also have to change the file mode and set the IMMUTABLE
bit for it to actually do anything.

Meanwhile, you can't actually persist any of the fadvise(2) advice
flags, so the xattr name doesn't even make sense.  Maybe you meant to
call it "user.madvise" since the closest thing I can think of is
MADV_HUGEPAGE?

I've understood enough.  YUCK.

--D

