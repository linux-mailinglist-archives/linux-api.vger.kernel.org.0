Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD4F0918
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 23:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfKEWK4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 17:10:56 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44099 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbfKEWK4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 17:10:56 -0500
Received: by mail-lf1-f67.google.com with SMTP id v4so16353909lfd.11
        for <linux-api@vger.kernel.org>; Tue, 05 Nov 2019 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oHNoa42wrptLOIF/3dlMMyJwxrj4Pwhbf1WPBq8o3uM=;
        b=txaxdUHAhhP9SDZaT+2LCWEybyxTXeBjbSvIEpNO3NUlCNP11+juSvK4NTapgDIQsx
         bx4UA6EMOgVRpvfj9Ytg3Dbq2TH/brOOWOMH+2KBx/B/IHrQbQAjLifbp0FSTSQsO2Bd
         NiuZC+eFppZJoQE3ZUPlpHN1pT+rO6Z14hJeshOd2hCFXwk4GR///Yx4GRVniJ3VKONO
         Kt+mJci6Da3WvnYbEe8gDOsTV7j/2J9XBqJqDkJ51fvbH5UQdmpyyfw/VvxEU/blzMIM
         MaPDes1kjsPOjqDH4nLH7vZE3u4nXKFUCYPNkeargYEdaXpUvyyeDnNhBld+YwzcgZEF
         lFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oHNoa42wrptLOIF/3dlMMyJwxrj4Pwhbf1WPBq8o3uM=;
        b=cxg/L0Sf2IwlVr2ZhFr3nAa/CgOVQm+CpWjdeJ1oVP0oiwy3wB1FIvbwCmtx+1CdsG
         tyHI785m2s21RxZw9PbAdttoB2NJehId1+ZS15Z6B9b8u0fJbiGjcQL5awnfMqBtDPGT
         fa1+wUWAaPoPppuOQpN/ZztrDL+N4m7hynxk3U/NgEudsma6WtftJ8g999DEIH33l+09
         3N7I/lPi5ms3gPiJ/Rotbvo0OSEqQ7NjNdclAShhI966+2UISR7eLwS3A2GRVT+o0udw
         /p1ib1YL5eQPNPtniSbgUriSHTyrWHnGPf1tR3+9u7vDCGGCp7mrfDhlZ4ozaofTg7a/
         TbBg==
X-Gm-Message-State: APjAAAVFszmeJo+exjmxYnWtrgDvuMbzCy2EF48wx8AzPQ7eZ+0YeI+S
        +2008xkEjKhwNwqM8GUT3cuWnIwAetxyzQiVMd9S6Q==
X-Google-Smtp-Source: APXvYqzbkj8YH9eITFZzXyrVd6DZFMTF5o/g/z0Eip1PKIKK6ASKx4h4gD3fA7MnFeAp5hmlIjHyjgVN7N9W0POhIHg=
X-Received: by 2002:ac2:5587:: with SMTP id v7mr135624lfg.79.1572991853663;
 Tue, 05 Nov 2019 14:10:53 -0800 (PST)
MIME-Version: 1.0
References: <CAKOZuet+fgaJR72YwYrHFdFVSOo6EWpcT8jUoh7se4cZb0V2aw@mail.gmail.com>
 <273986A1-A4BE-4FE5-B547-49CAA44C6FD3@amacapital.net>
In-Reply-To: <273986A1-A4BE-4FE5-B547-49CAA44C6FD3@amacapital.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 5 Nov 2019 14:10:16 -0800
Message-ID: <CAKOZuetCqQa_be_2Ek-zo58TA5nLKVFb4f01ahcACxiQ9Th80A@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for UFFD_FEATURE_EVENT_FORK
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 5, 2019 at 2:01 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Nov 5, 2019, at 9:02 AM, Daniel Colascione <dancol@google.com> wrote=
:
> >
> > =EF=BB=BFOn Tue, Nov 5, 2019 at 8:56 AM Andrea Arcangeli <aarcange@redh=
at.com> wrote:
> >>
> >>> On Tue, Nov 05, 2019 at 08:39:26AM -0800, Daniel Colascione wrote:
> >>> I'm not suggesting that we fail userfaultfd(2) without CAP_SYS_PTRACE=
.
> >>> That would, as you point out, break things. I'm talking about
> >>> recording *whether* we had CAP_SYS_PTRACE in an internal flag in the
> >>> uffd context when we create the thing --- and then, at ioctl time,
> >>> checking that flag, not the caller's CAP_SYS_PTRACE, to see whether
> >>> UFFD_FEATURE_EVENT_FORK should be made available. This way, the
> >>> security check hinges on whether the caller *at create time* was
> >>> privileged.
> >>
> >> Until now it wasn't clear to me you still wanted to do the permission
> >> check in UFFDIO_API time, and you only intended to move the
> >> "measurement" of the capability to the syscall.
> >>
> >> So you're suggesting to add more kernel complexity to code pending for
> >> removal to achieve a theoretically more pure solution in the band-aid
> >> required to defer the removal of the posix-breaking read
> >> implementation of the uffd fork feature?
> >
> > And you're suggesting making a security check work weirdly unlike most
> > other security checks because you hope it'll get removed one day?
> > Temporary solutions aren't, and if something goes into the kernel at
> > all, it's worth getting right. The general rule is that access checks
> > happen at open time. The kernel has already been bitten by UFFD
> > exempting itself from the normal rules (e.g., the
> > read(2)-makes-a-file-descriptor thing) in the name of expediency.
> > There shouldn't be any more exceptions.
>
> I don=E2=80=99t think ioctl() checking permission is particularly unusual=
. In principle, it=E2=80=99s better than open for a retrofit =E2=80=94 open=
 didn=E2=80=99t capture this permission in the past, so adding it makes an =
existing capability stronger than it was, which isn=E2=80=99t fantastic.

All right, let's do it the way the OP's patch does it then.
