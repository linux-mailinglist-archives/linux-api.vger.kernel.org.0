Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C215342E9A
	for <lists+linux-api@lfdr.de>; Sat, 20 Mar 2021 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCTRXr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 20 Mar 2021 13:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCTRX0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 20 Mar 2021 13:23:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A6AB61927
        for <linux-api@vger.kernel.org>; Sat, 20 Mar 2021 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616261005;
        bh=/b25iKJZ9KZluzyNkg+H4bqhRAkDvPRLLwwMd97ZR+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TPHe98WXNAl7xLc0QDXbr9795qTaPMEbiGwSoIjnmlrkPZZNoe2sAKfep58FWbzwK
         ghVRTxtNB7Nt0WQ4LYlEfXeFWWpTwlw3foUQnv1Uy9zTMiBcdIihU1EaSFz0f92LD9
         B+7fAKqalctoc0qQG39d5o2qUiMvBkCji3VqYkWAzx8M50H/L5ZxBMSgcDW1/leTUJ
         2PweDIHxtFj7hcM494kMCyfDqqbppwRvHAf0k0VdKycmUQwwRF27paNGZkWQn2f4YL
         qIVXgR5KhQ4LI1FWgxrHfW66b6GFQQi/0eqOlejFUEeDtvQEHboIkcyTNf/W+ea4ip
         IQ/8n+csOw+5g==
Received: by mail-ej1-f54.google.com with SMTP id u9so14636689ejj.7
        for <linux-api@vger.kernel.org>; Sat, 20 Mar 2021 10:23:25 -0700 (PDT)
X-Gm-Message-State: AOAM5316sf+yosUfXbc+qAHw3W0HPu2EYbEqjZamxhY4QN/mwXWHEaWm
        D0wzSE7vpoGmoJ4/sYUYaOI8zaOaWPKQyD7kvjxZ1A==
X-Google-Smtp-Source: ABdhPJwDmIu7WV5vbmp2D+c7QZtUKK60PPm1idT10R4ezumQ6BURijYmhpx1bDsIjG9Nf1v6G4pWqgqMdJiE0y8SqKQ=
X-Received: by 2002:a17:906:1494:: with SMTP id x20mr10645998ejc.101.1616261004125;
 Sat, 20 Mar 2021 10:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <YFYjOB1jpbqyNPAp@localhost.localdomain>
In-Reply-To: <YFYjOB1jpbqyNPAp@localhost.localdomain>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 20 Mar 2021 10:23:12 -0700
X-Gmail-Original-Message-ID: <CALCETrUPAvUOr8V5db0gu5RKVftKFwbBEkh6Aob57v+D-xdEig@mail.gmail.com>
Message-ID: <CALCETrUPAvUOr8V5db0gu5RKVftKFwbBEkh6Aob57v+D-xdEig@mail.gmail.com>
Subject: Re: [PATCH] Document that PF_KTHREAD _is_ ABI
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> On Mar 20, 2021, at 9:31 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> =EF=BB=BFPF_KTHREAD value is visible via field number 9 of /proc/*/stat
>
>    $ sudo cat /proc/2/stat
>    2 (kthreadd) S 0 0 0 0 -1 2129984 0 ...
>                  ^^^^^^^
>
> It is used by at least systemd to check for kernel-threadness:
> https://github.com/systemd/systemd/blob/main/src/basic/process-util.c#L35=
4
> src/basic/process-util.c:is_kernel_thread()

Eww.

Could we fix it differently and more permanently by modifying the proc
code to display the values systemd expects?


>
> It means that the value can't be changed despite perceived notion that
> task_struct flags are internal to kernel and can be shuffled at whim.
>
> Formally, _all_ struct task_struct::flags PF_* values are kernel ABI
> which is a disaster.
>
> I hope we can mask everything but few flags and hope for the best :^)
>
> Note for beginner Linux programmers:
> every other way you find on the interwebs and Stack Overflow
> for checking if pid belongs to a kernel thread is broken one way or
> another.
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>
> include/linux/sched.h |    3 +++
> 1 file changed, 3 insertions(+)
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1566,6 +1566,9 @@ extern struct pid *cad_pid;
> #define PF_MEMALLOC_NOIO    0x00080000    /* All allocation requests will=
 inherit GFP_NOIO */
> #define PF_LOCAL_THROTTLE    0x00100000    /* Throttle writes only agains=
t the bdi I write to,
>                         * I am cleaning dirty pages from some other bdi. =
*/
> +/*
> + * PF_KTHREAD is part of kernel ABI, visible via value #9 in /proc/$pid/=
stat
> + */
> #define PF_KTHREAD        0x00200000    /* I am a kernel thread */
> #define PF_RANDOMIZE        0x00400000    /* Randomize virtual address sp=
ace */
> #define PF_SWAPWRITE        0x00800000    /* Allowed to write to swap */
