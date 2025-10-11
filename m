Return-Path: <linux-api+bounces-5098-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82D2BCF4F0
	for <lists+linux-api@lfdr.de>; Sat, 11 Oct 2025 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26FB19A0ABA
	for <lists+linux-api@lfdr.de>; Sat, 11 Oct 2025 12:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5426F287;
	Sat, 11 Oct 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlTouuYn"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A53FC2;
	Sat, 11 Oct 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184540; cv=none; b=b8PgCKke9kRhVwh0kE6/4+XeOjIFgnatZ/OorWp2Do1WzmajO6NdV23oF6F4Bz/Uqqhz+/gf53QWFu86mYgJjG5H2r2bzs0DcCiZB/bKnHuoRrCCImRhAoooK7ExXs4QbGNjntJKU/gVOFPUS6jFCrRAh9mg2Cc+eAA40hHlAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184540; c=relaxed/simple;
	bh=w3xGrX+1VRhr0RQ7XQ9cpiXJorK5YeJAkemidrbd/88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYamq352bl6B5CexgtDbTCs+qOigBChfwCbx9unTB9xsXmvEtFXKsA5arZspeu2wSpDw5+L0q7Jh/6qxcB02upQP4MDpdqizkjcC1IF/CwuGz+MtahR3jGsxlBNKQbtz6X7IV06GooKax1tOEmPnDPn4sA448k3kXGoX58HAGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlTouuYn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760184535; x=1791720535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3xGrX+1VRhr0RQ7XQ9cpiXJorK5YeJAkemidrbd/88=;
  b=mlTouuYnBiBzZeIKRa01Seg292YASQ/BfldqzDhEk/hCYyAFp1oq07HL
   OWOCCGLGwxHOwDBkyGWcDfydiHD2to1ONpqfPKz1s2guA87ydq1gxzUSU
   +7FyZMNdgVEXFYcRwPeKfu6fdiSe6dsZ25xVd+1HKSt5RIM1pQJ/fgnjB
   KeF5nk3e8QvSs/lFkzfEyjxWJ7h6rqtTPZgvCERNtdwrIUkCZUmw5mlAW
   bfr8wALEPzepq8ojwUt/BNKOYsHipj7OlMA+2bdiY7Pofz/4yEhU/iXIk
   DDi5Z3Vj4q/LP5/gfkqmUnKKNHobq3z+TInORfSlQJbCpFVzXRzlP+i9M
   A==;
X-CSE-ConnectionGUID: Qa2v9vZLRK2Ruwbo90GKRw==
X-CSE-MsgGUID: IzsnQJimT6GYs1JMs+TKgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="87847224"
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="87847224"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 05:08:54 -0700
X-CSE-ConnectionGUID: r+kwUlfHQ+akfi6i8DtZIQ==
X-CSE-MsgGUID: C+4Uk8xpTlySaGgoG7jdow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="180767626"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Oct 2025 05:08:50 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7YP1-0003kf-1O;
	Sat, 11 Oct 2025 12:08:47 +0000
Date: Sat, 11 Oct 2025 20:07:56 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, john.johansen@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com, takedakn@nttdata.co.jp,
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org,
	rdunlap@infradead.org, linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH v6 1/5] Wire up lsm_config_self_policy and
 lsm_config_system_policy syscalls
Message-ID: <202510111947.0ObJ6YUH-lkp@intel.com>
References: <20251010132610.12001-2-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010132610.12001-2-maxime.belair@canonical.com>

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9c32cda43eb78f78c73aee4aa344b777714e259b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-B-lair/Wire-up-lsm_config_self_policy-and-lsm_config_system_policy-syscalls/20251010-213606
base:   9c32cda43eb78f78c73aee4aa344b777714e259b
patch link:    https://lore.kernel.org/r/20251010132610.12001-2-maxime.belair%40canonical.com
patch subject: [PATCH v6 1/5] Wire up lsm_config_self_policy and lsm_config_system_policy syscalls
config: sh-randconfig-001-20251011 (https://download.01.org/0day-ci/archive/20251011/202510111947.0ObJ6YUH-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510111947.0ObJ6YUH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510111947.0ObJ6YUH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/umh.c:9:0:
>> include/linux/syscalls.h:994:45: error: expected ';', ',' or ')' before 'u32'
              u32 __user size, u32 common_flags u32 flags);
                                                ^~~
--
   In file included from kernel/fork.c:56:0:
>> include/linux/syscalls.h:994:45: error: expected ';', ',' or ')' before 'u32'
              u32 __user size, u32 common_flags u32 flags);
                                                ^~~
   kernel/fork.c: In function '__do_sys_clone3':
   kernel/fork.c:3135:2: warning: #warning clone3() entry point is missing, please fix [-Wcpp]
    #warning clone3() entry point is missing, please fix
     ^~~~~~~


vim +994 include/linux/syscalls.h

   817	
   818	/* CONFIG_MMU only */
   819	asmlinkage long sys_swapon(const char __user *specialfile, int swap_flags);
   820	asmlinkage long sys_swapoff(const char __user *specialfile);
   821	asmlinkage long sys_mprotect(unsigned long start, size_t len,
   822					unsigned long prot);
   823	asmlinkage long sys_msync(unsigned long start, size_t len, int flags);
   824	asmlinkage long sys_mlock(unsigned long start, size_t len);
   825	asmlinkage long sys_munlock(unsigned long start, size_t len);
   826	asmlinkage long sys_mlockall(int flags);
   827	asmlinkage long sys_munlockall(void);
   828	asmlinkage long sys_mincore(unsigned long start, size_t len,
   829					unsigned char __user * vec);
   830	asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
   831	asmlinkage long sys_process_madvise(int pidfd, const struct iovec __user *vec,
   832				size_t vlen, int behavior, unsigned int flags);
   833	asmlinkage long sys_process_mrelease(int pidfd, unsigned int flags);
   834	asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
   835				unsigned long prot, unsigned long pgoff,
   836				unsigned long flags);
   837	asmlinkage long sys_mseal(unsigned long start, size_t len, unsigned long flags);
   838	asmlinkage long sys_mbind(unsigned long start, unsigned long len,
   839					unsigned long mode,
   840					const unsigned long __user *nmask,
   841					unsigned long maxnode,
   842					unsigned flags);
   843	asmlinkage long sys_get_mempolicy(int __user *policy,
   844					unsigned long __user *nmask,
   845					unsigned long maxnode,
   846					unsigned long addr, unsigned long flags);
   847	asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
   848					unsigned long maxnode);
   849	asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
   850					const unsigned long __user *from,
   851					const unsigned long __user *to);
   852	asmlinkage long sys_move_pages(pid_t pid, unsigned long nr_pages,
   853					const void __user * __user *pages,
   854					const int __user *nodes,
   855					int __user *status,
   856					int flags);
   857	asmlinkage long sys_rt_tgsigqueueinfo(pid_t tgid, pid_t  pid, int sig,
   858			siginfo_t __user *uinfo);
   859	asmlinkage long sys_perf_event_open(
   860			struct perf_event_attr __user *attr_uptr,
   861			pid_t pid, int cpu, int group_fd, unsigned long flags);
   862	asmlinkage long sys_accept4(int, struct sockaddr __user *, int __user *, int);
   863	asmlinkage long sys_recvmmsg(int fd, struct mmsghdr __user *msg,
   864				     unsigned int vlen, unsigned flags,
   865				     struct __kernel_timespec __user *timeout);
   866	asmlinkage long sys_recvmmsg_time32(int fd, struct mmsghdr __user *msg,
   867				     unsigned int vlen, unsigned flags,
   868				     struct old_timespec32 __user *timeout);
   869	asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
   870					int options, struct rusage __user *ru);
   871	asmlinkage long sys_prlimit64(pid_t pid, unsigned int resource,
   872					const struct rlimit64 __user *new_rlim,
   873					struct rlimit64 __user *old_rlim);
   874	asmlinkage long sys_fanotify_init(unsigned int flags, unsigned int event_f_flags);
   875	#if defined(CONFIG_ARCH_SPLIT_ARG64)
   876	asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
   877	                                unsigned int mask_1, unsigned int mask_2,
   878					int dfd, const char  __user * pathname);
   879	#else
   880	asmlinkage long sys_fanotify_mark(int fanotify_fd, unsigned int flags,
   881					  u64 mask, int fd,
   882					  const char  __user *pathname);
   883	#endif
   884	asmlinkage long sys_name_to_handle_at(int dfd, const char __user *name,
   885					      struct file_handle __user *handle,
   886					      void __user *mnt_id, int flag);
   887	asmlinkage long sys_open_by_handle_at(int mountdirfd,
   888					      struct file_handle __user *handle,
   889					      int flags);
   890	asmlinkage long sys_clock_adjtime(clockid_t which_clock,
   891					struct __kernel_timex __user *tx);
   892	asmlinkage long sys_clock_adjtime32(clockid_t which_clock,
   893					struct old_timex32 __user *tx);
   894	asmlinkage long sys_syncfs(int fd);
   895	asmlinkage long sys_setns(int fd, int nstype);
   896	asmlinkage long sys_pidfd_open(pid_t pid, unsigned int flags);
   897	asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
   898				     unsigned int vlen, unsigned flags);
   899	asmlinkage long sys_process_vm_readv(pid_t pid,
   900					     const struct iovec __user *lvec,
   901					     unsigned long liovcnt,
   902					     const struct iovec __user *rvec,
   903					     unsigned long riovcnt,
   904					     unsigned long flags);
   905	asmlinkage long sys_process_vm_writev(pid_t pid,
   906					      const struct iovec __user *lvec,
   907					      unsigned long liovcnt,
   908					      const struct iovec __user *rvec,
   909					      unsigned long riovcnt,
   910					      unsigned long flags);
   911	asmlinkage long sys_kcmp(pid_t pid1, pid_t pid2, int type,
   912				 unsigned long idx1, unsigned long idx2);
   913	asmlinkage long sys_finit_module(int fd, const char __user *uargs, int flags);
   914	asmlinkage long sys_sched_setattr(pid_t pid,
   915						struct sched_attr __user *attr,
   916						unsigned int flags);
   917	asmlinkage long sys_sched_getattr(pid_t pid,
   918						struct sched_attr __user *attr,
   919						unsigned int size,
   920						unsigned int flags);
   921	asmlinkage long sys_renameat2(int olddfd, const char __user *oldname,
   922				      int newdfd, const char __user *newname,
   923				      unsigned int flags);
   924	asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
   925				    void __user *uargs);
   926	asmlinkage long sys_getrandom(char __user *buf, size_t count,
   927				      unsigned int flags);
   928	asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
   929	asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size);
   930	asmlinkage long sys_execveat(int dfd, const char __user *filename,
   931				const char __user *const __user *argv,
   932				const char __user *const __user *envp, int flags);
   933	asmlinkage long sys_userfaultfd(int flags);
   934	asmlinkage long sys_membarrier(int cmd, unsigned int flags, int cpu_id);
   935	asmlinkage long sys_mlock2(unsigned long start, size_t len, int flags);
   936	asmlinkage long sys_copy_file_range(int fd_in, loff_t __user *off_in,
   937					    int fd_out, loff_t __user *off_out,
   938					    size_t len, unsigned int flags);
   939	asmlinkage long sys_preadv2(unsigned long fd, const struct iovec __user *vec,
   940				    unsigned long vlen, unsigned long pos_l, unsigned long pos_h,
   941				    rwf_t flags);
   942	asmlinkage long sys_pwritev2(unsigned long fd, const struct iovec __user *vec,
   943				    unsigned long vlen, unsigned long pos_l, unsigned long pos_h,
   944				    rwf_t flags);
   945	asmlinkage long sys_pkey_mprotect(unsigned long start, size_t len,
   946					  unsigned long prot, int pkey);
   947	asmlinkage long sys_pkey_alloc(unsigned long flags, unsigned long init_val);
   948	asmlinkage long sys_pkey_free(int pkey);
   949	asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
   950				  unsigned mask, struct statx __user *buffer);
   951	asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
   952				 int flags, uint32_t sig);
   953	asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
   954	asmlinkage long sys_open_tree_attr(int dfd, const char __user *path,
   955					   unsigned flags,
   956					   struct mount_attr __user *uattr,
   957					   size_t usize);
   958	asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
   959				       int to_dfd, const char __user *to_path,
   960				       unsigned int ms_flags);
   961	asmlinkage long sys_mount_setattr(int dfd, const char __user *path,
   962					  unsigned int flags,
   963					  struct mount_attr __user *uattr, size_t usize);
   964	asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
   965	asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
   966				     const void __user *value, int aux);
   967	asmlinkage long sys_fsmount(int fs_fd, unsigned int flags, unsigned int ms_flags);
   968	asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags);
   969	asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
   970					       siginfo_t __user *info,
   971					       unsigned int flags);
   972	asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
   973	asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr __user *attr,
   974			size_t size, __u32 flags);
   975	asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
   976			const void __user *rule_attr, __u32 flags);
   977	asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
   978	asmlinkage long sys_memfd_secret(unsigned int flags);
   979	asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
   980						    unsigned long home_node,
   981						    unsigned long flags);
   982	asmlinkage long sys_cachestat(unsigned int fd,
   983			struct cachestat_range __user *cstat_range,
   984			struct cachestat __user *cstat, unsigned int flags);
   985	asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
   986	asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
   987					      u32 __user *size, u32 flags);
   988	asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
   989					      u32 size, u32 flags);
   990	asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
   991	asmlinkage long sys_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
   992						   u32 __user size, u32 common_flags, u32 flags);
   993	asmlinkage long sys_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
 > 994						     u32 __user size, u32 common_flags u32 flags);
   995	
   996	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

