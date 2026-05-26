Return-Path: <linux-api+bounces-6403-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNl5JyXzFGrnRgcAu9opvQ
	(envelope-from <linux-api+bounces-6403-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 03:11:01 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEE5CF64A
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 920743017C16
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDB227B340;
	Tue, 26 May 2026 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enn6fEbc"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC39CA45;
	Tue, 26 May 2026 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779757859; cv=none; b=Tqd4slJm5U+ARb4QeHyGUYLHL6UBE51C38Jws6+O4rdsxzre72mRueMw7mldWn//gbYEuOEieFhMtRHMB7HjzKvPWWgOWc+k5BoacYy8OB4g/aAoiuhDm+Bv64dSA1X95a8D1ap+YxgIu9iEiSjMShsJjd49wUf2d9wft0EcmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779757859; c=relaxed/simple;
	bh=bX3HfcCiRm5ydvk/6O5+cH+kc+UaBg0ucCYCYzesGsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIpRuwBRZmdw1IiEeejyxDdGPoLkI+6/kS1D8W0cJi6y17P0sqxgcioxHnqV+uI8hQfH6oGFf5zX/Cs1fuguTNs7NsWLrndVq3o8b3t2i+Hr+YfxmSBzvNybEQwXmld6q6Fp6UPa2a8uaUgQIKU14fsSk1+NayuT8U8YBr1z3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Enn6fEbc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419911F000E9;
	Tue, 26 May 2026 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779757857;
	bh=8KtudcOxSvos7Bvf3DlHhV6S99t3w2rpbU5P7FcY4Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Enn6fEbcSDYSLXXU9tuWmlYyKtLN+m2e8UwpPc1rsxAkE97pNhQWlXAlduixrrUvG
	 3ZC+aOj9ajbuiWwQCPTKTYKGniF3t9Ave/L2cdwzGXNAGPNpdD9OuUTjXfbFF9lTKv
	 g37n63c+EP4zjliQGNiT3PRs6vQCBQ8ZR4SHrEgM3L4SPqOwqqUZEU7SVdV/gs8lgw
	 bE9hlCwY1arV6U2meLFVbJfTJ2d4rnP/iSWG0X+KiBKesXuisLqvA+kO4I24PKTDaz
	 eGSh4pdemHuXq0YDzI24c5MWF/tl6dUHgpSvJwhk7riCVLSAQiN73YrX/1JQFmbdhN
	 9FrMkNaCjY2GA==
Date: Tue, 26 May 2026 01:10:55 +0000
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
Message-ID: <ahTzHyHBL8t0iNBR@google.com>
References: <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522224108.GA18663@macsyma-wired.lan>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6403-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: E3FEE5CF64A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/22, Theodore Tso wrote:
> On Fri, May 22, 2026 at 05:08:41PM +0000, Jaegeuk Kim wrote:
> > 
> > Thank you for the explanation. It seems I made a wrong assumption on the
> > usage of "user." prefix where each filesystem can support in different
> > ways.
> 
> The "user." prefix is used by all userspace applications that wish to
> store extended attributes.  For example, user.mime_type,
> user.xdg.origin_url, user.charset, user.appache_handler, etc
> 
> For more information, see:
> 
>     https://www.freedesktop.org/wiki/CommonExtendedAttribute
>     https://wiki.archlinux.org/title/Extended_attributes
> 
> I certainly assumed this was common knowledge across all file system
> maintainers, but this was apparently not true in your case.  I don't
> know how this could be the case given that f2fs implements extended
> attributes, and I would have thought you would have known that when
> testing that feature.
> 
> > I shared some motivation when replying to Darrick's feedback [1], but yes,
> > it was not enough for all heads-up. The problem started that some speicific
> > application needs as many high-order pages as possible mostly for reads. So,
> > I thought we can turn on large folio on the specific files per hints. One way
> > for the hints was using immutable bit, but it turned out it's very hard to
> > manage disabling the bit whenever deleting the files. Along with limited
> > ioctl() and requiring inode eviction to manage large folio activation, I had
> > to implement this path.
> > 
> > [1] https://lore.kernel.org/lkml/aeA5C8byIpXWla7f@google.com/
> 
> Actually, you still haven't explained your use case, at least, not
> well enough for me to understand what you are trying to do.
> 
> So an application wants a particular file to use as many high-order
> pages as possible.  Why?  What sort of guarantees do you need to
> provide?  What happens if they can't be provided?  What happens if a
> possibly malicious, or at least gready, application uses this
> interface to grab a lot of high-order pages?
> 
> >From your patch:
> 
> 1. setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
>  -> register the inode number for large folio
> 2. chmod(0400, file)
>  -> make Read-Only
> 3. open()
>  -> f2fs_iget() with large folio
> 4. open(WRITE), mkwrite on mmap, chmod(WRITE)
>  -> return error
> 5. iput() and open()
>  -> goto #3
> 6. unlink
>  -> deregister the inode number
> 
> Why should making the file read-only matter?  And when you say
> "derigster the inode number", why should this be related to deleting
> the inode?
> 
> This is an interface which seems to be very specific to your use case.
> What if those requirements change over time?  What if you want pull in
> a file without making it be read-only?  And what if you want to
> release the large-order pages without deleting the file?

Let me try to write more details, helped with Gemini.

Background
----------
The primary use case is accelerating AI model loading, which demands
exceptionally high sequential read speeds. In our benchmarks on embedded
systems:
 - Using high-order page allocations allows the system to saturate the
   Universal Flash Storage (UFS) bandwidth, reaching 4 GB/s even at
   medium-to-low CPU frequencies.
 - In contrast, standard small folios cap performance at 2 GB/s.

The performance doubling stems directly from reducing CPU cycle overhead during
memory allocation.

Problem Statement
-----------------
High-order pages become heavily fragmented and scarce shortly after device boot.
We cannot afford to deplete these limited resources on default filesystem
operations using large folios. Instead, we need a mechanism to strictly
prioritize and reserve high-order allocations for specific, critical
payloads—specifically, large AI model files.

Design Principles
-----------------
 - Best-Effort Allocation: The system guarantees no fixed number of
 high-order pages. Allocation falls back gracefully from Order-10 down to
 Order-0 based on current memory availability.

 - Standard Page Cache Lifecycle: No custom or rigid memory management is
 introduced. These folios remain fully under the control of the Memory
 Management (MM) subsystem and can be reclaimed via the Least Recently
 Used (LRU) mechanism at any time.

 - Read-Only Optimization: To minimize code complexity (e.g., handling
 writeback, compression, and concurrency), this high-order allocation mechanism
 is strictly restricted to read-only files. The vast majority of performance
 gains are derived from read operations.

Questions
---------
Q: Why does an application require a specific file to utilize as many high-order
pages as possible?
A: It significantly boosts sequential read bandwidth in resource-constrained
 embedded systems by reducing the CPU overhead associated with page allocation
 during high-throughput I/O.

Q: What sort of guarantees does this mechanism need to provide?
A: No hard guarantees are provided. The filesystem provides a best-effort
 mechanism to attempt high-order page allocations for flagged inodes while the
 filesystem is mounted.

Q: What is the fallback behavior if high-order pages cannot be allocated?
A: The system treats the configuration as a performance hint. If high-order
 pages are unavailable, it seamlessly falls back to standard small folios.
 Functional behavior remains entirely unchanged.

Q: Why is restricting the implementation to read-only files necessary?
A: Limiting the scope to read-only files bypasses the architectural complexities
 of managing writes, dirtying pages, and compression in large folios, while
 still capturing the core performance benefits of high-speed sequential reads.

Q: What mitigations prevent a malicious or greedy application from abusing this
 interface to monopolize high-order pages?
A: The interface acts purely as a hint to the allocation path. Because it falls
 back to small folios when memory is tight, it poses no greater systemic risk
 than existing large-folio implementations used by other filesystems. Standard
 MM eviction and LRU paths remain fully active.

Q: Why is deregistering the inode number linked to inode deletion?
A: We need the high-order allocation hint to persist even if the inode is
 temporarily evicted from the VFS cache. To achieve this, we maintain a tracking
 list of hinted inode numbers. When a file is permanently deleted, its hint
 becomes obsolete, requiring us to deregister it from the list to prevent memory
 leaks or identifier reuse conflicts.

Q: How can an application release these large-order pages without deleting the
 file?
A: Pages allocated via this mechanism receive no special status in the page
 cache. They are managed by standard LRU logic and can be explicitly released by
 the user at any time using existing system calls, such as
 posix_fadvise(..., POSIX_FADV_DONTNEED).

Q: This interface seems highly tailored to a specific use case. What happens if
 these requirements evolve over time?
A: Massive AI model loading is a long-term architectural paradigm. Providing a
 targeted VFS/filesystem hint to optimize read bandwidth for specific large
 datasets is a highly practical, repeatable pattern that addresses a systemic
 bottleneck in embedded AI deployments.

> 
> 						- Ted

