Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518C4ED0D1
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2019 23:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKBWJc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 2 Nov 2019 18:09:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32773 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfKBWJb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 2 Nov 2019 18:09:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id t5so13739761ljk.0
        for <linux-api@vger.kernel.org>; Sat, 02 Nov 2019 15:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w/G6EKdeKHyA10XyqtoNEQBxMdg61j9NrYNZ+OC/8O0=;
        b=fiTiutJMMhzHoUatnMj/i0xks6LRSmy0r7/BRz4Oo2NzE6YmtOVVD9WTTp3vp/4Ftl
         susZvLuDrEDv2Y0EisfAoYbNX8c8ba0GWiLrv658sEXczCmotmacJTxLnXp7ikF2o1OS
         tH5KGMhlSFlbvPUr5HFJ0KdvbB3vKmi6HfEto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w/G6EKdeKHyA10XyqtoNEQBxMdg61j9NrYNZ+OC/8O0=;
        b=q6QWqAC77+K8dwPBLpftyEGM1qqJmrKjtDIk9+mC6/q76BLHxz68/xCnhhVu2SydIW
         syEx4XCPZMVkSl1M+yeluUt2GMPogcMlqINN3wmM6UhsHziZns1cQy99YwQuJi5rqqvg
         ZX3PXISAJnpUE1JXr7D2N6/6+LfFR7yVobv1P+0Q5+/7v8jgj8iueJxubpwJJfcG2Iy5
         FsIpR0oNzfHNPNwnR2vxCLhz0y3ZrzOiIMRnKjWXhhBknQef0xtZi3llXjbgUbT/gJ+L
         XtF9R+lvupP0DfRbHAdRRTt+f8dElc46XwRYQgdlf/BAxJc82kATt83Y77o3d657lhkw
         k6EA==
X-Gm-Message-State: APjAAAXX08pexWAl9t1cToNyBKEiwkmbeCEKfAOFVSVC+NnaHXD8GiUg
        t3I0WMQqhuaI2uI6AHyjYmWoz4bSqDA=
X-Google-Smtp-Source: APXvYqwj/1nCU41m3+SxxVFluT34evZ1dabwZa6t+AsYgmO0rjmt4yNcrXx5Rw80njSW/qrf4qBnOA==
X-Received: by 2002:a2e:91c9:: with SMTP id u9mr13475069ljg.227.1572732566883;
        Sat, 02 Nov 2019 15:09:26 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t25sm3945655ljj.93.2019.11.02.15.09.25
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:09:26 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y6so9608333lfj.2
        for <linux-api@vger.kernel.org>; Sat, 02 Nov 2019 15:09:25 -0700 (PDT)
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr11937953lfc.79.1572732565288;
 Sat, 02 Nov 2019 15:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <25886.1572723272@warthog.procyon.org.uk> <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
 <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
In-Reply-To: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 15:09:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNJYdEcomZKaD034S==-gEXg_V3JpW+DpKXFi5fJuruw@mail.gmail.com>
Message-ID: <CAHk-=wiNJYdEcomZKaD034S==-gEXg_V3JpW+DpKXFi5fJuruw@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 2, 2019 at 3:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
> >
> > Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be us=
ed correctly, and I=E2=80=99m wondering if we should just remove it or make=
 it just do write() under the hood.
>
> Sure it can. Just don't modify the data you vmsplice. It's really that si=
mple.
>
> That said, if we don't have any actual users, then we should look at
> removing it (maybe turning it into "write()" as you say). Not because
> it's hard to use, but simply because it probably doesn't have that
> many uses.

Looking at debian code search, there are _some_ uses (including
openssl and fuse):

  https://codesearch.debian.net/search?q=3D%3D+vmsplice%28&literal=3D1

but I didn't check any more closely what they do.

             Linus
