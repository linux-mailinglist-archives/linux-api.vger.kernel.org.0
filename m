Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AACBEBA4
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfD2Ua1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 16:30:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33584 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfD2Ua1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 16:30:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so4780858plp.0
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoZD/dNKX5WgAZZR7UrYB8wzOfrnR6MIY38MQG1fU9I=;
        b=HuFJyw7mcBSICXvwxdh6PMU9X3LJLUHpU9+bKmS9D3HjBjD776G0OSDEufj+PWdErx
         k+PyxOOFQOv4gIG3lXqz8OPtk+h5QV9gyLoysdsdq29yCYbFcRy2Lcl69wcmmoVdCLpe
         FlsNPdnOMLUXYepIRQZiaczXsQNBazRJMZ0M16estlF4q8C0e6bWl/rw3sku1cg3LAG6
         /hr2t34gB65l0tdPv6Jcz9kv0WhOVgBjfreNS4WifOA0gMfDBQgOGsQTS8cNMEW8Ovlq
         kemmEstg9YzsRssiopg3wv6x0o1paj4jb7lHf1m7hxUMUWiGesyu03sKiVEM3kPLdQFl
         poeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoZD/dNKX5WgAZZR7UrYB8wzOfrnR6MIY38MQG1fU9I=;
        b=Y5GyJx73w72a39NIU1zwjfcEhsqnU52DUNNaFwX44IyxrWVVpvxhM7M/YABWDZ6y2i
         2pCoHkvTPj68WxNas7x7Neqfcqr3f0Co4lmEceTjT9daPZBCglDXoVMcSxfDvhhtHmuv
         Fwdb080yJmaEUpJH4rZfFFjppZp4ZZNiSpCR403G2+AmOzT/SbvuluQRPkV8//rUXc0A
         NfxUEl9Ir2r7IrwDwVs5FiJeElQnfYrY1wyGakslfYO3x7uaz+c9qjHBEY0P52EqY3L7
         PTe8DnFaV3E07bc0VWC4YCKyQYDDgzzmlRI+MJas906/S0IGbiJtnqnmoCXxiJzagxhv
         bqOg==
X-Gm-Message-State: APjAAAUs9ugJJgqq7zj95lJtZ7AWTMo8ZI3KsiNydz7F404yBbmnJim0
        6tVSNrgi5IGS8lGkQufMkHpbCVMnl81E3XWTgugBNw==
X-Google-Smtp-Source: APXvYqxhr41z/hs2DekvYrX7RAFq341c0UsIKJJmbvYU/vfug6dUJri8bpSYOLqVcpo5BkOuZml7Dc4pFEKcsYeeoUo=
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr63915997plc.320.1556569825937;
 Mon, 29 Apr 2019 13:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
 <20190429152803.7719-13-mathieu.desnoyers@efficios.com> <CAKwvOdnbH0+ju5Ny-mB-Z4kC+ALyCJOU4Q8OCLHHjFAQzJqsXA@mail.gmail.com>
 <712082435.384.1556569697998.JavaMail.zimbra@efficios.com>
In-Reply-To: <712082435.384.1556569697998.JavaMail.zimbra@efficios.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Apr 2019 13:30:14 -0700
Message-ID: <CAKwvOdk1bUgczvUr3OVttFZ4ArO6fSEz6_enPmu+GDDy1yTrTQ@mail.gmail.com>
Subject: Re: [PATCH for 5.2 12/12] rseq/selftests: add -no-integrated-as for clang
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     shuah <shuah@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 1:28 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 29, 2019, at 1:03 PM, ndesaulniers ndesaulniers@google.com wrote:
>
> > On Mon, Apr 29, 2019 at 8:29 AM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >> diff --git a/tools/testing/selftests/rseq/Makefile
> >> b/tools/testing/selftests/rseq/Makefile
> >> index c30c52e1d0d2..d6469535630a 100644
> >> --- a/tools/testing/selftests/rseq/Makefile
> >> +++ b/tools/testing/selftests/rseq/Makefile
> >> @@ -1,5 +1,11 @@
> >>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
> >> -CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
> >> +
> >> +ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> >> +CLANG_FLAGS += -no-integrated-as
> >> +endif
> >> +
> >> +CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
> >> +         $(CLANG_FLAGS)
> >
> > The top level Makefile exports $(CLANG_FLAGS), which should contain
> > `-no-integrated-as`.  Is that available here?  If so, then you can
> > just add `$(CLANG_FLAGS)`, no compiler check needed.
>
> AFAIU, the makefiles under tools/testing/selftests all end up including
> tools/testing/selftests/lib.mk, which states:
>
> "# This mimics the top-level Makefile. We do it explicitly here so that this
>  # Makefile can operate with or without the kbuild infrastructure."
>
> So I don't think it's using any of the definitions from the toplevel
> Makefile.
>
> > If not, maybe the test for CONFIG_CC_IS_CLANG is cleaner?
>
> A quick test indicates that the toplevel CONFIG_* definitions are unavailable
> from the kernel selftests makefiles.

Ok, in that case...
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Thanks again!

-- 
Thanks,
~Nick Desaulniers
