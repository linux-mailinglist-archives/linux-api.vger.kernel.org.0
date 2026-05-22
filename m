Return-Path: <linux-api+bounces-6387-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B2PH9bbEGphewYAu9opvQ
	(envelope-from <linux-api+bounces-6387-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 23 May 2026 00:42:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B575BB316
	for <lists+linux-api@lfdr.de>; Sat, 23 May 2026 00:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0DA33009542
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 22:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A2A3921CC;
	Fri, 22 May 2026 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fzGRFuDb"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FAF391E7A
	for <linux-api@vger.kernel.org>; Fri, 22 May 2026 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489723; cv=none; b=G18SGCugrtuXeVO9GOPOjQOVh4bokjvYzprsfIr+wzPLY3Vs3Co6XJ9g7Se3bVYV9k5IDZO+wtZ8vi9rpzslYl/XyI6LbSaQAYkqGf+jc9Cv/FzO0qMT+QcyJIzZsz1yx8+53pYqplD8Td3eA8OmpWVxDnYnVd28woUgvKKoN3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489723; c=relaxed/simple;
	bh=jTrxt8pBQmnSCCuuYFcho0dAfhL+nI+Z9OqeP4ZdnG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCh1lBtKiR0iX1vJXQXnDVNOscNKM6Y7J51l4U9TMKyz7bvR+c5SNTOD4DEMbRz2NyXzcx6Wp2cl53c1e/YqBQkTGW/VC2MXAZA6v7UokAs7wT7iZ90WmXvf3iio/TP2e8ycrR+VEx7df4NYumvq+DsA8ay+t58tMCuXzUbrlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fzGRFuDb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-115-85.bstnma.fios.verizon.net [173.48.115.85])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 64MMf9rW014755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 18:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1779489673; bh=mKk+R/Gk87+i0eU1luqUgLxjRP4P7rgGxNJYbCK1vPs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fzGRFuDbzkUMu0uEQK2H4c1RfcgnLM3RfKHwG4javJ75OC9qF6AhAaDCLYfTMwPlz
	 of/InxBIn2Z19QZdFO9Lfn35k3wShr53V1AkPLqBH3y926x31L8yIiX5Ft+VhXuzZj
	 u6QWzugSykkNUHT2ZVgG3qguLUAzpDtoZQDbXZTjVM2bX8O4fdSlNwy/eEePJkgPbH
	 xkPsLmfmndIESLSSXVVw5gUV1IIehEFz4Ze8ZLr5XDmXaN6ar/CferRPBKhzJ1xyA5
	 xOcBMHr5C2Y9tZn++wyEJ2rpZjhv/cRPVTE2PhDddfmQdZgYpBQseZeb0sjiF8InMO
	 Oiul1xSVQJQJA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id DB24469EAC01; Fri, 22 May 2026 18:41:08 -0400 (EDT)
Date: Fri, 22 May 2026 18:41:08 -0400
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
Message-ID: <20260522224108.GA18663@macsyma-wired.lan>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahCNmWbcd_2lAJyk@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mit.edu:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6387-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E9B575BB316
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 05:08:41PM +0000, Jaegeuk Kim wrote:
> 
> Thank you for the explanation. It seems I made a wrong assumption on the
> usage of "user." prefix where each filesystem can support in different
> ways.

The "user." prefix is used by all userspace applications that wish to
store extended attributes.  For example, user.mime_type,
user.xdg.origin_url, user.charset, user.appache_handler, etc

For more information, see:

    https://www.freedesktop.org/wiki/CommonExtendedAttribute
    https://wiki.archlinux.org/title/Extended_attributes

I certainly assumed this was common knowledge across all file system
maintainers, but this was apparently not true in your case.  I don't
know how this could be the case given that f2fs implements extended
attributes, and I would have thought you would have known that when
testing that feature.

> I shared some motivation when replying to Darrick's feedback [1], but yes,
> it was not enough for all heads-up. The problem started that some speicific
> application needs as many high-order pages as possible mostly for reads. So,
> I thought we can turn on large folio on the specific files per hints. One way
> for the hints was using immutable bit, but it turned out it's very hard to
> manage disabling the bit whenever deleting the files. Along with limited
> ioctl() and requiring inode eviction to manage large folio activation, I had
> to implement this path.
> 
> [1] https://lore.kernel.org/lkml/aeA5C8byIpXWla7f@google.com/

Actually, you still haven't explained your use case, at least, not
well enough for me to understand what you are trying to do.

So an application wants a particular file to use as many high-order
pages as possible.  Why?  What sort of guarantees do you need to
provide?  What happens if they can't be provided?  What happens if a
possibly malicious, or at least gready, application uses this
interface to grab a lot of high-order pages?

From your patch:

1. setxattr(file, "user.fadvise", &value, sizeof(unsigned int), 0)
 -> register the inode number for large folio
2. chmod(0400, file)
 -> make Read-Only
3. open()
 -> f2fs_iget() with large folio
4. open(WRITE), mkwrite on mmap, chmod(WRITE)
 -> return error
5. iput() and open()
 -> goto #3
6. unlink
 -> deregister the inode number

Why should making the file read-only matter?  And when you say
"derigster the inode number", why should this be related to deleting
the inode?

This is an interface which seems to be very specific to your use case.
What if those requirements change over time?  What if you want pull in
a file without making it be read-only?  And what if you want to
release the large-order pages without deleting the file?

						- Ted

