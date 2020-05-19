Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D01D98F4
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgESOHt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgESOHt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 10:07:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484E0C08C5C0
        for <linux-api@vger.kernel.org>; Tue, 19 May 2020 07:07:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w25so14573479iol.12
        for <linux-api@vger.kernel.org>; Tue, 19 May 2020 07:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6U8yNeKU0rrgvoM4K/Cubp5TsmaK99ZDEl5KRFcpGxo=;
        b=zlBJ7apaTa3jrmCjmgxIOb83P+wDWjnJVG7u6qv2bEg+m5uxXSvojCxYJ6Rrnh3ML0
         qyROue7TOHgpkFADQAScVdKQ49DV50WWbCAprkMM/fXNcXwATH89JEWYYhWpQf7xo/g6
         2RN5dDbDP23he7yMoeKaHSHxW9DksRqjV2IpCGEaqKG3ErirLdTZp4o02DPRK2/w9cVS
         gLK8uH7ic9ecdy0/06l3EUHPKzM2p7PeG1EZ319GSCaFZ5PzHn+iOPsIdJxYoid82ecq
         rxQR/7RrzCPZYYQtfs9D6kw6cP5M4U1Ks9TFrgxk7cB8mQGWZibhA2Za1CkGHA/p9F3K
         y8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6U8yNeKU0rrgvoM4K/Cubp5TsmaK99ZDEl5KRFcpGxo=;
        b=SKT2Xi8kMEzVOR7xxUpwrwmRpDUHSt+/403zv8W5QNT7Y1DuuEHF4F43+IzF/I7RY5
         l9zOFxcBmcpmdT71XStQw7FRqgNNASf/XZlPDVsYg2qPCG0vcWAHfUsSPBo28fzcRb4k
         xw8p+dANEWAaLn7yTJqdYuRhxkL0BGfVESdBPTCSsY8M5QEpsL3UlXQbM6GuCR+XdMs3
         DvAvbjgU73IVgTgQTg5wVaZH3L13j8/slqej5hTTcNk+pN26Sj5c3G97Rw8STThbQTp/
         ax8C+oAcAmn3B0nla6Gd5skl6cQ7rU80isG/HryB6rsgm9iYHtuZESllrhXTGkUD1+wj
         oXrw==
X-Gm-Message-State: AOAM532njYEyXAkVDiKIaEEOFiAoNJDyRoeT9XNFqbWYZKFetcmGWDjF
        1ji+EhVoARhSRZUfYJB+DJiTaw==
X-Google-Smtp-Source: ABdhPJwgj5R01KB4WJEz+6cuvx8sRC5RxDCswBZ/tHhkVNGl/3eOaRTsG2AosW96nBbmsnprO1Ay6w==
X-Received: by 2002:a05:6638:2ad:: with SMTP id d13mr20174780jaq.119.1589897268093;
        Tue, 19 May 2020 07:07:48 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:6155:7c8c:3dc0:c56e])
        by smtp.gmail.com with ESMTPSA id n27sm6136718ild.76.2020.05.19.07.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 07:07:47 -0700 (PDT)
Date:   Tue, 19 May 2020 08:07:47 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: seccomp feature development
Message-ID: <20200519140747.GD2405879@cisco>
References: <202005181120.971232B7B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005181120.971232B7B@keescook>
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

Yep, this looks safe.

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

This sounds pretty nice to me :)

> And then, my age-old concern, that maybe doesn't need a solution... I
> remain plagued by the lack of pathname inspection. But I think the
> ToCToU nature of it means we just cannot do it from seccomp. It does
> make filtering openat2()'s EA struct a bit funny... a filter has no idea
> what path it applies to... but that doesn't matter because the object
> the path points to might change[6] during the syscall. Argh.
> 
> 
> ## changing structure sizes
> 
> Background: there have been regular needs to add things to various
> seccomp structures. Each come with their own unique pains, and solving
> this as completely as possible in a future-proof way would be very nice.
> 
> As noted in "fd passing" above, there is a desire to add some useful
> things to the user_notif struct (e.g. thread group pid). Similarly,
> there have been requests in the past (though I can't find any good
> references right now, just my indirect comments[3]) to grow seccomp_data.
> Combined with the EA struct work above, there's a clear need for seccomp
> to reexamine how it deals with its API structures (and how this
> interacts with filters).
> 
> First, let's consider seccomp_data. If we grow it, the EA struct offset
> will move, based on the deep arg inspection design above. Alternatively,
> we could instead put seccomp_data offset 0, and EA struct at offset
> PAGE_SIZE, and treat seccomp_data itself as an EA struct where we let
> the filter access whatever it thinks is there, with it being zero-filled
> by the kernel. For any values where 0 is valid, there will just need to
> be a "is that field valid?" bit before it:
> 
> 	unsigned long feature_bits;
> 	unsigned long interesting_thing_1;
> 	unsigned long interesting_thing_2;
> 	unsigned long interesting_thing_3;
> 	...
> 
> and the filter would check feature_bits...
> 
> (However, this needs to be carefully considered given that seccomp_data
> is embedded in user_notif... should the EA struct from userspace also be
> copied into user_notif? More thoughts on this below...)
> 
> For user_notif, I think we need something in and around these options:
> 
> - make a new API that explicitly follows EA struct design
>   (and while read()/write() might be easier[4], I tend to agree with
>   Jann and we need to stick to ioctl(): as Tycho noted, "read/write is
>   for data". Though I wonder if read() could be used for the notifications,
>   which ARE data, and use ioctl() for the responses?)
> - make a new API that is perf_event_open()-style where fields are
>   explicitly requested, as Sargun suggested[5]. (This looks like it
>   might be complex to construct, but would get us by far the most
>   extensible API.)

This already exists, and was my original intent with the current API.
You can add new ioctl()s:

struct seccomp_interesting_stuff {
    __u16 size;
    __u64 id;
    __u64 interesting_thing_1;
    __u64 interesting_thing_2;
};
ioctl(listener, SECCOMP_IOCTL_GET_INTERESTING_STUFF, &buf);

The original intent was that you could either grow one of these
structures, or add a new one. It's not clear to me really *why* we
need a whole new API where everything fits into one structure.

Or, we could build a requested fields approach that you discuss on
top. But I don't see a reason to add a whole new RECV2.

> - jam whatever we pick into the existing API (we'll be forced to do
>   SOMETHING to make the old API still work, so, I dunno what that will
>   look like until we finish the rest of the design).
> 
> If we did a requested-fields approach, what would the user_notif event
> block of bytes look like? Would it be entirely dynamic based on the
> initial ioctl()? Another design consideration here is that we don't want
> the kernel doing tons of work (especially copying) and tossing tons
> of stuff into a huge structure that the user doesn't care about. In
> addition to explicit fields, maybe the EA struct could be included,
> perhaps with specified offset/size, so only the portion the user_notif
> user wanted to inspect was copied?
> 
> The complexity of the per-field API is higher, but I think it might be
> the most robust and have the greatest chance at being performant.
> For example, "send me user_notif but I only care about the pid" would
> mean no syscall arguments are copied, etc.
> 
> 
> ## syscall bitmasks
> 
> Background: the number one bit of feedback on seccomp has been performance
> concerns, especially for fast syscalls like futex(). When looking at
> where time is spent, it is very clearly spent running the filters (which
> I found surprising, given that adding TIF_SECCOMP tended to trip the
> "slow path" syscall path (though most architectures these days just
> don't have a fast path any more thanks to Meltdown). It would be nice
> to make filtering faster without running BPF at all. :)
> 
> Nearly every thread on adding eBPF, for example, has been about trying to
> speed up the if/then nature of BPF for finding a syscall that the filter
> wants to always accept (or reject). The bulk of most seccomp filters
> are pretty simple, usually they're either "reject everything except
> $set-of-syscalls", or "accept everything except $set-of-syscalls". The
> stuff in between tends to be a mix, like "accept $some, process $these
> with argument checks, and reject $remaining".
> 
> In all three cases, the entire seccomp() path could be sped up by having
> a syscall bitmask that could be applied before the filters are ever run,
> with 3 (actually 2) syscall bitmasks: accept, reject, or process. If
> a syscall was in the "accept" bitmask, we immediately exit seccomp and
> continue. Otherwise, if it's in the "reject" bitmask, we mark it rejected
> and immediately exit seccomp. And finally, we run the filters. In all
> ways, doing bitmask math is going to be faster than running the BPF. ;)
> 
> So how would the API for this work? I have two thoughts, and I don't
> think they're exclusive:
> 
> - new API for "add this syscall to the reject bitmask". We can't really
>   do an "accept" bitmask addition without processing the attached
>   filters...
> - process attached filters! Each time a filter is added, have the
>   BPF verifier do an analysis to determine if there are any static
>   results, and set bits in the various bitmasks to represent it.
>   i.e. when seccomp is first enabled on a thread, the "accept"
>   bitmask is populated with all syscalls, and for each filter, do
>   [math,simulation,magic] and knock each syscall out of "accept" if

This sounds like a recipe for bugs :)

>   it isn't always accepted, and further see if there are any syscalls
>   that are always rejected, and mark those in the "reject" bitmask.

What if instead you have a reject bitmask which is always fine to add
to, and an accept bitmask which is only valid if there are no actual
filters attached. Is that enough for people?

Tycho
