Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B465B1B04FA
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2020 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgDTI66 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Apr 2020 04:58:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22086 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725865AbgDTI65 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Apr 2020 04:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587373136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bz93CG5tgmLS8pJDkO23pSfLYauBKXmOP1VWfhP+LYw=;
        b=OrufBDf1LE3Sy6hoKKEVmzHKULpIr/NeI7y3cbgNmnQiJ28Z0q7gLYFJ+2n2FcYnGjfffX
        mJaAInWkphslSxbvQr6mn3sDjBm3J4FsslSTBAd2Ylur3AIRajol9yX/fZP56sHN+4L3hT
        ZBa4sfB+eXWb4SpTtPVlS4ow1lGyTDQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-9fVUA0B6PT-J6UnBiHnD4Q-1; Mon, 20 Apr 2020 04:58:52 -0400
X-MC-Unique: 9fVUA0B6PT-J6UnBiHnD4Q-1
Received: by mail-qv1-f71.google.com with SMTP id e3so5381892qvs.16
        for <linux-api@vger.kernel.org>; Mon, 20 Apr 2020 01:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bz93CG5tgmLS8pJDkO23pSfLYauBKXmOP1VWfhP+LYw=;
        b=AGdGp8zI2FZtbkmYtWXu40YsJNNqp24QzzpsDeRiWOx7/BElcKdzdDh/mQgQ/Dp0Ub
         V4fGGXgHCgWdnCJOPVlim+xC41vKaX/VhSAP4W1usGEE7UfvDmAWaoqYq3JKo/2/1KHs
         CU3IYPLLVO8VYU6DuQbKjS6RRjcgZbtJ7WbgbgShvD4RsMh2w1R+1BYVHDl+4vrb95p8
         LVqG+3DDVgTJUVpD89+85pYxGVFaVMasF/qug1qyVFCrbxULsOFIyLE0h02JNod0CMon
         z2mHr63o24omxY8JQCF47LsrzIjzq7+cBIlg3EbWEP1Ts1yIRJIRRBlnj9PMEGcCMSwe
         FR3g==
X-Gm-Message-State: AGi0PuYiLlwBwB4pbh9afTh+G0cictMRR5sDHA4iX74Zj71MAnsKa6+5
        VixNmqFxdKPa/WiuPM9YkkzKObQIs+y1wHj8uSgvfWnubfVPPnMYNGnRiTxzEzvDz3oJ+cw34JC
        MRw3ylCMifHM0g+EXpO6OcyTH8d8dCj3RO3Mf
X-Received: by 2002:ae9:ed92:: with SMTP id c140mr8007657qkg.29.1587373131729;
        Mon, 20 Apr 2020 01:58:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypIjRvIlDDg57MantknXiQ5Jwc+acww2bCZ5DeZC+XsS6aRa5FxXy575F8K7vkHScc9X0dsku5X4PlBNJJp3zz0=
X-Received: by 2002:ae9:ed92:: with SMTP id c140mr8007648qkg.29.1587373131491;
 Mon, 20 Apr 2020 01:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200416143532.11743-1-mszeredi@redhat.com> <c47459a5-3323-121e-ec66-4a8eb2a8afca@samba.org>
 <CAOssrKe7RNyReAFLoQGBDm79qMdXEubhP5QhG_+UmGZXgeXBkA@mail.gmail.com> <3dce8811-a54e-1f74-c7ed-715b97a4652c@samba.org>
In-Reply-To: <3dce8811-a54e-1f74-c7ed-715b97a4652c@samba.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 20 Apr 2020 10:58:40 +0200
Message-ID: <CAOssrKcVddL5URQ0Vy79eQOscqTTK115Ro0Eqe8Q9kdkNJspCg@mail.gmail.com>
Subject: Re: [PATCH] vfs: add faccessat2 syscall
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Apr 18, 2020 at 10:23 PM Stefan Metzmacher <metze@samba.org> wrote:
>
> Am 18.04.20 um 21:00 schrieb Miklos Szeredi:
> > On Sat, Apr 18, 2020 at 8:36 PM Stefan Metzmacher <metze@samba.org> wrote:
> >>
> >> Hi Miklos,
> >>
> >>> POSIX defines faccessat() as having a fourth "flags" argument, while the
> >>> linux syscall doesn't have it.  Glibc tries to emulate AT_EACCESS and
> >>> AT_SYMLINK_NOFOLLOW, but AT_EACCESS emulation is broken.
> >>>
> >>> Add a new faccessat(2) syscall with the added flags argument and implement
> >>> both flags.
> >>>
> >>> The value of AT_EACCESS is defined in glibc headers to be the same as
> >>> AT_REMOVEDIR.  Use this value for the kernel interface as well, together
> >>> with the explanatory comment.
> >>
> >> It would be nice if resolv_flags would also be passed in addition to the
> >> at flags.
> >> See:https://lore.kernel.org/linux-api/CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com/
> >>
> >> We should avoid expecting yet another syscall in near future.
> >
> > What is the objection against
> >
> > openat(... O_PATH)
> > foobarat(fd, AT_EMPTY_PATH, ...)
>
> openat2(), foobarat(), close() are 3 syscalls vs. just one.

That's not a good argument.  We could have a million specialized
syscalls that all do very useful things.  Except it would be a
nightmare in terms of maintenance...

"do one thing and do it well"

> As we have the new features available, I think it would be
> good to expose them to userspace for all new syscalls, so
> that applications can avoid boiler plate stuff around each syscall
> and get better performance in a world where context switches are not for
> free.

The io-uring guys are working on that problem, AFAIK.

Thanks,
Miklos

