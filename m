Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B085E1FD102
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2020 17:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgFQP36 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Jun 2020 11:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgFQP36 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 17 Jun 2020 11:29:58 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E5B4208C3
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592407797;
        bh=27jdkWmDRhhCwAMVdzVBNUCaMhK3ANLmpo6tDzme/RY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m8E4I8fP6RGkvsWHgoknUnkuc8ycHHihswytSXi0vOMfarjSX/vKNYOQbZCYirpJ6
         c+x6u/nfAEbMdakQHJLhYn22GlGz0CY8+uK6fcid7nztrcpcl2vBDSjexLE/SY95fS
         Eseay/9LVF+5kSGvGguIjHnmw9OocqZ+PR3tQd00=
Received: by mail-wm1-f45.google.com with SMTP id f185so2465899wmf.3
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 08:29:57 -0700 (PDT)
X-Gm-Message-State: AOAM532F9Pe/fs1Sp2lhrrbqlek6yRxWUM2YEMiapJVYMhbSaiwvg+OE
        CVHeTorMA/7xm8HL4qo/Hlt2XyoR0uFuzGsR31bo7g==
X-Google-Smtp-Source: ABdhPJyj+JMcQ7Phb3gXIEZj015gqcyGEenjatOi3367DXj7oRIdA90no7VMeGQFL4GMEzknHcaRDz+kzB4C7HZbXAQ=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr8801236wma.36.1592407795664;
 Wed, 17 Jun 2020 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-4-keescook@chromium.org> <CAG48ez0-jSSaw85=ku35UM3vMe98Vz97B68LsUoNd8ftwpunkQ@mail.gmail.com>
In-Reply-To: <CAG48ez0-jSSaw85=ku35UM3vMe98Vz97B68LsUoNd8ftwpunkQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Jun 2020 08:29:44 -0700
X-Gmail-Original-Message-ID: <CALCETrUTsPHt4P=bWB-8r7bbpvgXXu3VBf4TS9S=XYxqxVt=DA@mail.gmail.com>
Message-ID: <CALCETrUTsPHt4P=bWB-8r7bbpvgXXu3VBf4TS9S=XYxqxVt=DA@mail.gmail.com>
Subject: Re: [PATCH 3/8] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 17, 2020 at 8:25 AM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Jun 16, 2020 at 9:49 AM Kees Cook <keescook@chromium.org> wrote:
> > For systems that provide multiple syscall maps based on architectures
> > (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via CONFIG_COMPAT), allow
> > a fast way to pin the process to a specific syscall mapping, instead of
> > needing to generate all filters with an architecture check as the first
> > filter action.
>
> This seems reasonable; but can we maybe also add X86-specific handling
> for that X32 mess? AFAIK there are four ways to do syscalls with
> AUDIT_ARCH_X86_64:

You're out of date :)  I fixed the mess.

commit 6365b842aae4490ebfafadfc6bb27a6d3cc54757
Author: Andy Lutomirski <luto@kernel.org>
Date:   Wed Jul 3 13:34:04 2019 -0700

    x86/syscalls: Split the x32 syscalls into their own table



>
> 1. normal x86-64 syscall, X32 bit unset (native case)
> 2. normal x86-64 syscall, X32 bit set (for X32 code calling syscalls
> with no special X32 version)

Returns -ENOSYS now if an x32 version was supposed to be used.

> 3. x32-specific syscall, X32 bit unset (never happens legitimately)

Returns -ENOSYS now.

> 4. x32-specific syscall, X32 bit set (for X32 code calling syscalls
> with special X32 version)
>
> (I got this wrong when I wrote the notes on x32 in the seccomp manpage...)
>
> Can we add a flag for AUDIT_ARCH_X86_64 that says either "I want
> native x64-64" (enforcing case 1) or "I want X32" (enforcing case 2 or
> 4, and in case 2 checking that the syscall has no X32 equivalent)? (Of
> course, if the kernel is built without X32 support, we can leave out
> these extra checks.)

No extra checks needed.  Trying to do a syscall with a wrongly-encoded
x32 nr just generates -ENOSYS now.

Henceforth, all new syscalls will have the same number for native and
x32 and will differ only in the presence of the x32 bit.

--Andy
