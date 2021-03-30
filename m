Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179FA34F20F
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 22:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhC3UVF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Mar 2021 16:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhC3UUa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Mar 2021 16:20:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05925C061574
        for <linux-api@vger.kernel.org>; Tue, 30 Mar 2021 13:20:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x26so12967726pfn.0
        for <linux-api@vger.kernel.org>; Tue, 30 Mar 2021 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+fvRCak5nT+7vsNsQ37FYFv5hB/hQM4I7Onizfja+Yk=;
        b=dyo9hBcc2uhiFNIDb0P+xc3bKZmmyInA4bas7pmqj5KCVLdG2TYPs1dPhOUYmJjRm2
         L8OX3M1ux4vxu3HbgUbSgVEokkRlNJ+9i8fvotEGIs8JZInGNe+3WEjmExm7boqErQvm
         Dlj8mdvz3MpgGdFlVD7dpz/uwGarh6a43aGmosqomfy87p0D2V4h3r/g0fA8Tj1sYqbw
         LIsj0coVi3FX4C/H6UFMTPZtzJLsWO72OBZUCV8Hsl8RSip1p6gyK5V8XhdQPTu6Xwt6
         6/k1qgIQiij81yo7yqzX3mvU1HFiHBRAfDy0ydobg9JP+aW/S1KP2cmzGH0EJKcxWuNo
         Zvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+fvRCak5nT+7vsNsQ37FYFv5hB/hQM4I7Onizfja+Yk=;
        b=q6aQLwoC20ZDO7sD80USJolSgBHhiw20wOWnT5EmBzpx64St83iwtjbJnRULcrEVsg
         c734fC6d7Ifjo/HrpUdFpFy38FRaepBaUVkb2xaCWdrDZaLKEd4ibIiKdSUuZukK4Ewh
         BO1TcldKJAGOTyqBCZHXo/gCDosiMob7pDVD+YG939NWz0JO8K9pVj3i/EZ9roi5XQw1
         WXZcqLas9hOVP/3F0a64FDGyePGB3e/DOXMlJYlyaMzMXyVTke5pXOgonR1OiySCm3vg
         wxDmoD2Z/o9enXGcNnHQOaJF81MwAQiyOfCCZdB5vQaY0JETVFD5FUxgqxTU3sKaTZLA
         kk9Q==
X-Gm-Message-State: AOAM530tsnAlXN+SnQIrd1J3MrI4SAib187Q8nTwikcbpkxMdDEArVfU
        6hZFaKZvQU3YkrfZs0IqKXJKrQ==
X-Google-Smtp-Source: ABdhPJwhMEkJzZ2fRP0OkCkDNZAazep5N/gSflrritdECzKkpf7jn2nsGX7tEg0YrqAN2rK4PvL83w==
X-Received: by 2002:a63:545e:: with SMTP id e30mr30841258pgm.13.1617135629521;
        Tue, 30 Mar 2021 13:20:29 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:30aa:f41a:f3f5:d36b? ([2601:646:c200:1ef2:30aa:f41a:f3f5:d36b])
        by smtp.gmail.com with ESMTPSA id v25sm21757167pfn.51.2021.03.30.13.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 13:20:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
Date:   Tue, 30 Mar 2021 13:20:27 -0700
Message-Id: <F2653B18-239A-42BB-84EE-04F18B712279@amacapital.net>
References: <d10affcb-d315-cebc-4162-084f0a1e4d43@intel.com>
Cc:     Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <d10affcb-d315-cebc-4162-084f0a1e4d43@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Mar 30, 2021, at 12:12 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 3/30/21 10:56 AM, Len Brown wrote:
>> On Tue, Mar 30, 2021 at 1:06 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
>>>> On Mar 30, 2021, at 10:01 AM, Len Brown <lenb@kernel.org> wrote:
>>>> Is it required (by the "ABI") that a user program has everything
>>>> on the stack for user-space XSAVE/XRESTOR to get back
>>>> to the state of the program just before receiving the signal?
>>> The current Linux signal frame format has XSTATE in uncompacted format,
>>> so everything has to be there.
>>> Maybe we could have an opt in new signal frame format, but the details w=
ould need to be worked out.
>>>=20
>>> It is certainly the case that a signal should be able to be delivered, r=
un =E2=80=9Casync-signal-safe=E2=80=9D code,
>>> and return, without corrupting register contents.
>> And so an an acknowledgement:
>>=20
>> We can't change the legacy signal stack format without breaking
>> existing programs.  The legacy is uncompressed XSTATE.  It is a
>> complete set of architectural state -- everything necessary to
>> XRESTOR.  Further, the sigreturn flow allows the signal handler to
>> *change* any of that state, so that it becomes active upon return from
>> signal.
>=20
> One nit with this: XRSTOR itself can work with the compacted format or
> uncompacted format.  Unlike the XSAVE/XSAVEC side where compaction is
> explicit from the instruction itself, XRSTOR changes its behavior by
> reading XCOMP_BV.  There's no XRSTORC.
>=20
> The issue with using the compacted format is when legacy software in the
> signal handler needs to go access the state.  *That* is what can't
> handle a change in the XSAVE buffer format (either optimized/XSAVEOPT,
> or compacted/XSAVEC).

The compacted format isn=E2=80=99t compact enough anyway. If we want to keep=
 AMX and AVX512 enabled in XCR0 then we need to further muck with the format=
 to omit the not-in-use features. I *think* we can pull this off in a way th=
at still does the right thing wrt XRSTOR.

If we go this route, I think we want a way for sigreturn to understand a poi=
nter to the state instead of inline state to allow programs to change the st=
ate.  Or maybe just to have a way to ask sigreturn to skip the restore entir=
ely.=
