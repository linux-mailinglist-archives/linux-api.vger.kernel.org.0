Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FDD2EFD19
	for <lists+linux-api@lfdr.de>; Sat,  9 Jan 2021 03:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAICUP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Jan 2021 21:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbhAICUP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 Jan 2021 21:20:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C8C061573
        for <linux-api@vger.kernel.org>; Fri,  8 Jan 2021 18:19:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d13so10647339wrc.13
        for <linux-api@vger.kernel.org>; Fri, 08 Jan 2021 18:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=052XPomPT0oPS9EFhbYOVhGRK5vb4IUUAo6lA6fY0a0=;
        b=Z//feIYP4BzIRBimKHRKIg3TS3FG+WbtsSOWeEzhIELipSoM/VopcW5yHQ8lBDSyNb
         cYtg10MGwnE3DBvOmC7Cpkkka8+K1+w3YgfHSDm78A6+pyVCRaqWSasoAB5OfPOaXT/k
         YtbB8X2JQ0DgQoyVeZW3R/ffL8fnqs5nVmfG4gr0Kzwnf350NBWSMa2sQuHmz48Cf3Xm
         n7tiAIB8q22oaykBB+CZ6214yMk/0IEKYux2zUP9uEa/x+RWWIL84MlWht+vNT0DTTom
         sLdoXIhK6FD3DANRI8tlhK+mZBRIzG51rgmCIwhhWVAyGx19W1RqftDiE8wf81zgHmO1
         1b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=052XPomPT0oPS9EFhbYOVhGRK5vb4IUUAo6lA6fY0a0=;
        b=WezK0diqN3r69uVHMflAQJhdN96IJVzS44e5SxveYvrciTqhl4ClyJFA2ofoOjzH2d
         1Gy/yPGT7nplallKq1eipiL87DOcTKciVwfr+2YO+RceF4214jxD+9y5k3jUWet8pyCt
         Oenwae2LlokQxLIXB/IVGlv6vjzEsTSEpZ/Czk3tWPpNugu98f492WVHgQJXuL1x/LKo
         qheh7e8RMKXVH39UeQz0YGp0tGY9z2bTtDN/qBYbRvVM04+6B+RvNXykMjpjXBQTGSaS
         WJ4VkvuPQTfUZjGPhf45W63dxYX1aZCpkZLQqfxh/196ETbN1iTu5a3bqBizYcu8MBPP
         zF1A==
X-Gm-Message-State: AOAM533ByTP5ehxJonm8+luiFr4/xBO5Winf10VTjSgbUZSMOFDK6qrF
        4DSkQegYmHL1OanFV5yYWGHrjJKIfl76CW3Z3eU6dQ==
X-Google-Smtp-Source: ABdhPJyvZEkJKALenbMvuoA7Rd/6gdTN0lh35/p88gWogUSV/ynhdTPItqFJ8Ggl7nc3v8PnPlUz5dEz5QJjKO1PF4Q=
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr6298503wro.162.1610158773355;
 Fri, 08 Jan 2021 18:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20210108205857.1471269-1-surenb@google.com> <X/jZibYD1B42D+r7@google.com>
 <CAJuCfpHa3XHVEjNBDHJNo3RBWGdLnXsgZH9wyiGLqj655GwE2w@mail.gmail.com> <db29d560-45d9-1eb3-60d0-8d6153ac7193@google.com>
In-Reply-To: <db29d560-45d9-1eb3-60d0-8d6153ac7193@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 8 Jan 2021 18:19:22 -0800
Message-ID: <CAJuCfpE3QR-8Lm_0cnCFQsDiU2Ui87E6ARQ+ScQuDZ1TNfm-tg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     David Rientjes <rientjes@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 8, 2021 at 5:02 PM David Rientjes <rientjes@google.com> wrote:
>
> On Fri, 8 Jan 2021, Suren Baghdasaryan wrote:
>
> > > > @@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> > > >               goto release_task;
> > > >       }
> > > >
> > > > -     mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > > > +     /* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> > > > +     mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > > >       if (IS_ERR_OR_NULL(mm)) {
> > > >               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > > >               goto release_task;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Require CAP_SYS_NICE for influencing process performance. Note that
> > > > +      * only non-destructive hints are currently supported.
> > > > +      */
> > > > +     if (!capable(CAP_SYS_NICE)) {
> > > > +             ret = -EPERM;
> > > > +             goto release_task;
> > >
> > > mmput?
> >
> > Ouch! Thanks for pointing it out! Will include in the next respin.
> >
>
> With the fix, feel free to add:
>
>         Acked-by: David Rientjes <rientjes@google.com>

Thanks! Will post a new version with the fix on Monday.

>
> Thanks Suren!
