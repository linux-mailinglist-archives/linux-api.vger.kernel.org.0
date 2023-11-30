Return-Path: <linux-api+bounces-183-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7427FEBE5
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 10:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BD9281CD7
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185C38F95;
	Thu, 30 Nov 2023 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f0K8D4b6"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB1BD50
	for <linux-api@vger.kernel.org>; Thu, 30 Nov 2023 01:34:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso1035354e87.3
        for <linux-api@vger.kernel.org>; Thu, 30 Nov 2023 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701336855; x=1701941655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eIvDGUerrfda7PffkFuPcobBVIOmFzTvv07SzDnFxE=;
        b=f0K8D4b6Oe8iOmMUicT+5Lv91ypLRKyglr/Pzb7avwoiUeeCkjczQlgrFzZ/XAFEUg
         eQh2jlq+UR19sNECrQK1HQasRgZHvBpFaFMRPBySOzM4EjPiJA37j34bVlNCIsfDboSE
         10YgyhnL0w2u+rDqn4QocWquSeCJyvOfDQAm/KCRQzbTInSEFlltVT2+zU4ayaBxSVWs
         epNVPNHTtRESZlipG3S9DqKQvjX9t+GwcrAGv0/rYEF8D4W9L37SB/hvZwp9xXlWOqWD
         L5Famg7t7l2X+DbzGABtg78fiKeCIbKuNbDspI1nDNUXPgLTliwPi0xErbSTewndabNY
         Lg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336855; x=1701941655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eIvDGUerrfda7PffkFuPcobBVIOmFzTvv07SzDnFxE=;
        b=iA1hB11+EoB4HgxRE4BKh/7EV8usdBNakQcGLAsnK7Y4mkdJChIf4HcWj4tCFo5x1F
         STP16ADhQvzNH7Yu/YrpyMAiyuy1j5PuQzjp4EXyxSg1961aSdFXRD4ul7gHbT/ZqRpP
         Pb6ylDkxCLq4z3Xsge6ahWQro/EUBYYL+XL/VbQWyM7g6dGzPwC/yCQ/lRx2a6lcAz3V
         lPl0CXZ4WpU8MP1/5qNunGdAAfbWwIvApbiaLv2OETD9zrmOinC0pwqt6YqjQQZlKBj2
         Wg8OtCCkAlEuh5mT04imDce46NNMCTocrR4fp6v8FOn+8+sSmqFWmPEyXIrvISUIHAY9
         X9Pg==
X-Gm-Message-State: AOJu0Yyaf9/tlp+y8yd6eg7qphFQKpJwCg03uvbWWowPGgK7/qMXi5dm
	xP6NtwcoZNYfr/WUNJLZbJRLmEJbNeC/U6+kr9vvcPEmEGBUXEIahGs=
X-Google-Smtp-Source: AGHT+IGEdQGMBIjZ7uHMEFe3IpSrNio2BkAzOv5Ena+HIB7yN6xBdJSwPKwJFx2hI5uAUVFYg1O06Q8AZ2TzKuVz+uU=
X-Received: by 2002:a19:a40a:0:b0:50b:c7e3:a1e6 with SMTP id
 q10-20020a19a40a000000b0050bc7e3a1e6mr2293027lfc.44.1701336855608; Thu, 30
 Nov 2023 01:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com> <CACSyD1OFjROw26+2ojG37eDBParVg721x1HCROMiF2pW2aHj8A@mail.gmail.com>
 <ZV/HSFMmv3xwkNPL@memverge.com>
In-Reply-To: <ZV/HSFMmv3xwkNPL@memverge.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 30 Nov 2023 17:34:04 +0800
Message-ID: <CACSyD1MrCzyV-93Ov07NpV3Nm3u0fYExmD1ShE_e2tapW6a6HA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
To: Gregory Price <gregory.price@memverge.com>
Cc: Vinicius Petrucci <vpetrucci@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-api@vger.kernel.org, minchan@kernel.org, dave.hansen@linux.intel.com, 
	x86@kernel.org, Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com, 
	ying.huang@intel.com, dan.j.williams@intel.com, fvdl@google.com, 
	surenb@google.com, rientjes@google.com, hannes@cmpxchg.org, mhocko@suse.com, 
	Hasan.Maruf@amd.com, jgroves@micron.com, ravis.opensrc@micron.com, 
	sthanneeru@micron.com, emirakhur@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gregory, sorry for the late reply.

I tried pidfd_set_mempolicy(suggested by michal) about a year ago.
There is a problem here that may need attention.

A mempolicy can be either associated with a process or with a VMA.
All vma manipulation is somewhat protected by a down_read on
mmap_lock.In process context(in alloc_pages()) there is no locking
because only the process accesses its own state.

Now  we need to change the process context mempolicy specified
in pidfd. the mempolicy may about to be freed by
pidfd_set_mempolicy() while alloc_pages() is using it,
The race condition appears.

Say something like the following=EF=BC=9A

pidfd_set_mempolicy()        target task stack:
                                               alloc_pages:
                                             mpol =3D p->mempolicy;
  task_lock(task);
  old =3D task->mempolicy;
  task->mempolicy =3D new;
  task_unlock(task);
  mpol_put(old);
                                           /*old mpol has been freed.*/
                                           policy_node(...., mpol)
                                          __alloc_pages();

To reduce the use of locks and atomic operations(mpol_get/put)
in the hot path, there are no references or lock protections here
for task mempolicy.

It would be great if your refactoring has a good solution.

Thanks.

On Sat, Nov 25, 2023 at 4:09=E2=80=AFAM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Fri, Nov 24, 2023 at 04:13:41PM +0800, Zhongkun He wrote:
> >
> > Per my understanding,  the process_mbind() is implementable without
> > many difficult challenges=EF=BC=8C
> > since it is always protected by mm->mmap_lock. But task mempolicy does
> > not acquire any lock
> > in alloc_pages().
>
> per-vma policies are protected by the mmap lock, while the task
> mempolicy is protected by the task lock on replacement, and
> task->mems_allowed (protected by task_lock).
>
> There is an update in my refactor tickets that enforces the acquisition
> of task_lock on mpol_set_nodemask, which prevents the need for
> alloc_pages to do anything else.  That's not present in this patch.
>
> Basically mems_allowed deals with the majority of situations, and
> mmap_lock deals with per-vma mempolicy changes and migrations.
>
> ~Gregory

