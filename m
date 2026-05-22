Return-Path: <linux-api+bounces-6386-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDnmFb6OEGqcZgYAu9opvQ
	(envelope-from <linux-api+bounces-6386-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 19:13:34 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 604765B8036
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 19:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7999F3004223
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558E4779B1;
	Fri, 22 May 2026 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzJ6y0n+"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220E47799E;
	Fri, 22 May 2026 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779469724; cv=none; b=ukA5EmLDkJ91ptgnAMFZzAPZ4WTh8tx7xZpeaRcylGYdJ/u9uJdzEgAEB4LRcdkcZflmUGdTs5r+9F4Xshex5lZFB5RyYx9WrwJzeJVkP8uZQvujhVX7z+WrKh4VSgyS+r8Z3zH103uWOxCZ1OTHdLaHXvTUNA57w7M8feVfavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779469724; c=relaxed/simple;
	bh=6hF6rqEwrJD4s9VY7thyzGJ4hqC11lqcEw2MCFgUj1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsvHEz1XSFFFMIcbL6hb17Pzo/r42gUr8DTtCKFJxe4IMcngpo9Es0KclyIXOrAcMvQtLRjB5B5/sIUvO9rFWaNvofU5KmcvP9/7eqW1yxAE7KGGX1ompSwuzncZLfvv+2CWJe8M/uV0oTwOM7aTyZGiwlnQEYAowr7Ic1LwfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzJ6y0n+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79BE1F000E9;
	Fri, 22 May 2026 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779469723;
	bh=c23yxkM0+/60YQOR3FKGtI6McR78Ee+YJUODTCKTIss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OzJ6y0n+zfW4+8WQGFFIbfwbnhp6Kv+qBK9H1sgDjZOELbUwkG34A+MtzYhcyghwQ
	 nrfe+NcdHemO7jYCA7aV3PfT7SaOud7n/OQycUYBIhSL7CO9++tBPbXgcl/QS+69gf
	 n1cGbOPUqj2ZCfDoZbf4ImCy2xQSS3pyLRuKeOepf+0jBS3SPuTYdt2JZ1UV6wtj5o
	 Em/8yk5bmWeLIV1wWHSEaNiqviQ3BwSC+MLhXk2Fs44SXHCFCatdF9dA6hgWDbxiyE
	 fDpSnQbBwhWWCGTzo/yjjKcytOvjcNcAP1TEV5yc7GuI0KKFJ2ZEd+gvk++fOksqEZ
	 Uzp89DIhXWvGQ==
Date: Fri, 22 May 2026 17:08:41 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahCNmWbcd_2lAJyk@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522141115.GA8258@macsyma-wired.lan>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6386-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 604765B8036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/22, Theodore Tso wrote:
> On Fri, May 22, 2026 at 03:32:39AM +0000, Jaegeuk Kim wrote:
> > I went this route because Android heavily restricts ioctl() permissions
> > and we needed broader access for this to work within the framework. It’s
> > definitely a pragmatic choice just to get it running in production.
> > 
> > If ioctl() is a right way for upstream, I'm happy to change this patch. By
> > the way, I really don't understand why all the messages are so offensive,
> > even without trying to understand the problem or guiding right directions.
> 
> The reason why some people were getting annoyed was because as a Linux
> file system maintainer, there was an assumption that you would
> understand that extended attributes --- especially in the user.*
> namespace --- have an intended use case of storing a user-chosen small
> piece of metadata that would be stored in the file system.
> 
> Hijacking user.fadvise such that it no longer persistent stores an
> extended attribute for one specific file system --- such that if a
> hypothetical user application might decide to store a piece of
> application data in the extended attribute named "fadvise" would do
> something completely different on a single mainline file system is in
> such poor taste that I would have *hoped* that any Linux file system
> maintainer would know that this a Really Bad Thing, such that if
> someone in your development community suggested such an idea, you
> would reject it.

Thank you for the explanation. It seems I made a wrong assumption on the
usage of "user." prefix where each filesystem can support in different
ways.

> 
> And then, when people complained that it was a bad idea, and you
> decided to put in the f2fs branch, such that it would show up in
> linux-next, and there was no way for other file system developers to
> object (short of appealing to Linus) --- well, that's basically you
> taking advantage of your file system maintainer privileges.  And this
> is why I started proposing whether we needed to appeal this to Linus
> so he could make the call to reject something that the community had
> already told you was in terrible, terrible taste.

To be fair, I hadn't queued it in linux-next for weeks since the first
post, and was waiting for more feedbacks. If I was able to hear "user."
is a generic prefix used for all filesystems and use ioctl from the beginning,
I'd just drop and be able to start arguing with security folks back. Since
my employer is funding for production mainly, not much upstream work, I
couldn't sit and wait for the response for months. :(

> 
> As far as trying to understand why you were doing this --- I have to
> turn that question around.  Why didn't *you* explain why you needed to
> do this thing?  I went through the e-mail history, and I couldn't find
> an explanation of why you decided to do this thing.  

I shared some motivation when replying to Darrick's feedback [1], but yes,
it was not enough for all heads-up. The problem started that some speicific
application needs as many high-order pages as possible mostly for reads. So,
I thought we can turn on large folio on the specific files per hints. One way
for the hints was using immutable bit, but it turned out it's very hard to
manage disabling the bit whenever deleting the files. Along with limited
ioctl() and requiring inode eviction to manage large folio activation, I had
to implement this path.

[1] https://lore.kernel.org/lkml/aeA5C8byIpXWla7f@google.com/

> 
> Perhaps we need to add an explanation the Documentation directory
> explaining what the intended use of the extended attribute case, and
> perhaps referencing past cases were people tried to use this to bypass
> the linux-api review process (f2fs's user.fadvise is not the first
> time someone has tried to do this) thing), so that automated review
> bots like Sashiko can explain why it's in such terrible taste to patch
> authors, perhaps we need to do this.  Up until now, I think the
> assumption is that file system maintainers would know something this
> self-evident, and if not, if it was pointed out, they wouldn't try to
> force such an ill-advised interface to Linus.

I believe this helps a lot to all newbies like me.

I really appreciate your feedback.

> 
> 						- Ted
> 
> P.S.  As an exmaple of how I hanlded a somewhat similar scenario in
> the past, my employer's cluster file system needed
> FALLOC_FL_NO_HIDE_STALE to save $$$$ in TCO storage costs.  But the
> concern was this would be an attractive nuisance for enterprise distro
> users, who would see the massive performance increase, not realize
> that this would leak stale data, which could result in user PII being
> exposed, thus making life hard for Enterprise Linux's reputation.
> (This wasn't an issue at $WORK because we enrypt all data at rest, and
> the cluster file system daemon was a privileged server who (a) knew
> what it was doing, and (b) only it would have access to set
> FALLOC_FL_NO_HIDE_STALE.)
> 
> I disclosed *why* $WORK needed such a thing (it made a huge difference
> to storage TCO costss for Google's Cluster Filesystem), and after
> discussion and negotiation, we came to a compromise which involved my
> keeping the (very small) patch out of tree, but reserving the code
> point upstream to avoid future bitfield collisions.  They key here was
> that I *knew* it was controversial, and I understood what problems it
> might cause in the rest of the ecosystem.  That's part of the job of a
> maintainer, and it's also why a company might want to hire a
> maintainer.  They can represent the needs of multiple stakeholders ---
> the upstream community, upstream users and the greater Linux
> ecosystem, as well as their employer.
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

