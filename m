Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8C1B56C5
	for <lists+linux-api@lfdr.de>; Thu, 23 Apr 2020 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgDWH5b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Apr 2020 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgDWH5b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Apr 2020 03:57:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FD1C08E934
        for <linux-api@vger.kernel.org>; Thu, 23 Apr 2020 00:57:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id pg17so3992614ejb.9
        for <linux-api@vger.kernel.org>; Thu, 23 Apr 2020 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AZ3LfYwwbdgd8+Gj6pfmGUhFDqMfSzSNioVUGjPTRU=;
        b=VBDSp624eeG5DG/gndTNaHMLvSdjtkZwVvqIk0HLfICAWTd3DdqJGCOdF+j3ZkiaF6
         OkJMkZajYDgkASdTcGVDQrKBArkOd3uXBgFTNPbyeCHS2d5P8A4O/ddQo/nRm1J/P6HS
         8YiyHoRzIG8e5maMV6UFDTwGB3oaF3TD+HG1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AZ3LfYwwbdgd8+Gj6pfmGUhFDqMfSzSNioVUGjPTRU=;
        b=XCHodHO6EI/8csMn7e/iT2+uBp6UBKgHQvIC0xtxavUSC7Wt+Pc/AzoDNSvHXeVGfJ
         +03GITycwSS+JMFQyoJiUGBAPc2ikLtwPV8yNBgJLZzpEVKZpFaHSZ2LbNbLJaMvXgTP
         7Q/Mn1avHAqtheyKwBpzgnOBuOpQWEA2gS5N3+u33eBNrLOMyn7UOmOTqLmDNbG3kAM+
         /u5SQj98GXDKxN3asxs0dAruwiiGakcFzxelhW4Irm1FtoBH2XizcbnKFF/LWx+7kqfR
         n4DcOyCq0fXrW2WKoCj3tBKhKy3QY1Z8ZSKxaEaz8tUOZsTXfaypDgKTmUi63VkOSB9p
         xfRQ==
X-Gm-Message-State: AGi0PuZRFdWcgXIqGRomOEsWydjnBs4H15f/DUBdvi2z46TnsOz6wO2t
        VvDqN5+7Frr6ty5PnsAgU9PaIgePgLzn+8is8z1XcQ==
X-Google-Smtp-Source: APiQypL8rnmcwmDcw0tzT8pkej1MVZvhOLUD9Stz7ZrjoCE/HfT+UO7lMR79fX8pKJtq7nSgVTmdAXP4XeG1L6cdh0M=
X-Received: by 2002:a17:906:340a:: with SMTP id c10mr1706242ejb.218.1587628649150;
 Thu, 23 Apr 2020 00:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587531463.git.josh@joshtriplett.org> <9873b8bd7d14ff8cd2a5782b434b39f076679eeb.1587531463.git.josh@joshtriplett.org>
 <CAKgNAkjo3AeA78XqK-RRGqJHNy1H8SbcjQQQs7+jDwuFgq4YSg@mail.gmail.com>
 <CAJfpegt=xe-8AayW2i3AYrk3q-=Pp_A+Hctsk+=sXoMed5hFQA@mail.gmail.com>
 <20200423004807.GC161058@localhost> <CAJfpegtSYKsApx2Dc6VGmc5Fm4SsxtAWAP-Zs052umwK1CjJmQ@mail.gmail.com>
 <20200423044226.GH161058@localhost> <CAJfpeguaVYo-Lf-5Bi=EYJYWdmCfo3BqZA=kj9E5UmDb0mBc1w@mail.gmail.com>
 <20200423073310.GA169998@localhost> <CAJfpegtXj4bSbhpx+=z=R0_ZT8uPEJAAev0O+DVg3AX242e=-g@mail.gmail.com>
In-Reply-To: <CAJfpegtXj4bSbhpx+=z=R0_ZT8uPEJAAev0O+DVg3AX242e=-g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 23 Apr 2020 09:57:17 +0200
Message-ID: <CAJfpegtgrUACZpYR8wWoTE=Hh4Xi+4rRfrZTxRtaFVpT9GMPjw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>, io-uring@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 23, 2020 at 9:45 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> > I would prefer to not introduce that limitation in the first place, and
> > instead open normal file descriptors.
> >
> > > The point of O_SPECIFIC_FD is to be able to perform short
> > > sequences of open/dosomething/close without having to block and having
> > > to issue separate syscalls.
> >
> > "close" is not a required component. It's entirely possible to use
> > io_uring to open a file descriptor, do various things with it, and then
> > leave it open for subsequent usage via either other io_uring chains or
> > standalone syscalls.
>
> If this use case arraises, we could add an op to dup/move a private
> descriptor to a public one.  io_uring can return values, right?
>
> Still not convinced...

Oh, and we haven't even touched on the biggest advantage of a private
fd table: not having to dirty a cacheline on fdget/fdput due to the
possibility of concurrent close() in a MT application.

I believe this is a sticking point in some big enterprise apps and it
may even be a driving force for io_uring.

Thanks,
Miklos
