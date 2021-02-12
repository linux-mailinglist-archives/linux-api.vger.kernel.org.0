Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA50E31996A
	for <lists+linux-api@lfdr.de>; Fri, 12 Feb 2021 06:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhBLFBx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Feb 2021 00:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhBLFBw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Feb 2021 00:01:52 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45B9C061756
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 21:01:11 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n201so8094961iod.12
        for <linux-api@vger.kernel.org>; Thu, 11 Feb 2021 21:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MSieHNsEiSJ/wkTUEfcTLoubkdAaikasczh7LitVoE=;
        b=mHaYom7VwxdsPzCDopP87k4FEPyaBfinKnqtUuV93xNymKSIs8ECQxZJeceyZcjMmI
         dNWOlNE95ZKRrwxCB2TF3EzvXNUfZn0aUDavbbub8KRYEofBhawcXYycFsyMkGqEJygR
         ijp/QEYP2aUS432bJ5qMyJcbnDqakeURf46pt7Pdik5aP8a1HWXC+TsGifF2PlMiwhMu
         DwXPLyhWINtoZ2516BZqZzmZFGitlnKsKO4lzDt4aQtdvrlWmCXkmm74FZeWpk3AY95a
         yqA641Uq2T9dfIpdedQrVn6dyM0DinID+IPgrZJbVxtNuuGBu3VA2ywgAYQcrsKtr/fq
         gWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MSieHNsEiSJ/wkTUEfcTLoubkdAaikasczh7LitVoE=;
        b=MAurM7wMjSeZlhxi9KgS4xgozjJul2h4cJN0K3qj9cDMQ8DJVbdENeA0MrakvmPQGA
         TJyD1GJV6UgohrWEZdjzzkn6tLPZWVrXB9uhJ5FoZjatOnSHSvB64MyIYE6nORa4vJTv
         Giouk7R3Lc/UG9DwaJLVzqOHT17RZUrimFzS4K0OwQH6eYSX6Uwces2VE33v4gbyqRHz
         RenSlkSJzqKX3I42begVc4MIK1uE74XNxTgiuLgBEhBSu6PYhX7W0MKxBr3Jpt1942B4
         dKrWXKDnjSciTYqtoKn3A6kysB+8Im+ND0PLovzc5oEiiNHjtCd8N1fJLqJZXGamIrXD
         FMjw==
X-Gm-Message-State: AOAM532m5dB8tRo+quBbX8dL3uvQnDJRqAyE/FuxRMyK+Eyw57GHdu+9
        nkPmqTMJbqGlMlbBPPo4FrG2vVfv5utVdBXbvN2g3Q==
X-Google-Smtp-Source: ABdhPJy4wG3QYsOKseeCcYXQqVUTMmrQjzJEndCvySZIX2UqwjwXrATrpCLwWzm36dfBaESRv/omdjcM51SGGFaOiWk=
X-Received: by 2002:a5d:9f15:: with SMTP id q21mr887390iot.132.1613106071274;
 Thu, 11 Feb 2021 21:01:11 -0800 (PST)
MIME-Version: 1.0
References: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
 <e3977b3e1b548be1d9554ccfad6c83ac87802583.1609311499.git.pcc@google.com> <20210126130947.GD29702@willie-the-truck>
In-Reply-To: <20210126130947.GD29702@willie-the-truck>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 11 Feb 2021 21:01:00 -0800
Message-ID: <CAMn1gO4OGsYYXBAWk=OiauZoyHoPFR9znSeLfXV0rLoZ+H7j1A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: pac: Optimize kernel entry/exit key
 installation code paths
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 26, 2021 at 5:09 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Dec 29, 2020 at 10:59:15PM -0800, Peter Collingbourne wrote:
> > The kernel does not use any keys besides IA so we don't need to
> > install IB/DA/DB/GA on kernel exit if we arrange to install them
> > on task switch instead, which we can expect to happen an order of
> > magnitude less often.
> >
> > Furthermore we can avoid installing the user IA in the case where the
> > user task has IA disabled and just leave the kernel IA installed. This
> > also lets us avoid needing to install IA on kernel entry.
>
> I've got to be honest, this makes me nervous in case there is a way for
> userspace to recover the kernel key even though EnIA is clear. Currently,
> EnIA doesn't affect XPAC* and PACGA instructions, and the architecture

For GA I would expect it to be controlled by a hypothetical EnGA, not
by EnIA (and I'm a bit surprised that there isn't an EnGA; doesn't it
mean that a userspace program running under an unaware kernel or
hypervisor may sign things using the GA from potentially another
hypervisor guest?)

> clearly expects us to be switching these things:
>
>   | Note
>   | Keys are not banked by Exception level. Arm expects software to switch the
>   | keys between Exception levels, typically by swapping the values with zero
>   | so that the current key values are not present in memo
>
> But then:
>
> > On an Apple M1 under a hypervisor, the overhead of kernel entry/exit
> > has been measured to be reduced by 15.6ns in the case where IA is
> > enabled, and 31.9ns in the case where IA is disabled.
>
> That's a good improvement, so this feels like its worth doing. I suppose all we
> can do is keep an eye on the architecture in case any future extensions mean
> the approach taken here is dangerous.

Right. I think it makes sense for any future extensions not to expose
a key in any way if the corresponding key enable bit is clear (to
avoid the potential problem that I highlighted with GA above) unless
the operating system has explicitly opted into such behavior, e.g. by
setting a separate bit in SCTLR_EL1.

Peter
