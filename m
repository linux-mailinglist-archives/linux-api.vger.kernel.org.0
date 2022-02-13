Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAAA4B38EF
	for <lists+linux-api@lfdr.de>; Sun, 13 Feb 2022 03:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiBMCcT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Feb 2022 21:32:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiBMCcS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Feb 2022 21:32:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2CE5FF2E
        for <linux-api@vger.kernel.org>; Sat, 12 Feb 2022 18:32:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u12so7781348plf.13
        for <linux-api@vger.kernel.org>; Sat, 12 Feb 2022 18:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=684CqHNwxeeFLDieT+hnImprW0dvEy16HRmo/OqQ8xM=;
        b=2/eyFc1PS/DG76NEKk8T151hYk/zKSztRGlztHd6pc0aK7ITJTn2hnlBYUh4LfTu8N
         NzDHhflNWPpKnwjtmTIem29YuUXO8HGI6pGiua3Ht1aD51mkr0XaB+i7i8B1y+C2wLN4
         Gp0235f94zC/e+/VEY+aBGx7k5zK86/Q+rcv90U55I3yFunbLBqcm0P9PrIuUTs3WvkX
         xyWMflfEMQ89O1RPyHPWwnySFALCgg9m+jmk6128At2dw8WD6TrfQsPHvsXgBmQ2WI9/
         79XVmkOmcqEpAwgWU8r91cFOXXgtjCZPRK+cMrdnbAEp+PQ99Ak114iATUTAyY2sx7Qv
         ELKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=684CqHNwxeeFLDieT+hnImprW0dvEy16HRmo/OqQ8xM=;
        b=oZ9vs0pevWGoFww1qLE4M3qtoD+CJrBjpWgJKnsSjf4evl37x7HW5bmCS2pMCB1Tx4
         7dNnbwRyV8I0H1bdZZwbEQlyHtNvUO5bAhDvIi5U2tf/86mnAU6Y8KaELEAgBn2DQwgW
         AtYb848D7SB+3X4hB3XNJ02OrbLU52TzrxEF8lwrzc1ITGvj+Nn+vXcfMq0C4r0ZcxGY
         O7BiZEkSfdCPU3Ssn5hHcvexqmtxSIfCehGe5bpaTiby2naRnlMDYjNw3TjsbkcYo5jK
         uNIrAn8Jm0puQhurA/G9QzlrjeKu4X4WHvY6RZTrTst1ipw22FQCzsXjad2rM00KB2Eb
         E/5w==
X-Gm-Message-State: AOAM530K3FCVu+W20pe/+lxSbeZl1+xnzkVZa7Q+QFfEYPo1sTfdZcnN
        sE9Nt0jrcL0mjYxrxUQyBwr8JA==
X-Google-Smtp-Source: ABdhPJyO3PZGcWVStExkJGBmRqNZ3FSI0hCXzWP8s9q//C22gfxpdpkBR42a4pFeBrtu1+7v3NVK6A==
X-Received: by 2002:a17:90a:9704:: with SMTP id x4mr7680500pjo.219.1644719532927;
        Sat, 12 Feb 2022 18:32:12 -0800 (PST)
Received: from smtpclient.apple ([2600:1010:b021:31a8:38de:7526:b98f:ba7b])
        by smtp.gmail.com with ESMTPSA id 16sm20612051pfm.200.2022.02.12.18.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 18:32:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] Get siginfo from unreaped task
Date:   Sat, 12 Feb 2022 18:32:08 -0800
Message-Id: <CF5167CE-FA1C-4CEC-9EA8-5EE8041FE7C4@amacapital.net>
References: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Will Drewry <wad@chromium.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
To:     =?utf-8?Q?Robert_=C5=9Awi=C4=99cki?= <robert@swiecki.net>
X-Mailer: iPhone Mail (19C63)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Feb 12, 2022, at 3:24 AM, Robert =C5=9Awi=C4=99cki <robert@swiecki.net>=
 wrote:
>=20
> =EF=BB=BFsob., 12 lut 2022 o 05:28 Kees Cook <keescook@chromium.org> napis=
a=C5=82(a):
>>=20
>> Make siginfo available through PTRACE_GETSIGINFO after process death,
>> without needing to have already used PTRACE_ATTACH. Uses 48 more bytes
>> in task_struct, though I bet there might be somewhere else we could
>> stash a copy of it?
>=20
> An alternative way of accessing this info could be abusing the
> waitid() interface, with some additional, custom to Linux, flag
>=20
> waitid(P_ALL, 0, &si, __WCHILDSIGINFO);
>=20
> which would change what is put into si.
>=20
> But maybe ptrace() is better, because it's mostly incompatible with
> other OSes anyway on the behavior/flag level, while waitd() seems to
> be POSIX/BSD standard, even if Linux specifies some additional flags.
>=20
>=20

I had a kind of opposite thought, which is that it would be very nice to be a=
ble to get all the waitid() data without reaping a process or even necessari=
ly being its parent.  Maybe these can be combined?  A new waitid() option li=
ke you=E2=80=99re suggesting could add siginfo (and might need permissions).=
  And we could have a different waitid() flag that says =E2=80=9Cmaybe not m=
y child, don=E2=80=99t reap=E2=80=9D (and also needs permissions).

Although the =E2=80=9Cdon=E2=80=99t reap=E2=80=9D thing is fundamentally rac=
y. What a sane process manager actually wants is an interface to read all th=
is info from a pidfd, which means it all needs to get stuck in struct pid. A=
nd task_struct needs a completion or wait queue so you can actually wait for=
 a pidfd to exit (unless someone already did this =E2=80=94 I had patches a w=
hile back).  And this would be awesome.=
