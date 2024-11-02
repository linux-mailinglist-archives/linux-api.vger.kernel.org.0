Return-Path: <linux-api+bounces-2659-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2C9B9D55
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 06:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88092858FB
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 05:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0614C5B0;
	Sat,  2 Nov 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYluvUtl"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081AF1DA53;
	Sat,  2 Nov 2024 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730526323; cv=none; b=FabXr17csxXQBpXiw5IkW5jPGcz7qgErXwUoS9DkGq24ViNLcAspVDYMp1N55djp+tbBQjUVjdLS+JaOjhh7WV1WwUG+/8Ot5R90q6FB9cUCwT8skCEvzPiGVIvhZvGMcUQqldLAvWk4Vet5XF6KOnttzDvomz9y7o/hfkrArqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730526323; c=relaxed/simple;
	bh=Ls2p5MjjLGBzTpn1/Ud5jGrxhf0JN7b2ShghMKOQdNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8cM0XhEVfaRR4Q3uVSZECstRxHpbK9Sf0VOs94Yly4zVZFVUNcoFy0/7SNRJ7wl0eYLl2wyGFi1Q2/AcavpAumBbJJ8n4fJFsocmLOKFK2WdzWjtAao222gzH5b3Frg9CdtWQAZ5JbirgLHdJg3HuMZo0t1vrxt5IyMOPIui6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYluvUtl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730526321; x=1762062321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ls2p5MjjLGBzTpn1/Ud5jGrxhf0JN7b2ShghMKOQdNA=;
  b=LYluvUtlm9enr+5H7tPb3tSbLgiZ6GZ8naCRbUvYbAcqsj+GqIuvUq0q
   mk6V+aFEL4dOS654G6jpYJABq35mHYkASO33Six9aI7XxV/dwkGnry7I2
   4+y4iVdZe30K0HASw2YhBchNsK6IS+eFBVJ1sIkZQR2g3uJ6A/rJj4Ibq
   soZzetSCiWizJ1idQ1AP1tT1OUktwQ/Rcchgl9Wyo7AheUOPnNoluGHVy
   h9z+bzxMvHE82K/q/S3SZwpKK8jvfTWIu2XFGNK6YF+hG6RkFpkroA01q
   ujkKP/REvGfWInVgAzGDQ3Khaul9jglb7xCHNed73Q0rPh9Zm1O2vc1/H
   Q==;
X-CSE-ConnectionGUID: tMzr2IMJROC831ycl96z+Q==
X-CSE-MsgGUID: Prvj3mnOTqOa/h8un66XzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30060539"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30060539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 22:45:20 -0700
X-CSE-ConnectionGUID: aMp/4X35QhWBarT+ItFz2g==
X-CSE-MsgGUID: o+NnwwpZQNWSY3c7XErHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="106496615"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Nov 2024 22:45:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t76wl-000iT9-01;
	Sat, 02 Nov 2024 05:45:15 +0000
Date: Sat, 2 Nov 2024 13:44:42 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v2 1/3] futex: Use explicit sizes for
 compat_exit_robust_list
Message-ID: <202411021349.tqg42lGq-lkp@intel.com>
References: <20241101162147.284993-2-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101162147.284993-2-andrealmeid@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/sched/core linus/master tip/x86/asm v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_exit_robust_list/20241102-002419
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20241101162147.284993-2-andrealmeid%40igalia.com
patch subject: [PATCH v2 1/3] futex: Use explicit sizes for compat_exit_robust_list
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20241102/202411021349.tqg42lGq-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411021349.tqg42lGq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411021349.tqg42lGq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/compat.h:8,
                    from include/net/scm.h:13,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:44,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:102,
                    from include/net/ipv6.h:12,
                    from include/linux/sunrpc/clnt.h:29,
                    from include/linux/nfs_fs.h:32,
                    from init/do_mounts.c:23:
>> include/linux/compat.h:665:35: warning: 'struct robust_list_head32' declared inside parameter list will not be visible outside of this definition or declaration
     665 | compat_sys_set_robust_list(struct robust_list_head32 __user *head,
         |                                   ^~~~~~~~~~~~~~~~~~
--
   In file included from include/net/compat.h:8,
                    from include/net/scm.h:13,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:44,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:102,
                    from include/net/addrconf.h:65,
                    from lib/vsprintf.c:41:
>> include/linux/compat.h:665:35: warning: 'struct robust_list_head32' declared inside parameter list will not be visible outside of this definition or declaration
     665 | compat_sys_set_robust_list(struct robust_list_head32 __user *head,
         |                                   ^~~~~~~~~~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from kernel/time/hrtimer.c:44:
>> include/linux/compat.h:665:35: warning: 'struct robust_list_head32' declared inside parameter list will not be visible outside of this definition or declaration
     665 | compat_sys_set_robust_list(struct robust_list_head32 __user *head,
         |                                   ^~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:124:35: warning: initialized field overwritten [-Woverride-init]
     124 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:124:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
--
   In file included from kernel/futex/core.c:34:
>> include/linux/compat.h:665:35: warning: 'struct robust_list_head32' declared inside parameter list will not be visible outside of this definition or declaration
     665 | compat_sys_set_robust_list(struct robust_list_head32 __user *head,
         |                                   ^~~~~~~~~~~~~~~~~~
   kernel/futex/core.c: In function 'exit_robust_list32':
   kernel/futex/core.c:902:54: error: 'struct task_struct' has no member named 'compat_robust_list'
     902 |         struct robust_list_head32 __user *head = curr->compat_robust_list;
         |                                                      ^~
   kernel/futex/core.c: At top level:
   kernel/futex/core.c:900:13: warning: 'exit_robust_list32' defined but not used [-Wunused-function]
     900 | static void exit_robust_list32(struct task_struct *curr)
         |             ^~~~~~~~~~~~~~~~~~


vim +665 include/linux/compat.h

   621	
   622	#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64
   623	asmlinkage long compat_sys_pwritev64(unsigned long fd,
   624			const struct iovec __user *vec,
   625			unsigned long vlen, loff_t pos);
   626	#endif
   627	asmlinkage long compat_sys_sendfile(int out_fd, int in_fd,
   628					    compat_off_t __user *offset, compat_size_t count);
   629	asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
   630					    compat_loff_t __user *offset, compat_size_t count);
   631	asmlinkage long compat_sys_pselect6_time32(int n, compat_ulong_t __user *inp,
   632					    compat_ulong_t __user *outp,
   633					    compat_ulong_t __user *exp,
   634					    struct old_timespec32 __user *tsp,
   635					    void __user *sig);
   636	asmlinkage long compat_sys_pselect6_time64(int n, compat_ulong_t __user *inp,
   637					    compat_ulong_t __user *outp,
   638					    compat_ulong_t __user *exp,
   639					    struct __kernel_timespec __user *tsp,
   640					    void __user *sig);
   641	asmlinkage long compat_sys_ppoll_time32(struct pollfd __user *ufds,
   642					 unsigned int nfds,
   643					 struct old_timespec32 __user *tsp,
   644					 const compat_sigset_t __user *sigmask,
   645					 compat_size_t sigsetsize);
   646	asmlinkage long compat_sys_ppoll_time64(struct pollfd __user *ufds,
   647					 unsigned int nfds,
   648					 struct __kernel_timespec __user *tsp,
   649					 const compat_sigset_t __user *sigmask,
   650					 compat_size_t sigsetsize);
   651	asmlinkage long compat_sys_signalfd4(int ufd,
   652					     const compat_sigset_t __user *sigmask,
   653					     compat_size_t sigsetsize, int flags);
   654	asmlinkage long compat_sys_newfstatat(unsigned int dfd,
   655					      const char __user *filename,
   656					      struct compat_stat __user *statbuf,
   657					      int flag);
   658	asmlinkage long compat_sys_newfstat(unsigned int fd,
   659					    struct compat_stat __user *statbuf);
   660	/* No generic prototype for sync_file_range and sync_file_range2 */
   661	asmlinkage long compat_sys_waitid(int, compat_pid_t,
   662			struct compat_siginfo __user *, int,
   663			struct compat_rusage __user *);
   664	asmlinkage long
 > 665	compat_sys_set_robust_list(struct robust_list_head32 __user *head,
   666				   compat_size_t len);
   667	asmlinkage long
   668	compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
   669				   compat_size_t __user *len_ptr);
   670	asmlinkage long compat_sys_getitimer(int which,
   671					     struct old_itimerval32 __user *it);
   672	asmlinkage long compat_sys_setitimer(int which,
   673					     struct old_itimerval32 __user *in,
   674					     struct old_itimerval32 __user *out);
   675	asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
   676					      compat_ulong_t nr_segments,
   677					      struct compat_kexec_segment __user *,
   678					      compat_ulong_t flags);
   679	asmlinkage long compat_sys_timer_create(clockid_t which_clock,
   680				struct compat_sigevent __user *timer_event_spec,
   681				timer_t __user *created_timer_id);
   682	asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
   683					  compat_long_t addr, compat_long_t data);
   684	asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid,
   685					     unsigned int len,
   686					     compat_ulong_t __user *user_mask_ptr);
   687	asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid,
   688					     unsigned int len,
   689					     compat_ulong_t __user *user_mask_ptr);
   690	asmlinkage long compat_sys_sigaltstack(const compat_stack_t __user *uss_ptr,
   691					       compat_stack_t __user *uoss_ptr);
   692	asmlinkage long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset,
   693						 compat_size_t sigsetsize);
   694	#ifndef CONFIG_ODD_RT_SIGACTION
   695	asmlinkage long compat_sys_rt_sigaction(int,
   696					 const struct compat_sigaction __user *,
   697					 struct compat_sigaction __user *,
   698					 compat_size_t);
   699	#endif
   700	asmlinkage long compat_sys_rt_sigprocmask(int how, compat_sigset_t __user *set,
   701						  compat_sigset_t __user *oset,
   702						  compat_size_t sigsetsize);
   703	asmlinkage long compat_sys_rt_sigpending(compat_sigset_t __user *uset,
   704						 compat_size_t sigsetsize);
   705	asmlinkage long compat_sys_rt_sigtimedwait_time32(compat_sigset_t __user *uthese,
   706			struct compat_siginfo __user *uinfo,
   707			struct old_timespec32 __user *uts, compat_size_t sigsetsize);
   708	asmlinkage long compat_sys_rt_sigtimedwait_time64(compat_sigset_t __user *uthese,
   709			struct compat_siginfo __user *uinfo,
   710			struct __kernel_timespec __user *uts, compat_size_t sigsetsize);
   711	asmlinkage long compat_sys_rt_sigqueueinfo(compat_pid_t pid, int sig,
   712					struct compat_siginfo __user *uinfo);
   713	/* No generic prototype for rt_sigreturn */
   714	asmlinkage long compat_sys_times(struct compat_tms __user *tbuf);
   715	asmlinkage long compat_sys_getrlimit(unsigned int resource,
   716					     struct compat_rlimit __user *rlim);
   717	asmlinkage long compat_sys_setrlimit(unsigned int resource,
   718					     struct compat_rlimit __user *rlim);
   719	asmlinkage long compat_sys_getrusage(int who, struct compat_rusage __user *ru);
   720	asmlinkage long compat_sys_gettimeofday(struct old_timeval32 __user *tv,
   721			struct timezone __user *tz);
   722	asmlinkage long compat_sys_settimeofday(struct old_timeval32 __user *tv,
   723			struct timezone __user *tz);
   724	asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
   725	asmlinkage long compat_sys_mq_open(const char __user *u_name,
   726				int oflag, compat_mode_t mode,
   727				struct compat_mq_attr __user *u_attr);
   728	asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
   729				const struct compat_sigevent __user *u_notification);
   730	asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
   731				const struct compat_mq_attr __user *u_mqstat,
   732				struct compat_mq_attr __user *u_omqstat);
   733	asmlinkage long compat_sys_msgctl(int first, int second, void __user *uptr);
   734	asmlinkage long compat_sys_msgrcv(int msqid, compat_uptr_t msgp,
   735			compat_ssize_t msgsz, compat_long_t msgtyp, int msgflg);
   736	asmlinkage long compat_sys_msgsnd(int msqid, compat_uptr_t msgp,
   737			compat_ssize_t msgsz, int msgflg);
   738	asmlinkage long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
   739	asmlinkage long compat_sys_shmctl(int first, int second, void __user *uptr);
   740	asmlinkage long compat_sys_shmat(int shmid, compat_uptr_t shmaddr, int shmflg);
   741	asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, compat_size_t len,
   742				    unsigned flags, struct sockaddr __user *addr,
   743				    int __user *addrlen);
   744	asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr __user *msg,
   745					   unsigned flags);
   746	asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
   747					   unsigned int flags);
   748	/* No generic prototype for readahead */
   749	asmlinkage long compat_sys_keyctl(u32 option,
   750				      u32 arg2, u32 arg3, u32 arg4, u32 arg5);
   751	asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr_t __user *argv,
   752			     const compat_uptr_t __user *envp);
   753	/* No generic prototype for fadvise64_64 */
   754	/* CONFIG_MMU only */
   755	asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
   756						compat_pid_t pid, int sig,
   757						struct compat_siginfo __user *uinfo);
   758	asmlinkage long compat_sys_recvmmsg_time64(int fd, struct compat_mmsghdr __user *mmsg,
   759					    unsigned vlen, unsigned int flags,
   760					    struct __kernel_timespec __user *timeout);
   761	asmlinkage long compat_sys_recvmmsg_time32(int fd, struct compat_mmsghdr __user *mmsg,
   762					    unsigned vlen, unsigned int flags,
   763					    struct old_timespec32 __user *timeout);
   764	asmlinkage long compat_sys_wait4(compat_pid_t pid,
   765					 compat_uint_t __user *stat_addr, int options,
   766					 struct compat_rusage __user *ru);
   767	asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
   768						    int, const char __user *);
   769	asmlinkage long compat_sys_open_by_handle_at(int mountdirfd,
   770						     struct file_handle __user *handle,
   771						     int flags);
   772	asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
   773					    unsigned vlen, unsigned int flags);
   774	asmlinkage long compat_sys_execveat(int dfd, const char __user *filename,
   775			     const compat_uptr_t __user *argv,
   776			     const compat_uptr_t __user *envp, int flags);
   777	asmlinkage ssize_t compat_sys_preadv2(compat_ulong_t fd,
   778			const struct iovec __user *vec,
   779			compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
   780	asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
   781			const struct iovec __user *vec,
   782			compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
   783	#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
   784	asmlinkage long  compat_sys_preadv64v2(unsigned long fd,
   785			const struct iovec __user *vec,
   786			unsigned long vlen, loff_t pos, rwf_t flags);
   787	#endif
   788	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

