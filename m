Return-Path: <linux-api+bounces-6487-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v+A5A5rDHWq9dgkAu9opvQ
	(envelope-from <linux-api+bounces-6487-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 19:38:34 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13B623583
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 19:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 077BB30440BB
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F41314D13;
	Mon,  1 Jun 2026 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C4F2CJUG"
X-Original-To: linux-api@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D683DD53E;
	Mon,  1 Jun 2026 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335213; cv=none; b=gh39mq3gW7O4Fqd32aQ0YedWoZTtOTUdw3Xg4/LlRsacaLof2pSLLL8gR4hB9kZyT+4nvwsBj9utWPSBSJ3R43AK/6qzfydoAhAX4QJc+YMAQNcZF3VsXSkcCY1ndjr8KSVDxPCtOumKz/Qf8gBC/qq7o0SjXGx9mV7hXachfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335213; c=relaxed/simple;
	bh=UIq0QwS9m8Vn34cqT2JX2YbbXgMu17lIdfl6g487i/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdkILFnRMUyVLYYjy1JgCGNfL+IQi+nzk0IcBHlDXFnETw5m3BYktdDARhD5cqEPFEHC2bNFI76pywy2aikqy3nxhb/j1f4jggDrCHIl4vj15363AWla2IWduT1NSerdQpMLpAHLiSTXnXQnHSIrbERj63x71S5oqZYT/RinF8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C4F2CJUG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UIq0QwS9m8Vn34cqT2JX2YbbXgMu17lIdfl6g487i/A=; b=C4F2CJUGwfl5xKazpWoseKj1wE
	WRgOlgnpACsA11o9vsmsB1IEgIxOgcMlpETmH2q+Pkmy5QKe6KOUTqNF+mzjFAZmW6fSabyetV2cW
	sg4PJwBvnYadtSQUsssgLJfv23FCBmBzKfIJqAjEkjJ8j6aMfSc6ff579wCMlKgyGVa+578BhJf+3
	aqYDiA+xagJzyAsdmYZ+Gofucv2YCBS1b4uUF8Ws6ne0a/OJF3nk0dr/nzPgMKLe6ZYQlNMD2P5vh
	7swJk2/OoPqvxRHMKexP/fcSrQDpePjfupzXW1wLMs+uMptCrx8erMt988UpqDtoAY4rWS8q83sDm
	jWgor8qg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wU6Vx-00000003Mll-0wOR;
	Mon, 01 Jun 2026 17:33:25 +0000
Date: Mon, 1 Jun 2026 18:33:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-api@vger.kernel.org,
	netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260601173325.GH2636677@ZenIV>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6487-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,linux-foundation.org,suse.de,szeredi.hu,lists.linux.dev,suse.cz,goodmis.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 5F13B623583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:

> TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> a big simplification.

FUSE might be interesting - fuse_dev_splice_read() and its ilk.
Communications between the kernel and fuse server at least used to
seriously want that, so that would be one place to look for unhappy
userland...

splice-related logics in fs/fuse/dev.c is interesting; another place
like this is kernel/trace/, but I'm less familiar with that one.

rostedt Cc'd (miklos already had been)

