Return-Path: <linux-api+bounces-6377-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH9hJ2LOD2paPwYAu9opvQ
	(envelope-from <linux-api+bounces-6377-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 05:32:50 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE85AE5A3
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 05:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AD32300B50F
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 03:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB22280331;
	Fri, 22 May 2026 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU/IlB9S"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF50D1F8723;
	Fri, 22 May 2026 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779420762; cv=none; b=Ah+Y/Q40ZhF/g0exSVzKUM3+qLvMW6obM466R5mYZbwxywlTHgIOgy9LNzJeZhp+RqGUWeV1pqOTRn7LAbEETMtnxUqrFCCB1wRxXJyYjwcJia8lFHuV2H+5ehwSAFBPAV19MGmDzulKeEnI4/3L66Us1P5zUnr5JzdQ26cvcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779420762; c=relaxed/simple;
	bh=aTe607YLL2D2+izBI4lOWSP0MU1tNfq+EHSoE0D1GOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scImTC/Y7PdNH0MFMMFzNCseEjHzVDYUrvotq2nXoh0Re6L0LivLXW7iYjmDaEUrHNcFUBsDfpkI245i3Ktu8wThoghTMNUumfruygj+ZNOHVzl9VRvMROfRtGhSgsqZXqUKsdAGHNlj9HKpB8rw1LwE4OTI/DG58t4hBXGFbW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU/IlB9S; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240291F000E9;
	Fri, 22 May 2026 03:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779420761;
	bh=CGFAvI18BKBe3vm3c5WorkCHjUcjWwmCPrmYoSAlc2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XU/IlB9SH9nlFWYU/EiIad/OZNWTJfz8uzGq441tNsdlZHlxAhPQwtA2NOjDRpp9S
	 jsCQvoPHpW/b2EqxF4z9HctvBw2zcUUMvy0PL79CW7tF6sSr9KaxQilTtBvSpuNzqm
	 LQb87xxVBr99WUX4SXHuRN9DK8q+KFJ//Sw7qV26y3Fn9lfiqnc2QNNAuAppqwkISa
	 IzKvOiT+uSEDGkJ0H1/ydXDs9FselwOycC80O8y436kSj8vTfb/9oUcRB5YSJcxjNT
	 MqyLv9+oWkNXUQUAOs44eSNwTfA+PX8Cm5Fx7teBgjoWyybo8QhspPJkMRersifqVP
	 doyNr89pmQCpQ==
Date: Fri, 22 May 2026 03:32:39 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ag_OVwPF49LSZ7rz@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521155748.GA79343@macsyma-wired.lan>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6377-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A8AE85AE5A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/21, Theodore Tso wrote:
> On Thu, May 21, 2026 at 01:51:08AM -0700, Christoph Hellwig wrote:
> > > You haven't sent a proposal.  This is a reply to a reply to a reply of a
> > > patch.  There's no justification for why f2fs is so special that it
> > > needs this.  What the hell is going on?  You know this is not the way to
> > > get code merged into Linux.
> > 
> > None of this got properly answers, and this broken interface now landed
> > in linux-next. IT is offloading a user.* xattr which is free-form
> > user data with semantics that are weird to say it very nicely.
> > 
> > All this was done against the advice in the mailing list discussion.
> 
> So let me get this straight.  This is a magic xattr interface which is
> not even persisted in the file system, but instead sets a 32-bit
> bitmask in the struct inode which disappears once the inode gets
> flushed from the inode stack.  And it uses a generic xattr name,
> "user.fadvise".
> 
> There's no way in *hell* any other file system is likely to adopt such
> a broken interface, so why didn't you just use an ioctl to set this
> magic f2fs-specific flag?

I went this route because Android heavily restricts ioctl() permissions
and we needed broader access for this to work within the framework. It’s
definitely a pragmatic choice just to get it running in production.

If ioctl() is a right way for upstream, I'm happy to change this patch. By
the way, I really don't understand why all the messages are so offensive,
even without trying to understand the problem or guiding right directions.

> 
> > I think at some point we just need to stop taking f2fs updates likes
> > this.
> 
> Well, that's ultiamtely up to Linus.  I'll say that if I were Linus
> (and I'm glad I'm not :-), and I saw this in a pull request, I'd
> reject it out of hand.  But whether it's worth making a huge fuss and
> asking escalating this mess to Linus, we probably should get a bit
> more community consensus before taking such a drastic step.

Could I also raise a quick concern regarding the phrasing/wording used
in the communications?

> 
> Christian, since you're one of the VFS maintaienrs, what's your
> opinion about escalating this to Linus?
> 
> 					- Ted
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

