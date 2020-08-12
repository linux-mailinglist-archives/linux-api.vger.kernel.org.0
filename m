Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA02426D4
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHLIhW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHLIhV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 04:37:21 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA6C06178A
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 01:37:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f24so1338565ejx.6
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5lKpdbRMPYHAYu1ae51I164qapzjNwIVzhn7ZJhmbg=;
        b=AcC/qQQCnxrUQDrRulzph4bIrPpKQ4hbVAqb0dQpE0YjsJg0S4AcKPqmLXQnYuZ8gQ
         9rMS2fX/xoMespxJ1EdabWK4zL1o2n2eaJ+IDZKcNAadf3DO9VvJI4IyDPUvT+oct/lD
         KK1tAvYAp2gilfvh3FiKoGKiqOV2rTwVpP3Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5lKpdbRMPYHAYu1ae51I164qapzjNwIVzhn7ZJhmbg=;
        b=WIQ7v1XNZuwCRtWP+0ZDA3CB3yqTFusTLb6ioky1G4Dhqb7+6P+ISUiHZvzbjNQIUP
         yYXbBvkpzRGEEoWc/4qQw9+NTFEv/b+juUdzFRiPB08mn9j1TEe+KcvC5jgyxxAxDBE3
         5UeY1Xj/Fog+taEcPueDYX9nc5ShTWUqh20WZfHaQEN80Ic9+1UOBBqFFbR77rE3QcZI
         k8hCR3PmgHhTLw/hl4X3DjcgSveHC5tjyULpHVnLI1gJf8h2VTv9gZ8I0WgPMLuXqvA1
         ZmV14Lb5p3oxrD6SRSSvphkNyQYoRZ8Uz+q9InmBaVNF5qOIto89itnNObPLupV8To3G
         b0Rw==
X-Gm-Message-State: AOAM530mfpk3pTOTkemS6ewgv9GGYCBF9bZjcC1g9nEQpKvAf22XK19E
        1u9j8xxA10qe5939faMK++LtKo3SsxpXfuSpMcC7lg==
X-Google-Smtp-Source: ABdhPJzWseLvjIX9yMZK1gWPtlrnfWCFKz8bLBOi+m92pGbohAATJNi/NlUhIAcvWT8riat4xaFeXZBq0E4EMOYrDOI=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr29546689ejb.113.1597221439198;
 Wed, 12 Aug 2020 01:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
 <98802.1597220949@warthog.procyon.org.uk>
In-Reply-To: <98802.1597220949@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 10:37:08 +0200
Message-ID: <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
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

On Wed, Aug 12, 2020 at 10:29 AM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Worried about performance?  Io-uring will allow you to do all those
> > five syscalls (or many more) with just one I/O submission.
>
> io_uring isn't going to help here.  We're talking about synchronous reads.
> AIUI, you're adding a couple more syscalls to the list and running stuff in a
> side thread to save the effort of going in and out of the kernel five times.
> But you still have to pay the set up/tear down costs on the fds and do the
> pathwalks.  io_uring doesn't magically make that cost disappear.
>
> io_uring also requires resources such as a kernel accessible ring buffer to
> make it work.
>
> You're proposing making everything else more messy just to avoid a dedicated
> syscall.  Could you please set out your reasoning for that?

a) A dedicated syscall with a complex binary API is a non-trivial
maintenance burden.

b) The awarded performance boost is not warranted for the use cases it
is designed for.

Thanks,
Miklos
