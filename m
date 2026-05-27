Return-Path: <linux-api+bounces-6429-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C76M8ISF2pf3QcAu9opvQ
	(envelope-from <linux-api+bounces-6429-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 17:50:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640965E72F9
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 17:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBCDF315C8B5
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9E53E833D;
	Wed, 27 May 2026 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRr7GJAh"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D583E9C3B;
	Wed, 27 May 2026 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896530; cv=none; b=YrBHqqxEmdfScDOx3CgO2C5p/hbsCMEer7/iKZjBHFQM3eqSyVY0X/mSl9LQ8GmS/yuxe3qz0z62q4RYmwZgAkT4JoeapPkqhZW4khwWAw29emROoKsPM4hRmTVfC1apqloxeEvndWIRZRCWkPKsHlDdCLn92x2Q7oEwjbaPR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896530; c=relaxed/simple;
	bh=y7oQWBYfTpCXRP7FFofHXQK7lW19z+Kk9GvcjC2vAcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSNzMuaQ+ZB4zXwo5Bf3KyK1XdeeT0aKOK+5bIHOLstlG9H+0pcmQFDA8qE8GCQ4snjWgo6zjnVN8BKX+U5dB0vhEoYooUWZCHB+gACZJEKZ63yvbfgoZ3VAoodNFHdcQS74xDPIq2wqpeGPsL/nn/WoioU6rPDNzspSu4Z35do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRr7GJAh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959161F000E9;
	Wed, 27 May 2026 15:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896529;
	bh=zMuKNG4HxYra3vlaS9CtWig32q9g8dK7SLHIEtEzN2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jRr7GJAhGlahPzN0bmeBXmtT0my8GCvw8BEnvoA0LHYmPZeF2NiGk/GoK4nW4iAI2
	 ah3DD6/iXQ06gmV829oiq4bltVzTjc4l9q/dzZxerNzX0v35Ht2iMEHMJ2Emrqt67I
	 MC9X0Ve2SmiTTeUv8lJORBTKQNvbigYOqlPLtBZtmWYaZSp8lVMgMDzjob8fkxb5hQ
	 FvBEW+y9hVHlppwfRLE2LN/rhcRUt55KCb8XV4FkKz5AVg1tN2pOESYeRx/RNoE2m0
	 aY4/qERt8Yjo9xLdjWHct8cXrh7SN9YUdfxwFBPRCtp+SF81vbpHlwAfuGPCj/WoLj
	 oqBb9fXdQZb2Q==
Date: Wed, 27 May 2026 15:42:07 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Tso <tytso@mit.edu>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahcQz9Z227RoWOFL@google.com>
References: <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com>
 <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
 <ahUF7HqSKFJ422bU@casper.infradead.org>
 <ahaOpdw7NgsWe8J4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahaOpdw7NgsWe8J4@infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6429-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 640965E72F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/26, Christoph Hellwig wrote:
> On Tue, May 26, 2026 at 03:31:08AM +0100, Matthew Wilcox wrote:
> > > > And what are you trying to say us with that?
> > > 
> > > This means, high-order pages were used up by EROFS which sets large folio by
> > > default. So, I wanted to say the concern was based on actual data which was what
> > > Mattew asked.
> > 
> > This isn't that though.  What you actually need is to show that high order
> > allocations are _failing_.
> 
> Exactly.
> 
> > If what you want is large folios readily available, then what you want
> > is large folios used _everywhere_ because then they're easy to get!
> 
> Yes.
> 
> > If there's small folios in use, you need to reclaim a lot of memory in
> > order to reassemble large folios (it's the birthday paradox, similar to
> > the hash collision problem).
> 
> Yeah.  Although it seems we have an issue with > order costly folios
> at the moment, but we should fix this.
> 
> And f2fs really needs to up the game and support large folios fully
> so that we can run that kind of analysis there as well, without this
> all this is just piling hacks on top of other hacks.

Ok, I'll revisit the large folio support in f2fs, and try to revisit the
problem afterwards.

Thanks,

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

