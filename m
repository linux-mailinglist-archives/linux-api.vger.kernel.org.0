Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E437307FC0
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 21:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhA1Uio (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 15:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhA1Uim (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Jan 2021 15:38:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DD8C06174A
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 12:38:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m13so6740404wro.12
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 12:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UVTyfisZAnJyUTGj4E05jEDNc8Dha7tB5MVBOZTxgI=;
        b=ThxQPnFlQS2JusYTiQxFRP3+0zCf67Lx1mZmUowPWQxOSXDGBf95O4lG5NKH0KvxFB
         Njg81kGWKAhCSjVrUAT5rwS36+YsMq93vtkglgZDRf9+97oM5WB/yHVObYB6bh878ytQ
         LI3TljWwYHbhh9xVUucfC3iUGmatqLJI0PvLxitJOoIwtWHV+iIU5A0Opi8hXMTNpipK
         M7sCdDcKFeXICxGPa4UxsZSjQdeWH/cT3hFXNuP/KbYlwsFrLc3vbKX9ByhKaeRH8idL
         5ExA6IFOiCNtWzF1wU8tB6vVMTG/rTOHlXqIlVkwIx8rD36WcPaduWxDPtr6Kmt5APXY
         WcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UVTyfisZAnJyUTGj4E05jEDNc8Dha7tB5MVBOZTxgI=;
        b=IHjdOfmluvX6cJv+JCHiIiuB8BErtUYiIn0hZHvU5/6zCtY6xjWkDRejYtyB9Esbtt
         ppd4qzCwUCube5xF8v1Sim1hHgZkR3Keckq/v4lkVbCLRmtfRFdKw9cHgCxdzYCaQYBO
         NSmgqymGgiScaxt4TcATC+gT3qYEqqER2675IolL99nUkT2mS9qeq7ESm6kHyPqzS9R/
         9Ol0u0T35ta86RtxNP9YdWG6XuzsxuiQgxB/i0J7DTNJIrhhDikMC65YYGtOCufuVRLN
         3i1st4uuyKSdTmnIt9Hy+2b5Kb4oiIrj8iUuehd1xuZNxK9xHNM3fwAdMYEtQXx+OPeV
         0jOQ==
X-Gm-Message-State: AOAM5331+fEIEbVtrmDMl8LJ2dgISiXVLALyfnbqTT2C0NshuPns/ZrR
        YWbVu2YiYkHYRrFLo25DMgr++0/0lCBe+gXONUh5PA==
X-Google-Smtp-Source: ABdhPJx+4T/pO4+VmwEvjZVx1CDiwbKYgrpPlUmq9ilFyshra0xthpiM/f5kvNBGGgKzNC8NOCSNdGRi87R0LyUm7L8=
X-Received: by 2002:a5d:6884:: with SMTP id h4mr999072wru.106.1611866280568;
 Thu, 28 Jan 2021 12:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20210120202337.1481402-1-surenb@google.com> <CAKgNAkgsQWL3QAyF6CQU=yifzA1tfp_E5kBBNKuAq_+sB4Amyw@mail.gmail.com>
 <CAJuCfpEfMgA6z5S5gmHwJB_3KWwmKKp434GeHheUGF3yC7r01w@mail.gmail.com> <6cd84701-fb65-7aa0-38db-b69fe5748754@gmail.com>
In-Reply-To: <6cd84701-fb65-7aa0-38db-b69fe5748754@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Jan 2021 12:37:49 -0800
Message-ID: <CAJuCfpGsi_973t=c0TXCQE4JPSN+APJW-insxFuRUwbWh4Pk-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] process_madvise.2: Add process_madvise man page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jan 28, 2021 at 12:31 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Suren,
>
> On 1/28/21 7:40 PM, Suren Baghdasaryan wrote:
> > On Thu, Jan 28, 2021 at 4:24 AM Michael Kerrisk (man-pages)
> > <mtk.manpages@gmail.com> wrote:
> >>
> >> Hello Suren,
> >>
> >> Thank you for writing this page! Some comments below.
> >
> > Thanks for the review!
> > Couple questions below and I'll respin the new version once they are clarified.
>
> Okay. See below.
>
> >> On Wed, 20 Jan 2021 at 21:36, Suren Baghdasaryan <surenb@google.com> wrote:
> >>>
>
> [...]
>
> Thanks for all the acks. That let's me know that you saw what I said.
>
> >>> RETURN VALUE
> >>>     On success, process_madvise() returns the number of bytes advised. This
> >>>     return value may be less than the total number of requested bytes, if an
> >>>     error occurred. The caller should check return value to determine whether
> >>>     a partial advice occurred.
> >>
> >> So there are three return values possible,
> >
> > Ok, I think I see your point. How about this instead:
>
> Well, I'm glad you saw it, because I forgot to finish it. But yes,
> you understood what I forgot to say.
>
> > RETURN VALUE
> >      On success, process_madvise() returns the number of bytes advised. This
> >      return value may be less than the total number of requested bytes, if an
> >      error occurred after some iovec elements were already processed. The caller
> >      should check the return value to determine whether a partial
> > advice occurred.
> >
> >     On error, -1 is returned and errno is set appropriately.
>
> We recently standardized some wording here:
> s/appropriately/to indicate the error/.

ack

>
>
> >>> +.PP
> >>> +The pointer
> >>> +.I iovec
> >>> +points to an array of iovec structures, defined in
> >>
> >> "iovec" should be formatted as
> >>
> >> .I iovec
> >
> > I think it is formatted that way above. What am I missing?
>
> But also in "an array of iovec structures"...

ack

>
> > BTW, where should I be using .I vs .IR? I was looking for an answer
> > but could not find it.
>
> .B / .I == bold/italic this line
> .BR / .IR == alternate bold/italic with normal (Roman) font.
>
> So:
> .I iovec
> .I iovec ,       # so that comma is not italic
> .BR process_madvise ()
> etc.

Aha! Got it now. It's clear after your example. Thanks!

>
> [...]
>
> >>> +.I iovec
> >>> +if one of its elements points to an invalid memory
> >>> +region in the remote process. No further elements will be
> >>> +processed beyond that point.
> >>> +.PP
> >>> +Permission to provide a hint to external process is governed by a
> >>> +ptrace access mode
> >>> +.B PTRACE_MODE_READ_REALCREDS
> >>> +check; see
> >>> +.BR ptrace (2)
> >>> +and
> >>> +.B CAP_SYS_ADMIN
> >>> +capability that caller should have in order to affect performance
> >>> +of an external process.
> >>
> >> The preceding sentence is garbled. Missing words?
> >
> > Maybe I worded it incorrectly. What I need to say here is that the
> > caller should have both PTRACE_MODE_READ_REALCREDS credentials and
> > CAP_SYS_ADMIN capability. The first part I shamelessly copy/pasted
> > from https://man7.org/linux/man-pages/man2/process_vm_readv.2.html and
> > tried adding the second one to it, obviously unsuccessfully. Any
> > advice on how to fix that?
>
> I think you already got pretty close. How about:
>
> [[
> Permission to provide a hint to another process is governed by a
> ptrace access mode
> .B PTRACE_MODE_READ_REALCREDS
> check (see
> BR ptrace (2));
> in addition, the caller must have the
> .B CAP_SYS_ADMIN
> capability.
> ]]

Perfect! I'll use that.

>
> [...]
>
> >>> +.TP
> >>> +.B ESRCH
> >>> +No process with ID
> >>> +.I pidfd
> >>> +exists.
> >>
> >> Should this maybe be:
> >> [[
> >> The target process does not exist (i.e., it has terminated and
> >> been waited on).
> >> ]]
> >>
> >> See pidfd_send_signal(2).
> >
> > I "borrowed" mine from
> > https://man7.org/linux/man-pages/man2/process_vm_readv.2.html but
> > either one sounds good to me. Maybe for pidfd_send_signal the wording
> > about termination is more important. Anyway, it's up to you. Just let
> > me know which one to use.
>
> I think the pidfd_send_signal(2) wording fits better.

ack, will use pidfd_send_signal(2) version.

>
> [...]
>
> Thanks,
>
> Michael

I'll include your and Michal's suggestions and will post the next
version later today or tomorrow morning.
Thanks for the guidance!

>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
