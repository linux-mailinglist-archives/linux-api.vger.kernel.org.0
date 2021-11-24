Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13D45CC38
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 19:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhKXSlG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 13:41:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:36449 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350749AbhKXSlC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 24 Nov 2021 13:41:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="232839548"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="232839548"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 10:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="554336169"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2021 10:36:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpx8c-0005CQ-Is; Wed, 24 Nov 2021 18:36:58 +0000
Date:   Thu, 25 Nov 2021 02:36:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <202111250209.9dBNZjdP-lkp@intel.com>
References: <20211122211327.5931-4-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122211327.5931-4-posk@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on cb0e52b7748737b2cf6481fdd9b920ce7e1ebbdf]

url:    https://github.com/0day-ci/linux/commits/Peter-Oskolkov/sched-mm-x86-uaccess-implement-User-Managed-Concurrency-Groups/20211123-051525
base:   cb0e52b7748737b2cf6481fdd9b920ce7e1ebbdf
config: arm64-randconfig-r031-20211124 (https://download.01.org/0day-ci/archive/20211125/202111250209.9dBNZjdP-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/942655474fa2cd59ea3d11a1cc03775dd79a508e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Peter-Oskolkov/sched-mm-x86-uaccess-implement-User-Managed-Concurrency-Groups/20211123-051525
        git checkout 942655474fa2cd59ea3d11a1cc03775dd79a508e
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:34:1: note: expanded from here
   __arm64_sys_recvmsg
   ^
   kernel/sys_ni.c:257:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:263:1: warning: no previous prototype for function '__arm64_sys_mremap' [-Wmissing-prototypes]
   COND_SYSCALL(mremap);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:39:1: note: expanded from here
   __arm64_sys_mremap
   ^
   kernel/sys_ni.c:263:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:266:1: warning: no previous prototype for function '__arm64_sys_add_key' [-Wmissing-prototypes]
   COND_SYSCALL(add_key);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:40:1: note: expanded from here
   __arm64_sys_add_key
   ^
   kernel/sys_ni.c:266:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:267:1: warning: no previous prototype for function '__arm64_sys_request_key' [-Wmissing-prototypes]
   COND_SYSCALL(request_key);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:41:1: note: expanded from here
   __arm64_sys_request_key
   ^
   kernel/sys_ni.c:267:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:268:1: warning: no previous prototype for function '__arm64_sys_keyctl' [-Wmissing-prototypes]
   COND_SYSCALL(keyctl);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:42:1: note: expanded from here
   __arm64_sys_keyctl
   ^
   kernel/sys_ni.c:268:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:272:1: warning: no previous prototype for function '__arm64_sys_landlock_create_ruleset' [-Wmissing-prototypes]
   COND_SYSCALL(landlock_create_ruleset);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:47:1: note: expanded from here
   __arm64_sys_landlock_create_ruleset
   ^
   kernel/sys_ni.c:272:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:273:1: warning: no previous prototype for function '__arm64_sys_landlock_add_rule' [-Wmissing-prototypes]
   COND_SYSCALL(landlock_add_rule);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:48:1: note: expanded from here
   __arm64_sys_landlock_add_rule
   ^
   kernel/sys_ni.c:273:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:274:1: warning: no previous prototype for function '__arm64_sys_landlock_restrict_self' [-Wmissing-prototypes]
   COND_SYSCALL(landlock_restrict_self);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:49:1: note: expanded from here
   __arm64_sys_landlock_restrict_self
   ^
   kernel/sys_ni.c:274:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
>> kernel/sys_ni.c:277:1: warning: no previous prototype for function '__arm64_sys_umcg_ctl' [-Wmissing-prototypes]
   COND_SYSCALL(umcg_ctl);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:50:1: note: expanded from here
   __arm64_sys_umcg_ctl
   ^
   kernel/sys_ni.c:277:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
>> kernel/sys_ni.c:278:1: warning: no previous prototype for function '__arm64_sys_umcg_wait' [-Wmissing-prototypes]
   COND_SYSCALL(umcg_wait);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:51:1: note: expanded from here
   __arm64_sys_umcg_wait
   ^
   kernel/sys_ni.c:278:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:283:1: warning: no previous prototype for function '__arm64_sys_fadvise64_64' [-Wmissing-prototypes]
   COND_SYSCALL(fadvise64_64);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:52:1: note: expanded from here
   __arm64_sys_fadvise64_64
   ^
   kernel/sys_ni.c:283:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:286:1: warning: no previous prototype for function '__arm64_sys_swapon' [-Wmissing-prototypes]
   COND_SYSCALL(swapon);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:53:1: note: expanded from here
   __arm64_sys_swapon
   ^
   kernel/sys_ni.c:286:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:287:1: warning: no previous prototype for function '__arm64_sys_swapoff' [-Wmissing-prototypes]
   COND_SYSCALL(swapoff);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:54:1: note: expanded from here
   __arm64_sys_swapoff
   ^
   kernel/sys_ni.c:287:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:288:1: warning: no previous prototype for function '__arm64_sys_mprotect' [-Wmissing-prototypes]
   COND_SYSCALL(mprotect);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:55:1: note: expanded from here
   __arm64_sys_mprotect
   ^
   kernel/sys_ni.c:288:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:289:1: warning: no previous prototype for function '__arm64_sys_msync' [-Wmissing-prototypes]
   COND_SYSCALL(msync);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:56:1: note: expanded from here
   __arm64_sys_msync
   ^
   kernel/sys_ni.c:289:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:290:1: warning: no previous prototype for function '__arm64_sys_mlock' [-Wmissing-prototypes]
   COND_SYSCALL(mlock);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:57:1: note: expanded from here
   __arm64_sys_mlock
   ^
   kernel/sys_ni.c:290:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                      ^
   kernel/sys_ni.c:291:1: warning: no previous prototype for function '__arm64_sys_munlock' [-Wmissing-prototypes]
   COND_SYSCALL(munlock);
   ^
   arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
           asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
                                  ^
   <scratch space>:58:1: note: expanded from here
   __arm64_sys_munlock
   ^
   kernel/sys_ni.c:291:1: note: declare 'static' if the function is not intended to be used outside of this translation unit


vim +/__arm64_sys_umcg_ctl +277 kernel/sys_ni.c

   275	
   276	/* kernel/sched/umcg.c */
 > 277	COND_SYSCALL(umcg_ctl);
 > 278	COND_SYSCALL(umcg_wait);
   279	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
