Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC1F5ED4
	for <lists+linux-api@lfdr.de>; Sat,  9 Nov 2019 12:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKILwk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 9 Nov 2019 06:52:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37733 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfKILwk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 9 Nov 2019 06:52:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so6472427lfp.4
        for <linux-api@vger.kernel.org>; Sat, 09 Nov 2019 03:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xi6duH3pBBVubrdx2RiTwNtljwfoO/cyvowXG2Qx18U=;
        b=o8CqLajkWNFhR3uhVNiDxjadE5ILz5wPV6y6dpceqE0oYlpns2eB0UzxAbraWdpDVF
         xl9+bUsCkAfUkrVCfNTX2c8DVOqrUWrR0dk6mXikmWnxhWVtpuEqDwCsy232gusIWiE8
         huycSUzxmhtxszusXyyqC/9DqjTHBkw5gQfu9Ik01QP6EtHOlsKzK15mdKigeZxz8mF/
         eW8BXZ9+KfgaPg7pPt+cQTKI/RYxnD9fBoMfxFOOEiNLJge1wk11K+/nUNaXbCLQPnyX
         Dx5eHk25FLJoRXEK+s3hVuhYmlxfibSzVUjFJNnOc0Nmmo8MPwde4Pdf7h9sIQz8nOcP
         uDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xi6duH3pBBVubrdx2RiTwNtljwfoO/cyvowXG2Qx18U=;
        b=U/JojsaLuyrK0XiZ/CRg3vL6AJr3KqKQO3+MvUHXXCQaci417iomdSHpPKULEiXklR
         qvIrdtVBcfLgj8ubInwzJnnPoY3XZ6CzpShTSGvYEgjUQ1tWCcG4JaWivZJ8v1dQePpN
         AujXAjHByRO69byI257qesWRiUMS/zY05+tFwLvT5P+Lnxz0gu5lEkCVXhoqzvJWUGu5
         JI8b3KvkolEtuahWOphfQu+D7GERSp7pdu2HnP/ephD2XanLsYtKjBdXLp7N6AqsF9Lt
         JAe6fGAaDzKfeRjbkh/TO6fNz/hNHUbkstY+N/RfVhKnHGwt3yOdQfDQ9nNEYPFMXuLo
         ctiQ==
X-Gm-Message-State: APjAAAUKqg7PjdXboU0ktW8JBOPC/eOh8ffTPCZo2XKlfuGauSCzZFne
        CePJ6H3QnvB8Yq0tfg81bu0y8rS9qQ67UsxdGAzNvw==
X-Google-Smtp-Source: APXvYqyWrNa5kgLQFiYbc8T2N1L5NbiJATXLd6NVurZp09K3k0dfahesSkuUyudSgBeRxFVAUXcKLj7XMjggWJhTubU=
X-Received: by 2002:ac2:4302:: with SMTP id l2mr4854460lfh.116.1573300357860;
 Sat, 09 Nov 2019 03:52:37 -0800 (PST)
MIME-Version: 1.0
References: <CALN7hCJRe1uL6pd+VwgzDt=5giMVjvX+YpF28f5qbLOVCZf4GQ@mail.gmail.com>
 <04EB5627-FD42-4397-995B-FDF051CFCFB5@brauner.io>
In-Reply-To: <04EB5627-FD42-4397-995B-FDF051CFCFB5@brauner.io>
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Sat, 9 Nov 2019 13:52:11 +0200
Message-ID: <CALN7hC+YmHGpniNKBiD03cBnTyO+cqXhrVvE7SdtgEb7GkG-LQ@mail.gmail.com>
Subject: Re: Missing size_t declaration in UAPI
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,
I'm proposing to move `linux/tools/include/nolibc/nolibc.h` to the
UAPI interface.
It would then be included in `linux/types.h`
Would love feedback before I work on a patch.

Thanks.
Elichai.

On Fri, Nov 8, 2019 at 11:43 PM Christian Brauner <christian@brauner.io> wr=
ote:
>
> On November 8, 2019 10:25:09 PM GMT+01:00, Elichai Turkel <elichai.turkel=
@gmail.com> wrote:
>>
>> Hi,
>> Currently compiling the following program fails:
>> ```
>> #include "linux/signal.h"
>> void main(void){}
>> ```
>> Because of `./asm/signal.h:127:2: error: unknown type name =E2=80=98size=
_t=E2=80=99`.
>>
>> I tried patching with `#include <stddef.h>` but there's a local file
>> with the same name overriding the include.
>>
>> How can this be fixed? the `drm` headers seems to work with `uint_*`.
>>
>> Right now the `linux/signal.h` header isn't usable without wrapping it
>> with another header to include/define size_t.
>>
>> Thanks,
>> Elichai.
>
>
> I think it might make sense to always cc the libc mailing list too for th=
ese things.



--=20
PGP: 5607C93B5F86650C
