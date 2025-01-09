Return-Path: <linux-api+bounces-2960-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA9A06A5C
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 02:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E2C1663B6
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2EB677;
	Thu,  9 Jan 2025 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6DXrIDU"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB0523A;
	Thu,  9 Jan 2025 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736386703; cv=none; b=FV//xQpcJebaoQzKKweQRmaXlmw4jR0n+F7TV9QenlhgwJFy5WJOIZs9U9VM5RDEWHFOdIPFw3lNA4pqpQ+m5rzwYCSpqQJhV1iwpQ6XZw3jMez/yrkQEMtZ7VOyzbSD1x+orijoEmHsfL0eO79iuvmAhifsH2KY3LZMqQKBhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736386703; c=relaxed/simple;
	bh=oF7Y6SMiN0ONR3SZWTXiT+ru74SS/1HZRQIhYEsngmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIsjZ1iF8AJ8Dj1PdkpEZfacVr452DPIwwMrM2Cvy29wHAzEAdelnkhCCVSqVLDgXaNtLke9xNRvHELwDoO0IB1rym1+fAGRLQVv3I1p2F9M+GjSrU722ujK3rOJHJJwAU/pG/N8Mmwc4JMtf35WZ/Mm7VTvjNuJz0RaQROFOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6DXrIDU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736386702; x=1767922702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oF7Y6SMiN0ONR3SZWTXiT+ru74SS/1HZRQIhYEsngmg=;
  b=m6DXrIDUn3tSD6inRsIbLBNN6r7AZEN2pH1clg62EUS9PqV3r2cYGeUH
   pFc5FkyzVd/fVj/Tsw6T3Tfwwvs21HAc+n+nLPuQd5gLmyqoefO/LhJ+w
   l8u7MYDOp6apAf+3Q3S4avq8/emRO/OgkLJZOEVMk61vBb3KbLgZBceWy
   qfdawUtu4T73kXNITmWU0Xb5+hlTvrxTgThH3h9iDDTTPDzNWk+i/3avn
   JIov+CMgGdQALu5PafQn3JoG+s4bEw79Skh+MzgixqlgCh7j9WEp4//+p
   1ZTFUqkBrL2leuX+rMSBLCDI2uEP6V5k1t8alYAWRi79vemYg42/jS0r7
   g==;
X-CSE-ConnectionGUID: LnYxUu2SStaqOsjsUUtibQ==
X-CSE-MsgGUID: L87GthXQShmGxgBkUpX0ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47992705"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="47992705"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 17:38:21 -0800
X-CSE-ConnectionGUID: zuCBD9jVRF+/TqWg5oXmMg==
X-CSE-MsgGUID: cbOIGZXrTBOmuK5jJR1EEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107865031"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jan 2025 17:38:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVhV2-000GtX-0E;
	Thu, 09 Jan 2025 01:38:16 +0000
Date: Thu, 9 Jan 2025 09:37:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <202501090919.TiLTOhaq-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on openrisc/for-next]
[also build test ERROR on powerpc/next powerpc/fixes s390/features uml/next jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master vgupta-arc/for-curr arm64/for-next/core linus/master uml/fixes tip/x86/core vgupta-arc/for-next v6.13-rc6 next-20250108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-V-Levin/Revert-arch-remove-unused-function-syscall_set_arguments/20250108-070658
base:   https://github.com/openrisc/linux.git for-next
patch link:    https://lore.kernel.org/r/20250107230456.GE30633%40strace.io
patch subject: [PATCH 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20250109/202501090919.TiLTOhaq-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 096551537b2a747a3387726ca618ceeb3950e9bc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501090919.TiLTOhaq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501090919.TiLTOhaq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/ptrace.c:1053:3: error: call to undeclared function 'syscall_set_return_value'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1053 |                 syscall_set_return_value(child, regs, -ENOSYS, 0);
         |                 ^
   kernel/ptrace.c:1053:3: note: did you mean 'syscall_get_return_value'?
   arch/hexagon/include/asm/syscall.h:56:20: note: 'syscall_get_return_value' declared here
      56 | static inline long syscall_get_return_value(struct task_struct *task,
         |                    ^
   kernel/ptrace.c:1075:3: error: call to undeclared function 'syscall_set_return_value'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1075 |                 syscall_set_return_value(child, regs, info->exit.rval, 0);
         |                 ^
   2 errors generated.


vim +/syscall_set_return_value +1053 kernel/ptrace.c

  1021	
  1022	static unsigned long
  1023	ptrace_set_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
  1024				      struct ptrace_syscall_info *info)
  1025	{
  1026		unsigned long args[ARRAY_SIZE(info->entry.args)];
  1027		int nr = info->entry.nr;
  1028		int i;
  1029	
  1030		if (nr != info->entry.nr)
  1031			return -ERANGE;
  1032	
  1033		for (i = 0; i < ARRAY_SIZE(args); i++) {
  1034			args[i] = info->entry.args[i];
  1035			if (args[i] != info->entry.args[i])
  1036				return -ERANGE;
  1037		}
  1038	
  1039		syscall_set_nr(child, regs, nr);
  1040		syscall_set_arguments(child, regs, args);
  1041		if (nr == -1) {
  1042			/*
  1043			 * When the syscall number is set to -1, the syscall will be
  1044			 * skipped.  In this case also set the syscall return value to
  1045			 * -ENOSYS, otherwise on some architectures the corresponding
  1046			 * struct pt_regs field will remain unchanged.
  1047			 *
  1048			 * Note that on some architectures syscall_set_return_value()
  1049			 * modifies one of the struct pt_regs fields also modified by
  1050			 * syscall_set_arguments(), so the former should be called
  1051			 * after the latter.
  1052			 */
> 1053			syscall_set_return_value(child, regs, -ENOSYS, 0);
  1054		}
  1055	
  1056		return 0;
  1057	}
  1058	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

