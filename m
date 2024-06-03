Return-Path: <linux-api+bounces-1671-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BFA8D8A31
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2024 21:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0011228D809
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2024 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917ED13AA3B;
	Mon,  3 Jun 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtULPL35"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002913A876;
	Mon,  3 Jun 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442884; cv=none; b=RynVYxbfEbulBE0hIZQI0BEVEHoOIjpx4jyG1iIF9Y7zxr73jIwZb2F7JQZWPRIaKcDe0TITkZGkErFOEHLgb5FVpCylqzIH+MdixVj+VcyIgdWzfQL3aYhgMnKAgt086Nrv45Wkx1HbP0rz8tI06FPQUwaWNts7xbmXZswG2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442884; c=relaxed/simple;
	bh=mrEwpiqCjvVJnCAY5cT1wSsEx33Z3Jwicz4IDjznKRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvsGJVOJypIGKoFsjozqtU8+QWTWVtL2RZJMnLfidCl4LYF9NXwK4IoqUL526MjD1ZoUKkQieP0cnKYsCqel5+TCj9PP83r5J7IAu3/+FNQPUR6TVcpGMTVG3DW3hYsY2daolucr1jmVeukdEx6cMcWNI3GQNcefc5PDnV6S2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtULPL35; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717442883; x=1748978883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mrEwpiqCjvVJnCAY5cT1wSsEx33Z3Jwicz4IDjznKRA=;
  b=DtULPL35lnE6XZMlMTtadzQDJZzVWIY1UOitHVR127devIx+ONpKaXgD
   QZRSEcUFCwqedza5/Nr3uIEwPyFEzprPVthYOGW6vI1MUdfQp19yfIY5z
   qcbhSdOuGL3WqrHXvw8ibWyYKSMWh7E+MJ+Xmd4JynMz4F4eIE3Kzmny9
   DiN2yEyDDy9iPe7HXrz0Gs+avfPac/2BfuxF5lcORIIFZmazjjZ89m+y2
   XN42dofPvPCsc8FGPMaWVd8Ml87nvFPddDnCG5Q8qqnTh45Q6dCxaNHk3
   LYgz+WZD6sz96Qy9XzEwJT4slxOYPtos0ZWn4zttArmKFY5mlD0XfaglS
   A==;
X-CSE-ConnectionGUID: IYtcsytRSC2XFRPjEGn65A==
X-CSE-MsgGUID: wrNlg7UpRG2mOzk0IKZVdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14078552"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="14078552"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:28:01 -0700
X-CSE-ConnectionGUID: sl/BujAzTGeKoHWIeAFxPA==
X-CSE-MsgGUID: fkKcjmoyT2GabTTHpQHK1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="36959388"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:28:00 -0700
Date: Mon, 3 Jun 2024 12:27:56 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
	Hugh Dickins <hughd@google.com>, Edward Liaw <edliaw@google.com>,
	kernel-team@android.com, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: Header conflicts with shmget() and SHM_HUGE_2MB
Message-ID: <Zl4ZPIesxcxI-QE2@tassilo>
References: <Zl4LC9lTNptB2xTJ@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl4LC9lTNptB2xTJ@google.com>

> I can see such definitions are tagged as "obsolete" in the uapi headers.
> Do we need some ifndef protection with the glibc headers?

They should be still supported, but also the more generic macro.
> 
> What is the advice to follow for userspace? Skip <linux/shm.h> and
> openly redefine the SHM_HUGE_* wherever needed?

glibc (or other C libraries if not using linux/shm) should add the
defines.  Short term you would need to redefine on your own yes.

-Andi

