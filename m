Return-Path: <linux-api+bounces-2323-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74918983905
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 23:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AE71F21FA2
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B878C73;
	Mon, 23 Sep 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw6ZEc3X"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEC6F2F2;
	Mon, 23 Sep 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126449; cv=none; b=VUHy+mNZ8cl5qiGJ2FthN6tDwdqkRCUN+MGtcnhYkBcIzJRIzq1ao0LBoY56mIjMjrtk74Na7J/0fzXg0okkG6MMsayMqG3imh4oyOReizGezTUHIJzVfi0Zk6ElVICChq0KHIAff7qiZV436IMPOcaX4uC8mXsxz6IF1e1pc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126449; c=relaxed/simple;
	bh=g9Gn/k5nAmV0T3ltzIzfRoQS02lQFtIevg5gw5zHPS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb5I/0UB1hIr4g3SGa8+a0DGPoLWNC1OitlktJZkWdaXb799KXOEQyZ89TIfzQbAsNKC4GnxhR68v/q17vTrEje6FvtkQLIgpSdiVeNH0tUP1tbV80O/nSzJ+15EF8F+2zAjJT1H801s2umBEiNo5QVubfdQmckfcirYaMQCUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw6ZEc3X; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727126448; x=1758662448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g9Gn/k5nAmV0T3ltzIzfRoQS02lQFtIevg5gw5zHPS4=;
  b=iw6ZEc3XJZT0r36yr6sIZwelLGIsWetaHrozbqaGpXNUXO0xN8gZSHw7
   N7qXzuJtYf7/Kt+Q3JneIcd2qf3PpqEgijAsjMu9FYWRseuwxcYb4BfDP
   PRFreAdnRwsy5Hg7u9D3Qh17U3yPLU5H6tTeIG+mtZSsgx5WlNWKR3Z0s
   34YTxZZCYDdNc7HpdxNQQD9IaMcoC25r5FiW+EfUhXifkR1EMH5k+fP8F
   TFnYjXMDS8zYiGEY2z6HsXcJWqL23MxPF9tQXaLbka2xVKlwvIX3KTmxW
   c/Z8703mwu5SGgr/79aZz+OunzYCcXx0yOpIJRpKtEIFqiKup5VaO3Jrf
   Q==;
X-CSE-ConnectionGUID: HKW7dPrKRBeNL71NbZpRFw==
X-CSE-MsgGUID: sak7jN3SRMCiD8AyQ2Q8mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37232595"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="37232595"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:20:48 -0700
X-CSE-ConnectionGUID: tcq1DjOCT7+gQupATco5bA==
X-CSE-MsgGUID: NTejMPhtRVKRkllcsULNGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="70779408"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2024 14:20:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssqU6-000Hc1-0u;
	Mon, 23 Sep 2024 21:20:42 +0000
Date: Tue, 24 Sep 2024 05:20:21 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <202409240527.pAgR35QJ-lkp@intel.com>
References: <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on arnd-asm-generic/master soc/for-next linus/master v6.11 next-20240923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-madvise-introduce-PR_MADV_SELF-flag-to-process_madvise/20240924-000845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
config: arm-aspeed_g4_defconfig (https://download.01.org/0day-ci/archive/20240924/202409240527.pAgR35QJ-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240527.pAgR35QJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240527.pAgR35QJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/madvise.c:9:
   In file included from include/linux/mman.h:5:
   In file included from include/linux/mm.h:2198:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/madvise.c:21:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/madvise.c:1542:6: warning: variable 'mm' is uninitialized when used here [-Wuninitialized]
    1542 |         if (mm != current->mm && !process_madvise_remote_valid(behavior)) {
         |             ^~
   mm/madvise.c:1511:22: note: initialize the variable 'mm' to silence this warning
    1511 |         struct mm_struct *mm;
         |                             ^
         |                              = NULL
   4 warnings generated.


vim +/mm +1542 mm/madvise.c

  1502	
  1503	SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
  1504			size_t, vlen, int, behavior, unsigned int, flags)
  1505	{
  1506		ssize_t ret;
  1507		struct iovec iovstack[UIO_FASTIOV];
  1508		struct iovec *iov = iovstack;
  1509		struct iov_iter iter;
  1510		struct task_struct *task;
  1511		struct mm_struct *mm;
  1512		unsigned int f_flags;
  1513	
  1514		if (flags & ~PR_MADV_SELF) {
  1515			ret = -EINVAL;
  1516			goto out;
  1517		}
  1518	
  1519		ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
  1520		if (ret < 0)
  1521			goto out;
  1522	
  1523		/*
  1524		 * Perform an madvise operation on the current process. No restrictions
  1525		 * need be applied, nor do we need to pin the task or mm_struct.
  1526		 */
  1527		if (flags & PR_MADV_SELF) {
  1528			ret = vector_madvise(current->mm, &iter, behavior);
  1529			goto free_iov;
  1530		}
  1531	
  1532		task = pidfd_get_task(pidfd, &f_flags);
  1533		if (IS_ERR(task)) {
  1534			ret = PTR_ERR(task);
  1535			goto free_iov;
  1536		}
  1537	
  1538		/*
  1539		 * We need only perform this check if we are attempting to manipulate a
  1540		 * remote process's address space.
  1541		 */
> 1542		if (mm != current->mm && !process_madvise_remote_valid(behavior)) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

