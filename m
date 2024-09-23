Return-Path: <linux-api+bounces-2324-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96A98391C
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 23:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EBB282B1B
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883078C90;
	Mon, 23 Sep 2024 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+JOV1PR"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3C1EB36;
	Mon, 23 Sep 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727127070; cv=none; b=B1aaWggJDpddJSAJyFOLJD98c2bDnvsIE8znR+DzNpF3s9mCYNByaEAFBRTrfmYU4bQipSqO9I2gtk75wyuYrJnJnrd2h/1wkR1/Zmooz3VY0ke3N4DEMa7aSurHZuNX65Gx3HnP37jZr/YJTYcF2ulgr2GBZ6NMxi/4vS6T9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727127070; c=relaxed/simple;
	bh=QTekxfaNaN8IG6PteUiDDFC8Jb8wzI+6h9p2OTkA0iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNVPw99vQIBjKJ3uR1jDjsyb94+/nCj2y0JnfvvaSWHcVewYy96zksCjcIcY5ANP59OJPZyMDHSUCrLyPKcpgaB2RcPf8D+ixG00Ani6XLcpe9B+ULWznLG/Z1QY54AJRZmu7tKUdpqTLQ7zDLe87UektDNzyc6cx/gMllFNbXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+JOV1PR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727127069; x=1758663069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QTekxfaNaN8IG6PteUiDDFC8Jb8wzI+6h9p2OTkA0iE=;
  b=J+JOV1PRw+iEmHijG/H7ZRUBnkqpzW5pL3A00meqHPgCoX6gGEUaFnUh
   2Y9Gq0nugYPo9NrCOsbtVSsTmlYGD0kg4NcVW7OysFsktJzBDNQAb0zZz
   6o4SnuPtmYi/Bc0RjcZB7NyhHPb40meEmNsF6phDTzFGuE0MxC3y7aTTq
   rwpsEcfz7uz9QLLQKDpu753kfpwa6741pX0hEEh4Ww1NvvlKonkBQJ6b1
   Rt66yKs/BW18djh7Cbs1dA7CfeDPT+vNxbQfdYokEY79do0R4Nl4DsPcp
   ehKIRNxe+JQ9hBLuhAPeyxmp9KL7prUMi3FcgfyU2I7woa6wh+HVfzD+q
   w==;
X-CSE-ConnectionGUID: VtR71Sf8TQeEFPecHKbJbw==
X-CSE-MsgGUID: QBcWKXEDTa6RSQ2/aKOaqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="37233479"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="37233479"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:31:08 -0700
X-CSE-ConnectionGUID: tG/6mynYT6yslR9lqNynDA==
X-CSE-MsgGUID: 4MwurWLkQs6iflw9/6WQSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="76121064"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Sep 2024 14:30:45 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssqdm-000HcP-1a;
	Mon, 23 Sep 2024 21:30:42 +0000
Date: Tue, 24 Sep 2024 05:30:35 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <202409240556.LgM8vOIF-lkp@intel.com>
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
[also build test ERROR on arnd-asm-generic/master soc/for-next linus/master v6.11 next-20240923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-madvise-introduce-PR_MADV_SELF-flag-to-process_madvise/20240924-000845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
config: parisc-allnoconfig (https://download.01.org/0day-ci/archive/20240924/202409240556.LgM8vOIF-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240556.LgM8vOIF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240556.LgM8vOIF-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/madvise.c: In function '__do_sys_process_madvise':
>> mm/madvise.c:1514:22: error: 'PR_MADV_SELF' undeclared (first use in this function)
    1514 |         if (flags & ~PR_MADV_SELF) {
         |                      ^~~~~~~~~~~~
   mm/madvise.c:1514:22: note: each undeclared identifier is reported only once for each function it appears in


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

