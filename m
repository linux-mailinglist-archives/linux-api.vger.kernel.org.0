Return-Path: <linux-api+bounces-3952-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72474AE1944
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 12:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99355A5286
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABEC27FD49;
	Fri, 20 Jun 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvNMXVW7"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5572727FB;
	Fri, 20 Jun 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416910; cv=none; b=MecGy1K+DsBvrUBRbpPBDsFBS0zEC8w90kpSo12HgL1/nzFYbBBOARGjJplmWb/Y3A2G8qfr967yoTAzkBi/rMe79iFYK4zfbZPDCJDLeiucQZ0XSWbeoNOJQn6B/Y27/ugwpSB5qUvttMRPtYnZrInWtYCuGYjxTPkxGbzrX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416910; c=relaxed/simple;
	bh=6qewnNaYjg29mT4CegioglXERqv4wxOZUuKKA1ZNGr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzEqUuA/jF2bdmjfKX690oN5FQ7yjXtxraZs0xYf3qycKTV8aho7awj/jnQHaE4rY/gfTbRq1cKaz8yPY/0jbHx5aXFufrxmzIiba9BdLlUFso09odYdUENyyfr512swx7aNmPfu/HkTqFPpVbu+k6v03NdOD9YHGJnKuWhjNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvNMXVW7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750416907; x=1781952907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qewnNaYjg29mT4CegioglXERqv4wxOZUuKKA1ZNGr8=;
  b=PvNMXVW7TA6BMgrZCNTJLKq6I8zswci6fcD9LwjsbDXZg0Y8bGCFC4CS
   KKEz2tC/gCcBBzZWD4PWgwMizbk8Z/Sy86PxYQMhGBFCd4JrlT8t9JNxu
   smavQMWAmLmd7TUlRUFLc6jox/VRExP5h168OsmY+9tUmmVXNWxnH5A5Y
   Pf02hk6O5tQ9Hb4/f29zevAiE7JDouBaCNnvGPfjM0hyC0QKgIJDELpha
   wqtJzy2iXnA7nkJ6MuvWUhjG7ryoz4RNAj1bEV1420wnETqsW0JUuYlmQ
   pJMm0ZQXKxCDSopQi6Ab4Ewwg29kc5b8U1jtVnmCwOuXuTl9+OLobTrvX
   A==;
X-CSE-ConnectionGUID: 5rT5sI/CTTeIf4XAsOLTaQ==
X-CSE-MsgGUID: icgjkqEWRMi5FnOpvwGntg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52608066"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52608066"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 03:55:06 -0700
X-CSE-ConnectionGUID: M0bDr3UrQEqGhmfhBPE43w==
X-CSE-MsgGUID: /nERQCYNR4er4KEIzEGjsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151182308"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jun 2025 03:55:02 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSZOe-000LeA-1a;
	Fri, 20 Jun 2025 10:55:00 +0000
Date: Fri, 20 Jun 2025 18:54:58 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, john.johansen@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com, takedakn@nttdata.co.jp,
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org,
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH v2 2/3] lsm: introduce security_lsm_config_*_policy hooks
Message-ID: <202506201824.SlorGLXM-lkp@intel.com>
References: <20250619181600.478038-3-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619181600.478038-3-maxime.belair@canonical.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9c32cda43eb78f78c73aee4aa344b777714e259b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-B-lair/Wire-up-lsm_config_self_policy-and-lsm_config_system_policy-syscalls/20250620-022714
base:   9c32cda43eb78f78c73aee4aa344b777714e259b
patch link:    https://lore.kernel.org/r/20250619181600.478038-3-maxime.belair%40canonical.com
patch subject: [PATCH v2 2/3] lsm: introduce security_lsm_config_*_policy hooks
config: i386-buildonly-randconfig-006-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201824.SlorGLXM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506201824.SlorGLXM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506201824.SlorGLXM-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |             ^~~~~~~~~~~~~~~
   include/linux/trace_events.h:869:13: error: storage class specified for parameter 'perf_trace_destroy'
     869 | extern void perf_trace_destroy(struct perf_event *event);
         |             ^~~~~~~~~~~~~~~~~~
   include/linux/trace_events.h:870:13: error: storage class specified for parameter 'perf_trace_add'
     870 | extern int  perf_trace_add(struct perf_event *event, int flags);
         |             ^~~~~~~~~~~~~~
   include/linux/trace_events.h:871:13: error: storage class specified for parameter 'perf_trace_del'
     871 | extern void perf_trace_del(struct perf_event *event, int flags);
         |             ^~~~~~~~~~~~~~
   include/linux/trace_events.h:890:13: error: storage class specified for parameter 'ftrace_profile_set_filter'
     890 | extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/trace_events.h:892:13: error: storage class specified for parameter 'ftrace_profile_free_filter'
     892 | extern void ftrace_profile_free_filter(struct perf_event *event);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/trace_events.h:935:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     935 | {
         | ^
   include/trace/syscall.h:25:1: warning: empty declaration
      25 | struct syscall_metadata {
         | ^~~~~~
   include/trace/syscall.h:47:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      47 | {
         | ^
   In file included from include/linux/syscalls.h:104:
   arch/x86/include/asm/syscall_wrapper.h:11:13: error: storage class specified for parameter '__x64_sys_ni_syscall'
      11 | extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
         |             ^~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:12:13: error: storage class specified for parameter '__ia32_sys_ni_syscall'
      12 | extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
         |             ^~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:211:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     211 | {
         | ^
   In file included from include/linux/linkage.h:8,
                    from include/linux/preempt.h:10:
   arch/x86/include/asm/linkage.h:20:35: error: expected declaration specifiers before '__attribute__'
      20 | #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
         |                                   ^~~~~~~~~~~~~
   include/linux/syscalls.h:1220:1: note: in expansion of macro 'asmlinkage'
    1220 | asmlinkage long sys_ni_posix_timers(void);
         | ^~~~~~~~~~
   include/linux/syscalls.h:1262:12: error: storage class specified for parameter 'do_fchownat'
    1262 | extern int do_fchownat(int dfd, const char __user *filename, uid_t user,
         |            ^~~~~~~~~~~
   include/linux/syscalls.h:1267:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1267 | {
         | ^
   include/linux/syscalls.h:1273:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1273 | {
         | ^
   include/linux/syscalls.h:1281:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1281 | {
         | ^
   include/linux/syscalls.h:1288:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1288 | {
         | ^
   include/linux/syscalls.h:1293:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1293 | {
         | ^
   block/ioprio.c:34:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      34 | {
         | ^
   arch/x86/include/asm/syscall_wrapper.h:224:21: error: storage class specified for parameter '__se_sys_ioprio_set'
     224 |         static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));     \
         |                     ^~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:69:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      69 | SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:225:28: error: storage class specified for parameter '__do_sys_ioprio_set'
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:69:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      69 | SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:225:28: warning: parameter '__do_sys_ioprio_set' declared 'inline'
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:69:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      69 | SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
         | ^~~~~~~~~~~~~~~
>> block/ioprio.c:69:1: warning: 'gnu_inline' attribute ignored [-Wattributes]
   arch/x86/include/asm/syscall_wrapper.h:225:28: error: 'no_instrument_function' attribute applies only to functions
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:69:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      69 | SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:93:55: error: expected declaration specifiers before ';' token
      93 |         ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);                 \
         |                                                       ^
   arch/x86/include/asm/syscall_wrapper.h:128:9: note: in expansion of macro '__SYS_STUBx'
     128 |         __SYS_STUBx(ia32, sys##name,                                    \
         |         ^~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:227:9: note: in expansion of macro '__IA32_SYS_STUBx'
     227 |         __IA32_SYS_STUBx(x, name, __VA_ARGS__)                          \
         |         ^~~~~~~~~~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:69:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      69 | SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:95:9: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      95 |         {                                                               \
         |         ^
   arch/x86/include/asm/syscall_wrapper.h:128:9: note: in expansion of macro '__SYS_STUBx'
     128 |         __SYS_STUBx(ia32, sys##name,                                    \
         |         ^~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:227:9: note: in expansion of macro '__IA32_SYS_STUBx'
     227 |         __IA32_SYS_STUBx(x, name, __VA_ARGS__)                          \
         |         ^~~~~~~~~~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:69:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      69 | SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:229:9: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     229 |         {                                                               \
         |         ^
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:226:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     226 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:69:1: note: in expansion of macro 'SYSCALL_DEFINE3'
      69 | SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
         | ^~~~~~~~~~~~~~~
   block/ioprio.c:70:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      70 | {
         | ^
   block/ioprio.c:143:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     143 | {
         | ^
   block/ioprio.c:163:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     163 | {
         | ^
   block/ioprio.c:180:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     180 | {
         | ^
   arch/x86/include/asm/syscall_wrapper.h:224:21: error: storage class specified for parameter '__se_sys_ioprio_get'
     224 |         static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));     \
         |                     ^~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:225:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     225 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:184:1: note: in expansion of macro 'SYSCALL_DEFINE2'
     184 | SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:225:28: error: storage class specified for parameter '__do_sys_ioprio_get'
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
     235 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:225:36: note: in expansion of macro 'SYSCALL_DEFINEx'
     225 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~
   block/ioprio.c:184:1: note: in expansion of macro 'SYSCALL_DEFINE2'
     184 | SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
         | ^~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:225:28: warning: parameter '__do_sys_ioprio_get' declared 'inline'
     225 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |                            ^~~~~~~~
   include/linux/syscalls.h:235:9: note: in expansion of macro '__SYSCALL_DEFINEx'
--
   include/linux/init_syscalls.h:7:12: error: section attribute not allowed for 'init_chroot'
       7 | int __init init_chroot(const char *filename);
         |            ^~~~~~~~~~~
   include/linux/init_syscalls.h:8:12: error: section attribute not allowed for 'init_chown'
       8 | int __init init_chown(const char *filename, uid_t user, gid_t group, int flags);
         |            ^~~~~~~~~~
   include/linux/init_syscalls.h:9:12: error: section attribute not allowed for 'init_chmod'
       9 | int __init init_chmod(const char *filename, umode_t mode);
         |            ^~~~~~~~~~
   include/linux/init_syscalls.h:10:12: error: section attribute not allowed for 'init_eaccess'
      10 | int __init init_eaccess(const char *filename);
         |            ^~~~~~~~~~~~
   include/linux/init_syscalls.h:11:12: error: section attribute not allowed for 'init_stat'
      11 | int __init init_stat(const char *filename, struct kstat *stat, int flags);
         |            ^~~~~~~~~
   include/linux/init_syscalls.h:12:12: error: section attribute not allowed for 'init_mknod'
      12 | int __init init_mknod(const char *filename, umode_t mode, unsigned int dev);
         |            ^~~~~~~~~~
   include/linux/init_syscalls.h:13:12: error: section attribute not allowed for 'init_link'
      13 | int __init init_link(const char *oldname, const char *newname);
         |            ^~~~~~~~~
   include/linux/init_syscalls.h:14:12: error: section attribute not allowed for 'init_symlink'
      14 | int __init init_symlink(const char *oldname, const char *newname);
         |            ^~~~~~~~~~~~
   include/linux/init_syscalls.h:15:12: error: section attribute not allowed for 'init_unlink'
      15 | int __init init_unlink(const char *pathname);
         |            ^~~~~~~~~~~
   include/linux/init_syscalls.h:16:12: error: section attribute not allowed for 'init_mkdir'
      16 | int __init init_mkdir(const char *pathname, umode_t mode);
         |            ^~~~~~~~~~
   include/linux/init_syscalls.h:17:12: error: section attribute not allowed for 'init_rmdir'
      17 | int __init init_rmdir(const char *pathname);
         |            ^~~~~~~~~~
   include/linux/init_syscalls.h:18:12: error: section attribute not allowed for 'init_utimes'
      18 | int __init init_utimes(char *filename, struct timespec64 *ts);
         |            ^~~~~~~~~~~
   include/linux/init_syscalls.h:19:12: error: section attribute not allowed for 'init_dup'
      19 | int __init init_dup(struct file *file);
         |            ^~~~~~~~
   In file included from init/do_mounts.h:12:
   include/linux/task_work.h:8:16: error: storage class specified for parameter 'task_work_func_t'
       8 | typedef void (*task_work_func_t)(struct callback_head *);
         |                ^~~~~~~~~~~~~~~~
   include/linux/task_work.h:11:45: error: expected declaration specifiers or '...' before 'task_work_func_t'
      11 | init_task_work(struct callback_head *twork, task_work_func_t func)
         |                                             ^~~~~~~~~~~~~~~~
   include/linux/task_work.h:16:1: warning: empty declaration
      16 | enum task_work_notify_mode {
         | ^~~~
   include/linux/task_work.h:25:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      25 | {
         | ^
   include/linux/task_work.h:34:67: error: expected declaration specifiers or '...' before 'task_work_func_t'
      34 | struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
         |                                                                   ^~~~~~~~~~~~~~~~
   include/linux/task_work.h:39:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      39 | {
         | ^
   init/do_mounts.h:17:12: error: storage class specified for parameter 'root_mountflags'
      17 | extern int root_mountflags;
         |            ^~~~~~~~~~~~~~~
   init/do_mounts.h:20:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      20 | {
         | ^
   init/do_mounts.h:32:39: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      32 | static inline int rd_load_disk(int n) { return 0; }
         |                                       ^
   init/do_mounts.h:33:45: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      33 | static inline int rd_load_image(char *from) { return 0; }
         |                                             ^
   init/do_mounts.h:38:13: error: section attribute not allowed for 'initrd_load'
      38 | bool __init initrd_load(char *root_device_name);
         |             ^~~~~~~~~~~
   init/do_mounts.h:49:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      49 | {
         | ^
   init/do_mounts_initrd.c:17:21: error: storage class specified for parameter 'real_root_dev'
      17 | static unsigned int real_root_dev;      /* do_proc_dointvec cannot handle kdev_t */
         |                     ^~~~~~~~~~~~~
   init/do_mounts_initrd.c:18:23: error: storage class specified for parameter 'mount_initrd'
      18 | static int __initdata mount_initrd = 1;
         |                       ^~~~~~~~~~~~
   init/do_mounts_initrd.c:18:1: error: parameter 'mount_initrd' is initialized
      18 | static int __initdata mount_initrd = 1;
         | ^~~~~~
   init/do_mounts_initrd.c:18:23: error: section attribute not allowed for 'mount_initrd'
      18 | static int __initdata mount_initrd = 1;
         |                       ^~~~~~~~~~~~
   init/do_mounts_initrd.c:20:13: error: section attribute not allowed for 'phys_initrd_start'
      20 | phys_addr_t phys_initrd_start __initdata;
         |             ^~~~~~~~~~~~~~~~~
   init/do_mounts_initrd.c:21:15: error: section attribute not allowed for 'phys_initrd_size'
      21 | unsigned long phys_initrd_size __initdata;
         |               ^~~~~~~~~~~~~~~~
   init/do_mounts_initrd.c:24:31: error: storage class specified for parameter 'kern_do_mounts_initrd_table'
      24 | static const struct ctl_table kern_do_mounts_initrd_table[] = {
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   init/do_mounts_initrd.c:24:21: error: parameter 'kern_do_mounts_initrd_table' is initialized
      24 | static const struct ctl_table kern_do_mounts_initrd_table[] = {
         |                     ^~~~~~~~~
>> init/do_mounts_initrd.c:25:9: warning: braces around scalar initializer
      25 |         {
         |         ^
   init/do_mounts_initrd.c:25:9: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:26:17: error: field name not in record or union initializer
      26 |                 .procname       = "real-root-dev",
         |                 ^
   init/do_mounts_initrd.c:26:17: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:26:35: error: initialization of 'const struct ctl_table *' from incompatible pointer type 'char *' [-Werror=incompatible-pointer-types]
      26 |                 .procname       = "real-root-dev",
         |                                   ^~~~~~~~~~~~~~~
   init/do_mounts_initrd.c:26:35: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:27:17: error: field name not in record or union initializer
      27 |                 .data           = &real_root_dev,
         |                 ^
   init/do_mounts_initrd.c:27:17: note: (near initialization for 'kern_do_mounts_initrd_table')
>> init/do_mounts_initrd.c:27:35: warning: excess elements in scalar initializer
      27 |                 .data           = &real_root_dev,
         |                                   ^
   init/do_mounts_initrd.c:27:35: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:28:17: error: field name not in record or union initializer
      28 |                 .maxlen         = sizeof(int),
         |                 ^
   init/do_mounts_initrd.c:28:17: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:28:35: warning: excess elements in scalar initializer
      28 |                 .maxlen         = sizeof(int),
         |                                   ^~~~~~
   init/do_mounts_initrd.c:28:35: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:29:17: error: field name not in record or union initializer
      29 |                 .mode           = 0644,
         |                 ^
   init/do_mounts_initrd.c:29:17: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:29:35: warning: excess elements in scalar initializer
      29 |                 .mode           = 0644,
         |                                   ^~~~
   init/do_mounts_initrd.c:29:35: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:30:17: error: field name not in record or union initializer
      30 |                 .proc_handler   = proc_dointvec,
         |                 ^
   init/do_mounts_initrd.c:30:17: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:30:35: warning: excess elements in scalar initializer
      30 |                 .proc_handler   = proc_dointvec,
         |                                   ^~~~~~~~~~~~~
   init/do_mounts_initrd.c:30:35: note: (near initialization for 'kern_do_mounts_initrd_table')
   init/do_mounts_initrd.c:35:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      35 | {
         | ^
   include/linux/compiler.h:166:45: error: storage class specified for parameter '__UNIQUE_ID___addressable_kernel_do_mounts_initrd_sysctls_init369'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:83:23: note: in definition of macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler.h:166:29: note: in expansion of macro '__PASTE'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:166:37: note: in expansion of macro '__PASTE'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/compiler.h:286:9: note: in expansion of macro '__UNIQUE_ID'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |         ^~~~~~~~~~~
   include/linux/compiler.h:289:9: note: in expansion of macro '___ADDRESSABLE'
     289 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__ADDRESSABLE'
     256 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:261:9: note: in expansion of macro '__define_initcall_stub'
     261 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '____define_initcall'
     274 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   init/do_mounts_initrd.c:39:1: note: in expansion of macro 'late_initcall'
      39 | late_initcall(kernel_do_mounts_initrd_sysctls_init);
         | ^~~~~~~~~~~~~
   init/do_mounts_initrd.c:39:1: error: parameter '__UNIQUE_ID___addressable_kernel_do_mounts_initrd_sysctls_init369' is initialized
>> init/do_mounts_initrd.c:39:1: warning: 'used' attribute ignored [-Wattributes]
   include/linux/compiler.h:166:45: error: section attribute not allowed for '__UNIQUE_ID___addressable_kernel_do_mounts_initrd_sysctls_init369'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/compiler_types.h:83:23: note: in definition of macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/compiler.h:166:29: note: in expansion of macro '__PASTE'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler.h:166:37: note: in expansion of macro '__PASTE'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/compiler.h:286:9: note: in expansion of macro '__UNIQUE_ID'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |         ^~~~~~~~~~~
   include/linux/compiler.h:289:9: note: in expansion of macro '___ADDRESSABLE'
     289 |         ___ADDRESSABLE(sym, __section(".discard.addressable"))
         |         ^~~~~~~~~~~~~~
   include/linux/init.h:256:9: note: in expansion of macro '__ADDRESSABLE'
     256 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:261:9: note: in expansion of macro '__define_initcall_stub'
     261 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '____define_initcall'
     274 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   init/do_mounts_initrd.c:39:1: note: in expansion of macro 'late_initcall'
      39 | late_initcall(kernel_do_mounts_initrd_sysctls_init);
         | ^~~~~~~~~~~~~
   In file included from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16:
   init/do_mounts_initrd.c:39:15: error: 'kernel_do_mounts_initrd_sysctls_init' undeclared (first use in this function)
      39 | late_initcall(kernel_do_mounts_initrd_sysctls_init);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:286:72: note: in definition of macro '___ADDRESSABLE'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |                                                                        ^~~
   include/linux/init.h:256:9: note: in expansion of macro '__ADDRESSABLE'
     256 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:261:9: note: in expansion of macro '__define_initcall_stub'
     261 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '____define_initcall'
     274 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   init/do_mounts_initrd.c:39:1: note: in expansion of macro 'late_initcall'
      39 | late_initcall(kernel_do_mounts_initrd_sysctls_init);
         | ^~~~~~~~~~~~~
   init/do_mounts_initrd.c:39:15: note: each undeclared identifier is reported only once for each function it appears in
      39 | late_initcall(kernel_do_mounts_initrd_sysctls_init);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:286:72: note: in definition of macro '___ADDRESSABLE'
     286 |         __UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
         |                                                                        ^~~
   include/linux/init.h:256:9: note: in expansion of macro '__ADDRESSABLE'
     256 |         __ADDRESSABLE(fn)
         |         ^~~~~~~~~~~~~
   include/linux/init.h:261:9: note: in expansion of macro '__define_initcall_stub'
     261 |         __define_initcall_stub(__stub, fn)                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:274:9: note: in expansion of macro '____define_initcall'
     274 |         ____define_initcall(fn,                                 \
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:313:41: note: in expansion of macro '__define_initcall'
     313 | #define late_initcall(fn)               __define_initcall(fn, 7)
         |                                         ^~~~~~~~~~~~~~~~~
   init/do_mounts_initrd.c:39:1: note: in expansion of macro 'late_initcall'
      39 | late_initcall(kernel_do_mounts_initrd_sysctls_init);
         | ^~~~~~~~~~~~~
   In file included from include/linux/printk.h:6,
                    from include/linux/kernel.h:31:
..


vim +16 include/linux/stddef.h

6e218287432472 Richard Knutsson 2006-09-30  14  
^1da177e4c3f41 Linus Torvalds   2005-04-16  15  #undef offsetof
14e83077d55ff4 Rasmus Villemoes 2022-03-23 @16  #define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
3876488444e712 Denys Vlasenko   2015-03-09  17  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

