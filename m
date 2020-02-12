Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D71C15AE7D
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 18:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBLRMk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 12:12:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42127 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBLRMk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 12:12:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so3193843ljl.9
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 09:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwo0z8hfwKW8dm+jdLGk+O1WJMW5uNc4qUsCsEIwvs8=;
        b=gE65b1Yd2Wh6XHXYwmu/c9CKJBy+Ws32WYuWa+/niiYwv8vUvoGbn1U37V3MujwSqy
         mH+LjaP+x63KnU2IbSBcx8+NiAhxkIQYwSc8YwMdNZLpq2it5+AVaw9VQGuEGa6UKPPR
         ezBIYI+6LJbYJUiMRnQ5MJxVYYEcgW/zXz6a3CWi8S7SRAgi+6ng4JmXmX7lGdw8HjWJ
         +zOP9rYdIq7UX6OAiXjWLvpRY3XkufloC3t4AETi/Qz/xZqs8etfWTN3NUQouNaSrJf4
         hFVn/JQ3eZHNsyf2nxuubKcJJZoA8fd1gQuPK3UYtvvWzHubUwxJ5Sv8UNwMwUmeooV5
         MxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwo0z8hfwKW8dm+jdLGk+O1WJMW5uNc4qUsCsEIwvs8=;
        b=txH/i8kP5TBkROsLuBz4HDjOeEsXpdtptz5YoKQOujtDizUnChmWCgVINntRj1K+O9
         OYQ7aTm6rPdu7wB259smyXI+NpXm2HmRgCMlWn9Gzol/aHZuOCEMG1zBG1gJ7aJNprYq
         H60sivD+VdTio8iHijz5G7WDCz/0rLo11TmvraOXDXwwelRsc/3+hHqk1YsYofUjMwFc
         Di5C059Z00I9laX8ASAUvFuaSBma/h9X5d2rxmQtqiWimll2fIGtsbsXFwrXYCdGp3YH
         Wr3xPutb2bkOL1hSaI5hoAYECoF0Xs/KxZxiuJ8UT3uXdPrrB4Hl6kdLNGeaalb1t5rP
         2RtA==
X-Gm-Message-State: APjAAAUenGiheSbQ/HE9JwbE03SQeZd7KDJstX9ZRB30410axF5MbCA/
        hEBlH42hnb31rourOGRgA6NouZTa3R1MLhxnxgqJIQ==
X-Google-Smtp-Source: APXvYqzY9e3KLachS/myU+/0mcUI2neod0a7EVtvHqf8eiEdgn1uuyZlXOPUph4HCp5xA57zsmk6uApwpSXMfGrV/WE=
X-Received: by 2002:a2e:9157:: with SMTP id q23mr8345506ljg.196.1581527556981;
 Wed, 12 Feb 2020 09:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <202002112332.BE71455@keescook>
In-Reply-To: <202002112332.BE71455@keescook>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 12 Feb 2020 09:12:00 -0800
Message-ID: <CAKOZuesS1_O0OuePwSN2Kc4b-vyokiV=MvBd4nDi=umBKM6v6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
To:     Kees Cook <keescook@chromium.org>
Cc:     Tim Murray <timmurray@google.com>, Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, selinux@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks for taking a look and for the fast reply!

On Tue, Feb 11, 2020 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hi!
>
> Firstly, thanks for working on this! It's been on my TODO list for a
> while. :)
>
> Casey already recommended including the LSM list to CC (since this is a
> new LSM -- there are many LSMs). Additionally, the series should
> probably be sent _to_ the userfaultfd maintainers:
>         Andrea Arcangeli <aarcange@redhat.com>
>         Mike Rapoport <rppt@linux.ibm.com>
> and I'd also CC a couple other people that have done recent work:
>         Peter Xu <peterx@redhat.com>
>         Jann Horn <jannh@google.com>
>
> More notes below...

In general, in the event that a patch series doesn't include all
needed parties on the to-line, what's the right way to fix the
situation without spamming everyone and forking the thread? In this
case, since I'm splitting the patch series anyway, I can just expand
the to-line in the reroll.

> On Tue, Feb 11, 2020 at 02:55:41PM -0800, Daniel Colascione wrote:
> > Userfaultfd in unprivileged contexts could be potentially very
> > useful. We'd like to harden userfaultfd to make such unprivileged use
> > less risky. This patch series allows SELinux to manage userfaultfd
> > file descriptors and allows administrators to limit userfaultfd to
> > servicing user-mode faults, increasing the difficulty of using
> > userfaultfd in exploit chains invoking delaying kernel faults.
>
> I actually think these are two very different goals and likely the
> series could be split into two for them. One is LSM hooking of
> userfaultfd and the SELinux attachment, and the other is the user-mode
> fault restrictions. And they would likely go via separate trees (LSM
> through James's LSM tree, and probably akpm's -mm tree for the sysctl).
>
> > A new anon_inodes interface allows callers to opt into SELinux
> > management of anonymous file objects. In this mode, anon_inodes
> > creates new ephemeral inodes for anonymous file objects instead of
> > reusing a singleton dummy inode. A new LSM hook gives security modules
> > an opportunity to configure and veto these ephemeral inodes.
> >
> > Existing anon_inodes users must opt into the new functionality.
> >
> > Daniel Colascione (6):
> >   Add a new flags-accepting interface for anonymous inodes
> >   Add a concept of a "secure" anonymous file
> >   Teach SELinux about a new userfaultfd class
> >   Wire UFFD up to SELinux
>
> The above is the first "series"... I don't have much opinion about it,
> though I do like the idea of making userfaultfd visible to the LSM.

Yeah. The interesting part there is the anon_inodes API change. I'll
split that half of the series out.

> >   Let userfaultfd opt out of handling kernel-mode faults
> >   Add a new sysctl for limiting userfaultfd to user mode faults
>
> Now this I'm very interested in. Can you go into more detail about two
> things:
>
> - What is the threat being solved? (I understand the threat, but detailing
>   it in the commit log is important for people who don't know it. Existing
>   commit cefdca0a86be517bc390fc4541e3674b8e7803b0 gets into some of the
>   details already, but I'd like to see reference to external sources like
>   https://duasynt.com/blog/linux-kernel-heap-spray)

Sure. I can add a reference to that and a more general discussion of
how delaying kernel fault handling can broaden race windows for other
exploits.

> - Why is this needed in addition to the existing vm.unprivileged_userfaultfd
>   sysctl? (And should this maybe just be another setting for that
>   sysctl, like "2"?)

We want to use UFFD for a new garbage collector in Android, and we
want unprivileged processes to be able to use this new garbage
collector. Giving them CAP_SYS_PTRACE is dangerous.

> As to the mechanics of the change, I'm not sure I like the idea of adding
> a UAPI flag for this. Why not just retain the permission check done at
> open() and if kernelmode faults aren't allowed, ignore them? This would
> require no changes to existing programs and gains the desired defense.

As Jann mentions below, it's a matter of the kernel's contractual
obligation to userspace. Right now, userfaultfd(2) either succeeds or
it fails with one of the enumerated error codes. You're proposing
having the userfaultfd(2) succeed but return a file descriptor that
doesn't do the job the kernel promised it would do. If we were to
adopt your proposal, an application would see UFFD succeed, then see
unexpeced EFAULTs from system calls, which would probably cause the
application to malfunctioning in exciting ways. An explicit "sorry, I
can't do that" error code is better: an application that gets an error
code from userfaultfd(2) can fall back to something else, but an
application that silently gets an underfeatured UFFD doesn't know
anything is wrong until it's too late. The additional flag preserves
the UFFD contract and gives applications a way to probe for feature
support.

> (And, I think, the sysctl value could be bumped to "2" as that's a
> better default state -- does qemu actually need kernelmode traps?)

I prefer a default of one for regular systems because I don't want to
make experimentation with novel ways to use UFFD more difficult, and a
default of two would require users go out of their way to handle user
faults, and few will. For a more constrained system like Android, two
is fine.
