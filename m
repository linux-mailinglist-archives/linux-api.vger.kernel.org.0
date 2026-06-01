Return-Path: <linux-api+bounces-6489-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNlSMHDnHWp0fwkAu9opvQ
	(envelope-from <linux-api+bounces-6489-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 22:11:28 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C8624EFE
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 22:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D015A3007C83
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625037BE70;
	Mon,  1 Jun 2026 20:04:18 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321032BF4B;
	Mon,  1 Jun 2026 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344258; cv=none; b=UqKSYFzdau8f6q+JPm0YR5Zy5kYlhTcVjvkNS8kR0/XawkNt86Gh0KVKBsQrDFI+to/fsukJE5zN2NFJPdD48TPQYsN9dJi7UzreQcNZHEbS1NGqwUu45VGzfbYbvBrbvxbLyBijPsmjXDTiT4dxREssL0wVMIG5xh4WatDYk1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344258; c=relaxed/simple;
	bh=uk0yKLHBz4R2ETgjnWSZXX0AwG/hvj2NvyoF/ETVPZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDH45j3HdnDLomY9ck0E54h1OD6zkunuYMiola00KDZ1VqL5C/a8s7ngre7GgQCfyEU0P8HlwWsUYF+OmBSuvqU8v4UE62VFb0jacoTyxjcpS4clih9ddscpYr2NXTxEVU8QXtmpXfYxqOl33o/ugXHAPXt13Goia6UUlfwDSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 68DA14070E;
	Mon,  1 Jun 2026 20:04:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A76E530;
	Mon,  1 Jun 2026 20:04:09 +0000 (UTC)
Date: Mon, 1 Jun 2026 16:04:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner
 <brauner@kernel.org>, Askar Safin <safinaskar@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, netdev@vger.kernel.org, Matthew Wilcox
 <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@infradead.org>, David Howells <dhowells@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Pedro
 Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
 patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, Jan Kara
 <jack@suse.cz>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260601160455.2c187574@gandalf.local.home>
In-Reply-To: <20260601173325.GH2636677@ZenIV>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
	<20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
	<CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
	<20260601173325.GH2636677@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: syidb8ujcaud9qkpckodykrwqszhs89e
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/l7NpaaKPpVVcYp6ykgwcyKHOTZkMF8KI=
X-HE-Tag: 1780344249-165888
X-HE-Meta: U2FsdGVkX1+J41g7IAS42JSeE5M9CFGhSVLKinkR5n5mo/WYVmBVHXBpB5cbIVL47VN3NsR+c1LBVIEHnhIvPvN6NQi5OTyaalsbrZEmg3uNAU4L5pjofHBefOVOwNAzq+bTYnik8yKJTyJaiIEZ//BclFM5tzba7zY+yq3qDmo5h2ghnrR+eDolpCZLEmUU1Ym4s93HTmeKQd6vDDUtwpZKMi4L2rkJyltTU8DXus3jvdVihyyTkULc+uoUj3MmLLV05SGgEjAXDGIG29TGeb2W66WTCW47AFMcODko/oJOuCEj3D+mT6s8K8FqbmRLqPBpAFWNEmeijv9MkxLF04LGCExu8JIYiaBNjan8sjAMgUDEmR1OwJeg5Jf7Echc
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-0.978];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6489-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 277C8624EFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 18:33:25 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
> 
> > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> > a big simplification.  
> 
> FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> Communications between the kernel and fuse server at least used to
> seriously want that, so that would be one place to look for unhappy
> userland...
> 
> splice-related logics in fs/fuse/dev.c is interesting; another place
> like this is kernel/trace/, but I'm less familiar with that one.
> 
> rostedt Cc'd (miklos already had been)

Thanks for the Cc. The tracing ring buffer was specifically made to be used
by splice and the libtracefs has a lot of code to use it as well. As
reading the ring buffer literally swaps out the write portion with a blank
read portion, that portion (sub-buffer) is used to be directly fed into
splice, providing a zero-copy of the trace data from the write of the event
to going into a file.

trace-cmd defaults to using splice to copy the tracing ring buffer directly
into files to avoid as much copying during live recordings as possible.

Whatever changes we make, I would like to make sure there's no regressions
in performance of trace-cmd record.

Thanks,

-- Steve

