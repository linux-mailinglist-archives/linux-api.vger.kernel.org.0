Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9717139910
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 19:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMSji (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 13:39:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38367 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMSji (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 13:39:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so5108116pgm.5;
        Mon, 13 Jan 2020 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jU2Lz+Ei3E18tD+/L/F20AT9UpnltD+Wp2e62LnQZes=;
        b=LYB7s8QdHMfcCCbSPauPce2/BubXJD7yFw+aW2DFP0/wt7/0lfIo95abAGiA2iUq5N
         6OG73quWBNd4PZZJXyyF1RSeADzh7+aoKrqOtg8Y+KmeBbyBILZimDk6tk971ECajmfM
         iX1TFzuRVgzulwkQ/cUXq5z/VKZssz7r+RsMIIsY55JV/lKKERJBXCk+ow4nG4h1ncj3
         3I+jA4Pb+z8V6uNuVgibpbMAUBkfIdQd2yIGLyuUt1xmGm23jtgMiaG0yxRkva/nyswn
         7OeIg9vBkixGmkTJ3WY+6lQU7L04R7QgjuTCPioB8tGBDLBQau013tDr/WpTLIlCHJ/B
         mT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jU2Lz+Ei3E18tD+/L/F20AT9UpnltD+Wp2e62LnQZes=;
        b=B5Y9BlxrZSpSnI/oG5Q+jpj0ioil7QV+ThXBHOhlg47/wY3nqDx69rJyqIzWo5rQ+b
         RdIMZwuPYX+Cq8P78bgHSXlTZxj60P/TUsj5kZTowDID2urVgh3Q1YqUWFqW//HXgXqV
         LUpCkyY3cejrFr9jmloIHi+t8cudwjLtlUl5RiWQciH1j44FZcydoMOmvyY/I7S5YHK1
         sWuyFCGFiH+PoIXx9gkHIjnn0qQ9Og0qHzm9QnQtJti9r9iLezJHjFhqgvb2zrAkPK5X
         7pzcgG1zhFAsKVZGujlGhof/qdNrR5zYz6RS5FNauSRjhNr36lwQ6qShwuSTE7WKz70W
         yp/A==
X-Gm-Message-State: APjAAAXHsZufS/3HGHY46XP6pXOfc9jFnU8y4XwTPgBL+7wXaEYuPsA3
        5Bp2V0Vfc/X8cpxDl/R/eb0=
X-Google-Smtp-Source: APXvYqyBWiivAFbiWurNKhV3S6OLZGbJISXnHsuNeCHKK49dODQNK1KH6wdrLrqpRQnA9NXXlctvvA==
X-Received: by 2002:a63:b26:: with SMTP id 38mr21948045pgl.116.1578940777486;
        Mon, 13 Jan 2020 10:39:37 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id p28sm14428051pgb.93.2020.01.13.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:39:36 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:39:34 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
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
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
Message-ID: <20200113183934.GC110363@google.com>
References: <20200110213433.94739-1-minchan@kernel.org>
 <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 13, 2020 at 11:47:11AM +0300, Kirill Tkhai wrote:
> On 11.01.2020 00:34, Minchan Kim wrote:
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
> 438. And several places below has the same mistake.

Thanks. I fixed.

< snip >

> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 0c901de531e4..e15dfb4df7bf 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/falloc.h>
> >  #include <linux/fadvise.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/ksm.h>
> >  #include <linux/fs.h>
> >  #include <linux/file.h>
> > @@ -993,6 +994,18 @@ madvise_behavior_valid(int behavior)
> >  	}
> >  }
> >  
> > +static bool
> > +process_madvise_behavior_valid(int behavior)
> > +{
> > +	switch (behavior) {
> > +	case MADV_COLD:
> > +	case MADV_PAGEOUT:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >  /*
> >   * madvise_common - request behavior hint to address range of the target process
> >   *
> > @@ -1169,3 +1182,54 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> >  {
> >  	return madvise_common(current, current->mm, start, len_in, behavior);
> >  }
> > +
> > +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> > +		size_t, len_in, int, behavior, unsigned long, flags)
> 
> I don't like the interface. The fact we have pidfd does not mean,
> we have to use it for new syscalls always. A user may want to set
> madvise for specific pid from console and pass pid as argument.
> pidfd would be an overkill in this case.

I am curious what is our plan for pid and pidfd once we introduced pidfd.
Ccing pidfd maintainer.

Since pid has clear problems, pidfd was born so not sure we should keep
both options for new coming API.

Since this is hinting API, performance wouldn't be critical requirment.
Rather than, it aims for a certain target process so that keep the process
during the operation without concern of reusing pid, which is perfectly
matched with pidfd.

> We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
> allow this?

It's a syscall but not command which uses the syscall for implementation.

> 
> I suggent to extend first argument to work with both pid and pidfd.
> Look at what we have for waitid(idtype, id_t id, ...) for example:
> 
>        idtype == P_PID
>               Wait for the child whose process ID matches id.
> 
>        idtype == P_PIDFD (since Linux 5.4)
>               Wait for the child referred to by the PID file descriptor specified in id.  (See pidfd_open(2) for  further  information  on
>               PID file descriptors.)

IMO, it's okay to extend existing syscall to support new pidfd but I'm not
convinced why we should support both options for this memory hinting API
fron the beginning.

I'm not strong against of supporting both options but it would be much better
to have strong justification or guide whehter we should support both or only
pidfd so that upcoming APIs will follow the strategy.

> 
> We may use @flags argument for this.

> 
> > +{
> > +	int ret;
> > +	struct fd f;
> > +	struct pid *pid;
> > +	struct task_struct *task;
> > +	struct mm_struct *mm;
> > +
> > +	if (flags != 0)
> > +		return -EINVAL;
> > +
> > +	if (!process_madvise_behavior_valid(behavior))
> > +		return -EINVAL;
> > +
> > +	f = fdget(pidfd);
> > +	if (!f.file)
> > +		return -EBADF;
> > +
> > +	pid = pidfd_pid(f.file);
> > +	if (IS_ERR(pid)) {
> > +		ret = PTR_ERR(pid);
> > +		goto err;
> > +	}
> 
> From here:
> 
> > +	rcu_read_lock();
> > +	task = pid_task(pid, PIDTYPE_PID);
> > +	if (!task) {
> > +		rcu_read_unlock();
> > +		ret = -ESRCH;
> > +		goto err;
> > +	}
> > +
> > +	get_task_struct(task);
> > +	rcu_read_unlock();
> 
> to here your code is a copy of existing get_pid_task(). We should the primitive instead.

Fixed.

> 
> > +
> > +	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > +	if (IS_ERR_OR_NULL(mm)) {
> > +		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > +		goto release_task;
> > +	}
> > +
> > +	ret = madvise_common(task, mm, start, len_in, behavior);
> > +	mmput(mm);
> > +release_task:
> > +	put_task_struct(task);
> > +err:
> 
> Maybe s/err:/fdput:/ for uniformity with the above "release_task:"?

Fixed.

Thanks for the review.
