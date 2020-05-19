Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848211D94D7
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgESLBh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 07:01:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42636 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgESLBh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 07:01:37 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jb001-0006AP-LY; Tue, 19 May 2020 11:01:29 +0000
Date:   Tue, 19 May 2020 13:01:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: seccomp feature development
Message-ID: <20200519110128.oot4zzxhivtmk7us@wittgenstein>
References: <202005181120.971232B7B@keescook>
 <20200519070929.55r3xvybjg6nnbsj@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519070929.55r3xvybjg6nnbsj@yavin.dot.cyphar.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 19, 2020 at 05:09:29PM +1000, Aleksa Sarai wrote:
> On 2020-05-18, Kees Cook <keescook@chromium.org> wrote:
> > ## fd passing
> > 
> > Background: seccomp users want to be able to install an fd in a
> > monitored process during a user_notif to emulate "open" calls (or
> > similar), possibly across security boundaries, etc.
> > 
> > On the fd passing front, it seems that gaining pidfd_addfd() is the way
> > to go as it allows for generic use not tied to seccomp in particular.
> > I expect this feature will be developed orthogonally to seccomp (where
> > does this stand, BTW?). However, as Sargun has shown[1], seccomp could
> > be friendlier to help with using it. Things that need to be resolved:
> > 
> > - report pidnr, or pidfd? It seems the consensus is to pass pidnr, but
> >   if we're going to step back and make some design choices here, is
> >   there a place for pidfds in seccomp user_notif, in order to avoid
> >   needing the user_notif cookie? I think probably not: it's a rather lot
> >   of overhead for notifications. It seems it's safe to perform an fd
> >   installation with these steps:
> > 	- get pidnr from user_notif_recv
> > 	- open pidfd from pidnr
> > 	- re-verify user_notif cookie is still valid
> > 	- send new fd via pidfd
> > 	- reply with user_notif_send
> > 	- close pidfd
> 
> I agree that while it would be conceptually nicer to not need the
> user_notif cookie, creating a new pidfd for every notification isn't a
> good idea (not to mention that the program may not care about the pid or
> pidfd when determining its response -- making the pidfd more of a pain
> than anything else).
> 
> You'd also need to have special-casing based on the userspace length of
> user_notif because old programs wouldn't know they'd have to close the
> pidfd returned (which then brings us back to the fact that user_notif
> doesn't specify what the usize of the struct is a-la
> copy_struct_from_user).
> 
> > ## deep argument inspection
> > 
> > Background: seccomp users would like to write filters that traverse
> > the user pointers passed into many syscalls, but seccomp can't do this
> > dereference for a variety of reasons (mostly involving race conditions and
> > rearchitecting the entire kernel syscall and copy_from_user() code flows).
> > 
> > During the last plumbers and in conversations since, the grudging
> > consensus was reached that having seccomp do this for ALL syscalls was
> > likely going to be extremely disruptive for very little gain (i.e.
> > many things, like pathnames, have differing lifetimes, aliases, unstable
> > kernel object references, etc[6]), but that there were a small subset of
> > syscalls for which this WOULD be beneficial, and those are the newly
> > created "Extensible Argument" syscalls (is there a better name for this
> > design? I'm calling it "EA" for the rest of the email), like clone3(),
> > openat2(), etc, which pass a pointer and a size:
> 
> I called them "extensible struct" syscalls, but "extensible arguments"
> is probably a better name. Though if you want to call them EA, make sure
> to include the ™. ;)
> 
> > long clone3(struct clone_args *cl_args, size_t size);
> > 
> > I think it should be possible to extend seccomp to examine this structure
> > by appending it to seccomp_data, and allowing filters to examine the
> > contents. This means that no BPF language extensions are required for
> > seccomp, as I'd still prefer to avoid making the eBPF jump (I don't think
> > seccomp's design principles work well with maps, kernel helpers, etc,
> > and I think the earlier the examination of using eBPF for user_notif
> > bares this out).
> 
> While I agree that we don't need to jump to eBPF for this, I do think
> we'll need an opcode for is_zeroed() (or bpf_check_uarg_tail_zero()) --
> see below.
> 
> > In order for this to work, there are a number of prerequisites:
> > 
> > - argument caching, in two halves: syscall side and seccomp side:
> >   - the EA syscalls needs to include awareness of potential seccomp
> >     hooking. i.e. seccomp may have done the copy_from_user() already and
> >     kept a cached copy.
> >   - seccomp needs to potentially DO the copy_from_user() itself when it
> >     hits these syscalls for a given filter, and put it somewhere for
> >     later use by the syscall.
> > 
> > The argument caching bit is, I think, rather mechanical in nature since
> > it's all "just" internal to the kernel: seccomp can likely adjust how it
> > allocates seccomp_data (maybe going so far as to have it split across two
> > pages with the syscall argument struct always starting on the 2nd page
> > boundary), and copying the EA struct into that page, which will be both
> > used by the filter and by the syscall. I imagine state tracking ("is
> > there a cached EA?", "what is the address of seccomp_data?", "what is
> > the address of the EA?") can be associated with the thread struct.
> 
> I agree that while this is an important thing to handle properly, it's
> internal and probably doesn't deserve the lions share of design
> discussion.
> 
> > - the sizes of these EA structs are, by design, growable over time.
> >   seccomp and its users need to be handle this in a forward and backward
> >   compatible way, similar to the design of the EA syscall interface
> >   itself.
> > 
> > The growing size of the EA struct will need some API design. For filters
> > to operate on the contiguous seccomp_data+EA struct, the filter will
> > need to know how large seccomp_data is (more on this later), and how
> > large the EA struct is. When the filter is written in userspace, it can
> > do the math, point into the expected offsets, and get what it needs. For
> > this to work correctly in the kernel, though, the seccomp BPF verifier
> > needs to know the size of the EA struct as well, so it can correctly
> > perform the offset checking (as it currently does for just the
> > seccomp_data struct size).
> > 
> > Since there is not really any caller-based "seccomp state" associated
> > across seccomp(2) calls, I don't think we can add a new command to tell
> > the kernel "I'm expecting the EA struct size to be $foo bytes", since
> > the kernel doesn't track who "I" is besides just being "current", which
> > doesn't take into account the thread lifetime -- if a process launcher
> > knows about one size and the child knows about another, things will get
> > confused. The sizes really are just associated with individual filters,
> > based on the syscalls they're examining. So, I have thoughts on possible
> > solutions:
> > 
> > - create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses the
> >   EA style so we can pass in more than a filter and include also an
> >   array of syscall to size mappings. (I don't like this...)
> > - create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which changes
> >   the meaning of the uarg from "filter" to a EA-style structure with
> >   sizes and pointers to the filter and an array of syscall to size
> >   mappings. (I like this slightly better, but I still don't like it.)
> > - leverage the EA design and just accept anything <= PAGE_SIZE, record
> >   the "max offset" value seen during filter verification, and zero-fill
> >   the EA struct with zeros to that size when constructing the
> >   seccomp_data + EA struct that the filter will examine. Then the seccomp
> >   filter doesn't care what any of the sizes are, and userspace doesn't
> >   care what any of the sizes are. (I like this as it makes the problems
> >   to solve contained entirely by the seccomp infrastructure and does not
> >   touch user API, but I worry I'm missing some gotcha I haven't
> >   considered.)
> 
> Okay, so here is my view on this. I think that the third option is
> closest to what I'd like to see. Based on Jann's email, I think we're on
> the same page but I'd just like to elaborate it a bit further:
> 
> First of all -- ideally, the backward and forward compatibility that EA
> syscalls give us should be reflected with seccomp filters being
> similarly compatible. Otherwise we're going to run into issues where all
> of the hard work with ensuring EA syscalls behave when extended will be
> less valuable if seccomp cannot handle it sufficiently. This means that
> I would hope that every combination of {old,new} filter/kernel/program
> would work on a best-effort (but fail-safe) basis.
> 
> In my view, the simplest way (from the kernel side) would be to simply
> do what you outlined in (3) -- make all accesses past usize (and even
> ksize) be zeroed.
> 
> However in order to make an old filter fail-safe on a new kernel with a
> new program, we'd need a new opcode which basically does
> bpf_check_uarg_tail_zero() after a given offset into the EA struct. This
> would punt the fail-safe problem to userspace (libseccomp would need to
> generate a check that any unknown-to-the-filter fields are zero). I
> don't think this is a decision we can make in-kernel because it might be
> that the filter doesn't care about the last field in a struct (and thus
> doesn't access it) but we don't know the difference between a field the
> filter doesn't care about and a field it doesn't know about.
> 
> Another issue which you haven't mentioned here is how do we deal with
> pointers inside an EA struct. clone3() already has this with set_tid,

It's also passed with a set_tid_size argument so we'd know how large
set_tid is.

> and the thread on user_notif seems to be converging towards having the
> user_notif2 struct just contain two pointers to EA structs. We could
> punt on this for now, so long as we leave room for us to deal with this
> problem in the future. However, I think it would be misguided to enable
> deep argument inspection on syscalls which have such entries (such as
> clone3) until we've figured out how we want to handle nested pointers --

We can't really punt on this and should figure this out now. I've
pointed to this problem in my other mail as well.
Though I currently fail to see why this should be a huge problem to get
that working as long as each pointer comes with a known size.

> at the very least because the bpf_check_uarg_tail_zero() opcode
> semantics need to consider this problem.
> 
> A silly proposal I had was that because the EA would never be bigger
> than PAGE_SIZE, we could take the offset into the EA and multiply it by
> PAGE_SIZE each time we wanted to do a "dereference" of a pointer in EA.

If you have a size to it it should be ok? I'm probably missing
something.

Christian
