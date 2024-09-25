Return-Path: <linux-api+bounces-2336-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D89864AC
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 18:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEAB28B1EC
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F83E49D;
	Wed, 25 Sep 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vVT+HoHW"
X-Original-To: linux-api@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC939FEB
	for <linux-api@vger.kernel.org>; Wed, 25 Sep 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281169; cv=none; b=KIPTzYqgvbM2GxCtclRc0ILomVUG6k1Ody3Ajodgu57EnfAtFokyVh2dgXWOLa+yOHMUYPe7IHDhCPvMIeIidWuxg7PAqnVFaw2DN2lJxjgID9m4Lw26XBJ9IhqRQl/ySrIi+n7GD3kMrUGLaXNocVz4KWlyJEmGseB7iZCr3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281169; c=relaxed/simple;
	bh=BV2a8idtNznVzDGHAz/mLNHpSkNlSHO+wTuGZIzNvSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0/dRenSHGg/iTEn2igL4Wp09hQsfvU8/fFwcKpFKdKcjaad406eMTVEeiZzimNdK/La3bqh5sJ3S4UXMwg8fn0SeaTN/IoeyV0J9YI0wjSH9jc/wgAt2yF7VO9j3tfPKl+JmEeQvOkd7+/BQxFmGci2fepvok2vKUB+KW7EPP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vVT+HoHW; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Sep 2024 09:19:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727281165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tBJk0rPPHbDUQHgsR/WgSoPYVaSEOecFXHLvPSFTqoI=;
	b=vVT+HoHWXwWr+gWC1gwr3m/Hapbg4kzKm6AHG6+ELPKP2zfVSmInmAjYbickdlALs5WKTo
	rPwQ3fY9QDCxf5qRD/VlKoByAD+GYY/7PJa9sSwLBCEIoOTYx2Wq+8NVs7GC4dmGYA0pnl
	WSSX3hCWRPSwcDpfVSrZIFSjRmoymJM=
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
Message-ID: <wvk5y3m47qmox4by6u3zpxtwartjmoaqaaqswbgui626zkjajq@22wjmqo36hes>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
 <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
 <u64scsk52b3ek4b7fh72tdylkf3qh537txcqhvozmaasrlug3r@eqsmstvs324c>
 <4740dfc7-71da-4eb4-b071-35116288571f@lucifer.local>
 <xilfrvlstq4fqr46jlrzvq2vlr22nizdrwlcdizp774nlt6pfj@jukzlcwc7bed>
 <7f40a8f6-c2f1-45f2-b9ff-88e169a33906@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f40a8f6-c2f1-45f2-b9ff-88e169a33906@lucifer.local>
X-Migadu-Flow: FLOW_OUT

I have no idea what makes you think I am blocking the feature that you
repond in a weird tone but let me be upfront what I am asking: Let's
collectively decide which is the better option (in terms of
maintainability and extensibility) and move forward.

On Wed, Sep 25, 2024 at 03:48:07PM GMT, Lorenzo Stoakes wrote:
> On Wed, Sep 25, 2024 at 07:02:59AM GMT, Shakeel Butt wrote:
> > Cced Christian
> >
> > On Tue, Sep 24, 2024 at 02:12:49PM GMT, Lorenzo Stoakes wrote:
> > > On Tue, Sep 24, 2024 at 01:51:11PM GMT, Pedro Falcato wrote:
> > > > On Tue, Sep 24, 2024 at 12:16:27PM GMT, Lorenzo Stoakes wrote:
> > > > > process_madvise() was conceived as a useful means for performing a vector
> > > > > of madvise() operations on a remote process's address space.
> > > > >
> > > > > However it's useful to be able to do so on the current process also. It is
> > > > > currently rather clunky to do this (requiring a pidfd to be opened for the
> > > > > current process) and introduces unnecessary overhead in incrementing
> > > > > reference counts for the task and mm.
> > > > >
> > > > > Avoid all of this by providing a PR_MADV_SELF flag, which causes
> > > > > process_madvise() to simply ignore the pidfd parameter and instead apply
> > > > > the operation to the current process.
> > > > >
> > > >
> > > > How about simply defining a pseudo-fd PIDFD_SELF in the negative int space?
> > > > There's precedent for it in the fs space (AT_FDCWD). I think it's more ergonomic
> > > > and if you take out the errno space we have around 2^31 - 4096 available sentinel
> > > > values.
> > > >
> > > > e.g:
> > > >
> > > > /* AT_FDCWD = -10, -1 is dangerous, pick a different value */
> > > > #define PIDFD_SELF   -11
> > > >
> > > > int pidfd = target_pid == getpid() ? PIDFD_SELF : pidfd_open(...);
> > > > process_madvise(pidfd, ...);
> > > >
> > > >
> > > > What do you think?
> > >
> > > I like the way you're thinking, but I don't think this is something we can
> > > do in the context of this series.
> > >
> > > I mean, I totally accept using a flag here and ignoring the pidfd field is
> > > _ugly_, no question. But I'm trying to find the smallest change that
> > > achieves what we want.
> >
> > I don't think "smallest change" should be the target. We are changing
> > user API and we should aim to make it as robust as possible against
> > possible misuse or making uninteded assumptions.
> 
> I think introducing a new pidfd sentinel that isn't used anywhere else is
> far more liable to mistakes than adding an explicit flag.
> 
> Could you provide examples of possible misuse of this flag or unintended
> assumptions it confers (other than the -1 thing addressed below).
> 
> The flag is explicitly 'target this process, ignore pidfd'. We can document
> it as such (I will patch manpages too).
> 
> >
> > The proposed implementation opened the door for the applications to
> > provide dummy pidfd if PR_MADV_SELF is used. You definitely need to
> > restrict it to some known value like -1 used by mmap() syscall.
> 
> Why?
> 
> mmap() is special in that you have a 'dual' situation with shmem that is
> both file-backed and private and of course you can do MAP_SHARED |
> MAP_PRIVATE and have mmap() transparently assign something to you, etc.
> 
> Here we explicitly have a flag whose semantics are 'ignore pidfd, target
> self'.
> 
> If you choose to use a brand new flag that explicitly states this and
> provide a 'dummy' pidfd which then has nothing done to it - what exactly is
> the problem?

IMHO having a fixed dummy would allow the kernel more flexibility in
future for evolving the API.

> 
> I mean if you feel strongly, we can enforce this, but I'm not sure -1
> implying a special case for pidfd is a thing either.
> 
> On the other hand it would be _weird_ and broken for the user to provide a
> valid pidfd so maybe we should as it is easy to do and the user has clearly
> done something wrong.
> 
> So fine, agreed, I'll add that.
> 

No, don't just agree. The response like "-1 is not good for so and so
reasons" is totally fine and my request would be add that reasoning in
the commit message. My only request is that we have thought through
alternatives and document the reasonsing behind the decided approach.

> >
> > >
> > > To add such a sentinel would be a change to the pidfd mechanism as a whole,
> > > and we'd be left in the awkward situation that no other user of the pidfd
> > > mechanism would be implementing this, but we'd have to expose this as a
> > > general sentinel value for all pidfd users.
> >
> > There might be future users which can take advantage of this. I can even
> > imagine pidfd_send_signal() can use PIDFD_SELF as well.
> 
> I'm confused by this comment - I mean absolutely, as I said I like the
> idea, but this just proves the point that you'd have to go around and
> implement this everywhere that uses a pidfd?
> 
> That is a big undertaking, and not blocked by this change. Nor is
> maintaining the flag proposed here egregious.

By big undertaking, do you mean other syscalls that take pidfd
(pidfd_getfd, pidfd_send_signal & process_mrelease) to handle PIDFD_SELF
or something else?

> 
> Blocking a useful feature because we may in future possibly add a new means
> of doing the same thing seems a little silly to me.
> 

Hah!!

> > >
> > > One nice thing with doing this as a flag is that, later, if somebody is
> > > willing to do the larger task of having a special sentinel pidfd value to
> > > mean 'the current process', we could use this in process_madvise() and
> > > deprecate this flag :)
> > >
> >
> > Once something is added to an API, particularly syscalls, the removal
> > is almost impossible.
> 
> And why would it be such a problem to have this flag remain? I said
> deprecate not remove. And only in the sense that 'you may as well use the
> sentinel'.
> 

My point was to aim for the solution where we can avoid such scenario
but it is totally understandable and acceptable that we still have to go
through deprecation process in future.

> The flag is very clear in its meaning, and confers no special problem in
> remaining supported. It is a private flag that overlaps no others.
> 
> I mean it'd in effect being a change to a single line 'if pidfd is sentinel
> or flag is used'. If we can't support that going forward, then we should
> give up this kernel stuff and frolick in the fields joyously instead...
> 
> Again, if you can tell me why it'd be such a problem then fine we can
> address that.
> 
> But blocking a series and demanding a change to an entire other feature
> just to support something I'd say requires some pretty specific reasons as
> to why you have a problem with the change.
> 
> >
> > Anyways, I don't have very strong opinion one way or other but whatever
> > we decide, let's make it robust.
> 
> I mean... err... it sounds like you do kinda have pretty strong opinions ;)

I am not sure how more explicit I have to be to but I am hoping now it
is more clear than before.

Shakeel

