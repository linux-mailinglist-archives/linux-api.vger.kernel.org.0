Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9672B6D06
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 19:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbgKQSR3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 13:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731153AbgKQSRY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 13:17:24 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434DAC0617A7
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 10:17:23 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so22150282ioo.7
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttXeKrhKcMls8e2meNyf1Yp9vx4Qupy+215G4JEYgyE=;
        b=kFD6q3+HmeywJk3p/3WSefExg0/XQO2Fmy/godmWhmRmj1Pyh/vrHRHpXC8cJvC92Z
         ZOe6RnmTJ8XzrWAXkCjNiXJ8hmTFZHwgtM+DhquqW47rbhw++lpI9XeMiIwePR4PD1PL
         dqMMtda/+EuW0o8bHb4CblAuqWis7mXf+egTqGVodWSUVgG5TsFmze3hrwGqeZag0ck9
         wEmCuHQlbne6XutwFVl7tFfC1SA5sWXBY+2Mft8l+kcIYYsiw0sxmYg7G6Xkak+0b/Hr
         gt+uMpQj0qsQwZluvg6xiqVa/HMjP+cIoU2OTVeEfLsdueIM6Vj7uCb7jyF/Akj6VDGI
         nT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttXeKrhKcMls8e2meNyf1Yp9vx4Qupy+215G4JEYgyE=;
        b=eiOmnTjr8GH1kGwmeJujT0G5xrdrGL5CJJpMdfFJFp8FBKY2GdHzTp7Vk/R4HMPuJT
         CVhspnx1Mmk/8Kq2bcH/CBBcaebKUaJ5JjUUTtqd27s+nTmvF3uCyIIcdWF0XL+vUKe2
         K8i61+s8NBK/3NkJe7VR/A0mQ3HETI6vjGBuSprv6J3X8yenAk5mRTN/x9U9zNXiSOr6
         eMEr29aVvHHxb8VZBftEEVk7Sv9b9BYoLRps5hg0tQwp2Z8pNANw/YrCUS+AYU+LHp9a
         gKbTrpwwYuOwV1VfmxTOx43ZWNS8uRcchS9joyQ47rKj/EDMwWhgdgNxePJFrziK7eSS
         QkCA==
X-Gm-Message-State: AOAM5316+ZCSS49X7xS/OOfFDVnKhOzVT3+GUhfU3N+xuqlYK694KVmF
        yRaFs/3YePBtDqOxVnBi4qvZxLgykx8bwVHXFr3Esg==
X-Google-Smtp-Source: ABdhPJwJkTaHobAIO358KOOx6EVeXkRqDl2senlYO+76iU8R/dOi/Rm3jLJYK4cqZPNpt+Q/Uz+Yj4G7YWF7pX9dv+Y=
X-Received: by 2002:a5d:9cc7:: with SMTP id w7mr12383475iow.202.1605637042319;
 Tue, 17 Nov 2020 10:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20201014055106.25164-1-pcc@google.com> <87blfv6fj3.fsf@mid.deneb.enyo.de>
In-Reply-To: <87blfv6fj3.fsf@mid.deneb.enyo.de>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 17 Nov 2020 10:17:11 -0800
Message-ID: <CAMn1gO7a-uyP93P4KapbsXy1+HRSuJR4r_kyy0_-FCY69qO_nA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        libc-alpha@sourceware.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 17, 2020 at 9:48 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Peter Collingbourne:
>
> > This prctl allows the user program to control which PAC keys are enabled
> > in a particular task. The main reason why this is useful is to enable a
> > userspace ABI that uses PAC to sign and authenticate function pointers
> > and other pointers exposed outside of the function, while still allowing
> > binaries conforming to the ABI to interoperate with legacy binaries that
> > do not sign or authenticate pointers.
> >
> > The idea is that a dynamic loader or early startup code would issue
> > this prctl very early after establishing that a process may load legacy
> > binaries, but before executing any PAC instructions.
>
> I thought that the silicon did not support this?

See e.g. the documentation for SCTLR_EL1.EnIA [1] for details. There
are also enable bits for the other three keys.

> What exactly does this switch on and off?  The signing itself (so that
> the bits are zero again), or just the verification?

Both the PAC* and AUT* instructions for the specific key become
no-ops, so the bits will be zero.

> I do not know how easy it will be to adjust the glibc dynamic linker
> to this because I expect it to use PAC instructions itself.  (It is an
> interesting target, I suppose, so this makes sense to me.)  The loader
> code used for initial process setup and later dlopen is the same.
> Worst case, we could compile the loader twice.

If you can avoid creating function pointers before the loader has
finished recursively scanning all libraries, and the ABI uses
different keys for function pointers and return addresses, you may be
able to get away with making the decision in the loader. The idea is
that you would disable the function pointer key and leave the return
address key enabled. This would also have the advantage of at least
providing return address protection for some libraries if function
pointer protection can't be enabled.

> There is also an issue with LD_AUDIT, where we run user-supplied code
> (which might be PAC-compatible) before loading code that is not.  I
> guess we could disable PAC by default in LD_AUDIT mode (which is
> unusual, no relation to the kernel audit subsystem).

Yes, LD_AUDIT may be difficult to deal with if it can influence which
libraries are loaded at startup. I agree that LD_AUDIT should disable
PAC by default.

Peter

[1] https://developer.arm.com/docs/ddi0601/d/aarch64-system-registers/sctlr_el1#EnIA_31
