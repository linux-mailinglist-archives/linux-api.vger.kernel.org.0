Return-Path: <linux-api+bounces-2729-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635A09C7172
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2024 14:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2885D28223B
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2024 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD41D88C4;
	Wed, 13 Nov 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lneoRFzP"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A7111A8;
	Wed, 13 Nov 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506010; cv=none; b=Fshbfwih0f+4et1xaIO4r26pjqhG0/6O1EtiHTWdAMFdtgqfn0Kzip5pmxv2CJfZmBeYmstNwSQYzTfTjPYm6abp5MT2ib5OUM2a/ZW7mFNIbZfwYHaZKAIl2/qVEieQdcqnnJW0GyBcf+jNJE7hTo/FF4zcFgYSiiM8qTP9Aes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506010; c=relaxed/simple;
	bh=e02wCo6/bCN5ygIPiqX/XjikMX8Gq9j4vtdOtzb6vsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yci/CMWo9W+tlc6hP/jkOcFwid5WmqHG9JiXcLpRKQ3TGXEcrdFK31hj2GAmwMvkeCJlpMx333gG9rWgR/1L/PWKMPfIc88vEUsf4Xz4TrPFPcGJo/aMG6bZzulTjhnED+B41wfrQZnJcxYgc5T7OomhQgEbOWzglw1mxRAN7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lneoRFzP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731506009; x=1763042009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e02wCo6/bCN5ygIPiqX/XjikMX8Gq9j4vtdOtzb6vsc=;
  b=lneoRFzPJO/3UTfgm3wNKUb7CMpQB/bpgVsvRF6vIs91C2gKqxHs/pEG
   hhFgrEGPLsQJ8jzzBd3X/KL3Sf2u2VWkMlN31oGhg5cYatBCbnXY9e+Il
   dWkPkCj9iHWhf3uXIhG8k1dvFm7D/2hm3QLhHL6eZL2SA6oXc5LIS+Poh
   gzwzUdyuTI99LNRkjP9PsTjkCXvBJ0rUsrLRmoOafWbFSyatcqqmnm/36
   CJinaGJl60tVEemSPQoi/SHYGDUf+49AyLI9GS27tRKxCFSb0yBhv0sC5
   PkW/I6BPyonk+s1MIikT2a1Aoaw+x7nAKw6jQfpC2WqW5cBzzXYaWRLm4
   A==;
X-CSE-ConnectionGUID: UEBN9jmVSWK1E/JTZZuIkg==
X-CSE-MsgGUID: 6Ir4oGWvRpyHRTaUi9ccjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41961109"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41961109"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 05:53:28 -0800
X-CSE-ConnectionGUID: LHGpgglRQBiIK+ZXfwC8+Q==
X-CSE-MsgGUID: f7Hfiq3BQZGpYPD5b8TPcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87869712"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Nov 2024 05:53:27 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBDoC-0000Qv-2j;
	Wed, 13 Nov 2024 13:53:24 +0000
Date: Wed, 13 Nov 2024 21:52:59 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202411132114.VB5yFmtR-lkp@intel.com>
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
config: riscv-randconfig-r112-20241113 (https://download.01.org/0day-ci/archive/20241113/202411132114.VB5yFmtR-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241113/202411132114.VB5yFmtR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411132114.VB5yFmtR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/homa/homa_sock.c:201:31: sparse: sparse: cast removes address space '__rcu' of expression
   net/homa/homa_sock.c:248:17: sparse: sparse: context imbalance in 'homa_sock_shutdown' - different lock contexts for basic block
   net/homa/homa_sock.c:303:21: sparse: sparse: context imbalance in 'homa_sock_bind' - different lock contexts for basic block

vim +/__rcu +201 net/homa/homa_sock.c

8ddf00265eb650 John Ousterhout 2024-11-11  183  
8ddf00265eb650 John Ousterhout 2024-11-11  184  /*
8ddf00265eb650 John Ousterhout 2024-11-11  185   * homa_sock_unlink() - Unlinks a socket from its socktab and does
8ddf00265eb650 John Ousterhout 2024-11-11  186   * related cleanups. Once this method returns, the socket will not be
8ddf00265eb650 John Ousterhout 2024-11-11  187   * discoverable through the socktab.
8ddf00265eb650 John Ousterhout 2024-11-11  188   */
8ddf00265eb650 John Ousterhout 2024-11-11  189  void homa_sock_unlink(struct homa_sock *hsk)
8ddf00265eb650 John Ousterhout 2024-11-11  190  {
8ddf00265eb650 John Ousterhout 2024-11-11  191  	struct homa_socktab *socktab = hsk->homa->port_map;
8ddf00265eb650 John Ousterhout 2024-11-11  192  	struct homa_socktab_scan *scan;
8ddf00265eb650 John Ousterhout 2024-11-11  193  
8ddf00265eb650 John Ousterhout 2024-11-11  194  	/* If any scans refer to this socket, advance them to refer to
8ddf00265eb650 John Ousterhout 2024-11-11  195  	 * the next socket instead.
8ddf00265eb650 John Ousterhout 2024-11-11  196  	 */
8ddf00265eb650 John Ousterhout 2024-11-11  197  	spin_lock_bh(&socktab->write_lock);
8ddf00265eb650 John Ousterhout 2024-11-11  198  	list_for_each_entry(scan, &socktab->active_scans, scan_links) {
8ddf00265eb650 John Ousterhout 2024-11-11  199  		if (!scan->next || scan->next->sock != hsk)
8ddf00265eb650 John Ousterhout 2024-11-11  200  			continue;
8ddf00265eb650 John Ousterhout 2024-11-11 @201  		scan->next = (struct homa_socktab_links *)hlist_next_rcu(&scan
8ddf00265eb650 John Ousterhout 2024-11-11  202  				->next->hash_links);
8ddf00265eb650 John Ousterhout 2024-11-11  203  	}
8ddf00265eb650 John Ousterhout 2024-11-11  204  	hlist_del_rcu(&hsk->socktab_links.hash_links);
8ddf00265eb650 John Ousterhout 2024-11-11  205  	spin_unlock_bh(&socktab->write_lock);
8ddf00265eb650 John Ousterhout 2024-11-11  206  }
8ddf00265eb650 John Ousterhout 2024-11-11  207  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

