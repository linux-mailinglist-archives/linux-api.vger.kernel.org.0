Return-Path: <linux-api+bounces-4157-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F2B0471A
	for <lists+linux-api@lfdr.de>; Mon, 14 Jul 2025 20:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCB33BCFC6
	for <lists+linux-api@lfdr.de>; Mon, 14 Jul 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A444A26B96E;
	Mon, 14 Jul 2025 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVx6V50J"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69726B94E;
	Mon, 14 Jul 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516476; cv=none; b=FZDQm7nY0Dnv8Pw+kJrIJtCMzKcJ0HljCl2mEdrYJE8sSAj+Ho+HjgRps7f8gNhZI/55B81fz9SPuA5g9QlYYFPvUEPCL9iomwM6EZ4YtsNwpD73sjF6GThlB09TiCbmtFHbQCnx2WJVVCqqqsycOgwsa4N4iCcWpQ1buy+9gAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516476; c=relaxed/simple;
	bh=dAR/rUsYNa6PZyDHeSqqc2o3AIhtW8QY+gby5DdA4gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtIQgJz1phDD7NMDBvsvfVAErrAllQv0NvGBkuMxcvRSlHkOT7HBygRNfQ2Ko0GsPCvQaFE+oiqXha8tUCXHCPT7FDIFBJ12EZ7LYIvGZeNl0iLDmE8loFDhVDZVJf5tq8DdrAnLhS9VlVIx6KtggEax2/hTajUgucjXcunwod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVx6V50J; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752516475; x=1784052475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dAR/rUsYNa6PZyDHeSqqc2o3AIhtW8QY+gby5DdA4gM=;
  b=iVx6V50JWGmUJLwHCIvFUDspkTcuqxHIq4T3i7wsUqKAj8dz3fTPVDtF
   FP5sC9r9gENqFYvTc6SE5ZsUksgBWRIYJfzVAhmzMdKx08t7r9QtFTuTA
   11+9wxG8D+tQUXUNguh5S99Ys+BtG1eshyfb3hHT2TP5YHu8zUoCbrssa
   Obzp3D/slYq25zpNrH9uRvaw4+aYfY28ej/yGsEpKQN1l/bd2Iga0HLkC
   sM7G7sCIJYNiN/0+JtNvYP/zbGnGojNuOe2It1BYs1U86qQ5OGESR48GT
   Ij177bvz9XfoJaNLhBFYDFThOf+fHR/kzIT8VTUtF4WrhR7XzEiBwNtd7
   A==;
X-CSE-ConnectionGUID: 7zaGDubiSTW7PxV43NHsqg==
X-CSE-MsgGUID: Agm7RjEqQSOhLDNSvNVxQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54845950"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="54845950"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:07:54 -0700
X-CSE-ConnectionGUID: zTt/8AEyS6u9eDHt80S9tg==
X-CSE-MsgGUID: fxml/+LHQEyTrbc2FF8K0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="188001945"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jul 2025 11:07:50 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubNae-0009Ch-0V;
	Mon, 14 Jul 2025 18:07:48 +0000
Date: Tue, 15 Jul 2025 02:07:38 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, john.johansen@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com, takedakn@nttdata.co.jp,
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org,
	rdunlap@infradead.org, linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH v5 3/3] AppArmor: add support for lsm_config_self_policy
 and lsm_config_system_policy
Message-ID: <202507150132.xWRFcZgf-lkp@intel.com>
References: <20250709080220.110947-4-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709080220.110947-4-maxime.belair@canonical.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9c32cda43eb78f78c73aee4aa344b777714e259b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-B-lair/Wire-up-lsm_config_self_policy-and-lsm_config_system_policy-syscalls/20250709-160720
base:   9c32cda43eb78f78c73aee4aa344b777714e259b
patch link:    https://lore.kernel.org/r/20250709080220.110947-4-maxime.belair%40canonical.com
patch subject: [PATCH v5 3/3] AppArmor: add support for lsm_config_self_policy and lsm_config_system_policy
config: hexagon-randconfig-r072-20250714 (https://download.01.org/0day-ci/archive/20250715/202507150132.xWRFcZgf-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150132.xWRFcZgf-lkp@intel.com/

smatch warnings:
security/apparmor/lsm.c:1348 apparmor_lsm_config_system_policy() warn: unsigned 'ns_size' is never less than zero.

vim +/ns_size +1348 security/apparmor/lsm.c

  1319	
  1320	/**
  1321	 * apparmor_lsm_config_system_policy - Load or replace a system policy
  1322	 * @lsm_id: AppArmor ID (LSM_ID_APPARMOR). Unused here
  1323	 * @op: operation to perform. Currently, only LSM_POLICY_LOAD is supported
  1324	 * @buf: user-supplied buffer in the form "<ns>\0<policy>"
  1325	 *        <ns> is the namespace to load the policy into (empty string for root)
  1326	 *        <policy> is the policy to load
  1327	 * @size: size of @buf
  1328	 * @flags: reserved for future uses; must be zero
  1329	 *
  1330	 * Returns: 0 on success, negative value on error
  1331	 */
  1332	static int apparmor_lsm_config_system_policy(u32 lsm_id, u32 op, void __user *buf,
  1333					      size_t size, u32 flags)
  1334	{
  1335		loff_t pos = 0; // Partial writing is not currently supported
  1336		char ns_name[AA_PROFILE_NAME_MAX_SIZE];
  1337		size_t ns_size;
  1338		size_t max_ns_size = min(size, AA_PROFILE_NAME_MAX_SIZE);
  1339	
  1340		if (op != LSM_POLICY_LOAD || flags)
  1341			return -EOPNOTSUPP;
  1342		if (size < 2)
  1343			return -EINVAL;
  1344		if (size > AA_PROFILE_MAX_SIZE)
  1345			return -E2BIG;
  1346	
  1347		ns_size = strncpy_from_user(ns_name, buf, max_ns_size);
> 1348		if (ns_size < 0)
  1349			return ns_size;
  1350		if (ns_size == max_ns_size)
  1351			return -E2BIG;
  1352	
  1353		return aa_profile_load_ns_name(ns_name, ns_size, buf + ns_size + 1,
  1354					       size - ns_size - 1, &pos);
  1355	}
  1356	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

