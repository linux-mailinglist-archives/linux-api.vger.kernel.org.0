Return-Path: <linux-api+bounces-2326-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB5983B7D
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 05:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA37B21B16
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 03:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2D17C91;
	Tue, 24 Sep 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcEC5Wqy"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002A1B85FA;
	Tue, 24 Sep 2024 03:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727147763; cv=none; b=Aou1FJ6K72WmC/ne94CT0EcHhlDoke6eAtbGO9iFVkPew0PFRIa/MTR+Plz1+9Y/Ndi0qZ2bLB8xXSaL+8j+KAb3SALH6pylaQv0Q0ZZEGFQ/0gLWb0FJtLpSCW8iG7nkzVTDdiQsW+PV4chT2SLuztlOLwyrQIBN39iL9WEGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727147763; c=relaxed/simple;
	bh=dO2hQgM5HLKyuiR7VUZ4brd4nSGoDAhmjyz/emJAvDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B11vZ/YiI69qKLsAToLDxJ5mf9I424e/vG3eHBDkAmq2sZdJAHHNSAk1+yF8Oh+cHnsIGAmjSzWrgekYAWJU1V+NMNA4Wkg8JwMzAUtXQIj7i4iwzTSN5ZFjqL80Iy1Gs7/f74dUFlhebK4BWbIzR2N9oua7+Lzol/gXEv128DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcEC5Wqy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727147761; x=1758683761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dO2hQgM5HLKyuiR7VUZ4brd4nSGoDAhmjyz/emJAvDE=;
  b=YcEC5Wqy3dgXeD8zFdDwTdh29iNb1uqm7s9UjNLgUZCHxDzo6P3DQnBU
   sKlbb4qQdEpok1IST47/5PcUlX+I8/zCgpCw3cdHdBBi4FBLWmdBeAXhm
   kMIiVVCPKIjYwkhHlqms8yB//4vSJT/eDhsFNLx0LGjWMzFwfrUDmaohI
   5gDDMbeeIbV0f9uZEoF8Nv3TBKc6B7L1DZv67qU6VhtB76bByf8BvNyEM
   vAIuaWjkfmuf5qJfUgNpQBxM6Zru/j0m+hJOdWqZbxNCdHVLuKDkY2mxU
   FzDYNFshxGxHfh2NfxxUo5rv5pFtf+0rHMXtF9s1lZrE96Ag/pV9C8eyw
   A==;
X-CSE-ConnectionGUID: v8kH9xLlSbq3WcOvr4x7FA==
X-CSE-MsgGUID: TmQbRsxiSaKEoK5sRQHF9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29838269"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="29838269"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 20:16:01 -0700
X-CSE-ConnectionGUID: XfdfgSgxRzexW0dJHeoqtA==
X-CSE-MsgGUID: 20Bcb4OISlWsptH0jrQ11Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="71272988"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 Sep 2024 20:15:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssw1r-000HrX-1p;
	Tue, 24 Sep 2024 03:15:55 +0000
Date: Tue, 24 Sep 2024 11:15:17 +0800
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
Message-ID: <202409241034.6ilzMh4w-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on soc/for-next linus/master v6.11 next-20240923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-madvise-introduce-PR_MADV_SELF-flag-to-process_madvise/20240924-000845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
config: mips-ip32_defconfig (https://download.01.org/0day-ci/archive/20240924/202409241034.6ilzMh4w-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409241034.6ilzMh4w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409241034.6ilzMh4w-lkp@intel.com/

All errors (new ones prefixed by >>):

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
>> mm/madvise.c:1514:15: error: use of undeclared identifier 'PR_MADV_SELF'
    1514 |         if (flags & ~PR_MADV_SELF) {
         |                      ^
   mm/madvise.c:1527:14: error: use of undeclared identifier 'PR_MADV_SELF'
    1527 |         if (flags & PR_MADV_SELF) {
         |                     ^
   3 warnings and 2 errors generated.


vim +/PR_MADV_SELF +1514 mm/madvise.c

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
> 1514		if (flags & ~PR_MADV_SELF) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

