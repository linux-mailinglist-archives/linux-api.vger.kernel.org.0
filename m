Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C7D241FF5
	for <lists+linux-api@lfdr.de>; Tue, 11 Aug 2020 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHKSuh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Aug 2020 14:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgHKSuh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 11 Aug 2020 14:50:37 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD23320786
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597171837;
        bh=bHJDMU0rLbfo8cYDMgt+G2+hN4y5s20JWP641OKcUdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eqgXAg3tJSKfnyBd2azKFYti0md97OdpjiDAp6m1SLfpdiNDp4gsaZtNfR4WutaPA
         UQIibY8ed8CeJtkADBqhr10runJYokKrwP0ysFS4/5dBEePH3tHiiSc+xazgZ7r8qb
         JLZ8z00DI0Gadljn18O8MIr4Mk/A1N0jlQVAQUN0=
Received: by mail-wr1-f48.google.com with SMTP id f1so12445337wro.2
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 11:50:36 -0700 (PDT)
X-Gm-Message-State: AOAM5317+/qTUntoxacPHHSgslCk5a4Jf8fy86MPOJzcMd8kEM/7uSZb
        YFvn8+6dAbGFMQJZgjfxJz4iiks/ViiuCYhxdZ9RBA==
X-Google-Smtp-Source: ABdhPJy/pZfOOeh9Xxs01sqtbOcHGxwDvVIBnnDSBxJyAXZ/5Sv+YCslqmHw/me/SfQdLJ7oARyUCNXa9f+53WFTGx0=
X-Received: by 2002:a5d:400e:: with SMTP id n14mr7069333wrp.75.1597171835374;
 Tue, 11 Aug 2020 11:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200810232636.1415588-1-krisman@collabora.com> <20200810232636.1415588-4-krisman@collabora.com>
In-Reply-To: <20200810232636.1415588-4-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Aug 2020 11:50:23 -0700
X-Gmail-Original-Message-ID: <CALCETrVOW+L-SuLrb8KwxWS=ZeDdt5qPv8dALHh6Rmcp1KxU0Q@mail.gmail.com>
Message-ID: <CALCETrVOW+L-SuLrb8KwxWS=ZeDdt5qPv8dALHh6Rmcp1KxU0Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] x86: vdso: Expose sigreturn address on vdso to the kernel
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 10, 2020 at 4:26 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Syscall user redirection requires the signal trampoline code to not be
> captured, in order to support returning with a locked selector while
> avoiding recursion back into the signal handler.  For ia-32, which has
> the trampoline in the vDSO, expose the entry points to the kernel, such
> that it can avoid dispatching syscalls from that region to userspace.

Almost looks good.

> +int arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)

If you make that bool instead of int, feel free to add:

Acked-by: Andy Lutomirski <luto@kernel.org>
