Return-Path: <linux-api+bounces-3710-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2982CAAE261
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 16:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E3B500E41
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC528B7C9;
	Wed,  7 May 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDImqiNJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882328A3EF;
	Wed,  7 May 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626301; cv=none; b=PM9KdJ3tp2c0tBI5ISB600dGgKeHaAAr2CzaF7SATHvSiM9PNHfpWIxSih2CfU3/YBLac2QgrE1vmsM43uMpHaqQc/BYtf2571kk2Xl0P/GMD8XVkl+m2R05AYqTBoQ0xTDmJWLBPUhHtIhbsN9rSn+FaYvVkdmyr5WUO5utoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626301; c=relaxed/simple;
	bh=/0Q/u6Uimv2ZxNumXH8o5ajq0edxS5+j8L2aCHsi8D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS+kMMJL7kC2zpDiTEtGkmJNj5EvyzyxBa5ZMqThh67Yajwr9ap85VrAn8qJCVkoLDLH2l8IBTcFJH4SkWA4z5DigXVIR4pK2oDNQUYS1VqCXIgj3h4NNgAYThRt0LX7G5IPT8qGVa5r2Etuwn1kY1i7Jk92C9odP45yRvfafyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDImqiNJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746626299; x=1778162299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/0Q/u6Uimv2ZxNumXH8o5ajq0edxS5+j8L2aCHsi8D0=;
  b=jDImqiNJdnO4ePwY5bb/rtYDrbUTN7U6FNGehtD+tEg4Ki/VW+Kr5MQl
   eR+MpZ5HBAcsp4WuSBn8fNZc6rn8jpIgsowrGhb1FKYflRDEQTsDyJ2o3
   05uSVq4akC6ppd+f3qr0r9NaVy1YEHkAL6bpBTWjSHoiB8Y6jReEt/aYf
   lc7bnKR/gz4T3gz69nPVAUcvy/PUVH4lE8Rs3FMsm0w+9a8iTBGhbmy4Z
   OugemXHZdjpPCgdbaZuE2bxkj8U62TyrnMgP3WYpgASudLSBt+9iVYfLp
   MfL55/HdO4sazfxmogj/ue7dCmXstQ32OuJ3S93SYHIrsqrRrl8uQ/iEC
   Q==;
X-CSE-ConnectionGUID: 5NKCv8ceS3G9NofLWRtuZQ==
X-CSE-MsgGUID: GpFFbxJgQUaC6dO2rt+NSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="47613044"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="47613044"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:58:18 -0700
X-CSE-ConnectionGUID: vnx8wscpTRCgNzf2C2Pp5w==
X-CSE-MsgGUID: K1Ux9pV0TFuSEc0nzuSVgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="140011265"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 May 2025 06:58:15 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCfHo-0007vN-2T;
	Wed, 07 May 2025 13:58:12 +0000
Date: Wed, 7 May 2025 21:58:03 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, mic@digikod.net, kees@kernel.org,
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp,
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH 1/3] Wire up the lsm_manage_policy syscall
Message-ID: <202505072131.ogtsaLPI-lkp@intel.com>
References: <20250506143254.718647-2-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506143254.718647-2-maxime.belair@canonical.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9c32cda43eb78f78c73aee4aa344b777714e259b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-B-lair/Wire-up-the-lsm_manage_policy-syscall/20250506-224212
base:   9c32cda43eb78f78c73aee4aa344b777714e259b
patch link:    https://lore.kernel.org/r/20250506143254.718647-2-maxime.belair%40canonical.com
patch subject: [PATCH 1/3] Wire up the lsm_manage_policy syscall
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20250507/202505072131.ogtsaLPI-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505072131.ogtsaLPI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505072131.ogtsaLPI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1618:2: warning: syscall lsm_manage_policy not implemented [-W#warnings]
    1618 | #warning syscall lsm_manage_policy not implemented
         |  ^
   1 warning generated.
--
>> <stdin>:1618:2: warning: syscall lsm_manage_policy not implemented [-W#warnings]
    1618 | #warning syscall lsm_manage_policy not implemented
         |  ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

