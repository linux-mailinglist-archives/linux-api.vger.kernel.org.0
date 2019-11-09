Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A86F5EEC
	for <lists+linux-api@lfdr.de>; Sat,  9 Nov 2019 13:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfKIMP7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 9 Nov 2019 07:15:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44393 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfKIMP6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 9 Nov 2019 07:15:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id v4so6480212lfd.11
        for <linux-api@vger.kernel.org>; Sat, 09 Nov 2019 04:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j54Tn5ZbYPJoRnAJ36pqoaL2ZMzTK7scfSSZFRv5Ns4=;
        b=HFGwogEKFzU3/E3ccnJhVYjC3Frb5RFYaNjh16uApilhETbu7kX8MJcJqF5t2IPEaP
         oHKNs1iZkOCauhh4xdPBv4spmb+gtG2dqqlNbJZ6aMWZtXQciaIGXg9v53QPYvolkDnZ
         49YJTzqmu8BZTyAwNlg2egzrgL4kjbav0klQpL4wrSqJ5lv9GHbVLsw5dunb/vrbV+y3
         pHfcRYptrFG2EqXwFb/OluWDvcKdZHk1ENfKlpduFPfL31Y9DDbv1zHR6YQjXtCqkvrJ
         HJbuCC1V+ir+5aXNFXiR0Odge1M9xl197oQJ0p+O0I/3iX8J61U2c9rgduWvV5bJzQdw
         /vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j54Tn5ZbYPJoRnAJ36pqoaL2ZMzTK7scfSSZFRv5Ns4=;
        b=KCywkFp+pdsXC1qx8iDCKGn8Va8zQywSJjekGRW0ZDGwyf/z5FlN96urz8UxfjSNs4
         E1WtPhsT4Xzd49h1yNhv1VgCREFOJHSI+WsZftSNzupPyQNU4p4UQEXjSwg4I6NXaLUQ
         KDwPjagy+CBQLPUjTL98xfG73FuH3Gldl38UgJe8bgPljlz/8qP392NdS+2U+a6B0J4J
         qrjuuELVc51PuNxqUcEDEED2A3nTMV7k+bBGf47ApDCrGvfw+wZLski4vBR6VJwWfw4W
         Vsnsgk1knmwR+DFtEPhq6WHLW51WYQN9tf2LS3nVK+TDCpP6xLh59BGnpNJP8aPk6jYD
         jRjw==
X-Gm-Message-State: APjAAAXr7ADU9Mn81VwpNB9C/4TUghPeYyFDyD8CECAzppK72Oawdmt+
        sHu/7MWKpSXQ441JP7sO5JKm8nzp5InoYeIN039Hug==
X-Google-Smtp-Source: APXvYqyUszyHJ+OP076JzB1ztSAOPbM2T2C++qZd6K6zmi4S0QIWpcr6DAwP9tmLcjoxCp2L9YqLqeHfiw4cTCUSTyw=
X-Received: by 2002:a19:820e:: with SMTP id e14mr9863810lfd.29.1573301756640;
 Sat, 09 Nov 2019 04:15:56 -0800 (PST)
MIME-Version: 1.0
References: <CALN7hCJRe1uL6pd+VwgzDt=5giMVjvX+YpF28f5qbLOVCZf4GQ@mail.gmail.com>
 <04EB5627-FD42-4397-995B-FDF051CFCFB5@brauner.io> <CALN7hC+YmHGpniNKBiD03cBnTyO+cqXhrVvE7SdtgEb7GkG-LQ@mail.gmail.com>
In-Reply-To: <CALN7hC+YmHGpniNKBiD03cBnTyO+cqXhrVvE7SdtgEb7GkG-LQ@mail.gmail.com>
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Sat, 9 Nov 2019 14:15:30 +0200
Message-ID: <CALN7hCKXbU_oXH_AfQ5Y204Faucc2UrwPASdgAHWoss8jgMgTA@mail.gmail.com>
Subject: Re: Missing size_t declaration in UAPI
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

After further reading into `nolibc.h` I think not all of it should be
in UAPI (specifically the syscalls wrappers don't).
I think it should be split and both the ASM declarations and the
types(i.e. size_t) should be in UAPI

On Sat, Nov 9, 2019 at 1:52 PM Elichai Turkel <elichai.turkel@gmail.com> wr=
ote:
>
> Hi,
> I'm proposing to move `linux/tools/include/nolibc/nolibc.h` to the
> UAPI interface.
> It would then be included in `linux/types.h`
> Would love feedback before I work on a patch.
>
> Thanks.
> Elichai.
>
> On Fri, Nov 8, 2019 at 11:43 PM Christian Brauner <christian@brauner.io> =
wrote:
> >
> > On November 8, 2019 10:25:09 PM GMT+01:00, Elichai Turkel <elichai.turk=
el@gmail.com> wrote:
> >>
> >> Hi,
> >> Currently compiling the following program fails:
> >> ```
> >> #include "linux/signal.h"
> >> void main(void){}
> >> ```
> >> Because of `./asm/signal.h:127:2: error: unknown type name =E2=80=98si=
ze_t=E2=80=99`.
> >>
> >> I tried patching with `#include <stddef.h>` but there's a local file
> >> with the same name overriding the include.
> >>
> >> How can this be fixed? the `drm` headers seems to work with `uint_*`.
> >>
> >> Right now the `linux/signal.h` header isn't usable without wrapping it
> >> with another header to include/define size_t.
> >>
> >> Thanks,
> >> Elichai.
> >
> >
> > I think it might make sense to always cc the libc mailing list too for =
these things.
>
>
>
> --
> PGP: 5607C93B5F86650C



--=20
PGP: 5607C93B5F86650C
