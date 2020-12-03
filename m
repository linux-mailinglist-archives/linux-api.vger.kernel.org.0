Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD802CD1F3
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 10:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgLCI7Y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 03:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgLCI7Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 03:59:24 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F066C061A4D
        for <linux-api@vger.kernel.org>; Thu,  3 Dec 2020 00:58:44 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id w8so1176494ilg.12
        for <linux-api@vger.kernel.org>; Thu, 03 Dec 2020 00:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rMvlBEF1tDoeRhoSoqMeQE+/ofVUR3pS5vYcuA6SOw=;
        b=JuHzGPMNaUUhhj8Rv76NCQkKr2BCQOXW6skBFchRy+zT4CS7m74fSKRQUZxA4h+nCu
         cYWkSWump1l/se/DTeZzGwyS3TXNM6VG4RiTDV6Vmbigtm2gOhNWiiE8vfuAqgf+81cy
         SqJTD1NAVv04727hPaRNrHoe0HNbnDGn1U3RtiOWVQ25tceQvYSowcge3oTUqpmsoKTi
         nrmmqc7sFejqZhTutiYY0Bebi7NAS4UoynZkKYvxBCVcIhne2Zzi7IXXSf9X6jhGTHrT
         ZsuT+JOyb8x+XNRZflnIpCZwzQ/9tBcR2uegigHDVBB7+r9sIZ/lKMsHCMZ89xG79+k4
         RqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rMvlBEF1tDoeRhoSoqMeQE+/ofVUR3pS5vYcuA6SOw=;
        b=sr1AQeWvfbkoU9bAPLBhGI3P1R+yzEE1VPGIAG9fpefASC+u4d3Q7PmJvqzD9ucprJ
         PkjmeH6ynhARJ7t4n1MJNEvcMdNHOO8XZNa1MgOmSsouAKWU+tXN0+4bz6aQV9DJP8OF
         PGv7ORMpqQ6bC0efecpf7Kf4Fe0ZkRPxpDvfT08nuXtnzR5KRwqFHp1xJH0h+fS2J4r8
         ol7Xm8ryts3vNWRvJyp5YmwLT1nnVa1ThJEe8Wr/QVXgK6eV7xgpEIFY9uczZHrCZLRk
         4r0Fos8flQUmA37QYNsNJg2s//0NT72QTdOL6sLvqUb6/G8h26hGZEgvEVnD4KXklft4
         gwvg==
X-Gm-Message-State: AOAM5322pgTjOs7+w4II3Xcg10AHa4/CFsPN3QpmN8RLOkBnjcS2nfyi
        c8JGMqUIt632Puz3LMvtNOnGDtqNeKwbL+1k+rV4cQ==
X-Google-Smtp-Source: ABdhPJyhdLwFEjVAZ96byTZ6uh8rIXZ6026FwCedBhlvkt/mLhelzCaUQVID9TqfxbDZTwOsYhf1p6nOZPAVw0dc4ZA=
X-Received: by 2002:a92:990e:: with SMTP id p14mr2122147ili.28.1606985923208;
 Thu, 03 Dec 2020 00:58:43 -0800 (PST)
MIME-Version: 1.0
References: <b584bf342a38580daa7aa73eda72184e9453a5e4.1605842067.git.pcc@google.com>
 <160650438443.22092.12368244632759393865.b4-ty@arm.com> <20201130125151.GD3902@gaia>
In-Reply-To: <20201130125151.GD3902@gaia>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 3 Dec 2020 00:58:31 -0800
Message-ID: <CAMn1gO7jvAwfawSqY_MUHqr30ti5aXUr97LiWQmD9U0YxYgK1A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: mte: make the per-task SCTLR_EL1 field
 usable elsewhere
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        libc-alpha@sourceware.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 30, 2020 at 4:51 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Peter,
>
> On Fri, Nov 27, 2020 at 07:13:43PM +0000, Catalin Marinas wrote:
> > On Thu, 19 Nov 2020 19:29:46 -0800, Peter Collingbourne wrote:
> > > In an upcoming change we are going to introduce per-task SCTLR_EL1
> > > bits for PAC. Move the existing per-task SCTLR_EL1 field out of the
> > > MTE-specific code so that we will be able to use it from both the
> > > PAC and MTE code paths and make the task switching code more efficient.
> >
> > Applied to arm64 (for-next/pac-keys-ctrl), thanks!
> >
> > [1/2] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
> >       https://git.kernel.org/arm64/c/e710c29e0177
> > [2/2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
> >       https://git.kernel.org/arm64/c/284c64e9eba3
> >
> > If Dave has any other comments next week, we can apply them on top.
>
> I'm dropping these patches from the arm64 tree as they conflict
> (and not in a trivial way) with the MTE patches queued in the mm tree.
>
> So we either wait until 5.12 or we try to merge them via Andrew on top
> of the mm tree. Given the interaction with MTE, I'm slightly inclined
> towards the former.

Okay, I don't mind waiting until 5.12.

In the process of resolving the conflict I happened to notice a couple
of minor bugs (one in your original MTE patch series and one in this
patch). I sent a patch to fix the former and v5 of this series to
resolve the conflicts and fix the latter.

I also took the opportunity to do some perf measurements with the real
instruction sequences now that I have access to capable hardware, and
I included the results in the commit message.

Peter
