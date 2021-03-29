Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D73234D6CE
	for <lists+linux-api@lfdr.de>; Mon, 29 Mar 2021 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhC2SRU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Mar 2021 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhC2SQz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Mar 2021 14:16:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28149C061574
        for <linux-api@vger.kernel.org>; Mon, 29 Mar 2021 11:16:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t140so2597612pgb.13
        for <linux-api@vger.kernel.org>; Mon, 29 Mar 2021 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=8BodsD7dsVnt+VzHAjG94w3biZzppe7s1NeC4YW3R/c=;
        b=GNpIT7nzOTmW1j7uFYG4MsGsQxgaqfSrJP1SkCUw/L5kBaziQANp4Xtap/4+tcFNgC
         KTvZCQCQVpgIb0fUmLkQ60kWI8HQXJYR6DiQRm4CIU3tIU29oOJJZ+fz+Ocfv5mlWm8x
         DkEPHuwuZkcS4OKahPd0myLcrYOjKzc6pCbnd6jKrunOdLISD8RsZXHq1DisNJJfQ0gt
         cMIX92bLePaXILA75sfBZv7pX34Tzjw7R53UoU7TJeFVt5m/Pw3fgpgQJUSVboYdjgGs
         +CFJcbyeTYn8OpYjuc/wtrHPkmhoJVZn2kGJKbVyDMEBroWuC16FFk0uifhUmu4OJiJw
         XMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=8BodsD7dsVnt+VzHAjG94w3biZzppe7s1NeC4YW3R/c=;
        b=uGtDZdX+cgZoBNK+TresM4BwO4LTKU3xSpvtNS9wlOqZx40WUBjmE5m3SFTGMlOImk
         4gg0yiGY1d/MxeAA7AWMWctKrJrZ7k86ldyw5FESfvl/LZ4jZbtzg33jdlNjcru7VYcW
         uk7ZlA/v62ACklV43gOLSQAYFQfh726QLm74tuhZE2FFdBsrE2JG110RfcG26Fxtdn6p
         Wae7eqjLFC9a0Ynl46wMbE3RnF8vX550rCWIT7ezvRLxLCtoymvcmZMiU3sDP1YPoYms
         pQur/8Mr91Ugpc4b2uIG9PPe4lXldJpod0vQIqvdzTYTuZOCwkM7boCi9ktM6JufxuVQ
         8D2g==
X-Gm-Message-State: AOAM532cUqt0SAO3uhqVh/2eYKUiXwVE+JW9OBCUk2jORxyHxIXPaTFc
        51rX3n+7FwDbk43tHnqJa7OwRQ==
X-Google-Smtp-Source: ABdhPJyUHvY7mzJVm4QtHCpeu+1+8bU5WDlgupz5L/Udp3YcSBGJJ/qR+2++lKVjcX5LitTuRPqOwQ==
X-Received: by 2002:a63:f959:: with SMTP id q25mr25786650pgk.104.1617041814663;
        Mon, 29 Mar 2021 11:16:54 -0700 (PDT)
Received: from ?IPv6:2600:1010:b06a:1311:e806:6d31:5a5:2c5c? ([2600:1010:b06a:1311:e806:6d31:5a5:2c5c])
        by smtp.gmail.com with ESMTPSA id mp21sm212574pjb.16.2021.03.29.11.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 11:16:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
From:   Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Date:   Mon, 29 Mar 2021 11:16:52 -0700
Message-Id: <5F98327E-8EC4-455E-B9E1-74D2F13578C5@amacapital.net>
References: <CAJvTdK=QbPRtZ9zPgu8c9tqxOtaG3apo7u4BBTXP0--qVWA5ig@mail.gmail.com>
To:     Len Brown <lenb@kernel.org>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Mar 29, 2021, at 8:47 AM, Len Brown <lenb@kernel.org> wrote:
>=20
> =EF=BB=BFOn Sat, Mar 27, 2021 at 5:58 AM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
>>> On Fri, Mar 26, 2021 at 11:39:18PM -0400, Len Brown wrote:
>>> Hi Andy,
>>> Say a mainline links with a math library that uses AMX without the
>>> knowledge of the mainline.
>=20
> sorry for the confusion.
>=20
> mainline =3D main().
>=20
> ie. the part of the program written by you, and not the library you linked=
 with.
>=20
> In particular, the library may use instructions that main() doesn't know e=
xist.

If we pretend for a bit that AMX were a separate device instead of a part of=
 the CPU, this would be a no brainer: something would be responsible for ope=
ning a device node or otherwise requesting access to the device.=20

Real AMX isn=E2=80=99t so different. Programs acquire access either by sysca=
ll or by a fault, they use it, and (hopefully) they release it again using T=
ILERELEASE. The only thing special about it is that, supposedly, acquiring a=
nd releasing access (at least after the first time) is quite fast.  But hold=
ing access is *not* free =E2=80=94 despite all your assertions to the contra=
ry, the kernel *will* correctly context switch it to avoid blowing up power c=
onsumption, and this will have overhead.

We=E2=80=99ve seen the pattern of programs thinking that, just because somet=
hing is a CPU insn, it=E2=80=99s free and no thought is needed before using i=
t. This happened with AVX and AVX512, and it will happen again with AMX. We *=
still* have a significant performance regression in the kernel due to screwi=
ng up the AVX state machine, and the only way I know about any of the detail=
s is that I wrote silly test programs to try to reverse engineer the nonsens=
ical behavior of the CPUs.

I might believe that Intel has figured out how to make a well behaved XSTATE=
 feature after Intel demonstrates at least once that it=E2=80=99s possible. =
 That means full documentation of all the weird issues, no new special cases=
, and the feature actually making sense in the context of XSTATE.  This has n=
ot happened.  Let=E2=80=99s list all of them:

- SSE.  Look for all the MXCSR special cases in the pseudocode and tell me w=
ith a straight face that this one works sensibly.

- AVX.  Also has special cases in the pseudocode. And has transition issues t=
hat are still problems and still not fully documented. L

- AVX2.  Horrible undocumented performance issues.  Otherwise maybe okay?

- MPX: maybe the best example, but the compat mode part got flubbed and it=E2=
=80=99s MPX.

- PKRU: Should never have been in XSTATE. (Also, having WRPKRU in the ISA wa=
s a major mistake, now unfixable, that seriously limits the usefulness of th=
e whole feature.  I suppose Intel could release PKRU2 with a better ISA and d=
eprecate the original PKRU, but I=E2=80=99m not holding my breath.)

- AVX512: Yet more uarch-dependent horrible performance issues, and Intel ha=
s still not responded about documentation.  The web is full of people specul=
ating differently about when, exactly, using AVX512 breaks performance. This=
 is NAKked in kernel until docs arrive. Also, it broke old user programs.  I=
f we had noticed a few years ago, AVX512 enablement would have been reverted=
.

- AMX: This mess.

The current system of automatic user enablement does not work. We need somet=
hing better.=
