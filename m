Return-Path: <linux-api+bounces-472-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7B182A377
	for <lists+linux-api@lfdr.de>; Wed, 10 Jan 2024 22:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A07B1F2239F
	for <lists+linux-api@lfdr.de>; Wed, 10 Jan 2024 21:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76174F603;
	Wed, 10 Jan 2024 21:39:56 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2D4F601
	for <linux-api@vger.kernel.org>; Wed, 10 Jan 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Wed, 10 Jan 2024 16:24:53 -0500
From: Rich Felker <dalias@libc.org>
To: musl@lists.openwall.com
Cc: linux-api@vger.kernel.org
Subject: Re: [musl] Protect pthreads' mutexes against use-after-destroy
Message-ID: <20240110212453.GR4163@brightrain.aerifal.cx>
References: <ec138086-c5b9-4ca2-9da5-bef8b14de27d@dustri.org>
 <20240109190726.GO4163@brightrain.aerifal.cx>
 <20240110015550.GP4163@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110015550.GP4163@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 09, 2024 at 08:55:50PM -0500, Rich Felker wrote:
> On Tue, Jan 09, 2024 at 02:07:26PM -0500, Rich Felker wrote:
> > On Tue, Jan 09, 2024 at 03:37:17PM +0100, jvoisin wrote:
> > > Ohai,
> > > 
> > > as discussed on irc, Android's bionic has a check to prevent
> > > use-after-destroy on phtread mutexes
> > > (https://github.com/LineageOS/android_bionic/blob/e0aac7df6f58138dae903b5d456c947a3f8092ea/libc/bionic/pthread_mutex.cpp#L803),
> > > and musl doesn't.
> > > 
> > > While odds are that this is a super-duper common bug, it would still be
> > > nice to have this kind of protection, since it's cheap, and would
> > > prevent/make it easy to diagnose weird states.
> > > 
> > > Is this something that should/could be implemented?
> > > 
> > > o/
> > 
> > I think you meant that the odds are it's not common. There's already
> > enough complexity in the code paths for supporting all the different
> > mutex types that my leaning would be, if we do any hardening for
> > use-after-destroy, that it should probably just take the form of
> > putting the object in a state that will naturally deadlock or error
> > rather than adding extra checks to every path where it's used.
> > 
> > If OTOH we do want it to actually trap in all cases where it's used
> > after destroy, the simplest way to achieve that is probably to set it
> > up as a non-robust non-PI recursive or errorchecking mutex with
> > invalid prev/next pointers and owner of 0x3fffffff. Then the only
> > place that would actually have to have an explicit trap is trylock in
> > the code path:
> > 
> >         if (own == 0x3fffffff) return ENOTRECOVERABLE;
> > 
> > where it could trap if type isn't robust. The unlock code path would
> > trap on accessing invalid prev/next pointers.
> 
> Unfortunately I discovered a problem we need to deal with in
> researching for this: at some point Linux quietly changed the futex
> ABI, so that bit 29 is no longer reserved but potentially a tid bit.
> This was documented in 9c40365a65d62d7c06a95fb331b3442cb02d2fd9 but
> apparently actually happened at the source level a long time before
> that. So, we cannot assume 0x3fffffff is not a valid tid, and thereby
> cannot assume 0x7fffffff is not equal to ownerdead|valid_tid.
> 
> This probably means we need to find a way to encode "not recoverable"
> as 0x40000000, as 0 is now the _only_ value in the low-30-bits that
> can't potentially be a valid tid.
> 
> I'll look at this more over the next day or two. It's probably fixable
> but requires fiddling with delicate logic.
> 
> Note that the only in-the-wild breakage possible is on systems where
> the pid/tid limit has been set extremely high, where attempts to lock
> a recursive or errorchecking mutex owned by a thread with tid
> 0x3fffffff could malfunction.

OK, more fun. The kernel documentation (locking/robust-futex-ABI.rst)
is *wrong*. It claims that, when processing the robust list for a
dying task, the only actions are:

 1) if bit 31 (0x80000000) is set in that word, then attempt a futex
    wakeup on that address, which will waken the next thread that has
    used to the futex mechanism to wait on that address, and
 2) atomically set  bit 30 (0x40000000) in the 'lock word'.

However, 2 is incorrect. There is no "set bit 30" operation in the
kernel. Rather, it atomically replaces the old lock value (tid of the
dying task, possibly with bit 31 added on for "waiters present") with
0x40000000 (no waiters) or 0xc0000000 (maybe waiters), clearing out
the tid of the dying task.

Thus, we cannot use 0x40000000 as the "not recoverable" value; this is
the only value the kernel ever used for "owner died" state.

At first this sounds good: we should be able to use any value with bit
30 set, including something like 0x7fffffff like we're using now, as
the "not recoverable" state. Unfortunately, that's not quite true. The
kernel's robust list processing at task death masks off bit 30, so if
a task with tid 0x3fffffff were to die with the unrecoverable mutex in
its robust list or or pending slot, it would wrongly get converted
back by the kernel from "not recoverable" state to "owner died" state.

Naively one would expect an already not-recoverable not to be able to
be added to the robust list, and this is correct; however, it can be
added to the pending slot if a thread attempting to lock it was
suspended after checking the old state, before it was in
not-recoverable state, but before attempting the atomic CAS to take
the lock, seeing that fail, and removing it from the pending slot.

I don't see any solution to this problem without having one or more
values of the low 30 bits (bits 0-29) that are reserved and guaranteed
never to match a real task. AIUI, Linux presently doesn't support more
than 22 bits of tid anyway, so this probably is not a real issue, but
it is an issue for future-proofing the user-kernel interface. What
we're doing now (using 0x7fffffff as the unrecoverable value) is
unsafe if Linux or any kernel purporting to honor the Linux syscall
API/ABI ever supports full 30-bit tids.

I think we should probably ask the kernel folks to reinstate the
original specification that bit 29 (0x20000000) is reserved and
guaranteed not to be present in a valid tid. If that's deemed
inappropriate, just reserving a single value 0x3fffffff that's
guaranteed not to be a real tid should suffice. Either would make what
we're doing now (based on the old pre-2020 documentation) valid and
future-proof once again.

Rich

