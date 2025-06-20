Return-Path: <linux-api+bounces-3950-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83BFAE13CE
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 08:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E70817281F
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173622127D;
	Fri, 20 Jun 2025 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqDyvRKw"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE621FF58;
	Fri, 20 Jun 2025 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750400985; cv=none; b=Refm7Q7bNsROcTMY8ZiCP1WxhK+GYG0UAGPFrP81o898lXQ87FQFiU5Dq4nnhZ/ejBRj6jgVJc5427Qkn/2j6dVJRGXS5qmTK07lUvo435bwD1gIstjv09P6ftuDKxHMjoAFo+oxHpWwqf1kQ/5nHtbuc8eU+DvjuRfAZkaHOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750400985; c=relaxed/simple;
	bh=iUugU0beBkguA+V8gL0p/ImULSe9RWyQ1obwjtE8WFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlVp7UtEauykYSs3/s+yXB1RcHHFvvkUVA6VcHNX8qx+Ksbu8q+x9Lj3C73evNi0gsT3HlN6kX/tx7MbaHkcyXE4lXjX2hhFzm5Y/AcV+ELM/g2OWPiXUTYChDVrQcymmhUOIB/hqs064QfoxynQzTtHGa0oWRz80N74AypvlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqDyvRKw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750400984; x=1781936984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iUugU0beBkguA+V8gL0p/ImULSe9RWyQ1obwjtE8WFk=;
  b=EqDyvRKwUs8d88zfwpLY+dwIKr5RTHS4qjFrq54S/DY6wHTX1LuVBEkC
   YrPsRvlP7MNS3M87ZHzAVzgT9zuF83fPH/e5vml2QokiGGmNPNRfhbWX6
   M8tNpUBCUTYLREsp/+s+8NpatCX86xEZfkWRpPyGC855xUn6Wcy7o4kEm
   /NTndV5KHM/6ydE/7WpqCqXXeP3plSvsFI4eUrleJ1EpJknCRrY3QqqZk
   3vPhEPCibEffk3jC8X3SRlR2r/CaaK1BwoBzfHAB+30QRoZDpJxeglizg
   +4OPfVrsQaRUUTeBmX35ZGYpz2TsdwFbYkPbO/9VkfGjcoP4SuMURSDg5
   g==;
X-CSE-ConnectionGUID: 1UrlVzUsRz2P5pVHoMrlWw==
X-CSE-MsgGUID: 4ya3r4SoS9S4tUWK9d/+Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52799557"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="52799557"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 23:29:43 -0700
X-CSE-ConnectionGUID: HyJO1NXySR6iHuubhhWGag==
X-CSE-MsgGUID: 00rE7B2WR9WdVeFR74EtcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="151370534"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 19 Jun 2025 23:29:38 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSVFn-000LQy-1v;
	Fri, 20 Jun 2025 06:29:35 +0000
Date: Fri, 20 Jun 2025 14:28:53 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, mic@digikod.net, kees@kernel.org,
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp,
	song@kernel.org, linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH v2 2/3] lsm: introduce security_lsm_config_*_policy hooks
Message-ID: <202506201415.KiEs36AG-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 9c32cda43eb78f78c73aee4aa344b777714e259b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-B-lair/Wire-up-lsm_config_self_policy-and-lsm_config_system_policy-syscalls/20250620-022714
base:   9c32cda43eb78f78c73aee4aa344b777714e259b
patch link:    https://lore.kernel.org/r/20250619181600.478038-3-maxime.belair%40canonical.com
patch subject: [PATCH v2 2/3] lsm: introduce security_lsm_config_*_policy hooks
config: x86_64-buildonly-randconfig-003-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201415.KiEs36AG-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506201415.KiEs36AG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506201415.KiEs36AG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:52:
>> include/linux/security.h:1614:2: error: expected function body after function declarator
    1614 |         return -EOPNOTSUPP;
         |         ^
>> include/linux/security.h:1615:1: error: extraneous closing brace ('}')
    1615 | }
         | ^
   include/linux/security.h:1620:2: error: expected function body after function declarator
    1620 |         return -EOPNOTSUPP;
         |         ^
   include/linux/security.h:1621:1: error: extraneous closing brace ('}')
    1621 | }
         | ^
   4 errors generated.
--
   In file included from kernel/sysctl.c:29:
>> include/linux/security.h:1614:2: error: expected function body after function declarator
    1614 |         return -EOPNOTSUPP;
         |         ^
>> include/linux/security.h:1615:1: error: extraneous closing brace ('}')
    1615 | }
         | ^
   include/linux/security.h:1620:2: error: expected function body after function declarator
    1620 |         return -EOPNOTSUPP;
         |         ^
   include/linux/security.h:1621:1: error: extraneous closing brace ('}')
    1621 | }
         | ^
   In file included from kernel/sysctl.c:46:
   In file included from include/linux/nfs_fs.h:31:
   In file included from include/linux/sunrpc/auth.h:13:
   In file included from include/linux/sunrpc/sched.h:19:
   include/linux/sunrpc/xdr.h:803:46: warning: result of comparison of constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     803 |         if (U32_MAX >= SIZE_MAX / sizeof(*p) && len > SIZE_MAX / sizeof(*p))
         |                                                 ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~
   1 warning and 4 errors generated.
--
   In file included from kernel/signal.c:30:
>> include/linux/security.h:1614:2: error: expected function body after function declarator
    1614 |         return -EOPNOTSUPP;
         |         ^
>> include/linux/security.h:1615:1: error: extraneous closing brace ('}')
    1615 | }
         | ^
   include/linux/security.h:1620:2: error: expected function body after function declarator
    1620 |         return -EOPNOTSUPP;
         |         ^
   include/linux/security.h:1621:1: error: extraneous closing brace ('}')
    1621 | }
         | ^
   kernel/signal.c:142:37: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     142 |         case 4: ready  = signal->sig[3] &~ blocked->sig[3];
         |                                            ^            ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   kernel/signal.c:142:19: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     142 |         case 4: ready  = signal->sig[3] &~ blocked->sig[3];
         |                          ^           ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   kernel/signal.c:143:30: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     143 |                 ready |= signal->sig[2] &~ blocked->sig[2];
         |                                            ^            ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   kernel/signal.c:143:12: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     143 |                 ready |= signal->sig[2] &~ blocked->sig[2];
         |                          ^           ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   kernel/signal.c:144:30: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     144 |                 ready |= signal->sig[1] &~ blocked->sig[1];
         |                                            ^            ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   kernel/signal.c:144:12: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     144 |                 ready |= signal->sig[1] &~ blocked->sig[1];
         |                          ^           ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   kernel/signal.c:148:37: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     148 |         case 2: ready  = signal->sig[1] &~ blocked->sig[1];
         |                                            ^            ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   kernel/signal.c:148:19: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     148 |         case 2: ready  = signal->sig[1] &~ blocked->sig[1];
         |                          ^           ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   8 warnings and 4 errors generated.
--
   In file included from kernel/dma/swiotlb.c:53:
   In file included from include/trace/events/swiotlb.h:41:
   In file included from include/trace/define_trace.h:119:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
>> include/linux/security.h:1614:2: error: expected function body after function declarator
    1614 |         return -EOPNOTSUPP;
         |         ^
>> include/linux/security.h:1615:1: error: extraneous closing brace ('}')
    1615 | }
         | ^
   include/linux/security.h:1620:2: error: expected function body after function declarator
    1620 |         return -EOPNOTSUPP;
         |         ^
   include/linux/security.h:1621:1: error: extraneous closing brace ('}')
    1621 | }
         | ^
   kernel/dma/swiotlb.c:639:20: warning: shift count >= width of type [-Wshift-count-overflow]
     639 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                                  ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 4 errors generated.
--
   In file included from kernel/events/core.c:34:
   In file included from include/linux/syscalls.h:94:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:62:
>> include/linux/security.h:1614:2: error: expected function body after function declarator
    1614 |         return -EOPNOTSUPP;
         |         ^
>> include/linux/security.h:1615:1: error: extraneous closing brace ('}')
    1615 | }
         | ^
   include/linux/security.h:1620:2: error: expected function body after function declarator
    1620 |         return -EOPNOTSUPP;
         |         ^
   include/linux/security.h:1621:1: error: extraneous closing brace ('}')
    1621 | }
         | ^
   In file included from kernel/events/core.c:43:
   include/linux/mman.h:157:9: warning: division by zero is undefined [-Wdivision-by-zero]
     157 |                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:135:21: note: expanded from macro '_calc_vm_trans'
     135 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
         |                     ^ ~~~~~~~~~~~~~~~~~
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
     158 |                _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:135:21: note: expanded from macro '_calc_vm_trans'
     135 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
         |                     ^ ~~~~~~~~~~~~~~~~~
   2 warnings and 4 errors generated.


vim +1614 include/linux/security.h

  1610	
  1611	static int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
  1612						   size_t size, u32 flags)
  1613	
> 1614		return -EOPNOTSUPP;
> 1615	}
  1616	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

