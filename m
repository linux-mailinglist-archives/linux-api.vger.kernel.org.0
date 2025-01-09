Return-Path: <linux-api+bounces-2961-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45FA06ADD
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 03:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00AC163230
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 02:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51397487BF;
	Thu,  9 Jan 2025 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK1K5OWK"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4D2AD31;
	Thu,  9 Jan 2025 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389355; cv=none; b=dc98uL8ZreXsWUgkccqD6US+tGOwY3hbpBZXvuI0XqHQdrRFbhRJwq8aMy7XbN85BYswStOf/S3mDC25OmNO3rxi4FTsPqOVuZE/DczoFKBbdNzoHBtoByPYUB4Y88xQgsfsn7tLg5oZxjnKvlDD9Dv6mro9vvVEenbnuPysvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389355; c=relaxed/simple;
	bh=n6F7hdGAmslB9CZg6tr+UZ8plNo2QCptD3FnnSRnMLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AybzMbbMyBZPGaHoZiXQuJclG3Wq6NgUYmya2Fymao7+pIcjK6VAFmUyXwiXMtkLfMWPqSrxFCgnz12nPlDxVuebh2T6GekIu2zEJcjC3QwkDNH9soth2Tsp1aav8zfDBz/q7MOP5hVcKa8+ez07I0ZtPdNv1w8q1XWU6PZk0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK1K5OWK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736389353; x=1767925353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n6F7hdGAmslB9CZg6tr+UZ8plNo2QCptD3FnnSRnMLU=;
  b=kK1K5OWKOQUi0NI79AkL/aXm1gcDnOtmsvg9df3b13naI7zKKv+yAbmJ
   ZheIzOLdD5K3TegHMKGAn2SY7dOtrz6yMMFwOTjzUmF852ZSqzqg3zS1X
   v8oJtwRXIKSvEiNpJqKh9zaVXPF7Heb9q4SuGOecbQY1iv9ggHPoVSOsl
   Bjt6RgW+5Nnu2U3nxs4twLeKUlRxM6Hlo5oDHEy3anA/aMsyfLkbvBN2K
   9X7mKCaruEjEMw5JW72tyGL6La5NVZU2PJXszbV0yKQ67+dO9876KEQMj
   /XMzPoaWuTvnZFCkKX9xHK5LYF9BaDPuzrIJIJe0c1kpN3DRDdAtHCmKZ
   A==;
X-CSE-ConnectionGUID: rKhadDuMRuqOSLpuK9n+DQ==
X-CSE-MsgGUID: 7v+muw12R3WJ2x4q0EZ3FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47303497"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="47303497"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 18:22:31 -0800
X-CSE-ConnectionGUID: vWCVwgLLQWOchty8ky9wEg==
X-CSE-MsgGUID: eBll/2QTQDeBdxBnORk5Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="134111750"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Jan 2025 18:22:27 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tViBl-000Gvx-0b;
	Thu, 09 Jan 2025 02:22:25 +0000
Date: Thu, 9 Jan 2025 10:21:36 +0800
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
Message-ID: <202501090954.gYTxI9sY-lkp@intel.com>
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
config: hexagon-randconfig-001-20250109 (https://download.01.org/0day-ci/archive/20250109/202501090954.gYTxI9sY-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501090954.gYTxI9sY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501090954.gYTxI9sY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/ptrace.c:1053:3: error: implicit declaration of function 'syscall_set_return_value' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   syscall_set_return_value(child, regs, -ENOSYS, 0);
                   ^
   kernel/ptrace.c:1053:3: note: did you mean 'syscall_get_return_value'?
   arch/hexagon/include/asm/syscall.h:56:20: note: 'syscall_get_return_value' declared here
   static inline long syscall_get_return_value(struct task_struct *task,
                      ^
   kernel/ptrace.c:1075:3: error: implicit declaration of function 'syscall_set_return_value' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   syscall_set_return_value(child, regs, info->exit.rval, 0);
                   ^
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

