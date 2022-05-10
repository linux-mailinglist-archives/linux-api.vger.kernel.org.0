Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D16521D83
	for <lists+linux-api@lfdr.de>; Tue, 10 May 2022 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbiEJPKP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 May 2022 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345520AbiEJPKE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 May 2022 11:10:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B4663F4
        for <linux-api@vger.kernel.org>; Tue, 10 May 2022 07:41:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id be20so20258947edb.12
        for <linux-api@vger.kernel.org>; Tue, 10 May 2022 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0kIV1SwXQMNPqOufG4oNCm/OKmJd8Pq9VuUM/8qF2c=;
        b=iH3GtIL3/HqFhI5vcBNrLNm4DRccYURKHIqy8W7HZ/otX11R9Ov4rZTaAVltaR0Mva
         80FE8kcPQSs8h8JSbjpouDxLkQTv+hMaf/4Y2m1lh8xn4wzs5s4/MBy4c2DwoScw3e+o
         E+MdKVSqLPJ9pFE7K2Y3sfcRJNwtl4QfNG+Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0kIV1SwXQMNPqOufG4oNCm/OKmJd8Pq9VuUM/8qF2c=;
        b=Rr09VG+UkGg+J+F750A7c5jTsN/Dorkyh5tq6kmL1jhkxCdzUYq9cUB/fncT6NaCEc
         yiqt0kihfn8bnAvGxhLsqGC/+jM7Vi7AvCDIqdxKb7oy7H9GvBaCT1xHlLm39QJ6Dvn0
         VfuWiCZjGo7oTZ8J95NGVP92HMugHjH1umtivIaqgF92/O/W4H9KJiwmJsVANX6ilP4b
         7hb6XrJDtD2HVlUQU4Wx8kZugExavLRmn0SoaNl9MHjGPa+0xUf3dJ0dj5dXeXa38heP
         ArJDWA1ZvPAPjcpZwofuep5Z+pJySuRuWHu2enJM0K8N3Ar5/sC+YG0xBKupH8cmpdED
         bbFg==
X-Gm-Message-State: AOAM531khXLagjX5Qoe2X7GFahshSHWyJp6Jg/xd9gWuZwt9owD4YKPr
        iZmTUHku/qPhsqtVE5rDxp4j06OeJSNIfYbjO5FboQ==
X-Google-Smtp-Source: ABdhPJwxFcHy0kTOLumVuIloHjeYzOBbRfxZpYeVUtm6nIVeD33bgE9YLgFuNW1UMgkcJZ3m/B9WcMJWOK6pK3hy5q0=
X-Received: by 2002:a05:6402:5ca:b0:423:f330:f574 with SMTP id
 n10-20020a05640205ca00b00423f330f574mr23198373edx.116.1652193707637; Tue, 10
 May 2022 07:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
 <20220510115316.acr6gl5ayqszada6@wittgenstein> <CAJfpegtVgyumJiFM_ujjuRTjg07vwOd4h9AT+mbh+n1Qn-LqqA@mail.gmail.com>
 <20220510141932.lth3bryefbl6ykny@wittgenstein>
In-Reply-To: <20220510141932.lth3bryefbl6ykny@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 May 2022 16:41:35 +0200
Message-ID: <CAJfpegt94fP-_eDAk=_C=24ahCtjQ4vhh8Xg+SrZbwPHs1waLA@mail.gmail.com>
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

On Tue, 10 May 2022 at 16:19, Christian Brauner <brauner@kernel.org> wrote:

> Fwiw, turning this around: unifying semantically distinct interfaces
> because of syntactical similarities is bad. Moving them into a
> syntactically equivalent system call that expresses the difference in
> semantics in its name is good.

You are ignoring the arguments against fragmentation.

You are also ignoring the fact that semantically the current xattr
interface is already fragmented.   Grep for "strncmp(name, XATTR_" in
fs/xattr.c.

We don't have getsecurityxattr(), getuserxattr(), gettrustedxattr()
and getsystemxattr().  It would be crazy.   Adding getfsxattr()  would
be equally crazy.  getxattr() pretty much describes the semantics of
all of these things.

Thanks,
Miklos
