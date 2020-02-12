Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048BF15ADC2
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 17:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLQzE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 11:55:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39718 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgBLQzE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 11:55:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id z2so2667160oih.6
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSkRhzJ0OgAeMcDZYCLOFCEGGgp2p5lC13LHYR1YgYQ=;
        b=ZIpMsy4qygjUeFX9wzK5ylo+se7CXBlKbUF6E5DO6YfLBLlgk0xfU1y+ioblr27Fxm
         XXRkd7e0QiBiV3hPCDz1YqWTFDcJe3Fgsk02FoO5u8ihRaB10mRZXKe8Oa75+g8N+t0U
         K2bfRy9ApAwR8kpZAdYe4JPB9Avx2l9v3UY6hANBGxx+DYJ7mGPe4pdbAGWsaRnnzFHv
         /ZDZS0IJQnbJhvBdCj487AMRSPTjkz5QPGPxaXmAGDK5fRgSdwZyklkRNsdY71SOBCR1
         EfooY1HX6JZQoaOc0VzGQeu5nEloIPJ9sE1dd0j/Z+YSPcbV1Ks5oKZpCCV/4ZuABw3B
         oZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSkRhzJ0OgAeMcDZYCLOFCEGGgp2p5lC13LHYR1YgYQ=;
        b=JJr7vclRzlhn9q/Nf2BbBajaxp8zOO9QM3t5O3jPoDXCtgUfAY6XvDjjRVuDD9RwVt
         4mDcmwHvE/tP30gFWrJfNmUXkSSglO7tIraixw9pV0HeD22C1+shO3SCtEg6m7RwkJlp
         kEUdI1rd5oQdFr1cnS7kNfYCASXToE05+4lRzK9cPkWFLZOip7hduRug9BblTsWsrgdx
         PWnGEXndIvb5ueKunLCvezMZKVmHm2jkeiSJNSw374DHldlmot253vGFbmdxiAGf78GX
         n2kAGu6XqnP/DNvZayxzAC+u9+bu0SNQaLyxWZgiQ2Q4SA7v0CdtXkEqKDc9M9W9BKUB
         mspg==
X-Gm-Message-State: APjAAAXeentqhLzcXMJSrs8qNoX9+R3HNhubC//Ipy1OZzRoZkYL/gHY
        ckNPRpvMCZ+nQFtqo80GRUUQlQ6AaG1wIeFEc7Qa5Q==
X-Google-Smtp-Source: APXvYqzoTbEk701bRg/VO9uviBn9wmpzEP3oEimUqZD0CHfaNloke8F7mwUkUM+o+ZiLPAwclceH3ziLpTr9nY7+ZCI=
X-Received: by 2002:aca:1913:: with SMTP id l19mr6487887oii.47.1581526503068;
 Wed, 12 Feb 2020 08:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <202002112332.BE71455@keescook>
In-Reply-To: <202002112332.BE71455@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 12 Feb 2020 17:54:35 +0100
Message-ID: <CAG48ez0ogRxvCK1aCnviN+nBqp6gmbUD7NjaMKvA7bF=esAc1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 12, 2020 at 8:51 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Feb 11, 2020 at 02:55:41PM -0800, Daniel Colascione wrote:
> >   Let userfaultfd opt out of handling kernel-mode faults
> >   Add a new sysctl for limiting userfaultfd to user mode faults
>
> Now this I'm very interested in. Can you go into more detail about two
> things:
[...]
> - Why is this needed in addition to the existing vm.unprivileged_userfaultfd
>   sysctl? (And should this maybe just be another setting for that
>   sysctl, like "2"?)
>
> As to the mechanics of the change, I'm not sure I like the idea of adding
> a UAPI flag for this. Why not just retain the permission check done at
> open() and if kernelmode faults aren't allowed, ignore them? This would
> require no changes to existing programs and gains the desired defense.
> (And, I think, the sysctl value could be bumped to "2" as that's a
> better default state -- does qemu actually need kernelmode traps?)

I think this might be necessary for I/O emulation? As in, if before
getting migrated, the guest writes some data into a buffer, then the
guest gets migrated, and then while the postcopy migration stuff is
still running, the guest tells QEMU to write that data from
guest-physical memory to disk or whatever; I think in that case, QEMU
will do something like a pwrite() syscall where the userspace pointer
points into the memory area containing guest-physical memory, which
would return -EFAULT if userfaultfd was restricted to userspace
accesses.

This was described in this old presentation about why userfaultfd is
better than a SIGSEGV handler:
https://drive.google.com/file/d/0BzyAwvVlQckeSzlCSDFmRHVybzQ/view
(slide 6) (recording at https://youtu.be/pC8cWWRVSPw?t=463)
