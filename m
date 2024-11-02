Return-Path: <linux-api+bounces-2658-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF00A9B9D47
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 06:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633AE1F2558F
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 05:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94C14AD38;
	Sat,  2 Nov 2024 05:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOljTd4+"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D75148826;
	Sat,  2 Nov 2024 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524403; cv=none; b=CMATamVX2PylGZ4ibwj2BtlY+E/v5XdizG+HnSPPlwI1TdOVKwW+XODd7+BFhwVCKWcd182tS5tfoWzkqvq6PjYO9PUXefgKXJYTTmpAAevQ57cbO76xiQ72af/rbX0CDmMOV4up59sqrb+CUpVNS7ibPgJiAuNCK5nuBXktruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524403; c=relaxed/simple;
	bh=2CBUDdckRX9eXW8UG0ZJT9/03nd6A5buRXD7s+rxrjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu8mxvDwJBSlMmSO0LQa3/qrrOwy9npyxfYleRpn3KW7VvwlyZGEkDlIPZ/yLGiIPClwj4ykuUNg3aRhc2XKBGIzyI4qorVRbymG4Y+Q58orVHktJ1bx8c+pOTx+8HLZz6+GatvNWHILnKIH6uypyMeSjYIH6KwtckKoT4uzWK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOljTd4+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730524400; x=1762060400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2CBUDdckRX9eXW8UG0ZJT9/03nd6A5buRXD7s+rxrjU=;
  b=YOljTd4+w5AQdCHYC/1IpYFaKK2oifOlqeIYunErmmAJAfFSxwk2zk4+
   raWatyPL3msX5Uz/CwLLm3dzt7cgQpq0WROI9mxqzkDsQs+8MYRbEB7zV
   q5eVZZ0NzuM/31C4kfP9ure5yO6P9nXbWkdwxWuITYFeOsZF/riyuswqk
   FoFC+gUJ2quwBTZAElkC6LN+TbI5MUrPK6SFZOIkdLSJ1ri0oIZJIAwPW
   tAF8RvOT94ys2QJH/3aZmmTT1XFhmriZXBPjp7l/de1b15uO+nQVSeEZ5
   cCO1F+cOS1cpMLRWMtviKGUQEHrCcIWXXXiSavvRVPOLKrSI419VwKYd4
   Q==;
X-CSE-ConnectionGUID: XnSKbznlTwu8kXKRRnJMuA==
X-CSE-MsgGUID: 1/kU0clsR3yIIidwOv9P0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30394849"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="30394849"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 22:13:19 -0700
X-CSE-ConnectionGUID: Ojh+67kvSr+4X1Ovd4EKMA==
X-CSE-MsgGUID: XAgTBWgaTHqr6PWGf6LNUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="87757342"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 01 Nov 2024 22:13:16 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t76Rm-000iRz-0w;
	Sat, 02 Nov 2024 05:13:14 +0000
Date: Sat, 2 Nov 2024 13:13:06 +0800
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
Subject: Re: [PATCH v2 3/3] futex: Wire up set_robust_list2 syscall
Message-ID: <202411021208.9UQz3ahR-lkp@intel.com>
References: <20241101162147.284993-4-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101162147.284993-4-andrealmeid@igalia.com>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on tip/sched/core linus/master v6.12-rc5 next-20241101]
[cannot apply to tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/futex-Use-explicit-sizes-for-compat_exit_robust_list/20241102-002419
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20241101162147.284993-4-andrealmeid%40igalia.com
patch subject: [PATCH v2 3/3] futex: Wire up set_robust_list2 syscall
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20241102/202411021208.9UQz3ahR-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411021208.9UQz3ahR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411021208.9UQz3ahR-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:455:1: note: in expansion of macro '__SYSCALL'
     455 | __SYSCALL(454, sys_futex_wake)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:456:1: note: in expansion of macro '__SYSCALL'
     456 | __SYSCALL(455, sys_futex_wait)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[455]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:456:1: note: in expansion of macro '__SYSCALL'
     456 | __SYSCALL(455, sys_futex_wait)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:457:1: note: in expansion of macro '__SYSCALL'
     457 | __SYSCALL(456, sys_futex_requeue)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[456]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:457:1: note: in expansion of macro '__SYSCALL'
     457 | __SYSCALL(456, sys_futex_requeue)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:458:1: note: in expansion of macro '__SYSCALL'
     458 | __SYSCALL(457, sys_statmount)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[457]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:458:1: note: in expansion of macro '__SYSCALL'
     458 | __SYSCALL(457, sys_statmount)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:459:1: note: in expansion of macro '__SYSCALL'
     459 | __SYSCALL(458, sys_listmount)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[458]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:459:1: note: in expansion of macro '__SYSCALL'
     459 | __SYSCALL(458, sys_listmount)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:460:1: note: in expansion of macro '__SYSCALL'
     460 | __SYSCALL(459, sys_lsm_get_self_attr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[459]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:460:1: note: in expansion of macro '__SYSCALL'
     460 | __SYSCALL(459, sys_lsm_get_self_attr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:461:1: note: in expansion of macro '__SYSCALL'
     461 | __SYSCALL(460, sys_lsm_set_self_attr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[460]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:461:1: note: in expansion of macro '__SYSCALL'
     461 | __SYSCALL(460, sys_lsm_set_self_attr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:462:1: note: in expansion of macro '__SYSCALL'
     462 | __SYSCALL(461, sys_lsm_list_modules)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[461]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:462:1: note: in expansion of macro '__SYSCALL'
     462 | __SYSCALL(461, sys_lsm_list_modules)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:463:1: note: in expansion of macro '__SYSCALL'
     463 | __SYSCALL(462, sys_mseal)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[462]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   ./arch/arc/include/generated/asm/syscall_table_32.h:463:1: note: in expansion of macro '__SYSCALL'
     463 | __SYSCALL(462, sys_mseal)
         | ^~~~~~~~~
>> ./arch/arc/include/generated/asm/syscall_table_32.h:464:16: error: 'sys_set_robust_list2' undeclared here (not in a function); did you mean 'sys_set_robust_list'?
     464 | __SYSCALL(463, sys_set_robust_list2)
         |                ^~~~~~~~~~~~~~~~~~~~
   arch/arc/kernel/sys.c:13:37: note: in definition of macro '__SYSCALL'
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                     ^~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

