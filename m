Return-Path: <linux-api+bounces-6419-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHymJlFaFmo9lgcAu9opvQ
	(envelope-from <linux-api+bounces-6419-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 04:43:29 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 045115DEA5B
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 04:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8385D300AB1F
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 02:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B563542D4;
	Wed, 27 May 2026 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny26pDgZ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740630B535;
	Wed, 27 May 2026 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849805; cv=none; b=oaAPrsAqi6jVozZ4+/Eh92E3P806JsGrSUfj1NSw7ap141rFYQq7nWVUABg7aN8Ai601viY73nwTbtWBOy0rt4nm4yIiHL+Gd5l4ChAHZemcLTE5yIXQtkm4bjt9J7xhJv2JDdieUmmytIoYUk/M3CYFAdTnpYBwpOB8IAF91ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849805; c=relaxed/simple;
	bh=QE3J2YMEUl0s3UKX2G1HSSLpUSwMk4WZlM2DR5RtF6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oomuumNKfrmdagrx4AgUjCvXS7u+j3h7R0uNteNkikwEkCE3dl/lfIUqma+zlpgRXPeuiT9HumiuBpH/Ud4Pc0PuO0NYGM6W7RpqzB+CFDzmgTMuEXWiHREhh5+5Upwhs9XZpp4O4/QvrQqxniGdg7beJGeIOXZnGjEdDoImiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny26pDgZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CA51F000E9;
	Wed, 27 May 2026 02:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779849803;
	bh=C1nuBMQZPJBWHgqL9hyljvS48WOhQs90dDmj4KPjIbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ny26pDgZPCLs9v4CxCOQAP2MxRb1/9vILo0qN0dihOg/EM1zL3/oRCluBSuR6mtPi
	 5hvm7I4KGLzcVR+d1mGv3Zt+10kmq3xDjtX/SHpb8KWDw7DU7tUHphnmIGJTZlfget
	 gnjSWNW3CcLdV+cnIBQwjIov5NpUalxlLjipXZk3ahldlukmbxICwRuyEtFn3QUP7k
	 aL8zMpEbxIQ1FXKEii/QhwHDuz8i7V1lo+C9CROKUs97zZQ3U2chXrmlrTj7XNCxSx
	 EOVIZ/vhWPcQxZqIB2ch0EmweOMkTmxBW1eXMQudMS48bPNsdDlm/v6K6GztH6O8x6
	 TepsgLundZL8w==
Date: Wed, 27 May 2026 02:43:21 +0000
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
Message-ID: <ahZaScMpx19ZLQi4@google.com>
References: <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <ahYWKH9-ybDlZuJd@google.com>
 <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6419-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 045115DEA5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/26, Theodore Tso wrote:
> On Tue, May 26, 2026 at 09:52:40PM +0000, Jaegeuk Kim wrote:
> > > It seems... surprising that the additional I/O operations are actually
> > > throttloing UFS device bandwidth by 2x (4GB/s vs 2GB/s).  Have you dug
> > > into why this is happening, and whether there is anything that can be
> > > optimized below the file system?
> > 
> > I can't tell the exact size tho, roughly it's between 1GB and
> > 4GB. And, per lots of test results with various tunings, it turned
> > out memory allocation speed was the culprit. If we use 4KB page, we
> > couldn't get the full bandwidth unless we set the biggest core
> > running the highest frequency.
> 
> OK, if we assume that the model file that you want to load is is 2GB
> then the number of 4k pages that you need is a bit over half a million
> (524288).  So if it take 1 second with large folios (2 GB/s as you
> stated above), and half-second without (4 GB/s), then you're basically
> saying that it was costing you half-second to allocate 524288
> singleton pages.  And the whole point of this exercise is to save that
> half second?
> 
> And I assume that these timing was using a performance cores, and part
> of the goal here is to be able to use an efficiency core instead.
> 
> Did I get that right?

Yes, right.

> 
> > > But the problem with using small folios is that if you want to
> > > actually *use* the memory, unless you want to segment out the memory
> > > so it can't be used for anything other than the AI models (e.g., by
> > > using somthing like hugetlbfs) it's just going to break up the memory
> > > into smaller folios.  So that's not actually going to *help* in actual
> > > real life use cases.  It might help for your artificial benchmarks /
> > > experiments, but in the real life case where Android applications are
> > > running and fragmenting all of the device memory, the large folios
> > > won't be available *anyway*.
> > 
> > Agreed it's hard to get this done perfectly tho, as the best effort on this
> > particular AI model case, I focused on two timings when loading the models:
> > 1) right after device boot, 2) dynamic loading when required. To secure high
> > order pages, for 1), I disabled the large folio consumed by EROFS, while for
> > 2), I tried to call compact_memory before loading the model. Both of cases,
> > I could observe we could get fair amount of large folios. Yes, not 100% tho.
> 
> If (1) is a common case in real life, the thing to do would be grab
> 2GB of large folios early in the startup sequence, and then letting
> erofs do its thing --- and then at the end of the startup, right before you
> load the model, you can release the 2GB worth of large folios.
> 
> (That being said, I'm guessing #1 is actually not that interesting,
> since as a percentage of the time that it takes for an Android device
> to startup, is adding an extra half-second *really* going to be
> noticeable by the user?)
> 
> But for case #2, that's the much more challenging case.  If you don't
> call compact_memory() you're going to burn half a second to allocate
> the 4k pages, since the large folios won't be available.  But if you
> *do* call compact_memory() in a production ROM, depending fragmented the
> memory is and how much memory have, calling compat_memory() could take
> **minutes**.  So what's the point?
> 
> The bottom line is if it's right after device boot, there are simple
> techniques that don't require hacking up the f2fs.  But in the
> demand-loaded case, calling compact_memory() is the last thing you'll
> want to do.  You're better either asking the mm to allocate the 4k
> pages, or do whatever compaction it can do to just free up 2GB worth
> of folios.  (Calling compact_memory() is overkill, and only makes
> sense in the context of benchmark / proof of concept demo.)
> 
> Either way, trying to get file systems to avoid using large folios in
> the hopes that this will speed up large AI model loading.... doesn't
> seem to make sense.
> 
> If the problem is fundamentally about making 2GB worth of large folios
> available in a way that takes significantly less time that just
> allocating the model using half-million 4k pages, that's the question
> that we should be asking Matthew and the mm folks.  Which is why it
> was too bad we didn't raise this issue at LSF/MM earlier this month.

Thanks for the context. To clarify a piece I missed earlier: the model pages
are also utilized for inference. Our data shows that larger chunks yield
higher inference speeds. Consequently, I required high-order pages to optimize
both read throughput and inference latency. I will halt my current efforts
and wait for alternative suggestions.

> 
> > Indeed, I was off from LSF/MM for years due to various product issues, not
> > related F2FS tho. Let me make some effort to attend upcoming ones like LPC,
> > if I can get the budget from company.
> 
> Next time, as a suggestion, feel free to raise the issue when the
> LSF/MM CFP goes out, even if you don't think it's likely you will get
> an invite.  Indeed, with a sufficiently interesting topic, that's the
> way to *get* an invitation.  It will require breaking down the
> technical requires as you and I have done for the last few messages on
> this thread.
> 
> Even if you can't attend LSF/MM due to time or budget reasons, there
> are a number of your colleagues who are attending, who could raise the
> question on your behalf.  I've been known to do that once or twice on
> behalf of other Google teams.  But it does require that you approach
> the usual LSF/MM suspects a good 2-3 months before the conference so
> we can help you craft the an appropriate response to the CFP.

Thanks for the suggestion. Will definitely do.

> 
> Cheers,
> 
> 					- Ted
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

