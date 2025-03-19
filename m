Return-Path: <linux-api+bounces-3398-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D3FA6934B
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101251B66B86
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A71DE899;
	Wed, 19 Mar 2025 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="O7l0n0to"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398F1C9B6C
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395837; cv=none; b=HFt83YJcgALRV3Y2y0Gts/qZvZBSWboGahZYbmeee81GYv1wRhP8So4iuonHxH5yuT570ID3Sajo3umM6fSm/Q4dFcRT/paiDu305/b/Mnk1E+fkFB0b3lSoHuVOlcz//TO/+P0ZJpWm0Nf3invR34W3o8TmzXNEtWvxVzmkQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395837; c=relaxed/simple;
	bh=VRmXls2VmwWW6MToh9ANlZpv2+BLd8nU5uI/yqd4x+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBJUaVVNqiQsQbybHRmWWOKowYGQI1+dvXNcf0k96kEc4kS8/bMvh4ZTUYNFm5A2OteHJJEF7KORmPfbSInySWfosjmyKM0MSNGUmDxaKzIhuJ9SThJ3muRfmej2unqZScn8Q+lSUW85WQQ5zNQ5pCq5qJIHtb1lgcDl4Lt5wJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=O7l0n0to; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E1AC3FCC9
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742395825;
	bh=SMXuj2xQPevxWoO0QPAu/DjqgHg0soeU6S5kJSD3kNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=O7l0n0toUcUb0pxMyNRVgnVLftB8gURg+4/+2J7PiI1rUpo5W5cn0z/pLLdhuYhN9
	 xrmdHzjINriJ/5jrb/b/E4ZgQ9PiPGYszY9v0GRlGXrxLdc+YSB8aJfZ0xKZPW8CWt
	 HKWu4w9+tueAUyvRt+T3GcoF9JrMbbO/ppbMnbRAW3XeVlfkl2FuGA35ze1CHKbAtS
	 5ozvn8bSLjTfCVSDD99HyhX3TFr0aSqKkEx9EvrZmKUSh+INAwDeioGg1r1ZLXg3D8
	 hNUjQNuHTsRsVEg1ZGri8fSMc2LejdVr5lb/ekzQ6ZPtk2niPESQ3RS1ovnfuUS+de
	 kUHtrazdkdnZQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5cc488f27so5985263a12.3
        for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 07:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395824; x=1743000624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMXuj2xQPevxWoO0QPAu/DjqgHg0soeU6S5kJSD3kNQ=;
        b=t+5/dtNjpaKn/t5CRr35Qj6Otwu4h74TzU+2DcWt07yFoUfX3xYiPSfBearpKjG8+N
         xSIC8T1cX5M0CDP/3PIpUX298fdcnEHcjdpP5FAD2DsfMp7J+DRzg48QN4TDhTfmWl0c
         dZCYynFmNJIy/PaoCctSFpD+Zp+tAxQ4FyzeOTif431PnkXeO1Sz4EmIeiz5dT8gkIrk
         mA0nVhS/vdgbfr89QuodtsiYtfEwZSpyrJa6Pb+4s3yRCtgHPZa1TLi9RZAEwy8ZaHTE
         XWloRbYE34HjAq8A+Ih3O1tzuN/lchkV4ADYn1VSPOV2Lq++k1dlur1AmdtRI531diFi
         hpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnRNjjOebQuKmodNh4z6nQ5MKsSSFz53ME8UaMW7E4lkobFRDkJuhoEY6TTV5CBAP17szwpbd6oiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYwiNmtJG1g3XytSQ/OgMXIfxnGMzJfnJH9ugl2zcLRZ6aEIh
	3ub3oyOej0b7X3EIRBF9Ext7ErUSaAH8QN+02sBl8lvbYC2r3BJaWWbHTu733TM2c5Bp5Ruunhj
	4pyOertalcWUH3WIpSDf9F6Nsi+nf9XuD1vgPXCfQJHnqLsdyHIoi4IT9K0iRLFvvnlam+tHWnA
	==
X-Gm-Gg: ASbGncvLSfVsqAW5md8PE2wjGRtUjYGPC7X0Dt/OGw6vNtAWQez1fF/uLNVBz84oVGv
	wkiYfYZZH3pic4FW3kT6LTgjbL9zLo8u7ad6RzEfOo685TjCKk8TEp1nACRF8nJ4T2JLWDK5plW
	UwJcWX56SAE9wOW6Uj/Crz/OOV0zL+NSyh0eXylKCjylEISGDbCrkuySSJH8hkbUD4hNIsMhzFG
	iUf9QqQ/4H+o5+f1v/+QenkAX0OTcf9dFDU9ng9NowpZiFiu28xdIsgPUCvbOKq/7WVmcgOtvvG
	LtAbefh2KYm4ze6GbAgivKyI4rotNlQeSflo9g==
X-Received: by 2002:a17:906:6a1e:b0:ac3:1364:2d15 with SMTP id a640c23a62f3a-ac3b7ddffa6mr284153266b.24.1742395824032;
        Wed, 19 Mar 2025 07:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZOIeVTPsdDlRt0H8qhCX7tF05joMtRcj2LbCy2HXABmRQxWZibWCD6ViL8rm2Ti4D18xvfQ==
X-Received: by 2002:a17:906:6a1e:b0:ac3:1364:2d15 with SMTP id a640c23a62f3a-ac3b7ddffa6mr284150466b.24.1742395823363;
        Wed, 19 Mar 2025 07:50:23 -0700 (PDT)
Received: from amikhalitsyn ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aed4fsm1014490066b.26.2025.03.19.07.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:50:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:50:20 +0100
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, arnd@kernel.org, brauner@kernel.org, chris@zankel.net, 
	david@redhat.com, deller@gmx.de, hch@infradead.org, jannh@google.com, 
	jcmvbkbc@gmail.com, jeffxu@chromium.org, jhubbard@nvidia.com, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mattst88@gmail.com, muchun.song@linux.dev, paulmck@kernel.org, 
	richard.henderson@linaro.org, shuah@kernel.org, sidhartha.kumar@oracle.com, surenb@google.com, 
	tsbogend@alpha.franken.de, vbabka@suse.cz, willy@infradead.org, criu@lists.linux.dev, 
	Andrei Vagin <avagin@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH v4 0/5] implement lightweight guard pages
Message-ID: <zihwmp67m2lpuxbfktmztvjdyap7suzd75dowlw4eamu6bhjf3@6euydiqowc7h>
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730123433.git.lorenzo.stoakes@oracle.com>

On Mon, Oct 28, 2024 at 02:13:26PM +0000, Lorenzo Stoakes wrote:
> Userland library functions such as allocators and threading implementations
> often require regions of memory to act as 'guard pages' - mappings which,
> when accessed, result in a fatal signal being sent to the accessing
> process.
> 
> The current means by which these are implemented is via a PROT_NONE mmap()
> mapping, which provides the required semantics however incur an overhead of
> a VMA for each such region.
> 
> With a great many processes and threads, this can rapidly add up and incur
> a significant memory penalty. It also has the added problem of preventing
> merges that might otherwise be permitted.
> 
> This series takes a different approach - an idea suggested by Vlasimil
> Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
> provenance becomes a little tricky to ascertain after this - please forgive
> any omissions!)  - rather than locating the guard pages at the VMA layer,
> instead placing them in page tables mapping the required ranges.
> 
> Early testing of the prototype version of this code suggests a 5 times
> speed up in memory mapping invocations (in conjunction with use of
> process_madvise()) and a 13% reduction in VMAs on an entirely idle android
> system and unoptimised code.
> 
> We expect with optimisation and a loaded system with a larger number of
> guard pages this could significantly increase, but in any case these
> numbers are encouraging.
> 
> This way, rather than having separate VMAs specifying which parts of a
> range are guard pages, instead we have a VMA spanning the entire range of
> memory a user is permitted to access and including ranges which are to be
> 'guarded'.
> 
> After mapping this, a user can specify which parts of the range should
> result in a fatal signal when accessed.
> 
> By restricting the ability to specify guard pages to memory mapped by
> existing VMAs, we can rely on the mappings being torn down when the
> mappings are ultimately unmapped and everything works simply as if the
> memory were not faulted in, from the point of view of the containing VMAs.
> 
> This mechanism in effect poisons memory ranges similar to hardware memory
> poisoning, only it is an entirely software-controlled form of poisoning.
> 
> The mechanism is implemented via madvise() behaviour - MADV_GUARD_INSTALL
> which installs page table-level guard page markers - and
> MADV_GUARD_REMOVE - which clears them.
> 
> Guard markers can be installed across multiple VMAs and any existing
> mappings will be cleared, that is zapped, before installing the guard page
> markers in the page tables.
> 
> There is no concept of 'nested' guard markers, multiple attempts to install
> guard markers in a range will, after the first attempt, have no effect.
> 
> Importantly, removing guard markers over a range that contains both guard
> markers and ordinary backed memory has no effect on anything but the guard
> markers (including leaving huge pages un-split), so a user can safely
> remove guard markers over a range of memory leaving the rest intact.
> 
> The actual mechanism by which the page table entries are specified makes
> use of existing logic - PTE markers, which are used for the userfaultfd
> UFFDIO_POISON mechanism.
> 
> Unfortunately PTE_MARKER_POISONED is not suited for the guard page
> mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
> handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
> logic to handle it.
> 
> We also extend the generic page walk mechanism to allow for installation of
> PTEs (carefully restricted to memory management logic only to prevent
> unwanted abuse).
> 
> We ensure that zapping performed by MADV_DONTNEED and MADV_FREE do not
> remove guard markers, nor does forking (except when VM_WIPEONFORK is
> specified for a VMA which implies a total removal of memory
> characteristics).
> 
> It's important to note that the guard page implementation is emphatically
> NOT a security feature, so a user can remove the markers if they wish. We
> simply implement it in such a way as to provide the least surprising
> behaviour.
> 
> An extensive set of self-tests are provided which ensure behaviour is as
> expected and additionally self-documents expected behaviour of guard
> ranges.

Dear Lorenzo,
Dear colleagues,

sorry about raising an old thread.

It looks like this feature is now used in glibc [1]. And we noticed failures in CRIU [2]
CI on Fedora Rawhide userspace. Now a question is how we can properly detect such 
"guarded" pages from user space. As I can see from MADV_GUARD_INSTALL implementation,
it does not modify VMA flags anyhow, but only page tables. It means that /proc/<pid>/maps
and /proc/<pid>/smaps interfaces are useless in this case. (Please, correct me if I'm missing
anything here.)

I wonder if you have any ideas / suggestions regarding Checkpoint/Restore here. We (CRIU devs) are happy
to develop some patches to bring some uAPI to expose MADV_GUARDs, but before going into this we decided
to raise this question in LKML.

+CC criu@lists.linux.dev
+CC Andrei Vagin <avagin@gmail.com>
+CC Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Kind regards,
Alex

[1] https://github.com/bminor/glibc/commit/a6fbe36b7f31292981422692236465ab56670ea9
[2] https://github.com/checkpoint-restore/criu/pull/2625

> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Suggested-by: Jann Horn <jannh@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> 
> v4
> * Use restart_syscall() to implement -ERESTARTNOINTR to ensure correctly
>   handled by kernel - tested this code path and confirmed it works
>   correctly. Thanks to Vlastimil for pointing this issue out!
> * Updated the vector_madvise() handler to not unnecessarily invoke
>   cond_resched() as suggested by Vlastimil.
> * Updated guard page tests to add a test for a vector operation which
>   overwrites existing mappings. Tested this against the -ERESTARTNOINTR
>   case and confirmed working.
> * Improved page walk logic further, refactoring handling logic as suggested
>   by Vlastimil.
> * Moved MAX_MADVISE_GUARD_RETRIES to mm/madvise.c as suggested by Vlastimil.
> 
> v3
> * Cleaned up mm/pagewalk.c logic a bit to make things clearer, as suggested
>   by Vlastiml.
> * Explicitly avoid splitting THP on PTE installation, as suggested by
>   Vlastimil. Note this has no impact on the guard pages logic, which has
>   page table entry handlers at PUD, PMD and PTE level.
> * Added WARN_ON_ONCE() to mm/hugetlb.c path where we don't expect a guard
>   marker, as suggested by Vlastimil.
> * Reverted change to is_poisoned_swp_entry() to exclude guard pages which
>   has the effect of MADV_FREE _not_ clearing guard pages. After discussion
>   with Vlastimil, it became apparent that the ability to 'cancel' the
>   freeing operation by writing to the mapping after having issued an
>   MADV_FREE would mean that we would risk unexpected behaviour should the
>   guard pages be removed, so we now do not remove markers here at all.
> * Added comment to PTE_MARKER_GUARD to highlight that memory tagged with
>   the marker behaves as if it were a region mapped PROT_NONE, as
>   highlighted by David.
> * Rename poison -> install, unpoison -> remove (i.e. MADV_GUARD_INSTALL /
>   MADV_GUARD_REMOVE over MADV_GUARD_POISON / MADV_GUARD_REMOVE) at the
>   request of David and John who both find the poison analogy
>   confusing/overloaded.
> * After a lot of discussion, replace the looping behaviour should page
>   faults race with guard page installation with a modest reattempt followed
>   by returning -ERESTARTNOINTR to have the operation abort and re-enter,
>   relieving lock contention and avoiding the possibility of allowing a
>   malicious sandboxed process to impact the mmap lock or stall the overall
>   process more than necessary, as suggested by Jann and Vlastimil having
>   raised the issue.
> * Adjusted the page table walker so a populated huge PUD or PMD is
>   correctly treated as being populated, necessitating a zap. In v2 we
>   incorrectly skipped over these, which would cause the logic to wrongly
>   proceed as if nothing were populated and the install succeeded.
>   Instead, explicitly check to see if a huge page - if so, do not split but
>   rather abort the operation and let zap take care of things.
> * Updated the guard remove logic to not unnecessarily split huge pages
>   either.
> * Added a debug check to assert that the number of installed PTEs matches
>   expectation, accounting for any existing guard pages.
> * Adapted vector_madvise() used by the process_madvise() system call to
>   handle -ERESTARTNOINTR correctly.
> https://lore.kernel.org/all/cover.1729699916.git.lorenzo.stoakes@oracle.com/
> 
> v2
> * The macros in kselftest_harness.h seem to be broken - __EXPECT() is
>   terminated by '} while (0); OPTIONAL_HANDLER(_assert)' meaning it is not
>   safe in single line if / else or for /which blocks, however working
>   around this results in checkpatch producing invalid warnings, as reported
>   by Shuah.
> * Fixing these macros is out of scope for this series, so compromise and
>   instead rewrite test blocks so as to use multiple lines by separating out
>   a decl in most cases. This has the side effect of, for the most part,
>   making things more readable.
> * Heavily document the use of the volatile keyword - we can't avoid
>   checkpatch complaining about this, so we explain it, as reported by
>   Shuah.
> * Updated commit message to highlight that we skip tests we lack
>   permissions for, as reported by Shuah.
> * Replaced a perror() with ksft_exit_fail_perror(), as reported by Shuah.
> * Added user friendly messages to cases where tests are skipped due to lack
>   of permissions, as reported by Shuah.
> * Update the tool header to include the new MADV_GUARD_POISON/UNPOISON
>   defines and directly include asm-generic/mman.h to get the
>   platform-neutral versions to ensure we import them.
> * Finally fixed Vlastimil's email address in Suggested-by tags from suze to
>   suse, as reported by Vlastimil.
> * Added linux-api to cc list, as reported by Vlastimil.
> https://lore.kernel.org/all/cover.1729440856.git.lorenzo.stoakes@oracle.com/
> 
> v1
> * Un-RFC'd as appears no major objections to approach but rather debate on
>   implementation.
> * Fixed issue with arches which need mmu_context.h and
>   tlbfush.h. header imports in pagewalker logic to be able to use
>   update_mmu_cache() as reported by the kernel test bot.
> * Added comments in page walker logic to clarify who can use
>   ops->install_pte and why as well as adding a check_ops_valid() helper
>   function, as suggested by Christoph.
> * Pass false in full parameter in pte_clear_not_present_full() as suggested
>   by Jann.
> * Stopped erroneously requiring a write lock for the poison operation as
>   suggested by Jann and Suren.
> * Moved anon_vma_prepare() to the start of madvise_guard_poison() to be
>   consistent with how this is used elsewhere in the kernel as suggested by
>   Jann.
> * Avoid returning -EAGAIN if we are raced on page faults, just keep looping
>   and duck out if a fatal signal is pending or a conditional reschedule is
>   needed, as suggested by Jann.
> * Avoid needlessly splitting huge PUDs and PMDs by specifying
>   ACTION_CONTINUE, as suggested by Jann.
> https://lore.kernel.org/all/cover.1729196871.git.lorenzo.stoakes@oracle.com/
> 
> RFC
> https://lore.kernel.org/all/cover.1727440966.git.lorenzo.stoakes@oracle.com/
> 
> Lorenzo Stoakes (5):
>   mm: pagewalk: add the ability to install PTEs
>   mm: add PTE_MARKER_GUARD PTE marker
>   mm: madvise: implement lightweight guard page mechanism
>   tools: testing: update tools UAPI header for mman-common.h
>   selftests/mm: add self tests for guard page feature
> 
>  arch/alpha/include/uapi/asm/mman.h           |    3 +
>  arch/mips/include/uapi/asm/mman.h            |    3 +
>  arch/parisc/include/uapi/asm/mman.h          |    3 +
>  arch/xtensa/include/uapi/asm/mman.h          |    3 +
>  include/linux/mm_inline.h                    |    2 +-
>  include/linux/pagewalk.h                     |   18 +-
>  include/linux/swapops.h                      |   24 +-
>  include/uapi/asm-generic/mman-common.h       |    3 +
>  mm/hugetlb.c                                 |    4 +
>  mm/internal.h                                |    6 +
>  mm/madvise.c                                 |  239 ++++
>  mm/memory.c                                  |   18 +-
>  mm/mprotect.c                                |    6 +-
>  mm/mseal.c                                   |    1 +
>  mm/pagewalk.c                                |  246 +++-
>  tools/include/uapi/asm-generic/mman-common.h |    3 +
>  tools/testing/selftests/mm/.gitignore        |    1 +
>  tools/testing/selftests/mm/Makefile          |    1 +
>  tools/testing/selftests/mm/guard-pages.c     | 1243 ++++++++++++++++++
>  19 files changed, 1751 insertions(+), 76 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/guard-pages.c
> 
> --
> 2.47.0

