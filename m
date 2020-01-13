Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B949139848
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgAMSCj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 13:02:39 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37350 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgAMSCj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 13:02:39 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so4604814pjb.2;
        Mon, 13 Jan 2020 10:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3LTw7gnh2l+GenASPNMgebGB+0QdjUuP2xkFIISEt1k=;
        b=SNvR1EqyZEkpVxwyZe+G9tvItFI6ANOEEsFwSzUdxfb6EQHtis4t8ScfhdKZ8W0hQU
         Ms1RN7pbPwvW63JV6jLfFoKNGSad7fUV9jWhJr8pipyGuITyR105XJummcDzd+4sIOFY
         sFvro+82OOPcEHSZo/5dw372DQUCReQyUAydtQ9zcqioUlhrS4aqh71KyqnOOnpVVZK3
         e12i0+Wq/cwwvZEkmu185f5vCokVhFOkzEnPt2yGYG9kFUMgIOj3LbrEUrNCX41eNZHe
         uVTB8mbrzTIh/BJOGLF2N6HNl8zG/nu6p3oBH79h7cm5BEGELQxuS0oRZBGNbc4lXDCb
         k+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3LTw7gnh2l+GenASPNMgebGB+0QdjUuP2xkFIISEt1k=;
        b=V8QdU5a7yWJ3KIiBF6FwqMl/y/ZxRptIz/6O8hZ1tiu9FZydqzJH7EUB0xUAPECcwP
         wFmZ857Bp/hJIprlRuu8P/VIdlriRf2iV1TqGQnVstyEGEdKMBGF87XOJbriufpLPYZ/
         fRo72LLCQCOVNBQ3lQUd1Bgl2hWii77RRXG40Be9Lm9QBa/7UM3jIJyZXVbu5QHbH17L
         sJNw9A2elPJiLdtTRV9/rl2ureLg6ZWyTUjAkrzMah74EKmp8AVQycx/O4WMtbbpXRLw
         41lv7Bqilf+m5z1XivNukgw5e7XnHjFhrHyDdcdI7hvczywPj3Xhw7q3lfec2523YkZo
         z7mg==
X-Gm-Message-State: APjAAAVo/fHy3zhlPsOPApSUKV+ZvbHk3qyGQNCA+JkrNO+shWrX8wxP
        c2OEEf1LQdWZHROU30ICj8U=
X-Google-Smtp-Source: APXvYqwtKvDz8srJ5hh5IFVAaDmTKCmCFhbN78Ba2LDKf1eZOgWMK7Hgjh67AG3vsmBcrmeNw/yBXg==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr23723158pjb.44.1578938557564;
        Mon, 13 Jan 2020 10:02:37 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t30sm14096286pgl.75.2020.01.13.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:02:33 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:02:30 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
Message-ID: <20200113180230.GA110363@google.com>
References: <20200110213433.94739-3-minchan@kernel.org>
 <20200111073452.25182-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111073452.25182-1-sj38.park@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jan 11, 2020 at 08:34:52AM +0100, SeongJae Park wrote:
> On Fri, 10 Jan 2020 13:34:31 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > There are usecases that System Management Software(SMS) want to give
> > a memory hint to other processes because it's not known to the
> > application. In the case of Android, ActivityManagerService daemon
> > manges app's life cycle and that daemon must be able to initiate
> > reclaim on its own without any app involvement.
> > 
> > To solve the issue, this patch introduces new syscall process_madvise(2).
> > It uses pidfd of an external processs to give the hint.
> > 
> >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > 			unsigned long flag);
> > 
> > Since it could affect other process's address range, only privileged
> > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > gives it the right to ptrace the process could use it successfully.
> > The flag argument is reserved for future use if we need to extend the
> > API.
> > 
> > Supporting all hints madvise has/will supported/support to process_madvise
> > is rather risky. Because we are not sure all hints make sense from external
> > process and implementation for the hint may rely on the caller being
> > in the current context so it could be error-prone. Thus, I just limited
> > hints as MADV_[COLD|PAGEOUT] in this patch.
> > 
> > If someone want to add other hints, we could hear hear the usecase and
> > review it for each hint. It's more safe for maintainace rather than
> > introducing a buggy syscall but hard to fix it later.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
> >  arch/arm/tools/syscall.tbl                  |  1 +
> >  arch/arm64/include/asm/unistd.h             |  2 +-
> >  arch/arm64/include/asm/unistd32.h           |  2 +
> >  arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |  1 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |  1 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
> >  include/linux/syscalls.h                    |  2 +
> >  include/uapi/asm-generic/unistd.h           |  5 +-
> >  kernel/sys_ni.c                             |  1 +
> >  mm/madvise.c                                | 64 +++++++++++++++++++++
> >  21 files changed, 89 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> > index e56950f23b49..776c61803315 100644
> > --- a/arch/alpha/kernel/syscalls/syscall.tbl
> > +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> > @@ -477,3 +477,4 @@
> >  # 545 reserved for clone3
> >  546	common	watch_devices			sys_watch_devices
> >  547	common	openat2				sys_openat2
> > +548	common	process_madvise			sys_process_madvise
> > diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> > index 7fb2f4d59210..a43381542276 100644
> > --- a/arch/arm/tools/syscall.tbl
> > +++ b/arch/arm/tools/syscall.tbl
> > @@ -451,3 +451,4 @@
> >  435	common	clone3				sys_clone3
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2				sys_openat2
> > +438	common	process_madvise			sys_process_madvise
> > diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> > index 8aa00ccb0b96..b722e47377a5 100644
> > --- a/arch/arm64/include/asm/unistd.h
> > +++ b/arch/arm64/include/asm/unistd.h
> > @@ -38,7 +38,7 @@
> >  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
> >  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
> >  
> > -#define __NR_compat_syscalls		438
> > +#define __NR_compat_syscalls		439
> >  #endif
> >  
> >  #define __ARCH_WANT_SYS_CLONE
> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 31f0ce25719e..5c82557d408f 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -883,6 +883,8 @@ __SYSCALL(__NR_clone3, sys_clone3)
> >  __SYSCALL(__NR_watch_devices, sys_watch_devices)
> >  #define __NR_openat2 437
> >  __SYSCALL(__NR_openat2, sys_openat2)
> > +#define __NR_openat2 438
> 
> Shouldn't this be '#define __NR_process_madvise 438'?
> 
> > +__SYSCALL(__NR_process_madvise, process_madvise)
> >  
> >  /*
> >   * Please add new compat syscalls above this comment and update
> > diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> > index b9aa59931905..c156abc9a298 100644
> > --- a/arch/ia64/kernel/syscalls/syscall.tbl
> > +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> > @@ -358,3 +358,4 @@
> >  # 435 reserved for clone3
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2				sys_openat2
> > +438	common	process_madvise			sys_process_madvise
> > diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> > index 868c1ef89d35..5b6034b6650f 100644
> > --- a/arch/m68k/kernel/syscalls/syscall.tbl
> > +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> > @@ -437,3 +437,4 @@
> >  # 435 reserved for clone3
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2				sys_openat2
> > +438	common	process_madvise			sys_process_madvise
> > diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> > index 544b4cef18b3..4bef584af09c 100644
> > --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> > +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> > @@ -443,3 +443,4 @@
> >  435	common	clone3				sys_clone3
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2				sys_openat2
> > +438	common	process_madvise			sys_process_madvise
> > diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> > index 05e8aee5dae7..94fbd0fcccce 100644
> > --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> > @@ -376,3 +376,4 @@
> >  435	n32	clone3				__sys_clone3
> >  436	n32	watch_devices			sys_watch_devices
> >  437	n32	openat2				sys_openat2
> > +437	n32	process_madivse			sys_process_madvise
> 
> Shouldn't the number for the 'process_madvise' be '438' instead of '437'?
> 
> > diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > index 24d6c01328fb..4e6982c429d5 100644
> > --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > @@ -352,3 +352,4 @@
> >  435	n64	clone3				__sys_clone3
> >  436	n64	watch_devices			sys_watch_devices
> >  437	n64	openat2				sys_openat2
> > +437	n64	process_madvise			sys_process_madvise
> 
> 438?  Same for below 5 changes.
> 
> > diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> > index 4b5f77a4e1a2..3aa990caf9dc 100644
> > --- a/arch/parisc/kernel/syscalls/syscall.tbl
> > +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> > @@ -435,3 +435,4 @@
> >  435	common	clone3				sys_clone3_wrapper
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2				sys_openat2
> > +437	common	process_madvise			sys_process_madvise
> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> > index 9716dc85a517..30e727a23f33 100644
> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> > @@ -519,3 +519,4 @@
> >  435	nospu	clone3				ppc_clone3
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2				sys_openat2
> > +437	common	process_madvise			sys_process_madvise
> > diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> > index 7da330f8b03e..75722e5ff496 100644
> > --- a/arch/s390/kernel/syscalls/syscall.tbl
> > +++ b/arch/s390/kernel/syscalls/syscall.tbl
> > @@ -440,3 +440,4 @@
> >  435  common	clone3			sys_clone3			sys_clone3
> >  436  common	watch_devices		sys_watch_devices		sys_watch_devices
> >  437  common	openat2			sys_openat2			sys_openat2
> > +437  common	process_madvise		sys_process_madvise		sys_process_madvise
> > diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> > index bb7e68e25337..7d7bc7befad3 100644
> > --- a/arch/sh/kernel/syscalls/syscall.tbl
> > +++ b/arch/sh/kernel/syscalls/syscall.tbl
> > @@ -440,3 +440,4 @@
> >  # 435 reserved for clone3
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2				sys_openat2
> > +437	common	process_madvise			sys_process_madvise
> > diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> > index 646a1fad7218..581d331ff62f 100644
> > --- a/arch/sparc/kernel/syscalls/syscall.tbl
> > +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> > @@ -483,3 +483,4 @@
> >  # 435 reserved for clone3
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2			sys_openat2
> > +437	common	process_madvise		sys_process_madvise
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 57c53acee290..76a2c266fe7e 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -442,3 +442,4 @@
> >  435	i386	clone3			sys_clone3			__ia32_sys_clone3
> >  436	i386	watch_devices		sys_watch_devices		__ia32_sys_watch_devices
> >  437	i386	openat2			sys_openat2			__ia32_sys_openat2
> > +438	i386	process_madvise		sys_process_madvise		__ia32_sys_process_madvise
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 1dd8d21f6500..b697cd8620cb 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -359,6 +359,7 @@
> >  435	common	clone3			__x64_sys_clone3/ptregs
> >  436	common	watch_devices		__x64_sys_watch_devices
> >  437	common	openat2			__x64_sys_openat2
> > +438	common	process_madvise		__x64_sys_process_madvise
> >  
> >  #
> >  # x32-specific system call numbers start at 512 to avoid cache impact
> > diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> > index 0f48ab7bd75b..2e9813ecfd7d 100644
> > --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> > +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> > @@ -408,3 +408,4 @@
> >  435	common	clone3				sys_clone3
> >  436	common	watch_devices			sys_watch_devices
> >  437	common	openat2				sys_openat2
> > +438	common	process_madvise			sys_process_madvise
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 433c8c85636e..1b58a11ff49f 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -877,6 +877,8 @@ asmlinkage long sys_munlockall(void);
> >  asmlinkage long sys_mincore(unsigned long start, size_t len,
> >  				unsigned char __user * vec);
> >  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> > +asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
> > +			size_t len, int behavior, unsigned long flags);
> >  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
> >  			unsigned long prot, unsigned long pgoff,
> >  			unsigned long flags);
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 33f3856a9c3c..4bcd8d366f38 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -856,8 +856,11 @@ __SYSCALL(__NR_watch_devices, sys_watch_devices)
> >  #define __NR_openat2 437
> >  __SYSCALL(__NR_openat2, sys_openat2)
> >  
> > +#define __NR_openat2 438
> 
> Shouldn't this be '#define __NR_process_madvise 438'?
> 

Hi SeongJae,

I fixed all you pointed out.

Thanks for the review.
