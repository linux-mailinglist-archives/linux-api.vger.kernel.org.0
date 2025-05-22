Return-Path: <linux-api+bounces-3842-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A98AC0B60
	for <lists+linux-api@lfdr.de>; Thu, 22 May 2025 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F145166835
	for <lists+linux-api@lfdr.de>; Thu, 22 May 2025 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E192289813;
	Thu, 22 May 2025 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkXM5PH1"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014317D098;
	Thu, 22 May 2025 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915856; cv=none; b=UwWh13DPwYICMWlEHVUP8iwJYHzS7m49dFd+t9P2VPSHo9smLxju4530CbtZolITppbGdOthMqCTVG8kIS5jmF13m8/hnKFQnCIvIkDE3edoyZ8NBt5Cp8Ar2Z6YTHPCuvB9AQP+ionNdAVSLYYyJBjWWO14QpmQve+zca0wiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915856; c=relaxed/simple;
	bh=b6ul/IexOU3UrwM7guWXvrzYe6FDI+7LVqnn9ABwBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieaQOjL+smqxwFrGoiRGDaz6Ek/nLxQ9AW3U1pus2BQojWT6Kj+oAuYRYu+kIUEwRKq2BNXtorQWX4diQuIvzn5s1wnYmBTxHCEIXDGupXNonjbkcR4WTTA0sz4VAdH2ib4IL/KpjlqfLbSTr3VJ2gZh4TB+ZVKI+yaCXb69fCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkXM5PH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB4FC4CEE4;
	Thu, 22 May 2025 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747915855;
	bh=b6ul/IexOU3UrwM7guWXvrzYe6FDI+7LVqnn9ABwBxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkXM5PH1UOY51ngJLl4uZllA5Ci9jw+TjLfP4hokuQwbhjcCdah0S/N3QkANGMK3d
	 wImkWwJrreuMgBRLezTB1cM8ix5QDJVeLulJnbY9ASowqZehW3HzJtfLPbmM7/TdPd
	 c/xaiJ6DDLhPr1hlw6GwDrYBVxoRJgl5Y72IJ9oCYylCPJLF3k2Nx5xQJ8BwqcXeuL
	 iRZL5xmqqdMyhwSRvf+h8/1MWC0k2SC+qcVfOpBadGUH3moerBLvgy57loUsrEl4cO
	 M3Y+x2H0F+uX+vM6C1K/u5b1M9UKz2kyRNByPZPSbenwRDULvmGyZZqnHQqDTsbMmT
	 lqam+yTFz3vAQ==
Date: Thu, 22 May 2025 15:10:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	linux-mm@kvack.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
	riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel-team@meta.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 0/7] prctl: introduce PR_SET/GET_THP_POLICY
Message-ID: <aC8URbAzw06Ob4T8@kernel.org>
References: <20250519223307.3601786-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519223307.3601786-1-usamaarif642@gmail.com>

(cc'ing linux-api)

On Mon, May 19, 2025 at 11:29:52PM +0100, Usama Arif wrote:
> This series allows to change the THP policy of a process, according to the
> value set in arg2, all of which will be inherited during fork+exec:
> - PR_DEFAULT_MADV_HUGEPAGE: This will set VM_HUGEPAGE and clear VM_NOHUGEPAGE
>   for the default VMA flags. It will also iterate through every VMA in the
>   process and call hugepage_madvise on it, with MADV_HUGEPAGE policy.
>   This effectively allows setting MADV_HUGEPAGE on the entire process.
>   In an environment where different types of workloads are run on the
>   same machine, this will allow workloads that benefit from always having
>   hugepages to do so, without regressing those that don't.
> - PR_DEFAULT_MADV_NOHUGEPAGE: This will set VM_NOHUGEPAGE and clear VM_HUGEPAGE
>   for the default VMA flags. It will also iterate through every VMA in the
>   process and call hugepage_madvise on it, with MADV_NOHUGEPAGE policy.
>   This effectively allows setting MADV_NOHUGEPAGE on the entire process.
>   In an environment where different types of workloads are run on the
>   same machine,this will allow workloads that benefit from having
>   hugepages on an madvise basis only to do so, without regressing those
>   that benefit from having hugepages always.
> - PR_THP_POLICY_SYSTEM: This will reset (clear) both VM_HUGEPAGE and
>   VM_NOHUGEPAGE process for the default flags.
> 
> In hyperscalers, we have a single THP policy for the entire fleet.
> We have different types of workloads (e.g. AI/compute/databases/etc)
> running on a single server.
> Some of these workloads will benefit from always getting THP at fault
> (or collapsed by khugepaged), some of them will benefit by only getting
> them at madvise.
> 
> This series is useful for 2 usecases:
> 1) global system policy = madvise, while we want some workloads to get THPs
> at fault and by khugepaged :- some processes (e.g. AI workloads) benefits
> from getting THPs at fault (and collapsed by khugepaged). Other workloads
> like databases will incur regression (either a performance regression or
> they are completely memory bound and even a very slight increase in memory
> will cause them to OOM). So what these patches will do is allow setting
> prctl(PR_DEFAULT_MADV_HUGEPAGE) on the AI workloads, (This is how
> workloads are deployed in our (Meta's/Facebook) fleet at this moment).
> 
> 2) global system policy = always, while we want some workloads to get THPs
> only on madvise basis :- Same reason as 1). What these patches
> will do is allow setting prctl(PR_DEFAULT_MADV_NOHUGEPAGE) on the database
> workloads. (We hope this is us (Meta) in the near future, if a majority of
> workloads show that they benefit from always, we flip the default host
> setting to "always" across the fleet and workloads that regress can opt-out
> and be "madvise". New services developed will then be tested with always by
> default. "always" is also the default defconfig option upstream, so I would
> imagine this is faced by others as well.)
> 
> v2->v3: (Thanks Lorenzo for all the below feedback!)
> v2: https://lore.kernel.org/all/20250515133519.2779639-1-usamaarif642@gmail.com/
> - no more flags2.
> - no more MMF2_...
> - renamed policy to PR_DEFAULT_MADV_(NO)HUGEPAGE
> - mmap_write_lock_killable acquired in PR_GET_THP_POLICY
> - mmap_write lock fixed in PR_SET_THP_POLICY
> - mmap assert check in process_default_madv_hugepage
> - check if hugepage_global_enabled is enabled in the call and account for s390
> - set mm->def_flags VM_HUGEPAGE and VM_NOHUGEPAGE according to the policy in
>   the way done by madvise(). I believe VM merge will not be broken in
>   this way.
> - process_default_madv_hugepage function that does for_each_vma and calls
>   hugepage_madvise.
> 
> v1->v2:
> - change from modifying the THP decision making for the process, to modifying
>   VMA flags only. This prevents further complicating the logic used to
>   determine THP order (Thanks David!)
> - change from using a prctl per policy change to just using PR_SET_THP_POLICY
>   and arg2 to set the policy. (Zi Yan)
> - Introduce PR_THP_POLICY_DEFAULT_NOHUGE and PR_THP_POLICY_DEFAULT_SYSTEM
> - Add selftests and documentation.
>  
> Usama Arif (7):
>   mm: khugepaged: extract vm flag setting outside of hugepage_madvise
>   prctl: introduce PR_DEFAULT_MADV_HUGEPAGE for the process
>   prctl: introduce PR_DEFAULT_MADV_NOHUGEPAGE for the process
>   prctl: introduce PR_THP_POLICY_SYSTEM for the process
>   selftests: prctl: introduce tests for PR_DEFAULT_MADV_NOHUGEPAGE
>   selftests: prctl: introduce tests for PR_THP_POLICY_DEFAULT_HUGE
>   docs: transhuge: document process level THP controls
> 
>  Documentation/admin-guide/mm/transhuge.rst    |  42 +++
>  include/linux/huge_mm.h                       |   2 +
>  include/linux/mm.h                            |   2 +-
>  include/linux/mm_types.h                      |   4 +-
>  include/uapi/linux/prctl.h                    |   6 +
>  kernel/sys.c                                  |  53 ++++
>  mm/huge_memory.c                              |  13 +
>  mm/khugepaged.c                               |  26 +-
>  tools/include/uapi/linux/prctl.h              |   6 +
>  .../trace/beauty/include/uapi/linux/prctl.h   |   6 +
>  tools/testing/selftests/prctl/Makefile        |   2 +-
>  tools/testing/selftests/prctl/thp_policy.c    | 286 ++++++++++++++++++
>  12 files changed, 436 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/selftests/prctl/thp_policy.c
> 
> -- 
> 2.47.1
> 
> 

-- 
Sincerely yours,
Mike.

