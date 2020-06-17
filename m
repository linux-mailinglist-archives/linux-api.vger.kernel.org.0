Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53CB1FD10B
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2020 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFQPc3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Jun 2020 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFQPc2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Jun 2020 11:32:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E70C06174E
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 08:32:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so3396924ljh.7
        for <linux-api@vger.kernel.org>; Wed, 17 Jun 2020 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l32XRyEkePlebWnUae8i7rcm+cLkXuxHO0S9jd5PcS8=;
        b=sSpczcE6lMjOla0Qq7Ojd8fn4tDSWBrhMmLDDt6LJ86Y9mjbQV+bTQXs9ttXlzP4j6
         kbP2DWE/BTuY4ZH4z2UoHE/D5Jj6eentsfqgd+Z7BrEVUdToZJhvZGbLyWrjbNkkK+hU
         CquzCzK5nJvm44QjUxLVvNdw6EDRR42+qHY4xHcMCKUv2aNHRlMxEMZ2vgU+oDZT2j7s
         aHEu6RVQo91uJ/ZRi4J/bntJVWz8VDfVO9ZuRCll0hoHo0KvtsN0OG6rk19jkQYPFLOe
         6TSwCIE1a9yX0Dp6wEJkiLCMlX/avsVKvOWBggMzfFxk9XYZKknnkyDOu++F6eSC8j1p
         T2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l32XRyEkePlebWnUae8i7rcm+cLkXuxHO0S9jd5PcS8=;
        b=k2SKIn2RSm3FROe8fICKNGZL8NecvJZlArSh/gpqyzerLSnfDDhSwAEPrP3TDmOX0i
         fAAWlQ/+4065YVVcxziCDHFHeEzJx0FqZz1BcKec5NtWT3elafglIfQ8/CnQ+2DO3Glo
         yGfcO1RMhrSYAhV7mC6rOKtGtBn7TIkmxPQI1V3GfHfzlVZheYrvYkhWnJ304t8C4JdU
         Lu7UCCWlCwSPnAREABCe4vVkRHkR+S4UEfUZO3ln2pp9/k5WQ+0/V+yT4TGR1mvCkTc6
         XSXOd3OC/tb0KjNaU7EGykuWfu6hh5c8NKdzG6YP7VXRbbq1o4GuKjzH2E4VLMQXFXbV
         eoIw==
X-Gm-Message-State: AOAM5305uMCc9E2RD3t71xRAYbkOPkX/csifXfEyv1f12JuxcGqEgE3y
        udXYmh2MuHVWCM/IyStGZ7OAETjqjz0SwDyrjqcCEw==
X-Google-Smtp-Source: ABdhPJyauhbkn3VnOnpdJHtl3A9kM8iVF5IJzfX+GgrITFSBm3aQ4wPhFZD6DFnpmXCZvji7QIuycv8yUAKBuu+HrkY=
X-Received: by 2002:a2e:541e:: with SMTP id i30mr3989852ljb.156.1592407945965;
 Wed, 17 Jun 2020 08:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org>
 <20200616074934.1600036-4-keescook@chromium.org> <CAG48ez0-jSSaw85=ku35UM3vMe98Vz97B68LsUoNd8ftwpunkQ@mail.gmail.com>
 <CALCETrUTsPHt4P=bWB-8r7bbpvgXXu3VBf4TS9S=XYxqxVt=DA@mail.gmail.com>
In-Reply-To: <CALCETrUTsPHt4P=bWB-8r7bbpvgXXu3VBf4TS9S=XYxqxVt=DA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 17 Jun 2020 17:31:59 +0200
Message-ID: <CAG48ez23QKhv4CGPTgGAhCVM8KUCm-wWy2H6EV2Sc9nz0Hmckg@mail.gmail.com>
Subject: Re: [PATCH 3/8] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
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

On Wed, Jun 17, 2020 at 5:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Jun 17, 2020 at 8:25 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 9:49 AM Kees Cook <keescook@chromium.org> wrote:
> > > For systems that provide multiple syscall maps based on architectures
> > > (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via CONFIG_COMPAT), allow
> > > a fast way to pin the process to a specific syscall mapping, instead of
> > > needing to generate all filters with an architecture check as the first
> > > filter action.
> >
> > This seems reasonable; but can we maybe also add X86-specific handling
> > for that X32 mess? AFAIK there are four ways to do syscalls with
> > AUDIT_ARCH_X86_64:
>
> You're out of date :)  I fixed the mess.
>
> commit 6365b842aae4490ebfafadfc6bb27a6d3cc54757
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Wed Jul 3 13:34:04 2019 -0700
>
>     x86/syscalls: Split the x32 syscalls into their own table

Oooooh, beautiful. Thank you very much for that.
