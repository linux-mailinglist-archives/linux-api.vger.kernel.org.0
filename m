Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D44308650
	for <lists+linux-api@lfdr.de>; Fri, 29 Jan 2021 08:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhA2HQC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 Jan 2021 02:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhA2HP5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 Jan 2021 02:15:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3662C0613D6
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 23:15:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f16so6021184wmq.5
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 23:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLdacsm3XogIsaiExukBUmqPzsJY8TDJ1FbcWEsqSm4=;
        b=axhlIo/D+wi8wYEr5mSU2TeU2BHoww+YZeD6E6GdrBwgl9gpG9ta/zxED6w811vA1e
         XUkx3ytL3FDQNK19YaMIEfgRJ9aJTyOqVg4+lHSJSxmM/EXiU0PQeTncr79rkwfJI3As
         rS0N5aN3Puio1orZOigpQI40abIOPc4XPhctpY411MUxXy/iO7Ha1wmCcwBa9I+sr8kh
         z2fSowH8P0SCc6TKI1/wZMphf47/x3IAmMNlXetDpHKsjLgiu9uOK97lKzrZ6fPGCh86
         4Hg+FaVgBIqtMK8TmAQN6CW2XmGYez8FXgs1HYOoQcmOJwObMajdXLB5rgANhUDDeeXq
         0SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLdacsm3XogIsaiExukBUmqPzsJY8TDJ1FbcWEsqSm4=;
        b=JksSDxir40GmW9RD1WHu/12ChvEY9FgdlW0UYwW5keJfQQ4go2CET5d0Tmi7ZYY7Sl
         AwyJrNugYD0EcZyBar7pezKoA7nwkF3G8UJ2TMMmFJ4nWEHLCHwFY1k6nI0ncL1wCjo3
         ylR7Ows5Hp5cmOlOSMQRBHpw9N7mU/LNHaw/iKYvTfpaxXhol4asRHTCD/zYBwZINhfd
         7OrY1a6KV3ah6NTk7jPMFZjQs1M6baWJKawKNCtE1t3F15lBm8UU+ozvCvwxxBxE6lsI
         GTOuCPgfs876pwAkE7g21FsiHuM0PqehgkbCdAb3WxZflHC4vRHm311vO76UWhJ1ulIG
         glWQ==
X-Gm-Message-State: AOAM531xRY7JU8rpG1udmwAqj5pHfrA3MtidfMYQcQrCqQ0A0KzBsQ1m
        zmUZ8Tg3yI70jsxVRQCGMl6PPhjGClF5ABFgfArcJg==
X-Google-Smtp-Source: ABdhPJxpkxr3lWUY1Rn0hsphGiX4XcyWnJxlD176nyKrLed2lzKaKrzUHbmSNYf+8M3ImhOcw+T4C3o2/WEbt+7Lfus=
X-Received: by 2002:a1c:7906:: with SMTP id l6mr2443143wme.22.1611904515127;
 Thu, 28 Jan 2021 23:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20210120202337.1481402-1-surenb@google.com> <CAKgNAkgsQWL3QAyF6CQU=yifzA1tfp_E5kBBNKuAq_+sB4Amyw@mail.gmail.com>
 <CAJuCfpEfMgA6z5S5gmHwJB_3KWwmKKp434GeHheUGF3yC7r01w@mail.gmail.com> <6cd84701-fb65-7aa0-38db-b69fe5748754@gmail.com>
In-Reply-To: <6cd84701-fb65-7aa0-38db-b69fe5748754@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Jan 2021 23:15:04 -0800
Message-ID: <CAJuCfpE+g96MW+x9A9M0PT_a6-FDtJNFnx6mk9cW3JkZ-SDjvw@mail.gmail.com>
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

In V2 I explanded a bit this part to explain why CAP_SYS_ADMIN is
needed. There were questions about that during my patch review which
adds this requirement
(https://lore.kernel.org/patchwork/patch/1363605), so I thought a
short explanation would be useful.

> ]]
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
>
> [...]
>
> Thanks,
>
> Michael
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
