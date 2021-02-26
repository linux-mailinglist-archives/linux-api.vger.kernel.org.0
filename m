Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B432653B
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 17:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZQFW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhBZQFS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 11:05:18 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66DC061788
        for <linux-api@vger.kernel.org>; Fri, 26 Feb 2021 08:04:36 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id w69so10236482oif.1
        for <linux-api@vger.kernel.org>; Fri, 26 Feb 2021 08:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y4vuk5gk8VYy+TeoS2K1DIgXIADU2xMHdtcWrqlVRR4=;
        b=KSe8qTDeRpFYN1HUJs2d8SEpaHEKul8wK+ZEUsnOVTPmNejECnL3w4O5GtWglVlTDr
         8KkimECkDOmDseogluJ5qMGyYBFTdfqBoOmuy7MYzhA0cP3IPynlKQLzu491fYiNdLWB
         D0zZysCs3AsT4rgQ+l1u1gqDNXDpjCnG6dKaRRA4Ut0rN2qzOxlx6LrFQ0E4UODu1cHO
         ZKDXrRP/jsu1fj81lYNGyAhF0m8l6LLVhckBYIfM4IEHSkyI+TcghTula+Xpff1n/KLI
         aMYSSnyzOPljJT9jHQlbKWbBcP0NhYdWhJB5HnmeqWsFv2PbUWkXRxXJtNSdUi7wHf1f
         nEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y4vuk5gk8VYy+TeoS2K1DIgXIADU2xMHdtcWrqlVRR4=;
        b=nt1DljiIwfsfMO/+D+DFL96l5mq1PCGZ8cXAkLcE9en12SoyvA/ROIRgX5lRNHFyb4
         g8Juv7vqjlNqyLghfOnFxfQaZtJdOr0f4pFbIO2iwVgvc1zKJ3tNBVfMjak5PA6pUyqc
         oHts+1FJiToQsXvSJIlcLRucAokJvwcixV+dHLhvz+X12dAeZ0ut0S8G/74uLNKJO97P
         oHj/wxbRZewjTFyUTFGuYSzfVbIKvN4pQIfrdO+E5ptQiybLgqgzfT3cPzhiTxwPkjmh
         bS6Sm8dnmdkwssJ019e1kidlb5R4vKSku4eAIVcr5vQ53jNBark9FhqEHBbhcfXvaVKT
         J8qw==
X-Gm-Message-State: AOAM533LivZr+dfna0U7t51YGK2ThdDd/krqplkPEQ55NiiFAFl1vZac
        UImaOmdHPow7p5tH06OIrz84ecY+Mi+yjZPRpdAK4g==
X-Google-Smtp-Source: ABdhPJyUdh9yW8FHuekN2vW1gS18Lpi9c5coVOjZSAhtTZ7sHc4OVRdI08y0pI1Z15k8LltuLme+KiRPuKIqoY/ii84=
X-Received: by 2002:aca:3408:: with SMTP id b8mr2467679oia.102.1614355475958;
 Fri, 26 Feb 2021 08:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20210226135156.1081606-1-figiel@google.com> <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com>
In-Reply-To: <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 26 Feb 2021 17:04:25 +0100
Message-ID: <CABb0KFFhbxU0xq0A=m2FO83j04vrzwVa2-JwKJi1mtRhu_0kSg@mail.gmail.com>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Piotr Figiel <figiel@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Florian Weimer <fweimer@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 26 Feb 2021 at 16:32, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Feb 26, 2021, at 8:51 AM, Piotr Figiel figiel@google.com wrote:
> [...]
> > ---
> > v2:
> > Applied review comments:
> > - changed return value from the ptrace request to the size of the
> >   configuration structure
> > - expanded configuration structure with the flags field and
> >   the rseq abi structure size
> >
> [...]
> > +#define PTRACE_GET_RSEQ_CONFIGURATION        0x420f
> > +
> > +struct ptrace_rseq_configuration {
> > +     __u64 rseq_abi_pointer;
> > +     __u32 rseq_abi_size;
> > +     __u32 signature;
> > +     __u32 flags;
> > +     __u32 pad;
> > +};
> > +
> [...]
> > +#ifdef CONFIG_RSEQ
> > +static long ptrace_get_rseq_configuration(struct task_struct *task,
> > +                                       unsigned long size, void __user=
 *data)
> > +{
> > +     struct ptrace_rseq_configuration conf =3D {
> > +             .rseq_abi_pointer =3D (u64)(uintptr_t)task->rseq,
> > +             .rseq_abi_size =3D sizeof(*task->rseq),
> > +             .signature =3D task->rseq_sig,
> > +             .flags =3D 0,
> > +     };
> > +
> > +     size =3D min_t(unsigned long, size, sizeof(conf));
> > +     if (copy_to_user(data, &conf, size))
> > +             return -EFAULT;
> > +     return sizeof(conf);
> > +}
>
> I think what Florian was after would be:
>
> struct ptrace_rseq_configuration {
>         __u32 size;  /* size of struct ptrace_rseq_configuration */
>         __u32 flags;
>         __u64 rseq_abi_pointer;
>         __u32 signature;
>         __u32 pad;
> };
>
> where:
>
>     .size =3D sizeof(struct ptrace_rseq_configuration),
>
> This way, the configuration structure can be expanded in the future. The
> rseq ABI structure is by definition fixed-size, so there is no point in
> having its size here.
>
> Florian, did I understand your request correctly, or am I missing your po=
int ?

In this case returning sizeof(conf) would serve the same purpose, wouldn't =
it?

Best Regards
Micha=C5=82 Miros=C5=82aw

[Resent because of HTML mail misfeature...]
