Return-Path: <linux-api+bounces-6381-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O1IOjspEGpQUQYAu9opvQ
	(envelope-from <linux-api+bounces-6381-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 12:00:27 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC305B192B
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C4AE300F974
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D13C4B76;
	Fri, 22 May 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqGHgDrZ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D43C3C01;
	Fri, 22 May 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443979; cv=none; b=CPXq9V/75+5S+W3MWiQFkpYK5LbmlCzTjmdw8pfHxRrdDuTxd61vQzZGNNsp20oSuzc22glWStH3pbHzWI4bSmcujilcMyAYnqhVQz1Co0fqGBNcZkm7jNUnG9rKLd8x4oL3qtdC9K4eEbAW6mne1x2bMZddfuB997KE0o7pnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443979; c=relaxed/simple;
	bh=YuVuEhwaHMb0Ugfecndd7/67rNAO5cvP1w5w6tDsGuw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iaDCLB1FGPk2CWhPn+Um2NHdyNjZrQPiFBt7JblFaqezLrh5bZ56Yo+IhwPerCNw72YQqbv8PVHjU0sagToOqLwXQmdk7L4OTFCwfaXT0kIV+VesdXqDqKm5vOYMQQ2JBv5LrJ6id9+VSA4QW2ldXUaqMWyuxm5Se/15Ibn/MBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqGHgDrZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3190A1F000E9;
	Fri, 22 May 2026 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443977;
	bh=8p0T4HNyPt2rtXXItCwHLCB30PYbM6+SRmeDyHpW9cw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=KqGHgDrZsdOsieHVKysVXhcHgaodUEd3YW69EUjImDXu74JlBtzE+02Vun3dI1EPC
	 9AdaM39GaGHFsm4W9fje1kSJnTeI+Bgsu4DfNFhXFRRQswSpxfNVxRjlw+HPqz8sa/
	 1HeGG9B0JdvT705Ndutn8tb1FsaJdTsnGAPsQEzuEIr4WQk2TZmKtWrniq+cHcTEx8
	 +h0XvbKl5qLScCnPomNuOS4jDsAhdrG9mZFrMkOd0T7N9F6zInDzfA3I4No0vUpmID
	 Z9fCZ9Pgd1wPc4NJyYicruwHkBPpuI6VQbfbdi5lE4IS4inSNUq/8Kh3FFnJ45Y8K5
	 S8PGC+EW4gutg==
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
From: Christian Brauner <brauner@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>, 
 Matthew Wilcox <willy@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 Akilesh Kailash <akailash@google.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-api@vger.kernel.org, 
 Christian Brauner <christian@brauner.io>
In-Reply-To: <20260521155748.GA79343@macsyma-wired.lan>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com> <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
Date: Fri, 22 May 2026 11:59:32 +0200
Message-Id: <20260522-stollen-fabuliert-helium-82376a109c5e@brauner>
X-Mailer: b4 0.16-dev-05c9c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YuVuEhwaHMb0Ugfecndd7/67rNAO5cvP1w5w6tDsGuw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQJaLJ9nsafzv/su3jKF497K1aGzw071/TmS38665l8H
 7/wtEWfOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyq5Hhf5qa1v/j2cyaK90u
 /pascZaX+2H0V3tm+4TPG0169h/25mJkeHl/+epvi1jLAjit1KbOXmerZxfQYFh8/urqWXN0vb/
 w8gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6381-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5EC305B192B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-21 11:57 -0400, Theodore Tso wrote:
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
> 
> > I think at some point we just need to stop taking f2fs updates likes
> > this.
> 
> Well, that's ultiamtely up to Linus.  I'll say that if I were Linus
> (and I'm glad I'm not :-), and I saw this in a pull request, I'd
> reject it out of hand.  But whether it's worth making a huge fuss and
> asking escalating this mess to Linus, we probably should get a bit
> more community consensus before taking such a drastic step.
> 
> Christian, since you're one of the VFS maintaienrs, what's your
> opinion about escalating this to Linus?

I think we don't need to involve Linus.
The interface as is is broken. Using xattrs for this makes no sense
whatsoever.


