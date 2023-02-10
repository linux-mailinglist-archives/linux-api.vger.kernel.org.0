Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80F369256F
	for <lists+linux-api@lfdr.de>; Fri, 10 Feb 2023 19:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjBJShZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Feb 2023 13:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjBJShX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Feb 2023 13:37:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7852D16E
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 10:37:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so6909113wmb.2
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 10:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45HS3XcRsfRS5VbZ2TiXDHQBLKSDRISNQErTXQPnH+g=;
        b=fA28mHicQVXU0rc9eizNL3RpJL4UanQ9gfQOBZ57SNqi5RpYK6zoS094B9dEWMLQUJ
         VDR5+QKCsCoY483JdS84PYO+YawCsU7ivhQXQygIuTrEgqYgXEUqNL9o00YmCoBr4cj0
         8loINQ8lMH5qSDzADuKONPbLiCHUOVpr3CWx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45HS3XcRsfRS5VbZ2TiXDHQBLKSDRISNQErTXQPnH+g=;
        b=WqS/0x1v4xc/tHZGtByL5JP6HZuSDp8bI6hEnqLu7PjIecIj/6hmtuODsYSzoxSWzE
         Ikj0J29d6hcaZKXZgZ84nR4Q7/Ad3g/KWXm9X6DTRe8uswQX/Asy01hIi7cIvBpsPwLT
         4RWYkZ163gwBv8qLT2p4Jjw/2t49SlKARXINNkR0tCvqouPBJb12qmDCN46ozeSVsgkA
         hdJRf/+iElvYn1z1vQPDLlncdwA1YhcqEqwYSvyFBtQPVjpKZMkB9PL/yeR7eXKm00av
         x78MJldDXg3sME1GwUE2EJAu63rGbyF6XYXxY4LAYgpq34VxDGOL/4UU1MCqBi920BKF
         mC2w==
X-Gm-Message-State: AO0yUKVrI22cOK1KseXIvUf7xuwrAQX5+uCc0QCWdtwt67ZULnHxwKCS
        SLt2cfHawKM37et65jbGU7VBBTcobyulhFRZ4zg=
X-Google-Smtp-Source: AK7set9F9XlXIe43czVQKjcqW/e6nUQBFFsPZU8XPsbSVIsoy7kmlwovsUvL+z2qfkm81MFyhgOk4A==
X-Received: by 2002:a05:600c:308a:b0:3dc:43a0:83bb with SMTP id g10-20020a05600c308a00b003dc43a083bbmr13795913wmn.3.1676054240245;
        Fri, 10 Feb 2023 10:37:20 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b003e00c9888besm8970078wmj.30.2023.02.10.10.37.19
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 10:37:19 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id cq19so2722740edb.5
        for <linux-api@vger.kernel.org>; Fri, 10 Feb 2023 10:37:19 -0800 (PST)
X-Received: by 2002:a50:f61e:0:b0:4ab:168c:dbd7 with SMTP id
 c30-20020a50f61e000000b004ab168cdbd7mr1816109edn.5.1676054239147; Fri, 10 Feb
 2023 10:37:19 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <20230210021603.GA2825702@dread.disaster.area> <20230210040626.GB2825702@dread.disaster.area>
 <Y+XLuYh+kC+4wTRi@casper.infradead.org> <20230210065747.GD2825702@dread.disaster.area>
 <CALCETrWjJisipSJA7tPu+h6B2gs3m+g0yPhZ4z+Atod+WOMkZg@mail.gmail.com>
 <CAHk-=wj66F6CdJUAAjqigXMBy7gHquFMzPNAwKCgkrb2mF6U7w@mail.gmail.com> <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
In-Reply-To: <CALCETrU-9Wcb_zCsVWr24V=uCA0+c6x359UkJBOBgkbq+UHAMA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Feb 2023 10:37:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
Message-ID: <CAHk-=wjQZWMeQ9OgXDNepf+TLijqj0Lm0dXWwWzDcbz6o7yy_g@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 10, 2023 at 9:57 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> I am saying exactly what I meant.  Obviously mutable data exists.  I'm
> saying that *putting it in a pipe* *while it's still mutable* is not
> good.  Which implies that I don't think splice() is good.  No offense.

No offense at all. As mentioned, I have grown to detest splice over the years.

That said, in defense of splice(), it really does solve a lot of
conceptual problems.

And I still think that conceptually it's absolutely lovely in *theory*.

And part of it is very much the fact that pipes are useful and have
the infrastructure for other things. So you can mix regular read/write
calls with splice, and it actually makes sense. One of the design
goals was for things like static http, where you don't really send out
just file contents, there's a whole header to it as well.

So it's not just a specialized "send file contents to network", it's a
"you can do a write() call to start filling the pipe buffer with the
http header, then a splice() to start filling the file data".

And it was also designed to allow other sources, notably things like
video capture cards etc. And very much multiple destinations (again,
media accelerators).

So it all "makes sense" conceptually as a generic pipe (sic) between
different sources and sinks. And again, using a pipe as the mechanism
then also makes perfect sense in a historical Unix context of
"everything is a pipe".

But.

The above just tries to make sense of the design, and excuses for it.
I want to re-iterate that I think it's all lovely and coherent
conceptually. But in practice, it's just a huge pain.

The same way "everything is a pipeline of processes" is very much
historical Unix and very useful for shell scripting, but isn't
actually then normally very useful for larger problems, splice()
really never lived up to that conceptual issue, and it's just really
really nasty in practice.

But we're stuck with it.

I'm not convinced your suggestion of extending io_uring with new
primitives is any better in practice, though.

          Linus
