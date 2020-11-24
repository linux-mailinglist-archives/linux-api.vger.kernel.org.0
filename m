Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4143A2C2F27
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 18:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404049AbgKXRry (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 12:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404040AbgKXRry (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 12:47:54 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418EEC0613D6
        for <linux-api@vger.kernel.org>; Tue, 24 Nov 2020 09:47:52 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so30145754lfg.0
        for <linux-api@vger.kernel.org>; Tue, 24 Nov 2020 09:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBvdxE2ZMFJMjEWowg/8vkDR+EJtYbLtmKIhC1tTWa4=;
        b=eUfyso5qnVBEifJ8Un7AiNAgM3bkJdE3LxUDITLN+Cp7b4V+Hmur6vRsVALDz8z6jM
         7sUgbX/bPUY+WdI1ID3C4peVma+0/3KoNchjxF54EFV7aCQ0g5dZloVxY/qpercaEzqY
         8llbSj9cbON+LzLGVLB8NcW+iZkjaf3VMbSAvDnUWuVIBOzw6UYZ2q6RPpISc0F3Ffu8
         OoQFxGRt9FKL+lxgVfd3FUIljbypXESLb9WOCMv5AsakKM9Xwi76NXlhEdR2i91RpdvC
         djbyDa2By5GUoZgKn3ggm9XIfWAC9aYPcyu1ZrCG0J0HpUd5jy557qYVmw/JiWiukVb5
         V4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBvdxE2ZMFJMjEWowg/8vkDR+EJtYbLtmKIhC1tTWa4=;
        b=eVEK88T2Z+lY/Ca+NGrsp1wcZ1meqZiEE8aZohJCk+jpcHJo2MR5r4RjOO2n7BvPqs
         nQVl15Fy6G5HjikiyZBgcBaStCRXExoQpPm3mPMRJJWPhfGl9Hx1+GHIcGE3IAPryhEp
         Q8HLM3/UTfT/MQG8RrYOEUmtUYjbPkJpRRL+Px1/D3sqjGUDpt3dRr3MPL0twtUR159B
         XV7jDjhiDFymQPJ3l2oefnCzjTU6vIaF8dP7rdGXtf6sj/qbM0kqSkqcCVZj2GwVPU97
         OiH3hbWnbgF2YeNBHcBaQUJP5Xe3scZ23/HnPVID6LN/mObCdr12uKrhtI9OTEQ+3qXj
         O67g==
X-Gm-Message-State: AOAM532eXrm0ZwkdTpMVH7sej2ZHyCpyOlisKn373hxaiPxDr4CYNVWN
        QlZpJGYoU1MMNPccYu6s6x06h8fRBMoGgcAF9dAQrg==
X-Google-Smtp-Source: ABdhPJxoj0vRU23tyVRdct6OOAD7fJtx1Mij3ypPETiW6TBLpnkB+WqmeahlnNpDHjI7f0LJfBT01KzmQ91JPe+WijE=
X-Received: by 2002:a19:4b48:: with SMTP id y69mr2334660lfa.576.1606240070465;
 Tue, 24 Nov 2020 09:47:50 -0800 (PST)
MIME-Version: 1.0
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com> <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
 <878saq3ofx.fsf@oldenburg2.str.redhat.com> <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org>
 <20201124164546.GA14094@infradead.org> <CAG48ez2ZHPavVU3_2VnRADFQstOM1s+3GwfWsRaEjAA1jYcHDg@mail.gmail.com>
 <X70/uPNt2BA/vUSo@kroah.com> <CAG48ez2NH2Esw_55JiwK1FAzr_qFFyGaPrE_A=iH=dNuVvY6GQ@mail.gmail.com>
 <X71Gbko70D/jedAP@kroah.com>
In-Reply-To: <X71Gbko70D/jedAP@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 24 Nov 2020 18:47:24 +0100
Message-ID: <CAG48ez3fHajON65uuKNx7Q+52X=41-C7=mub=XVmBWSUtBtnpA@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions & workaround
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Mark Wielaard <mark@klomp.org>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        dev@opencontainers.org, Jonathan Corbet <corbet@lwn.net>,
        "Carlos O'Donell" <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 6:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 24, 2020 at 06:30:28PM +0100, Jann Horn wrote:
> > On Tue, Nov 24, 2020 at 6:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Nov 24, 2020 at 06:06:38PM +0100, Jann Horn wrote:
> > > > +seccomp maintainers/reviewers
> > > > [thread context is at
> > > > https://lore.kernel.org/linux-api/87lfer2c0b.fsf@oldenburg2.str.redhat.com/
> > > > ]
> > > >
> > > > On Tue, Nov 24, 2020 at 5:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > On Tue, Nov 24, 2020 at 03:08:05PM +0100, Mark Wielaard wrote:
> > > > > > For valgrind the issue is statx which we try to use before falling back
> > > > > > to stat64, fstatat or stat (depending on architecture, not all define
> > > > > > all of these). The problem with these fallbacks is that under some
> > > > > > containers (libseccomp versions) they might return EPERM instead of
> > > > > > ENOSYS. This causes really obscure errors that are really hard to
> > > > > > diagnose.
> > > > >
> > > > > So find a way to detect these completely broken container run times
> > > > > and refuse to run under them at all.  After all they've decided to
> > > > > deliberately break the syscall ABI.  (and yes, we gave the the rope
> > > > > to do that with seccomp :().
> > > >
> > > > FWIW, if the consensus is that seccomp filters that return -EPERM by
> > > > default are categorically wrong, I think it should be fairly easy to
> > > > add a check to the seccomp core that detects whether the installed
> > > > filter returns EPERM for some fixed unused syscall number and, if so,
> > > > prints a warning to dmesg or something along those lines...
> > >
> > > Why?  seccomp is saying "this syscall is not permitted", so -EPERM seems
> > > like the correct error to provide here.  It's not -ENOSYS as the syscall
> > > is present.
> > >
> > > As everyone knows, there are other ways to have -EPERM be returned from
> > > a syscall if you don't have the correct permissions to do something.
> > > Why is seccomp being singled out here?  It's doing the correct thing.
> >
> > AFAIU from what the others have said, it's being singled out because
> > it means that for two semantically equivalent operations (e.g.
> > openat() vs open()), one can fail while the other works because the
> > filter doesn't know about one of the syscalls. Normally semantically
> > equivalent syscalls are supposed to be subject to the same checks, and
> > if one of them fails, trying the other one won't help.
>
> They aren't being subject to the same checks, if the seccomp permissions
> are different for both of them, they will get different answers.
>
> Trying to use this to determine if the syscall is present or not is not
> ok, and as Christian just said, needs to be fixed in userspace.  We
> can't change the kernel ABI now, odds are someone else relies on the api
> we have had in place and it can not be changed :)

I don't think anyone was proposing changes to existing kernel API.
