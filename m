Return-Path: <linux-api+bounces-6411-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNZfNHOkFWprWwcAu9opvQ
	(envelope-from <linux-api+bounces-6411-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 15:47:31 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF825D6CFA
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FA643005382
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C112D3A93;
	Tue, 26 May 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ejesU+18"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4293B637A
	for <linux-api@vger.kernel.org>; Tue, 26 May 2026 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802995; cv=none; b=aIVYmARWoREllUoygepDDOecjiO4Y4YiCaGBTqF9zycRv4LmN7aqkodx5xU6v1AfyGwSmCWP4YHpI+Ta0/jpYN3BbcwUUFWrGargwNGycrTbCmnJAke7fXZ8GGia3Zs2DWOTWXYYRYUkQMnRr9KwbqJRm5wPXboiUBUwdYBuxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802995; c=relaxed/simple;
	bh=jsX56txrjgQIZ0fr7cEDTrpi3QveEJSs5gg+iLcN8YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhApVDo2uRwf3/QF3Hs8LAzdHbSQ0Wnrtd48VhGjpKwlSXayd+sbtUWDKykUssA9h7gLi9OIhoGRJiT4U8HBLBDCwZa99mdaA8kAXHokuBQCL6BObXmsUF9oOKV8tdT+kKSy7oeXesMLeJkncEF2aQwsDn9VURvI8yv8/1CK1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ejesU+18; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64QDgKbw016888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 09:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779802946; bh=03Ae6RWKd6EnbPpHHfvNMfYhJeKoYpqPfXah8lU8jAo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ejesU+18AVFFIEgBaVKUv1hsYDQbQOg6W/J3OH9yYwjHCIb+jpqlrXpt7KIGFvPSr
	 2ht/krbvYSvIBKP5sZEAjbhEuE7NL0QJt0YgO2g1S4v3XDL1RR7qoft1xNr7FQPzka
	 Hwo8LpmDOwrc3SQGOlv+wHY1Wps6J/GMV8xeaovvUDIbVbEF4UWSI1igFd+XnkAldn
	 PfbQ90HPxiIGNmRMH+x0KVLVvGWyDA3vJG8EknOdtJikYP3UixBrFiteufTcdEKT9w
	 wD4NduZ5RLVuaoFmZzDQYDwHkVZ/sYNwLAIREliUiPZLApHgIQO7Bf54STmkIdX8Zw
	 hZdbOvYuIOKBA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 137D16B282ED; Tue, 26 May 2026 08:42:20 -0500 (CDT)
Date: Tue, 26 May 2026 08:42:19 -0500
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
Message-ID: <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
References: <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahTzHyHBL8t0iNBR@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6411-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4AF825D6CFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:10:55AM +0000, Jaegeuk Kim wrote:
> Background
> ----------
> The primary use case is accelerating AI model loading, which demands
> exceptionally high sequential read speeds. In our benchmarks on embedded
> systems:
>  - Using high-order page allocations allows the system to saturate the
>    Universal Flash Storage (UFS) bandwidth, reaching 4 GB/s even at
>    medium-to-low CPU frequencies.
>  - In contrast, standard small folios cap performance at 2 GB/s.

So you're interested in optimizing the I/O speeds.  And apparenty, on
your hardware, the UFS controller has limits on scatter-gather entries
--- UFS seems to call this Physical Region Description (PRD) table
entries.  Per Gemini:

    1. PRD Segment & Length Limits
	
	Maximum PRD Entries: Hardware limits typically cap the number
	    of PRD entries (or segments) to 255 or 256 per transfer
	    request.
	
	Maximum Transfer Length: Each individual PRD entry typically
	    allows a maximum transfer size of (65,535 bytes) per segment.

    2. Host Controller Hardware Limits (UFSHCI)
    
	Transfer Queue Depth: A UFS controller supports a predefined
	    number of outstanding task request entries. This is often
	    hard-capped at 32 concurrent transfer requests (slots) by the
	    doorbell register array.
	
	Descriptor Pre-fetch: Some UFS host controllers are
	   pre-configured to pre-fetch multiple PRD entries sequentially
	   before requiring main memory reads.

Is this an accurate description of the limits that you are trying to
work with?  How much data are you trying to read?  Looking at Gemma 4
models, E2B is about 10GB or 3GB for the 4-bit quantized version.  E4B
is 15GB, or 5GB for the 4-bit quantized version.  Is that about right?

It seems... surprising that the additional I/O operations are actually
throttloing UFS device bandwidth by 2x (4GB/s vs 2GB/s).  Have you dug
into why this is happening, and whether there is anything that can be
optimized below the file system?

> Problem Statement
> -----------------
> High-order pages become heavily fragmented and scarce shortly after
> device boot.  We cannot afford to deplete these limited resources on
> default filesystem operations using large folios. Instead, we need a
> mechanism to strictly prioritize and reserve high-order allocations
> for specific, critical payloads—specifically, large AI model files.

There's a fundamental assumption here, which is that the only use of
high order pages is the page cache.  This doesn't take into account
anonymous pages used by programs that isn't backed by files.  Nor does
it take into account kernel memory allocations.

But that being said, you seem to be assuming that you can reduce the
pressure on high order pages by only using large folios for these AI
model files.

But the problem with using small folios is that if you want to
actually *use* the memory, unless you want to segment out the memory
so it can't be used for anything other than the AI models (e.g., by
using somthing like hugetlbfs) it's just going to break up the memory
into smaller folios.  So that's not actually going to *help* in actual
real life use cases.  It might help for your artificial benchmarks /
experiments, but in the real life case where Android applications are
running and fragmenting all of the device memory, the large folios
won't be available *anyway*.

> 
> Q: Why is deregistering the inode number linked to inode deletion?
> A: We need the high-order allocation hint to persist even if the inode is
>  temporarily evicted from the VFS cache. To achieve this, we maintain a tracking
>  list of hinted inode numbers. When a file is permanently deleted, its hint
>  becomes obsolete, requiring us to deregister it from the list to prevent memory
>  leaks or identifier reuse conflicts.

Assuming that the high-order allocation hint is a good thing, why not
just make it persistent?  e.g., just a *real* extended attribute
(which is more wateful of space), or grab a flag in the on-disk f2fs
inode?  Then you don't need to have an in-memory list of hinted
inodes; instead, you can just have the Android package manager set
that flag indicating that you want that special treatment.  This is
all assuming that we need an explicit hint, though....

> Massive AI model loading is a long-term architectural
> paradigm. Providing a targeted VFS/filesystem hint to optimize read
> bandwidth for specific large datasets is a highly practical,
> repeatable pattern that addresses a systemic bottleneck in embedded
> AI deployments.

It's really too bad you didn't propose this as a LSF/MM topic, and
presented this at a session at Zagreb two weeks ago.  That would have
been a much more upstream-friendly way of collaborating, and it might
have allowed the mm experts to give you some more dynamic, real-time
feedback.

Cheers,

					- Ted

