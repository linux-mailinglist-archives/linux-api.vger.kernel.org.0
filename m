Return-Path: <linux-api+bounces-6418-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBqcFVNHFmofkQcAu9opvQ
	(envelope-from <linux-api+bounces-6418-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 03:22:27 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0805DE379
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 03:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6858930074E4
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 01:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223B1E1DE5;
	Wed, 27 May 2026 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PSWDr8l0"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB91A6819
	for <linux-api@vger.kernel.org>; Wed, 27 May 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844939; cv=none; b=tYKvWpwAyFWwFBYdx4bi3dcrBLLPnkCZtQcqy40YY7LHgwxVE+HcktM/UWV1DZCO4WedlCMEQv4VEwEIttN9kMaZbihDUC+wkbel6A5jP9FhG7mZw6o0wREUBy+h1bJ9DGCxixT+0Rc3Y6GyrmPP+NeqtOmbt9w5Qi6bnlIXGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844939; c=relaxed/simple;
	bh=d6FL2Mdr+HKsCGFbQDFxJ5m6z3oHl+3HNqL8LQv3Hb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydxj7E+BC/RU9HTnH+0COn7jGtAPhfB7fQ2tbrmZbGhoYCwcliVnkNselT/XbZbCjHk+Tnch6uljcQE8UaRI03OVVna3CEGVCJ5/zgj6eky1EulUpEQkKiFXcHDkDi5wzPVwgx1CdmBS91r3kG+XcdK0kLCSM9u2OGGZheGBVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PSWDr8l0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64R1LhpE022642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 21:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779844907; bh=DJFkDvXxR0DjYA3xWYda2p1KUsjgyfsXRLcTLMKtZ+c=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PSWDr8l0xAxG+aO7NY0TUEScHYUAT3V1K6PjCEMN0Gxn7ksMEmUXWMzBHgXAR6Fz3
	 l9s+D8e3P0cM9uziJ/JcbbMnKrNZoaNK4EBsYi4ljiRX2KtqtM3uf4WRB2i0lzbZYr
	 qR3FneqDQww/s0jVBh1GakrN+rkZR+JGoW+N7YIaCJogB1WUuqkEIg++rTq1UfabQt
	 wln2UkUGPyOtKsWY7VWaMsjiZdy7GzUZlr1Jg1XiGUDgoblMJSzf06/8g0PvJ29Pf1
	 J6US3QBSYQDRI8t8isI8KP6cS+bC7W7MidFp7vFb96gFpK4GLP1P6dC3UlEMI3OgP+
	 Yij0XC/BpJXfQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 84D236B384FE; Tue, 26 May 2026 20:21:43 -0500 (CDT)
Date: Tue, 26 May 2026 20:21:43 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
References: <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <ahYWKH9-ybDlZuJd@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahYWKH9-ybDlZuJd@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6418-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5E0805DE379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 09:52:40PM +0000, Jaegeuk Kim wrote:
> > It seems... surprising that the additional I/O operations are actually
> > throttloing UFS device bandwidth by 2x (4GB/s vs 2GB/s).  Have you dug
> > into why this is happening, and whether there is anything that can be
> > optimized below the file system?
> 
> I can't tell the exact size tho, roughly it's between 1GB and
> 4GB. And, per lots of test results with various tunings, it turned
> out memory allocation speed was the culprit. If we use 4KB page, we
> couldn't get the full bandwidth unless we set the biggest core
> running the highest frequency.

OK, if we assume that the model file that you want to load is is 2GB
then the number of 4k pages that you need is a bit over half a million
(524288).  So if it take 1 second with large folios (2 GB/s as you
stated above), and half-second without (4 GB/s), then you're basically
saying that it was costing you half-second to allocate 524288
singleton pages.  And the whole point of this exercise is to save that
half second?

And I assume that these timing was using a performance cores, and part
of the goal here is to be able to use an efficiency core instead.

Did I get that right?

> > But the problem with using small folios is that if you want to
> > actually *use* the memory, unless you want to segment out the memory
> > so it can't be used for anything other than the AI models (e.g., by
> > using somthing like hugetlbfs) it's just going to break up the memory
> > into smaller folios.  So that's not actually going to *help* in actual
> > real life use cases.  It might help for your artificial benchmarks /
> > experiments, but in the real life case where Android applications are
> > running and fragmenting all of the device memory, the large folios
> > won't be available *anyway*.
> 
> Agreed it's hard to get this done perfectly tho, as the best effort on this
> particular AI model case, I focused on two timings when loading the models:
> 1) right after device boot, 2) dynamic loading when required. To secure high
> order pages, for 1), I disabled the large folio consumed by EROFS, while for
> 2), I tried to call compact_memory before loading the model. Both of cases,
> I could observe we could get fair amount of large folios. Yes, not 100% tho.

If (1) is a common case in real life, the thing to do would be grab
2GB of large folios early in the startup sequence, and then letting
erofs do its thing --- and then at the end of the startup, right before you
load the model, you can release the 2GB worth of large folios.

(That being said, I'm guessing #1 is actually not that interesting,
since as a percentage of the time that it takes for an Android device
to startup, is adding an extra half-second *really* going to be
noticeable by the user?)

But for case #2, that's the much more challenging case.  If you don't
call compact_memory() you're going to burn half a second to allocate
the 4k pages, since the large folios won't be available.  But if you
*do* call compact_memory() in a production ROM, depending fragmented the
memory is and how much memory have, calling compat_memory() could take
**minutes**.  So what's the point?

The bottom line is if it's right after device boot, there are simple
techniques that don't require hacking up the f2fs.  But in the
demand-loaded case, calling compact_memory() is the last thing you'll
want to do.  You're better either asking the mm to allocate the 4k
pages, or do whatever compaction it can do to just free up 2GB worth
of folios.  (Calling compact_memory() is overkill, and only makes
sense in the context of benchmark / proof of concept demo.)

Either way, trying to get file systems to avoid using large folios in
the hopes that this will speed up large AI model loading.... doesn't
seem to make sense.

If the problem is fundamentally about making 2GB worth of large folios
available in a way that takes significantly less time that just
allocating the model using half-million 4k pages, that's the question
that we should be asking Matthew and the mm folks.  Which is why it
was too bad we didn't raise this issue at LSF/MM earlier this month.

> Indeed, I was off from LSF/MM for years due to various product issues, not
> related F2FS tho. Let me make some effort to attend upcoming ones like LPC,
> if I can get the budget from company.

Next time, as a suggestion, feel free to raise the issue when the
LSF/MM CFP goes out, even if you don't think it's likely you will get
an invite.  Indeed, with a sufficiently interesting topic, that's the
way to *get* an invitation.  It will require breaking down the
technical requires as you and I have done for the last few messages on
this thread.

Even if you can't attend LSF/MM due to time or budget reasons, there
are a number of your colleagues who are attending, who could raise the
question on your behalf.  I've been known to do that once or twice on
behalf of other Google teams.  But it does require that you approach
the usual LSF/MM suspects a good 2-3 months before the conference so
we can help you craft the an appropriate response to the CFP.

Cheers,

					- Ted

