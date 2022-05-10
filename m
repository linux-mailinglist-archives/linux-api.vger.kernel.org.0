Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1565217A3
	for <lists+linux-api@lfdr.de>; Tue, 10 May 2022 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbiEJN2G (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 May 2022 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbiEJNZa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 May 2022 09:25:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D0102773
        for <linux-api@vger.kernel.org>; Tue, 10 May 2022 06:18:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id be20so19947291edb.12
        for <linux-api@vger.kernel.org>; Tue, 10 May 2022 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bQPxzjuthC5W7FG0xtvK97qut8WhgOZVs5QGqQcukzE=;
        b=Ib9QQhXrM+AZHVuN39H0Gj+04jz1DkFcq6dfa7Ts+bfu4GOpgy7EP6e6+/Bu+c3z2N
         ENIb0CkTl5epcS7kuHzNgbY6Ckx3XymenJ9LEcP3JjqiswNfAYZSUESSCTojwaYl0Ys8
         Wby5SNlVrBFWql2lFfQTzdFuqaK5lVdg5fmGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQPxzjuthC5W7FG0xtvK97qut8WhgOZVs5QGqQcukzE=;
        b=X7da6JD9Aw4kwukR7Yk3poHx6bpqGZN1IZ1eysOL+Ksz005+QOZi9yxrDcvmDqnIYL
         XfFMdzke+LFTk22Mk0JA46Jttyd73nphI1O5bP4/yCOL8Zjuy1UZubJ8Jw8UbGBNWKlI
         ZXvqLDdL/5LcJNGT0dIQBBi0Q7dAKTj0TAVLgSMURhdv01h0UI1K6lzCe7/B+fIFreAS
         6XPpVUXVA7EDXEAlrjOHAA1AWoqc2HZdfSPS9k22ZTVeEx3h3w8ECBZz45DmBPeJFpd2
         ZHEyaDV0rwOJGvGmsk5PCVrymhvagu7XViqpwQMW+scpgPlG/sNQja8EIELidvSAVypY
         TLSQ==
X-Gm-Message-State: AOAM533Qs6RBpeAoW3moLs3G0J9lMeWWzUECz5Djnt3xD9ACu5r/Z2fV
        fT5WOdV4EUyNIyWTtY/iJvNsc5YlQs4ulg+tHnqA1Q==
X-Google-Smtp-Source: ABdhPJwczgUPDxe7i5EFoi7djB0qfa6gmDtEieMpp4Tpi/GlN71wFMNkosjsi+Nmytcb6euO0hRwtO0GNWPw30McobE=
X-Received: by 2002:a05:6402:f08:b0:428:53c1:a867 with SMTP id
 i8-20020a0564020f0800b0042853c1a867mr23374997eda.224.1652188732583; Tue, 10
 May 2022 06:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
 <20220510115316.acr6gl5ayqszada6@wittgenstein> <CAJfpegtVgyumJiFM_ujjuRTjg07vwOd4h9AT+mbh+n1Qn-LqqA@mail.gmail.com>
In-Reply-To: <CAJfpegtVgyumJiFM_ujjuRTjg07vwOd4h9AT+mbh+n1Qn-LqqA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 May 2022 15:18:40 +0200
Message-ID: <CAJfpegvBoYABebN2GD=ecu4gUsPZgiTksK6S8d3MA-1r1NgmMA@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 10 May 2022 at 15:15, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 10 May 2022 at 13:53, Christian Brauner <brauner@kernel.org> wrote:
>
> > > What exactly are the attributes that systemd requires?
> >
> > We keep a repo with ideas for (kernel) extensions - we should probably
> > publish that somewhere - but the list we used for a prototype roughly
> > contains:
> >
> > * mount flags MOUNT_ATTR_RDONLY etc.
> > * time flags MOUNT_ATTR_RELATIME etc. (could probably be combined with
> >   mount flags. We missed the opportunity to make them proper enums
> >   separate from other mount flags imho.)
> > * propagation "flags" (MS_SHARED)
> > * peer group
> > * mnt_id of the mount
> > * mnt_id of the mount's parent
> > * owning userns
>
> Sounds good thus far.   And hey, we don't even need a new syscall:
> statx(2) could handle these fine.

Oh, we need this indexed with a mount id, which statx can't do.  So
indeed, a new syscall may be the best choice.

Thanks,
Miklos
