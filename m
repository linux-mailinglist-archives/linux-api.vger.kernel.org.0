Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01DF1D9C59
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgESQUC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 12:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESQUB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 12:20:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C968CC08C5C0;
        Tue, 19 May 2020 09:20:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so45189pgl.9;
        Tue, 19 May 2020 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JF34kt26RhjaruLc/XD2gQz0xHA0enu1v9lenrfmiDA=;
        b=J4gOPm6RhgMNtmf6QP7YkHQThu3dS0r/9CYjL1rQH87rUBxldBoKze8gii4q9bhqvF
         VOOJRlZNYKOLM1jPKP93Vgwue69567kESoCFZZP/cTfT+7CqDR7QarLbaCsPftdr7dWD
         uTF9+xgcuTcPR5XCfPzsv24ObmVmlPdzKvCZyT4At5VMqIDxLbFMWvKOJ6jDIQUQSXP5
         Th1AL3t7jjHBupCtoc3S8yDsNlqbU/qfrlxF+xgtXz4Bd37fKKLukyXRYSoKHc4ftsqy
         4o7nPV2NMOx/u4GGVllSNgOvIctcMgJoSWTxXkZYrrB16jsnsLUoDzZqFwERLRY2KBMc
         PFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JF34kt26RhjaruLc/XD2gQz0xHA0enu1v9lenrfmiDA=;
        b=Vytc37QPfIGvyWM6bCetK0xvkEPHJicdHslTPrkUS2xaxlD1k2bTrmKSWLAdboF5Q0
         khbuRs9X59QiRX4a66+ZWMZxBgwpFTLRr5/IUuFUj06BYsMrHn4LgdS0Ri2mfOGWvlc5
         kPX1N8aVTm7yqbjoz9uNpKwt0EXjL1+XXrtgzzKcfjqAfMT0Wz4l3a74kyeEaTFQxLpl
         sx+3O9Y3sOuzPxRQacSIb7GIyVI7MO5s5HDREUs1o84QshLAHFDB/WzcCOn1SEYgA0cF
         R6L8HDFi2yARHWiLTLWkG1q+rcIuB1YXnbhCPspupeZ40wAHo7Jnno/wnLh7/pAukNsu
         8Zgw==
X-Gm-Message-State: AOAM533PVJa++dS7EZ1MGEM3Kl2W9A+9MMezlk19mKEGfY6qp1Evwhij
        Dh9wfXR840Hzp5h1aXRkFZc=
X-Google-Smtp-Source: ABdhPJxmQQoLLJIQTZ6lhp/NktndRp59hFeHjp6S0RUGCxMVnXo5ZeGDkhhfH8HpA+nYn6zSfjYIlQ==
X-Received: by 2002:a62:8849:: with SMTP id l70mr14666485pfd.44.1589905201080;
        Tue, 19 May 2020 09:20:01 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::e690])
        by smtp.gmail.com with ESMTPSA id 3sm8223pfo.27.2020.05.19.09.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 09:19:59 -0700 (PDT)
Date:   Tue, 19 May 2020 09:19:56 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sjpark@amazon.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH] mm: use only pidfd for process_madvise syscall
Message-ID: <20200519161956.GA66748@google.com>
References: <20200516012055.126205-1-minchan@kernel.org>
 <20200519074518.dur6qvfaq5pujtmg@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519074518.dur6qvfaq5pujtmg@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Christian,

On Tue, May 19, 2020 at 09:45:18AM +0200, Christian Brauner wrote:
> On Fri, May 15, 2020 at 06:20:55PM -0700, Minchan Kim wrote:
> > Based on discussion[1], people didn't feel we need to support both
> > pid and pidfd for every new coming API[2] so this patch keeps only
> > pidfd. This patch also changes flags's type with "unsigned int".
> > So finally, the API is as follows,
> > 
> >       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
> >       		unsigned long vlen, int advice, unsigned int flags);
> > 
> >     DESCRIPTION
> >       The process_madvise() system call is used to give advice or directions
> >       to the kernel about the address ranges from external process as well as
> >       local process. It provides the advice to address ranges of process
> >       described by iovec and vlen. The goal of such advice is to improve system
> >       or application performance.
> > 
> >       The pidfd selects the process referred to by the PID file descriptor
> >       specified in pidfd. (See pidofd_open(2) for further information)
> > 
> >       The pointer iovec points to an array of iovec structures, defined in
> >       <sys/uio.h> as:
> > 
> >         struct iovec {
> >             void *iov_base;         /* starting address */
> >             size_t iov_len;         /* number of bytes to be advised */
> >         };
> > 
> >       The iovec describes address ranges beginning at address(iov_base)
> >       and with size length of bytes(iov_len).
> > 
> >       The vlen represents the number of elements in iovec.
> > 
> >       The advice is indicated in the advice argument, which is one of the
> >       following at this moment if the target process specified by idtype and
> >       id is external.
> > 
> >         MADV_COLD
> >         MADV_PAGEOUT
> >         MADV_MERGEABLE
> >         MADV_UNMERGEABLE
> > 
> >       Permission to provide a hint to external process is governed by a
> >       ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).
> > 
> >       The process_madvise supports every advice madvise(2) has if target
> >       process is in same thread group with calling process so user could
> >       use process_madvise(2) to extend existing madvise(2) to support
> >       vector address ranges.
> > 
> >     RETURN VALUE
> >       On success, process_madvise() returns the number of bytes advised.
> >       This return value may be less than the total number of requested
> >       bytes, if an error occurred. The caller should check return value
> >       to determine whether a partial advice occurred.
> > 
> > [1] https://lore.kernel.org/linux-mm/20200509124817.xmrvsrq3mla6b76k@wittgenstein/
> > [2] https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> Thanks for the ping Minchan, and sorry for not replying earlier to this.
> 
> Also, sorry that i delayed the patch but this here really seems a way
> cleaner api to me and feels less hackish. In general this patch seems
> fine to me.

Thanks.

> But two comments below:
> 
> > ---
> >  mm/madvise.c | 42 +++++++++++++-----------------------------
> >  1 file changed, 13 insertions(+), 29 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index d3fbbe52d230..35c9b220146a 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1229,8 +1229,8 @@ static int process_madvise_vec(struct task_struct *target_task,
> >  	return ret;
> >  }
> >  
> > -static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
> > -				       int behavior, unsigned long flags)
> > +static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> > +				int behavior, unsigned int flags)
> >  {
> >  	ssize_t ret;
> >  	struct pid *pid;
> > @@ -1241,26 +1241,12 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
> >  	if (flags != 0)
> >  		return -EINVAL;
> >  
> > -	switch (which) {
> > -	case P_PID:
> > -		if (upid <= 0)
> > -			return -EINVAL;
> > -
> > -		pid = find_get_pid(upid);
> > -		if (!pid)
> > -			return -ESRCH;
> > -		break;
> > -	case P_PIDFD:
> > -		if (upid < 0)
> > -			return -EINVAL;
> > -
> > -		pid = pidfd_get_pid(upid);
> > -		if (IS_ERR(pid))
> > -			return PTR_ERR(pid);
> > -		break;
> > -	default:
> > +	if (pidfd < 0)
> >  		return -EINVAL;
> 
> When garbage file descriptors are passed EBADF needs to be returned, not
> EINVAL. That's the case with most apis and also with pidfds, compare:

True. Let me cook a patch for that.

> 
> int main(void)
> {
> 
> 	if (syscall(__NR_openat, -1, "tmp", O_RDONLY) < 0)
> 		printf("%m - openat(-1)\n");
> 
> 	if (syscall(__NR_fcntl, -1, F_GETFL) < 0)
> 		printf("%m - fcntl(-1)\n");
> 
> 	if (syscall(__NR_dup, -1) < 0)
> 		printf("%m - dup(-1)\n");
> 
> 	if (syscall(__NR_close, -1) < 0)
> 		printf("%m - close(-1)\n");
> 
> 	if (syscall(__NR_pidfd_getfd, -1, 0) < 0)
> 		printf("%m - pidfd_getfd(-1)\n");
> 
> 	if (syscall(__NR_pidfd_send_signal, -1, 0, NULL, 0) < 0)
> 		printf("%m - pidfd_getfd(-1)\n");
> 
> 	exit(EXIT_SUCCESS);
> }
> 
> which all give:
> 
> Bad file descriptor - openat(-1)
> Bad file descriptor - fcntl(-1)
> Bad file descriptor - dup(-1)
> Bad file descriptor - close(-1)
> Bad file descriptor - pidfd_getfd(-1)
> Bad file descriptor - pidfd_send_signal(-1)
> 
> In addition, I have one more request/proposal. I really think that
> consistent api naming is something we should consider so I'd propose:
> 
> From eef84697f1f19be4de1416d7d86975c319620569 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Tue, 19 May 2020 08:26:07 +0200
> Subject: [PATCH] mm: retain consistent pidfd syscall naming
> 
> I think there's value in consistent api naming. So far we have
> pidfd_open(), pidfd_send_signal(), pidfd_getfd(), likely there's going
> to be a pidfd_addfd() in the near future. process_madvise() would
> currently be the only syscall not fitting in that set. It probably
> doesn't matter much whether we call it process_madvise() or
> pidfd_madvise() and as long as noone has serious problems with renaming
> this I'd vote to keep naming consistent. This is also way nicer for
> userspace.

I agree if the syscall aimed for creating the particular fd(e.g., pidfd_open,
pidfd_getfd, timefd_create, memfd_create, eventfd, signalfd).
However, this process_madvise is not the case. Since fd is general concept
to cover various type's resources's handle, API naming doesn't follow the
particular type since they are created/opened in general.
I think it's more consistent with other APIs in the Linux since we follow
general concept.

> 
> I tested this patch on the akpm branch:
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm
> 
> It can be applied directly on top of Minchan's patch:
> 
> https://lore.kernel.org/lkml/20200516012055.126205-1-minchan@kernel.org
> 
> Here's also the adapted commit message:
> 
> 	Based on discussion[1], people didn't feel we need to support both
> 	pid and pidfd for every new coming API[2] so this patch keeps only
> 	pidfd. This patch also changes flags's type with "unsigned int".
> 	So finally, the API is as follows,
> 
> 	      ssize_t pidfd_madvise(int pidfd, const struct iovec *iovec,
> 	      		unsigned long vlen, int advice, unsigned int flags);
> 
> 	    DESCRIPTION
> 	      The pidfd_madvise() system call is used to give advice or directions
> 	      to the kernel about the address ranges from external process as well as
> 	      local process. It provides the advice to address ranges of process
> 	      described by iovec and vlen. The goal of such advice is to improve system
> 	      or application performance.
> 
> 	      The pidfd selects the process referred to by the PID file descriptor
> 	      specified in pidfd. (See pidofd_open(2) for further information)
> 
> 	      The pointer iovec points to an array of iovec structures, defined in
> 	      <sys/uio.h> as:
> 
> 	        struct iovec {
> 	            void *iov_base;         /* starting address */
> 	            size_t iov_len;         /* number of bytes to be advised */
> 	        };
> 
> 	      The iovec describes address ranges beginning at address(iov_base)
> 	      and with size length of bytes(iov_len).
> 
> 	      The vlen represents the number of elements in iovec.
> 
> 	      The advice is indicated in the advice argument, which is one of the
> 	      following at this moment if the target process specified by idtype and
> 	      id is external.
> 
> 	        MADV_COLD
> 	        MADV_PAGEOUT
> 	        MADV_MERGEABLE
> 	        MADV_UNMERGEABLE
> 
> 	      Permission to provide a hint to external process is governed by a
> 	      ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).
> 
> 	      The pidfd_madvise supports every advice madvise(2) has if target
> 	      process is in same thread group with calling process so user could
> 	      use pidfd_madvise(2) to extend existing madvise(2) to support
> 	      vector address ranges.
> 
> 	    RETURN VALUE
> 	      On success, pidfd_madvise() returns the number of bytes advised.
> 	      This return value may be less than the total number of requested
> 	      bytes, if an error occurred. The caller should check return value
> 	      to determine whether a partial advice occurred.
> 
> 	[1] https://lore.kernel.org/linux-mm/20200509124817.xmrvsrq3mla6b76k@wittgenstein/
> 	[2] https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> 	Signed-off-by: Minchan Kim <minchan@kernel.org>
> 	Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      |  2 +-
>  arch/arm/tools/syscall.tbl                  |  2 +-
>  arch/arm64/include/asm/unistd32.h           |  4 ++--
>  arch/ia64/kernel/syscalls/syscall.tbl       |  2 +-
>  arch/m68k/kernel/syscalls/syscall.tbl       |  2 +-
>  arch/microblaze/kernel/syscalls/syscall.tbl |  2 +-
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +-
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +-
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +-
>  arch/parisc/kernel/syscalls/syscall.tbl     |  2 +-
>  arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +-
>  arch/s390/kernel/syscalls/syscall.tbl       |  2 +-
>  arch/sh/kernel/syscalls/syscall.tbl         |  2 +-
>  arch/sparc/kernel/syscalls/syscall.tbl      |  2 +-
>  arch/x86/entry/syscalls/syscall_32.tbl      |  2 +-
>  arch/x86/entry/syscalls/syscall_64.tbl      |  4 ++--
>  arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +-
>  include/linux/compat.h                      |  2 +-
>  include/linux/syscalls.h                    |  2 +-
>  include/uapi/asm-generic/unistd.h           |  6 +++---
>  kernel/sys_ni.c                             |  4 ++--
>  mm/madvise.c                                | 18 +++++++++---------
>  22 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index b249824c8267..2e125f20e182 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -481,4 +481,4 @@
>  550	common	watch_mount			sys_watch_mount
>  551	common	watch_sb			sys_watch_sb
>  552	common	fsinfo				sys_fsinfo
> -553	common	process_madvise			sys_process_madvise
> +553	common	pidfd_madvise			sys_pidfd_madvise
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 7b3832d920ee..e65949d0019a 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -455,4 +455,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index f8dafe900cb9..0f18d84f5ec0 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -891,8 +891,8 @@ __SYSCALL(__NR_watch_mount, sys_watch_mount)
>  __SYSCALL(__NR_watch_sb, sys_watch_sb)
>  #define __NR_fsinfo 442
>  __SYSCALL(__NR_fsinfo, sys_fsinfo)
> -#define __NR_process_madvise 443
> -__SYSCALL(__NR_process_madvise, compat_sys_process_madvise)
> +#define __NR_pidfd_madvise 443
> +__SYSCALL(__NR_pidfd_madvise, compat_sys_pidfd_madvise)
>  
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 6636a1aef36b..494b8af8207d 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -362,4 +362,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 8cd84a7fbf57..e7397ab813d3 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -441,4 +441,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index f581a02257ec..f70a0abcbe99 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -447,4 +447,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index c85bdc3abe55..b6a992f2a255 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -380,4 +380,4 @@
>  440	n32	watch_mount			sys_watch_mount
>  441	n32	watch_sb			sys_watch_sb
>  442	n32	fsinfo				sys_fsinfo
> -443	n32	process_madvise			compat_sys_process_madvise
> +443	n32	pidfd_madvise			compat_sys_pidfd_madvise
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 9e08c40d3cb9..8638beaf724d 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -356,4 +356,4 @@
>  440	n64	watch_mount			sys_watch_mount
>  441	n64	watch_sb			sys_watch_sb
>  442	n64	fsinfo				sys_fsinfo
> -443	n64	process_madvise			sys_process_madvise
> +443	n64	pidfd_madvise			sys_pidfd_madvise
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index a2b591d7c874..7228e9c91263 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -429,4 +429,4 @@
>  440	o32	watch_mount			sys_watch_mount
>  441	o32	watch_sb			sys_watch_sb
>  442	o32	fsinfo				sys_fsinfo
> -443	o32	process_madvise			sys_process_madvise		compat_sys_process_madvise
> +443	o32	pidfd_madvise			sys_pidfd_madvise		compat_sys_pidfd_madvise
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 98e7442e4d7a..14991103f5e2 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -439,4 +439,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise		compat_sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise		compat_sys_pidfd_madvise
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 72fb9dd88e16..a4a286c222aa 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -531,4 +531,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise		compat_sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise		compat_sys_pidfd_madvise
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index b731fcb03f1b..ec11df661285 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -444,4 +444,4 @@
>  440	common	watch_mount		sys_watch_mount			sys_watch_mount
>  441	common	watch_sb		sys_watch_sb			sys_watch_sb
>  442  common	fsinfo			sys_fsinfo			sys_fsinfo
> -443  common	process_madvise		sys_process_madvise		compat_sys_process_madvise
> +443  common	pidfd_madvise		sys_pidfd_madvise		compat_sys_pidfd_madvise
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index e7a4804e23cf..62c4926e3150 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -444,4 +444,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index d6126ee2f51d..50ccfc41d3a0 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -487,4 +487,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise		compat_sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise		compat_sys_pidfd_madvise
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 686d59df1e12..6b16b95c58a0 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -446,4 +446,4 @@
>  440	i386	watch_mount		sys_watch_mount
>  441	i386	watch_sb		sys_watch_sb
>  442	i386	fsinfo			sys_fsinfo
> -443	i386	process_madvise		sys_process_madvise		compat_sys_process_madvise
> +443	i386	pidfd_madvise		sys_pidfd_madvise		compat_sys_pidfd_madvise
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index b345b35b3308..3662a0f4b682 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -363,7 +363,7 @@
>  440	common	watch_mount		sys_watch_mount
>  441	common	watch_sb		sys_watch_sb
>  442	common	fsinfo			sys_fsinfo
> -443	64	process_madvise		sys_process_madvise
> +443	64	pidfd_madvise		sys_pidfd_madvise
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> @@ -407,4 +407,4 @@
>  545	x32	execveat		compat_sys_execveat
>  546	x32	preadv2			compat_sys_preadv64v2
>  547	x32	pwritev2		compat_sys_pwritev64v2
> -548	x32	process_madvise		compat_sys_process_madvise
> +548	x32	pidfd_madvise		compat_sys_pidfd_madvise
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 96cb07095e4c..a2510c81ab35 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -412,4 +412,4 @@
>  440	common	watch_mount			sys_watch_mount
>  441	common	watch_sb			sys_watch_sb
>  442	common	fsinfo				sys_fsinfo
> -443	common	process_madvise			sys_process_madvise
> +443	common	pidfd_madvise			sys_pidfd_madvise
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 2e2f0a2700ab..f9eca29244f5 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -827,7 +827,7 @@ asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
>  		unsigned long vlen, loff_t pos, rwf_t flags);
>  #endif
>  
> -asmlinkage ssize_t compat_sys_process_madvise(compat_int_t which,
> +asmlinkage ssize_t compat_sys_pidfd_madvise(compat_int_t which,
>  		compat_pid_t upid, const struct compat_iovec __user *vec,
>  		compat_ulong_t vlen, compat_int_t behavior,
>  		compat_ulong_t flags);
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 2cbd3660e8e6..5c4949606502 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -879,7 +879,7 @@ asmlinkage long sys_munlockall(void);
>  asmlinkage long sys_mincore(unsigned long start, size_t len,
>  				unsigned char __user * vec);
>  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> -asmlinkage long sys_process_madvise(int which, pid_t upid,
> +asmlinkage long sys_pidfd_madvise(int which, pid_t upid,
>  		const struct iovec __user *vec, unsigned long vlen,
>  		int behavior, unsigned long flags);
>  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 6a5856c9d9b4..40dd1b66858e 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -863,9 +863,9 @@ __SYSCALL(__NR_watch_mount, sys_watch_mount)
>  __SYSCALL(__NR_watch_sb, sys_watch_sb)
>  #define __NR_fsinfo 442
>  __SYSCALL(__NR_fsinfo, sys_fsinfo)
> -#define __NR_process_madvise 443
> -__SC_COMP(__NR_process_madvise, sys_process_madvise, \
> -		compat_sys_process_madvise)
> +#define __NR_pidfd_madvise 443
> +__SC_COMP(__NR_pidfd_madvise, sys_pidfd_madvise, \
> +		compat_sys_pidfd_madvise)
>  
>  #undef __NR_syscalls
>  #define __NR_syscalls 444
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index fad48ace1123..6b7cc69617f8 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -287,8 +287,8 @@ COND_SYSCALL(mlockall);
>  COND_SYSCALL(munlockall);
>  COND_SYSCALL(mincore);
>  COND_SYSCALL(madvise);
> -COND_SYSCALL(process_madvise);
> -COND_SYSCALL_COMPAT(process_madvise);
> +COND_SYSCALL(pidfd_madvise);
> +COND_SYSCALL_COMPAT(pidfd_madvise);
>  COND_SYSCALL(remap_file_pages);
>  COND_SYSCALL(mbind);
>  COND_SYSCALL_COMPAT(mbind);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 35c9b220146a..d8b9e9c54275 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1008,7 +1008,7 @@ madvise_behavior_valid(int behavior)
>  }
>  
>  static bool
> -process_madvise_behavior_valid(int behavior)
> +pidfd_madvise_behavior_valid(int behavior)
>  {
>  	switch (behavior) {
>  	case MADV_COLD:
> @@ -1211,7 +1211,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  	return do_madvise(current, current->mm, start, len_in, behavior);
>  }
>  
> -static int process_madvise_vec(struct task_struct *target_task,
> +static int pidfd_madvise_vec(struct task_struct *target_task,
>  		struct mm_struct *mm, struct iov_iter *iter, int behavior)
>  {
>  	struct iovec iovec;
> @@ -1229,7 +1229,7 @@ static int process_madvise_vec(struct task_struct *target_task,
>  	return ret;
>  }
>  
> -static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> +static ssize_t do_pidfd_madvise(int pidfd, struct iov_iter *iter,
>  				int behavior, unsigned int flags)
>  {
>  	ssize_t ret;
> @@ -1255,7 +1255,7 @@ static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
>  	}
>  
>  	if (task->mm != current->mm &&
> -			!process_madvise_behavior_valid(behavior)) {
> +			!pidfd_madvise_behavior_valid(behavior)) {
>  		ret = -EINVAL;
>  		goto release_task;
>  	}
> @@ -1266,7 +1266,7 @@ static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
>  		goto release_task;
>  	}
>  
> -	ret = process_madvise_vec(task, mm, iter, behavior);
> +	ret = pidfd_madvise_vec(task, mm, iter, behavior);
>  	if (ret >= 0)
>  		ret = total_len - iov_iter_count(iter);
>  
> @@ -1278,7 +1278,7 @@ static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
>  	return ret;
>  }
>  
> -SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> +SYSCALL_DEFINE5(pidfd_madvise, int, pidfd, const struct iovec __user *, vec,
>  		unsigned long, vlen, int, behavior, unsigned int, flags)
>  {
>  	ssize_t ret;
> @@ -1288,14 +1288,14 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>  
>  	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
>  	if (ret >= 0) {
> -		ret = do_process_madvise(pidfd, &iter, behavior, flags);
> +		ret = do_pidfd_madvise(pidfd, &iter, behavior, flags);
>  		kfree(iov);
>  	}
>  	return ret;
>  }
>  
>  #ifdef CONFIG_COMPAT
> -COMPAT_SYSCALL_DEFINE5(process_madvise, compat_int_t, pidfd,
> +COMPAT_SYSCALL_DEFINE5(pidfd_madvise, compat_int_t, pidfd,
>  			const struct compat_iovec __user *, vec,
>  			compat_ulong_t, vlen,
>  			compat_int_t, behavior,
> @@ -1310,7 +1310,7 @@ COMPAT_SYSCALL_DEFINE5(process_madvise, compat_int_t, pidfd,
>  	ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
>  				&iov, &iter);
>  	if (ret >= 0) {
> -		ret = do_process_madvise(pidfd, &iter, behavior, flags);
> +		ret = do_pidfd_madvise(pidfd, &iter, behavior, flags);
>  		kfree(iov);
>  	}
>  	return ret;
> -- 
> 2.26.2
> 
