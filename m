Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7744A9C4
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 09:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhKII6o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 03:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbhKII6o (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 03:58:44 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A95C061764;
        Tue,  9 Nov 2021 00:55:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ee33so74086486edb.8;
        Tue, 09 Nov 2021 00:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YF0nJGr2F3cAY4yWpx0AziwiF6WyFVyJ2P8U7ZMBQ2k=;
        b=Rd9tJkCsqFqsA1uFdxPhnYdcOJssqFpCCo9AOZ2RpFr6zA3rc+Lr+XL6yoYY0J+x/l
         10K/j3jaHl4yd4Fi9YsIdkVK5lKvicLxe4z2YsnzWkIu4u375S0qlOvqb9m36w1gq9PT
         c4T6dZFiGrGyrsl4Ttx2SVax4CIbUEK8otiLMZnAFVCLYJy7wDduhp9egcd/VK5qEFqm
         XbJwq5hhMRkZdF4kfabHK+a4q+CGVh8pXVOgXH6pzPRKoBJZtjMWLQDmtoE9eWn/zoui
         52UYC9rOIQqaWVchhIbtvjSyxAddEiacXS8hX7cSLMrXbqQmR8N+2oZBy8qotC7pBIJb
         J2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YF0nJGr2F3cAY4yWpx0AziwiF6WyFVyJ2P8U7ZMBQ2k=;
        b=VG912Y+pR3rfgyTJvUwPZdWMv0ly7BPK0NOLBHfbgvQvOPnhJqVEL2m9bctkodvbU3
         fxzzaETPPyYn1TK+T7zqR07FUK0m+1wL0i6iF3EeI2ess5G1vaVVlnmm/pJmSGrkrBUb
         jOyauIRXbHD/k6sZPMfX/1u2xEhnQkzmao/krZJPiPvMezdSYsBMJHP46Y5Aal8QD+Vq
         uOUW/n/woxDnNNN/38uw/r/IlyoKIhO6Ctm8+B4GSu31zXhFp0EfdOFKW3uRn8BZ6R6f
         gVdElxMzbNb7f/+pnzgVdiCGWERdFwaNSWtVFYzZDsGtjDduDbms3tOhILeo3KWSxHYt
         T0Ig==
X-Gm-Message-State: AOAM533vztPyZ3czkQvczESNtWS738trQUhv7kapMD6+cOZuaVIBJHwV
        8Ht6AYgepS/gE8Pkkaf7504JD3v7HV1jZPBEZi0=
X-Google-Smtp-Source: ABdhPJxUXsDlKLE4/vBP0zD1S+wpZ+CiVLOikj2CtG05js/EKJ0IaEtzXPWZAceSn8Lj9ydytAspFmr6LW1xwJj8ugg=
X-Received: by 2002:a17:907:6e0b:: with SMTP id sd11mr7258908ejc.134.1636448157072;
 Tue, 09 Nov 2021 00:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20211104195804.83240-1-posk@google.com>
In-Reply-To: <20211104195804.83240-1-posk@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 9 Nov 2021 21:55:45 +1300
Message-ID: <CAGsJ_4xRcu1P9EV0-9GF00n7Cg0=0=NRQ8dj1EAe4OZotWWfbQ@mail.gmail.com>
Subject: Re: [PATCH v0.8 0/6] sched,mm,x86/uaccess: implement User Managed
 Concurrency Groups
To:     posk@posk.io
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 5, 2021 at 8:58 AM Peter Oskolkov <posk@posk.io> wrote:
>
> User Managed Concurrency Groups (UMCG) is an M:N threading
> subsystem/toolkit that lets user space application developers implement
> in-process user space schedulers.
>
> Key changes from the previous patchset
> https://lore.kernel.org/all/20211012232522.714898-1-posk@google.com/:
>
> - added libumcg tools/lib/umcg;
> - worker "wakeup" is reworked so that it is now purely a userspace op,
>   instead of waking the thread in order for it to block on return
>   to the userspace immediately;
> - a couple of minor fixes and refactorings.
>
> These big things remain to be addressed (in no particular order):
> - support tracing/debugging
> - make context switches faster (see umcg_do_context_switch in umcg.c)
> - support other architectures
> - cleanup and post selftests in tools/testing/selftests/umcg/
> - allow cross-mm wakeups (securely)
>
>
> Peter Oskolkov (6):
>   sched/umcg: add WF_CURRENT_CPU and externise ttwu
>   mm, x86/uaccess: add userspace atomic helpers
>   sched/umcg: implement UMCG syscalls
>   sched/umcg, lib/umcg: implement libumcg
>   sched/umcg: add Documentation/userspace-api/umcg.txt
>   sched/umcg, lib/umcg: add tools/lib/umcg/libumcg.txt

Hi Peter,
Do you have a real workload or an example application using UMCG?

>
>  Documentation/userspace-api/umcg.txt   |  598 ++++++++++++
>  arch/x86/entry/syscalls/syscall_64.tbl |    2 +
>  arch/x86/include/asm/uaccess_64.h      |   93 ++
>  fs/exec.c                              |    1 +
>  include/linux/sched.h                  |   71 ++
>  include/linux/syscalls.h               |    3 +
>  include/linux/uaccess.h                |   46 +
>  include/uapi/asm-generic/unistd.h      |    6 +-
>  include/uapi/linux/umcg.h              |  137 +++
>  init/Kconfig                           |   10 +
>  kernel/entry/common.c                  |    4 +-
>  kernel/exit.c                          |    5 +
>  kernel/sched/Makefile                  |    1 +
>  kernel/sched/core.c                    |   12 +-
>  kernel/sched/fair.c                    |    4 +
>  kernel/sched/sched.h                   |   15 +-
>  kernel/sched/umcg.c                    |  949 +++++++++++++++++++
>  kernel/sys_ni.c                        |    4 +
>  mm/maccess.c                           |  264 ++++++
>  tools/lib/umcg/.gitignore              |    4 +
>  tools/lib/umcg/Makefile                |   11 +
>  tools/lib/umcg/libumcg.c               | 1201 ++++++++++++++++++++++++
>  tools/lib/umcg/libumcg.h               |  299 ++++++
>  tools/lib/umcg/libumcg.txt             |  438 +++++++++
>  24 files changed, 4166 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/userspace-api/umcg.txt
>  create mode 100644 include/uapi/linux/umcg.h
>  create mode 100644 kernel/sched/umcg.c
>  create mode 100644 tools/lib/umcg/.gitignore
>  create mode 100644 tools/lib/umcg/Makefile
>  create mode 100644 tools/lib/umcg/libumcg.c
>  create mode 100644 tools/lib/umcg/libumcg.h
>  create mode 100644 tools/lib/umcg/libumcg.txt
>
>
> base-commit: 8ea9183db4ad8afbcb7089a77c23eaf965b0cacd
> --
> 2.25.1
>

Thanks
Barry
