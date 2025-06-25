Return-Path: <linux-api+bounces-3985-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A169AE73E7
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 02:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C000717E722
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 00:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88227D07D;
	Wed, 25 Jun 2025 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qolb9x/4"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEA72634;
	Wed, 25 Jun 2025 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750812150; cv=none; b=Jnqgsls5U7zQpYZI5IGOIkEyglTSKAjjZ2U54mstcinoqdXJRWi4jlyRRUzE+k9rORCw91rhzIH3GvuvQr7w3NQU5cJFc/BCT6lrf1KLXE5xAR8BHd838lIk+kr93+eY0KPKU+N2kL0pCfhxGKmuiuuMtfJgnmMKvf0KSuC9tGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750812150; c=relaxed/simple;
	bh=sU2bp2FhksrcqHMdvPNPlXXnoiA4d9/n8fR2mCs2TO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6OMCwb6e+oyT/TZqkAiK9Z0zmeYFCrWYzvrMbUrlBHJENnd8xYqqGu4Ao1+JeoD7ArLKVcJDvrpRoeDvYndfCbbUc5KzBlO1WZxiVteDIAOLcF35n6OaRJjlWIRWGnqWPFcGquGmUano3AvgZqkiXdAJVWMVkcdUDZ3sInWLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qolb9x/4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750812149; x=1782348149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sU2bp2FhksrcqHMdvPNPlXXnoiA4d9/n8fR2mCs2TO0=;
  b=Qolb9x/441o6FMdjxErw6gweCdzLguhyzm/RVJirj3UMThlWGe8LmqGP
   EEx/uQrwchqfj2WAYegMT/+v7wtglSeGgIui8MoQuLrCJ/T4qKIesQQeL
   JUxUK0cBcYVlLuSKs9Io+BcwYEebFe2SjzpK59mj/+I+jOa2oEga+UHxT
   HfEeNcOIsQY8+sWibEtb9vGdOzLWPYc2CKiVt8V8WuJlarPIlUjN9022o
   pxNGpMGUBQVYbJMQl8TzWfh/sBdN4CU6dUxvB3K63dod5otec7VWobaLW
   RoWFarwE23fj8PHbpFUA5BoKD9qabL/YrJPvTdCOToslJACJ1XfXAeCXr
   Q==;
X-CSE-ConnectionGUID: 0EJvShpNSeGq+X1pjXN1VQ==
X-CSE-MsgGUID: 0pNFTTd8RJyHtgAxyQtrZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="70497671"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="70497671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 17:42:28 -0700
X-CSE-ConnectionGUID: D6eAnGzDS2CVyTA3FvngIg==
X-CSE-MsgGUID: b/dXdKFATX2y6HDy5S3wfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="183103928"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Jun 2025 17:42:23 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUEDV-000Sd4-1v;
	Wed, 25 Jun 2025 00:42:21 +0000
Date: Wed, 25 Jun 2025 08:42:08 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, john.johansen@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com, takedakn@nttdata.co.jp,
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org,
	rdunlap@infraread.org, linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH v3 2/3] lsm: introduce security_lsm_config_*_policy hooks
Message-ID: <202506250843.UnXrlnza-lkp@intel.com>
References: <20250624143211.436045-3-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624143211.436045-3-maxime.belair@canonical.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9c32cda43eb78f78c73aee4aa344b777714e259b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-B-lair/Wire-up-lsm_config_self_policy-and-lsm_config_system_policy-syscalls/20250624-225008
base:   9c32cda43eb78f78c73aee4aa344b777714e259b
patch link:    https://lore.kernel.org/r/20250624143211.436045-3-maxime.belair%40canonical.com
patch subject: [PATCH v3 2/3] lsm: introduce security_lsm_config_*_policy hooks
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20250625/202506250843.UnXrlnza-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250625/202506250843.UnXrlnza-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506250843.UnXrlnza-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:62,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:94,
                    from init/main.c:21:
>> include/linux/security.h:1618:12: warning: 'security_lsm_config_system_policy' defined but not used [-Wunused-function]
    1618 | static int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/security.h:1611:12: warning: 'security_lsm_config_self_policy' defined but not used [-Wunused-function]
    1611 | static int security_lsm_config_self_policy(u32 lsm_id, u32 op, void __user *buf,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/security_lsm_config_system_policy +1618 include/linux/security.h

  1617	
> 1618	static int security_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
  1619						     size_t size, u32 flags)
  1620	{
  1621	
  1622		return -EOPNOTSUPP;
  1623	}
  1624	#endif	/* CONFIG_SECURITY */
  1625	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

