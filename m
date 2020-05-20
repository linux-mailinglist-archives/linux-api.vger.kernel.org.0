Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA91DAE4E
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2020 11:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETJF1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 May 2020 05:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETJF0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 May 2020 05:05:26 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79084C061A0E
        for <linux-api@vger.kernel.org>; Wed, 20 May 2020 02:05:26 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t15so2335447ios.4
        for <linux-api@vger.kernel.org>; Wed, 20 May 2020 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k/on5dXOqPPTTiXT6elXTcI6XkJXgcd9gTLZOle0dV4=;
        b=MDfBRknDn2S/BQFUVM7z6D6T94KFygSDo/kJkICFQue8fXx9Qa2drC4JcszQH+0SqJ
         rnVDBljeQL6QvXKyM3JJ5qLdcMxL7KScgWzdmvpGeLIUbrcyw7a037GCauyMwR+Qlid6
         c1gDhAbV+l8eW1qQaipwvyeoXUTXrDtoeonx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k/on5dXOqPPTTiXT6elXTcI6XkJXgcd9gTLZOle0dV4=;
        b=TBsnApusGck6zysj3cHups2VgeqqNhZws4x23+H/W4g9yv6HSCVCpbBr8rI0dIuP8y
         iqEsGazfOON0V9LsRuGapGReTl2t7MwGLibywToP4Bc6FZz5voKbcqrlCH5kQ/6tAX5q
         gYYRqXxY3vi5Bxg3CPI8lbe80oZh89mtm7jUsxU5hJL/gcgyNYlHcr7MQ+/g5wsHzSHw
         x1gs+jhfOtu8pM5E1niIy4J18bJ6xuA5iwJbkAC4Jwazp3aqLT+BxUi81yVSJxA10YbG
         kdkayRVWQrB/u8367QKTCMvRddkODW5h+EVc1imUqAgxCMC8PV3US0QPDC8wseFhCG7N
         BWcQ==
X-Gm-Message-State: AOAM530+Ydpyzp+4162er7zcn67T+HDk1KJV+Vcx5f1eoSXR14On3FIr
        HFbOhHCXmA2KoYNeHp6mAo6f5w==
X-Google-Smtp-Source: ABdhPJwZYpjIzIkLLlpmXQDWFkKpC1z3x2FPkXeBEZvoL5ZeTF3tRsMpIlAh31FgNbg3XQj0XOi8yQ==
X-Received: by 2002:a02:c9d3:: with SMTP id c19mr3504366jap.80.1589965525385;
        Wed, 20 May 2020 02:05:25 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id s84sm1059046ill.5.2020.05.20.02.05.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 02:05:24 -0700 (PDT)
Date:   Wed, 20 May 2020 09:05:23 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: seccomp feature development
Message-ID: <20200520090522.GA25177@ircssh-2.c.rugged-nimbus-611.internal>
References: <202005181120.971232B7B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005181120.971232B7B@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 18, 2020 at 02:04:57PM -0700, Kees Cook wrote:
> Hi!
> 
> This is my attempt at a brain-dump on my plans for nearish-term seccomp
> features. Welcome to my TED talk... ;)
> 
> These are the things I've been thinking about:
> 
> - fd passing
> - deep argument inspection
> - changing structure sizes
> - syscall bitmasks
> 
> So, diving right in:
> 
> 
> ## fd passing
> 
> Background: seccomp users want to be able to install an fd in a
> monitored process during a user_notif to emulate "open" calls (or
> similar), possibly across security boundaries, etc.
> 
> On the fd passing front, it seems that gaining pidfd_addfd() is the way
> to go as it allows for generic use not tied to seccomp in particular.
> I expect this feature will be developed orthogonally to seccomp (where
> does this stand, BTW?). However, as Sargun has shown[1], seccomp could
> be friendlier to help with using it. Things that need to be resolved:
> 
> - report pidnr, or pidfd? It seems the consensus is to pass pidnr, but
>   if we're going to step back and make some design choices here, is
>   there a place for pidfds in seccomp user_notif, in order to avoid
>   needing the user_notif cookie? I think probably not: it's a rather lot
>   of overhead for notifications. It seems it's safe to perform an fd
>   installation with these steps:
> 	- get pidnr from user_notif_recv
> 	- open pidfd from pidnr
> 	- re-verify user_notif cookie is still valid
> 	- send new fd via pidfd
> 	- reply with user_notif_send
> 	- close pidfd
> 
> - how to deal with changing sizes of the user_notif structures to
>   include a pidnr. (Which will be its own topic below.)
> 
> 
> ## deep argument inspection
> 
> Background: seccomp users would like to write filters that traverse
> the user pointers passed into many syscalls, but seccomp can't do this
> dereference for a variety of reasons (mostly involving race conditions and
> rearchitecting the entire kernel syscall and copy_from_user() code flows).
> 
> During the last plumbers and in conversations since, the grudging
> consensus was reached that having seccomp do this for ALL syscalls was
> likely going to be extremely disruptive for very little gain (i.e.
> many things, like pathnames, have differing lifetimes, aliases, unstable
> kernel object references, etc[6]), but that there were a small subset of
> syscalls for which this WOULD be beneficial, and those are the newly
> created "Extensible Argument" syscalls (is there a better name for this
> design? I'm calling it "EA" for the rest of the email), like clone3(),
> openat2(), etc, which pass a pointer and a size:
> 
> long clone3(struct clone_args *cl_args, size_t size);
> 
> I think it should be possible to extend seccomp to examine this structure
> by appending it to seccomp_data, and allowing filters to examine the
> contents. This means that no BPF language extensions are required for
> seccomp, as I'd still prefer to avoid making the eBPF jump (I don't think
> seccomp's design principles work well with maps, kernel helpers, etc,
> and I think the earlier the examination of using eBPF for user_notif
> bares this out).
> 
> In order for this to work, there are a number of prerequisites:
> 
> - argument caching, in two halves: syscall side and seccomp side:
>   - the EA syscalls needs to include awareness of potential seccomp
>     hooking. i.e. seccomp may have done the copy_from_user() already and
>     kept a cached copy.
>   - seccomp needs to potentially DO the copy_from_user() itself when it
>     hits these syscalls for a given filter, and put it somewhere for
>     later use by the syscall.
> - the sizes of these EA structs are, by design, growable over time.
>   seccomp and its users need to be handle this in a forward and backward
>   compatible way, similar to the design of the EA syscall interface
>   itself.
> 
> The argument caching bit is, I think, rather mechanical in nature since
> it's all "just" internal to the kernel: seccomp can likely adjust how it
> allocates seccomp_data (maybe going so far as to have it split across two
> pages with the syscall argument struct always starting on the 2nd page
> boundary), and copying the EA struct into that page, which will be both
> used by the filter and by the syscall. I imagine state tracking ("is
> there a cached EA?", "what is the address of seccomp_data?", "what is
> the address of the EA?") can be associated with the thread struct.
> 
> The growing size of the EA struct will need some API design. For filters
> to operate on the contiguous seccomp_data+EA struct, the filter will
> need to know how large seccomp_data is (more on this later), and how
> large the EA struct is. When the filter is written in userspace, it can
> do the math, point into the expected offsets, and get what it needs. For
> this to work correctly in the kernel, though, the seccomp BPF verifier
> needs to know the size of the EA struct as well, so it can correctly
> perform the offset checking (as it currently does for just the
> seccomp_data struct size).
> 
> Since there is not really any caller-based "seccomp state" associated
> across seccomp(2) calls, I don't think we can add a new command to tell
> the kernel "I'm expecting the EA struct size to be $foo bytes", since
> the kernel doesn't track who "I" is besides just being "current", which
> doesn't take into account the thread lifetime -- if a process launcher
> knows about one size and the child knows about another, things will get
> confused. The sizes really are just associated with individual filters,
> based on the syscalls they're examining. So, I have thoughts on possible
> solutions:
> 
> - create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses the
>   EA style so we can pass in more than a filter and include also an
>   array of syscall to size mappings. (I don't like this...)
> - create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which changes
>   the meaning of the uarg from "filter" to a EA-style structure with
>   sizes and pointers to the filter and an array of syscall to size
>   mappings. (I like this slightly better, but I still don't like it.)
> - leverage the EA design and just accept anything <= PAGE_SIZE, record
>   the "max offset" value seen during filter verification, and zero-fill
>   the EA struct with zeros to that size when constructing the
>   seccomp_data + EA struct that the filter will examine. Then the seccomp
>   filter doesn't care what any of the sizes are, and userspace doesn't
>   care what any of the sizes are. (I like this as it makes the problems
>   to solve contained entirely by the seccomp infrastructure and does not
>   touch user API, but I worry I'm missing some gotcha I haven't
>   considered.)
> 
I may be ridiculed for suggesting this approach, and maybe it's a bit
mad-science. I'll be honest, my familiarity with mm is low, and although
I think what I'm describing can be done, I'm unsure of the complexity,
and performance impact.

I was playing with userfaultfd a while ago for somewhat related reasons
and I found a patchset supporting write protection [1]. This got me
interested in wondering if we could leverage this. What if we had a
mechanism to read a process's memory, and simultaneously mark it
as read-only.

#define memstruct_flag_mark_ro	1
#define notify_on_mod	2
struct memstruct {
	__u32 flags;
	/* We might even support multiple iovecs... */
	struct iovec *local_iov;
	struct iovec *remote_iov;
}
Flow:
1. Supervisor (s1) launches child (c1)
2. c1 makes syscall that triggers seccomp_notif -- let's say clone3 --
a call where we can't do injection or such on behalf of the child.
3. s1 receives notification + seccomp data
4. s1 calls ioctl(..., SECCOMP_READ_MEM, memstruct) (where memstruct is
above)
5. When s1 calls this, the pages which are accessed by the iovec get
marked as read only, so a fault is triggered if the user process tries
to change things.
6. s1 says, continue syscall
7. Syscall returns, and pages are reverted to pre-notification state.

Upon fault, if the range being changed lies outside of what was copied
back via the SECCOMP_READ_MEM ioctl, then it is passed through as-is.
If the range is inside, and notify_on_mod is unset, it will SIGSEGV.
If the range is inside, and notify_on_mod is set, we will have to do
a userfaultfd-like notification back down to userspace.

I realize this approach is hacky, and ugly, and potentially goes
into the same territory as userfaultfd, which has proven to be a security
thing, but the benefits are that no kernel, cBPF, etc.. need to change.

The only downsides I see are complexity, performance, and potentially
there may be some userspace programs innocously manipulating memory
that might get caught in such an iovec.

Thoughts?
 
> And then, my age-old concern, that maybe doesn't need a solution... I
> remain plagued by the lack of pathname inspection. But I think the
> ToCToU nature of it means we just cannot do it from seccomp. It does
> make filtering openat2()'s EA struct a bit funny... a filter has no idea
> what path it applies to... but that doesn't matter because the object
> the path points to might change[6] during the syscall. Argh.
> 
> 
I have no idea how to solve this if the process can do stuff like move
files around on disk, or switch out namespaces while in the user notification.


[1]: https://lwn.net/Articles/786896/

