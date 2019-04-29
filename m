Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DDE39E
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 15:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfD2NWT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 09:22:19 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41841 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2NWT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 09:22:19 -0400
Received: by mail-qk1-f194.google.com with SMTP id l199so5862772qke.8;
        Mon, 29 Apr 2019 06:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxj1FCipKcklarY6Q+hJsPo8HKtT8eDMF/LowfJ48xw=;
        b=Sbt8zt5d/mefsrGhBrLCyCxx0ScBdXzomZnTqffwL8ee/2jJxZmIugIfbvJ/amxNH2
         CuWYUv2wD5PeuSDLqncG+cFqtzjg/5hmzI1QUCy+kqzIYFv0PuFq3hVbWMCCA72BAck5
         KSGECbiZTd8gYMGA7jMjHUGY0QtNN2xPt4t+nt6JBzcZZpWC4NJzvwpuUcrE1mAR51Bm
         NPTLV/7eL2APotZt5g69Thn44L2avZuLRqNZTqByo3KwoFcNXrl6fT53jpm7iIkIK8Jp
         bGi2x5a4cSih9GFpTIoyAuqeZoIAoy7zJRJ6JS+G9o0IFKlwckWqhpB+n5w3U57BDXKl
         LQeg==
X-Gm-Message-State: APjAAAVptRK3oDUEjovUIxLSPNAMjCkrO9M/UWiyEjiruiiCTDHBWqcc
        Ea41oRxF4+XouMPmZSiG3o1DdgLYXrHFbUub8Dw=
X-Google-Smtp-Source: APXvYqzA00hWBDMEberomQeBoApVfyufrjCPcagiQ+CrJXNsKP6fBHPvkVE+n4jTzMcf6/hgw0GZ+JNqgRHhjJk6HYc=
X-Received: by 2002:ae9:ee15:: with SMTP id i21mr43735948qkg.107.1556544138476;
 Mon, 29 Apr 2019 06:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190426142531.1378357-1-arnd@arndb.de> <alpine.DEB.2.21.1904290933130.1626@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904290933130.1626@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Apr 2019 15:22:02 +0200
Message-ID: <CAK8P3a2UVqg--Xs29o55QbsRKu-ynN8ZXR96Phiq2cuCoABvGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] y2038: make CONFIG_64BIT_TIME unconditional
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Stepan Golosunov <stepan@golosunov.pp.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 9:34 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 26 Apr 2019, Arnd Bergmann wrote:
>
> > As Stepan Golosunov points out, we made a small mistake in the
> > get_timespec64() function in the kernel. It was originally added under
> > the assumption that CONFIG_64BIT_TIME would get enabled on all 32-bit
> > and 64-bit architectures, but when I did the conversion, I only turned
> > it on for 32-bit ones.
> >
> > The effect is that the get_timespec64() function never clears the upper
> > half of the tv_nsec field for 32-bit tasks in compat mode. Clearing this
> > is required for POSIX compliant behavior of functions that pass a
> > 'timespec' structure with a 64-bit tv_sec and a 32-bit tv_nsec, plus
> > uninitialized padding.
> >
> > The easiest fix for linux-5.1 is to just make the Kconfig symbol
> > unconditional, as it was originally intended. As a follow-up,
> > we should remove any #ifdef CONFIG_64BIT_TIME completely.
> >
> > Link: https://lore.kernel.org/lkml/20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru/
> > Cc: Lukasz Majewski <lukma@denx.de>
> > Cc: Stepan Golosunov <stepan@golosunov.pp.ru>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Please apply this one as a bugfix for 5.1
>
> Can you provide a 'Fixes: ....' tag please?

Ok, resent both patches now. I also took the chance to add a clarification
for the point that Lukasz missed on the first submission.

       Arnd
