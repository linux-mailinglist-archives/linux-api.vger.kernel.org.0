Return-Path: <linux-api+bounces-2660-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBD19B9D5D
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 07:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 699FA1F24A07
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 06:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065991465B3;
	Sat,  2 Nov 2024 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDR8JmRK"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3706AB8;
	Sat,  2 Nov 2024 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730527583; cv=none; b=W2iNP3eRHeKyr70GLYw7/rQ/KF+jrZxQ0ul1BFEseTdHXZ6u534cgzg/4lqej8oZLKf/EQOOT4iZnUJyM/j3R92Ax9BLuI1ctITNKV704oG0ILV1Fb7m0l8oh/R92G+Lr82aXyJ4+VA/vh3gGhCdTq0DOLFzyt5yjS8FlOBJaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730527583; c=relaxed/simple;
	bh=FU3MbR9TdGzHaEWs8KjoXfNRyPQoGYyb1pFShhI8gWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+TDAacYmpyXqILfLEbPTb8G3uxvNfOJx4PAqXRZ9nvOkQZl+wNlMpWwm3KrDd3XfiuuhWodu6H0D8zbUYZV4uE48mrRt9N9CSIFExqqAiPhAlR3MSVKhP4XjfjHZrTKyD5C1krA4t4IX4/hS6rOUnBDHgY/WIvsRuRrsamsbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDR8JmRK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730527581; x=1762063581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FU3MbR9TdGzHaEWs8KjoXfNRyPQoGYyb1pFShhI8gWE=;
  b=RDR8JmRKBVBgaAYLwqN2Rza3r0HirEuHnaFnCIqJho1I4zz34e3kpbaf
   ebOw+WKN1OcctYz6/8VZpoNBRcVunizQ8li2bvsSNh9NSAxzSIDF9D/KM
   Sxk2P7dpXYTbtyhzy8BuggAxYJGLN36fzu0tqdzVggE1L7K8Oo6t+Tw1u
   k2CMgtROjv0+/WSqFFIiksQYnkI70OiExf0xyrXl46I7a+lbrpPW3nX1s
   Ym+0RhsLXkOT9hqwZM3vvmk38GQtSgVoKYH5OzjRIPLmLoAeNptxv7j+J
   vUPXOMrb82iuxTLodVh+Glwsl6If9TbtHvnFj0wOTKVUdtYn0Bitpdf32
   A==;
X-CSE-ConnectionGUID: 2SJinfakQluG+AcGDuv6jg==
X-CSE-MsgGUID: lzhMPL9/Qpur8PRA6nBqsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="47789147"
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="47789147"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 23:06:21 -0700
X-CSE-ConnectionGUID: PYQlaRYyRRSsAsJYr7TOjw==
X-CSE-MsgGUID: CwspcYxaR423x8GCTygejw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="113977044"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Nov 2024 23:06:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t77H5-000iUP-2X;
	Sat, 02 Nov 2024 06:06:15 +0000
Date: Sat, 2 Nov 2024 14:05:33 +0800
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
Message-ID: <202411021323.fazJ8GOs-lkp@intel.com>
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
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20241102/202411021323.fazJ8GOs-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411021323.fazJ8GOs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411021323.fazJ8GOs-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:455:1: note: in expansion of macro '__SYSCALL'
     455 | __SYSCALL(454, sys_futex_wake)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:456:1: note: in expansion of macro '__SYSCALL'
     456 | __SYSCALL(455, sys_futex_wait)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[455]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:456:1: note: in expansion of macro '__SYSCALL'
     456 | __SYSCALL(455, sys_futex_wait)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:457:1: note: in expansion of macro '__SYSCALL'
     457 | __SYSCALL(456, sys_futex_requeue)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[456]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:457:1: note: in expansion of macro '__SYSCALL'
     457 | __SYSCALL(456, sys_futex_requeue)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:458:1: note: in expansion of macro '__SYSCALL'
     458 | __SYSCALL(457, sys_statmount)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[457]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:458:1: note: in expansion of macro '__SYSCALL'
     458 | __SYSCALL(457, sys_statmount)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:459:1: note: in expansion of macro '__SYSCALL'
     459 | __SYSCALL(458, sys_listmount)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[458]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:459:1: note: in expansion of macro '__SYSCALL'
     459 | __SYSCALL(458, sys_listmount)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:460:1: note: in expansion of macro '__SYSCALL'
     460 | __SYSCALL(459, sys_lsm_get_self_attr)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[459]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:460:1: note: in expansion of macro '__SYSCALL'
     460 | __SYSCALL(459, sys_lsm_get_self_attr)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:461:1: note: in expansion of macro '__SYSCALL'
     461 | __SYSCALL(460, sys_lsm_set_self_attr)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[460]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:461:1: note: in expansion of macro '__SYSCALL'
     461 | __SYSCALL(460, sys_lsm_set_self_attr)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:462:1: note: in expansion of macro '__SYSCALL'
     462 | __SYSCALL(461, sys_lsm_list_modules)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[461]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:462:1: note: in expansion of macro '__SYSCALL'
     462 | __SYSCALL(461, sys_lsm_list_modules)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: warning: initialized field overwritten [-Woverride-init]
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:463:1: note: in expansion of macro '__SYSCALL'
     463 | __SYSCALL(462, sys_mseal)
         | ^~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:35: note: (near initialization for 'sys_call_table[462]')
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                   ^
   ./arch/csky/include/generated/asm/syscall_table_32.h:463:1: note: in expansion of macro '__SYSCALL'
     463 | __SYSCALL(462, sys_mseal)
         | ^~~~~~~~~
>> ./arch/csky/include/generated/asm/syscall_table_32.h:464:16: error: 'sys_set_robust_list2' undeclared here (not in a function); did you mean 'sys_set_robust_list'?
     464 | __SYSCALL(463, sys_set_robust_list2)
         |                ^~~~~~~~~~~~~~~~~~~~
   arch/csky/kernel/syscall_table.c:8:36: note: in definition of macro '__SYSCALL'
       8 | #define __SYSCALL(nr, call)[nr] = (call),
         |                                    ^~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

