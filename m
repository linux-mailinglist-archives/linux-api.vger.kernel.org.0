Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C291D8B15
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 00:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgERWkM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 18:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgERWkJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 18:40:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2261C05BD09
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 15:40:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c12so6063795lfc.10
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyufSDQ+mjTGgbF/gJ7nyoqjw/U1bJe95Dy8bOiBLh8=;
        b=YMauaD2C+q8SoYoEhIcIWir+6IHcBhD/krvjJgTzvjJM+f4zHiiWI2yZ0Bj29mSbq2
         Bc67q3F3wjF9k0IpbeAdcko8+FQNADgTnc1tGPRPwFeC+WrvBtuOzNoYTgxMwADy/um2
         EbjubsC3IxmLzZoY8t9/e1ma2RfR11QRxq9uHv1aQS+ss6WZjteKD5wPbfETk2wUe3La
         1k4GUv3rKG7RXOxDCKEe0KXn8ShVHsNTCmMMezNzY2zdZHVwgkRUuBvSzJGwhBPnTWFR
         DAYJsR573nzz/SX1ovp4FnYkgHzPbhSay39lZPu0N0YdwrG+wsyNNQWXuxtd3rhEEsYr
         20xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyufSDQ+mjTGgbF/gJ7nyoqjw/U1bJe95Dy8bOiBLh8=;
        b=Cx0eYuTRCnuRyPgdKkaqwI01c/Rfw8+ARkQzyrbwHgcyFO+0iN1YIyhmqImK3oRtOX
         BMfhpOpVepMjgjfs89AfcliYhE7geOPRvbZ3ymJVL0f7dRJMUsyJI+5BuhRkHnA5iUyo
         dGZYrv35kCbsefX5ifUTYtddGaRbi2FQVJyMYrACUOu6LIHms+eUIAb9hKnJlzdIYpYB
         Wy0b67ws2NJWb3/P/rJ5Xshgfv3b7gOcMYIiGNJixpTlblBGesrE+GhbLw+SAqfjtfvk
         DAC+O0tH6DgKPDUGJZMG4/antUuKA1YTnWLxVQ0h3WNqBqYSkW8qy9modNHctQlmaTft
         mIeg==
X-Gm-Message-State: AOAM533nDKhZwNnoQmnRW2xO6SgA2dg1GnBkcwG+qmj8u8Fghu5Nj6SM
        7AHBFdWiiLIxSL/i/5nxf8sd8qChOgl38EjriAcAhA==
X-Google-Smtp-Source: ABdhPJzvfMDKb+XCZXKLli7j8WQ3yzAOzucxgODeYv988tBwd82PiIlCrouJdkydsaFDD4/X6+VdohDMWlrqYSJizR0=
X-Received: by 2002:a05:6512:6ca:: with SMTP id u10mr13516822lff.184.1589841605769;
 Mon, 18 May 2020 15:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <202005181120.971232B7B@keescook>
In-Reply-To: <202005181120.971232B7B@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 19 May 2020 00:39:39 +0200
Message-ID: <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
Subject: Re: seccomp feature development
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 18, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wrote:
> ## deep argument inspection
>
> Background: seccomp users would like to write filters that traverse
> the user pointers passed into many syscalls, but seccomp can't do this
> dereference for a variety of reasons (mostly involving race conditions and
> rearchitecting the entire kernel syscall and copy_from_user() code flows).

Also, other than for syscall entry, it might be worth thinking about
whether we want to have a special hook into seccomp for io_uring.
io_uring is growing support for more and more syscalls, including
things like openat2, connect, sendmsg, splice and so on, and that list
is probably just going to grow in the future. If people start wanting
to use io_uring in software with seccomp filters, it might be
necessary to come up with some mechanism to prevent io_uring from
permitting access to almost everything else...

Probably not a big priority for now, but something to keep in mind for
the future.

[...]
> The argument caching bit is, I think, rather mechanical in nature since
> it's all "just" internal to the kernel: seccomp can likely adjust how it
> allocates seccomp_data (maybe going so far as to have it split across two
> pages with the syscall argument struct always starting on the 2nd page
> boundary), and copying the EA struct into that page, which will be both
> used by the filter and by the syscall.

We could also do the same kind of thing the eBPF verifier does in
convert_ctx_accesses(), and rewrite the context accesses to actually
go through two different pointers depending on the (constant) offset
into seccomp_data.

> I imagine state tracking ("is
> there a cached EA?", "what is the address of seccomp_data?", "what is
> the address of the EA?") can be associated with the thread struct.

You probably mean the task struct?

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

We don't need to actually zero-fill memory for this beyond what the
kernel supports - AFAIK the existing APIs already say that passing a
short length is equivalent to passing zeroes, so we can just replace
all out-of-bounds loads with zeroing registers in the filter.
The tricky case is what should happen if the userspace program passes
in fields that the filter doesn't know about. The filter can see the
length field passed in by userspace, and then just reject anything
where the length field is bigger than the structure size the filter
knows about. But maybe it'd be slightly nicer if there was an
operation for "tell me whether everything starting at offset X is
zeroes", so that if someone compiles with newer kernel headers where
the struct is bigger, and leaves the new fields zeroed, the syscalls
still go through an outdated filter properly.

> And then, my age-old concern, that maybe doesn't need a solution... I
> remain plagued by the lack of pathname inspection. But I think the
> ToCToU nature of it means we just cannot do it from seccomp. It does
> make filtering openat2()'s EA struct a bit funny... a filter has no idea
> what path it applies to... but that doesn't matter because the object
> the path points to might change[6] during the syscall. Argh.

I don't think seccomp needs to care about paths. Instead, you can use
one of these three approaches:

1) You can make openat2() the only syscall that is allowed to take
non-empty path arguments, and restrict it to
RESOLVE_BENEATH|RESOLVE_IN_ROOT. (For APIs that use AT_EMPTY_PATH, we
can probably come up with some way to say "this part must be an empty
string" - e.g. by defining a new bogus placeholder pointer that you
can use as "empty path", or something like that.) This is basically
like the old capsicum O_BENEATH stuff, except with seccomp doing the
enforcement that you're not using absolute paths or things like that.
2) You can create a new mount namespace, then use open_tree() with
OPEN_TREE_CLONE to create file descriptors to ephemeral bind mounts,
then sandbox yourself with pivot_root().
3) You can use Mickael's landlock, once that's landed.

In particular the first and second option are things you can already
do today - although the first one requires that you have a seccomp
filter that prevents the program from overwriting/unmapping/... the
chunk of memory that contains the openat2 argument structure, so that
you can then whitelist the argument structure's address in the filter.

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

This thing (which hasn't landed so far, but would be a really awesome
feature) needed to add stuff to seccomp_data:
<https://lore.kernel.org/linux-api/20181029112343.27454-1-msammler@mpi-sws.org/>

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
>         unsigned long feature_bits;
>         unsigned long interesting_thing_1;
>         unsigned long interesting_thing_2;
>         unsigned long interesting_thing_3;
>         ...
>
> and the filter would check feature_bits...

(Apart from the user_notif stuff, those feature bits would not
actually have to exist in memory; they could be inlined while loading
the program. Actually, not even the registers would have to exist in a
seccomp_data struct in memory, we could just replace the loads with
reads from the pt_regs, too.)

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

Just as a note: If we use read() there, we'll never be able to
transfer things like FDs through that API.

> ## syscall bitmasks

YES PLEASE

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
>   it isn't always accepted, and further see if there are any syscalls
>   that are always rejected, and mark those in the "reject" bitmask.

Other options:
 - add a "load from read-only memory" opcode and permit specifying the
data that should be in that memory when loading the filter
 - make the seccomp API take an array of (syscall-number,
instruction-offset) tuples, and start evaluation of the filter at an
offset if it's one of those syscalls

One more thing that would be really nice: Is there a way we can have
64-bit registers in our seccomp filters? At the moment, every
comparison has to turn into three ALU ops, which is pretty messy;
libseccomp got that wrong (<https://crbug.com/project-zero/1769>), and
it contributes to the horrific code Chrome's BPF generator creates.
Here's some pseudocode from my hacky BPF disassembler, which shows
pretty much just the filter code for filtering getpriority() and
setpriority() in a Chrome renderer, with tons of useless dead code:

0139         if args[0].high == 0x00000000: [true +3, false +0]
013e           if args[0].low != 0x00000000: [true +157, false +0] -> ret TRAP
0140           if args[1].high == 0x00000000: [true +3, false +0]
0145             if args[1].low == 0x00000000: [true +149, false +0]
-> ret ALLOW (syscalls: getpriority, setpriority)
0147             if args[1].high == 0x00000000: [true +3, false +0]
014c               if args[1].low == 0x00000001: [true +142, false
+141] -> ret ALLOW (syscalls: getpriority, setpriority)
01da               ret ERRNO
0148             if args[1].high != 0xffffffff: [true +142, false +0]
-> ret TRAP
014a             if args[1].low NO-COMMON-BITS 0x80000000: [true +140,
false +0] -> ret TRAP
014c             if args[1].low == 0x00000001: [true +142, false +141]
-> ret ALLOW (syscalls: getpriority, setpriority)
01da             ret ERRNO
0141           if args[1].high != 0xffffffff: [true +149, false +0] -> ret TRAP
0143           if args[1].low NO-COMMON-BITS 0x80000000: [true +147,
false +0] -> ret TRAP
0145           if args[1].low == 0x00000000: [true +149, false +0] ->
ret ALLOW (syscalls: getpriority, setpriority)
0147           if args[1].high == 0x00000000: [true +3, false +0]
014c             if args[1].low == 0x00000001: [true +142, false +141]
-> ret ALLOW (syscalls: getpriority, setpriority)
01da             ret ERRNO
0148           if args[1].high != 0xffffffff: [true +142, false +0] -> ret TRAP
014a           if args[1].low NO-COMMON-BITS 0x80000000: [true +140,
false +0] -> ret TRAP
014c           if args[1].low == 0x00000001: [true +142, false +141]
-> ret ALLOW (syscalls: getpriority, setpriority)
01da           ret ERRNO
013a         if args[0].high != 0xffffffff: [true +156, false +0] -> ret TRAP
013c         if args[0].low NO-COMMON-BITS 0x80000000: [true +154,
false +0] -> ret TRAP
013e         if args[0].low != 0x00000000: [true +157, false +0] -> ret TRAP
0140         if args[1].high == 0x00000000: [true +3, false +0]
0145           if args[1].low == 0x00000000: [true +149, false +0] ->
ret ALLOW (syscalls: getpriority, setpriority)
0147           if args[1].high == 0x00000000: [true +3, false +0]
014c             if args[1].low == 0x00000001: [true +142, false +141]
-> ret ALLOW (syscalls: getpriority, setpriority)
01da             ret ERRNO
0148           if args[1].high != 0xffffffff: [true +142, false +0] -> ret TRAP
014a           if args[1].low NO-COMMON-BITS 0x80000000: [true +140,
false +0] -> ret TRAP
014c           if args[1].low == 0x00000001: [true +142, false +141]
-> ret ALLOW (syscalls: getpriority, setpriority)
01da           ret ERRNO
0141         if args[1].high != 0xffffffff: [true +149, false +0] -> ret TRAP
0143         if args[1].low NO-COMMON-BITS 0x80000000: [true +147,
false +0] -> ret TRAP
0145         if args[1].low == 0x00000000: [true +149, false +0] ->
ret ALLOW (syscalls: getpriority, setpriority)
0147         if args[1].high == 0x00000000: [true +3, false +0]
014c           if args[1].low == 0x00000001: [true +142, false +141]
-> ret ALLOW (syscalls: getpriority, setpriority)
01da           ret ERRNO
0148         if args[1].high != 0xffffffff: [true +142, false +0] -> ret TRAP
014a         if args[1].low NO-COMMON-BITS 0x80000000: [true +140,
false +0] -> ret TRAP
014c         if args[1].low == 0x00000001: [true +142, false +141] ->
ret ALLOW (syscalls: getpriority, setpriority)
01da         ret ERRNO

which is generated by this little snippet of C++ code:

ResultExpr RestrictGetSetpriority(pid_t target_pid) {
  const Arg<int> which(0);
  const Arg<int> who(1);
  return If(which == PRIO_PROCESS,
            Switch(who).CASES((0, target_pid), Allow()).Default(Error(EPERM)))
      .Else(CrashSIGSYS());
}

On anything other than 32-bit MIPS, 32-bit powerpc and 32-bit sparc,
we're actually already using the eBPF backend infrastructure... so
maybe it would be an option to keep enforcing basically the same rules
that we currently have for cBPF, but use the eBPF instruction format?
