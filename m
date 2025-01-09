Return-Path: <linux-api+bounces-2962-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DF6A07881
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 15:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2417F1889BA2
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B221A443;
	Thu,  9 Jan 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k652eWZW"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDD219EB6;
	Thu,  9 Jan 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431443; cv=none; b=QorFf515ARQc0/eBe1IEo2RlUHvf0idIPi8gOS6XyQ07pPpEhTHnoKmi/Obt4egrkVSlZUGnZJG5l8Ax/y9SXCraf93miVWns8wPionF6wxp4EKh8qj4iree3He8yCZcVssH2sENe+86zZF48USXII6NeFAhnU7/Wssxcr/miN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431443; c=relaxed/simple;
	bh=UWB6doJdaiwZrEW0sfpO/DyKw7haphGlV4KhtLkvTJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+lIsy/io9Hq0Y76d6Ed64ge12aljXh51oehvgbUmon0NASb6wgPzwMENSXkQ0bFcOwt78MPZAs+jo851Cf8QvLOYFX24mteFAlbKHxrvrIStl6/f2ylhG4iauwoVeKQF45vf0Yr02yfAYC3zdbC1kZAOTCeMhtS94GqYLbEN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k652eWZW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736431441; x=1767967441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UWB6doJdaiwZrEW0sfpO/DyKw7haphGlV4KhtLkvTJs=;
  b=k652eWZWuR/HQ0hRcwhAM/Fm+lZvF/iUsyENRZWccFsMY1RBMtJHmEM6
   TPBNLnt6IEZSO+0AAAgKR9CjYZxiV7gwpbCLeeQSGUggHnIWr5qJ0wCZb
   7mcBSzvpE9Mqbu+Tp3188cC9ZVRfKuNMhpDxGbBLrapSB6/6vA9ht9LbQ
   5lblx8rZrsl0PHOrIo68X1R3epITIPb1uxJQE1cdmwO/w2mcpvHJ23bho
   Pj7zKqjCkt9JmgM4YEw/htKw0ZYiAPjNkZaq2cvJsG6/GEYFF29tn5vig
   UTLHBi9D3QKd+S4ZgqDxjpyt4UWF1Q3Es2plqhFZM0kxW2BZLwBOSznvn
   Q==;
X-CSE-ConnectionGUID: Z20PGK+iRrKyWdibHkfz7Q==
X-CSE-MsgGUID: Uag8lk07QKipVLxYTgzmHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="48054842"
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="48054842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 06:04:00 -0800
X-CSE-ConnectionGUID: Oc/aELuVQbOzsuzoC/izoA==
X-CSE-MsgGUID: OwtKc+KCSxeAkV7Sdk3Jzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="103219228"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Jan 2025 06:03:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVt8c-000Hdb-0Z;
	Thu, 09 Jan 2025 14:03:54 +0000
Date: Thu, 9 Jan 2025 22:03:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <202501092150.9BH2s9AO-lkp@intel.com>
References: <20250107230456.GE30633@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107230456.GE30633@strace.io>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on openrisc/for-next]
[also build test WARNING on powerpc/next powerpc/fixes s390/features uml/next jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master vgupta-arc/for-curr arm64/for-next/core linus/master uml/fixes tip/x86/core vgupta-arc/for-next v6.13-rc6 next-20250109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-V-Levin/Revert-arch-remove-unused-function-syscall_set_arguments/20250108-070658
base:   https://github.com/openrisc/linux.git for-next
patch link:    https://lore.kernel.org/r/20250107230456.GE30633%40strace.io
patch subject: [PATCH 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
config: mips-randconfig-r122-20250109 (https://download.01.org/0day-ci/archive/20250109/202501092150.9BH2s9AO-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250109/202501092150.9BH2s9AO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501092150.9BH2s9AO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/ptrace.c:55:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:55:22: sparse:    struct task_struct *
   kernel/ptrace.c:55:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:74:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:74:23: sparse:     expected struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:74:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:75:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:75:29: sparse:     expected struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:75:29: sparse:     got struct cred const *
   kernel/ptrace.c:129:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   kernel/ptrace.c:129:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:129:18: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:133:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:133:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:133:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:160:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:160:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:160:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:192:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:192:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:192:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:198:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:198:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:198:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:251:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:251:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:251:44: sparse:    struct task_struct *
   kernel/ptrace.c:494:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:494:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:494:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:502:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:502:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:502:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:550:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:550:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:550:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:552:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:552:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:552:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:743:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:743:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:743:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:751:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:751:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:751:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:862:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:862:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:862:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:866:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:866:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:866:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1206:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1206:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1206:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1208:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1208:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1208:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c: note: in included file (through include/linux/fwnode.h, include/linux/logic_pio.h, include/asm-generic/io.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:751:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:751:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:751:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:380:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *l @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:380:30: sparse:     expected struct spinlock [usertype] *l
   kernel/ptrace.c:380:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:409:12: sparse: sparse: context imbalance in 'ptrace_attach' - different lock contexts for basic block
   kernel/ptrace.c:500:38: sparse: sparse: dereference of noderef expression
   kernel/ptrace.c: note: in included file (through include/linux/fwnode.h, include/linux/logic_pio.h, include/asm-generic/io.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:751:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:751:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:751:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:690:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:751:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:751:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:751:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:706:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   kernel/ptrace.c: note: in included file:
   arch/mips/include/asm/syscall.h:85:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__p @@     got int * @@
   arch/mips/include/asm/syscall.h:85:25: sparse:     expected int const [noderef] __user *__p
   arch/mips/include/asm/syscall.h:85:25: sparse:     got int *
>> arch/mips/include/asm/syscall.h:121:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   arch/mips/include/asm/syscall.h:121:25: sparse:     expected int [noderef] __user *__p
   arch/mips/include/asm/syscall.h:121:25: sparse:     got int *
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:751:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:751:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:751:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:751:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:751:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:751:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1369:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block

vim +121 arch/mips/include/asm/syscall.h

307e4cb2957c2f Dmitry V. Levin 2025-01-08  116  
307e4cb2957c2f Dmitry V. Levin 2025-01-08  117  #ifdef CONFIG_64BIT
307e4cb2957c2f Dmitry V. Levin 2025-01-08  118  	case 4: case 5: case 6: case 7:
307e4cb2957c2f Dmitry V. Levin 2025-01-08  119  #ifdef CONFIG_MIPS32_O32
307e4cb2957c2f Dmitry V. Levin 2025-01-08  120  		if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
307e4cb2957c2f Dmitry V. Levin 2025-01-08 @121  			put_user(*arg, (int *)usp + n);
307e4cb2957c2f Dmitry V. Levin 2025-01-08  122  		else
307e4cb2957c2f Dmitry V. Levin 2025-01-08  123  #endif
307e4cb2957c2f Dmitry V. Levin 2025-01-08  124  			regs->regs[4 + n] = *arg;
307e4cb2957c2f Dmitry V. Levin 2025-01-08  125  
307e4cb2957c2f Dmitry V. Levin 2025-01-08  126  		return;
307e4cb2957c2f Dmitry V. Levin 2025-01-08  127  #endif
307e4cb2957c2f Dmitry V. Levin 2025-01-08  128  	}
307e4cb2957c2f Dmitry V. Levin 2025-01-08  129  }
307e4cb2957c2f Dmitry V. Levin 2025-01-08  130  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

