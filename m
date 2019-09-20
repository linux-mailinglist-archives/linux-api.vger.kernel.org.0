Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4662B95AB
	for <lists+linux-api@lfdr.de>; Fri, 20 Sep 2019 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfITQaM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Sep 2019 12:30:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38753 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbfITQaM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Sep 2019 12:30:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so2301821ljj.5
        for <linux-api@vger.kernel.org>; Fri, 20 Sep 2019 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qfHDj62HozW8w7YWwj9CkN9/sQfc3fOAZsNubcgArY=;
        b=ZQIGHEoM2VE/RUJCyR8wJqhG4SoL3m5ky7t1mnKhLv11uqJxbD6lRJm5k/4ajS8Sdo
         UMhvXa/MmA5zyCc/ENaP9s79+xZOTrHtnrS7z9ra7Xe2HT/ekZVmC2KO+GbdBvDc35H9
         t5l05A8TLonE+2sI7SlSpw7F1/5/t4r9zscBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qfHDj62HozW8w7YWwj9CkN9/sQfc3fOAZsNubcgArY=;
        b=UzOaPmTz+JTSWyXsldF5qCCobi1LPu0/QhKZQJLsRgjhg56aKKDLIfukbCietpQfCH
         tCKvBD2rONO2NRPfCIO/gBs1S26PAfvob335OSHC4ZummKp503LMlnW8raPlN3xxPQD0
         y5Y0+O3i0SHqFlj+n0phN45aGt4sSFzJkmhYIc3SGhDVIj6Eltvop+gIsA/TilHA9bAe
         +s/2nM7czlDIWkPIUwKyJ65HxRYaWYH5Zk33lcvHYoDedTkHYtGdlW7sYsQ52wghkRYY
         7Ds5p1DLjk2ep9QG0tC54gvr03vqWS+28JK2yG7/0/jVDAbUH/LwdCJgIEmuBD4AEfYy
         3ruA==
X-Gm-Message-State: APjAAAXci/qfaylb2mFFtbFLFA1YTXMqiuHPSBeXvMma6eZpRo+8Elf2
        6kCcGPHwCNY69e1QGddLxL48RoicDk4=
X-Google-Smtp-Source: APXvYqxLF8wAKOsU3v4WbyRqDb5SMDGF+JQqs7DcAy+gn/hNHN9OqROMrVMqzoX71wVvw5T8UE4BkQ==
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr9324376ljj.206.1568997009445;
        Fri, 20 Sep 2019 09:30:09 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x3sm544467ljm.103.2019.09.20.09.30.07
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:30:08 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id j19so6194774lja.1
        for <linux-api@vger.kernel.org>; Fri, 20 Sep 2019 09:30:07 -0700 (PDT)
X-Received: by 2002:a2e:96d3:: with SMTP id d19mr411864ljj.165.1568997007674;
 Fri, 20 Sep 2019 09:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc> <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
In-Reply-To: <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 09:29:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
Message-ID: <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 20, 2019 at 7:34 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> What is this GRND_EXPLICIT thing?

Your own email gives the explanation:

> Linus, I disagree that blocking while waiting for randomness is an
> error.  Sometimes you want to generate a key

That's *exactly* why GRND_EXPLICIT needs to be done regardless.

The keyword there is "Sometimes".

But people currently use "getrandom(0)" when they DO NOT want a key,
they just want some miscellaneous random numbers for some totally
non-security-related reason.

And that will continue. Exactly because the people who do not want a
key by definition aren't thinking about it very hard.

So the interface was very much mis-designed from the get-go. It was
designed purely for key people, even though generating keys is by no
means the most common reason for wanting a block of "random" numbers.

So GRND_EXPLICIT is there very much to make sure people who want true
secure keys will say so, and five years from now we will not have the
confusion between "Oh, I wasn't thinking about bootup". Because at a
minimum, in the near future getrandom(0) will warn about the
ambiguity. Or it will use some questionable jitter entropy that some
real key users will look at sideways and go "I don't want that".

This is an ABI design issue. The old ABI was fundamentally misdesigned
and actively encouraged the current situation of mixing secure and
insecure callers for that getrandom(0).

And it's entirely orthogonal to _any_ actual technical change we will
do (like removing the old GRND_RANDOM behavior entirely, which is
insane for other reasons and nobody ever wanted or likely used).

            Linus
