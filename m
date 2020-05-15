Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1763C1D4CE4
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2020 13:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgEOLnF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 May 2020 07:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgEOLnE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 May 2020 07:43:04 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B607C061A0C;
        Fri, 15 May 2020 04:43:04 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g16so1973157eds.1;
        Fri, 15 May 2020 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=YrRjGioZ7zs8Asf2el6GNnClQSN4/9WcA4T9EDyJgyA=;
        b=rPmtrXXqRVCW97h+P3nclhrqz/ASpOaStgq7I5BSA3yCvviKNEv8M48baYPCJDxuxi
         TS/r0gIuSNuBLBhJ/kQm2beFU76eKpvR2oWUO1MPaDbnz/xU6d3lorRc//bu0Fl6o0sS
         uuRlWCGkwGZdkeN/JLAWXOvt9IYdcEvtX0u7KKxUjuK37MilANKXnjd9hwcPLJj26e5b
         2wO609//xeVZi6mwjr6sVnvJ27fSuPDbSDrM1vufjoI0Fh1OuTinU3S2qVe0f7NFPUZl
         EoHC7zKNCfdxdDdyteYzbVjYUk8v2qdQPQ8NeAIKoxecfsgIqDiGw+8MDFrYL4NcUCTM
         asug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=YrRjGioZ7zs8Asf2el6GNnClQSN4/9WcA4T9EDyJgyA=;
        b=UpWgplq57ik1C5/G/iOO/eaXQPY2OMJ7B82UiAAkM25Hwm+zxkK66xk8pVDUDK0kbI
         K3Qbyyw7Xz20o5Z+15ECarPFFOBsyItqy+Oh+mZ50/jHyYqoMq6po5v8aOh24y01t1ve
         vBO80gtLbnosC9Pts6ATTYcQJKUyrNXDmV0UeiCSzoej/64c4HPy4vuX3T/B3fg6Oo24
         xvECek4gdgrmgIcRYhY0Wbpn+Zmi+qSZsImxyPIoLcVAm8wPg4+0AUR068fEyPJF57LV
         X3eb7NUI34/uA+xfbQrefabp/htkE5KUFbCPKJViy7W76dp1LNXNXPqNIC415BEfcX/L
         09wA==
X-Gm-Message-State: AOAM532VdQ7hN+otdHQWz4kEDhFyJIWvZ1/vqc8Sf2WmI9NH2m+XaVaj
        Ci30Fq24X/xfvpgDG3Xh0Tb8Z16+W3jsQVMZbDQ=
X-Google-Smtp-Source: ABdhPJwcoJVIRsrHOSm9SEOFRuMMSD9KOplnbeLbxJOfYXEGdSUTAmQ3F55EDFGr6/Re1Ndtpe35QinGpRkY31Y+6As=
X-Received: by 2002:aa7:cb4f:: with SMTP id w15mr2334159edt.239.1589542982851;
 Fri, 15 May 2020 04:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191003145542.17490-1-cyphar@cyphar.com> <20191003145542.17490-2-cyphar@cyphar.com>
 <CAKgNAkiqU0TtmoZ8A89FT4zSYS7AcvWX6oc=1-45L95XbSkUog@mail.gmail.com> <20200417153740.37j2uxjcasyieuoa@yavin.dot.cyphar.com>
In-Reply-To: <20200417153740.37j2uxjcasyieuoa@yavin.dot.cyphar.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 15 May 2020 13:42:51 +0200
Message-ID: <CAKgNAkgF0M2hzSrw+_+iMkRyvkT6OgTeB5e1GeTATF8jwY248g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] symlink.7: document magic-links more completely
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Aleksa,

Did you have a chance to look into writing this patch?

Thanks,

Michael

On Fri, 17 Apr 2020 at 17:37, Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2020-04-17, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> > Hi Aleksa,
> >
> > Re our discussion of documentation to be added for magic symlinks,
> > there was the patch below, which got paused. I guess this just needs a
> > light refresh?
>
> Yes, this is the patch I was thinking of -- but since the whole "magic
> link mode" semantics weren't in the openat2() series that was merged,
> this would need a refresh. Also I feel that magic-links probably deserve
> a slightly longer explanation than I gave here.
>
> > Thanks,
> >
> > Michael
> >
> > On Thu, 3 Oct 2019 at 16:56, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > >
> > > Traditionally, magic-links have not been a well-understood topic in
> > > Linux. Given the new changes in their semantics (related to the link
> > > mode of trailing magic-links), it seems like a good opportunity to shine
> > > more light on magic-links and their semantics.
> > >
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > ---
> > >  man7/path_resolution.7 | 15 +++++++++++++++
> > >  man7/symlink.7         | 39 ++++++++++++++++++++++++++++++---------
> > >  2 files changed, 45 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
> > > index 07664ed8faec..46f25ec4cdfa 100644
> > > --- a/man7/path_resolution.7
> > > +++ b/man7/path_resolution.7
> > > @@ -136,6 +136,21 @@ we are just creating it.
> > >  The details on the treatment
> > >  of the final entry are described in the manual pages of the specific
> > >  system calls.
> > > +.PP
> > > +Since Linux 5.FOO, if the final entry is a "magic-link" (see
> > > +.BR symlink (7)),
> > > +and the user is attempting to
> > > +.BR open (2)
> > > +it, then there is an additional permission-related restriction applied to the
> > > +operation: the requested access mode must not exceed the "link mode" of the
> > > +magic-link (unlike ordinary symlinks, magic-links have their own file mode.)
> > > +For example, if
> > > +.I /proc/[pid]/fd/[num]
> > > +has a link mode of
> > > +.BR 0500 ,
> > > +unprivileged users are not permitted to
> > > +.BR open ()
> > > +the magic-link for writing.
> > >  .SS . and ..
> > >  By convention, every directory has the entries "." and "..",
> > >  which refer to the directory itself and to its parent directory,
> > > diff --git a/man7/symlink.7 b/man7/symlink.7
> > > index 9f5bddd5dc21..33f0ec703acd 100644
> > > --- a/man7/symlink.7
> > > +++ b/man7/symlink.7
> > > @@ -84,6 +84,25 @@ as they are implemented on Linux and other systems,
> > >  are outlined here.
> > >  It is important that site-local applications also conform to these rules,
> > >  so that the user interface can be as consistent as possible.
> > > +.SS Magic-links
> > > +There is a special class of symlink-like objects known as "magic-links" which
> > > +can be found in certain pseudo-filesystems such as
> > > +.BR proc (5)
> > > +(examples include
> > > +.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
> > > +Unlike normal symlinks, magic-links are not resolved through
> > > +pathname-expansion, but instead act as direct references to the kernel's own
> > > +representation of a file handle. As such, these magic-links allow users to
> > > +access files which cannot be referenced with normal paths (such as unlinked
> > > +files still referenced by a running program.)
> > > +.PP
> > > +Because they can bypass ordinary
> > > +.BR mount_namespaces (7)-based
> > > +restrictions, magic-links have been used as attack vectors in various exploits.
> > > +As such (since Linux 5.FOO), there are additional restrictions placed on the
> > > +re-opening of magic-links (see
> > > +.BR path_resolution (7)
> > > +for more details.)
> > >  .SS Symbolic link ownership, permissions, and timestamps
> > >  The owner and group of an existing symbolic link can be changed
> > >  using
> > > @@ -99,16 +118,18 @@ of a symbolic link can be changed using
> > >  or
> > >  .BR lutimes (3).
> > >  .PP
> > > -On Linux, the permissions of a symbolic link are not used
> > > -in any operations; the permissions are always
> > > -0777 (read, write, and execute for all user categories),
> > >  .\" Linux does not currently implement an lchmod(2).
> > > -and can't be changed.
> > > -(Note that there are some "magic" symbolic links in the
> > > -.I /proc
> > > -directory tree\(emfor example, the
> > > -.IR /proc/[pid]/fd/*
> > > -files\(emthat have different permissions.)
> > > +On Linux, the permissions of an ordinary symbolic link are not used in any
> > > +operations; the permissions are always 0777 (read, write, and execute for all
> > > +user categories), and can't be changed.
> > > +.PP
> > > +However, magic-links do not follow this rule. They can have a non-0777 mode,
> > > +which is used for permission checks when the final
> > > +component of an
> > > +.BR open (2)'s
> > > +path is a magic-link (see
> > > +.BR path_resolution (7).)
> > > +
> > >  .\"
> > >  .\" The
> > >  .\" 4.4BSD
> > > --
> > > 2.23.0
> > >
> >
> >
> > --
> > Michael Kerrisk
> > Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> > Linux/UNIX System Programming Training: http://man7.org/training/
>
>
> --
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
