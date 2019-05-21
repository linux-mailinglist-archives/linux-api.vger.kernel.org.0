Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE524609
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 04:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfEUClQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 22:41:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45761 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfEUClP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 May 2019 22:41:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id a5so7619595pls.12;
        Mon, 20 May 2019 19:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zlrU/Ybu5gZWpNEr8He7EVH/0de3GMQ9Nd5+F5aNWo0=;
        b=JX69JK0c0pkI2fZJN/mWr9cmScTLdxaMzBW3hGKgexYdAnjrljpRqC9e8xnaSZxUj0
         2GcHR1mFgt67uy5J4B2KsiKi4EORyl3pmt3dhkcYxJ8MtFiF2b/Ei63oMvUmEdG+D1Kh
         PAqBlefRXrdvJBs3aCApPC7FRJNibYO4nW2llgza2GJgfsuGQbzeneVEafbvXhw/zR/f
         IU8yhIqp5eB/+xAO81/HE62cIrJYGycTl4oQkhq4mE637OP6pANxTkRCp7BNL00LFPzh
         lWBLbcuwpC3PcL5dpxTRjPy+0BODVIfRxgcD43QGjA1f3fvDLj+8knGBfiBXgtCT2NMr
         Eb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zlrU/Ybu5gZWpNEr8He7EVH/0de3GMQ9Nd5+F5aNWo0=;
        b=POOafeWH1wflyOKN2ax3WqPFEfF4kPQCBSK8Z9Czt2SmvYHlfwcLy3frhVuXwZCMWB
         p4hZwOI5TqZkCOYni7Lg+NNkKDz3oseWfg3WitlFH4cAQfaWobYBUHYP1XTOpiBm/27S
         vDLNFkF9plskwkCNV4wegtW+HH1GyY/rIDsu0JlIwn+ywCMcmDApfeifSfzdVcC5x9g3
         zxem965t3P5h9mtzoO/WwtQVUDJRxkS92IWprph+VT+awe8Gj7cWYKwF7adNpKTTumKB
         9Ag7c/16xImOgcvxvUAAdZ1Qqfi1JYpCS/92YOTouQWt1ZeFDz064G14hZF/63Qf/j2h
         e0WA==
X-Gm-Message-State: APjAAAUnnsEJPa1RaSjl01Gc6yCuSRksZKelxcwv2/6NlDZamL6kRaf6
        KNtxhenIE27jRyIj6Apl69k=
X-Google-Smtp-Source: APXvYqxWyWkpdRVELAF23gHj7mxU//F+QDTqqyYfbed9IXrUZThIIeq0cK53bnljKqFg18jBJEvDaA==
X-Received: by 2002:a17:902:22:: with SMTP id 31mr79820454pla.15.1558406474442;
        Mon, 20 May 2019 19:41:14 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j10sm20384667pgk.37.2019.05.20.19.41.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 19:41:13 -0700 (PDT)
Date:   Tue, 21 May 2019 11:41:07 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 5/7] mm: introduce external memory hinting API
Message-ID: <20190521024107.GF10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-6-minchan@kernel.org>
 <20190520091829.GY6836@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520091829.GY6836@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 20, 2019 at 11:18:29AM +0200, Michal Hocko wrote:
> [Cc linux-api]
> 
> On Mon 20-05-19 12:52:52, Minchan Kim wrote:
> > There is some usecase that centralized userspace daemon want to give
> > a memory hint like MADV_[COOL|COLD] to other process. Android's
> > ActivityManagerService is one of them.
> > 
> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > required to make the reclaim decision is not known to the app. Instead,
> > it is known to the centralized userspace daemon(ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without
> > any app involvement.
> 
> Could you expand some more about how this all works? How does the
> centralized daemon track respective ranges? How does it synchronize
> against parallel modification of the address space etc.

Currently, we don't track each address ranges because we have two
policies at this moment:

	deactive file pages and reclaim anonymous pages of the app.

Since the daemon has a ability to let background apps resume(IOW, process
will be run by the daemon) and both hints are non-disruptive stabilty point
of view, we are okay for the race.

> 
> > To solve the issue, this patch introduces new syscall process_madvise(2)
> > which works based on pidfd so it could give a hint to the exeternal
> > process.
> > 
> > int process_madvise(int pidfd, void *addr, size_t length, int advise);
> 
> OK, this makes some sense from the API point of view. When we have
> discussed that at LSFMM I was contemplating about something like that
> except the fd would be a VMA fd rather than the process. We could extend
> and reuse /proc/<pid>/map_files interface which doesn't support the
> anonymous memory right now. 
> 
> I am not saying this would be a better interface but I wanted to mention
> it here for a further discussion. One slight advantage would be that
> you know the exact object that you are operating on because you have a
> fd for the VMA and we would have a more straightforward way to reject
> operation if the underlying object has changed (e.g. unmapped and reused
> for a different mapping).

I agree your point. If I didn't miss something, such kinds of vma level
modify notification doesn't work even file mapped vma at this moment.
For anonymous vma, I think we could use userfaultfd, pontentially.
It would be great if someone want to do with disruptive hints like
MADV_DONTNEED.

I'd like to see it further enhancement after landing address range based
operation via limiting hints process_madvise supports to non-disruptive
only(e.g., MADV_[COOL|COLD]) so that we could catch up the usercase/workload
when someone want to extend the API.

> 
> > All advises madvise provides can be supported in process_madvise, too.
> > Since it could affect other process's address range, only privileged
> > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > gives it the right to ptrrace the process could use it successfully.
> 
> proc_mem_open model we use for accessing address space via proc sounds
> like a good mode. You are doing something similar.
> 
> > Please suggest better idea if you have other idea about the permission.
> > 
> > * from v1r1
> >   * use ptrace capability - surenb, dancol
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
> >  include/linux/proc_fs.h                |  1 +
> >  include/linux/syscalls.h               |  2 ++
> >  include/uapi/asm-generic/unistd.h      |  2 ++
> >  kernel/signal.c                        |  2 +-
> >  kernel/sys_ni.c                        |  1 +
> >  mm/madvise.c                           | 45 ++++++++++++++++++++++++++
> >  8 files changed, 54 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> > index 4cd5f982b1e5..5b9dd55d6b57 100644
> > --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > @@ -438,3 +438,4 @@
> >  425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
> >  426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
> >  427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
> > +428	i386	process_madvise		sys_process_madvise		__ia32_sys_process_madvise
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 64ca0d06259a..0e5ee78161c9 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -355,6 +355,7 @@
> >  425	common	io_uring_setup		__x64_sys_io_uring_setup
> >  426	common	io_uring_enter		__x64_sys_io_uring_enter
> >  427	common	io_uring_register	__x64_sys_io_uring_register
> > +428	common	process_madvise		__x64_sys_process_madvise
> >  
> >  #
> >  # x32-specific system call numbers start at 512 to avoid cache impact
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index 52a283ba0465..f8545d7c5218 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -122,6 +122,7 @@ static inline struct pid *tgid_pidfd_to_pid(const struct file *file)
> >  
> >  #endif /* CONFIG_PROC_FS */
> >  
> > +extern struct pid *pidfd_to_pid(const struct file *file);
> >  struct net;
> >  
> >  static inline struct proc_dir_entry *proc_net_mkdir(
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index e2870fe1be5b..21c6c9a62006 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -872,6 +872,8 @@ asmlinkage long sys_munlockall(void);
> >  asmlinkage long sys_mincore(unsigned long start, size_t len,
> >  				unsigned char __user * vec);
> >  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> > +asmlinkage long sys_process_madvise(int pid_fd, unsigned long start,
> > +				size_t len, int behavior);
> >  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
> >  			unsigned long prot, unsigned long pgoff,
> >  			unsigned long flags);
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index dee7292e1df6..7ee82ce04620 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -832,6 +832,8 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
> >  __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
> >  #define __NR_io_uring_register 427
> >  __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> > +#define __NR_process_madvise 428
> > +__SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  
> >  #undef __NR_syscalls
> >  #define __NR_syscalls 428
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 1c86b78a7597..04e75daab1f8 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3620,7 +3620,7 @@ static int copy_siginfo_from_user_any(kernel_siginfo_t *kinfo, siginfo_t *info)
> >  	return copy_siginfo_from_user(kinfo, info);
> >  }
> >  
> > -static struct pid *pidfd_to_pid(const struct file *file)
> > +struct pid *pidfd_to_pid(const struct file *file)
> >  {
> >  	if (file->f_op == &pidfd_fops)
> >  		return file->private_data;
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index 4d9ae5ea6caf..5277421795ab 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -278,6 +278,7 @@ COND_SYSCALL(mlockall);
> >  COND_SYSCALL(munlockall);
> >  COND_SYSCALL(mincore);
> >  COND_SYSCALL(madvise);
> > +COND_SYSCALL(process_madvise);
> >  COND_SYSCALL(remap_file_pages);
> >  COND_SYSCALL(mbind);
> >  COND_SYSCALL_COMPAT(mbind);
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 119e82e1f065..af02aa17e5c1 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/mman.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/page_idle.h>
> > +#include <linux/proc_fs.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/mempolicy.h>
> >  #include <linux/page-isolation.h>
> > @@ -16,6 +17,7 @@
> >  #include <linux/hugetlb.h>
> >  #include <linux/falloc.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/ksm.h>
> >  #include <linux/fs.h>
> >  #include <linux/file.h>
> > @@ -1140,3 +1142,46 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> >  {
> >  	return madvise_core(current, start, len_in, behavior);
> >  }
> > +
> > +SYSCALL_DEFINE4(process_madvise, int, pidfd, unsigned long, start,
> > +		size_t, len_in, int, behavior)
> > +{
> > +	int ret;
> > +	struct fd f;
> > +	struct pid *pid;
> > +	struct task_struct *tsk;
> > +	struct mm_struct *mm;
> > +
> > +	f = fdget(pidfd);
> > +	if (!f.file)
> > +		return -EBADF;
> > +
> > +	pid = pidfd_to_pid(f.file);
> > +	if (IS_ERR(pid)) {
> > +		ret = PTR_ERR(pid);
> > +		goto err;
> > +	}
> > +
> > +	ret = -EINVAL;
> > +	rcu_read_lock();
> > +	tsk = pid_task(pid, PIDTYPE_PID);
> > +	if (!tsk) {
> > +		rcu_read_unlock();
> > +		goto err;
> > +	}
> > +	get_task_struct(tsk);
> > +	rcu_read_unlock();
> > +	mm = mm_access(tsk, PTRACE_MODE_ATTACH_REALCREDS);
> > +	if (!mm || IS_ERR(mm)) {
> > +		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > +		if (ret == -EACCES)
> > +			ret = -EPERM;
> > +		goto err;
> > +	}
> > +	ret = madvise_core(tsk, start, len_in, behavior);
> > +	mmput(mm);
> > +	put_task_struct(tsk);
> > +err:
> > +	fdput(f);
> > +	return ret;
> > +}
> > -- 
> > 2.21.0.1020.gf2820cf01a-goog
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
