Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB0A2C89
	for <lists+linux-api@lfdr.de>; Fri, 30 Aug 2019 04:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfH3CBw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Aug 2019 22:01:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33453 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfH3CBv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Aug 2019 22:01:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so3492098pfq.0
        for <linux-api@vger.kernel.org>; Thu, 29 Aug 2019 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zO8PdeeIdG1tzfsClmI9LZenmd5UMF2AEWQotpYVtec=;
        b=UV08w7N+5XgxFjTDWXP/3lw1pQs3F9sFih4WmrXbG9U1ct8t9lWf2ogCOxhxXaPehS
         wA24OrTp0v0DshA8cBBQNpF3AssXMiO5fORzdCQ2I6FjT6U3h8F90v8b4SKDURnkPtVO
         GD2Q5lxuwrOUlw6pYPSaTUbpToD/zQuObr2pfLVncswWmB+OdHrGoeAv/VOwUNIcjk0q
         iSgKDDLJwcqC17yibYASvtIH4319ktHSVNtdJt8AJCGwS+y1UqSVCv3Q+zZd6DXBNwyU
         sxVqGBvsnCQ7CsD5cufFmK7FGJRt436S2qTZcBlwtrfB5Ndou5BRp1SAQZ+abIKHc2re
         67Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zO8PdeeIdG1tzfsClmI9LZenmd5UMF2AEWQotpYVtec=;
        b=kyPIfM9Cc1+G4p3WdbzlhRgYiyrT10+kimpYfeBT9ltUg/UgW8d5si+sXPg4LLXoYV
         nGQgOX6FtegGYzUuKRSCny3AMi89oIVXd55a8fcZrJvTj/oL1w3eAh4LdwiVK95EXN5G
         1aTnhPJ3ap3fOnM2Hpy2GvTZ+d/yOqQKe4EYzjXOXlLJBeIUWjd2D68x4ZP2XSOvY2nD
         45vO6Tt8Vy88jIys+fSkNejXQQbGx69DFoVt+JxKUShklMH9yXWCrqFjDXjbwCdoBQDE
         xh/iXR02LrFHcMQsokLfYiuVt9p98vJE36AfD6r9i4t9Fv2sDKAXr5OsM1+A4NyM+TpW
         LjYw==
X-Gm-Message-State: APjAAAWnpkbJ5KhRDH7KKBRFwWJFlwrfz/CzhkzFB+6fSSWyedwqpbiK
        sBeaBQHg4kl11T7v39+gnTPjwg==
X-Google-Smtp-Source: APXvYqxAKUgTUdilFGku6rp2i6CciI9SDnT1shayBd62iyV14FjbrqVjZQH30hIzVPpbyDHjOrfotQ==
X-Received: by 2002:a65:6281:: with SMTP id f1mr10331899pgv.400.1567130511065;
        Thu, 29 Aug 2019 19:01:51 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3184:4148:fbd:376a? ([2601:646:c200:1ef2:3184:4148:fbd:376a])
        by smtp.gmail.com with ESMTPSA id c5sm4502562pfo.175.2019.08.29.19.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 19:01:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/7] Rework random blocking
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <20190830014906.GD10779@mit.edu>
Date:   Thu, 29 Aug 2019 19:01:49 -0700
Cc:     Andy Lutomirski <luto@kernel.org>, Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B9BEDD92-7EE4-40C9-96D2-389D32B8D040@amacapital.net>
References: <cover.1567126741.git.luto@kernel.org> <20190830014906.GD10779@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Aug 29, 2019, at 6:49 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
>> On Thu, Aug 29, 2019 at 06:11:35PM -0700, Andy Lutomirski wrote:
>> This series also removes the blocking pool and makes /dev/random
>> work just like getentropy(..., 0) and makes GRND_RANDOM a no-op.  I
>> believe that Linux's blocking pool has outlived its usefulness.
>> Linux's CRNG generates output that is good enough to use even for
>> key generation.  The blocking pool is not stronger in any material
>> way, and keeping it around requires a lot of infrastructure of
>> dubious value.
>=20
> It's too late for the 5.4 cycle for a change of this magnitude, and
> I'd just as soon let this wait until *after* the LTS kernel gets cut.
> The reason for this is because at the moment, there are some PCI
> compliance labs who believe that the "true randomness" of /dev/random
> is necessary for PCI compliance and so they mandate the use of
> /dev/random over /dev/urandom's "cryptographic randomness" for that
> reason.  A lot of things which are thought to be needed for PCI
> compliance that are about as useful as eye of newt and toe of frog,
> but nothing says that PCI compliance (and enterprise customer
> requirements :-) have to make sense.
>=20
> It may be that what we might need to really support people (or stupid
> compliance labs) who have a fetish for "true randomness" to get a
> better interface for hardware random number generators than
> /dev/hwrng.  Specifically, one which allows for a more sane way of
> selecting which hardware random number generator to use if there are
> multiple available, and also one where we mix in some CRNG as a
> whitening step just case the hardware number generator is busted in
> some way.  (And to fix the issue that at the moment, if someone evil
> fakes up a USB device with the USB manufacturer and minor device
> number for a ChosKey device that generates a insecure sequence, it
> will still get blindly trusted by the kernel without any kind of
> authentication of said hardware device.)
>=20
> That probably means we need to come up with a new interface than
> /dev/hwrng, or have some way of configuring /dev/random to use a
> hardware RNG device for those people who really care about "true
> randomness".  The current /dev/hwrng interface and how it is
> configured via sysfs is pretty baroque IMO.
>=20
>                    =20

Hmm. Does this really need to be in the kernel?  ISTM it should be straightf=
orward to write a little CUSE program that grabs bytes from RDSEED or RDRAND=
, TPM, ChaosKey (if enabled, with a usb slot selected!), and whatever other s=
ources are requested and, configurable to satisfy whoever actually cares, mi=
xes some or all with a FIPS-compliant, provably-indististinguishable-from-ra=
ndom, definitely not Dual-EC mixer, and spits out the result.  And filters i=
t and checks all the sources for credibility, and generally does whatever th=
e user actually needs.

And the really over-the-top auditors can symlink it to /dev/random.

Do the PCI folks actually care that it=E2=80=99s in the kernel?


As an aside, the first two patches could plausibly land before the rest of t=
he series if that seems appropriate.=
