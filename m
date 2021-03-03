Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E474032B048
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbhCCDFt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 22:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbhCCAUZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 19:20:25 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CCDC06178B
        for <linux-api@vger.kernel.org>; Tue,  2 Mar 2021 16:19:19 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id u75so22620537ybi.10
        for <linux-api@vger.kernel.org>; Tue, 02 Mar 2021 16:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JW1Fu4Y9hN6xAYARes5cfh1tpWz1vPxhWkj9gQP9lMg=;
        b=u1nwXvtWmXFyEWnp6VppaODAurHV9DyB0Hjtg4WhYgLJVNAaoIYeGJZvU43qMBUJ6E
         IimgA+XS3J5QwuPCb+tO6o9paf11kNThyRGMElbfERtDWM6tg7RKMBHM6hkBjx2TNkFj
         OZn61IWqGoUx1mJO0BlY3FtpWDlbc6MErJ8pv/xoVwQa2urYmDCCwSmKgctPgLkBb44M
         cWiqTvILyMC8/sIgRNeraaWg8r7RXj9ftkUPl7pCM2LV0SUr8p9hhBKyfWKaFXBtJr/j
         Yac8vr0Eod4rNzqVMvFe38E7kuDnD2dppBfLoaFX266TkyDIxtSKKz6k1RFaXJlguCV0
         mu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JW1Fu4Y9hN6xAYARes5cfh1tpWz1vPxhWkj9gQP9lMg=;
        b=EQemgv/VL/4Ah5bN0JjGLSokp1Ql3Sh1gxBK7hakMXc65+PRvT1e9aqFoffxhhTIKM
         SKgdCaLYhlk4eg0bkNsSTU78esgJXnPzs4adMH2qUtWD6SVRZ+q9gzDrGE46C4d0yAZx
         IlPFTmNRpgZViwG3h5mTN2WjAqfZmV+xnLn6cq5tWhSRyMrHgjZo4qR4UWLrAEPZCE8r
         TTqXDU2p7/UFptpDvUZV/sS84b9zDSxrZvyruTrHYB7EtU5WKRMcKPtVwPyW8V0SNuCt
         y/nkX9T4Dg9cLsZ7CZ6D6GN8m0d0Ixm3T91twiMovZfaudCdQtZOhEPn6RgvW/kq5i3I
         ARaw==
X-Gm-Message-State: AOAM532M/44D4XaeBcsLi76QwwKbJWCht5rPBgs8Gb07lSSgnCAMjz80
        bSpDmHsEvE6TVqYtJfEBdfW1Cv0vcXRfYUQp2ptZZQ==
X-Google-Smtp-Source: ABdhPJyRJft9qC3F2zEP87gLkkL8hWzq9DSLyGwU9vBpLj1qV5qHyP+0wGclenGJnbIjvyqXGUZQfBpD7UTJ5dJvT2k=
X-Received: by 2002:a25:d74b:: with SMTP id o72mr33962620ybg.190.1614730758774;
 Tue, 02 Mar 2021 16:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210112074629.GG22493@dhcp22.suse.cz>
 <20210112174507.GA23780@redhat.com> <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
 <20210113142202.GC22493@dhcp22.suse.cz> <CAG48ez0=QSzuj96+5oVQ2qWqfjedv3oKtfEFzw--C8bzfvj7EQ@mail.gmail.com>
 <20210126135254.GP827@dhcp22.suse.cz> <CAJuCfpEnMyo9XAnoF+q1j9EkC0okZfUxxdAFhzhPJi+adJYqjw@mail.gmail.com>
 <CAJuCfpF861zhp8yR_pYx8gb+WMrORAZ0tbzcKtKxaj7L=jzw+Q@mail.gmail.com>
 <CAJuCfpFzxiBXp1rdY=H=bX+eOAVGOe72_FxwC-NTWF4fhUO26g@mail.gmail.com>
 <CAJuCfpEOE8=L1fT4FSauy65cS82M_kW3EzTgH89ewE9HudL=VA@mail.gmail.com> <20210302161716.89a65d3cb5b60dbc5074cfa7@linux-foundation.org>
In-Reply-To: <20210302161716.89a65d3cb5b60dbc5074cfa7@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 Mar 2021 16:19:07 -0800
Message-ID: <CAJuCfpF72mevYd4zQ_q-Tyn+Bj-fa7ywudu=iM6L7e4B-42fpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 2, 2021 at 4:17 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 2 Mar 2021 15:53:39 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Hi Andrew,
> > A friendly reminder to please include this patch into mm tree.
> > There seem to be no more questions or objections.
> > The man page you requested is accepted here:
> > https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=a144f458bad476a3358e3a45023789cb7bb9f993
> > stable is CC'ed and this patch should go into 5.10 and later kernels
> > The patch has been:
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > If you want me to resend it, please let me know.
>
> This patch was tough.  I think it would be best to resend please, being
> sure to cc everyone who commented.  To give everyone another chance to
> get their heads around it.  If necessary, please update the changelog
> to address any confusion/questions which have arisen thus far.

Sure, will do. Thanks!

>
> Thanks.
