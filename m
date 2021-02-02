Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E215B30B3ED
	for <lists+linux-api@lfdr.de>; Tue,  2 Feb 2021 01:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBBAMg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Feb 2021 19:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhBBAMa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Feb 2021 19:12:30 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4A7C061573
        for <linux-api@vger.kernel.org>; Mon,  1 Feb 2021 16:11:48 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id x21so19433541iog.10
        for <linux-api@vger.kernel.org>; Mon, 01 Feb 2021 16:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKsK9UXrWRkf7WKSYGvLRPQ3/a8epKY1v2M3Ao0BxKM=;
        b=I1ZGxFDyZcFWxV6Ds8hHfU/EM46jOeOfxAF/uMT6OlWDQJtegjXcFpdui3jy/Y4oKZ
         BdbQXmKniU4Z48rsLMCDTzW25a8TZylpL2TTKvC/xERkYCR0goT/JcpCtUDURyfuv3Ko
         hDdNwwkeseIYnCCNOQSg4L8WxVTmj11XhEq7PXE/Xcgxq3NK8Y3gyMrUEmJfRiORosdZ
         N/FgYVLgUsorrW3ngeziFrIB9waGjSr6D3uXxCdScQCsZ0YFV/VEaPxouuLc4fI/H3Pa
         vs+tvG9YMHCvBa7htqLw7SeK7is11HzPf4O6l1K2D83pnYv9sjOqwnv3nD+Em5mv1PYP
         998Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKsK9UXrWRkf7WKSYGvLRPQ3/a8epKY1v2M3Ao0BxKM=;
        b=i4CGKrMGqv7lx7zRQ87F2b42BzoLPAeqqEP2F1mtWcki3lYmu9MZJupbC6e/yw4pXL
         feA+BkHIXg+1ixsy6BOlT8zUVzetkQ1EiWvvaGMiKUJuXqzLkFTpJQzl99qWy/uKA9Tl
         NQQu1Nn3r4aRU52b/EjdpAexrqJsNjp0PpZhPZFG2BP7u45oJ8viPFmLXpUN6WH05Jha
         xrkk3QY0YMW1HOA0LaHfuGSI8LZeC3+hx0te53KRzWX2RCERuTIACyQ2JKiRGdZ50h/s
         sbvxSzBIRxcqT2QFoNInoZXk6QO7eb0xWaO8ql4WeaGmq0Ga8MWM63cMUSjs3L78ZwZM
         3itw==
X-Gm-Message-State: AOAM533USWTqfioSq86AWYk+6+3ivKtqKzjKyMwW3K8AvdljqVuRJXbT
        JN4Bgckej1PAZu119WQsJeRRmUBtuT7xn05G/YGnGw==
X-Google-Smtp-Source: ABdhPJw8t84Nqko8w+nRZe50q+bIRNXYTkSLBEvg0qYVT9qBoQm0QPzyL6KSs7DG/Qw+m9ASuPKpueKnNDkP63fzwXM=
X-Received: by 2002:a05:6638:69b:: with SMTP id i27mr16915782jab.143.1612224708358;
 Mon, 01 Feb 2021 16:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20210201194012.524831-1-avagin@gmail.com>
In-Reply-To: <20210201194012.524831-1-avagin@gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 1 Feb 2021 19:11:12 -0500
Message-ID: <CABV8kRzg1BaKdAhqXU3hONhfPAHj6Nbw0wLBC1Lo7PN1UA0CoA@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] arm64/ptrace: allow to get all registers on
 syscall traps
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        Dave Martin <Dave.Martin@arm.com>, Kyle Huey <khuey@pernos.co>,
        "Robert O'Callahan" <roc@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrei,

> This series introduces the PTRACE_O_ARM64_RAW_REGS option. If it is set,
> PTRACE_GETREGSET returns values of all registers, and PTRACE_SETREGSET
> allows to change any of them.

thanks for picking this up. I meant to work on this, but unfortunately ran out
of time to be able to push it through, so I'm glad you're working on
it, since it
does absolutely need to get fixed. Besides this issue, the other problem we
ran into when trying to port our ptracer to aarch64 is that orig_x0 is not
accessible through the ptrace interface on aarch64, which can cause tricky
behavior around restarts. We managed to work around that in the end,
but it's painful. If we're fixing the kernel here anyway, I'm wondering if
we might want to address that as well while we're at it.

Keno
