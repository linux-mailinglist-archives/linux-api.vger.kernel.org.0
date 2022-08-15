Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB305927C0
	for <lists+linux-api@lfdr.de>; Mon, 15 Aug 2022 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiHOCYc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Aug 2022 22:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHOCYb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Aug 2022 22:24:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB401180E
        for <linux-api@vger.kernel.org>; Sun, 14 Aug 2022 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660530270; x=1692066270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15akVnLmqGB2LRmtpYXPewEWH5UBdRqrgqSU2eW3ORg=;
  b=mejxYFAPFkCgFszE1gmG9AjqOQ/ADHgYHUq3Zn/VsjgsFvRj98O2JyP3
   qPRXcZvgZtpuTvqFUgy4yMWkm9Zldt09S3f5Hfi2zgGk9yHUa69lnlTac
   hVg19+XQTsD1C8vsu0OVdNnOfRq+gs3RNHOaDAlxqlA2zlm4a0mYOK9Lg
   WkeMslqAUEoHHH2o5msACWCetJLgvVE4aAVewhjqQz8bDzd2g5vaGHbcZ
   GFsu95fW6hr69ZITiFpYVBDoLNdxoybEcCYLULqeUmE8y9mrbScPrjLZd
   gpR78csarg/eL3C3P/lk+0wPTqJZDL7KvXiFGG3kPBJXPB5Mrg/HDAMmw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="278833188"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="278833188"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="606507615"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2022 19:24:25 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNPmC-0000iM-1R;
        Mon, 15 Aug 2022 02:24:24 +0000
Date:   Mon, 15 Aug 2022 10:23:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Zach O'Keefe <zokeefe@google.com>
Subject: Re: [PATCH mm-unstable 3/9] mm/madvise: add file and shmem support
 to MADV_COLLAPSE
Message-ID: <202208151032.dIQzLJma-lkp@intel.com>
References: <20220812012843.3948330-4-zokeefe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812012843.3948330-4-zokeefe@google.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Zach,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Zach-O-Keefe/mm-add-file-shmem-support-to-MADV_COLLAPSE/20220812-093122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: hexagon-randconfig-r045-20220812 (https://download.01.org/0day-ci/archive/20220815/202208151032.dIQzLJma-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dff08746d6f7b9387b94360b66bd9db644542991
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zach-O-Keefe/mm-add-file-shmem-support-to-MADV_COLLAPSE/20220812-093122
        git checkout dff08746d6f7b9387b94360b66bd9db644542991
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/fork.c:86:
>> include/linux/khugepaged.h:53:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   kernel/fork.c:163:13: warning: no previous prototype for function 'arch_release_task_struct' [-Wmissing-prototypes]
   void __weak arch_release_task_struct(struct task_struct *tsk)
               ^
   kernel/fork.c:163:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak arch_release_task_struct(struct task_struct *tsk)
   ^
   static 
   kernel/fork.c:852:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:852:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
   kernel/fork.c:947:12: warning: no previous prototype for function 'arch_dup_task_struct' [-Wmissing-prototypes]
   int __weak arch_dup_task_struct(struct task_struct *dst,
              ^
   kernel/fork.c:947:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak arch_dup_task_struct(struct task_struct *dst,
   ^
   static 
   3 warnings and 1 error generated.
--
   In file included from mm/mmap.c:40:
>> include/linux/khugepaged.h:53:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
   }
   ^
   1 error generated.


vim +53 include/linux/khugepaged.h

ba76149f47d8c9 Andrea Arcangeli  2011-01-13  33  
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  34  static inline void khugepaged_exit(struct mm_struct *mm)
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  35  {
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  36  	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  37  		__khugepaged_exit(mm);
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  38  }
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  39  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
d2081b2bf8195b Yang Shi          2022-05-19  40  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  41  {
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  42  }
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  43  static inline void khugepaged_exit(struct mm_struct *mm)
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  44  {
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  45  }
c791576c60288c Yang Shi          2022-05-19  46  static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
6d50e60cd2edb5 David Rientjes    2014-10-29  47  					unsigned long vm_flags)
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  48  {
ba76149f47d8c9 Andrea Arcangeli  2011-01-13  49  }
dff08746d6f7b9 Zach O'Keefe      2022-08-11  50  static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
dff08746d6f7b9 Zach O'Keefe      2022-08-11  51  					  unsigned long addr, bool install_pmd)
27e1f8273113ad Song Liu          2019-09-23  52  {
27e1f8273113ad Song Liu          2019-09-23 @53  }
4aab2be0983031 Vijay Balakrishna 2020-10-10  54  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
