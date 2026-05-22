Return-Path: <linux-api+bounces-6385-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NWSF+BlEGoKXAYAu9opvQ
	(envelope-from <linux-api+bounces-6385-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 16:19:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C696E5B605D
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBC67302515F
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D32C317169;
	Fri, 22 May 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lpmCqZgx"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31041C319
	for <linux-api@vger.kernel.org>; Fri, 22 May 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459115; cv=none; b=JrD0PRIcZyGORs3DqgdLZWErdapKsqX7Ed9G4AUWOAfxWDXEn1IBhAUxjRdq7kdKkKLAIYc1Ohy8+90uR5IrkO0v7ZLWBCK6j2HoRhqZ/ozlsU+IZvRIkUHH394p7usfB+ubKtRDbx/plzE8FNJoEDuBtnMe0wKffkIoexG0QEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459115; c=relaxed/simple;
	bh=Z1KFUy7yFmT8phE2o51kuK/KVyikMTp1njUQtH61aiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfkTjpHGHrHZna1/b0HzhC5c+D26bdIXwkl9D7kq2++umulOs4MkmF4cCV4xng7FZjEUITaG1UfIo/IF8zTbe/9dbHVrghDW3J7bOF3yrqyI4e0Kec+aJ9weLttPkcpJi2u1x9ck+34sAa8fcxLPz7O3PE/WLcnEkBHS1JK21Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lpmCqZgx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-115-85.bstnma.fios.verizon.net [173.48.115.85])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64MEBFMM009434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779459078; bh=mHoK9Kgu4Ukogk/OuX5oJ2mC+IXl+XVKkhhR9Ymm7QI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lpmCqZgxMgz6LXGThL+FgpU/gHZm2q7cb9GG7Hmbw1HF0AaE+gTLZhx9dJOwJ0nAa
	 2x/e4DVdk6Mue88+of/m4/ffVBkjFqZKlQf1pjyNfEHE3qjYAT5bb4AA+yS6hK29dF
	 tpcNUTkTnuKZKnGb2yNXM1Xpq2G56JRBZFxvMjxungbdw4ZnXHfC9aHoYGP1zgzpe9
	 rCykZkCrU7T2G0hk7TF/PTaBZd6uVu1liAacXiKKP6Mtbrh5RAchLbF0HPslHhm0PS
	 hlvO2wQHeMa+U19lqVyv1mhCKetcXnea+xjcMVpqrI/U8nWD/W6aAO3aYuPE2RV/Mq
	 Mp2pkRBJcpAFA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 38EDE69D5323; Fri, 22 May 2026 10:11:15 -0400 (EDT)
Date: Fri, 22 May 2026 10:11:15 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <20260522141115.GA8258@macsyma-wired.lan>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag_OVwPF49LSZ7rz@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-6385-lists,linux-api=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+]
X-Rspamd-Queue-Id: C696E5B605D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 03:32:39AM +0000, Jaegeuk Kim wrote:
> I went this route because Android heavily restricts ioctl() permissions
> and we needed broader access for this to work within the framework. It’s
> definitely a pragmatic choice just to get it running in production.
> 
> If ioctl() is a right way for upstream, I'm happy to change this patch. By
> the way, I really don't understand why all the messages are so offensive,
> even without trying to understand the problem or guiding right directions.

The reason why some people were getting annoyed was because as a Linux
file system maintainer, there was an assumption that you would
understand that extended attributes --- especially in the user.*
namespace --- have an intended use case of storing a user-chosen small
piece of metadata that would be stored in the file system.

Hijacking user.fadvise such that it no longer persistent stores an
extended attribute for one specific file system --- such that if a
hypothetical user application might decide to store a piece of
application data in the extended attribute named "fadvise" would do
something completely different on a single mainline file system is in
such poor taste that I would have *hoped* that any Linux file system
maintainer would know that this a Really Bad Thing, such that if
someone in your development community suggested such an idea, you
would reject it.

And then, when people complained that it was a bad idea, and you
decided to put in the f2fs branch, such that it would show up in
linux-next, and there was no way for other file system developers to
object (short of appealing to Linus) --- well, that's basically you
taking advantage of your file system maintainer privileges.  And this
is why I started proposing whether we needed to appeal this to Linus
so he could make the call to reject something that the community had
already told you was in terrible, terrible taste.

As far as trying to understand why you were doing this --- I have to
turn that question around.  Why didn't *you* explain why you needed to
do this thing?  I went through the e-mail history, and I couldn't find
an explanation of why you decided to do this thing.  

Perhaps we need to add an explanation the Documentation directory
explaining what the intended use of the extended attribute case, and
perhaps referencing past cases were people tried to use this to bypass
the linux-api review process (f2fs's user.fadvise is not the first
time someone has tried to do this) thing), so that automated review
bots like Sashiko can explain why it's in such terrible taste to patch
authors, perhaps we need to do this.  Up until now, I think the
assumption is that file system maintainers would know something this
self-evident, and if not, if it was pointed out, they wouldn't try to
force such an ill-advised interface to Linus.

						- Ted

P.S.  As an exmaple of how I hanlded a somewhat similar scenario in
the past, my employer's cluster file system needed
FALLOC_FL_NO_HIDE_STALE to save $$$$ in TCO storage costs.  But the
concern was this would be an attractive nuisance for enterprise distro
users, who would see the massive performance increase, not realize
that this would leak stale data, which could result in user PII being
exposed, thus making life hard for Enterprise Linux's reputation.
(This wasn't an issue at $WORK because we enrypt all data at rest, and
the cluster file system daemon was a privileged server who (a) knew
what it was doing, and (b) only it would have access to set
FALLOC_FL_NO_HIDE_STALE.)

I disclosed *why* $WORK needed such a thing (it made a huge difference
to storage TCO costss for Google's Cluster Filesystem), and after
discussion and negotiation, we came to a compromise which involved my
keeping the (very small) patch out of tree, but reserving the code
point upstream to avoid future bitfield collisions.  They key here was
that I *knew* it was controversial, and I understood what problems it
might cause in the rest of the ecosystem.  That's part of the job of a
maintainer, and it's also why a company might want to hire a
maintainer.  They can represent the needs of multiple stakeholders ---
the upstream community, upstream users and the greater Linux
ecosystem, as well as their employer.

