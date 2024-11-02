Return-Path: <linux-api+bounces-2661-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3149BA0E6
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 15:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC2A1C20F5B
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF391922D6;
	Sat,  2 Nov 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXoCqRMi"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7B82890;
	Sat,  2 Nov 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730559466; cv=none; b=QZlDubn5eefVx4Sz6fM20NR/PztL4RQ9vJooH8u+KTepTUsj1V3ANIoS48EOLknpDRAqmpx+VSIzNn7qGc8I0m/Dk2KU/Z/BlSs8Ml80CEtVPlex0qkpk9G/sCPvEm/kHXn/lgBpBac/zEPTrcCalXmJHmo9bGhAH4DdDLpGj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730559466; c=relaxed/simple;
	bh=+kig3y6lmvI17GCrzccYnpL9XwG617bk4/y1maBE3L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOmnuGYiE+dgiy4xkohWgdOe7eAL0DoycUM9p2V6Hs1R7nWtf3Diwial0AEKNBkRLYIFEA4DYe5jX9b/qbF11S0mK2FxscHr4Rt2ssf9mI/qQXq197FiL+Sm12bNVbnR63VEmmvNh7GJ1cNA+m6ZU2a6NVolbDGRewIK4Efjd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXoCqRMi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730559465; x=1762095465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+kig3y6lmvI17GCrzccYnpL9XwG617bk4/y1maBE3L4=;
  b=SXoCqRMiAoHnjIK/8QlfWQA+rKYqT1grxrlDDt+lmG32T4lWtIWA6i+w
   e1DnFLDAqOsF7V2JkqI2AtmTWnvMHZ2BzsKwIThSelxIqBWbD1r4krzDj
   aTBiTj2pfMotarZt+QINzX7afNyIManc+sOTUzEb+PRzYYsBDgv+JLhJD
   DkD4sNQY2r9KUkDx/RL/tXoekq2O7Laq49aXcuAkRUAaVv4Tmw+p0E4ml
   4yykZN7CfTkYrSz5XTGOraeUShZCOCVLgsS0bf1VVKdycjVvCsMqSRCib
   tCy9Nhr8aZl95kXrPCl4ZSSk7xFh+ojXgECpBXwbWP5JaKRXbOM6LeJy5
   Q==;
X-CSE-ConnectionGUID: bJZm8/FyS6Cs+sYeoMbqXQ==
X-CSE-MsgGUID: GfbnDBxOTd6kArtjmfVLWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="40883294"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="40883294"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 07:57:44 -0700
X-CSE-ConnectionGUID: veWbj8gwRU6f/HwMxf2CnQ==
X-CSE-MsgGUID: JNxxEeC2RMqnaV69vmVfgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="87833768"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 02 Nov 2024 07:57:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7FZK-000j4n-1m;
	Sat, 02 Nov 2024 14:57:38 +0000
Date: Sat, 2 Nov 2024 22:57:16 +0800
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
Message-ID: <202411022242.XCJECOCz-lkp@intel.com>
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
config: x86_64-randconfig-123-20241102 (https://download.01.org/0day-ci/archive/20241102/202411022242.XCJECOCz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411022242.XCJECOCz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411022242.XCJECOCz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/futex/core.c:914:59: sparse: sparse: cast removes address space '__user' of expression
>> kernel/futex/core.c:914:59: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected unsigned int [noderef] [usertype] __user *head @@     got unsigned int [usertype] * @@
   kernel/futex/core.c:914:59: sparse:     expected unsigned int [noderef] [usertype] __user *head
   kernel/futex/core.c:914:59: sparse:     got unsigned int [usertype] *

vim +/__user +914 kernel/futex/core.c

   893	
   894	/*
   895	 * Walk curr->robust_list (very carefully, it's a userspace list!)
   896	 * and mark any locks found there dead, and notify any waiters.
   897	 *
   898	 * We silently return on any sign of list-walking problem.
   899	 */
   900	static void exit_robust_list32(struct task_struct *curr)
   901	{
   902		struct robust_list_head32 __user *head = curr->compat_robust_list;
   903		struct robust_list __user *entry, *next_entry, *pending;
   904		unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
   905		unsigned int next_pi;
   906		u32 uentry, next_uentry, upending;
   907		s32 futex_offset;
   908		int rc;
   909	
   910		/*
   911		 * Fetch the list head (which was registered earlier, via
   912		 * sys_set_robust_list()):
   913		 */
 > 914		if (fetch_robust_entry32((u32 *)&uentry, &entry, (u32 *)&head->list.next, &pi))
   915			return;
   916		/*
   917		 * Fetch the relative futex offset:
   918		 */
   919		if (get_user(futex_offset, &head->futex_offset))
   920			return;
   921		/*
   922		 * Fetch any possibly pending lock-add first, and handle it
   923		 * if it exists:
   924		 */
   925		if (fetch_robust_entry32(&upending, &pending,
   926				       &head->list_op_pending, &pip))
   927			return;
   928	
   929		next_entry = NULL;	/* avoid warning with gcc */
   930		while (entry != (struct robust_list __user *) &head->list) {
   931			/*
   932			 * Fetch the next entry in the list before calling
   933			 * handle_futex_death:
   934			 */
   935			rc = fetch_robust_entry32(&next_uentry, &next_entry,
   936				(u32 __user *)&entry->next, &next_pi);
   937			/*
   938			 * A pending lock might already be on the list, so
   939			 * dont process it twice:
   940			 */
   941			if (entry != pending) {
   942				void __user *uaddr = futex_uaddr(entry, futex_offset);
   943	
   944				if (handle_futex_death(uaddr, curr, pi,
   945						       HANDLE_DEATH_LIST))
   946					return;
   947			}
   948			if (rc)
   949				return;
   950			uentry = next_uentry;
   951			entry = next_entry;
   952			pi = next_pi;
   953			/*
   954			 * Avoid excessively long or circular lists:
   955			 */
   956			if (!--limit)
   957				break;
   958	
   959			cond_resched();
   960		}
   961		if (pending) {
   962			void __user *uaddr = futex_uaddr(pending, futex_offset);
   963	
   964			handle_futex_death(uaddr, curr, pip, HANDLE_DEATH_PENDING);
   965		}
   966	}
   967	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

