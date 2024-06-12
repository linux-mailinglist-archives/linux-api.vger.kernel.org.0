Return-Path: <linux-api+bounces-1728-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 176DA905A24
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 19:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC621F240AE
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DC617DE0F;
	Wed, 12 Jun 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOEGFuFE"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60C1CD38
	for <linux-api@vger.kernel.org>; Wed, 12 Jun 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214437; cv=none; b=oW7n0weBImCzPKuxglrC5+veSkFXpE7GCQTfdFzARMLwj5XJPMsUAZos/anKNkgHZIsST3gQi+ZtNsgBTqoZ5Qd0X+Jg1fvklGOJ+w1R/Jn6RpsMqxAg/eRLR7kOOphYolOCn7y4o2drfMzivHk8kdit/T9nap4tgn61U3ltdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214437; c=relaxed/simple;
	bh=yQaCFIOSreG4dB3HESrGO2r8ZFtVH9AGcf4g3223SlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXmgbFx+Txr7END74/XKI9n2Z/x0vFg19J3hVsdFdLSO8DmvrHl6B0wgxF+XFSLLXr1eYag29p0yn6+WAxk7v+XSagWvAFW9jVeRN8nQurrJa5Tps6DmHxQ0bVep6Isfc/HitSuSYxtBErcSUwBtzGywAoSfjppwl+euB9wpBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mOEGFuFE; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso129000276.3
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2024 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718214435; x=1718819235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9K/YgRhZtFx7uthgN6OITo7kLPMlwArLIjPMt98hbo=;
        b=mOEGFuFEY9XB1AVEOa6Uw9qQBlg67OcjvVWlt3XMJRKH9/VEZznu2pkUa++bw22HmX
         TAsDAOmW08sN758NzWLXshu9EujZ6WiT66MtsTxVuiPkKuGaoepDBNTw+1z8Md4YyPN+
         6COZCrLTCSENtfx9uVhgCmELdRd3pFWrYoGT0MBPrkjPFVlhp+hO/ab4GET21VpfGKem
         jlPo0tGv9ViK/Gw+bAVS8YkpT3RhALabdJ1zXNX2PikEeJRDYQarIkQV57CF5qIysiFv
         3/njB5WuvRmQJjeTLsT6bORrSiH2o6jxpHfqU3u5hbJMjobBbhXwPxBrCf/4SiY7o9DF
         HsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718214435; x=1718819235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9K/YgRhZtFx7uthgN6OITo7kLPMlwArLIjPMt98hbo=;
        b=KdcUIOkjw6pwCH1aCpMSK6eAKUQkqJgTA+F8g7kKFqKb7wSbD8Rz+SqRpeVHb8KWb1
         KVs6XpaRgq+WIITbmS6blMc3cWAPx6wpgjVdlYEc7hk5YND4H3bnykc0OyNULZVCs064
         XkPNDzUjaVPLvCFSv8DiAsAUdDdXn2D6ifkAthoI+MmAiiTK+4Ex2mE+OVpUr0boOsi6
         P6UqS0X2413ZRowcsWzcd2Q0iFocIk43Owirr35/ucYFjmWh21DpmGxDIo4yKBnFcpsT
         q9k1vEsg+YUUUEdmv48JRBJarsfbPa9a3ueq9Azz37UqjdsiHG6KPiXN2Xr3hN5b660O
         Dhvw==
X-Forwarded-Encrypted: i=1; AJvYcCU9nOZZ7G+MUuaRiEs0xKU7ai5QIp62h8j/HD/umC4A7xdddrvdFCOz9fGLoeBqz8rVRqVAc7zcQymz2/kKz0ietTQnjI0W9Zc5
X-Gm-Message-State: AOJu0YyxRfnysIQaIJk3vpYPQaP0tMcXNgNTpEblMxmZFSa8P8sHcY98
	tnqoNebhjD6FJnZOObXKL/DULYSpRR3AxLwikuLTnbX2w1sUgwYHHaod/CMs/m/eZwf2Evi3uy7
	29u6tcFybmDc/SMKBN4N/YSaV74kUmJqz71c1
X-Google-Smtp-Source: AGHT+IG/ICa75l9zohCG4/2lItGuALPXT0N9Ucn9xhcsPivipbrVZ9ARL2AfAdTNET6da3WCkbrVegcDfHhFQDbE2yA=
X-Received: by 2002:a25:3044:0:b0:dfb:85a:5e23 with SMTP id
 3f1490d57ef6-dfe6852dde0mr2104434276.44.1718214434980; Wed, 12 Jun 2024
 10:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu> <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
In-Reply-To: <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
From: enh <enh@google.com>
Date: Wed, 12 Jun 2024 13:47:03 -0400
Message-ID: <CAJgzZorNc3gNVbiibz+DibrMLxc2dQoOS5NtL+RQUkSD-GMYaA@mail.gmail.com>
Subject: Re: termios constants should be unsigned
To: Alejandro Colomar <alx@kernel.org>
Cc: Paul Eggert <eggert@cs.ucla.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, libc-alpha@sourceware.org, 
	linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 12:29=E2=80=AFPM Alejandro Colomar <alx@kernel.org>=
 wrote:
>
> Hi Paul,
>
> On Wed, Jun 12, 2024 at 07:55:14AM GMT, Paul Eggert wrote:
> > On 2024-06-12 05:16, Alejandro Colomar wrote:
> > > tcgets.c:53:24:
> > >   error: implicit conversion changes signedness: 'int' to 'tcflag_t' =
(aka
> > >   'unsigned int') [clang-diagnostic-sign-conversion,-warnings-as-erro=
rs]
> >
> > This is a bug in Clang not glibc, and if you're worried about it I sugg=
est
> > sending a bug report to the Clang folks about the false positive.
> >
> > Even GCC's -Wsign-conversion, which is at least smart enough to not war=
n
> > about benign conversions like that, is too often so chatty that it's be=
st
> > avoided.
> >
> > A lot of this stuff is pedanticism that dates back to the bad old days =
when
> > the C standard allowed ones' complement and signed magnitude representa=
tions
> > of signed integers. Although it can be amusing to worry about that
> > possibility (I know I've done it) it's never been a practical worry, an=
d
> > even the motivation of pedanticism is going away now that C23 requires =
two's
> > complement.
>
> I know; I think I have -Weverything enabled in that run, which is known
> for its pedanticity.  I usually disable it when it triggers a warning,
> since they are usually nonsense.  But in this case, adding U is a net
> improvement, without downsides (or I can't see them).

well, any change like this is a potential source incompatibility ... i
hacked these changes into AOSP, and it did break one bit of existing
code that was already working around the sign differences --- this
warning was enabled but the code had a cast to make the _other_ side
of the comparison signed (rather than make this side of the comparison
unsigned).

Android's libc [bionic] uses the uapi headers directly, so we would be
affected, but to be clear --- i'm fine with this if the consensus is
to go this way.

(but, yeah, i'm with the "how about we fix the language and compiler
rather than all the extant code?" sentiment from Paul Eggert.)

> So, while the kernel and glibc are just fine with this implicit
> conversion, they would be equally fine and even better without the
> conversion.  Not a bug, but rather a slight improvement.
>
> Have a lovely day!
> Alex
>
> --
> <https://www.alejandro-colomar.es/>

