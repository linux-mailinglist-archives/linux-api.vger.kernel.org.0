Return-Path: <linux-api+bounces-2111-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA48947FC7
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 18:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED2A1C20C80
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 16:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F001515D5C5;
	Mon,  5 Aug 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C/UnRtfd"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27B15B57B
	for <linux-api@vger.kernel.org>; Mon,  5 Aug 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877129; cv=none; b=O0qdy3jyrQ+A6IngUhIJEJkI9PryfITsQvWCvImT86Uf7ZUoYtl1ajtns095LnhDrEeyYOwYvP+9wIEMwDjWBg1MMogjZtLD62XyTur8L1w3+dizIRpNyPat5NuUAEanIvnX7t3KJaE2acV/k4TLf6qI2lWr+0jWyVrbCA98cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877129; c=relaxed/simple;
	bh=6P7RATJtfpr4x9vwPooxcpS9WQT23cQ9BkDDETt9dHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky5Fw2wutIhXSYuRhfuy5/FCF+Q0ec22Itfg1nwMV8Bb2SdRTQVDyjP2eaMK+DAobkcZyLcIKkfplGQFMzyhbha8u/+cWkZQ2HkPlTmLqwSfxpEp+4+3Iwzbybtu/C9AIgclf5d7xghtUNY1Qk3EGqMjSJJa8tT/F6pC1/Ejxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C/UnRtfd; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5d4d07babso5584425eaf.3
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722877126; x=1723481926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmZFGw6x2XnauggBIOWGJH6eCk7i2++PahpN20+gqWc=;
        b=C/UnRtfdF0tZ4c0cub6yuWHj04aiRCPna3/vTrSE6BgycSiaNQazHLwQ5s/6d7ywZd
         RGbRKyCw6ai9XWDIB2aXsI5Ti3NvSUqdHTs+JsjhNzoeTyYUtW5/ViB8VB6V1No0nP4n
         SXGpiu6FoBpRajd0sstWp7NSkMMhwKS70F7L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877126; x=1723481926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmZFGw6x2XnauggBIOWGJH6eCk7i2++PahpN20+gqWc=;
        b=cZNL1XoMgNg0KsS+SqY19po6GcNw6mnDimORTzEDfPADXZSL0UbktLXe/HDP7A30J9
         U6ggROzv2VCKwopmi1xKV/5aHc9AI4h+lDkbMo4E9HewUbu1fHZTFSnk8qxLCRqW9Nze
         ZKr5UI2TiexlP5LcX9wSNSZPFzYbTMUpbQgU8bVgYCgKpnx3JMc+3kB6TawxHsuORnPB
         IQmpqj6bGqmLIbgFXLW+T2xelhi0GTVtQ4hQgK1TU9dYc0uHMV54g2kxEwqbaIRG3pF9
         LhfPqWFbVqmvHkxv1O0P74f45+egEqGe1IY0KWcPCAetOFAWDZBCPMLW1VnN+WmrK+iW
         7V+g==
X-Forwarded-Encrypted: i=1; AJvYcCVOQY1qk6kue35OPRBxouvR+eKLs3OhqfNl4U+1ZMHUXUM5PQq+gxvL2pj9hSO+zkTFMHxx+x600k0Cx3SG7qeeC5J4PGQNbCOI
X-Gm-Message-State: AOJu0YzQuZx7Oy5BNq7EmcmQkmXLGdlllzGwPWN/wxIsg7Gwru/ecIVF
	ngMiBohFongOmUscb4gDL1hy+var9WGAGdrTszPyox8903sTWfiXrHYiCUzmlSGAlr+AgtWTZVe
	6wRVtPoIjQq1mD7U9rRaD8hDOn/zroBGOIBHG
X-Google-Smtp-Source: AGHT+IFcdU/4JUja9dNJXSdzgyNGDhy8xKgDIQ5dwkjqraypTDTRgJEs1nqq5gfan2k/x7ao6JFtLMDOxFOVYz7JrDQ=
X-Received: by 2002:a05:6870:c192:b0:261:1339:1cb8 with SMTP id
 586e51a60fabf-26891e6789cmr16009079fac.35.1722877125503; Mon, 05 Aug 2024
 09:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com>
In-Reply-To: <202408041602.caa0372-oliver.sang@intel.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 5 Aug 2024 09:58:33 -0700
Message-ID: <CABi2SkWco0svzUqCK8OsTmivXTvoWUHrE6AJxpm=NaT2uMb=WA@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Dave Hansen <dave.hansen@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Guenter Roeck <groeck@chromium.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 1:59=E2=80=AFAM kernel test robot <oliver.sang@intel=
.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a -4.4% regression of stress-ng.pagemove.page_r=
emaps_per_sec on:
>
>
> commit: 8be7258aad44b5e25977a98db136f677fa6f4370 ("mseal: add mseal sysca=
ll")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> parameters:
>
>         nr_threads: 100%
>         testtime: 60s
>         test: pagemove
>         cpufreq_governor: performance
>
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
----------------------------------------+
> | testcase: change | stress-ng: stress-ng.pkey.ops_per_sec -3.6% regressi=
on                                      |
> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480=
CTDX (Sapphire Rapids) with 256G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                          |
> |                  | nr_threads=3D100%                                   =
                                          |
> |                  | test=3Dpkey                                         =
                                          |
> |                  | testtime=3D60s                                      =
                                          |
> +------------------+-----------------------------------------------------=
----------------------------------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202408041602.caa0372-oliver.sang=
@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240804/202408041602.caa0372-oli=
ver.sang@intel.com
>
There is an error when I try to reproduce the test:

bin/lkp install job.yaml

--------------------------------------------------------
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
 libdw1 : Depends: libelf1 (=3D 0.190-1+b1)
 libdw1t64 : Breaks: libdw1 (< 0.191-2)
E: Unable to correct problems, you have held broken packages.
Cannot install some packages of perf-c2c depends
---------------------------------------------------------------------------=
--------------

And where is stress-ng.pagemove.page_remaps_per_sec test implemented,
is that part of lkp-tests ?

Thanks
-Jeff

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/l=
kp-icl-2sp7/pagemove/stress-ng/60s
>
> commit:
>   ff388fe5c4 ("mseal: wire up mseal syscall")
>   8be7258aad ("mseal: add mseal syscall")
>
> ff388fe5c481d39c 8be7258aad44b5e25977a98db13
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>   41625945            -4.3%   39842322        proc-vmstat.numa_hit
>   41559175            -4.3%   39774160        proc-vmstat.numa_local
>   77484314            -4.4%   74105555        proc-vmstat.pgalloc_normal
>   77205752            -4.4%   73826672        proc-vmstat.pgfree
>   18361466            -4.2%   17596652        stress-ng.pagemove.ops
>     306014            -4.2%     293262        stress-ng.pagemove.ops_per_=
sec
>     205312            -4.4%     196176        stress-ng.pagemove.page_rem=
aps_per_sec
>       4961            +1.0%       5013        stress-ng.time.percent_of_c=
pu_this_job_got
>       2917            +1.2%       2952        stress-ng.time.system_time
>       1.07            -6.6%       1.00        perf-stat.i.MPKI
>  3.354e+10            +3.5%  3.473e+10        perf-stat.i.branch-instruct=
ions
>  1.795e+08            -4.2%  1.719e+08        perf-stat.i.cache-misses
>  2.376e+08            -4.1%  2.279e+08        perf-stat.i.cache-reference=
s
>       1.13            -3.0%       1.10        perf-stat.i.cpi
>       1077            +4.3%       1124        perf-stat.i.cycles-between-=
cache-misses
>  1.717e+11            +2.7%  1.762e+11        perf-stat.i.instructions
>       0.88            +3.1%       0.91        perf-stat.i.ipc
>       1.05            -6.8%       0.97        perf-stat.overall.MPKI
>       0.25 =C4=85  2%      -0.0        0.24        perf-stat.overall.bran=
ch-miss-rate%
>       1.13            -3.0%       1.10        perf-stat.overall.cpi
>       1084            +4.0%       1127        perf-stat.overall.cycles-be=
tween-cache-misses
>       0.88            +3.1%       0.91        perf-stat.overall.ipc
>  3.298e+10            +3.5%  3.415e+10        perf-stat.ps.branch-instruc=
tions
>  1.764e+08            -4.3%  1.689e+08        perf-stat.ps.cache-misses
>  2.336e+08            -4.1%   2.24e+08        perf-stat.ps.cache-referenc=
es
>     194.57            -2.4%     189.96 =C4=85  2%  perf-stat.ps.cpu-migra=
tions
>  1.688e+11            +2.7%  1.733e+11        perf-stat.ps.instructions
>  1.036e+13            +3.0%  1.068e+13        perf-stat.total.instruction=
s
>      75.12            -1.9       73.22        perf-profile.calltrace.cycl=
es-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe=
.mremap
>      36.84            -1.6       35.29        perf-profile.calltrace.cycl=
es-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall=
_64
>      24.90            -1.2       23.72        perf-profile.calltrace.cycl=
es-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe
>      19.89            -0.9       18.98        perf-profile.calltrace.cycl=
es-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mrema=
p
>      10.56 =C4=85  2%      -0.8        9.78 =C4=85  2%  perf-profile.call=
trace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kt=
hread
>      10.56 =C4=85  2%      -0.8        9.79 =C4=85  2%  perf-profile.call=
trace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret=
_from_fork
>      10.56 =C4=85  2%      -0.8        9.79 =C4=85  2%  perf-profile.call=
trace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_f=
rom_fork_asm
>      10.57 =C4=85  2%      -0.8        9.80 =C4=85  2%  perf-profile.call=
trace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>      10.52 =C4=85  2%      -0.8        9.75 =C4=85  2%  perf-profile.call=
trace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot=
_thread_fn
>      10.62 =C4=85  2%      -0.8        9.85 =C4=85  2%  perf-profile.call=
trace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
>      10.62 =C4=85  2%      -0.8        9.85 =C4=85  2%  perf-profile.call=
trace.cycles-pp.ret_from_fork.ret_from_fork_asm
>      10.62 =C4=85  2%      -0.8        9.85 =C4=85  2%  perf-profile.call=
trace.cycles-pp.ret_from_fork_asm
>      14.75            -0.7       14.07        perf-profile.calltrace.cycl=
es-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       1.50            -0.6        0.94        perf-profile.calltrace.cycl=
es-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
>       5.88 =C4=85  2%      -0.4        5.47 =C4=85  2%  perf-profile.call=
trace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_k=
softirqd
>       7.80            -0.3        7.47        perf-profile.calltrace.cycl=
es-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL=
_64_after_hwframe
>       4.55 =C4=85  2%      -0.3        4.24 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_so=
ftirqs
>       6.76            -0.3        6.45        perf-profile.calltrace.cycl=
es-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       6.15            -0.3        5.86        perf-profile.calltrace.cycl=
es-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.d=
o_vmi_munmap
>       8.22            -0.3        7.93        perf-profile.calltrace.cycl=
es-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mrem=
ap
>       6.12            -0.3        5.87        perf-profile.calltrace.cycl=
es-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       5.74            -0.2        5.50        perf-profile.calltrace.cycl=
es-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
>       3.16 =C4=85  2%      -0.2        2.94        perf-profile.calltrace=
.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ks=
oftirqd
>       5.50            -0.2        5.28        perf-profile.calltrace.cycl=
es-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vm=
i_munmap
>       1.36            -0.2        1.14        perf-profile.calltrace.cycl=
es-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
>       5.15            -0.2        4.94        perf-profile.calltrace.cycl=
es-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi=
_align_munmap
>       5.51            -0.2        5.31        perf-profile.calltrace.cycl=
es-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       5.16            -0.2        4.97        perf-profile.calltrace.cycl=
es-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
>       2.24            -0.2        2.05        perf-profile.calltrace.cycl=
es-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       2.60 =C4=85  2%      -0.2        2.42 =C4=85  2%  perf-profile.call=
trace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.h=
andle_softirqs
>       4.67            -0.2        4.49        perf-profile.calltrace.cycl=
es-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.cop=
y_vma
>       3.41            -0.2        3.23        perf-profile.calltrace.cycl=
es-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       3.00            -0.2        2.83 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mov=
e_vma
>       0.96            -0.2        0.80        perf-profile.calltrace.cycl=
es-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
>       4.04            -0.2        3.88        perf-profile.calltrace.cycl=
es-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       3.20 =C4=85  2%      -0.2        3.04 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_are=
a_dup.__split_vma.do_vmi_align_munmap
>       3.53            -0.1        3.38        perf-profile.calltrace.cycl=
es-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
>       3.40            -0.1        3.26        perf-profile.calltrace.cycl=
es-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mrema=
p
>       2.20 =C4=85  2%      -0.1        2.06 =C4=85  2%  perf-profile.call=
trace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_a=
lign_munmap.do_vmi_munmap
>       1.84 =C4=85  3%      -0.1        1.71 =C4=85  3%  perf-profile.call=
trace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.anon_v=
ma_clone.__split_vma.do_vmi_align_munmap
>       1.78 =C4=85  2%      -0.1        1.65 =C4=85  3%  perf-profile.call=
trace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       2.69            -0.1        2.56        perf-profile.calltrace.cycl=
es-pp.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap.do_vm=
i_munmap
>       1.78 =C4=85  2%      -0.1        1.66 =C4=85  2%  perf-profile.call=
trace.cycles-pp.__slab_free.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batc=
h.rcu_core
>       1.36 =C4=85  2%      -0.1        1.23 =C4=85  2%  perf-profile.call=
trace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.ru=
n_ksoftirqd
>       0.95            -0.1        0.83        perf-profile.calltrace.cycl=
es-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
>       3.29            -0.1        3.17        perf-profile.calltrace.cycl=
es-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mre=
map
>       2.08            -0.1        1.96        perf-profile.calltrace.cycl=
es-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       1.43 =C4=85  3%      -0.1        1.32 =C4=85  3%  perf-profile.call=
trace.cycles-pp.down_write.vma_prepare.vma_merge.copy_vma.move_vma
>       2.21            -0.1        2.10        perf-profile.calltrace.cycl=
es-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vm=
a
>       2.47            -0.1        2.36        perf-profile.calltrace.cycl=
es-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
>       2.21            -0.1        2.12        perf-profile.calltrace.cycl=
es-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes=
.move_page_tables
>       1.41            -0.1        1.32        perf-profile.calltrace.cycl=
es-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vm=
i_munmap
>       1.26            -0.1        1.18        perf-profile.calltrace.cycl=
es-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.d=
o_vmi_align_munmap
>       1.82            -0.1        1.75        perf-profile.calltrace.cycl=
es-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       0.71            -0.1        0.63        perf-profile.calltrace.cycl=
es-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       1.29            -0.1        1.22        perf-profile.calltrace.cycl=
es-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.mo=
ve_vma
>       0.61            -0.1        0.54        perf-profile.calltrace.cycl=
es-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
>       1.36            -0.1        1.29        perf-profile.calltrace.cycl=
es-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_al=
ign_munmap
>       1.40            -0.1        1.33        perf-profile.calltrace.cycl=
es-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
>       0.70            -0.1        0.64        perf-profile.calltrace.cycl=
es-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
>       1.23            -0.1        1.17        perf-profile.calltrace.cycl=
es-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge.cop=
y_vma
>       1.66            -0.1        1.60        perf-profile.calltrace.cycl=
es-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYS=
CALL_64_after_hwframe
>       1.16            -0.1        1.10        perf-profile.calltrace.cycl=
es-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       0.96            -0.1        0.90        perf-profile.calltrace.cycl=
es-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables=
.unmap_region
>       1.14            -0.1        1.08        perf-profile.calltrace.cycl=
es-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_=
align_munmap
>       0.79            -0.1        0.74        perf-profile.calltrace.cycl=
es-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate=
.__split_vma
>       1.04            -0.1        1.00        perf-profile.calltrace.cycl=
es-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
>       0.58            -0.0        0.53        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64.mremap
>       0.61            -0.0        0.56        perf-profile.calltrace.cycl=
es-pp.__memcg_slab_free_hook.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_bat=
ch.rcu_core
>       0.56            -0.0        0.52        perf-profile.calltrace.cycl=
es-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
>       0.57            -0.0        0.53 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.rcu_do_batch.rcu_core.han=
dle_softirqs
>       0.78            -0.0        0.74        perf-profile.calltrace.cycl=
es-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate=
.vma_merge
>       0.88            -0.0        0.84        perf-profile.calltrace.cycl=
es-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
>       0.70            -0.0        0.66        perf-profile.calltrace.cycl=
es-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys=
_mremap
>       0.68            -0.0        0.64        perf-profile.calltrace.cycl=
es-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_vma._=
_do_sys_mremap
>       0.68            -0.0        0.64        perf-profile.calltrace.cycl=
es-pp.syscall_return_via_sysret.mremap
>       0.97            -0.0        0.93        perf-profile.calltrace.cycl=
es-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       1.11            -0.0        1.08        perf-profile.calltrace.cycl=
es-pp.clear_bhb_loop.mremap
>       0.75            -0.0        0.72        perf-profile.calltrace.cycl=
es-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__spl=
it_vma
>       0.74            -0.0        0.71        perf-profile.calltrace.cycl=
es-pp.kmem_cache_alloc_noprof.anon_vma_clone.copy_vma.move_vma.__do_sys_mre=
map
>       0.60 =C4=85  2%      -0.0        0.57        perf-profile.calltrace=
.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mremap=
.do_syscall_64
>       0.67 =C4=85  2%      -0.0        0.64        perf-profile.calltrace=
.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_=
vma
>       0.82            -0.0        0.79        perf-profile.calltrace.cycl=
es-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwfra=
me.mremap
>       0.63            -0.0        0.60        perf-profile.calltrace.cycl=
es-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mre=
map
>       0.99            -0.0        0.96        perf-profile.calltrace.cycl=
es-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       0.62 =C4=85  2%      -0.0        0.59        perf-profile.calltrace=
.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall=
_64
>       0.87            -0.0        0.84        perf-profile.calltrace.cycl=
es-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.mremap
>       0.78            -0.0        0.75        perf-profile.calltrace.cycl=
es-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
>       0.64            -0.0        0.62        perf-profile.calltrace.cycl=
es-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
>       0.90            -0.0        0.87        perf-profile.calltrace.cycl=
es-pp.mtree_load.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       0.54            -0.0        0.52        perf-profile.calltrace.cycl=
es-pp.__pte_offset_map_lock.move_ptes.move_page_tables.move_vma.__do_sys_mr=
emap
>       1.04            +0.0        1.08        perf-profile.calltrace.cycl=
es-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
>       0.76            +0.1        0.83        perf-profile.calltrace.cycl=
es-pp.__madvise
>       0.63            +0.1        0.70        perf-profile.calltrace.cycl=
es-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madv=
ise
>       0.62            +0.1        0.70        perf-profile.calltrace.cycl=
es-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame.__madvise
>       0.66            +0.1        0.74        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.__madvise
>       0.66            +0.1        0.74        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
>      87.74            +0.7       88.45        perf-profile.calltrace.cycl=
es-pp.mremap
>       0.00            +0.9        0.86        perf-profile.calltrace.cycl=
es-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
>       0.00            +0.9        0.86        perf-profile.calltrace.cycl=
es-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
>      84.88            +0.9       85.77        perf-profile.calltrace.cycl=
es-pp.entry_SYSCALL_64_after_hwframe.mremap
>      84.73            +0.9       85.62        perf-profile.calltrace.cycl=
es-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>       0.00            +0.9        0.92 =C4=85  2%  perf-profile.calltrace=
.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
>      83.84            +0.9       84.78        perf-profile.calltrace.cycl=
es-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>       0.00            +1.1        1.06        perf-profile.calltrace.cycl=
es-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
>       0.00            +1.2        1.21        perf-profile.calltrace.cycl=
es-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
>       2.07            +1.5        3.55        perf-profile.calltrace.cycl=
es-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe
>       1.58            +1.5        3.07        perf-profile.calltrace.cycl=
es-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
>       0.00            +1.5        1.52        perf-profile.calltrace.cycl=
es-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
>       0.00            +1.6        1.57        perf-profile.calltrace.cycl=
es-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
>       0.00            +1.7        1.72        perf-profile.calltrace.cycl=
es-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
>       0.00            +2.0        2.01        perf-profile.calltrace.cycl=
es-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
>       5.39            +2.9        8.32        perf-profile.calltrace.cycl=
es-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwfram=
e.mremap
>      75.29            -1.9       73.37        perf-profile.children.cycle=
s-pp.move_vma
>      37.06            -1.6       35.50        perf-profile.children.cycle=
s-pp.do_vmi_align_munmap
>      24.98            -1.2       23.80        perf-profile.children.cycle=
s-pp.copy_vma
>      19.99            -1.0       19.02        perf-profile.children.cycle=
s-pp.handle_softirqs
>      19.97            -1.0       19.00        perf-profile.children.cycle=
s-pp.rcu_core
>      19.95            -1.0       18.98        perf-profile.children.cycle=
s-pp.rcu_do_batch
>      19.98            -0.9       19.06        perf-profile.children.cycle=
s-pp.__split_vma
>      17.55            -0.8       16.76        perf-profile.children.cycle=
s-pp.kmem_cache_free
>      10.56 =C4=85  2%      -0.8        9.79 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.run_ksoftirqd
>      10.57 =C4=85  2%      -0.8        9.80 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.smpboot_thread_fn
>      15.38            -0.8       14.62        perf-profile.children.cycle=
s-pp.kmem_cache_alloc_noprof
>      10.62 =C4=85  2%      -0.8        9.85 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.kthread
>      10.62 =C4=85  2%      -0.8        9.86 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.ret_from_fork
>      10.62 =C4=85  2%      -0.8        9.86 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.ret_from_fork_asm
>      15.14            -0.7       14.44        perf-profile.children.cycle=
s-pp.vma_merge
>      12.08            -0.5       11.55        perf-profile.children.cycle=
s-pp.__slab_free
>      12.11            -0.5       11.62        perf-profile.children.cycle=
s-pp.mas_wr_store_entry
>      10.86            -0.5       10.39        perf-profile.children.cycle=
s-pp.vm_area_dup
>      11.89            -0.5       11.44        perf-profile.children.cycle=
s-pp.mas_store_prealloc
>       8.49            -0.4        8.06        perf-profile.children.cycle=
s-pp.__memcg_slab_post_alloc_hook
>       9.88            -0.4        9.49        perf-profile.children.cycle=
s-pp.mas_wr_node_store
>       7.91            -0.3        7.58        perf-profile.children.cycle=
s-pp.move_page_tables
>       6.06            -0.3        5.78        perf-profile.children.cycle=
s-pp.vm_area_free_rcu_cb
>       8.28            -0.3        8.00        perf-profile.children.cycle=
s-pp.unmap_region
>       6.69            -0.3        6.42        perf-profile.children.cycle=
s-pp.vma_complete
>       5.06            -0.3        4.80        perf-profile.children.cycle=
s-pp.mas_preallocate
>       5.82            -0.2        5.57        perf-profile.children.cycle=
s-pp.move_ptes
>       4.24            -0.2        4.01        perf-profile.children.cycle=
s-pp.anon_vma_clone
>       3.50            -0.2        3.30        perf-profile.children.cycle=
s-pp.down_write
>       2.44            -0.2        2.25        perf-profile.children.cycle=
s-pp.find_vma_prev
>       3.46            -0.2        3.28        perf-profile.children.cycle=
s-pp.___slab_alloc
>       3.45            -0.2        3.27        perf-profile.children.cycle=
s-pp.free_pgtables
>       2.54            -0.2        2.37        perf-profile.children.cycle=
s-pp.rcu_cblist_dequeue
>       3.35            -0.2        3.18        perf-profile.children.cycle=
s-pp.__memcg_slab_free_hook
>       2.93            -0.2        2.78        perf-profile.children.cycle=
s-pp.mas_alloc_nodes
>       2.28 =C4=85  2%      -0.2        2.12 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.vma_prepare
>       3.46            -0.1        3.32        perf-profile.children.cycle=
s-pp.flush_tlb_mm_range
>       3.41            -0.1        3.27 =C4=85  2%  perf-profile.children.=
cycles-pp.mod_objcg_state
>       2.76            -0.1        2.63        perf-profile.children.cycle=
s-pp.unlink_anon_vmas
>       3.41            -0.1        3.28        perf-profile.children.cycle=
s-pp.mas_store_gfp
>       2.21            -0.1        2.09        perf-profile.children.cycle=
s-pp.__cond_resched
>       2.04            -0.1        1.94        perf-profile.children.cycle=
s-pp.allocate_slab
>       2.10            -0.1        2.00        perf-profile.children.cycle=
s-pp.__call_rcu_common
>       2.51            -0.1        2.40        perf-profile.children.cycle=
s-pp.flush_tlb_func
>       1.04            -0.1        0.94        perf-profile.children.cycle=
s-pp.mas_prev
>       2.71            -0.1        2.61        perf-profile.children.cycle=
s-pp.mtree_load
>       2.23            -0.1        2.14        perf-profile.children.cycle=
s-pp.native_flush_tlb_one_user
>       0.22 =C4=85  5%      -0.1        0.13 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.vm_stat_account
>       0.95            -0.1        0.87        perf-profile.children.cycle=
s-pp.mas_prev_setup
>       1.65            -0.1        1.57        perf-profile.children.cycle=
s-pp.mas_wr_walk
>       1.84            -0.1        1.76        perf-profile.children.cycle=
s-pp.up_write
>       1.27            -0.1        1.20        perf-profile.children.cycle=
s-pp.mas_prev_slot
>       1.84            -0.1        1.77        perf-profile.children.cycle=
s-pp.vma_link
>       1.39            -0.1        1.32        perf-profile.children.cycle=
s-pp.shuffle_freelist
>       0.96            -0.1        0.90 =C4=85  2%  perf-profile.children.=
cycles-pp.rcu_all_qs
>       0.86            -0.1        0.80        perf-profile.children.cycle=
s-pp._raw_spin_lock_irqsave
>       1.70            -0.1        1.64        perf-profile.children.cycle=
s-pp.__get_unmapped_area
>       0.34 =C4=85  3%      -0.1        0.29 =C4=85  5%  perf-profile.chil=
dren.cycles-pp.security_vm_enough_memory_mm
>       0.60            -0.0        0.55        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64
>       0.92            -0.0        0.87        perf-profile.children.cycle=
s-pp.percpu_counter_add_batch
>       1.07            -0.0        1.02        perf-profile.children.cycle=
s-pp.vma_to_resize
>       1.59            -0.0        1.54        perf-profile.children.cycle=
s-pp.mas_update_gap
>       0.44 =C4=85  2%      -0.0        0.40 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.native_queued_spin_lock_slowpath
>       0.70            -0.0        0.66        perf-profile.children.cycle=
s-pp.syscall_return_via_sysret
>       1.13            -0.0        1.09        perf-profile.children.cycle=
s-pp.mt_find
>       0.20 =C4=85  6%      -0.0        0.17 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.cap_vm_enough_memory
>       0.99            -0.0        0.95        perf-profile.children.cycle=
s-pp.mas_pop_node
>       0.63 =C4=85  2%      -0.0        0.59        perf-profile.children.=
cycles-pp.security_mmap_addr
>       0.62            -0.0        0.59        perf-profile.children.cycle=
s-pp.__put_partials
>       1.17            -0.0        1.14        perf-profile.children.cycle=
s-pp.clear_bhb_loop
>       0.46            -0.0        0.43 =C4=85  2%  perf-profile.children.=
cycles-pp.__alloc_pages_noprof
>       0.44            -0.0        0.41 =C4=85  2%  perf-profile.children.=
cycles-pp.get_page_from_freelist
>       0.90            -0.0        0.87        perf-profile.children.cycle=
s-pp.userfaultfd_unmap_complete
>       0.64 =C4=85  2%      -0.0        0.62        perf-profile.children.=
cycles-pp.get_old_pud
>       1.07            -0.0        1.05        perf-profile.children.cycle=
s-pp.mas_leaf_max_gap
>       0.22 =C4=85  3%      -0.0        0.20 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.__rmqueue_pcplist
>       0.55            -0.0        0.53        perf-profile.children.cycle=
s-pp.refill_obj_stock
>       0.25            -0.0        0.23 =C4=85  3%  perf-profile.children.=
cycles-pp.rmqueue
>       0.48            -0.0        0.45        perf-profile.children.cycle=
s-pp.mremap_userfaultfd_prep
>       0.33            -0.0        0.30        perf-profile.children.cycle=
s-pp.free_unref_page
>       0.46            -0.0        0.44        perf-profile.children.cycle=
s-pp.setup_object
>       0.21 =C4=85  3%      -0.0        0.19 =C4=85  2%  perf-profile.chil=
dren.cycles-pp.rmqueue_bulk
>       0.31 =C4=85  3%      -0.0        0.29        perf-profile.children.=
cycles-pp.__vm_enough_memory
>       0.40            -0.0        0.38        perf-profile.children.cycle=
s-pp.entry_SYSRETQ_unsafe_stack
>       0.36            -0.0        0.35        perf-profile.children.cycle=
s-pp.madvise_vma_behavior
>       0.54            -0.0        0.53 =C4=85  2%  perf-profile.children.=
cycles-pp.mas_wr_end_piv
>       0.46            -0.0        0.44 =C4=85  2%  perf-profile.children.=
cycles-pp.rcu_segcblist_enqueue
>       0.34            -0.0        0.32 =C4=85  2%  perf-profile.children.=
cycles-pp.mas_destroy
>       0.28            -0.0        0.26 =C4=85  3%  perf-profile.children.=
cycles-pp.mas_wr_store_setup
>       0.30            -0.0        0.28        perf-profile.children.cycle=
s-pp.pte_offset_map_nolock
>       0.19            -0.0        0.18 =C4=85  2%  perf-profile.children.=
cycles-pp.__thp_vma_allowable_orders
>       0.08 =C4=85  4%      -0.0        0.07        perf-profile.children.=
cycles-pp.ksm_madvise
>       0.17            -0.0        0.16        perf-profile.children.cycle=
s-pp.get_any_partial
>       0.08            -0.0        0.07        perf-profile.children.cycle=
s-pp.syscall_exit_to_user_mode_prepare
>       0.45            +0.0        0.47        perf-profile.children.cycle=
s-pp._raw_spin_lock
>       1.10            +0.0        1.14        perf-profile.children.cycle=
s-pp.zap_pte_range
>       0.78            +0.1        0.85        perf-profile.children.cycle=
s-pp.__madvise
>       0.63            +0.1        0.70        perf-profile.children.cycle=
s-pp.__x64_sys_madvise
>       0.62            +0.1        0.70        perf-profile.children.cycle=
s-pp.do_madvise
>       0.00            +0.1        0.09 =C4=85  4%  perf-profile.children.=
cycles-pp.can_modify_mm_madv
>       1.32            +0.1        1.46        perf-profile.children.cycle=
s-pp.mas_next_slot
>      88.13            +0.7       88.83        perf-profile.children.cycle=
s-pp.mremap
>      83.94            +0.9       84.88        perf-profile.children.cycle=
s-pp.__do_sys_mremap
>      86.06            +0.9       87.00        perf-profile.children.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
>      85.56            +1.0       86.54        perf-profile.children.cycle=
s-pp.do_syscall_64
>      40.49            +1.4       41.90        perf-profile.children.cycle=
s-pp.do_vmi_munmap
>       2.10            +1.5        3.57        perf-profile.children.cycle=
s-pp.do_munmap
>       3.62            +2.3        5.90        perf-profile.children.cycle=
s-pp.mas_walk
>       5.44            +2.9        8.38        perf-profile.children.cycle=
s-pp.mremap_to
>       5.30            +3.1        8.39        perf-profile.children.cycle=
s-pp.mas_find
>       0.00            +5.4        5.40        perf-profile.children.cycle=
s-pp.can_modify_mm
>      11.46            -0.5       10.96        perf-profile.self.cycles-pp=
.__slab_free
>       4.30            -0.2        4.08        perf-profile.self.cycles-pp=
.__memcg_slab_post_alloc_hook
>       2.51            -0.2        2.34        perf-profile.self.cycles-pp=
.rcu_cblist_dequeue
>       2.41 =C4=85  2%      -0.2        2.25        perf-profile.self.cycl=
es-pp.down_write
>       2.21            -0.1        2.11        perf-profile.self.cycles-pp=
.native_flush_tlb_one_user
>       2.37            -0.1        2.28        perf-profile.self.cycles-pp=
.mtree_load
>       1.60            -0.1        1.51        perf-profile.self.cycles-pp=
.__memcg_slab_free_hook
>       0.18 =C4=85  3%      -0.1        0.10 =C4=85 15%  perf-profile.self=
.cycles-pp.vm_stat_account
>       1.25            -0.1        1.18        perf-profile.self.cycles-pp=
.move_vma
>       1.76            -0.1        1.69        perf-profile.self.cycles-pp=
.mod_objcg_state
>       1.42            -0.1        1.35 =C4=85  2%  perf-profile.self.cycl=
es-pp.__call_rcu_common
>       1.41            -0.1        1.34        perf-profile.self.cycles-pp=
.mas_wr_walk
>       1.52            -0.1        1.46        perf-profile.self.cycles-pp=
.up_write
>       1.02            -0.1        0.95        perf-profile.self.cycles-pp=
.mas_prev_slot
>       0.96            -0.1        0.90 =C4=85  2%  perf-profile.self.cycl=
es-pp.vm_area_free_rcu_cb
>       1.50            -0.1        1.45        perf-profile.self.cycles-pp=
.kmem_cache_free
>       0.69 =C4=85  3%      -0.1        0.64 =C4=85  2%  perf-profile.self=
.cycles-pp.rcu_all_qs
>       1.14 =C4=85  2%      -0.1        1.09        perf-profile.self.cycl=
es-pp.shuffle_freelist
>       1.10            -0.1        1.05        perf-profile.self.cycles-pp=
.__cond_resched
>       1.40            -0.0        1.35        perf-profile.self.cycles-pp=
.do_vmi_align_munmap
>       0.99            -0.0        0.94        perf-profile.self.cycles-pp=
.mas_preallocate
>       0.88            -0.0        0.83        perf-profile.self.cycles-pp=
.___slab_alloc
>       0.55            -0.0        0.50        perf-profile.self.cycles-pp=
.mremap_to
>       0.98            -0.0        0.93        perf-profile.self.cycles-pp=
.move_ptes
>       0.78            -0.0        0.74        perf-profile.self.cycles-pp=
.percpu_counter_add_batch
>       0.21 =C4=85  2%      -0.0        0.18 =C4=85  2%  perf-profile.self=
.cycles-pp.entry_SYSCALL_64
>       0.44 =C4=85  2%      -0.0        0.40 =C4=85  2%  perf-profile.self=
.cycles-pp.native_queued_spin_lock_slowpath
>       0.92            -0.0        0.89        perf-profile.self.cycles-pp=
.mas_store_gfp
>       0.86            -0.0        0.82        perf-profile.self.cycles-pp=
.mas_pop_node
>       0.50            -0.0        0.46        perf-profile.self.cycles-pp=
.entry_SYSCALL_64_after_hwframe
>       1.15            -0.0        1.12        perf-profile.self.cycles-pp=
.clear_bhb_loop
>       1.14            -0.0        1.11        perf-profile.self.cycles-pp=
.vma_merge
>       0.66            -0.0        0.63        perf-profile.self.cycles-pp=
.__split_vma
>       0.16 =C4=85  6%      -0.0        0.13 =C4=85  7%  perf-profile.self=
.cycles-pp.cap_vm_enough_memory
>       0.82            -0.0        0.79        perf-profile.self.cycles-pp=
.mas_wr_store_entry
>       0.54 =C4=85  2%      -0.0        0.52        perf-profile.self.cycl=
es-pp.get_old_pud
>       0.43            -0.0        0.40        perf-profile.self.cycles-pp=
.do_munmap
>       0.51 =C4=85  2%      -0.0        0.48 =C4=85  2%  perf-profile.self=
.cycles-pp.security_mmap_addr
>       0.50            -0.0        0.48        perf-profile.self.cycles-pp=
.refill_obj_stock
>       0.24            -0.0        0.22        perf-profile.self.cycles-pp=
.mas_prev
>       0.71            -0.0        0.69        perf-profile.self.cycles-pp=
.unmap_page_range
>       0.48            -0.0        0.45        perf-profile.self.cycles-pp=
.find_vma_prev
>       0.42            -0.0        0.40        perf-profile.self.cycles-pp=
._raw_spin_lock_irqsave
>       0.66            -0.0        0.64        perf-profile.self.cycles-pp=
.mas_store_prealloc
>       0.31            -0.0        0.29        perf-profile.self.cycles-pp=
.mas_prev_setup
>       0.43            -0.0        0.41        perf-profile.self.cycles-pp=
.mas_wr_end_piv
>       0.78            -0.0        0.76        perf-profile.self.cycles-pp=
.userfaultfd_unmap_complete
>       0.28            -0.0        0.26 =C4=85  2%  perf-profile.self.cycl=
es-pp.mas_put_in_tree
>       0.42            -0.0        0.40        perf-profile.self.cycles-pp=
.mremap_userfaultfd_prep
>       0.28            -0.0        0.26        perf-profile.self.cycles-pp=
.free_pgtables
>       0.39            -0.0        0.37        perf-profile.self.cycles-pp=
.entry_SYSRETQ_unsafe_stack
>       0.30 =C4=85  2%      -0.0        0.28        perf-profile.self.cycl=
es-pp.zap_pmd_range
>       0.32            -0.0        0.31        perf-profile.self.cycles-pp=
.unmap_vmas
>       0.21            -0.0        0.20        perf-profile.self.cycles-pp=
.__get_unmapped_area
>       0.18 =C4=85  2%      -0.0        0.17 =C4=85  2%  perf-profile.self=
.cycles-pp.lru_add_drain_cpu
>       0.06            -0.0        0.05        perf-profile.self.cycles-pp=
.ksm_madvise
>       0.45            +0.0        0.46        perf-profile.self.cycles-pp=
.do_vmi_munmap
>       0.37            +0.0        0.39        perf-profile.self.cycles-pp=
._raw_spin_lock
>       1.06            +0.1        1.18        perf-profile.self.cycles-pp=
.mas_next_slot
>       1.50            +0.5        1.97        perf-profile.self.cycles-pp=
.mas_find
>       0.00            +1.4        1.35        perf-profile.self.cycles-pp=
.can_modify_mm
>       3.13            +2.0        5.13        perf-profile.self.cycles-pp=
.mas_walk
>
>
> *************************************************************************=
**************************
> lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sa=
pphire Rapids) with 256G memory
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testc=
ase/testtime:
>   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/l=
kp-spr-r02/pkey/stress-ng/60s
>
> commit:
>   ff388fe5c4 ("mseal: wire up mseal syscall")
>   8be7258aad ("mseal: add mseal syscall")
>
> ff388fe5c481d39c 8be7258aad44b5e25977a98db13
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>      10539            -2.5%      10273        vmstat.system.cs
>       0.28 =C4=85  5%     -20.1%       0.22 =C4=85  7%  sched_debug.cfs_r=
q:/.h_nr_running.stddev
>       1419 =C4=85  7%     -15.3%       1202 =C4=85  6%  sched_debug.cfs_r=
q:/.util_avg.max
>       0.28 =C4=85  6%     -18.4%       0.23 =C4=85  8%  sched_debug.cpu.n=
r_running.stddev
>  8.736e+08            -3.6%  8.423e+08        stress-ng.pkey.ops
>   14560560            -3.6%   14038795        stress-ng.pkey.ops_per_sec
>     770.39 =C4=85  4%      -5.0%     732.04        stress-ng.time.user_ti=
me
>     244657 =C4=85  3%      +5.8%     258782 =C4=85  3%  proc-vmstat.nr_sl=
ab_unreclaimable
>   73133541            -2.1%   71588873        proc-vmstat.numa_hit
>   72873579            -2.1%   71357274        proc-vmstat.numa_local
>  1.842e+08            -2.5%  1.796e+08        proc-vmstat.pgalloc_normal
>  1.767e+08            -2.8%  1.717e+08        proc-vmstat.pgfree
>    1345346 =C4=85 40%     -73.1%     362064 =C4=85124%  numa-vmstat.node0=
.nr_inactive_anon
>    1345340 =C4=85 40%     -73.1%     362062 =C4=85124%  numa-vmstat.node0=
.nr_zone_inactive_anon
>    2420830 =C4=85 14%     +35.1%    3270248 =C4=85 16%  numa-vmstat.node1=
.nr_file_pages
>    2067871 =C4=85 13%     +51.5%    3132982 =C4=85 17%  numa-vmstat.node1=
.nr_inactive_anon
>     191406 =C4=85 17%     +33.6%     255808 =C4=85 14%  numa-vmstat.node1=
.nr_mapped
>       2452 =C4=85 61%    +104.4%       5012 =C4=85 35%  numa-vmstat.node1=
.nr_page_table_pages
>    2067853 =C4=85 13%     +51.5%    3132966 =C4=85 17%  numa-vmstat.node1=
.nr_zone_inactive_anon
>    5379238 =C4=85 40%     -73.0%    1453605 =C4=85123%  numa-meminfo.node=
0.Inactive
>    5379166 =C4=85 40%     -73.0%    1453462 =C4=85123%  numa-meminfo.node=
0.Inactive(anon)
>    8741077 =C4=85 22%     -36.7%    5531290 =C4=85 28%  numa-meminfo.node=
0.MemUsed
>    9651902 =C4=85 13%     +35.8%   13105318 =C4=85 16%  numa-meminfo.node=
1.FilePages
>    8239855 =C4=85 13%     +52.4%   12556929 =C4=85 17%  numa-meminfo.node=
1.Inactive
>    8239712 =C4=85 13%     +52.4%   12556853 =C4=85 17%  numa-meminfo.node=
1.Inactive(anon)
>     761944 =C4=85 18%     +34.6%    1025906 =C4=85 14%  numa-meminfo.node=
1.Mapped
>   11679628 =C4=85 11%     +31.2%   15322841 =C4=85 14%  numa-meminfo.node=
1.MemUsed
>       9874 =C4=85 62%    +104.6%      20200 =C4=85 36%  numa-meminfo.node=
1.PageTables
>       0.74            -4.2%       0.71        perf-stat.i.MPKI
>  1.245e+11            +2.3%  1.274e+11        perf-stat.i.branch-instruct=
ions
>       0.37            -0.0        0.35        perf-stat.i.branch-miss-rat=
e%
>  4.359e+08            -2.1%  4.265e+08        perf-stat.i.branch-misses
>  4.672e+08            -2.6%  4.548e+08        perf-stat.i.cache-misses
>  7.276e+08            -2.7%  7.082e+08        perf-stat.i.cache-reference=
s
>       1.00            -1.6%       0.98        perf-stat.i.cpi
>       1364            +2.9%       1404        perf-stat.i.cycles-between-=
cache-misses
>  6.392e+11            +1.7%  6.499e+11        perf-stat.i.instructions
>       1.00            +1.6%       1.02        perf-stat.i.ipc
>       0.74            -4.3%       0.71        perf-stat.overall.MPKI
>       0.35            -0.0        0.33        perf-stat.overall.branch-mi=
ss-rate%
>       1.00            -1.6%       0.99        perf-stat.overall.cpi
>       1356            +2.9%       1395        perf-stat.overall.cycles-be=
tween-cache-misses
>       1.00            +1.6%       1.01        perf-stat.overall.ipc
>  1.209e+11            +1.9%  1.232e+11        perf-stat.ps.branch-instruc=
tions
>  4.188e+08            -2.6%  4.077e+08        perf-stat.ps.branch-misses
>  4.585e+08            -3.1%  4.441e+08        perf-stat.ps.cache-misses
>  7.124e+08            -3.1%  6.901e+08        perf-stat.ps.cache-referenc=
es
>      10321            -2.6%      10053        perf-stat.ps.context-switch=
es
>
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

