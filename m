Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D99242669
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHLH4G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 03:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLH4G (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 03:56:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ACBC061787
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 00:56:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p24so1185657ejf.13
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 00:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDkDdVENPHITasYSBRU0u7LO8tRkihQ4z/zsle3BKDM=;
        b=FcyMnz82AtZrn2stC6Sl+f2PRHcZZoUGt3wuUZSk5ELWTNbgax4eDZ49GeMmHZunvH
         rljYXQFu7im4PZdzdO0lYZKHRM7iSUO5yQA6L76Zz9QFCkx/6qWH6uVaeCONVQcLz0dD
         0HklRpgXSl1s8dN6ptFu4M6YictVBFjo9XKNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDkDdVENPHITasYSBRU0u7LO8tRkihQ4z/zsle3BKDM=;
        b=s29JJkAkHUfthznoaTSiiNXNuaen9A+gBOLQLfVsKg6mSyxtGKuipkz2jK7546XNYe
         HjNxICQChUKjpslVjFnla6v3vbs7VmOrSKI4896O++TNpikw7a+hFyvIpoehZnzDgWUf
         kz9p+nO19W3ZV0jnrmWsxwSIxLdXirTU63A/x/e5LaqSJvaolgyWV1T9AFroLYc7q9E1
         YaEK8hGeisdAn408cIAqQoFzLiWZAKchwEzJu2EJXGbbJ9tlhLqqcgCZyqgBwimQPd9F
         bWJP1OtOIuVeLi+otkNif03cNshKQ1siUYtfhLtm/rfN4InbgqEh1Y1HiTMyY/0wsKfj
         /RUQ==
X-Gm-Message-State: AOAM532w3GwPXeSx0kLILJU8LDPBREN4sRHrpH6yZZ1FF376W3s3SUl+
        K5Z+jHOu6BWoafP0e1P4EYQsNUQ2p14yf9Y7+83h+w==
X-Google-Smtp-Source: ABdhPJyC+097Jzc9mCwLBoOsJSWaNWeNVwgxC3Mrnwc6PONsKYSspfchPT7cYNPuBGsdELhZl9Dw0VTmRZ5suKmEj3M=
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr29497913ejt.320.1597218964348;
 Wed, 12 Aug 2020 00:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
In-Reply-To: <52483.1597190733@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 09:55:53 +0200
Message-ID: <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 12, 2020 at 2:05 AM David Howells <dhowells@redhat.com> wrote:

> >   {
> >      int fd, attrfd;
> >
> >      fd = open(path, O_PATH);
> >      attrfd = openat(fd, name, O_ALT);
> >      close(fd);
> >      read(attrfd, value, size);
> >      close(attrfd);
> >   }
>
> Please don't go down this path.  You're proposing five syscalls - including
> creating two file descriptors - to do what fsinfo() does in one.

So what?  People argued against readfile() for exactly the opposite of
reasons, even though that's a lot less specialized than fsinfo().

Worried about performance?  Io-uring will allow you to do all those
five syscalls (or many more) with just one I/O submission.

Thanks,
Miklos
