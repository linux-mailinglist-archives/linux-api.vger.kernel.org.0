Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BC531A479
	for <lists+linux-api@lfdr.de>; Fri, 12 Feb 2021 19:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhBLSVF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Feb 2021 13:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBLSVE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Feb 2021 13:21:04 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088CFC061574
        for <linux-api@vger.kernel.org>; Fri, 12 Feb 2021 10:20:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id g9so53747ilc.3
        for <linux-api@vger.kernel.org>; Fri, 12 Feb 2021 10:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxSJSmRLq1aFDkk7sXLF73Mw0WDfSPOa/cBn9MZ26PU=;
        b=viwhcZp12Cg1IJsi0b3tmh9ciF+hxbmsfq6nWmrFn9JqEOjwIgoNE77Yl+MMCrpr+K
         LZfElCxAgofItYSUtJGQfowazsiTxNYNqqUQThhkalPUrZy6d0/D/k4o1BkR4XlkTxHh
         zcTNuyPJm9GectFyVUJF09w5J0+dRaP/kZyf3WSsJhyhCLznMVuozZ6EY4cwl7QbfDan
         +cZ3MaNiLr5GP3Pz4xXtzVnIZG+cobaius5w/RN/74wKY98Q7ML4yka+OAdyuntMggQe
         RwaBHY0w1u3reZI2Af3CmcUikZJ2NDlJk2cfLAwWFhcKv7ysgeqSdQVdr0H9P8ZdMaKU
         YBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxSJSmRLq1aFDkk7sXLF73Mw0WDfSPOa/cBn9MZ26PU=;
        b=O1Fk5dQHULhuVzuyqUJE1J4HkAQj0pSSIzvTtbmiWg1E68xzuULqakKIauRQEQXKUr
         3F3s+qE783Q58NdN7aUa/o8exQRTS/mAn1qhmoaSaBMgVN7THt6j/bFL+L5TBvbB80Sn
         Vv4XwSTz+Tl5GUB0GcMwpZolgDnaNQG88ZtTLCdkJL6Igz8ukriYb7j9apTc+Qu+xi3s
         VSueBZ1cXveFxIE1d0PAkL8KAwG17A5t8mlRDjL96Z1uQP8kPpjWPxTvo/KmBCUjomT6
         QsFOkEtIltPBYDTR7r5ZprPoA7SMXKKdBeeHL8uSLK89GA0YUCSni+MKBvcmkCPL4rgt
         ZtsQ==
X-Gm-Message-State: AOAM533ykyuMkdsyIU6pgrgDv3S/qhvpN4+gT0c6QJ+NX8eEnGJMqSQR
        +dlYZqdOLl59QGlNM7wBi7EJ/a6TPU344sprQEvBgw==
X-Google-Smtp-Source: ABdhPJxdaQK1Pebo+XgNYailbCbPTpXKGqyxsbSXwv2oCpD7A8EUK1aaNXqHcW0PKQr7Xn/jkj2HJdYRZTVgAg/zauw=
X-Received: by 2002:a05:6e02:1be6:: with SMTP id y6mr3211839ilv.145.1613154024344;
 Fri, 12 Feb 2021 10:20:24 -0800 (PST)
MIME-Version: 1.0
References: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
 <e3977b3e1b548be1d9554ccfad6c83ac87802583.1609311499.git.pcc@google.com>
 <20210126130947.GD29702@willie-the-truck> <CAMn1gO4OGsYYXBAWk=OiauZoyHoPFR9znSeLfXV0rLoZ+H7j1A@mail.gmail.com>
 <c314e144-26d7-d80c-ce83-5fd597a8f772@arm.com>
In-Reply-To: <c314e144-26d7-d80c-ce83-5fd597a8f772@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 12 Feb 2021 10:20:13 -0800
Message-ID: <CAMn1gO5DZ2qW1u9mMhqsC49xndb8WJFmwKX_Ua-5t-yj5jcDMg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: pac: Optimize kernel entry/exit key
 installation code paths
To:     James Morse <james.morse@arm.com>
Cc:     Will Deacon <will@kernel.org>, libc-alpha@sourceware.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 12, 2021 at 3:01 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Peter,
>
> On 12/02/2021 05:01, Peter Collingbourne wrote:
> > On Tue, Jan 26, 2021 at 5:09 AM Will Deacon <will@kernel.org> wrote:
> >>
> >> On Tue, Dec 29, 2020 at 10:59:15PM -0800, Peter Collingbourne wrote:
> >>> The kernel does not use any keys besides IA so we don't need to
> >>> install IB/DA/DB/GA on kernel exit if we arrange to install them
> >>> on task switch instead, which we can expect to happen an order of
> >>> magnitude less often.
> >>>
> >>> Furthermore we can avoid installing the user IA in the case where the
> >>> user task has IA disabled and just leave the kernel IA installed. This
> >>> also lets us avoid needing to install IA on kernel entry.
> >>
> >> I've got to be honest, this makes me nervous in case there is a way for
> >> userspace to recover the kernel key even though EnIA is clear. Currently,
> >> EnIA doesn't affect XPAC* and PACGA instructions, and the architecture
>
> > For GA I would expect it to be controlled by a hypothetical EnGA, not
> > by EnIA (and I'm a bit surprised that there isn't an EnGA;
>
> PACGA is undefined if the CPU doesn't implement PAC, whereas PACIASP is a NOP if the CPU
> doesn't implement PAC.
>
> I think the reason from the SCTLR_ELx controls is to make unaware systems transform the
> instructions that were hints back into hints. (e.g. the AddPACIA psuedo code). This is
> needed on mismatched big-little systems, otherwise processes can't be migrated between them.

It's needed for more than that, see the history of my
PR_PAC_SET_ENABLED_KEYS patch, in particular [1].

> For the non-hint instructions, user-space needs to test the hwcap/id-register-emulation to
> know it can use these instructions, and the compiler shouldn't output them unconditionally.

Right, unless the target is known to support them.

> > doesn't it
> > mean that a userspace program running under an unaware kernel or
> > hypervisor may sign things using the GA from potentially another
> > hypervisor guest?)
>
> The hypervisor controls all this with HCR_EL2.API, which also traps PACGA et al.
> For the hypervisor its all or nothing.
> If the hypervisor is emulating a machine without PAC, it can emulate an undefined
> exception regardless of whether the CPU supports PAC or not.
>
> Does this match your reading?

I think that's right. So an unaware hypervisor would set API to 0 and
none of the guests would be able to use the authentication
instructions. Since it looks like API=0 would make the hint-space
instructions trap as well, I would imagine that a hypervisor would
need to emulate them as no-ops if it's emulating a machine without
PAC.

Peter

[1] https://www.spinics.net/lists/arm-kernel/msg830889.html
