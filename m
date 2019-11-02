Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D205ED0C5
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2019 23:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfKBWEF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 2 Nov 2019 18:04:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39530 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfKBWEF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 2 Nov 2019 18:04:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id y3so13706164ljj.6
        for <linux-api@vger.kernel.org>; Sat, 02 Nov 2019 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=XRll/5vMVkjx89KHnpq6WWB0oHHUpEHdiN6O6XIbNfDvJpLq9nAHdnvBRo0qcYtdlV
         dDebt2KT4z/UoQ3oT2Pk6vWaFBXKSztN5uuRAQNTvGwr3g3jPPeee0pGSv+auGk2TkT9
         /FiIqnPnAFsk6ubf5wFePKPpQhSpZfg8GPgik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vTCI0qHuBsBb0Kz5RbeswHqlSoPusOsIRcj6s1CCCCU=;
        b=GwGSctVpLZ0TcDZWCIIH8z2+2G2AcltDujE+w5aGrW3e4MTv+iFZR7SDxUagDWkwPI
         xEIw/y6UXJ6jiNayCBwd69jezmFtghntlxqB1d0ZdA8QNd6OWAe9jiurvRHlsu9AsRmh
         roCxLzK9Q62yCQpdoRKCNgj4s6oKqAluB6AZswgVRD1OSlhdUezb/NWg308gum5xPrKt
         Iicj8YvtoGi23QcrJNXrDiHfr+LMCYcVx8fvb49zFcLYeP0kcNCpvYCF7dMyjz1ZLD+d
         2avHNN9+cQtj8JZuKTSskwarV3KOefc3Xu2OOqV777mT/13o1p3p9qefwByP84TQagOZ
         We8Q==
X-Gm-Message-State: APjAAAVSicc7Grp5H6821HqiDI9f2V3jOcUStH12pZJR4UC04UNMX7mQ
        ONI2fGO5VTQM24BXU78iPn/4iO5VdcE=
X-Google-Smtp-Source: APXvYqylpF3tcKpgozfD/syB8hnYmEnNwyHg2IqTPPXK83LLL3Q2EY4o3TiWwJ+ZnqTQmaEXbNTzSA==
X-Received: by 2002:a2e:7a04:: with SMTP id v4mr466363ljc.106.1572732242751;
        Sat, 02 Nov 2019 15:04:02 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v6sm7257749ljd.15.2019.11.02.15.03.59
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 15:04:00 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 139so13740111ljf.1
        for <linux-api@vger.kernel.org>; Sat, 02 Nov 2019 15:03:59 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr13611187lja.48.1572732239632;
 Sat, 02 Nov 2019 15:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <25886.1572723272@warthog.procyon.org.uk> <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
In-Reply-To: <CC3328CC-2F05-461E-AAC3-8DEBAB1BA162@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 15:03:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
Message-ID: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
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

On Sat, Nov 2, 2019 at 1:31 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Add in the fact that it=E2=80=99s not obvious that vmsplice *can* be used=
 correctly, and I=E2=80=99m wondering if we should just remove it or make i=
t just do write() under the hood.

Sure it can. Just don't modify the data you vmsplice. It's really that simp=
le.

That said, if we don't have any actual users, then we should look at
removing it (maybe turning it into "write()" as you say). Not because
it's hard to use, but simply because it probably doesn't have that
many uses.

               Linus
