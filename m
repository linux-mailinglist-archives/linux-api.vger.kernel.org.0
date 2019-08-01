Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C701E7D4F0
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 07:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfHAFem (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 01:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfHAFel (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Aug 2019 01:34:41 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977B8214DA
        for <linux-api@vger.kernel.org>; Thu,  1 Aug 2019 05:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564637680;
        bh=HrxXpiw3LkZQVE8e0ZTsuPfAdvYomc3P/3Iwf2HWM78=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0ebISSC+VkWLanyiZVHv45OnsczBwZ/hhiLimuR6zOqlYwygqcsyVYs/Uggl/DUDA
         Vjg6ZhJC4VwycJYMBeYYpn6ol3ZOQ9ll7OD8huaDYfWk+0g4YZjgJsfGfweOTO+8j7
         gAzapcOdDUfZB2TJ2EfeZZl+C/z+VLO2A2rR6jtM=
Received: by mail-wr1-f43.google.com with SMTP id n4so72184521wrs.3
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 22:34:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVat5tM60fyKR2C9sr4qpqTvjmi4xZ8lWo/h1TymFTawtlTVZUf
        GhhZNi1yvWmq3G0BK/sOS09G0ZowReL2bVfZvJ5R8g==
X-Google-Smtp-Source: APXvYqx9zbupszGMOuu4tkZ/G09clcPNyUxpoySIadp3yoAa9h3SwqTOS6ZQE9j4ym1f+H9vYJGnx6jogN3n0v0lAKg=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr61034365wro.343.1564637677248;
 Wed, 31 Jul 2019 22:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-26-dima@arista.com>
In-Reply-To: <20190729215758.28405-26-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Jul 2019 22:34:26 -0700
X-Gmail-Original-Message-ID: <CALCETrUpOhTCQkhB3S73LBFAiTp07PwXP32Q6Bn0m2LTqiw9hA@mail.gmail.com>
Message-ID: <CALCETrUpOhTCQkhB3S73LBFAiTp07PwXP32Q6Bn0m2LTqiw9hA@mail.gmail.com>
Subject: Re: [PATCHv5 25/37] x86/vdso: Switch image on setns()/clone()
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> It will add a penalty for everybody as branch predictor may mispredict
> the jump. Also there are instruction cache lines wasted on cmp/jmp.


>
> +#ifdef CONFIG_TIME_NS
> +int vdso_join_timens(struct task_struct *task)
> +{
> +       struct mm_struct *mm = task->mm;
> +       struct vm_area_struct *vma;
> +
> +       if (down_write_killable(&mm->mmap_sem))
> +               return -EINTR;
> +
> +       for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +               unsigned long size = vma->vm_end - vma->vm_start;
> +
> +               if (vma_is_special_mapping(vma, &vvar_mapping) ||
> +                   vma_is_special_mapping(vma, &vdso_mapping))
> +                       zap_page_range(vma, vma->vm_start, size);
> +       }

This is, unfortunately, fundamentally buggy.  If any thread is in the
vDSO or has the vDSO on the stack (due to a signal, for example), this
will crash it.  I can think of three solutions:

1. Say that you can't setns() if you have other mms and ignore the
signal issue.  Anything with green threads will disapprove.  It's also
rather gross.

2. Make it so that you can flip the static branch safely.  As in my
other email, you'll need to deal with CoW somehow,

3. Make it so that you can't change timens, or at least that you can't
turn timens on or off, without execve() or fork().

BTW, that static branch probably needs to be aligned to a cache line
or something similar to avoid all the nastiness with trying to poke
text that might be concurrently executing.  This will be a mess.
