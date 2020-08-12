Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61498242B96
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLOqe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHLOqd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 10:46:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B6C061385
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 07:46:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so2531354ejb.11
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CevgO8y+bID+0RAL78i6xuCLe1DAtuhsuxp9oVmqPQU=;
        b=VAqCelzNyjnT6iNu6JL0OmE0MRSdkKZhVA4vV7FxA77mfestyhafmSBAI3sD50miSZ
         J5esPSbvoNSwivwgD7HrxmmozNQhTCw6laCyOnzMciZMuFOjZbZpT6M/JpF1foP9AZlE
         CTt6UyxNn0t4maELRb8vFmnciOaAi9XeCYAX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CevgO8y+bID+0RAL78i6xuCLe1DAtuhsuxp9oVmqPQU=;
        b=AQglnO0HiZEdfVTSw3924f0fJXkSCPwgkdUwOKzsw8Vvw/w+TFtf2gt6mPIKRVWMVU
         wp6AjBoUSS1Tg9YU2Ig1ltakOm6LZVs/40A62rJ4+YUWFZu71314jXJnzjq06JE3FZ+y
         SBRqkMN0RR2ZcsViHeCMVBmX/nqJgZj6x2RVHgQfby4JNdO7NBlWRKGr0ecP+1mwPpFO
         YfcpkOpF4l7SI1sa0J4hocyI9toeD+CXePE+sZyMyfBs1EHJxuy3L8wChzGVWXyS3X9q
         JCsnCce35FX03Wv3dWfjvPD8nydb7KuIj7MmEWB3IC24ujeiKqfgvYnBk89FS7GlTkq4
         lnRg==
X-Gm-Message-State: AOAM532QYHdnryy9zMe85pAHgIxmWrTK1hkXqrTI1VSFf2h7bCv1WiMF
        Gw37EFA0tehe/cEuXLOki7DJNTwdnadAatpCJAiNSQ==
X-Google-Smtp-Source: ABdhPJznRUZHYjzTK+AQg0Ekew5Jmkjqxgf9THY/0F2af+vjSso/3Yfi5HB6kL+u3+1mzuQyYpPhW+i0c+cYdCrgi/M=
X-Received: by 2002:a17:906:4aca:: with SMTP id u10mr138835ejt.320.1597243591705;
 Wed, 12 Aug 2020 07:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com> <20200812143957.GQ1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812143957.GQ1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 16:46:20 +0200
Message-ID: <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
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

On Wed, Aug 12, 2020 at 4:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 12, 2020 at 09:23:23AM +0200, Miklos Szeredi wrote:
>
> > Anyway, starting with just introducing the alt namespace without
> > unification seems to be a good first step. If that turns out to be
> > workable, we can revisit unification later.
>
> Start with coming up with answers to the questions on semantics
> upthread.  To spare you the joy of digging through the branches
> of that thread, how's that for starters?
>
> "Can those suckers be passed to
> ...at() as starting points?

No.

>  Can they be bound in namespace?

No.

> Can something be bound *on* them?

No.

>  What do they have for inodes
> and what maintains their inumbers (and st_dev, while we are at
> it)?

Irrelevant.  Can be some anon dev + shared inode.

The only attribute of an attribute that I can think of that makes
sense would be st_size, but even that is probably unimportant.

>  Can _they_ have secondaries like that (sensu Swift)?

Reference?

> Is that a flat space, or can they be directories?"

Yes it has a directory tree.   But you can't mkdir, rename, link,
symlink, etc on anything in there.

Thanks,
Miklos
