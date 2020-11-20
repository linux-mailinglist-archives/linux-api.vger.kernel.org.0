Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9172BBA45
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 00:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgKTXlw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 18:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgKTXlv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 18:41:51 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1F5C061A04
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 15:41:51 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so15836145lfc.4
        for <linux-api@vger.kernel.org>; Fri, 20 Nov 2020 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4X3JgQ4RPxBwwWZDZkMawYKrU5kawZa5XwbccIiOlk=;
        b=fMuLwYClEdAadSzvWYkAP/jvTOpXw94bICx+OYCMzy7UTAGgcDRlygMInZIvEujlw2
         uv/jO22fk/2x23A21TbxXR1lpeCzfruKMg85wcwQ6Qps+47ypl8fig1EFQmgGwtYA1L2
         uFH2B+LfY62r2owvWlp4TX4A8YRTjV1T1jAQlHi36TDv+g7lAqFShqGtXVDHGFCeFrud
         ROTeIeG3xeXCnH/MOpYzlke00TgmBgw5yO4Z4b09PaOUnHEN2CltBfLjwTkDzUfprYE2
         SKB2jeQU834H6D73e8chfxDtpG5JszY4A0+lx6Gmh5QHYL9Y6H//Z0Sg4pMDSC5JHtP7
         RTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4X3JgQ4RPxBwwWZDZkMawYKrU5kawZa5XwbccIiOlk=;
        b=XrgPH5XqXCf7jsHoh362BYQAC6F6uwjGF66lpqzrzTkl43pk8k1P6DFOb6NERsjR/J
         obe2FbycmUzFePCqj3Rjlnas2Vvb2EOUScABRWAeYdmB0svxBfziU1a7Fi44az6VA0GG
         8bI8r7QhAJHcg4qw+kR/hfIsGH73aXO3RDUIDdPYF8ACHwkn9ZOHtEo4Wi5iu5ZLvA30
         XG67G3F6efAy6Wlpu+ni0Bv6Sj+TiXTJ8qqKk865YEwTmc9mKje02hQGyTfOHZqVoVTm
         wxA+sIEU6QAf+K18co397IHzjmrTwXuovGvgi3ZejxwMYsgINcvLsuh8eFOXspD9z9J5
         eYcA==
X-Gm-Message-State: AOAM531Xw255D6y5NPjUj9F05dgyEqDyvaGWsidEcn1KlwcJoEJniNvz
        OOdtGprMmHTfJ42QUxBMqxsxSVTOPEYYtJ26CRf3zw==
X-Google-Smtp-Source: ABdhPJwXPfmuHQziNQZcT5u300NF6Dhifvv4PZmdrQW14N8dBch+LNWZZeOwlsVTr0m1EgqrXrKk6uAQNaZdAB5bLdU=
X-Received: by 2002:a19:4b45:: with SMTP id y66mr8447196lfa.482.1605915709537;
 Fri, 20 Nov 2020 15:41:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605723568.git.osandov@fb.com> <977fd16687d8b0474fd9c442f79c23f53783e403.1605723568.git.osandov@fb.com>
 <CAOQ4uxiaWAT6kOkxgMgeYEcOBMsc=HtmSwssMXg0Nn=rbkZRGA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiaWAT6kOkxgMgeYEcOBMsc=HtmSwssMXg0Nn=rbkZRGA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 00:41:23 +0100
Message-ID: <CAG48ez3rLFOWpaQcJxEE7BNXvxHvUQnvhhY-xyR2bZfhnmwQrg@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] fs: add O_ALLOW_ENCODED open flag
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 19, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Nov 18, 2020 at 9:18 PM Omar Sandoval <osandov@osandov.com> wrote:
> > The upcoming RWF_ENCODED operation introduces some security concerns:
> >
> > 1. Compressed writes will pass arbitrary data to decompression
> >    algorithms in the kernel.
> > 2. Compressed reads can leak truncated/hole punched data.
> >
> > Therefore, we need to require privilege for RWF_ENCODED. It's not
> > possible to do the permissions checks at the time of the read or write
> > because, e.g., io_uring submits IO from a worker thread. So, add an open
> > flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> > fcntl(). The flag is not cleared in any way on fork or exec. It must be
> > combined with O_CLOEXEC when opening to avoid accidental leaks (if
> > needed, it may be set without O_CLOEXEC by using fnctl()).
> >
> > Note that the usual issue that unknown open flags are ignored doesn't
> > really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> > O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
[...]
> > diff --git a/fs/open.c b/fs/open.c
> > index 9af548fb841b..f2863aaf78e7 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1040,6 +1040,13 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> >                 acc_mode = 0;
> >         }
> >
> > +       /*
> > +        * O_ALLOW_ENCODED must be combined with O_CLOEXEC to avoid accidentally
> > +        * leaking encoded I/O privileges.
> > +        */
> > +       if ((how->flags & (O_ALLOW_ENCODED | O_CLOEXEC)) == O_ALLOW_ENCODED)
> > +               return -EINVAL;
> > +
>
>
> dup() can also result in accidental leak.
> We could fail dup() of fd without O_CLOEXEC. Should we?
>
> If we should than what error code should it be? We could return EPERM,
> but since we do allow to clear O_CLOEXEC or set O_ALLOW_ENCODED
> after open, EPERM seems a tad harsh.
> EINVAL seems inappropriate because the error has nothing to do with
> input args of dup() and EBADF would also be confusing.

This seems very arbitrary to me. Sure, leaking these file descriptors
wouldn't be great, but there are plenty of other types of file
descriptors that are probably more sensitive. (Writable file
descriptors to databases, to important configuration files, to
io_uring instances, and so on.) So I don't see why this specific
feature should impose such special rules on it.
