Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E06220263
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 04:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGOCex (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 22:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgGOCew (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 22:34:52 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F875C061794
        for <linux-api@vger.kernel.org>; Tue, 14 Jul 2020 19:34:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so3161545wmh.4
        for <linux-api@vger.kernel.org>; Tue, 14 Jul 2020 19:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T6LjRRrOVLGwVCH+E/vyiV5aYGtBQNbXUznocfAb3SM=;
        b=VqLvow7SaFWzu6jDNNTg/b7EHiPxeh+07ePJpCnkINLTRLnBsPXLN/jem/POkOU2gL
         Gr9jYNphMaj/vFSifxXuYaM/jC96ugVhM9gJlpCKEBy3lA6X1S/y8ZxI74ZSSzZcwqg4
         ZxvBJOvLFMcOXkEOCSCpECuvyJ90PbxqrCwIGwcwgfw41C9sa+VTV0gWxiE9O5esrg2o
         Fx3KWfmjdHd/aMdcylVCG6aT+FcI2imzVqUVwuJsPVZK9ERFpS2z/Ih49SWHUDpVKaB7
         Qwh4cxCWKsczYrcvb4pBTb09JpTGkWcvu1VkVUyou396rpeyLyv1FxGAUkn7Y01V62jW
         MsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T6LjRRrOVLGwVCH+E/vyiV5aYGtBQNbXUznocfAb3SM=;
        b=KiH7bF0aCG/f5iG/Bem4fQHgy5XD/5P6oZjDw1c1Tylya4G1snK7FZgtj9eSrwRatw
         3em9LwD8mAqOS5pjpCI9cZIFrFMVa41nu6ka88Ov6T/Q/P6eMWOMp4olstRoX2ytOoTI
         k2bUwqt5lakon686LZF++IQbwXrpwmFGIRCCzmF/IJbhXx1Bbp07a/Ns3Dn3RuRHKESy
         I5H3BnVVOQZsWUTE1qpIVxrcf/M7fmLLC5xCpBZQ25HLA1334R0XadfBZoTAdCdzzBwi
         /11Ar9Y2BAjhylYolQiDB9IkKls6vtGJABISbS8MIJaOoHn1L99lpLZvtMsGFamer4zX
         KGfw==
X-Gm-Message-State: AOAM532ryUZ1uHQUwEz4y3HH+qUrZlajnzCmBn3fP283ZiDRhF7zqhBB
        f1ihZUo4Rbx7Rci4zElizmWnBl8vZ5D7DHkAZQCCIA==
X-Google-Smtp-Source: ABdhPJz1Z6RHfokkDk1nsGqHkzY0Eso/NAYD3JoNvRiQCC7JJzY2omDv4F4SJBQsn7SH4y16tveNnvG9KLVTTrGsTbE=
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr6743574wme.177.1594780490700;
 Tue, 14 Jul 2020 19:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <CAFTs51UHaUqaKj5bEj0vQtEZrww9gnrqb-kGVk7DAgQJPBAR+w@mail.gmail.com>
 <775688146.12145.1594748580461.JavaMail.zimbra@efficios.com> <CAPNVh5fiCCJpyeLj_ciWzFrO4fasVXZNhpfKXJhJWJirXdJOjQ@mail.gmail.com>
In-Reply-To: <CAPNVh5fiCCJpyeLj_ciWzFrO4fasVXZNhpfKXJhJWJirXdJOjQ@mail.gmail.com>
From:   Chris Kennelly <ckennelly@google.com>
Date:   Tue, 14 Jul 2020 22:34:38 -0400
Message-ID: <CAEE+ybmt4BredezuTPdh-vf=FkKtu0yAhWuf+0daUe89AnbmPg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
To:     Peter Oskolkov <posk@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 14, 2020 at 2:33 PM Peter Oskolkov <posk@google.com> wrote:
>
> On Tue, Jul 14, 2020 at 10:43 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > ----- On Jul 14, 2020, at 1:24 PM, Peter Oskolkov posk@posk.io wrote:
> >
> > > At Google, we actually extended struct rseq (I will post the patches
> > > here once they are fully deployed and we have specific
> > > benefits/improvements to report). We did this by adding several fields
> > > below __u32 flags (the last field currently), and correspondingly
> > > increasing rseq_len in rseq() syscall. If the kernel does not know of
> > > this extension, it will return -EINVAL due to an unexpected rseq_len;
> > > then the application can either fall-back to the standard/upstream
> > > rseq, or bail. If the kernel does know of this extension, it accepts
> > > it. If the application passes the old rseq_len (32), the kernel knows
> > > that this is an old application and treats it as such.
> > >
> > > I looked through the archives, but I did not find specifically why the
> > > pretty standard approach described above is considered inferior to the
> > > one taken in this patch (freeze rseq_len at 32, add additional length
> > > fields to struct rseq). Can these be summarized?
> >
> > I think you don't face the issues I'm facing with libc rseq integration
> > because you control the entire user-space software ecosystem at Google.
> >
> > The main issue we face is that the library responsible for registering
> > rseq (either glibc 2.32+, an early-adopter librseq library, or the
> > application) may very well not be the same library defining the __rseq_abi
> > symbol used in the global symbol table. Interposition with ld preload or
> > by defining the __rseq_abi in the program's executable are good examples
> > of this kind of scenario, and those use-cases are supported.

Does this work if/when we run out of bytes in the current sizeof(__rseq_abi)?

Which library provides the TLS symbol (and N bytes of storage) seems
sensitive to the choices the linker makes for us, once the symbol
sizes diverge.

> > So the size of the __rseq_abi structure may be larger than the struct
> > rseq known by glibc (and eventually smaller, if future glibc versions
> > extend their __rseq_abi size but is loaded with an older program/library
> > doing __rseq_abi interposition).

When glibc provides registration, is the anticipated use case that a
library would unregister and reregister each thread to "upgrade" it to
the most modern version of interface it knows about provided by the
kernel?

> > So we need some way to allow code defining the __rseq_abi to let the kernel
> > know how much room is available, without necessarily requiring the code
> > responsible for rseq registration to be aware of that extended layout.
> > This is the purpose of the __rseq_abi.flags RSEQ_FLAG_TLS_SIZE and field
> > __rseq_abi.user_size.
> >
> > And we need some way to allow the kernel to let user-space rseq critical
> > sections (user code) know how much of those fields are actually populated
> > by the kernel. This is the purpose of __rseq_abi.flags RSEQ_FLAG_TLS_SIZE
> > with __rseq_abi.kernel_size.

I authored the userspace component
(https://github.com/google/tcmalloc/commit/ad136d45f75a273b934446699cef8b278c34ec6e)
that consumes the extensions Peter mentions and found that minimizing
the performance impact of their potential absence was a bit of a
challenge.

There, I could assume an all-or-nothing registration of the new
feature--limited only by kernel availability for thread
homogeneity--but inconsistencies across early adopter libraries would
mean each thread would have to examine its own TLS to determine if a
feature were available.

Chris
