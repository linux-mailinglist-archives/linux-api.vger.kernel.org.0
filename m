Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16782250D7F
	for <lists+linux-api@lfdr.de>; Tue, 25 Aug 2020 02:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgHYAcv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Aug 2020 20:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgHYAct (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 24 Aug 2020 20:32:49 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB8602177B
        for <linux-api@vger.kernel.org>; Tue, 25 Aug 2020 00:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598315569;
        bh=HzNRSUeUL6OriNoi411G8DjwqUuqi7JFl1V+hmvfPWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uRWu1h/pRTe38+cnhWVoUjMTGyUxj4FX6LHXPmQOHohc0UiMAuVFXRFfGvQuUXiFU
         x0m9GY1EjwLb2Vn/RymkjG2w7e8cfbzAb7e02+yOOlT1W3LXR000Pr7kw4RnV+6ZXj
         WrQB1im2A7usG0ceNRnrso4/XUttJEJC2aZHtYTM=
Received: by mail-wm1-f41.google.com with SMTP id c19so579267wmd.1
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 17:32:48 -0700 (PDT)
X-Gm-Message-State: AOAM53156OPMtvObyD5jLTEqXJStIuW2cvGsa31Ry4lGSs/BX+U5vL1s
        4+oqY9wdGJrfNsNV7daIS1JbwADXn9xmOzJXDKHtMg==
X-Google-Smtp-Source: ABdhPJyauPayFdftcuPZnq0MJTSphzvI2x0UgLNn081J3B9GZfktgEGZliAmuQJq8JPRJLx6kwBNbrs1VoFPRwDiqF4=
X-Received: by 2002:a7b:ca48:: with SMTP id m8mr1581098wml.36.1598315567552;
 Mon, 24 Aug 2020 17:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002645.3658-1-yu-cheng.yu@intel.com> <20200825002645.3658-10-yu-cheng.yu@intel.com>
In-Reply-To: <20200825002645.3658-10-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Aug 2020 17:32:35 -0700
X-Gmail-Original-Message-ID: <CALCETrVXwUDu2m-XEd-_J03L=sricM4cMxQYVkdGRWZDjmMB2g@mail.gmail.com>
Message-ID: <CALCETrVXwUDu2m-XEd-_J03L=sricM4cMxQYVkdGRWZDjmMB2g@mail.gmail.com>
Subject: Re: [PATCH v11 9/9] x86: Disallow vsyscall emulation when CET is enabled
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 24, 2020 at 5:30 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> Emulation of the legacy vsyscall page is required by some programs built
> before 2013.  Newer programs after 2013 don't use it.  Disallow vsyscall
> emulation when Control-flow Enforcement (CET) is enabled to enhance
> security.

NAK.

By all means disable execute emulation if CET-IBT is enabled at the
time emulation is attempted, and maybe even disable the vsyscall page
entirely if you can magically tell that CET-IBT will be enabled when a
process starts, but you don't get to just disable it outright on a
CET-enabled kernel.
