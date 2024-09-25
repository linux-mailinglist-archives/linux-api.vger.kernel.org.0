Return-Path: <linux-api+bounces-2334-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760EA986141
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A638C1C26B75
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A81B3731;
	Wed, 25 Sep 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XiinWLMV"
X-Original-To: linux-api@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322C1B29D9
	for <linux-api@vger.kernel.org>; Wed, 25 Sep 2024 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272994; cv=none; b=Xmklx3YUBz46XJnzPZ7raCfqf2ROSUteq7GBCsKzMebpTefcztOKtDr/BeejR57nVI8K+avipxBQ1GqiuPxJmby521tvQz5rMgTvSgjueO+OoxRer3pkU/C+t4at38phLT5xX7NhngiyWaQDQL9DwyQP8poRYZ7BtlEWWAgov8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272994; c=relaxed/simple;
	bh=qckODCn1Qe91B/IOqDEMwpop7pD/4GWLDYxE60jAeNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mep77oW3g62i1H2XyPW6iamm4KqA+EEC+vYlGIxz3hK6qwpbcA9FWCwshwFvpxtEdgPkc2JHbvrHLc31hRhRN1am6kBAK+EGgee7fmazWWBcIcnc9tMKfal9RayNAZ0vjC9LpJqMI1ITJE1a3NRIQ0VFUXGUQHR1RpvMX9kHVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XiinWLMV; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Sep 2024 07:02:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727272987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5t463NG6eQ9jLF1YTXL/0TjCocLmn8Mda+WfoUOloPc=;
	b=XiinWLMVgLAFXBHkWWg+stYNqT4HftwpWwql5zrUkGf56VIJnBycuq0wrsWFr53xHFZd2Q
	pfJNKS/UZ8nX2VTTiyi01vbdQ0fKa9LlV3Jg30rG4uGmRQDh6enLUC+J6y/Zt/6UhKNdWU
	yVfeEOwFmSfpi6DyFPWg8LXvIYzV6sM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, christian@brauner.io
Subject: Re: [PATCH v2 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <xilfrvlstq4fqr46jlrzvq2vlr22nizdrwlcdizp774nlt6pfj@jukzlcwc7bed>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
 <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
 <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
 <4740dfc7-71da-4eb4-b071-35116288571f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4740dfc7-71da-4eb4-b071-35116288571f@lucifer.local>
X-Migadu-Flow: FLOW_OUT

Cced Christian

On Tue, Sep 24, 2024 at 02:12:49PM GMT, Lorenzo Stoakes wrote:
> On Tue, Sep 24, 2024 at 01:51:11PM GMT, Pedro Falcato wrote:
> > On Tue, Sep 24, 2024 at 12:16:27PM GMT, Lorenzo Stoakes wrote:
> > > process_madvise() was conceived as a useful means for performing a vector
> > > of madvise() operations on a remote process's address space.
> > >
> > > However it's useful to be able to do so on the current process also. It is
> > > currently rather clunky to do this (requiring a pidfd to be opened for the
> > > current process) and introduces unnecessary overhead in incrementing
> > > reference counts for the task and mm.
> > >
> > > Avoid all of this by providing a PR_MADV_SELF flag, which causes
> > > process_madvise() to simply ignore the pidfd parameter and instead apply
> > > the operation to the current process.
> > >
> >
> > How about simply defining a pseudo-fd PIDFD_SELF in the negative int space?
> > There's precedent for it in the fs space (AT_FDCWD). I think it's more ergonomic
> > and if you take out the errno space we have around 2^31 - 4096 available sentinel
> > values.
> >
> > e.g:
> >
> > /* AT_FDCWD = -10, -1 is dangerous, pick a different value */
> > #define PIDFD_SELF   -11
> >
> > int pidfd = target_pid == getpid() ? PIDFD_SELF : pidfd_open(...);
> > process_madvise(pidfd, ...);
> >
> >
> > What do you think?
> 
> I like the way you're thinking, but I don't think this is something we can
> do in the context of this series.
> 
> I mean, I totally accept using a flag here and ignoring the pidfd field is
> _ugly_, no question. But I'm trying to find the smallest change that
> achieves what we want.

I don't think "smallest change" should be the target. We are changing
user API and we should aim to make it as robust as possible against
possible misuse or making uninteded assumptions.

The proposed implementation opened the door for the applications to
provide dummy pidfd if PR_MADV_SELF is used. You definitely need to
restrict it to some known value like -1 used by mmap() syscall.

> 
> To add such a sentinel would be a change to the pidfd mechanism as a whole,
> and we'd be left in the awkward situation that no other user of the pidfd
> mechanism would be implementing this, but we'd have to expose this as a
> general sentinel value for all pidfd users.

There might be future users which can take advantage of this. I can even
imagine pidfd_send_signal() can use PIDFD_SELF as well.

> 
> One nice thing with doing this as a flag is that, later, if somebody is
> willing to do the larger task of having a special sentinel pidfd value to
> mean 'the current process', we could use this in process_madvise() and
> deprecate this flag :)
> 

Once something is added to an API, particularly syscalls, the removal
is almost impossible.

Anyways, I don't have very strong opinion one way or other but whatever
we decide, let's make it robust.

