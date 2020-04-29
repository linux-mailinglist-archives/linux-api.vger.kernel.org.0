Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460A01BE831
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD2UNh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Apr 2020 16:13:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgD2UNh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Apr 2020 16:13:37 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MlO5j-1ikOiA2IEH-00lklT; Wed, 29 Apr 2020 22:13:35 +0200
Received: by mail-qk1-f181.google.com with SMTP id g74so3381207qke.13;
        Wed, 29 Apr 2020 13:13:35 -0700 (PDT)
X-Gm-Message-State: AGi0PuZKJeyQsi5vXdTIxqcwhP1iOQ+UkecM3VWIOihlJWoBwrN1Q7Bs
        5y+Eu/6G/l1icwPhX7HSHrW1FNWLbwBMk1b5rIk=
X-Google-Smtp-Source: APiQypLgwNCOWXi8lqhZ+IOv19XxfH/9iluwOOMdrmf8VHOif7vlkTCUTHkDgO4JZEVtkCieIyzUDvCFIORJYDtFE+I=
X-Received: by 2002:ae9:f712:: with SMTP id s18mr204482qkg.394.1588191214238;
 Wed, 29 Apr 2020 13:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200429132349.1294904-1-arnd@arndb.de> <20200429133512.GE1551@shell.armlinux.org.uk>
In-Reply-To: <20200429133512.GE1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 22:13:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2hXhtCx6pk65__U1Msk_OPstT0Qad_skqjCz9DNSfq4A@mail.gmail.com>
Message-ID: <CAK8P3a2hXhtCx6pk65__U1Msk_OPstT0Qad_skqjCz9DNSfq4A@mail.gmail.com>
Subject: Re: [PATCH] [v2] ARM: oabi-compat: fix epoll_ctl build failure
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zqjB0K5itibZQxDrMZXbU6dnX9nPzRmtRkBND1WinO3L0z3plWD
 9u5ckpGOQBLolZ2lG/bNXZJq3mpAi4a8VWLQ5Yji8cKAntBsXFlOHYR0OAKjKavW5i/lSHf
 YIdWwMNkY5rXRO8vDKPEX27XBH45Qmi9Aqq7QbSOa2VFv70Cfu2wAO/quqYtYZEa+dx6rvA
 TStcjRw1udFVmJFUzJppg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BWh5PdHHxKQ=:MpYawQD1ciBPVEX2das18A
 utk58HKgTGlFGALiNtOAHZO1g5dDgTLCRB+BufUCxdQPSfVjvM9+HFnPAniHVkYZKZ1JY2Ofh
 chB3FyJgNoOuBLbg+EBgorrDgXqWXpPV8XMUuBG1tEEfa86Iw3OVZK0piwR/VAakS276/CFGx
 0I6VsLwPif+2Bum9+CtjP1UxV3oJ+3AFCjxVMzykl++qbjZIYlybXFHJi+q8Hpr2cNtm5Lyaz
 X2fpCgwtIq9FpHP/PKyhf3ie/Ab0zN5HmmDxmfem7TMRjD0lL1dCdcmqEwHfHlOV5UZnFE1s0
 t1NfnZYcBPItIFNLwn06l5UuIOqEYqfxbKiN7kA3z57+0NDFx/tub4XSi0qM7mt8VD1rQZqcF
 RMKSq8Bhfi+72KNBRXC1BVqw9BbSyOtVnmO0Yy9endtw+DazyFCHdhp6lW8oq6XKLrHqBuKx3
 3SWTk0srTyDCBa8Dr4fHR0r0AnuTU4SaUcH8c1sLNQFxvq1DpVQAQ0eB8Paz5Sp+7XOt+2D92
 1284OhQe2ifSuo2P56O64Lu6PlcgalfSsatr1Y7JFwgeqMrOfRZ65Im7kg6E5G/HeXbhmabt2
 J7dw/1Jhbg7o1uW2jqJzYBveIL8eeY7lb9ib7bOKiDuRgm4p19M8tp4nEal5VNcA61+9XvEvF
 Xn3VZXlp+C9ZeJrDCEI+ncmtIlTGnZe1c5zs4YrfyTOFssM9xgWTCdWvKP7LVP5O1kq1jHhiW
 uK3j2H3SCGeOqJsrEqSRw6rblfw27I1pFPUD6kWrbcfqMJHVjz5xSbSC3DUwAuRk10OiDjRS0
 52ytQN8K55Pv22f7FSwYI+0tdDEwKhfX2ECnUoXALHRTjisNYY=
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 29, 2020 at 3:35 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Wed, Apr 29, 2020 at 03:23:24PM +0200, Arnd Bergmann wrote:
> > Two functions are not declared or defined when CONFIG_EPOLL is
> > disabled:
> >
>
> I know what Chris said, but do we really want to be polluting generic
> kernel files with arch specific stuff like this?

The file already has a couple of architecture specific syscalls listed already,
so it shouldn't be a big deal. If you prefer the first version of my patch,
or have another suggestion, I don't mind sending a v3 that does it differently
again.

Unfortunately, COND_SYSCALL() is a locally defined macro in that file,
so we can't easily use it elsewhere without duplicating it like in
kernel/time/posix-stubs.c.

As I mentioned in v1, it's also possible to just make this function
compile without #ifdefs by having conditional stub definitions of the
missing interfaces.

      Arnd
