Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F90D1ED685
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2020 21:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFCTJs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Jun 2020 15:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTJs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Jun 2020 15:09:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D8C08C5C0
        for <linux-api@vger.kernel.org>; Wed,  3 Jun 2020 12:09:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so2391083pgn.5
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2020 12:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9J/QiNIqpGtAFKkXggLRfzQjqDQ5mfigXOY5FAlXiM=;
        b=ZTkVR2x8kUrn+0mo5IyL7Bxo4O7mmo1f3P4NPtAmiiLd1EjAwxJfirJDUPcMpGZ/jU
         VJS8VVcWOdLakx+zAOBYDRVJ4hmnGlPvzAOTjH/Au5XMfMbqOJR6fBeJSpHImlA8kWWj
         MBTYVbdEvtStupaj5eSzvSMkFb07Aoeuj9t9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9J/QiNIqpGtAFKkXggLRfzQjqDQ5mfigXOY5FAlXiM=;
        b=HKPTuENlseZo+2PTgq3qrcPmA8zu7N1in5npqxcnOxx8wUld4Q4nenxM54TmqPxebz
         kjJtZ07mBAsWubLHttla9FhiQ8qNlEJFXmIlaRUWUNzE1+10dSrVM3uXBW9sfKISxzRe
         e7bu//+inka2iLphreYEbPJI40qlDZnaY9KcqxBgA40REI51PsLpM1y1lkM5j0uGIWqZ
         M7bhGo02u+2X7LgocbqiYxWbxE8SlpD8uFV6WBOwnVxoEB3Jr4lB6eJijhB3qmWjfjok
         5kHFmWbhomMVXvuDl+zqCej/JIXKuwFGYxW6xr9z5rvcqlHRN9BCMth0rY8+pD1ItbzF
         a/DA==
X-Gm-Message-State: AOAM533x5A5wsN5feFeIKHzhkHd+Own1cLsHTa8WzeRobHuiCuFs7rL0
        eZf21b7fSkyj/c78yNSeViHg1g==
X-Google-Smtp-Source: ABdhPJw34TkFUaPPCiTDSQTGWE4UdRAQj+6e0F2fDqqbUTEhn0buXYNqap8uLXUdL5nWeSyNWZfY7Q==
X-Received: by 2002:a63:df48:: with SMTP id h8mr95867pgj.411.1591211386235;
        Wed, 03 Jun 2020 12:09:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n189sm418318pfn.108.2020.06.03.12.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 12:09:45 -0700 (PDT)
Date:   Wed, 3 Jun 2020 12:09:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <202005181630.60E58CA0C5@keescook>
References: <202005181120.971232B7B@keescook>
 <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[trying to get back to this thread -- I've been distracted]

On Tue, May 19, 2020 at 12:39:39AM +0200, Jann Horn wrote:
> On Mon, May 18, 2020 at 11:05 PM Kees Cook <keescook@chromium.org> wrote:
> > ## deep argument inspection
> >
> > Background: seccomp users would like to write filters that traverse
> > the user pointers passed into many syscalls, but seccomp can't do this
> > dereference for a variety of reasons (mostly involving race conditions and
> > rearchitecting the entire kernel syscall and copy_from_user() code flows).
> 
> Also, other than for syscall entry, it might be worth thinking about
> whether we want to have a special hook into seccomp for io_uring.
> io_uring is growing support for more and more syscalls, including
> things like openat2, connect, sendmsg, splice and so on, and that list
> is probably just going to grow in the future. If people start wanting
> to use io_uring in software with seccomp filters, it might be
> necessary to come up with some mechanism to prevent io_uring from
> permitting access to almost everything else...

/me perks up. Oh my, I hadn't been paying attention -- I thought this
was strictly for I/O ... like it's named. I will go read up.

> [...]
> > The argument caching bit is, I think, rather mechanical in nature since
> > it's all "just" internal to the kernel: seccomp can likely adjust how it
> > allocates seccomp_data (maybe going so far as to have it split across two
> > pages with the syscall argument struct always starting on the 2nd page
> > boundary), and copying the EA struct into that page, which will be both
> > used by the filter and by the syscall.
> 
> We could also do the same kind of thing the eBPF verifier does in
> convert_ctx_accesses(), and rewrite the context accesses to actually
> go through two different pointers depending on the (constant) offset
> into seccomp_data.

Ah, as in "for seccomp_data accesses, add offset $foo and for EA struct
add offset $bar"? Yeah, though my preference is to avoid rewriting the
filters as much as possible. But yes, that's a good point about not
requiring them be strictly contiguous.

> > I imagine state tracking ("is
> > there a cached EA?", "what is the address of seccomp_data?", "what is
> > the address of the EA?") can be associated with the thread struct.
> 
> You probably mean the task struct?

Yup; think-o.

> > ## syscall bitmasks
> 
> YES PLEASE

I've got a working PoC for this now. It's sneaky.

> Other options:
>  - add a "load from read-only memory" opcode and permit specifying the
> data that should be in that memory when loading the filter

I think you've mentioned something like this before to me, but can you
remind me the details? If you mean RO userspace memory, don't we still
run the risk of racing mprotect, etc?

>  - make the seccomp API take an array of (syscall-number,
> instruction-offset) tuples, and start evaluation of the filter at an
> offset if it's one of those syscalls

To avoid making cBPF changes, yeah, perhaps have a way to add per-syscall
filters.

> One more thing that would be really nice: Is there a way we can have
> 64-bit registers in our seccomp filters? At the moment, every
> comparison has to turn into three ALU ops, which is pretty messy;
> libseccomp got that wrong (<https://crbug.com/project-zero/1769>), and
> it contributes to the horrific code Chrome's BPF generator creates.
> Here's some pseudocode from my hacky BPF disassembler, which shows
> pretty much just the filter code for filtering getpriority() and
> setpriority() in a Chrome renderer, with tons of useless dead code:
> 
> 0139         if args[0].high == 0x00000000: [true +3, false +0]
> 013e           if args[0].low != 0x00000000: [true +157, false +0] -> ret TRAP
> 0140           if args[1].high == 0x00000000: [true +3, false +0]
> 0145             if args[1].low == 0x00000000: [true +149, false +0]
> -> ret ALLOW (syscalls: getpriority, setpriority)
> 0147             if args[1].high == 0x00000000: [true +3, false +0]
> 014c               if args[1].low == 0x00000001: [true +142, false
> +141] -> ret ALLOW (syscalls: getpriority, setpriority)
> 01da               ret ERRNO
> 0148             if args[1].high != 0xffffffff: [true +142, false +0]
> -> ret TRAP
> 014a             if args[1].low NO-COMMON-BITS 0x80000000: [true +140,
> false +0] -> ret TRAP
> 014c             if args[1].low == 0x00000001: [true +142, false +141]
> -> ret ALLOW (syscalls: getpriority, setpriority)
> 01da             ret ERRNO
> 0141           if args[1].high != 0xffffffff: [true +149, false +0] -> ret TRAP
> 0143           if args[1].low NO-COMMON-BITS 0x80000000: [true +147,
> false +0] -> ret TRAP
> 0145           if args[1].low == 0x00000000: [true +149, false +0] ->
> ret ALLOW (syscalls: getpriority, setpriority)
> 0147           if args[1].high == 0x00000000: [true +3, false +0]
> 014c             if args[1].low == 0x00000001: [true +142, false +141]
> -> ret ALLOW (syscalls: getpriority, setpriority)
> 01da             ret ERRNO
> 0148           if args[1].high != 0xffffffff: [true +142, false +0] -> ret TRAP
> 014a           if args[1].low NO-COMMON-BITS 0x80000000: [true +140,
> false +0] -> ret TRAP
> 014c           if args[1].low == 0x00000001: [true +142, false +141]
> -> ret ALLOW (syscalls: getpriority, setpriority)
> 01da           ret ERRNO
> 013a         if args[0].high != 0xffffffff: [true +156, false +0] -> ret TRAP
> 013c         if args[0].low NO-COMMON-BITS 0x80000000: [true +154,
> false +0] -> ret TRAP
> 013e         if args[0].low != 0x00000000: [true +157, false +0] -> ret TRAP
> 0140         if args[1].high == 0x00000000: [true +3, false +0]
> 0145           if args[1].low == 0x00000000: [true +149, false +0] ->
> ret ALLOW (syscalls: getpriority, setpriority)
> 0147           if args[1].high == 0x00000000: [true +3, false +0]
> 014c             if args[1].low == 0x00000001: [true +142, false +141]
> -> ret ALLOW (syscalls: getpriority, setpriority)
> 01da             ret ERRNO
> 0148           if args[1].high != 0xffffffff: [true +142, false +0] -> ret TRAP
> 014a           if args[1].low NO-COMMON-BITS 0x80000000: [true +140,
> false +0] -> ret TRAP
> 014c           if args[1].low == 0x00000001: [true +142, false +141]
> -> ret ALLOW (syscalls: getpriority, setpriority)
> 01da           ret ERRNO
> 0141         if args[1].high != 0xffffffff: [true +149, false +0] -> ret TRAP
> 0143         if args[1].low NO-COMMON-BITS 0x80000000: [true +147,
> false +0] -> ret TRAP
> 0145         if args[1].low == 0x00000000: [true +149, false +0] ->
> ret ALLOW (syscalls: getpriority, setpriority)
> 0147         if args[1].high == 0x00000000: [true +3, false +0]
> 014c           if args[1].low == 0x00000001: [true +142, false +141]
> -> ret ALLOW (syscalls: getpriority, setpriority)
> 01da           ret ERRNO
> 0148         if args[1].high != 0xffffffff: [true +142, false +0] -> ret TRAP
> 014a         if args[1].low NO-COMMON-BITS 0x80000000: [true +140,
> false +0] -> ret TRAP
> 014c         if args[1].low == 0x00000001: [true +142, false +141] ->
> ret ALLOW (syscalls: getpriority, setpriority)
> 01da         ret ERRNO
> 
> which is generated by this little snippet of C++ code:
> 
> ResultExpr RestrictGetSetpriority(pid_t target_pid) {
>   const Arg<int> which(0);
>   const Arg<int> who(1);
>   return If(which == PRIO_PROCESS,
>             Switch(who).CASES((0, target_pid), Allow()).Default(Error(EPERM)))
>       .Else(CrashSIGSYS());
> }

What would this look like in eBPF?

> On anything other than 32-bit MIPS, 32-bit powerpc and 32-bit sparc,
> we're actually already using the eBPF backend infrastructure... so
> maybe it would be an option to keep enforcing basically the same rules
> that we currently have for cBPF, but use the eBPF instruction format?

Yeah, I think this might be a good idea just for the reduction in
complexity for these things. The "unpriv BPF" problem needs to be solved
for this still, though, yes?

-- 
Kees Cook
