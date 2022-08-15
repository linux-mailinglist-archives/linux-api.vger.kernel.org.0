Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0592592920
	for <lists+linux-api@lfdr.de>; Mon, 15 Aug 2022 07:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiHOFlh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Aug 2022 01:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHOFlg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Aug 2022 01:41:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E7C14081
        for <linux-api@vger.kernel.org>; Sun, 14 Aug 2022 22:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660542094; x=1692078094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2uWyyHRSzgByKXaC+wjLJswLcAS9PxLK4BBhJ8umn8=;
  b=nYE/n8d18yrxyL/1a3rUxRalfmEHv8tCN+dzJQcSrqj8EF0Ss2i3F7aD
   ANnLGBv5gm+05Gl1TZeDthavv6rWl7duxY85pi6xYM0FWiVh2hl7wJNRT
   F6FWueHT4ee7nJWSaocs7sZRSxO6HHOpflosKo1SnKdCjr0Axtj5viIko
   ol8F1meBZ6iYthsJ6+zQGUmcdmfvRin0f1Z0vAOUsIfMT5V7GXfTxf4la
   ZZfRFeWAr8qMBxuP3RFDEE76vIGW+sJTVlLCQZWA5gU0a7b5xUa03eUUk
   WzlpnewE+n8T8rIUpf3cuAcSaej4UD4/DR4JpAV+VSl6pW8zrBkhFs42I
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="378183309"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="378183309"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 22:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="639536842"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2022 22:41:28 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNSqu-0000oz-0t;
        Mon, 15 Aug 2022 05:41:28 +0000
Date:   Mon, 15 Aug 2022 13:41:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <202208151331.uxreCJWj-lkp@intel.com>
References: <20220812012843.3948330-4-zokeefe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812012843.3948330-4-zokeefe@google.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220815/202208151331.uxreCJWj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/dff08746d6f7b9387b94360b66bd9db644542991
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zach-O-Keefe/mm-add-file-shmem-support-to-MADV_COLLAPSE/20220812-093122
        git checkout dff08746d6f7b9387b94360b66bd9db644542991
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/khugepaged.c: In function 'set_huge_pmd':
>> mm/khugepaged.c:1403:13: error: assignment of read-only variable 'vmf'
    1403 |         vmf = (struct vm_fault) {
         |             ^


vim +/vmf +1403 mm/khugepaged.c

  1393	
  1394	/* hpage must be locked, and mmap_lock must be held in write */
  1395	static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
  1396				pmd_t *pmdp, struct page *hpage)
  1397	{
  1398		struct vm_fault vmf;
  1399	
  1400		VM_BUG_ON(!PageTransHuge(hpage));
  1401		mmap_assert_write_locked(vma->vm_mm);
  1402	
> 1403		vmf = (struct vm_fault) {
  1404			.vma = vma,
  1405			.address = addr,
  1406			.flags = 0,
  1407			.pmd = pmdp,
  1408		};
  1409	
  1410		if (do_set_pmd(&vmf, hpage))
  1411			return SCAN_FAIL;
  1412	
  1413		get_page(hpage);
  1414		return SCAN_SUCCEED;
  1415	}
  1416	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
