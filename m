Return-Path: <linux-api+bounces-2714-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8249C5232
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AF51F21650
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC220E014;
	Tue, 12 Nov 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLSj/W5k"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306620E037;
	Tue, 12 Nov 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404236; cv=none; b=fneKtRTPtxYVlAE2df4tHRkklk/tOU0X9BOkKcme6NC8bCZITmJ3fjKxO8d4ApH+b1q2xU2MfxMJKFb0M0r6I+s6n7yF/436RhJkREj/XPzE7s29LcrLpQJd/IJzvDBO8dUkwWoO0y3SA298g9qlOXgOcVFd6NweOoBE6u8jmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404236; c=relaxed/simple;
	bh=sa9o6tJLuPEt4doSHckjMjO+65m1SV01OWp1P2w3aW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+YEQaIJnyc0pTbsejxIC7R0+30vEbm+ag8ThTL1Ep0RnbaIso/cY/lOh3ota87Lzc0rd2+jxV3MBGp74HMyFoXBgH6BPckbmoOvzfT/tq9z6Ai0v+wcgUdawEYyYDOGWuuID0J1FHhgF+neTZHJf8340j1EqYQEn63M3IBuHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLSj/W5k; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731404234; x=1762940234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sa9o6tJLuPEt4doSHckjMjO+65m1SV01OWp1P2w3aW4=;
  b=VLSj/W5k7/fElL3nycItnrGWqXaoOZ8oVI1H45M4FmDKperNtN4oKubx
   K5TkQFxVRQU+8ZJCAf03T1z4WR6aFiR0v4/mM16qUhRIoTi64ZDfbpgl+
   QxFfi7OyGrb22EBfU4XcQkorrHC1clzcXB0YwxAUM1L8JloiKPhQJMUNW
   ajUidJ4xwTFE+ctmPCXlvwzJaBOTfFBjbVoylq7jsshQpFU1Xm+lBHueM
   wHncv1w9RVj7Ly6y88y2W11dc/mP9PWUMeJoFx/7rvBh0v9CLh4K4dDKM
   l/afr45UKd+QHL7fcSXKRIBuL4eDOQRemkov7RwX9hh1g7nB5bls5Gadd
   Q==;
X-CSE-ConnectionGUID: EzFgIMUNRC6AjbYnlEYJ1g==
X-CSE-MsgGUID: JDBNkEA2RWKGKBxRKRrdaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31324309"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="31324309"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:37:11 -0800
X-CSE-ConnectionGUID: T4p8b4V4QAKl0jAGQaorIg==
X-CSE-MsgGUID: q7Kel42VRcGmmOcxnFcM1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87726525"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2024 01:37:11 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAnKd-0000fn-2G;
	Tue, 12 Nov 2024 09:37:07 +0000
Date: Tue, 12 Nov 2024 17:36:44 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202411121722.Oxq727h0-lkp@intel.com>
References: <20241111234006.5942-13-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234006.5942-13-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20241112-074535
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241111234006.5942-13-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20241112/202411121722.Oxq727h0-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121722.Oxq727h0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121722.Oxq727h0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/mips/include/asm/div64.h:89,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:6,
                    from ./arch/mips/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/audit.h:12,
                    from net/homa/homa_impl.h:12,
                    from net/homa/homa_outgoing.c:7:
   net/homa/homa_outgoing.c: In function 'homa_new_data_packet':
>> include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   net/homa/homa_outgoing.c:108:9: note: in expansion of macro 'do_div'
     108 |         do_div(segs, max_seg_data);
         |         ^~~~~~
   In file included from arch/mips/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from net/homa/homa_impl.h:10:
>> include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   net/homa/homa_outgoing.c:108:9: note: in expansion of macro 'do_div'
     108 |         do_div(segs, max_seg_data);
         |         ^~~~~~
   net/homa/homa_outgoing.c: In function 'homa_message_out_fill':
>> include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   net/homa/homa_outgoing.c:233:9: note: in expansion of macro 'do_div'
     233 |         do_div(segs_per_gso, max_seg_data);
         |         ^~~~~~
>> include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   net/homa/homa_outgoing.c:233:9: note: in expansion of macro 'do_div'
     233 |         do_div(segs_per_gso, max_seg_data);
         |         ^~~~~~


vim +222 include/asm-generic/div64.h

^1da177e4c3f41 Linus Torvalds     2005-04-16  215  
^1da177e4c3f41 Linus Torvalds     2005-04-16  216  /* The unnecessary pointer compare is there
^1da177e4c3f41 Linus Torvalds     2005-04-16  217   * to check for type safety (n must be 64bit)
^1da177e4c3f41 Linus Torvalds     2005-04-16  218   */
^1da177e4c3f41 Linus Torvalds     2005-04-16  219  # define do_div(n,base) ({				\
^1da177e4c3f41 Linus Torvalds     2005-04-16  220  	uint32_t __base = (base);			\
^1da177e4c3f41 Linus Torvalds     2005-04-16  221  	uint32_t __rem;					\
^1da177e4c3f41 Linus Torvalds     2005-04-16 @222  	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  223  	if (__builtin_constant_p(__base) &&		\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  224  	    is_power_of_2(__base)) {			\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  225  		__rem = (n) & (__base - 1);		\
911918aa7ef6f8 Nicolas Pitre      2015-11-02  226  		(n) >>= ilog2(__base);			\
c747ce4706190e Geert Uytterhoeven 2021-08-11  227  	} else if (__builtin_constant_p(__base) &&	\
461a5e51060c93 Nicolas Pitre      2015-10-30  228  		   __base != 0) {			\
461a5e51060c93 Nicolas Pitre      2015-10-30  229  		uint32_t __res_lo, __n_lo = (n);	\
461a5e51060c93 Nicolas Pitre      2015-10-30  230  		(n) = __div64_const32(n, __base);	\
461a5e51060c93 Nicolas Pitre      2015-10-30  231  		/* the remainder can be computed with 32-bit regs */ \
461a5e51060c93 Nicolas Pitre      2015-10-30  232  		__res_lo = (n);				\
461a5e51060c93 Nicolas Pitre      2015-10-30  233  		__rem = __n_lo - __res_lo * __base;	\
911918aa7ef6f8 Nicolas Pitre      2015-11-02 @234  	} else if (likely(((n) >> 32) == 0)) {		\
^1da177e4c3f41 Linus Torvalds     2005-04-16  235  		__rem = (uint32_t)(n) % __base;		\
^1da177e4c3f41 Linus Torvalds     2005-04-16  236  		(n) = (uint32_t)(n) / __base;		\
c747ce4706190e Geert Uytterhoeven 2021-08-11  237  	} else {					\
^1da177e4c3f41 Linus Torvalds     2005-04-16  238  		__rem = __div64_32(&(n), __base);	\
c747ce4706190e Geert Uytterhoeven 2021-08-11  239  	}						\
^1da177e4c3f41 Linus Torvalds     2005-04-16  240  	__rem;						\
^1da177e4c3f41 Linus Torvalds     2005-04-16  241   })
^1da177e4c3f41 Linus Torvalds     2005-04-16  242  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

