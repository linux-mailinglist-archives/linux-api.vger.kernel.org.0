Return-Path: <linux-api+bounces-2136-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625E9493E0
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 16:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C61C210D4
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363F1D47D7;
	Tue,  6 Aug 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMER4UaT"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA317ADF9
	for <linux-api@vger.kernel.org>; Tue,  6 Aug 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956111; cv=none; b=FUE/iWrFgy/xPzrmp3b/uU7yLUtQlqflJxjmQqyyrsaxp0z6QfXSksbMvfvkekeHsZIoqMvKh6XUiI3vfIn6Wyja6d/AXfU3AnwZKePseseWRZzEKqrmBZTsLqUSLAtLU29QgaZKnTJkJMapWdJxTi/n6CH3zpR6MihmQ/7mif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956111; c=relaxed/simple;
	bh=ZuUg4OalQdGKgIoAQI+PyCgqiEe8M/Fag9VYYgDgNCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WF+4D3d83ns4/unHb+OkZUiHizXB7xs4186HnIILifISETuwdsFX71Uoh48oJPkDOO69LJOCJIZpNrN0kJvDn/mSOuC+7oD5ilFHxLCc4J3kGmZFHBpL2wi+Id0+oOK52qwsmqSVyauQGkhYsIjhxZfevGDTTCiX3m7K7iLlIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMER4UaT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so13463a12.1
        for <linux-api@vger.kernel.org>; Tue, 06 Aug 2024 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722956107; x=1723560907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBBxdc8bnzvCBuar3L4/asJ+JBse0+IGn7z4RiiPF2o=;
        b=EMER4UaTe08qUbhOZjPxOtC1i1HFBt4cjWLkWe1bfBZhsAfLERPS5ckv7lYqotWFuN
         +UPsto2S5U24IH65DTL4ltPjj0/2TBd16X4QPcgOcysv0dnT1o4bvoIsGR7AxDQx6vZ9
         MOHVuknBTk0arMCf8acAKAjGxoxDNoyVmG3ByVA5KcLTDDNFo31TxpitFHFFU0cBj33e
         bKdtSMkgyAi5F4TzSd5aEIVJAYAl0sggY473l/AA4CyxLOR8QT8dyH9CKG8BY8caPNsc
         OrUPH1a4S0jM5tW7VQ04lSw6pk1E6M8oEyBnQ8w6YaAnxiPSEA49IjymBji2RrJcbU3x
         SKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722956107; x=1723560907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBBxdc8bnzvCBuar3L4/asJ+JBse0+IGn7z4RiiPF2o=;
        b=fimc7OV5TsSq6QP46gGah4uBTauWFiL+T3bvdTvXkQkaU81qjtkamNY2C4w982zXQ+
         AXG3Q1sWuXZrrtjFzL1DLiT0LEIvrJeKtDD+kWplJSOIjGvB/Mwvwz6t0ExkY6nzKtlu
         r8A6JpuUfmO6GDGu8l79CsVLw3+EQuGIB41dFJop77Ao69xcxSmDPS+Vfp5tQyGDxE9e
         JEsx2a4iD1RSni1t4HJ+OsGfSbU0/4YIBFy3/87J8vmkKsUGTejbUSP0sbhc/s/SplkO
         A3ZHL1xuUfYXE2Lh28WLA1llcvy67DdwW/C5cUTkFX8/+HLQKd8boj2vJX63SSFvoB9e
         jCkg==
X-Forwarded-Encrypted: i=1; AJvYcCXwMWKnLkeXoq/mnAQskFBmfD9p3T1RlwkkEIiPCwf9iDPI8sXM5NNwJYr2MIGywYSKjhlJehL1r1E2/Kdc1uCcAPHZL92Veme+
X-Gm-Message-State: AOJu0YzzqFM9kUWU4UjTb8zR4DTFrw4d3sGNHZOq9XDzAgwXhw0Ri5H5
	UHTXl3ad2aeV6suv0dtp5LnIfaJqDmTFs1Msy3BbFUhWp6DsAQa0aSwKQ4srt9J4/5GsI/3Xm9L
	m33K0nuExbKLl5rSdUB5S8lBBLmQnVClp895M
X-Google-Smtp-Source: AGHT+IGkZ+ztJ5NLBz2ZoImMd6+BYx8pZh/l1H0iIsjgmCdJg8JIP0wyAQ2+Hrk06elEbxHBIA2RpBwoeS2/rS9EBmQ=
X-Received: by 2002:a05:6402:51c7:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5bb98115352mr179862a12.0.1722956106217; Tue, 06 Aug 2024
 07:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CABi2SkWco0svzUqCK8OsTmivXTvoWUHrE6AJxpm=NaT2uMb=WA@mail.gmail.com>
 <ZrF/9+Z/h7wlLub4@xsang-OptiPlex-9020>
In-Reply-To: <ZrF/9+Z/h7wlLub4@xsang-OptiPlex-9020>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 6 Aug 2024 07:54:26 -0700
Message-ID: <CALmYWFsU60dB78gHiQZH+7vsEWZH93kBQ04zYE0SjHwbsjJavA@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	=?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:44=E2=80=AFPM Oliver Sang <oliver.sang@intel.com> =
wrote:
>
> hi, Jeff,
>
> On Mon, Aug 05, 2024 at 09:58:33AM -0700, Jeff Xu wrote:
> > On Sun, Aug 4, 2024 at 1:59=E2=80=AFAM kernel test robot <oliver.sang@i=
ntel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed a -4.4% regression of stress-ng.pagemove.pa=
ge_remaps_per_sec on:
> > >
> > >
> > > commit: 8be7258aad44b5e25977a98db136f677fa6f4370 ("mseal: add mseal s=
yscall")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git maste=
r
> > >
> > > testcase: stress-ng
> > > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3=
.10GHz (Ice Lake) with 256G memory
> > > parameters:
> > >
> > >         nr_threads: 100%
> > >         testtime: 60s
> > >         test: pagemove
> > >         cpufreq_governor: performance
> > >
> > >
> > > In addition to that, the commit also has significant impact on the fo=
llowing tests:
> > >
> > > +------------------+-------------------------------------------------=
--------------------------------------------+
> > > | testcase: change | stress-ng: stress-ng.pkey.ops_per_sec -3.6% regr=
ession                                      |
> > > | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum =
8480CTDX (Sapphire Rapids) with 256G memory |
> > > | test parameters  | cpufreq_governor=3Dperformance                  =
                                              |
> > > |                  | nr_threads=3D100%                               =
                                              |
> > > |                  | test=3Dpkey                                     =
                                              |
> > > |                  | testtime=3D60s                                  =
                                              |
> > > +------------------+-------------------------------------------------=
--------------------------------------------+
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202408041602.caa0372-oliver.=
sang@intel.com
> > >
> > >
> > > Details are as below:
> > > ---------------------------------------------------------------------=
----------------------------->
> > >
> > >
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20240804/202408041602.caa0372=
-oliver.sang@intel.com
> > >
> > There is an error when I try to reproduce the test:
>
> what's your os? we support some distributions
> https://github.com/intel/lkp-tests?tab=3Dreadme-ov-file#supported-distrib=
utions
>
> >
> > bin/lkp install job.yaml
> >
> > --------------------------------------------------------
> > Some packages could not be installed. This may mean that you have
> > requested an impossible situation or if you are using the unstable
> > distribution that some required packages have not yet been created
> > or been moved out of Incoming.
> > The following information may help to resolve the situation:
> >
> > The following packages have unmet dependencies:
> >  libdw1 : Depends: libelf1 (=3D 0.190-1+b1)
> >  libdw1t64 : Breaks: libdw1 (< 0.191-2)
> > E: Unable to correct problems, you have held broken packages.
> > Cannot install some packages of perf-c2c depends
> > -----------------------------------------------------------------------=
------------------
> >
> > And where is stress-ng.pagemove.page_remaps_per_sec test implemented,
> > is that part of lkp-tests ?
>
> stress-ng is in https://github.com/ColinIanKing/stress-ng
>
I will try this route first.

Thanks
-Jeff

> >
> > Thanks
> > -Jeff
> >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/t=
estcase/testtime:
> > >   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.c=
gz/lkp-icl-2sp7/pagemove/stress-ng/60s
> > >
> > > commit:
> > >   ff388fe5c4 ("mseal: wire up mseal syscall")
> > >   8be7258aad ("mseal: add mseal syscall")
> > >
> > > ff388fe5c481d39c 8be7258aad44b5e25977a98db13
> > > ---------------- ---------------------------
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >   41625945            -4.3%   39842322        proc-vmstat.numa_hit
> > >   41559175            -4.3%   39774160        proc-vmstat.numa_local
> > >   77484314            -4.4%   74105555        proc-vmstat.pgalloc_nor=
mal
> > >   77205752            -4.4%   73826672        proc-vmstat.pgfree
> > >   18361466            -4.2%   17596652        stress-ng.pagemove.ops
> > >     306014            -4.2%     293262        stress-ng.pagemove.ops_=
per_sec
> > >     205312            -4.4%     196176        stress-ng.pagemove.page=
_remaps_per_sec
> > >       4961            +1.0%       5013        stress-ng.time.percent_=
of_cpu_this_job_got
> > >       2917            +1.2%       2952        stress-ng.time.system_t=
ime
> > >       1.07            -6.6%       1.00        perf-stat.i.MPKI
> > >  3.354e+10            +3.5%  3.473e+10        perf-stat.i.branch-inst=
ructions
> > >  1.795e+08            -4.2%  1.719e+08        perf-stat.i.cache-misse=
s
> > >  2.376e+08            -4.1%  2.279e+08        perf-stat.i.cache-refer=
ences
> > >       1.13            -3.0%       1.10        perf-stat.i.cpi
> > >       1077            +4.3%       1124        perf-stat.i.cycles-betw=
een-cache-misses
> > >  1.717e+11            +2.7%  1.762e+11        perf-stat.i.instruction=
s
> > >       0.88            +3.1%       0.91        perf-stat.i.ipc
> > >       1.05            -6.8%       0.97        perf-stat.overall.MPKI
> > >       0.25 =C4=85  2%      -0.0        0.24        perf-stat.overall.=
branch-miss-rate%
> > >       1.13            -3.0%       1.10        perf-stat.overall.cpi
> > >       1084            +4.0%       1127        perf-stat.overall.cycle=
s-between-cache-misses
> > >       0.88            +3.1%       0.91        perf-stat.overall.ipc
> > >  3.298e+10            +3.5%  3.415e+10        perf-stat.ps.branch-ins=
tructions
> > >  1.764e+08            -4.3%  1.689e+08        perf-stat.ps.cache-miss=
es
> > >  2.336e+08            -4.1%   2.24e+08        perf-stat.ps.cache-refe=
rences
> > >     194.57            -2.4%     189.96 =C4=85  2%  perf-stat.ps.cpu-m=
igrations
> > >  1.688e+11            +2.7%  1.733e+11        perf-stat.ps.instructio=
ns
> > >  1.036e+13            +3.0%  1.068e+13        perf-stat.total.instruc=
tions
> > >      75.12            -1.9       73.22        perf-profile.calltrace.=
cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwf=
rame.mremap
> > >      36.84            -1.6       35.29        perf-profile.calltrace.=
cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_sys=
call_64
> > >      24.90            -1.2       23.72        perf-profile.calltrace.=
cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_=
after_hwframe
> > >      19.89            -0.9       18.98        perf-profile.calltrace.=
cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_m=
remap
> > >      10.56 =C4=85  2%      -0.8        9.78 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_f=
n.kthread
> > >      10.56 =C4=85  2%      -0.8        9.79 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread=
.ret_from_fork
> > >      10.56 =C4=85  2%      -0.8        9.79 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.r=
et_from_fork_asm
> > >      10.57 =C4=85  2%      -0.8        9.80 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_a=
sm
> > >      10.52 =C4=85  2%      -0.8        9.75 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smp=
boot_thread_fn
> > >      10.62 =C4=85  2%      -0.8        9.85 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
> > >      10.62 =C4=85  2%      -0.8        9.85 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
> > >      10.62 =C4=85  2%      -0.8        9.85 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.ret_from_fork_asm
> > >      14.75            -0.7       14.07        perf-profile.calltrace.=
cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> > >       1.50            -0.6        0.94        perf-profile.calltrace.=
cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
> > >       5.88 =C4=85  2%      -0.4        5.47 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.r=
un_ksoftirqd
> > >       7.80            -0.3        7.47        perf-profile.calltrace.=
cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYS=
CALL_64_after_hwframe
> > >       4.55 =C4=85  2%      -0.3        4.24 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handl=
e_softirqs
> > >       6.76            -0.3        6.45        perf-profile.calltrace.=
cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vm=
a
> > >       6.15            -0.3        5.86        perf-profile.calltrace.=
cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munm=
ap.do_vmi_munmap
> > >       8.22            -0.3        7.93        perf-profile.calltrace.=
cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_=
mremap
> > >       6.12            -0.3        5.87        perf-profile.calltrace.=
cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_v=
ma
> > >       5.74            -0.2        5.50        perf-profile.calltrace.=
cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
> > >       3.16 =C4=85  2%      -0.2        2.94        perf-profile.callt=
race.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.ru=
n_ksoftirqd
> > >       5.50            -0.2        5.28        perf-profile.calltrace.=
cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.d=
o_vmi_munmap
> > >       1.36            -0.2        1.14        perf-profile.calltrace.=
cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
> > >       5.15            -0.2        4.94        perf-profile.calltrace.=
cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do=
_vmi_align_munmap
> > >       5.51            -0.2        5.31        perf-profile.calltrace.=
cycles-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
> > >       5.16            -0.2        4.97        perf-profile.calltrace.=
cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
> > >       2.24            -0.2        2.05        perf-profile.calltrace.=
cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> > >       2.60 =C4=85  2%      -0.2        2.42 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_co=
re.handle_softirqs
> > >       4.67            -0.2        4.49        perf-profile.calltrace.=
cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge=
.copy_vma
> > >       3.41            -0.2        3.23        perf-profile.calltrace.=
cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move=
_vma
> > >       3.00            -0.2        2.83 =C4=85  2%  perf-profile.callt=
race.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap=
.move_vma
> > >       0.96            -0.2        0.80        perf-profile.calltrace.=
cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
> > >       4.04            -0.2        3.88        perf-profile.calltrace.=
cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> > >       3.20 =C4=85  2%      -0.2        3.04 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm=
_area_dup.__split_vma.do_vmi_align_munmap
> > >       3.53            -0.1        3.38        perf-profile.calltrace.=
cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mr=
emap
> > >       3.40            -0.1        3.26        perf-profile.calltrace.=
cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_m=
remap
> > >       2.20 =C4=85  2%      -0.1        2.06 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_v=
mi_align_munmap.do_vmi_munmap
> > >       1.84 =C4=85  3%      -0.1        1.71 =C4=85  3%  perf-profile.=
calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.an=
on_vma_clone.__split_vma.do_vmi_align_munmap
> > >       1.78 =C4=85  2%      -0.1        1.65 =C4=85  3%  perf-profile.=
calltrace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
> > >       2.69            -0.1        2.56        perf-profile.calltrace.=
cycles-pp.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap.d=
o_vmi_munmap
> > >       1.78 =C4=85  2%      -0.1        1.66 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.__slab_free.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_=
batch.rcu_core
> > >       1.36 =C4=85  2%      -0.1        1.23 =C4=85  2%  perf-profile.=
calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirq=
s.run_ksoftirqd
> > >       0.95            -0.1        0.83        perf-profile.calltrace.=
cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
> > >       3.29            -0.1        3.17        perf-profile.calltrace.=
cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys=
_mremap
> > >       2.08            -0.1        1.96        perf-profile.calltrace.=
cycles-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
> > >       1.43 =C4=85  3%      -0.1        1.32 =C4=85  3%  perf-profile.=
calltrace.cycles-pp.down_write.vma_prepare.vma_merge.copy_vma.move_vma
> > >       2.21            -0.1        2.10        perf-profile.calltrace.=
cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mov=
e_vma
> > >       2.47            -0.1        2.36        perf-profile.calltrace.=
cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move=
_vma
> > >       2.21            -0.1        2.12        perf-profile.calltrace.=
cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_=
ptes.move_page_tables
> > >       1.41            -0.1        1.32        perf-profile.calltrace.=
cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.d=
o_vmi_munmap
> > >       1.26            -0.1        1.18        perf-profile.calltrace.=
cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_v=
ma.do_vmi_align_munmap
> > >       1.82            -0.1        1.75        perf-profile.calltrace.=
cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> > >       0.71            -0.1        0.63        perf-profile.calltrace.=
cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
> > >       1.29            -0.1        1.22        perf-profile.calltrace.=
cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munma=
p.move_vma
> > >       0.61            -0.1        0.54        perf-profile.calltrace.=
cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
> > >       1.36            -0.1        1.29        perf-profile.calltrace.=
cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region.do_vm=
i_align_munmap
> > >       1.40            -0.1        1.33        perf-profile.calltrace.=
cycles-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
> > >       0.70            -0.1        0.64        perf-profile.calltrace.=
cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
> > >       1.23            -0.1        1.17        perf-profile.calltrace.=
cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge=
.copy_vma
> > >       1.66            -0.1        1.60        perf-profile.calltrace.=
cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry=
_SYSCALL_64_after_hwframe
> > >       1.16            -0.1        1.10        perf-profile.calltrace.=
cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
> > >       0.96            -0.1        0.90        perf-profile.calltrace.=
cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgta=
bles.unmap_region
> > >       1.14            -0.1        1.08        perf-profile.calltrace.=
cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_=
vmi_align_munmap
> > >       0.79            -0.1        0.74        perf-profile.calltrace.=
cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallo=
cate.__split_vma
> > >       1.04            -0.1        1.00        perf-profile.calltrace.=
cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
> > >       0.58            -0.0        0.53        perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64.mremap
> > >       0.61            -0.0        0.56        perf-profile.calltrace.=
cycles-pp.__memcg_slab_free_hook.kmem_cache_free.vm_area_free_rcu_cb.rcu_do=
_batch.rcu_core
> > >       0.56            -0.0        0.52        perf-profile.calltrace.=
cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
> > >       0.57            -0.0        0.53 =C4=85  2%  perf-profile.callt=
race.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.rcu_do_batch.rcu_core=
.handle_softirqs
> > >       0.78            -0.0        0.74        perf-profile.calltrace.=
cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallo=
cate.vma_merge
> > >       0.88            -0.0        0.84        perf-profile.calltrace.=
cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
> > >       0.70            -0.0        0.66        perf-profile.calltrace.=
cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do=
_sys_mremap
> > >       0.68            -0.0        0.64        perf-profile.calltrace.=
cycles-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_v=
ma.__do_sys_mremap
> > >       0.68            -0.0        0.64        perf-profile.calltrace.=
cycles-pp.syscall_return_via_sysret.mremap
> > >       0.97            -0.0        0.93        perf-profile.calltrace.=
cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mrem=
ap
> > >       1.11            -0.0        1.08        perf-profile.calltrace.=
cycles-pp.clear_bhb_loop.mremap
> > >       0.75            -0.0        0.72        perf-profile.calltrace.=
cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup._=
_split_vma
> > >       0.74            -0.0        0.71        perf-profile.calltrace.=
cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.copy_vma.move_vma.__do_sys=
_mremap
> > >       0.60 =C4=85  2%      -0.0        0.57        perf-profile.callt=
race.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mr=
emap.do_syscall_64
> > >       0.67 =C4=85  2%      -0.0        0.64        perf-profile.callt=
race.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.m=
ove_vma
> > >       0.82            -0.0        0.79        perf-profile.calltrace.=
cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_h=
wframe.mremap
> > >       0.63            -0.0        0.60        perf-profile.calltrace.=
cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys=
_mremap
> > >       0.99            -0.0        0.96        perf-profile.calltrace.=
cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
> > >       0.62 =C4=85  2%      -0.0        0.59        perf-profile.callt=
race.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_sys=
call_64
> > >       0.87            -0.0        0.84        perf-profile.calltrace.=
cycles-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SY=
SCALL_64_after_hwframe.mremap
> > >       0.78            -0.0        0.75        perf-profile.calltrace.=
cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
> > >       0.64            -0.0        0.62        perf-profile.calltrace.=
cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
> > >       0.90            -0.0        0.87        perf-profile.calltrace.=
cycles-pp.mtree_load.vma_merge.copy_vma.move_vma.__do_sys_mremap
> > >       0.54            -0.0        0.52        perf-profile.calltrace.=
cycles-pp.__pte_offset_map_lock.move_ptes.move_page_tables.move_vma.__do_sy=
s_mremap
> > >       1.04            +0.0        1.08        perf-profile.calltrace.=
cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_reg=
ion
> > >       0.76            +0.1        0.83        perf-profile.calltrace.=
cycles-pp.__madvise
> > >       0.63            +0.1        0.70        perf-profile.calltrace.=
cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__=
madvise
> > >       0.62            +0.1        0.70        perf-profile.calltrace.=
cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after=
_hwframe.__madvise
> > >       0.66            +0.1        0.74        perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
> > >       0.66            +0.1        0.74        perf-profile.calltrace.=
cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
> > >      87.74            +0.7       88.45        perf-profile.calltrace.=
cycles-pp.mremap
> > >       0.00            +0.9        0.86        perf-profile.calltrace.=
cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
> > >       0.00            +0.9        0.86        perf-profile.calltrace.=
cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
> > >      84.88            +0.9       85.77        perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64_after_hwframe.mremap
> > >      84.73            +0.9       85.62        perf-profile.calltrace.=
cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
> > >       0.00            +0.9        0.92 =C4=85  2%  perf-profile.callt=
race.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
> > >      83.84            +0.9       84.78        perf-profile.calltrace.=
cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mrem=
ap
> > >       0.00            +1.1        1.06        perf-profile.calltrace.=
cycles-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
> > >       0.00            +1.2        1.21        perf-profile.calltrace.=
cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
> > >       2.07            +1.5        3.55        perf-profile.calltrace.=
cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe
> > >       1.58            +1.5        3.07        perf-profile.calltrace.=
cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
> > >       0.00            +1.5        1.52        perf-profile.calltrace.=
cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
> > >       0.00            +1.6        1.57        perf-profile.calltrace.=
cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCA=
LL_64_after_hwframe
> > >       0.00            +1.7        1.72        perf-profile.calltrace.=
cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
> > >       0.00            +2.0        2.01        perf-profile.calltrace.=
cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_6=
4
> > >       5.39            +2.9        8.32        perf-profile.calltrace.=
cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hw=
frame.mremap
> > >      75.29            -1.9       73.37        perf-profile.children.c=
ycles-pp.move_vma
> > >      37.06            -1.6       35.50        perf-profile.children.c=
ycles-pp.do_vmi_align_munmap
> > >      24.98            -1.2       23.80        perf-profile.children.c=
ycles-pp.copy_vma
> > >      19.99            -1.0       19.02        perf-profile.children.c=
ycles-pp.handle_softirqs
> > >      19.97            -1.0       19.00        perf-profile.children.c=
ycles-pp.rcu_core
> > >      19.95            -1.0       18.98        perf-profile.children.c=
ycles-pp.rcu_do_batch
> > >      19.98            -0.9       19.06        perf-profile.children.c=
ycles-pp.__split_vma
> > >      17.55            -0.8       16.76        perf-profile.children.c=
ycles-pp.kmem_cache_free
> > >      10.56 =C4=85  2%      -0.8        9.79 =C4=85  2%  perf-profile.=
children.cycles-pp.run_ksoftirqd
> > >      10.57 =C4=85  2%      -0.8        9.80 =C4=85  2%  perf-profile.=
children.cycles-pp.smpboot_thread_fn
> > >      15.38            -0.8       14.62        perf-profile.children.c=
ycles-pp.kmem_cache_alloc_noprof
> > >      10.62 =C4=85  2%      -0.8        9.85 =C4=85  2%  perf-profile.=
children.cycles-pp.kthread
> > >      10.62 =C4=85  2%      -0.8        9.86 =C4=85  2%  perf-profile.=
children.cycles-pp.ret_from_fork
> > >      10.62 =C4=85  2%      -0.8        9.86 =C4=85  2%  perf-profile.=
children.cycles-pp.ret_from_fork_asm
> > >      15.14            -0.7       14.44        perf-profile.children.c=
ycles-pp.vma_merge
> > >      12.08            -0.5       11.55        perf-profile.children.c=
ycles-pp.__slab_free
> > >      12.11            -0.5       11.62        perf-profile.children.c=
ycles-pp.mas_wr_store_entry
> > >      10.86            -0.5       10.39        perf-profile.children.c=
ycles-pp.vm_area_dup
> > >      11.89            -0.5       11.44        perf-profile.children.c=
ycles-pp.mas_store_prealloc
> > >       8.49            -0.4        8.06        perf-profile.children.c=
ycles-pp.__memcg_slab_post_alloc_hook
> > >       9.88            -0.4        9.49        perf-profile.children.c=
ycles-pp.mas_wr_node_store
> > >       7.91            -0.3        7.58        perf-profile.children.c=
ycles-pp.move_page_tables
> > >       6.06            -0.3        5.78        perf-profile.children.c=
ycles-pp.vm_area_free_rcu_cb
> > >       8.28            -0.3        8.00        perf-profile.children.c=
ycles-pp.unmap_region
> > >       6.69            -0.3        6.42        perf-profile.children.c=
ycles-pp.vma_complete
> > >       5.06            -0.3        4.80        perf-profile.children.c=
ycles-pp.mas_preallocate
> > >       5.82            -0.2        5.57        perf-profile.children.c=
ycles-pp.move_ptes
> > >       4.24            -0.2        4.01        perf-profile.children.c=
ycles-pp.anon_vma_clone
> > >       3.50            -0.2        3.30        perf-profile.children.c=
ycles-pp.down_write
> > >       2.44            -0.2        2.25        perf-profile.children.c=
ycles-pp.find_vma_prev
> > >       3.46            -0.2        3.28        perf-profile.children.c=
ycles-pp.___slab_alloc
> > >       3.45            -0.2        3.27        perf-profile.children.c=
ycles-pp.free_pgtables
> > >       2.54            -0.2        2.37        perf-profile.children.c=
ycles-pp.rcu_cblist_dequeue
> > >       3.35            -0.2        3.18        perf-profile.children.c=
ycles-pp.__memcg_slab_free_hook
> > >       2.93            -0.2        2.78        perf-profile.children.c=
ycles-pp.mas_alloc_nodes
> > >       2.28 =C4=85  2%      -0.2        2.12 =C4=85  2%  perf-profile.=
children.cycles-pp.vma_prepare
> > >       3.46            -0.1        3.32        perf-profile.children.c=
ycles-pp.flush_tlb_mm_range
> > >       3.41            -0.1        3.27 =C4=85  2%  perf-profile.child=
ren.cycles-pp.mod_objcg_state
> > >       2.76            -0.1        2.63        perf-profile.children.c=
ycles-pp.unlink_anon_vmas
> > >       3.41            -0.1        3.28        perf-profile.children.c=
ycles-pp.mas_store_gfp
> > >       2.21            -0.1        2.09        perf-profile.children.c=
ycles-pp.__cond_resched
> > >       2.04            -0.1        1.94        perf-profile.children.c=
ycles-pp.allocate_slab
> > >       2.10            -0.1        2.00        perf-profile.children.c=
ycles-pp.__call_rcu_common
> > >       2.51            -0.1        2.40        perf-profile.children.c=
ycles-pp.flush_tlb_func
> > >       1.04            -0.1        0.94        perf-profile.children.c=
ycles-pp.mas_prev
> > >       2.71            -0.1        2.61        perf-profile.children.c=
ycles-pp.mtree_load
> > >       2.23            -0.1        2.14        perf-profile.children.c=
ycles-pp.native_flush_tlb_one_user
> > >       0.22 =C4=85  5%      -0.1        0.13 =C4=85 13%  perf-profile.=
children.cycles-pp.vm_stat_account
> > >       0.95            -0.1        0.87        perf-profile.children.c=
ycles-pp.mas_prev_setup
> > >       1.65            -0.1        1.57        perf-profile.children.c=
ycles-pp.mas_wr_walk
> > >       1.84            -0.1        1.76        perf-profile.children.c=
ycles-pp.up_write
> > >       1.27            -0.1        1.20        perf-profile.children.c=
ycles-pp.mas_prev_slot
> > >       1.84            -0.1        1.77        perf-profile.children.c=
ycles-pp.vma_link
> > >       1.39            -0.1        1.32        perf-profile.children.c=
ycles-pp.shuffle_freelist
> > >       0.96            -0.1        0.90 =C4=85  2%  perf-profile.child=
ren.cycles-pp.rcu_all_qs
> > >       0.86            -0.1        0.80        perf-profile.children.c=
ycles-pp._raw_spin_lock_irqsave
> > >       1.70            -0.1        1.64        perf-profile.children.c=
ycles-pp.__get_unmapped_area
> > >       0.34 =C4=85  3%      -0.1        0.29 =C4=85  5%  perf-profile.=
children.cycles-pp.security_vm_enough_memory_mm
> > >       0.60            -0.0        0.55        perf-profile.children.c=
ycles-pp.entry_SYSCALL_64
> > >       0.92            -0.0        0.87        perf-profile.children.c=
ycles-pp.percpu_counter_add_batch
> > >       1.07            -0.0        1.02        perf-profile.children.c=
ycles-pp.vma_to_resize
> > >       1.59            -0.0        1.54        perf-profile.children.c=
ycles-pp.mas_update_gap
> > >       0.44 =C4=85  2%      -0.0        0.40 =C4=85  2%  perf-profile.=
children.cycles-pp.native_queued_spin_lock_slowpath
> > >       0.70            -0.0        0.66        perf-profile.children.c=
ycles-pp.syscall_return_via_sysret
> > >       1.13            -0.0        1.09        perf-profile.children.c=
ycles-pp.mt_find
> > >       0.20 =C4=85  6%      -0.0        0.17 =C4=85  9%  perf-profile.=
children.cycles-pp.cap_vm_enough_memory
> > >       0.99            -0.0        0.95        perf-profile.children.c=
ycles-pp.mas_pop_node
> > >       0.63 =C4=85  2%      -0.0        0.59        perf-profile.child=
ren.cycles-pp.security_mmap_addr
> > >       0.62            -0.0        0.59        perf-profile.children.c=
ycles-pp.__put_partials
> > >       1.17            -0.0        1.14        perf-profile.children.c=
ycles-pp.clear_bhb_loop
> > >       0.46            -0.0        0.43 =C4=85  2%  perf-profile.child=
ren.cycles-pp.__alloc_pages_noprof
> > >       0.44            -0.0        0.41 =C4=85  2%  perf-profile.child=
ren.cycles-pp.get_page_from_freelist
> > >       0.90            -0.0        0.87        perf-profile.children.c=
ycles-pp.userfaultfd_unmap_complete
> > >       0.64 =C4=85  2%      -0.0        0.62        perf-profile.child=
ren.cycles-pp.get_old_pud
> > >       1.07            -0.0        1.05        perf-profile.children.c=
ycles-pp.mas_leaf_max_gap
> > >       0.22 =C4=85  3%      -0.0        0.20 =C4=85  2%  perf-profile.=
children.cycles-pp.__rmqueue_pcplist
> > >       0.55            -0.0        0.53        perf-profile.children.c=
ycles-pp.refill_obj_stock
> > >       0.25            -0.0        0.23 =C4=85  3%  perf-profile.child=
ren.cycles-pp.rmqueue
> > >       0.48            -0.0        0.45        perf-profile.children.c=
ycles-pp.mremap_userfaultfd_prep
> > >       0.33            -0.0        0.30        perf-profile.children.c=
ycles-pp.free_unref_page
> > >       0.46            -0.0        0.44        perf-profile.children.c=
ycles-pp.setup_object
> > >       0.21 =C4=85  3%      -0.0        0.19 =C4=85  2%  perf-profile.=
children.cycles-pp.rmqueue_bulk
> > >       0.31 =C4=85  3%      -0.0        0.29        perf-profile.child=
ren.cycles-pp.__vm_enough_memory
> > >       0.40            -0.0        0.38        perf-profile.children.c=
ycles-pp.entry_SYSRETQ_unsafe_stack
> > >       0.36            -0.0        0.35        perf-profile.children.c=
ycles-pp.madvise_vma_behavior
> > >       0.54            -0.0        0.53 =C4=85  2%  perf-profile.child=
ren.cycles-pp.mas_wr_end_piv
> > >       0.46            -0.0        0.44 =C4=85  2%  perf-profile.child=
ren.cycles-pp.rcu_segcblist_enqueue
> > >       0.34            -0.0        0.32 =C4=85  2%  perf-profile.child=
ren.cycles-pp.mas_destroy
> > >       0.28            -0.0        0.26 =C4=85  3%  perf-profile.child=
ren.cycles-pp.mas_wr_store_setup
> > >       0.30            -0.0        0.28        perf-profile.children.c=
ycles-pp.pte_offset_map_nolock
> > >       0.19            -0.0        0.18 =C4=85  2%  perf-profile.child=
ren.cycles-pp.__thp_vma_allowable_orders
> > >       0.08 =C4=85  4%      -0.0        0.07        perf-profile.child=
ren.cycles-pp.ksm_madvise
> > >       0.17            -0.0        0.16        perf-profile.children.c=
ycles-pp.get_any_partial
> > >       0.08            -0.0        0.07        perf-profile.children.c=
ycles-pp.syscall_exit_to_user_mode_prepare
> > >       0.45            +0.0        0.47        perf-profile.children.c=
ycles-pp._raw_spin_lock
> > >       1.10            +0.0        1.14        perf-profile.children.c=
ycles-pp.zap_pte_range
> > >       0.78            +0.1        0.85        perf-profile.children.c=
ycles-pp.__madvise
> > >       0.63            +0.1        0.70        perf-profile.children.c=
ycles-pp.__x64_sys_madvise
> > >       0.62            +0.1        0.70        perf-profile.children.c=
ycles-pp.do_madvise
> > >       0.00            +0.1        0.09 =C4=85  4%  perf-profile.child=
ren.cycles-pp.can_modify_mm_madv
> > >       1.32            +0.1        1.46        perf-profile.children.c=
ycles-pp.mas_next_slot
> > >      88.13            +0.7       88.83        perf-profile.children.c=
ycles-pp.mremap
> > >      83.94            +0.9       84.88        perf-profile.children.c=
ycles-pp.__do_sys_mremap
> > >      86.06            +0.9       87.00        perf-profile.children.c=
ycles-pp.entry_SYSCALL_64_after_hwframe
> > >      85.56            +1.0       86.54        perf-profile.children.c=
ycles-pp.do_syscall_64
> > >      40.49            +1.4       41.90        perf-profile.children.c=
ycles-pp.do_vmi_munmap
> > >       2.10            +1.5        3.57        perf-profile.children.c=
ycles-pp.do_munmap
> > >       3.62            +2.3        5.90        perf-profile.children.c=
ycles-pp.mas_walk
> > >       5.44            +2.9        8.38        perf-profile.children.c=
ycles-pp.mremap_to
> > >       5.30            +3.1        8.39        perf-profile.children.c=
ycles-pp.mas_find
> > >       0.00            +5.4        5.40        perf-profile.children.c=
ycles-pp.can_modify_mm
> > >      11.46            -0.5       10.96        perf-profile.self.cycle=
s-pp.__slab_free
> > >       4.30            -0.2        4.08        perf-profile.self.cycle=
s-pp.__memcg_slab_post_alloc_hook
> > >       2.51            -0.2        2.34        perf-profile.self.cycle=
s-pp.rcu_cblist_dequeue
> > >       2.41 =C4=85  2%      -0.2        2.25        perf-profile.self.=
cycles-pp.down_write
> > >       2.21            -0.1        2.11        perf-profile.self.cycle=
s-pp.native_flush_tlb_one_user
> > >       2.37            -0.1        2.28        perf-profile.self.cycle=
s-pp.mtree_load
> > >       1.60            -0.1        1.51        perf-profile.self.cycle=
s-pp.__memcg_slab_free_hook
> > >       0.18 =C4=85  3%      -0.1        0.10 =C4=85 15%  perf-profile.=
self.cycles-pp.vm_stat_account
> > >       1.25            -0.1        1.18        perf-profile.self.cycle=
s-pp.move_vma
> > >       1.76            -0.1        1.69        perf-profile.self.cycle=
s-pp.mod_objcg_state
> > >       1.42            -0.1        1.35 =C4=85  2%  perf-profile.self.=
cycles-pp.__call_rcu_common
> > >       1.41            -0.1        1.34        perf-profile.self.cycle=
s-pp.mas_wr_walk
> > >       1.52            -0.1        1.46        perf-profile.self.cycle=
s-pp.up_write
> > >       1.02            -0.1        0.95        perf-profile.self.cycle=
s-pp.mas_prev_slot
> > >       0.96            -0.1        0.90 =C4=85  2%  perf-profile.self.=
cycles-pp.vm_area_free_rcu_cb
> > >       1.50            -0.1        1.45        perf-profile.self.cycle=
s-pp.kmem_cache_free
> > >       0.69 =C4=85  3%      -0.1        0.64 =C4=85  2%  perf-profile.=
self.cycles-pp.rcu_all_qs
> > >       1.14 =C4=85  2%      -0.1        1.09        perf-profile.self.=
cycles-pp.shuffle_freelist
> > >       1.10            -0.1        1.05        perf-profile.self.cycle=
s-pp.__cond_resched
> > >       1.40            -0.0        1.35        perf-profile.self.cycle=
s-pp.do_vmi_align_munmap
> > >       0.99            -0.0        0.94        perf-profile.self.cycle=
s-pp.mas_preallocate
> > >       0.88            -0.0        0.83        perf-profile.self.cycle=
s-pp.___slab_alloc
> > >       0.55            -0.0        0.50        perf-profile.self.cycle=
s-pp.mremap_to
> > >       0.98            -0.0        0.93        perf-profile.self.cycle=
s-pp.move_ptes
> > >       0.78            -0.0        0.74        perf-profile.self.cycle=
s-pp.percpu_counter_add_batch
> > >       0.21 =C4=85  2%      -0.0        0.18 =C4=85  2%  perf-profile.=
self.cycles-pp.entry_SYSCALL_64
> > >       0.44 =C4=85  2%      -0.0        0.40 =C4=85  2%  perf-profile.=
self.cycles-pp.native_queued_spin_lock_slowpath
> > >       0.92            -0.0        0.89        perf-profile.self.cycle=
s-pp.mas_store_gfp
> > >       0.86            -0.0        0.82        perf-profile.self.cycle=
s-pp.mas_pop_node
> > >       0.50            -0.0        0.46        perf-profile.self.cycle=
s-pp.entry_SYSCALL_64_after_hwframe
> > >       1.15            -0.0        1.12        perf-profile.self.cycle=
s-pp.clear_bhb_loop
> > >       1.14            -0.0        1.11        perf-profile.self.cycle=
s-pp.vma_merge
> > >       0.66            -0.0        0.63        perf-profile.self.cycle=
s-pp.__split_vma
> > >       0.16 =C4=85  6%      -0.0        0.13 =C4=85  7%  perf-profile.=
self.cycles-pp.cap_vm_enough_memory
> > >       0.82            -0.0        0.79        perf-profile.self.cycle=
s-pp.mas_wr_store_entry
> > >       0.54 =C4=85  2%      -0.0        0.52        perf-profile.self.=
cycles-pp.get_old_pud
> > >       0.43            -0.0        0.40        perf-profile.self.cycle=
s-pp.do_munmap
> > >       0.51 =C4=85  2%      -0.0        0.48 =C4=85  2%  perf-profile.=
self.cycles-pp.security_mmap_addr
> > >       0.50            -0.0        0.48        perf-profile.self.cycle=
s-pp.refill_obj_stock
> > >       0.24            -0.0        0.22        perf-profile.self.cycle=
s-pp.mas_prev
> > >       0.71            -0.0        0.69        perf-profile.self.cycle=
s-pp.unmap_page_range
> > >       0.48            -0.0        0.45        perf-profile.self.cycle=
s-pp.find_vma_prev
> > >       0.42            -0.0        0.40        perf-profile.self.cycle=
s-pp._raw_spin_lock_irqsave
> > >       0.66            -0.0        0.64        perf-profile.self.cycle=
s-pp.mas_store_prealloc
> > >       0.31            -0.0        0.29        perf-profile.self.cycle=
s-pp.mas_prev_setup
> > >       0.43            -0.0        0.41        perf-profile.self.cycle=
s-pp.mas_wr_end_piv
> > >       0.78            -0.0        0.76        perf-profile.self.cycle=
s-pp.userfaultfd_unmap_complete
> > >       0.28            -0.0        0.26 =C4=85  2%  perf-profile.self.=
cycles-pp.mas_put_in_tree
> > >       0.42            -0.0        0.40        perf-profile.self.cycle=
s-pp.mremap_userfaultfd_prep
> > >       0.28            -0.0        0.26        perf-profile.self.cycle=
s-pp.free_pgtables
> > >       0.39            -0.0        0.37        perf-profile.self.cycle=
s-pp.entry_SYSRETQ_unsafe_stack
> > >       0.30 =C4=85  2%      -0.0        0.28        perf-profile.self.=
cycles-pp.zap_pmd_range
> > >       0.32            -0.0        0.31        perf-profile.self.cycle=
s-pp.unmap_vmas
> > >       0.21            -0.0        0.20        perf-profile.self.cycle=
s-pp.__get_unmapped_area
> > >       0.18 =C4=85  2%      -0.0        0.17 =C4=85  2%  perf-profile.=
self.cycles-pp.lru_add_drain_cpu
> > >       0.06            -0.0        0.05        perf-profile.self.cycle=
s-pp.ksm_madvise
> > >       0.45            +0.0        0.46        perf-profile.self.cycle=
s-pp.do_vmi_munmap
> > >       0.37            +0.0        0.39        perf-profile.self.cycle=
s-pp._raw_spin_lock
> > >       1.06            +0.1        1.18        perf-profile.self.cycle=
s-pp.mas_next_slot
> > >       1.50            +0.5        1.97        perf-profile.self.cycle=
s-pp.mas_find
> > >       0.00            +1.4        1.35        perf-profile.self.cycle=
s-pp.can_modify_mm
> > >       3.13            +2.0        5.13        perf-profile.self.cycle=
s-pp.mas_walk
> > >
> > >
> > > *********************************************************************=
******************************
> > > lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX=
 (Sapphire Rapids) with 256G memory
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/t=
estcase/testtime:
> > >   gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.c=
gz/lkp-spr-r02/pkey/stress-ng/60s
> > >
> > > commit:
> > >   ff388fe5c4 ("mseal: wire up mseal syscall")
> > >   8be7258aad ("mseal: add mseal syscall")
> > >
> > > ff388fe5c481d39c 8be7258aad44b5e25977a98db13
> > > ---------------- ---------------------------
> > >          %stddev     %change         %stddev
> > >              \          |                \
> > >      10539            -2.5%      10273        vmstat.system.cs
> > >       0.28 =C4=85  5%     -20.1%       0.22 =C4=85  7%  sched_debug.c=
fs_rq:/.h_nr_running.stddev
> > >       1419 =C4=85  7%     -15.3%       1202 =C4=85  6%  sched_debug.c=
fs_rq:/.util_avg.max
> > >       0.28 =C4=85  6%     -18.4%       0.23 =C4=85  8%  sched_debug.c=
pu.nr_running.stddev
> > >  8.736e+08            -3.6%  8.423e+08        stress-ng.pkey.ops
> > >   14560560            -3.6%   14038795        stress-ng.pkey.ops_per_=
sec
> > >     770.39 =C4=85  4%      -5.0%     732.04        stress-ng.time.use=
r_time
> > >     244657 =C4=85  3%      +5.8%     258782 =C4=85  3%  proc-vmstat.n=
r_slab_unreclaimable
> > >   73133541            -2.1%   71588873        proc-vmstat.numa_hit
> > >   72873579            -2.1%   71357274        proc-vmstat.numa_local
> > >  1.842e+08            -2.5%  1.796e+08        proc-vmstat.pgalloc_nor=
mal
> > >  1.767e+08            -2.8%  1.717e+08        proc-vmstat.pgfree
> > >    1345346 =C4=85 40%     -73.1%     362064 =C4=85124%  numa-vmstat.n=
ode0.nr_inactive_anon
> > >    1345340 =C4=85 40%     -73.1%     362062 =C4=85124%  numa-vmstat.n=
ode0.nr_zone_inactive_anon
> > >    2420830 =C4=85 14%     +35.1%    3270248 =C4=85 16%  numa-vmstat.n=
ode1.nr_file_pages
> > >    2067871 =C4=85 13%     +51.5%    3132982 =C4=85 17%  numa-vmstat.n=
ode1.nr_inactive_anon
> > >     191406 =C4=85 17%     +33.6%     255808 =C4=85 14%  numa-vmstat.n=
ode1.nr_mapped
> > >       2452 =C4=85 61%    +104.4%       5012 =C4=85 35%  numa-vmstat.n=
ode1.nr_page_table_pages
> > >    2067853 =C4=85 13%     +51.5%    3132966 =C4=85 17%  numa-vmstat.n=
ode1.nr_zone_inactive_anon
> > >    5379238 =C4=85 40%     -73.0%    1453605 =C4=85123%  numa-meminfo.=
node0.Inactive
> > >    5379166 =C4=85 40%     -73.0%    1453462 =C4=85123%  numa-meminfo.=
node0.Inactive(anon)
> > >    8741077 =C4=85 22%     -36.7%    5531290 =C4=85 28%  numa-meminfo.=
node0.MemUsed
> > >    9651902 =C4=85 13%     +35.8%   13105318 =C4=85 16%  numa-meminfo.=
node1.FilePages
> > >    8239855 =C4=85 13%     +52.4%   12556929 =C4=85 17%  numa-meminfo.=
node1.Inactive
> > >    8239712 =C4=85 13%     +52.4%   12556853 =C4=85 17%  numa-meminfo.=
node1.Inactive(anon)
> > >     761944 =C4=85 18%     +34.6%    1025906 =C4=85 14%  numa-meminfo.=
node1.Mapped
> > >   11679628 =C4=85 11%     +31.2%   15322841 =C4=85 14%  numa-meminfo.=
node1.MemUsed
> > >       9874 =C4=85 62%    +104.6%      20200 =C4=85 36%  numa-meminfo.=
node1.PageTables
> > >       0.74            -4.2%       0.71        perf-stat.i.MPKI
> > >  1.245e+11            +2.3%  1.274e+11        perf-stat.i.branch-inst=
ructions
> > >       0.37            -0.0        0.35        perf-stat.i.branch-miss=
-rate%
> > >  4.359e+08            -2.1%  4.265e+08        perf-stat.i.branch-miss=
es
> > >  4.672e+08            -2.6%  4.548e+08        perf-stat.i.cache-misse=
s
> > >  7.276e+08            -2.7%  7.082e+08        perf-stat.i.cache-refer=
ences
> > >       1.00            -1.6%       0.98        perf-stat.i.cpi
> > >       1364            +2.9%       1404        perf-stat.i.cycles-betw=
een-cache-misses
> > >  6.392e+11            +1.7%  6.499e+11        perf-stat.i.instruction=
s
> > >       1.00            +1.6%       1.02        perf-stat.i.ipc
> > >       0.74            -4.3%       0.71        perf-stat.overall.MPKI
> > >       0.35            -0.0        0.33        perf-stat.overall.branc=
h-miss-rate%
> > >       1.00            -1.6%       0.99        perf-stat.overall.cpi
> > >       1356            +2.9%       1395        perf-stat.overall.cycle=
s-between-cache-misses
> > >       1.00            +1.6%       1.01        perf-stat.overall.ipc
> > >  1.209e+11            +1.9%  1.232e+11        perf-stat.ps.branch-ins=
tructions
> > >  4.188e+08            -2.6%  4.077e+08        perf-stat.ps.branch-mis=
ses
> > >  4.585e+08            -3.1%  4.441e+08        perf-stat.ps.cache-miss=
es
> > >  7.124e+08            -3.1%  6.901e+08        perf-stat.ps.cache-refe=
rences
> > >      10321            -2.6%      10053        perf-stat.ps.context-sw=
itches
> > >
> > >
> > >
> > >
> > >
> > > Disclaimer:
> > > Results have been estimated based on internal Intel analysis and are =
provided
> > > for informational purposes only. Any difference in system hardware or=
 software
> > > design or configuration may affect actual performance.
> > >
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > >

