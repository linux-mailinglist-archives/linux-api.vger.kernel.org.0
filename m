Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E99E847
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfD2RD0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 13:03:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35394 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbfD2RD0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 13:03:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so5373284plp.2
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t78kRyibN119sX6XaoF9LHRnGVjGQAvmGDpS+vaSbaM=;
        b=WWFnOAaWMWJi8Y87MDOhYg3uT20LX29yUkkQFwloZur/2CX+8XKG3L2r7voIDSH2Ew
         cLt0i1gR2cw2+mWSPDfcDR1Rf1UGXjCnmtlHVexo5B5+NJNedFfPkPIBirWXc/EyfJ79
         NKafsSqDIIZPAAYg5Vraipp8pEVsu4LhaUOpsgwvdmAIBvKvbRMumD1lBMyuibJhE0B7
         P6ioDOWFx7Tgiqa7Etq2SI5cmlmxU4fespoPE89jpXoIYouw0rtqZ21Qma9TRRqMCXyq
         snKJ66cwNiq4nGrkji9xRgOc5VWjrtf1APv/UdUZ3o5kH5bW1H2yL1Jd5MTq71XjdP+X
         fk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t78kRyibN119sX6XaoF9LHRnGVjGQAvmGDpS+vaSbaM=;
        b=m82Fyv7njHbk+rieJ2Dal7mX8dkxotYmtklcTYKgtprZANAUgcBwYNBaLuRYQOj4JQ
         /0NV/Y2Te5JDyKielKH8en2OZL40+JQsx5SA9w4rkWfd4vh5J69nF3g5ZiMNhveRJW2x
         ozCwbfPLi3AKJsOTKOr1joXzUmScWK3p/rfV8ciiG0BxWnZlHN+p6MzkT91Lfia2f3mc
         wAGieZ70h5CsS1cecNPCa8YKXF5DD5C7/OJLxCIdvOol4fa1csOKu2CJdnjQdFDdEJO7
         +iwpMMYRvZiB1hutJylNv7Vy4Dq3ByRQHq0WpKvYsjYUXOZGywoNe6hW+G1wFy5erQnX
         VlLQ==
X-Gm-Message-State: APjAAAVlFrhADWymCjUX3mXbBVxvbGR6Ah2KRNJZUMZ+Vuqv4m5eeqtx
        9WYSFJyvgtybNiOQV3YvkMb/f88UHCnnrw6kOl/NEw==
X-Google-Smtp-Source: APXvYqw1M3eWxi/pFaO7kKJ5I3ulUBc9PTeuZHQQhY1Rvu+AoD5/ctqo73qV8GYax06T5JS5A99G43tYWVrAxxEI9xQ=
X-Received: by 2002:a17:902:b595:: with SMTP id a21mr23126393pls.13.1556557404902;
 Mon, 29 Apr 2019 10:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com> <20190429152803.7719-13-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190429152803.7719-13-mathieu.desnoyers@efficios.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Apr 2019 10:03:13 -0700
Message-ID: <CAKwvOdnbH0+ju5Ny-mB-Z4kC+ALyCJOU4Q8OCLHHjFAQzJqsXA@mail.gmail.com>
Subject: Re: [PATCH for 5.2 12/12] rseq/selftests: add -no-integrated-as for clang
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 8:29 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Ongoing work for asm goto support from clang requires the
> -no-integrated-as compiler flag.
>
> This compiler flag is present in the toplevel kernel Makefile,
> but is not replicated for selftests. Add it specifically for
> the rseq selftest which requires asm goto.
>
> Link: https://reviews.llvm.org/D56571
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Nick Desaulniers <ndesaulniers@google.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Joel Fernandes <joelaf@google.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Dave Watson <davejwatson@fb.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Shuah Khan <shuah@kernel.org>
> CC: Andi Kleen <andi@firstfloor.org>
> CC: linux-kselftest@vger.kernel.org
> CC: "H . Peter Anvin" <hpa@zytor.com>
> CC: Chris Lameter <cl@linux.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Michael Kerrisk <mtk.manpages@gmail.com>
> CC: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
> CC: Paul Turner <pjt@google.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Josh Triplett <josh@joshtriplett.org>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Maurer <bmaurer@fb.com>
> CC: linux-api@vger.kernel.org
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  tools/testing/selftests/rseq/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index c30c52e1d0d2..d6469535630a 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -1,5 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
> -CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
> +
> +ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
> +CLANG_FLAGS += -no-integrated-as
> +endif
> +
> +CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
> +         $(CLANG_FLAGS)

The top level Makefile exports $(CLANG_FLAGS), which should contain
`-no-integrated-as`.  Is that available here?  If so, then you can
just add `$(CLANG_FLAGS)`, no compiler check needed.

If not, maybe the test for CONFIG_CC_IS_CLANG is cleaner?

Thanks for the patch, and helping test asm goto in Clang!
-- 
Thanks,
~Nick Desaulniers
