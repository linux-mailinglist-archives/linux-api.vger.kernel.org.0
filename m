Return-Path: <linux-api+bounces-3951-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E69AE13D1
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 08:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091CD3B8194
	for <lists+linux-api@lfdr.de>; Fri, 20 Jun 2025 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964DC22171E;
	Fri, 20 Jun 2025 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPY0ed+K"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6057221281;
	Fri, 20 Jun 2025 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750400987; cv=none; b=Ck66zEOQnmR55bVcLWJz6kwZmZrywGrik8QA6mJ3pC2Jj7gJ9BG0A4TA4ofbQ5IDWwcfZ7bnElQHUxoirYBDdtIkWwPuGP4fBX0DV7x8korE0p3mY4+vl2Ob3DwvXdy6tLJotv02E94V2S9Yh3b6TsVtPzvC0Tvx7SvQfGpNDOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750400987; c=relaxed/simple;
	bh=hD7ZFg2oUF1zO6JNaxETcxrUQ675xpCMaUgDOQcTzEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXBlxMsv7wsth6Vkkjx47uFPNJumFzA1vetaSeI+fUB9urT33Ri0098AViSCbNhVVcGtrsdTnicY3G/QXg4hANPVE/ah3QfxiqScenFq8JeS3p2Aq7yubexivUAmFWNdfk3mC1cY7t+MDVPoSwn2qJO1sVv6Q8H3lGI7mhNtd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPY0ed+K; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750400986; x=1781936986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hD7ZFg2oUF1zO6JNaxETcxrUQ675xpCMaUgDOQcTzEY=;
  b=cPY0ed+KlXLhLj/xRyNAfkv21G0adHWoBWkrPifBshVNK+BstnSHzVKP
   XAi+e4fAk94Cwh6mhbIh/pP1qVQaelFWVD44CIlI/g9VCE4xQsj+blnom
   IDueJibQqASwaXXwDEwzmOblzZhyUbUIXivPu7STR6NEtVVKRQVsdcidV
   NbXClVULZJvc8zZDzUGrlwKHS1IpZMpJcfAc47xGaOXcfvBkisA2wi44m
   l8aDCH3tIucwNm9yK0MHSrj5hoYoe1fa2L3hGcN8k1vCE8eFCVWpw/nJ1
   GKva3AL3tsy+LeqS/wvhV3AVlz5g0rCjNOvseRDR4/SQc3cRrjLWDnUXZ
   Q==;
X-CSE-ConnectionGUID: yCKS7getRb+p98N8s1m30g==
X-CSE-MsgGUID: Ig6XqNNeS8i4fL61A15K2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52799571"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="52799571"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 23:29:43 -0700
X-CSE-ConnectionGUID: 6/qi+xb+SXS8ZP7Y8EHbmg==
X-CSE-MsgGUID: kCKCdyveR5aVl7otqVCwdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="151370535"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 19 Jun 2025 23:29:38 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSVFn-000LR1-28;
	Fri, 20 Jun 2025 06:29:35 +0000
Date: Fri, 20 Jun 2025 14:28:49 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, john.johansen@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com, takedakn@nttdata.co.jp,
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org,
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH v2 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
Message-ID: <202506201414.tHOEthTb-lkp@intel.com>
References: <20250619181600.478038-4-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619181600.478038-4-maxime.belair@canonical.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9c32cda43eb78f78c73aee4aa344b777714e259b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-B-lair/Wire-up-lsm_config_self_policy-and-lsm_config_system_policy-syscalls/20250620-022714
base:   9c32cda43eb78f78c73aee4aa344b777714e259b
patch link:    https://lore.kernel.org/r/20250619181600.478038-4-maxime.belair%40canonical.com
patch subject: [PATCH v2 3/3] AppArmor: add support for lsm_config_self_policy and lsm_config_system_policy
config: x86_64-buildonly-randconfig-002-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201414.tHOEthTb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506201414.tHOEthTb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506201414.tHOEthTb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/apparmor/apparmorfs.c:454: warning: Function parameter or struct member 'name' not described in 'aa_profile_load_ns_name'
>> security/apparmor/apparmorfs.c:454: warning: Function parameter or struct member 'name_size' not described in 'aa_profile_load_ns_name'
>> security/apparmor/apparmorfs.c:454: warning: Function parameter or struct member 'buf' not described in 'aa_profile_load_ns_name'
>> security/apparmor/apparmorfs.c:454: warning: Function parameter or struct member 'size' not described in 'aa_profile_load_ns_name'
>> security/apparmor/apparmorfs.c:454: warning: Function parameter or struct member 'ppos' not described in 'aa_profile_load_ns_name'
--
>> security/apparmor/lsm.c:1287: warning: Function parameter or struct member 'lsm_id' not described in 'apparmor_lsm_config_self_policy'
>> security/apparmor/lsm.c:1287: warning: Function parameter or struct member 'op' not described in 'apparmor_lsm_config_self_policy'
>> security/apparmor/lsm.c:1287: warning: Function parameter or struct member 'flags' not described in 'apparmor_lsm_config_self_policy'
>> security/apparmor/lsm.c:1318: warning: Function parameter or struct member 'lsm_id' not described in 'apparmor_lsm_config_system_policy'
>> security/apparmor/lsm.c:1318: warning: Function parameter or struct member 'op' not described in 'apparmor_lsm_config_system_policy'
>> security/apparmor/lsm.c:1318: warning: Function parameter or struct member 'flags' not described in 'apparmor_lsm_config_system_policy'


vim +454 security/apparmor/apparmorfs.c

   441	
   442	/**
   443	 * aa_profile_load_ns_name - load a profile into the current namespace identified by name
   444	 * @name The name of the namesapce to load the policy in. "" for root_ns
   445	 * @name_size size of @name. 0 For root ns
   446	 * @buf buffer containing the user-provided policy
   447	 * @size size of @buf
   448	 * @ppos position pointer in the file
   449	 *
   450	 * Returns: 0 on success, negative value on error
   451	 */
   452	ssize_t aa_profile_load_ns_name(char *name, size_t name_size, const void __user *buf,
   453					size_t size, loff_t *ppos)
 > 454	{
   455		struct aa_ns *ns;
   456	
   457		if (name_size == 0)
   458			ns = aa_get_ns(root_ns);
   459		else
   460			ns = aa_lookupn_ns(root_ns, name, name_size);
   461	
   462		if (!ns)
   463			return -EINVAL;
   464	
   465		int error = policy_update(AA_MAY_LOAD_POLICY | AA_MAY_REPLACE_POLICY,
   466					  buf, size, ppos, ns);
   467	
   468		aa_put_ns(ns);
   469	
   470		return error >= 0 ? 0 : error;
   471	}
   472	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

