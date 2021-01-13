Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5325E2F51B1
	for <lists+linux-api@lfdr.de>; Wed, 13 Jan 2021 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbhAMSJB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Jan 2021 13:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbhAMSJB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Jan 2021 13:09:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84599C061575
        for <linux-api@vger.kernel.org>; Wed, 13 Jan 2021 10:08:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r3so3132863wrt.2
        for <linux-api@vger.kernel.org>; Wed, 13 Jan 2021 10:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yH5u9y2wy1keEH/7cm+6LpeR3BpSRhAV0Ow7SdVvy58=;
        b=Bdwk6nUFlCU+LPWRFAuXQj2yM2oD/qD5nc1ASW24XvBCfyLvhbRO7i0GT9uj20AayT
         4B+343KPnyqctxOjxfYPws509SjQuI5J8b/pPdcgSc+uDXEV6LyPX+J9ayTX+9A2OCCZ
         h+nDYj7pStlw/LGEB/Bb2bXgqu1XoeRv1PKo8d5i/nE0KuKXr0kVsdZENuXc4+boAk8x
         fYxlXgqy4kH8FIaLjvInn0JaKu2+v9aqajNCZ87OH3iY/0siM7zeqtK00jRVHa7r6oOv
         MoTOEk69/OTdcIZa2OWgDqZDRLKXQNyg0L4+hSEcDw3lwZWMWXI4xYb7hZ6bVxYPZvuG
         mxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yH5u9y2wy1keEH/7cm+6LpeR3BpSRhAV0Ow7SdVvy58=;
        b=JNhVsJELSSNe3p1XU2wTPv1BWmSIFdovvyj6pVhie5EAzvGg1p8FW8IX0JK2ecU+BK
         6vCcivxLBzJqLVIOEaJsd4toNwnsDNxOJIFyDFs00Py13ywQWK5ZO+u2SGwUPZK7g72r
         nAgiwdXebgUz/Bf69dyoZFbIGFqlMuS3Mj+jU7iDI74Ax9ry2G/Bzme9JB1hvjKDKzCD
         2VVuM3pszx1GOwI6rarmMUFZyUPgRhtYYi6mnroSKbtq8hx7rQJsQUxQnV7astvEXZ5W
         zTHw7Gy/QRtNMeQ18YnEsVTGzHfUWJKc3el+8y0Mhb4c21EHx0miJEksHn0K70KdwjQJ
         22pA==
X-Gm-Message-State: AOAM533iddHIaLTuJe/J95ZeU9qnOIjwIHQ31XfkILgRguXtQkohEAkp
        3EMnx90GY67aVRBvuvvFlydEcJFoI02XjJbD+1ntDQ==
X-Google-Smtp-Source: ABdhPJzvfLlFhauGSP5N6MGXJl9v13+O6cX+vTvVC9ye8FhSO5okdudU++QgL2t0g5Ek15bT4blDIQNiAZWIwiPjFRE=
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr4006181wrs.106.1610561299128;
 Wed, 13 Jan 2021 10:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210112074629.GG22493@dhcp22.suse.cz>
 <20210112174507.GA23780@redhat.com> <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
 <20210113142202.GC22493@dhcp22.suse.cz>
In-Reply-To: <20210113142202.GC22493@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 13 Jan 2021 10:08:08 -0800
Message-ID: <CAJuCfpEccYMENy_6PrVFTC1_Xx3wV2E2805wsSLENbW+C_mbfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Michal Hocko <mhocko@suse.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
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

On Wed, Jan 13, 2021 at 6:22 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-01-21 09:51:24, Suren Baghdasaryan wrote:
> > On Tue, Jan 12, 2021 at 9:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > On 01/12, Michal Hocko wrote:
> > > >
> > > > On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
> > > >
> > > > > What we want is the ability for one process to influence another process
> > > > > in order to optimize performance across the entire system while leaving
> > > > > the security boundary intact.
> > > > > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > > > > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > > > > and CAP_SYS_NICE for influencing process performance.
> > > >
> > > > I have to say that ptrace modes are rather obscure to me. So I cannot
> > > > really judge whether MODE_READ is sufficient. My understanding has
> > > > always been that this is requred to RO access to the address space. But
> > > > this operation clearly has a visible side effect. Do we have any actual
> > > > documentation for the existing modes?
> > > >
> > > > I would be really curious to hear from Jann and Oleg (now Cced).
> > >
> > > Can't comment, sorry. I never understood these security checks and never tried.
> > > IIUC only selinux/etc can treat ATTACH/READ differently and I have no idea what
> > > is the difference.
> >
> > I haven't seen a written explanation on ptrace modes but when I
> > consulted Jann his explanation was:
> >
> > PTRACE_MODE_READ means you can inspect metadata about processes with
> > the specified domain, across UID boundaries.
> > PTRACE_MODE_ATTACH means you can fully impersonate processes with the
> > specified domain, across UID boundaries.
>
> Maybe this would be a good start to document expectations. Some more
> practical examples where the difference is visible would be great as
> well.

I'll do my best but I'm also not a security expert. Will post the next
version with a draft for the man page (this syscall does not have a
man page yet AFAIKT) and we can iterate on the wording there.

> > He did agree that in this case PTRACE_MODE_ATTACH seems too
> > restrictive (we do not try to gain full control or impersonate a
> > process) and PTRACE_MODE_READ is a better choice.
>
> All that being said, I am not against the changed behavior but I do not
> feel competent to give an ack.

Great. SOunds like the only missing piece is the man page with more
details. I'll work on it but since it's the first time I will be
contributing to man pages it might take me a couple days. Thanks
everyone for the reviews!

> --
> Michal Hocko
> SUSE Labs
