Return-Path: <linux-api+bounces-2713-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1158C9C5237
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 10:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C893AB22367
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5513E20E022;
	Tue, 12 Nov 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeNE8Amt"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2120DD64;
	Tue, 12 Nov 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404234; cv=none; b=hSO78rmOiG2E6i70SPOFJBZndgImKJs7JPxk4PcLmqwtWT3Anu/h7xBW/+k9qfubSL7prrDG7xcJSVpqNIv8CaQ3Zrlgjib9238tRZ2Yb88OH+nu1iKFns4YM+TfjaiTQ/GfXXBuQgWCI8Lrlnc8GS9G7Kb26OQjalGGlPz2Z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404234; c=relaxed/simple;
	bh=BG88lmT+d3ZawoP/5WJSguMy0D/EvYsOfiqns+IETtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duuZPOFZlbo1a195nxMfHdQuGxcGiIcUOIbj9CMkmcdHsZ9Qv+Q8Xe29njfHpwDCg2jUBt7WrTo0bc/3ZaMwFZTdwKjMze1RR4IvyIx7Mwi86kkow2udYn0IsT7OA6o6wXseo9djONzs2up0ZKMBy9xEOzM1YVaGXZLDhB6TWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeNE8Amt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731404232; x=1762940232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BG88lmT+d3ZawoP/5WJSguMy0D/EvYsOfiqns+IETtQ=;
  b=ZeNE8AmtlxUTcbbIuntoyNlm6QCWvm775vjzy66B022FnqSYGOnCJI0y
   cSMfpXOC2i+7tbGAAWIWoRtuLKSKviK0ezQs5egD797ph2ZaKkmdsc7PW
   XOTQEWcFE3uSqvfnOzT95i6lJ775mQUfiK17cZkPcEEu/n+0KyYjQoPGy
   fg4w4sJy1XIn1Ftbcbf14Zwazwg6ecVGhuHMvMKV61ekse7LyMS8H6p3b
   BQ3QRzHn131U7/+yp/rFrb8wtQpi+BIyGgkX0/riNa7NhiQ+BNbuUxvHc
   FzJVfcM5w9pkSGz3AxXVMyNdjtPeG9dZhPJG69pBbRLLQWh7e2/+h9VWK
   g==;
X-CSE-ConnectionGUID: cAHj36bMRACd6DFTxDTvnw==
X-CSE-MsgGUID: h5go18ZWRxebnTmETQafGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31324306"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="31324306"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:37:11 -0800
X-CSE-ConnectionGUID: uznwFk1lQj6Hj/ss8jzqjw==
X-CSE-MsgGUID: FrAaMaVFR46Dsllk7XcSsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87726523"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Nov 2024 01:37:10 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAnKd-0000fj-23;
	Tue, 12 Nov 2024 09:37:07 +0000
Date: Tue, 12 Nov 2024 17:36:43 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202411121707.Uash8uoM-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20241112-074535
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241111234006.5942-13-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20241112/202411121707.Uash8uoM-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121707.Uash8uoM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121707.Uash8uoM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/openrisc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/sched.h:2145,
                    from include/linux/audit.h:12,
                    from net/homa/homa_impl.h:12,
                    from net/homa/homa_outgoing.c:7:
   net/homa/homa_outgoing.c: In function 'homa_new_data_packet':
   include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   net/homa/homa_outgoing.c:108:9: note: in expansion of macro 'do_div'
     108 |         do_div(segs, max_seg_data);
         |         ^~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/openrisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from net/homa/homa_impl.h:10:
   include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   net/homa/homa_outgoing.c:108:9: note: in expansion of macro 'do_div'
     108 |         do_div(segs, max_seg_data);
         |         ^~~~~~
>> include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    int *
   net/homa/homa_outgoing.c:108:9: note: in expansion of macro 'do_div'
     108 |         do_div(segs, max_seg_data);
         |         ^~~~~~
   include/asm-generic/div64.h:213:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'int *'
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~
   net/homa/homa_outgoing.c: In function 'homa_message_out_fill':
   include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^~
   net/homa/homa_outgoing.c:233:9: note: in expansion of macro 'do_div'
     233 |         do_div(segs_per_gso, max_seg_data);
         |         ^~~~~~
   include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   net/homa/homa_outgoing.c:233:9: note: in expansion of macro 'do_div'
     233 |         do_div(segs_per_gso, max_seg_data);
         |         ^~~~~~
>> include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
         |                                    |
         |                                    int *
   net/homa/homa_outgoing.c:233:9: note: in expansion of macro 'do_div'
     233 |         do_div(segs_per_gso, max_seg_data);
         |         ^~~~~~
   include/asm-generic/div64.h:213:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'int *'
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                            ~~~~~~~~~~^~~~~~~~


vim +/__div64_32 +238 include/asm-generic/div64.h

^1da177e4c3f41 Linus Torvalds     2005-04-16  215  
^1da177e4c3f41 Linus Torvalds     2005-04-16  216  /* The unnecessary pointer compare is there
^1da177e4c3f41 Linus Torvalds     2005-04-16  217   * to check for type safety (n must be 64bit)
^1da177e4c3f41 Linus Torvalds     2005-04-16  218   */
^1da177e4c3f41 Linus Torvalds     2005-04-16  219  # define do_div(n,base) ({				\
^1da177e4c3f41 Linus Torvalds     2005-04-16  220  	uint32_t __base = (base);			\
^1da177e4c3f41 Linus Torvalds     2005-04-16  221  	uint32_t __rem;					\
^1da177e4c3f41 Linus Torvalds     2005-04-16  222  	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
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
911918aa7ef6f8 Nicolas Pitre      2015-11-02  234  	} else if (likely(((n) >> 32) == 0)) {		\
^1da177e4c3f41 Linus Torvalds     2005-04-16  235  		__rem = (uint32_t)(n) % __base;		\
^1da177e4c3f41 Linus Torvalds     2005-04-16  236  		(n) = (uint32_t)(n) / __base;		\
c747ce4706190e Geert Uytterhoeven 2021-08-11  237  	} else {					\
^1da177e4c3f41 Linus Torvalds     2005-04-16 @238  		__rem = __div64_32(&(n), __base);	\
c747ce4706190e Geert Uytterhoeven 2021-08-11  239  	}						\
^1da177e4c3f41 Linus Torvalds     2005-04-16  240  	__rem;						\
^1da177e4c3f41 Linus Torvalds     2005-04-16  241   })
^1da177e4c3f41 Linus Torvalds     2005-04-16  242  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

