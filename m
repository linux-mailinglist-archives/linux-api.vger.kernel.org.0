Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053401E147D
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389835AbgEYSu1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389242AbgEYSu1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 14:50:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4347C061A0E;
        Mon, 25 May 2020 11:50:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id se13so21356381ejb.9;
        Mon, 25 May 2020 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=yacm3U0qWCWgeSmXbcjYqJ4T7TsFvh8zB4Vu1STfoFM=;
        b=uQa+JryU5U/xkprr0VU4wHLb1ptlusOM492zyG8yptXBCQ7qII6dwK/9S+0Er1CJVi
         vdZVJu04IYtyxD8tt6oI2Dby72CGOP8y6yf12XXVdNrTX3D1mLvWrrrG4ZZUsKs344sR
         uc5s88RYB//nXT5BVmBNbwI/LOnWW/BWJSEpNgIpaLbjr8w3ghGCUjiaRrx3nQKDuBpU
         LbVRM7shQHOWAKrtO70/jP82aiMaxHB4cIeA3BDQ5ueUgui6UfOflHRsuYs9+fyUFIfu
         dx766EfXFLguqRAiRFbhAgJaP3cCPYzU7OwKH1NPi5O3wfRDM3/8fjbgPyjsN4ye4JEF
         M0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=yacm3U0qWCWgeSmXbcjYqJ4T7TsFvh8zB4Vu1STfoFM=;
        b=jVi7nFNUWz3ubpOVsCHMFMdtODE0+0CAhadSSQR8fRQgX5JSfOHVAG9kvor2EnHQtb
         hFVRl4N5g0cE5UrXQRuj2zaZevDb+ETgKVFGCMss7lWtk2KbsMMbNilECVsLZ+uU8J80
         eKQgSzWzZrHrThuope4YApbBTFt/kjAUZxFd95vqEmW/K+ODCseAvSK1e5eCBpr+cX6m
         FN0Q91eP6pUKtLp2QiQ4fMkIMOH62efP3FWT7EMTN5w37ry4b05Y8jkS3xb9t+rEqGi0
         B43IxoRieRyiNyJ8hNMFHYQB4z0007w/KHQdNtdaIol7uVzvlNi/oQgjSYkNmJIr05/u
         eCIA==
X-Gm-Message-State: AOAM533lqHVFxCUFmUPsCTHW6bwb1siyiCrxyBg1OePnqHylBkpWAwEd
        3r77UUtP+mDVTRrS6v5oxpUL65ILeCG40u9JflU=
X-Google-Smtp-Source: ABdhPJyC9tuTXMYG9K8YfU4Pyf8Jg11LDH1/yKS69qMXTsf7ZZM9DsSbPV2QF3umu5gcdOx0/SP74f0QpwbjwAnUHLQ=
X-Received: by 2002:a17:906:41a:: with SMTP id d26mr20778426eja.217.1590432624419;
 Mon, 25 May 2020 11:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200521222551.259804-1-irogers@google.com> <CAP-5=fXjXgWEgp9gqReByrDBTvjDbPEsubeAFxrpxj_+FsFn6w@mail.gmail.com>
 <1edcb7ac-bc5f-b9ec-a037-656005ae85e3@gmail.com> <20200525145906.e5xfzmj6hvl7t4fg@box>
In-Reply-To: <20200525145906.e5xfzmj6hvl7t4fg@box>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 25 May 2020 20:50:13 +0200
Message-ID: <CAKgNAkg8OG1gCvZcaAMYmwpd-_MPMis4kGfDRgZGgp3o_MxUag@mail.gmail.com>
Subject: Re: [PATCH] proc.5: add "wf" to VmFlags in /proc/[pid]/smaps
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Ian Rogers <irogers@google.com>, Rik van Riel <riel@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, nilal@redhat.com,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Colm_MacC=C3=A1rtaigh?= <colm@allcosts.net>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 25 May 2020 at 16:59, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Mon, May 25, 2020 at 03:50:38PM +0200, Michael Kerrisk (man-pages) wrote:
> > On 5/22/20 1:13 AM, Ian Rogers wrote:
> > > On Thu, May 21, 2020 at 3:25 PM Ian Rogers <irogers@google.com> wrote:
> > >>
> > >> This patch documents a flag added in the following kernel commit:
> > >>
> > >> commit d2cd9ede6e193dd7d88b6d27399e96229a551b19
> > >> Author: Rik van Riel <riel@redhat.com>
> > >> Date:   Wed Sep 6 16:25:15 2017 -0700
> > >>
> > >>     mm,fork: introduce MADV_WIPEONFORK
> > >>
> > >> This was already documented in man2/madvise.2 in the commit:
> > >>
> > >> commit c0c4f6c29c494c466f3a2a6273c5b55b76a72927
> > >> Author: Rik van Riel <riel@redhat.com>
> > >> Date:   Tue Sep 19 20:32:00 2017 +0200
> > >>
> > >>     madvise.2: Document MADV_WIPEONFORK and MADV_KEEPONFORK
> > >>
> > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Doing a quick audit of fs/proc/task_mmu.c having noticed this flag was
> > > missing I note:
> > >  - "mp" isn't documented, only possible with INTEL_MPX
> > >  - "nl" is documented but not present in show_smap_vma_flags
> > >  - "um" and "uw" aren't documented
> >
> > I took a shot at fixing these:
> >
> >
> >              mp  - MPX-specific VMA (x86, since Linux 3.19)
>
> This one is gone. The patch to remove leftovers of MPX is linux-next.

Thanks, Kirill. I'll simply remove that entry.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
