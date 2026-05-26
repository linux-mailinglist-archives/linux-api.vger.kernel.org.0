Return-Path: <linux-api+bounces-6410-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE3lFcMdFWoVSwcAu9opvQ
	(envelope-from <linux-api+bounces-6410-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 06:12:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5816C5D099C
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 06:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B12F3004608
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 04:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AE382289;
	Tue, 26 May 2026 04:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNuGG/JC"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286653A6B8D;
	Tue, 26 May 2026 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768762; cv=none; b=O4CEUmap1Xyyr2WZIhRPbPpuPQ3H9f62Bc//zImFA2KEQhJ7BWnrQoZHh5qHhMvGQxDqOfCGo6qSiv7+8yjOame20nQEDVXU/xw1yW6RZQHxsXOhreArgqEZ3eSKIsnu1BRzE8ND9ZMTSMZtWWnrfZ3+3smmcPTfIDnz5bJunlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768762; c=relaxed/simple;
	bh=35aK1wtYELp/8cf46gTXnv8C1nRq1YD5vjk/UW6vuD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwx8yC8sftQtzy8fe18BUtnhebxUvHBy/J5TF6JqKsvJMk0P7e7FJquGuTYCNd3O8PexnUiw/+sVmmLy+UjsokIOWkJMyKunOHf3P8g8hQu+7O8ZnlQE1lOjTX2YvffS5XzIH1+WF7VO67P9dCKWIzN3G86ngSbhhOgAI5jmuxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNuGG/JC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E571F000E9;
	Tue, 26 May 2026 04:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779768753;
	bh=zolLXtUNuGgMGvntuicSbuzfsAN933tYyy3XaR95l44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lNuGG/JCaQFXm9DDXJufxSObLd3mxQYXUbJx58IGDqgyqXUXLdPw6Qum8nbATPHWY
	 5y2VYItqqlemNRDU4RYHDFJSue2sXB7QuSOk6n2bmNNK5t60yWIf2XVPU2xvz9XOqB
	 4tDOcHHdsg2zavU9J43B7Yf+uT1eeJgDZ5jMnzX/6kLtcAXzSv4gUknm8/CDjiFRtU
	 DbMMr04HINTanf9VBY8VWy2BPeuTqj+LeaBQhVBfYlXUceVNqK2M1f81lxUHFzgjIU
	 a2cniHjQE9QBikxhPJG6GvI7LUSdZmwi7xavsdN/6CaDs5RblpvPwwl+i3h6rFOHOs
	 WtFijc6Mq4nMg==
Date: Tue, 26 May 2026 04:12:32 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahUdsKSVV65qSvDm@google.com>
References: <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <8a42abed-8289-44ec-a144-dfe531a4af71@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a42abed-8289-44ec-a144-dfe531a4af71@infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6410-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5816C5D099C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/25, Randy Dunlap wrote:
> 
> 
> On 5/25/26 6:10 PM, Jaegeuk Kim wrote:
> > On 05/22, Theodore Tso wrote:
> >> On Fri, May 22, 2026 at 05:08:41PM +0000, Jaegeuk Kim wrote:
> >>>
> >>> Thank you for the explanation. It seems I made a wrong assumption on the
> >>> usage of "user." prefix where each filesystem can support in different
> >>> ways.
> >>
> >> The "user." prefix is used by all userspace applications that wish to
> >> store extended attributes.  For example, user.mime_type,
> >> user.xdg.origin_url, user.charset, user.appache_handler, etc
> >>
> >> For more information, see:
> >>
> >>     https://www.freedesktop.org/wiki/CommonExtendedAttribute
> >>     https://wiki.archlinux.org/title/Extended_attributes
> >>
> >> I certainly assumed this was common knowledge across all file system
> >> maintainers, but this was apparently not true in your case.  I don't
> >> know how this could be the case given that f2fs implements extended
> >> attributes, and I would have thought you would have known that when
> >> testing that feature.
> >>
> >>> I shared some motivation when replying to Darrick's feedback [1], but yes,
> >>> it was not enough for all heads-up. The problem started that some speicific
> >>> application needs as many high-order pages as possible mostly for reads. So,
> >>> I thought we can turn on large folio on the specific files per hints. One way
> >>> for the hints was using immutable bit, but it turned out it's very hard to
> >>> manage disabling the bit whenever deleting the files. Along with limited
> >>> ioctl() and requiring inode eviction to manage large folio activation, I had
> >>> to implement this path.
> >>>
> >>> [1] https://lore.kernel.org/lkml/aeA5C8byIpXWla7f@google.com/
> >>
> >> Actually, you still haven't explained your use case, at least, not
> >> well enough for me to understand what you are trying to do.
> >>
> >> So an application wants a particular file to use as many high-order
> >> pages as possible.  Why?  What sort of guarantees do you need to
> >> provide?  What happens if they can't be provided?  What happens if a
> >> possibly malicious, or at least gready, application uses this
> >> interface to grab a lot of high-order pages?
> >>
> >> >From your patch:
> >>
> >> 1. setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
> >>  -> register the inode number for large folio
> >> 2. chmod(0400, file)
> >>  -> make Read-Only
> >> 3. open()
> >>  -> f2fs_iget() with large folio
> >> 4. open(WRITE), mkwrite on mmap, chmod(WRITE)
> >>  -> return error
> >> 5. iput() and open()
> >>  -> goto #3
> >> 6. unlink
> >>  -> deregister the inode number
> >>
> >> Why should making the file read-only matter?  And when you say
> >> "derigster the inode number", why should this be related to deleting
> >> the inode?
> >>
> >> This is an interface which seems to be very specific to your use case.
> >> What if those requirements change over time?  What if you want pull in
> >> a file without making it be read-only?  And what if you want to
> >> release the large-order pages without deleting the file?
> > 
> > Let me try to write more details, helped with Gemini.
> 
> [as an interested reader:]
> 
> If this idea is so good, why shouldn't it be done in the VFS/MM so that
> other filesystems could do the same thing instead of just in f2fs?

Thanks for the feedback. I'm really open, but just trying to understand it's
good or not. If it's so bad at all, I'd be really ready to drop it even the
ioctl approach, even though I already prepared its implementation.

>
> 
> -- 
> ~Randy
> 

