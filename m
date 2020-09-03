Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B363D25B79F
	for <lists+linux-api@lfdr.de>; Thu,  3 Sep 2020 02:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgICAe0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Sep 2020 20:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgICAeX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 Sep 2020 20:34:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D6C061247
        for <linux-api@vger.kernel.org>; Wed,  2 Sep 2020 17:34:21 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e23so1265931eja.3
        for <linux-api@vger.kernel.org>; Wed, 02 Sep 2020 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zuE9S2kX3yBdAXx6VDq5nZON6IsB7oZg0hs9UuY921M=;
        b=tIkG82mnDBNJywHLRaI6/zVNwcstLoIiktcOv/j/drukTe3Yyf8awFxGW8oN7DprMj
         /nBjEF6hZNuvXxJvt99XuFKiiKoQaLXsnOU1IBa1RWC5BfCawHRiB9URI5005NpDX6xs
         L5pO6G6KT/PwCl6jgRVxuSsy80FZ3M+y1beOsg72cbOVQkMFozp03IbLPQm3197YaODp
         j0tABAaAuD4XEAUNNNpGNZsVAkglNMIs7s3ZL5q3AcE827mQrUOf11oKHpzGuqSqYqjw
         MS5Dlac5YTP4IPqx2IgZcTW3WaTfLmK8pVI+og5WhZ5rgXi+NbEF/kFwqQ0pGpEzW+nt
         qu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuE9S2kX3yBdAXx6VDq5nZON6IsB7oZg0hs9UuY921M=;
        b=rIPYfKdcLRyA5EmaQBg2rmSO9wLqDa0d/QPtOB74yMLGjxIRp4t8q4m32E17H2SVG2
         UAxrFIaZ2YLA4C1ds6qlulEz/rma0ueej0CX78R7dPMtAhlgE6psB0HrngcG1bB4autK
         fFfMqI5qcUlfEXHMKGSTNtwVc1QZzH3Ioz9yke4SUQrbzvsMMy728HU6MAdaQYXwalEh
         qZLaHXwvSKjBdki7xc2gSKy9H4QHLyxbfn8L6OnT8JYi+dt5gJs2L6XSDmGiUpuKyEZF
         vuwfIIy/qLTCKaRUcnLScM/CmMmi1jbMnc0ykszgf/5b6o+toCNfG2ALYkg1LBMGxrX7
         0NNg==
X-Gm-Message-State: AOAM532/uZT+Fg+o+kWNVQsNfOJ4xpjBOoHZluH1xalRtj7Hr52OKxSt
        bl0y+e/VCsbUGTE9o5yGA66EF5HIj8Q5OVNjk2rWwQ==
X-Google-Smtp-Source: ABdhPJxdALR4cm0WRdFm1nV86J6GOCE81MxM9fhMvtNjRqZTT/V2g4OhtuHQC3P0OGbQ/uCHIDae7gU9e8mz5iXDE4M=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr747386ejc.114.1599093259495;
 Wed, 02 Sep 2020 17:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002645.3658-1-yu-cheng.yu@intel.com> <20200825002645.3658-7-yu-cheng.yu@intel.com>
 <CAG48ez21a_afHJrRQeweuHu8c+fxJ+VN1dezD18UOtZA5q-Shg@mail.gmail.com> <9be5356c-ec51-4541-89e5-05a1727a09a8@intel.com>
In-Reply-To: <9be5356c-ec51-4541-89e5-05a1727a09a8@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 3 Sep 2020 02:33:53 +0200
Message-ID: <CAG48ez2_8BwG5xnwevniVODAM7oHWxGSY7zyg8gdKcWbzZ9YNQ@mail.gmail.com>
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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

On Thu, Sep 3, 2020 at 12:13 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> On 9/2/2020 1:03 PM, Jann Horn wrote:
> > On Tue, Aug 25, 2020 at 2:30 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >> Add REGSET_CET64/REGSET_CET32 to get/set CET MSRs:
> >>
> >>      IA32_U_CET (user-mode CET settings) and
> >>      IA32_PL3_SSP (user-mode Shadow Stack)
> > [...]
> >> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
> > [...]
> >> +int cetregs_get(struct task_struct *target, const struct user_regset *regset,
> >> +               struct membuf to)
> >> +{
> >> +       struct fpu *fpu = &target->thread.fpu;
> >> +       struct cet_user_state *cetregs;
> >> +
> >> +       if (!boot_cpu_has(X86_FEATURE_SHSTK))
> >> +               return -ENODEV;
> >> +
> >> +       fpu__prepare_read(fpu);
> >> +       cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> >> +       if (!cetregs)
> >> +               return -EFAULT;
> >
> > Can this branch ever be hit without a kernel bug? If yes, I think
> > -EFAULT is probably a weird error code to choose here. If no, this
> > should probably use WARN_ON(). Same thing in cetregs_set().
> >
>
> When a thread is not CET-enabled, its CET state does not exist.  I
> looked at EFAULT, and it means "Bad address".  Maybe this can be ENODEV,
> which means "No such device"?

Yeah, I guess ENODEV might fit reasonably well.
