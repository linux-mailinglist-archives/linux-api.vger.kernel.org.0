Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185BF34F25B
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 22:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhC3Ums convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 30 Mar 2021 16:42:48 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:44596 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhC3Umg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Mar 2021 16:42:36 -0400
Received: by mail-ej1-f50.google.com with SMTP id e14so26738962ejz.11;
        Tue, 30 Mar 2021 13:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6y0w4epdy1zgw6lkitkraNKrAbYioLiFpd2DfbWTyl8=;
        b=Inb7zticwx0eIkksP/PyxErSyQ+GvY8gPMbfEefPME5MCgrUj/Zos8ahk71jMy/3FQ
         NoKAumj/zxrS/7RWcZg+UMcqZkNmmngXkzGzoradW4f0fX8hlUReS7T+fVaZ9K4ZsDV7
         wCyKWzek4v5bADCoFma5qKpcnOnas35ifmZPW+eagJjZOPnP158nRJA2so3QAmmg5IPg
         0PChIQ2bnWVmTtRDExtaOC5KXzcPqA9gUDK0qBLrlSefo+QqZJdgS0rX1f6B7t70RsWX
         dxhQWZEHCHIdfvGg2vl+3qjr5LU9VODlOy/OfJUB7dBR6n5XApFUEJQ+FpS0KhKM1WoQ
         FE5A==
X-Gm-Message-State: AOAM532KRgr4pJS4Z9zqnrixeNIRkFIY8ErRiBoBRkYKSrrlqgPVjfml
        BHgyh5U81rRPdtEYQAkeBO37qadQLgX9S5gNFTQ=
X-Google-Smtp-Source: ABdhPJyrA2haUymQO29Ez3sUhVUwRRFyYvafzbD5Smm8CpiSI7WxlTg1TiYD2c/PTh+vB6yqvyj441BjJtKgKmzV2eU=
X-Received: by 2002:a17:907:ea3:: with SMTP id ho35mr35338549ejc.219.1617136955046;
 Tue, 30 Mar 2021 13:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <d10affcb-d315-cebc-4162-084f0a1e4d43@intel.com> <F2653B18-239A-42BB-84EE-04F18B712279@amacapital.net>
In-Reply-To: <F2653B18-239A-42BB-84EE-04F18B712279@amacapital.net>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 30 Mar 2021 16:42:23 -0400
Message-ID: <CAJvTdKnwexRpHrLFQv+2ykK9WEqtXMwehjfa_D7T+O_8DO_CGA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 30, 2021 at 4:20 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > On Mar 30, 2021, at 12:12 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > ﻿On 3/30/21 10:56 AM, Len Brown wrote:
> >> On Tue, Mar 30, 2021 at 1:06 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >>>> On Mar 30, 2021, at 10:01 AM, Len Brown <lenb@kernel.org> wrote:
> >>>> Is it required (by the "ABI") that a user program has everything
> >>>> on the stack for user-space XSAVE/XRESTOR to get back
> >>>> to the state of the program just before receiving the signal?
> >>> The current Linux signal frame format has XSTATE in uncompacted format,
> >>> so everything has to be there.
> >>> Maybe we could have an opt in new signal frame format, but the details would need to be worked out.
> >>>
> >>> It is certainly the case that a signal should be able to be delivered, run “async-signal-safe” code,
> >>> and return, without corrupting register contents.
> >> And so an an acknowledgement:
> >>
> >> We can't change the legacy signal stack format without breaking
> >> existing programs.  The legacy is uncompressed XSTATE.  It is a
> >> complete set of architectural state -- everything necessary to
> >> XRESTOR.  Further, the sigreturn flow allows the signal handler to
> >> *change* any of that state, so that it becomes active upon return from
> >> signal.
> >
> > One nit with this: XRSTOR itself can work with the compacted format or
> > uncompacted format.  Unlike the XSAVE/XSAVEC side where compaction is
> > explicit from the instruction itself, XRSTOR changes its behavior by
> > reading XCOMP_BV.  There's no XRSTORC.
> >
> > The issue with using the compacted format is when legacy software in the
> > signal handler needs to go access the state.  *That* is what can't
> > handle a change in the XSAVE buffer format (either optimized/XSAVEOPT,
> > or compacted/XSAVEC).
>
> The compacted format isn’t compact enough anyway. If we want to keep AMX and AVX512 enabled in XCR0 then we need to further muck with the format to omit the not-in-use features. I *think* we can pull this off in a way that still does the right thing wrt XRSTOR.

Agreed.  Compacted format doesn't save any space when INIT=0, so it is
only a half-step forward.

> If we go this route, I think we want a way for sigreturn to understand a pointer to the state instead of inline state to allow programs to change the state.  Or maybe just to have a way to ask sigreturn to skip the restore entirely.

The legacy approach puts all architectural state on the signal stack
in XSTATE format.

If we make the signal stack smaller with a new fast-signal scheme, we
need to find another place for that state to live.

It can't live in the task context switch buffer.  If we put it there
and then take an interrupt while running the signal handler, then we'd
overwrite the signaled thread's state with the signal handler's state.

Can we leave it in live registers?  That would be the speed-of-light
signal handler approach.  But we'd need to teach the signal handler to
not clobber it.  Perhaps that could be part of the contract that a
fast signal handler signs?  INIT=0 AMX state could simply sit
patiently in the AMX registers for the duration of the signal handler.
You can't get any faster than doing nothing :-)

Of course part of the contract for the fast signal handler is that it
knows that it can't possibly use XRESTOR of the stuff on the stack to
necessarily get back to the state of the signaled thread (assuming we
even used XSTATE format on the fast signal handler stack, it would
forget the contents of the AMX registers, in this example)

Len Brown, Intel Open Source Technology Center
