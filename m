Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25951DAD31
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2020 10:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgETIXd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 May 2020 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETIXc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 May 2020 04:23:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB335C061A0E
        for <linux-api@vger.kernel.org>; Wed, 20 May 2020 01:23:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j8so2157129iog.13
        for <linux-api@vger.kernel.org>; Wed, 20 May 2020 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tvhc95Q3g028qLTJV8u0mdNMwmqDgdXr1VFvPL6SRJQ=;
        b=IktwJbLztFdygn1fXL+7Wczekks99TerhdSvVxlaDmBO/+xj1ql6ek9dfjOcjyVarN
         pSvsnpHrD/4r21ZQDlx0dynwRciBGiF4E26yx2NIn2p16cBpi6HgqsN8GcG5AYg2Sm0I
         kSIvTW/+o9RO6ruDJM8sArHRxMie8dfkuRXxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tvhc95Q3g028qLTJV8u0mdNMwmqDgdXr1VFvPL6SRJQ=;
        b=IhLCY1Ta7hIHbUgTVCJyMg5a9mCpku9peeevvmlVIr7tlNprKrZfYpfEOrk1h+GR4i
         qwZXFPCsJt4COOsynt3wW/BTDFjjE3ZGtCCLuKrluEmxsUnJw6o9Vn1sPi6+VPPh266m
         KAxqqct3Si5JKy+8h1S+MEx2lfpwjXGaQAv/kbGKz/71Gyp2pkZZ7VjHNJoYC4RxdVZ2
         LVXXgX5P8KnIsSU4Jo/0/big/S2wZZfvwRMtcq5TC2ZhvrCp9mswESHpR6uvGpIn9+uF
         41sfWvg9Al3w4pCbQ+pGbROULw1UrX3XsS5Z8Kkng7SsOpMZgqEdPy1pwat3bmiw7lz7
         X7rw==
X-Gm-Message-State: AOAM533ZGZdLqrLW9GkJojoR7VKbM2QkUtq1kHGCvaCLXXHYI2IERB8+
        MtQLo238QCkU9pUQp+IixdgmBg==
X-Google-Smtp-Source: ABdhPJwEqarmfMUcn8Jgj5d0caODWN1mY0iJB8Tw1UL2AXnEcySOgJAlqmTuKvz0uNn0JefbnIADsw==
X-Received: by 2002:a6b:6414:: with SMTP id t20mr2541747iog.32.1589963010913;
        Wed, 20 May 2020 01:23:30 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id a20sm883940iot.17.2020.05.20.01.23.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 01:23:29 -0700 (PDT)
Date:   Wed, 20 May 2020 08:23:28 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <CAMp4zn-hs=e6Di9QddR1hYYiWixeUDh_R1eV2_VngZ=D3u=2pg@mail.gmail.com>
References: <202005181120.971232B7B@keescook>
 <20200519102648.dnnciytdaocfrmjc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519102648.dnnciytdaocfrmjc@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On Tue, May 19, 2020 at 3:26 AM Christian Brauner <christian.brauner@ubuntu.com> wrote:
>
> On Mon, May 18, 2020 at 02:04:57PM -0700, Kees Cook wrote:
> > Hi!
> >
> > This is my attempt at a brain-dump on my plans for nearish-term seccomp
> > features. Welcome to my TED talk... ;)
> >
> > These are the things I've been thinking about:
> >
> > - fd passing
> > - deep argument inspection
> > - changing structure sizes
> > - syscall bitmasks
> >
> > ## changing structure sizes
> >
> > Background: there have been regular needs to add things to various
> > seccomp structures. Each come with their own unique pains, and solving
> > this as completely as possible in a future-proof way would be very nice.
> >
> > As noted in "fd passing" above, there is a desire to add some useful
> > things to the user_notif struct (e.g. thread group pid). Similarly,
> > there have been requests in the past (though I can't find any good
> > references right now, just my indirect comments[3]) to grow seccomp_data.
> > Combined with the EA struct work above, there's a clear need for seccomp
> > to reexamine how it deals with its API structures (and how this
> > interacts with filters).
> >
> > First, let's consider seccomp_data. If we grow it, the EA struct offset
> > will move, based on the deep arg inspection design above. Alternatively,
> > we could instead put seccomp_data offset 0, and EA struct at offset
> > PAGE_SIZE, and treat seccomp_data itself as an EA struct where we let
> > the filter access whatever it thinks is there, with it being zero-filled
> > by the kernel. For any values where 0 is valid, there will just need to
> > be a "is that field valid?" bit before it:
>
> That's exactly what clone3() - and openat2() too - I think is doing.
> (Case in point, CLONE_INTO_CGROUP with the .cgroup member referencing a
>  file descriptor for which 0 is obviously valid.)
>
> >
> >       unsigned long feature_bits;
> >       unsigned long interesting_thing_1;
> >       unsigned long interesting_thing_2;
> >       unsigned long interesting_thing_3;
> >       ...
> >
> > and the filter would check feature_bits...
> >
> > (However, this needs to be carefully considered given that seccomp_data
> > is embedded in user_notif... should the EA struct from userspace also be
> > copied into user_notif? More thoughts on this below...)
> >
> > For user_notif, I think we need something in and around these options:
> >
> > - make a new API that explicitly follows EA struct design
> >   (and while read()/write() might be easier[4], I tend to agree with
> >   Jann and we need to stick to ioctl(): as Tycho noted, "read/write is
> >   for data". Though I wonder if read() could be used for the notifications,
> >   which ARE data, and use ioctl() for the responses?)
>
> I'm still pretty convinced that my original suggestion here to switch
> user_notif over to esyscall design is the way to go and probably the
> least complex.
>
I think that the big difference in the esyscall design is that the
nested structures don't require evolution. In addition, the kernel
deals with the burden of old versions of userspace structs without
requiring the user to do dynamic allocation.

> > - make a new API that is perf_event_open()-style where fields are
> >   explicitly requested, as Sargun suggested[5]. (This looks like it
> >   might be complex to construct, but would get us by far the most
> >   extensible API.)
> > - jam whatever we pick into the existing API (we'll be forced to do
> >   SOMETHING to make the old API still work, so, I dunno what that will
> >   look like until we finish the rest of the design).
> >
> > If we did a requested-fields approach, what would the user_notif event
> > block of bytes look like? Would it be entirely dynamic based on the
> > initial ioctl()? Another design consideration here is that we don't want
> > the kernel doing tons of work (especially copying) and tossing tons
> > of stuff into a huge structure that the user doesn't care about. In
> > addition to explicit fields, maybe the EA struct could be included,
> > perhaps with specified offset/size, so only the portion the user_notif
> > user wanted to inspect was copied?
> >
> > The complexity of the per-field API is higher, but I think it might be
> > the most robust and have the greatest chance at being performant.
> > For example, "send me user_notif but I only care about the pid" would
> > mean no syscall arguments are copied, etc.
>
> Before we go with such a flexible design we should ask who's going to
> use it that way? At least for our use-cass we always want everything.
> Maybe I'm missing other uses though. But most use-cases seem kinda
> pointless, e.g. just getting the pid seems not interesting. I could see
> a use-case for pid + syscall number without arguments and the notifier
> always replying with _CONTINUE but even that seems a little odd to me.
>
I think it's worth being clear about the perf_event_attr style API [1][2].
That's here there are two steps:
1. Configure what / how / versions of fields you want to receive. This looks
something like this:
struct seccomp_notif_config {
	/*
	 * Size of this data structure, indicating which 
	 * member fields are included.
	 */
	__u32	size;
	/* Bitmask of optional fields */
	__u64	optional_fixed_size_fields;
	/* Size indicates version. 0 means omit */
	__u32	size_of_variable_member1;
	__u32	size_of_variable_member2;
	/* New varible sized members are added at the end */
}
2. Then at read time, the user builds a structure like this on the stack:
struct notif_flat {
	/* Existing variable members cannot have their sizes changed */
	struct variable_member1 ...;
	struct variable_member2 ...;
	__u32 optional_field1;
	__u32 optional_field2;
}
And you can read (or ioctl) the notification into the buffer in one-go.

There is a slightly different alternative where the data structure
you share with the kernel looks more like:
struct notif_submembers {
	__u32 optional_field1;
	__u32 optional_field2;
}
struct notif_ptrs {
	/* Points are empty buffers the size of variable member */
	struct *variable_member1;
	struct *variable_member2;
	// You cannot interleave fixed fields, they may be at the end
	struct notif_submembers members;
}

I think that userspace signaling up to kernelspace what it wants is a better
design. I'm not sure how the kernel would tell userspace to lay out a structure
of mixed pointers, and flat fields, so I think you'd have something like this:

/* this datastructure is returned by the kernel */
struct seccom_sizes {
	__u32	num_members;
	/* Ack, VLA */
	__u32	member_sizes[];
	__u32	submember_size;;	
}

If we go down the route of notif_ptrs, it requires the kernel read in
the datastructure, find the pointers in userspace and copy out to a bunch of
other buffers. In addition, it means the userspace has to deal with managing
all these buffers (And have a mechanism like seccomp_notif_sizes to find the
number of structures, and their respective buffer size). Because this is
dynamic and not static (can vary based on kernel version), the user can no
longer rely on stack allocations / static programming, and has to do at least
some basic casting back and forth to void.

If we go down the route of notif_flat, it makes thing slightly nicer, unless
we want to upgrade (extend) a field without moving it to the bottom of the
datastructure. If we try to do in-place growth it will move around all
the other fields.

I think that perf_event_attr style API not only solves this problem more
cleanly (at least from the perspective of userspace), but it also means
less extra memory copies if we don't need to. I think that this is interesting
from the perspective of performance, and simpler userspace code without
having to do dynamic allocations for fields that I do not care about.
Although the fields we've discussed adding so far (pidfd, tgid) are tiny,
cheap, and easy to work with, they still mean that userspace has to
deal with dynamic memory allocation.

Mostly, I'd like to get clarity on:
1. Do we want to go down the route of perf_event_attr or continue to have
a mechanism where the kernel tells userspace how to layout a struct at runtime

If we want to do the latter, can someone counterpropose an API if they
have a better idea than that I've described aboe.
2. Do we want to want to open the door to read(2) for receiving events?
3. Do we want to *ever* send other things with events? (FDs) -- it sounds
   like we've answered this one with a no
4. Should the kernel be able to handle userspace applications without
requiring them to dynamic allocations?
5. Where does this become a performance concern?
6. Is there *anything* that is a good idea to pass back with the notification
(FDs, locks, etc...?)

-Sargun

[1]: https://lore.kernel.org/linux-api/20200518213734.GA25216@ircssh-2.c.rugged-nimbus-611.internal/
[2]: https://lore.kernel.org/linux-api/20200518083224.GA16270@ircssh-2.c.rugged-nimbus-611.internal/
