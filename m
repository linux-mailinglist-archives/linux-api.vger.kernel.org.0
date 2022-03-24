Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A658D4E608D
	for <lists+linux-api@lfdr.de>; Thu, 24 Mar 2022 09:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347448AbiCXIqZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Mar 2022 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCXIqZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Mar 2022 04:46:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C439BBB1
        for <linux-api@vger.kernel.org>; Thu, 24 Mar 2022 01:44:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qa43so7640232ejc.12
        for <linux-api@vger.kernel.org>; Thu, 24 Mar 2022 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++pYMAFi8siFITGTtI8OJ/ZLZmlTf/qSvmoDsoiudic=;
        b=bLvvkukA8BB7oL86pGuChsm+aSNaBbNixr+1oNjsVP/ANz9qs22bL+0co9+LxeTzLr
         p3/WfqNXLKRw5+YHpINrfHfutnGeCd8YeacpkAp7M5/e+ZXmlEcFJraf7HOoRtUvvuzU
         pRsj5BGCkDl5Z0LzlawnSEndD3gSIn0EoXRDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++pYMAFi8siFITGTtI8OJ/ZLZmlTf/qSvmoDsoiudic=;
        b=qt7f0gaCgO98N69zo363kD7qelS1H2NT1mAHgEl8XIBQKfAqWGaiuRKwAkG5uB1sSI
         2j4W/roWKfwix5j9KkZ7llwXIqOYAlqY5gVT3p62Sz2nZsYe4VeeCYcF9ZI08ILS8/nK
         jZJLnY0PRxCpechuWJbPiIvkaJ3IDPtpm02sKMt4Gd3usUqWJ4YNE+hIhkBOMzYt+IEJ
         Hwbuq92JDNTpQYlFrL/NpKm4amHFcf5QxOS1FqR4oto0fAECJlO0Z5TUiuzBPjhaAqL8
         W1uv6tH7Le3ejueoQgc3HiJ0k7Zii2sI1eGOrGdAUQFJ6sLpPZEn1cVAYbwhZH14T3FY
         9MiQ==
X-Gm-Message-State: AOAM532khx3ao8ZxUMFvNxTaQYFTWeja3bB3i9Xo08tS3AWO3F/Aq8xY
        hcjKHjYcaIsKmMRK43hVmDFeUvyPbFMmlz9lUolfWQ==
X-Google-Smtp-Source: ABdhPJySkj3ocM+OfhTMngFbezUNAcO5OUVM0gUJl6sz5vW4FyHPd7j4grGLKSZMO+nJda8YLjoLclQNUxq16JpPat4=
X-Received: by 2002:a17:906:2991:b0:6cf:6b24:e92f with SMTP id
 x17-20020a170906299100b006cf6b24e92fmr4461589eje.748.1648111489773; Thu, 24
 Mar 2022 01:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com> <YjudB7XARLlRtBiR@mit.edu>
In-Reply-To: <YjudB7XARLlRtBiR@mit.edu>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 24 Mar 2022 09:44:38 +0100
Message-ID: <CAJfpegtiRx6jRFUuPeXDxwJpBhYn0ekKkwYbGowUehGZkqVmAw@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 23 Mar 2022 at 23:20, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Mar 23, 2022 at 02:24:40PM +0100, Miklos Szeredi wrote:
> > The reason I stated thinking about this is that Amir wanted a per-sb
> > iostat interface and dumped it into /proc/PID/mountstats.  And that is
> > definitely not the right way to go about this.
> >
> > So we could add a statfsx() and start filling in new stuff, and that's
> > what Linus suggested.  But then we might need to add stuff that is not
> > representable in a flat structure (like for example the stuff that
> > nfs_show_stats does) and that again needs new infrastructure.
> >
> > Another example is task info in /proc.  Utilities are doing a crazy
> > number of syscalls to get trivial information.  Why don't we have a
> > procx(2) syscall?  I guess because lots of that is difficult to
> > represent in a flat structure.  Just take the lsof example: tt's doing
> > hundreds of thousands of syscalls on a desktop computer with just a
> > few hundred processes.
>
> I'm still a bit puzzled about the reason for getvalues(2) beyond,
> "reduce the number of system calls".  Is this a performance argument?

One argument that can't be worked around without batchingis atomicity.
Not sure how important that is, but IIRC it was one of the
requirements relating to the proposed fsinfo syscall, which this API
is meant to supersede.   Performance was also oft repeated regarding
the fsinfo API, but I'm less bought into that.

> If so, have you benchmarked lsof using this new interface?

Not yet.  Looked yesterday at both lsof and procps source code, and
both are pretty complex and not easy to plug in a new interface.   But
I've not yet given up...

> I did a quickie run on my laptop, which currently had 444 process.
> "lsof /home/tytso > /tmp/foo" didn't take long:
>
> % time lsof /home/tytso >& /tmp/foo
> real    0m0.144s
> user    0m0.039s
> sys     0m0.087s
>
> And an strace of that same lsof command indicated had 67,889 lines.
> So yeah, lots of system calls.  But is this new system call really
> going to speed up things by all that much?

$ ps uax | wc -l
335
$ time lsof > /dev/null

real 0m3.011s
user 0m1.257s
sys 0m1.249s
$ strace -o /tmp/strace lsof > /dev/null
$ wc -l /tmp/strace
638523 /tmp/strace

That's an order of magnitude higher than in your case; don't know what
could cause this.

Thanks,
Millos
