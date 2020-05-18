Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801221D89C1
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 23:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgERVFA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVFA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 17:05:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E18FC061A0C
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 14:05:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v63so5519842pfb.10
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=t/Su5oPmAaTnzxELr9jqEJcQqoOSeoau3xrqICnbgM0=;
        b=oSfqYA7vt8jZYZVEa+xFD3hf7kEQcAL8QQkTyaVYVp732KfrWcftjSJbodKC6XpJkv
         1plWk3etuSgsJ3nCbPqujhrCN4v5fR2r9uWI+bC39p8FT7y70sNpnJHIWebSDtlGLt7I
         ZcucoeEzhKDh2U1b2TxSTNd2l2eMN11DtvMZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=t/Su5oPmAaTnzxELr9jqEJcQqoOSeoau3xrqICnbgM0=;
        b=jJamDFvVqItj785A/+ar1hdjOlFSoz7A16e2B2guhx/wF970e/2vEQ9a3Cz8xYnGr6
         T0lDS9m7Op4p6wIvnrAG6ah0WfuojvhEnuPq8ygMDT+3BGy85xQEtGdm1zZEuChIkiKL
         tcFHY6HDiCw/a7Yscd0MrLNuqxm+EArCrDOcaFAjpoWnuCtqbHkBLQX9raPjwzj3PiUe
         EKRvffqOIQ2ZetH5kMF900xOniWBQ3hUEKv8BWmTZbI2y9455YWp+LxtjU/zQet7zPRJ
         7tk1jH7fl+AoE4rUDDnyCmN8vfwpZA2kW0r0Tugwd4rODU9F/PG1FNrKaCwkn+6vPaay
         LaSw==
X-Gm-Message-State: AOAM530mdJCw02kBabKrFi0ZjRfvMvEDlSapLt8cIkROc2w8xizsljMa
        C6S4/qZ0qI1UY8I75sjpl1Ccgg==
X-Google-Smtp-Source: ABdhPJylNQYrF4F2xeoBIjCTCOF+yt7tppEmw4dbfR8q8wq+Ci2G6O90uRK+fEmKiVdOtBPhQOCnGA==
X-Received: by 2002:aa7:8042:: with SMTP id y2mr18740260pfm.94.1589835899334;
        Mon, 18 May 2020 14:04:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm379141pjp.4.2020.05.18.14.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:04:58 -0700 (PDT)
Date:   Mon, 18 May 2020 14:04:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>
Cc:     Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: seccomp feature development
Message-ID: <202005181120.971232B7B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi!

This is my attempt at a brain-dump on my plans for nearish-term seccomp
features. Welcome to my TED talk... ;)

These are the things I've been thinking about:

- fd passing
- deep argument inspection
- changing structure sizes
- syscall bitmasks

So, diving right in:


## fd passing

Background: seccomp users want to be able to install an fd in a
monitored process during a user_notif to emulate "open" calls (or
similar), possibly across security boundaries, etc.

On the fd passing front, it seems that gaining pidfd_addfd() is the way
to go as it allows for generic use not tied to seccomp in particular.
I expect this feature will be developed orthogonally to seccomp (where
does this stand, BTW?). However, as Sargun has shown[1], seccomp could
be friendlier to help with using it. Things that need to be resolved:

- report pidnr, or pidfd? It seems the consensus is to pass pidnr, but
  if we're going to step back and make some design choices here, is
  there a place for pidfds in seccomp user_notif, in order to avoid
  needing the user_notif cookie? I think probably not: it's a rather lot
  of overhead for notifications. It seems it's safe to perform an fd
  installation with these steps:
	- get pidnr from user_notif_recv
	- open pidfd from pidnr
	- re-verify user_notif cookie is still valid
	- send new fd via pidfd
	- reply with user_notif_send
	- close pidfd

- how to deal with changing sizes of the user_notif structures to
  include a pidnr. (Which will be its own topic below.)


## deep argument inspection

Background: seccomp users would like to write filters that traverse
the user pointers passed into many syscalls, but seccomp can't do this
dereference for a variety of reasons (mostly involving race conditions and
rearchitecting the entire kernel syscall and copy_from_user() code flows).

During the last plumbers and in conversations since, the grudging
consensus was reached that having seccomp do this for ALL syscalls was
likely going to be extremely disruptive for very little gain (i.e.
many things, like pathnames, have differing lifetimes, aliases, unstable
kernel object references, etc[6]), but that there were a small subset of
syscalls for which this WOULD be beneficial, and those are the newly
created "Extensible Argument" syscalls (is there a better name for this
design? I'm calling it "EA" for the rest of the email), like clone3(),
openat2(), etc, which pass a pointer and a size:

long clone3(struct clone_args *cl_args, size_t size);

I think it should be possible to extend seccomp to examine this structure
by appending it to seccomp_data, and allowing filters to examine the
contents. This means that no BPF language extensions are required for
seccomp, as I'd still prefer to avoid making the eBPF jump (I don't think
seccomp's design principles work well with maps, kernel helpers, etc,
and I think the earlier the examination of using eBPF for user_notif
bares this out).

In order for this to work, there are a number of prerequisites:

- argument caching, in two halves: syscall side and seccomp side:
  - the EA syscalls needs to include awareness of potential seccomp
    hooking. i.e. seccomp may have done the copy_from_user() already and
    kept a cached copy.
  - seccomp needs to potentially DO the copy_from_user() itself when it
    hits these syscalls for a given filter, and put it somewhere for
    later use by the syscall.
- the sizes of these EA structs are, by design, growable over time.
  seccomp and its users need to be handle this in a forward and backward
  compatible way, similar to the design of the EA syscall interface
  itself.

The argument caching bit is, I think, rather mechanical in nature since
it's all "just" internal to the kernel: seccomp can likely adjust how it
allocates seccomp_data (maybe going so far as to have it split across two
pages with the syscall argument struct always starting on the 2nd page
boundary), and copying the EA struct into that page, which will be both
used by the filter and by the syscall. I imagine state tracking ("is
there a cached EA?", "what is the address of seccomp_data?", "what is
the address of the EA?") can be associated with the thread struct.

The growing size of the EA struct will need some API design. For filters
to operate on the contiguous seccomp_data+EA struct, the filter will
need to know how large seccomp_data is (more on this later), and how
large the EA struct is. When the filter is written in userspace, it can
do the math, point into the expected offsets, and get what it needs. For
this to work correctly in the kernel, though, the seccomp BPF verifier
needs to know the size of the EA struct as well, so it can correctly
perform the offset checking (as it currently does for just the
seccomp_data struct size).

Since there is not really any caller-based "seccomp state" associated
across seccomp(2) calls, I don't think we can add a new command to tell
the kernel "I'm expecting the EA struct size to be $foo bytes", since
the kernel doesn't track who "I" is besides just being "current", which
doesn't take into account the thread lifetime -- if a process launcher
knows about one size and the child knows about another, things will get
confused. The sizes really are just associated with individual filters,
based on the syscalls they're examining. So, I have thoughts on possible
solutions:

- create a new seccomp command SECCOMP_SET_MODE_FILTER2 which uses the
  EA style so we can pass in more than a filter and include also an
  array of syscall to size mappings. (I don't like this...)
- create a new filter flag, SECCOMP_FILTER_FLAG_EXTENSIBLE, which changes
  the meaning of the uarg from "filter" to a EA-style structure with
  sizes and pointers to the filter and an array of syscall to size
  mappings. (I like this slightly better, but I still don't like it.)
- leverage the EA design and just accept anything <= PAGE_SIZE, record
  the "max offset" value seen during filter verification, and zero-fill
  the EA struct with zeros to that size when constructing the
  seccomp_data + EA struct that the filter will examine. Then the seccomp
  filter doesn't care what any of the sizes are, and userspace doesn't
  care what any of the sizes are. (I like this as it makes the problems
  to solve contained entirely by the seccomp infrastructure and does not
  touch user API, but I worry I'm missing some gotcha I haven't
  considered.)

And then, my age-old concern, that maybe doesn't need a solution... I
remain plagued by the lack of pathname inspection. But I think the
ToCToU nature of it means we just cannot do it from seccomp. It does
make filtering openat2()'s EA struct a bit funny... a filter has no idea
what path it applies to... but that doesn't matter because the object
the path points to might change[6] during the syscall. Argh.


## changing structure sizes

Background: there have been regular needs to add things to various
seccomp structures. Each come with their own unique pains, and solving
this as completely as possible in a future-proof way would be very nice.

As noted in "fd passing" above, there is a desire to add some useful
things to the user_notif struct (e.g. thread group pid). Similarly,
there have been requests in the past (though I can't find any good
references right now, just my indirect comments[3]) to grow seccomp_data.
Combined with the EA struct work above, there's a clear need for seccomp
to reexamine how it deals with its API structures (and how this
interacts with filters).

First, let's consider seccomp_data. If we grow it, the EA struct offset
will move, based on the deep arg inspection design above. Alternatively,
we could instead put seccomp_data offset 0, and EA struct at offset
PAGE_SIZE, and treat seccomp_data itself as an EA struct where we let
the filter access whatever it thinks is there, with it being zero-filled
by the kernel. For any values where 0 is valid, there will just need to
be a "is that field valid?" bit before it:

	unsigned long feature_bits;
	unsigned long interesting_thing_1;
	unsigned long interesting_thing_2;
	unsigned long interesting_thing_3;
	...

and the filter would check feature_bits...

(However, this needs to be carefully considered given that seccomp_data
is embedded in user_notif... should the EA struct from userspace also be
copied into user_notif? More thoughts on this below...)

For user_notif, I think we need something in and around these options:

- make a new API that explicitly follows EA struct design
  (and while read()/write() might be easier[4], I tend to agree with
  Jann and we need to stick to ioctl(): as Tycho noted, "read/write is
  for data". Though I wonder if read() could be used for the notifications,
  which ARE data, and use ioctl() for the responses?)
- make a new API that is perf_event_open()-style where fields are
  explicitly requested, as Sargun suggested[5]. (This looks like it
  might be complex to construct, but would get us by far the most
  extensible API.)
- jam whatever we pick into the existing API (we'll be forced to do
  SOMETHING to make the old API still work, so, I dunno what that will
  look like until we finish the rest of the design).

If we did a requested-fields approach, what would the user_notif event
block of bytes look like? Would it be entirely dynamic based on the
initial ioctl()? Another design consideration here is that we don't want
the kernel doing tons of work (especially copying) and tossing tons
of stuff into a huge structure that the user doesn't care about. In
addition to explicit fields, maybe the EA struct could be included,
perhaps with specified offset/size, so only the portion the user_notif
user wanted to inspect was copied?

The complexity of the per-field API is higher, but I think it might be
the most robust and have the greatest chance at being performant.
For example, "send me user_notif but I only care about the pid" would
mean no syscall arguments are copied, etc.


## syscall bitmasks

Background: the number one bit of feedback on seccomp has been performance
concerns, especially for fast syscalls like futex(). When looking at
where time is spent, it is very clearly spent running the filters (which
I found surprising, given that adding TIF_SECCOMP tended to trip the
"slow path" syscall path (though most architectures these days just
don't have a fast path any more thanks to Meltdown). It would be nice
to make filtering faster without running BPF at all. :)

Nearly every thread on adding eBPF, for example, has been about trying to
speed up the if/then nature of BPF for finding a syscall that the filter
wants to always accept (or reject). The bulk of most seccomp filters
are pretty simple, usually they're either "reject everything except
$set-of-syscalls", or "accept everything except $set-of-syscalls". The
stuff in between tends to be a mix, like "accept $some, process $these
with argument checks, and reject $remaining".

In all three cases, the entire seccomp() path could be sped up by having
a syscall bitmask that could be applied before the filters are ever run,
with 3 (actually 2) syscall bitmasks: accept, reject, or process. If
a syscall was in the "accept" bitmask, we immediately exit seccomp and
continue. Otherwise, if it's in the "reject" bitmask, we mark it rejected
and immediately exit seccomp. And finally, we run the filters. In all
ways, doing bitmask math is going to be faster than running the BPF. ;)

So how would the API for this work? I have two thoughts, and I don't
think they're exclusive:

- new API for "add this syscall to the reject bitmask". We can't really
  do an "accept" bitmask addition without processing the attached
  filters...
- process attached filters! Each time a filter is added, have the
  BPF verifier do an analysis to determine if there are any static
  results, and set bits in the various bitmasks to represent it.
  i.e. when seccomp is first enabled on a thread, the "accept"
  bitmask is populated with all syscalls, and for each filter, do
  [math,simulation,magic] and knock each syscall out of "accept" if
  it isn't always accepted, and further see if there are any syscalls
  that are always rejected, and mark those in the "reject" bitmask.


Okay, that's all I had ... what do people think?

-Kees


[1] https://lore.kernel.org/lkml/20200515234005.32370-1-sargun@sargun.me/
    https://lore.kernel.org/lkml/20200124091743.3357-1-sargun@sargun.me/
[2] http://man7.org/linux/man-pages/man2/openat2.2.html#NOTES
[3] https://lore.kernel.org/lkml/202003172058.3CB0D95@keescook/
[4] https://lore.kernel.org/lkml/20200518124500.5cb7rtjitbiiw3mq@wittgenstein/
[5] https://lore.kernel.org/lkml/CAMp4zn-Ak0062t9HfMMZvKNv1+EAujgEeg5c4-gtjD-pAGAtTw@mail.gmail.com/
    http://man7.org/linux/man-pages/man2/perf_event_open.2.html
[6] see "move argument parsing?" https://outflux.net/slides/2019/lpc/deep-arg-inspection.pdf
    https://www.youtube.com/watch?v=PnOSPsRzVYM


-- 
Kees Cook
