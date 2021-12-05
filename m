Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE52468E23
	for <lists+linux-api@lfdr.de>; Mon,  6 Dec 2021 00:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhLEXrT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 5 Dec 2021 18:47:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:38124 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhLEXrS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 5 Dec 2021 18:47:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237159110"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="237159110"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 15:43:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="460644315"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2021 15:43:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mu1AY-000Kbt-8q; Sun, 05 Dec 2021 23:43:46 +0000
Date:   Mon, 6 Dec 2021 07:42:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     akpm@linux-foundation.org, aarcange@redhat.com, ak@linux.intel.com,
        aneesh.kumar@linux.ibm.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        feng.tang@intel.com, linux-api@vger.kernel.org,
        mgorman@techsingularity.net, mhocko@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: + mm-mempolicy-wire-up-syscall-set_mempolicy_home_node.patch
 added to -mm tree
Message-ID: <202112060718.JbZsyJcP-lkp@intel.com>
References: <20211202225542.A2LkS8Bho%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202225542.A2LkS8Bho%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on deller-parisc/for-next linus/master v5.16-rc3]
[cannot apply to geert-m68k/for-next powerpc/next s390/features arnd-asm-generic/master tip/x86/asm davem-sparc/master next-20211203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/akpm-linux-foundation-org/mm-mempolicy-wire-up-syscall-set_mempolicy_home_node-patch-added-to-mm-tree/20211203-065847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-r025-20211203 (https://download.01.org/0day-ci/archive/20211206/202112060718.JbZsyJcP-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 1e328b06c15273edf4a40a27ca24931b5efb3a87)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/d7bb34dec7840474ed1ad87136b47eb1ea0c8bee
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review akpm-linux-foundation-org/mm-mempolicy-wire-up-syscall-set_mempolicy_home_node-patch-added-to-mm-tree/20211203-065847
        git checkout d7bb34dec7840474ed1ad87136b47eb1ea0c8bee
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:161:1: note: expanded from here
   __arm64_sys_process_madvise
   ^
   kernel/sys_ni.c:292:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:293:1: warning: no previous prototype for function '__arm64_sys_process_mrelease' [-Wmissing-prototypes]
   COND_SYSCALL(process_mrelease);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:162:1: note: expanded from here
   __arm64_sys_process_mrelease
   ^
   kernel/sys_ni.c:293:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:294:1: warning: no previous prototype for function '__arm64_sys_remap_file_pages' [-Wmissing-prototypes]
   COND_SYSCALL(remap_file_pages);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:163:1: note: expanded from here
   __arm64_sys_remap_file_pages
   ^
   kernel/sys_ni.c:294:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:295:1: warning: no previous prototype for function '__arm64_sys_mbind' [-Wmissing-prototypes]
   COND_SYSCALL(mbind);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:164:1: note: expanded from here
   __arm64_sys_mbind
   ^
   kernel/sys_ni.c:295:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:296:1: warning: no previous prototype for function '__arm64_sys_get_mempolicy' [-Wmissing-prototypes]
   COND_SYSCALL(get_mempolicy);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:165:1: note: expanded from here
   __arm64_sys_get_mempolicy
   ^
   kernel/sys_ni.c:296:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:297:1: warning: no previous prototype for function '__arm64_sys_set_mempolicy' [-Wmissing-prototypes]
   COND_SYSCALL(set_mempolicy);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:166:1: note: expanded from here
   __arm64_sys_set_mempolicy
   ^
   kernel/sys_ni.c:297:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:298:1: warning: no previous prototype for function '__arm64_sys_migrate_pages' [-Wmissing-prototypes]
   COND_SYSCALL(migrate_pages);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:167:1: note: expanded from here
   __arm64_sys_migrate_pages
   ^
   kernel/sys_ni.c:298:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:299:1: warning: no previous prototype for function '__arm64_sys_move_pages' [-Wmissing-prototypes]
   COND_SYSCALL(move_pages);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:168:1: note: expanded from here
   __arm64_sys_move_pages
   ^
   kernel/sys_ni.c:299:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
>> kernel/sys_ni.c:300:1: warning: no previous prototype for function '__arm64_sys_set_mempolicy_home_node' [-Wmissing-prototypes]
   COND_SYSCALL(set_mempolicy_home_node);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:169:1: note: expanded from here
   __arm64_sys_set_mempolicy_home_node
   ^
   kernel/sys_ni.c:300:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:302:1: warning: no previous prototype for function '__arm64_sys_perf_event_open' [-Wmissing-prototypes]
   COND_SYSCALL(perf_event_open);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:170:1: note: expanded from here
   __arm64_sys_perf_event_open
   ^
   kernel/sys_ni.c:302:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:303:1: warning: no previous prototype for function '__arm64_sys_accept4' [-Wmissing-prototypes]
   COND_SYSCALL(accept4);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:171:1: note: expanded from here
   __arm64_sys_accept4
   ^
   kernel/sys_ni.c:303:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:304:1: warning: no previous prototype for function '__arm64_sys_recvmmsg' [-Wmissing-prototypes]
   COND_SYSCALL(recvmmsg);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:172:1: note: expanded from here
   __arm64_sys_recvmmsg
   ^
   kernel/sys_ni.c:304:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:305:1: warning: no previous prototype for function '__arm64_sys_recvmmsg_time32' [-Wmissing-prototypes]
   COND_SYSCALL(recvmmsg_time32);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:173:1: note: expanded from here
   __arm64_sys_recvmmsg_time32
   ^
   kernel/sys_ni.c:305:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:306:1: warning: no previous prototype for function '__arm64_compat_sys_recvmmsg_time32' [-Wmissing-prototypes]
   COND_SYSCALL_COMPAT(recvmmsg_time32);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:41:25: note: expanded from macro 'COND_SYSCALL_COMPAT'
           asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs)    \
                                  ^
   <scratch space>:174:1: note: expanded from here
   __arm64_compat_sys_recvmmsg_time32
   ^
   kernel/sys_ni.c:306:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:41:13: note: expanded from macro 'COND_SYSCALL_COMPAT'
           asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs)    \
                      ^
   kernel/sys_ni.c:307:1: warning: no previous prototype for function '__arm64_compat_sys_recvmmsg_time64' [-Wmissing-prototypes]
   COND_SYSCALL_COMPAT(recvmmsg_time64);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:41:25: note: expanded from macro 'COND_SYSCALL_COMPAT'
           asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs)    \
                                  ^
   <scratch space>:2:1: note: expanded from here
   __arm64_compat_sys_recvmmsg_time64
   ^
   kernel/sys_ni.c:307:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:41:13: note: expanded from macro 'COND_SYSCALL_COMPAT'
           asmlinkage long __weak __arm64_compat_sys_##name(const struct pt_regs *regs)    \
                      ^
   kernel/sys_ni.c:314:1: warning: no previous prototype for function '__arm64_sys_fanotify_init' [-Wmissing-prototypes]
   COND_SYSCALL(fanotify_init);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:3:1: note: expanded from here
   __arm64_sys_fanotify_init
   ^
   kernel/sys_ni.c:314:1: note: declare 'static' if the function is not intended to be used outside of this translation unit


vim +/__arm64_sys_set_mempolicy_home_node +300 kernel/sys_ni.c

   280	
   281	/* mm/, CONFIG_MMU only */
   282	COND_SYSCALL(swapon);
   283	COND_SYSCALL(swapoff);
   284	COND_SYSCALL(mprotect);
   285	COND_SYSCALL(msync);
   286	COND_SYSCALL(mlock);
   287	COND_SYSCALL(munlock);
   288	COND_SYSCALL(mlockall);
   289	COND_SYSCALL(munlockall);
   290	COND_SYSCALL(mincore);
   291	COND_SYSCALL(madvise);
   292	COND_SYSCALL(process_madvise);
   293	COND_SYSCALL(process_mrelease);
   294	COND_SYSCALL(remap_file_pages);
   295	COND_SYSCALL(mbind);
   296	COND_SYSCALL(get_mempolicy);
   297	COND_SYSCALL(set_mempolicy);
   298	COND_SYSCALL(migrate_pages);
   299	COND_SYSCALL(move_pages);
 > 300	COND_SYSCALL(set_mempolicy_home_node);
   301	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
