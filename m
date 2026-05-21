Return-Path: <linux-api+bounces-6375-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAD/Ib4+D2pNIQYAu9opvQ
	(envelope-from <linux-api+bounces-6375-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 19:19:58 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4925AA156
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DA83316BE27
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6960368D70;
	Thu, 21 May 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LeZnGv0J"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D05366067
	for <linux-api@vger.kernel.org>; Thu, 21 May 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379173; cv=none; b=qvspvg2i1MAkGgoqtOD6XBPSFO3z4NZbSZckyUAA+BubgZKtHcO2GN5fMxjb+rHayKA7Xpyzlxxs3jSQYipzqFNMh2lIFtH+pe5lgLkxDoNCkvITG91IxDqYun/xSts0sjJ3MAbMHKtjR9+qjzvZfDpFnjyZF0gJtMQE2dt63rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379173; c=relaxed/simple;
	bh=ITJFTESfGkiZTJ+3PCXB6CFOd2Nk4sL6k7mS1hwhsjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bioImyRIqd68cyBUOvQoidz0Ssqd1NdFWWv5PKKB+4kqETzVgUyCEwvmAAGQiFoMkq/zfU++yS0PP0yTh/McIosE3lUIS4MY1a+SclL2cAfLkmS754Ye6knrZfErjrm8bPSxu8jGkFo9n+67e4gBTuj6AzQPHTKZvZnVt/nqD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LeZnGv0J; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-82-210.bstnma.fios.verizon.net [173.48.82.210])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64LFwmMB027517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 11:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779379133; bh=wTn+GnhNxMudbQm4gD4f9vF/cA4/h1qk9LUl7mxlP9c=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LeZnGv0Jw0KN2cpmFMusUp0BDqatOhD1eCiQmfJGgSNLUg5e9ogcoxiH08zwQBTnF
	 Isbjbd75Ih/THtpbE0NzEbyaBqEOHUW4oMUAPZPfhEWCT/lNsgyTmJtMnmgy8PrfuW
	 BfCE6Xd2aINXdkFM8v9YmztLozt2nQYwXF14OzBCSVWMM5JRHZmHy/ORKwcER/zpdO
	 wp+kflSZAS/eIj4l6at6x2ZNDzQvltChJnap/adzvNaQwU8bEhffLchG+vErQwXj6h
	 m03OA6B5NP9+kyki85Fnak+wng+fBb1/bKnpG7j7sNwn/cnhlJS0EskvLMdv4PcJeS
	 kgtMjFEiFg6Rg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 6B3A2697D19B; Thu, 21 May 2026 11:57:48 -0400 (EDT)
Date: Thu, 21 May 2026 11:57:48 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Akilesh Kailash <akailash@google.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
Message-ID: <20260521155748.GA79343@macsyma-wired.lan>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag7HfNryTmQ-bVIS@infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6375-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4B4925AA156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:51:08AM -0700, Christoph Hellwig wrote:
> > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > patch.  There's no justification for why f2fs is so special that it
> > needs this.  What the hell is going on?  You know this is not the way to
> > get code merged into Linux.
> 
> None of this got properly answers, and this broken interface now landed
> in linux-next. IT is offloading a user.* xattr which is free-form
> user data with semantics that are weird to say it very nicely.
> 
> All this was done against the advice in the mailing list discussion.

So let me get this straight.  This is a magic xattr interface which is
not even persisted in the file system, but instead sets a 32-bit
bitmask in the struct inode which disappears once the inode gets
flushed from the inode stack.  And it uses a generic xattr name,
"user.fadvise".

There's no way in *hell* any other file system is likely to adopt such
a broken interface, so why didn't you just use an ioctl to set this
magic f2fs-specific flag?

> I think at some point we just need to stop taking f2fs updates likes
> this.

Well, that's ultiamtely up to Linus.  I'll say that if I were Linus
(and I'm glad I'm not :-), and I saw this in a pull request, I'd
reject it out of hand.  But whether it's worth making a huge fuss and
asking escalating this mess to Linus, we probably should get a bit
more community consensus before taking such a drastic step.

Christian, since you're one of the VFS maintaienrs, what's your
opinion about escalating this to Linus?

					- Ted

