Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B6D21F983
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 20:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgGNSd6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgGNSd5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 14:33:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E36FC061794
        for <linux-api@vger.kernel.org>; Tue, 14 Jul 2020 11:33:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x9so14654556ljc.5
        for <linux-api@vger.kernel.org>; Tue, 14 Jul 2020 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyP3ZHSQbiIJkgfhj+w2LY9l2YJKPJ+qK594IrEb58E=;
        b=qYKY00MEabqGiQ7om+FCgRsF3qL/GSt4BdQ+DC3BjaBjVRtPavSO7I+bKn2fn9H/+A
         4YBy0mJ2n+3/LWK/rIvkJW2EI4G8dmOhSmAUXBD8hThIgdANEqiZViODGTy4FbwROfPK
         tRn5nCWI7UiPloxZ1mwja90xAyhlIvln/CUboMoCeo0trcdTJyJjV/oBdcYI1stqk/wA
         l7D4atz2mu0OIXlrT1I7Sjl4Zhb6DLYCoG6xROrOmWi4z+5tAVUy1jbIiVFPQUIr88t7
         Q357PW73mz4a2VcF94WK8yu4QOJCbCniyE4OnjqjHoCYNlA/Y6U+x+hheWnzedDV4r0a
         OqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyP3ZHSQbiIJkgfhj+w2LY9l2YJKPJ+qK594IrEb58E=;
        b=oeplBhWhn9G8C7+/Ljja4KGY+qA79Rskr0X5qDDWO9t10uQSSJY0JXdpNZzYAnc6JS
         0CpxjoFRpLsYUjkSe7hNOpkD6+rVev8YIWvSngQBMaC/DlrHeOMcU5CKI+97LON6eLMd
         zeR8Kfe2yaqw+esVysB8beDqO0/1Ur47EUxW7mT7VU081troblSBDnhPqf3hUtXYpfQX
         u2hy6j01pXdY093vHEfOFzUsI4tq5y30WmshcAdCHM1pbkJ0MvY2lCGB4TH0yXmf1z2t
         Ur7ddsui4TEadCtpQqHUR/P3gzMXoM9JwNhTH4RBinZc8zn8CoBcgFxFvtXE9hNW2emr
         8Eqg==
X-Gm-Message-State: AOAM532E9Yp3DMFmSrmZaKlH4Adl16qtvfNY6+i8S6In4HtMDNQt9eyx
        fgcAA6z/qhZRCZMmcOoTndny1G/Uh1JOUmqpIvd4eQ==
X-Google-Smtp-Source: ABdhPJzutP+Eujesct6aPGeAiwrZdsjZGD8qSndUPJy6OUx7H9vvuS79gJZzuNhHI60cmBHSQCgOeaiRiKEf+jUgss0=
X-Received: by 2002:a2e:9b87:: with SMTP id z7mr186034lji.80.1594751635653;
 Tue, 14 Jul 2020 11:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <CAFTs51UHaUqaKj5bEj0vQtEZrww9gnrqb-kGVk7DAgQJPBAR+w@mail.gmail.com>
 <775688146.12145.1594748580461.JavaMail.zimbra@efficios.com>
In-Reply-To: <775688146.12145.1594748580461.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 14 Jul 2020 11:33:44 -0700
Message-ID: <CAPNVh5fiCCJpyeLj_ciWzFrO4fasVXZNhpfKXJhJWJirXdJOjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>,
        Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 14, 2020 at 10:43 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jul 14, 2020, at 1:24 PM, Peter Oskolkov posk@posk.io wrote:
>
> > At Google, we actually extended struct rseq (I will post the patches
> > here once they are fully deployed and we have specific
> > benefits/improvements to report). We did this by adding several fields
> > below __u32 flags (the last field currently), and correspondingly
> > increasing rseq_len in rseq() syscall. If the kernel does not know of
> > this extension, it will return -EINVAL due to an unexpected rseq_len;
> > then the application can either fall-back to the standard/upstream
> > rseq, or bail. If the kernel does know of this extension, it accepts
> > it. If the application passes the old rseq_len (32), the kernel knows
> > that this is an old application and treats it as such.
> >
> > I looked through the archives, but I did not find specifically why the
> > pretty standard approach described above is considered inferior to the
> > one taken in this patch (freeze rseq_len at 32, add additional length
> > fields to struct rseq). Can these be summarized?
>
> I think you don't face the issues I'm facing with libc rseq integration
> because you control the entire user-space software ecosystem at Google.
>
> The main issue we face is that the library responsible for registering
> rseq (either glibc 2.32+, an early-adopter librseq library, or the
> application) may very well not be the same library defining the __rseq_abi
> symbol used in the global symbol table. Interposition with ld preload or
> by defining the __rseq_abi in the program's executable are good examples
> of this kind of scenario, and those use-cases are supported.
>
> So the size of the __rseq_abi structure may be larger than the struct
> rseq known by glibc (and eventually smaller, if future glibc versions
> extend their __rseq_abi size but is loaded with an older program/library
> doing __rseq_abi interposition).
>
> So we need some way to allow code defining the __rseq_abi to let the kernel
> know how much room is available, without necessarily requiring the code
> responsible for rseq registration to be aware of that extended layout.
> This is the purpose of the __rseq_abi.flags RSEQ_FLAG_TLS_SIZE and field
> __rseq_abi.user_size.
>
> And we need some way to allow the kernel to let user-space rseq critical
> sections (user code) know how much of those fields are actually populated
> by the kernel. This is the purpose of __rseq_abi.flags RSEQ_FLAG_TLS_SIZE
> with __rseq_abi.kernel_size.

Thanks, Mathieu, for the explanation. Yes, multiple unrelated
libraries having to share struct rseq complicates matters. Your
approach appears to be a way to reconcile the issues you outlined
above.

Thanks,
Peter

>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
