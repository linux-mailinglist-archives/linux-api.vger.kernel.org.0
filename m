Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A57E371800
	for <lists+linux-api@lfdr.de>; Mon,  3 May 2021 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhECPaI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 May 2021 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhECPaH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 May 2021 11:30:07 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504EC06174A
        for <linux-api@vger.kernel.org>; Mon,  3 May 2021 08:29:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v191so4387958pfc.8
        for <linux-api@vger.kernel.org>; Mon, 03 May 2021 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=2V3HYq3YbH5eZIxZs7nKcsCMHCZy6Xq7DA+V46SoNmI=;
        b=TpPnf3bolYDVSjJPRDR8FjKGu85pfRv77SBJZBQHoYEbphH6DRrCLMsD3dOCctjAnL
         wYvu3jVE2AQewOxDy3vbfn34JxTgO54FuX0FukEmGBlfMPgi/OwJRDW8pwT8TYvQLPIa
         SAxm3wjxi7gZbV7CyGYGyYJ7J8VFqd+lGgJA5S/dnsskEew6z4LDbJqlNSWLZW7VQcQw
         XE8cpOE0KyYGVnmLW0WdupKeoC3QvggNovzlgSezkkAQc1nuKa8GFvy0zhhielqXmimy
         /B82tbcges+mfMiayPFZ6b3WCcwAP4Tzfr3NKzRg7CsvpOwm8JdBdR2efMIQ8UrLRsFm
         7CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2V3HYq3YbH5eZIxZs7nKcsCMHCZy6Xq7DA+V46SoNmI=;
        b=PYBOGTURJ03myXHqr7t7CtAKjaDCoxBgIpuzHvKrSB4h4j2ZcJPm5yTCSkO/DiDpnl
         tCPLOG81yz+TuiLn3jMK5JQV1alaY35ZRCGjhyhJi+FqDuOXR9w5GtdaYtAepMlQ5kr+
         9GDjWqoGDZAnqyI7lgBY2Hh4uc9YGJ2wZ7F6Zn9555WS33jgXNYt7exF1iJV+fG0BMw8
         Z9Om9ye6Mqo04sHNr6UXlaT1lHBe5hNBBtCwfqi4vbul69cErWalvo4J1iDou41FPb49
         9ShjyEO4yHJJ4w5bADjapXqwcJy9uZBN5sckwL+nJMVdlTXzArrnU7a/TnPFVNkcDOoz
         VJRg==
X-Gm-Message-State: AOAM531bo3wQF0cCbCAFM37qsy8N2QWp0E6/zKZiAq9T3IG2jlu6XXuF
        6BxF8746/bLgUyIJEdPWJWcqrg==
X-Google-Smtp-Source: ABdhPJzUqbXM/URmBF8ZSKH3HSbo8rHKVMg/k9x+YM8ZCOfN/FE0pEJH6vDM7iXTKEJD89xzJexv7A==
X-Received: by 2002:a62:1888:0:b029:262:de45:b458 with SMTP id 130-20020a6218880000b0290262de45b458mr19722073pfy.20.1620055753894;
        Mon, 03 May 2021 08:29:13 -0700 (PDT)
Received: from smtpclient.apple ([2601:646:c200:1ef2:1960:85f5:fe97:e8ac])
        by smtp.gmail.com with ESMTPSA id l3sm17757773pju.44.2021.05.03.08.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:29:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: extending ucontext (Re: [PATCH v26 25/30] x86/cet/shstk: Handle signals for shadow stack)
Date:   Mon, 3 May 2021 08:29:11 -0700
Message-Id: <2D8926E4-F1B6-433A-96EA-995A66F3F42D@amacapital.net>
References: <782ffe96-b830-d13b-db80-5b60f41ccdbf@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
In-Reply-To: <782ffe96-b830-d13b-db80-5b60f41ccdbf@intel.com>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
X-Mailer: iPhone Mail (18E199)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On May 3, 2021, at 8:14 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>=20
> =EF=BB=BFOn 5/2/2021 4:23 PM, Andy Lutomirski wrote:
>>> On Fri, Apr 30, 2021 at 10:47 AM Andy Lutomirski <luto@kernel.org> wrote=
:
>>>=20
>>> On Fri, Apr 30, 2021 at 10:00 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wr=
ote:
>>>>=20
>>>> On 4/28/2021 4:03 PM, Andy Lutomirski wrote:
>>>>> On Tue, Apr 27, 2021 at 1:44 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wr=
ote:
>>>>>>=20
>>>>>> When shadow stack is enabled, a task's shadow stack states must be sa=
ved
>>>>>> along with the signal context and later restored in sigreturn.  Howev=
er,
>>>>>> currently there is no systematic facility for extending a signal cont=
ext.
>>>>>> There is some space left in the ucontext, but changing ucontext is li=
kely
>>>>>> to create compatibility issues and there is not enough space for furt=
her
>>>>>> extensions.
>>>>>>=20
>>>>>> Introduce a signal context extension struct 'sc_ext', which is used t=
o save
>>>>>> shadow stack restore token address.  The extension is located above t=
he fpu
>>>>>> states, plus alignment.  The struct can be extended (such as the ibt'=
s
>>>>>> wait_endbr status to be introduced later), and sc_ext.total_size fiel=
d
>>>>>> keeps track of total size.
>>>>>=20
>>>>> I still don't like this.
>>>>>=20
>>>>> Here's how the signal layout works, for better or for worse:
>>>>>=20
>=20
> [...]
>=20
>>>>>=20
>>>>> That's where we are right now upstream.  The kernel has a parser for
>>>>> the FPU state that is bugs piled upon bugs and is going to have to be
>>>>> rewritten sometime soon.  On top of all this, we have two upcoming
>>>>> features, both of which require different kinds of extensions:
>>>>>=20
>>>>> 1. AVX-512.  (Yeah, you thought this story was over a few years ago,
>>>>> but no.  And AMX makes it worse.)  To make a long story short, we
>>>>> promised user code many years ago that a signal frame fit in 2048
>>>>> bytes with some room to spare.  With AVX-512 this is false.  With AMX
>>>>> it's so wrong it's not even funny.  The only way out of the mess
>>>>> anyone has come up with involves making the length of the FPU state
>>>>> vary depending on which features are INIT, i.e. making it more compact=

>>>>> than "compact" mode is.  This has a side effect: it's no longer
>>>>> possible to modify the state in place, because enabling a feature with=

>>>>> no space allocated will make the structure bigger, and the stack won't=

>>>>> have room.  Fortunately, one can relocate the entire FPU state, update=

>>>>> the pointer in mcontext, and the kernel will happily follow the
>>>>> pointer.  So new code on a new kernel using a super-compact state
>>>>> could expand the state by allocating new memory (on the heap? very
>>>>> awkwardly on the stack?) and changing the pointer.  For all we know,
>>>>> some code already fiddles with the pointer.  This is great, except
>>>>> that your patch sticks more data at the end of the FPU block that no
>>>>> one is expecting, and your sigreturn code follows that pointer, and
>>>>> will read off into lala land.
>>>>>=20
>>>>=20
>>>> Then, what about we don't do that at all.  Is it possible from now on w=
e
>>>> don't stick more data at the end, and take the relocating-fpu approach?=

>>>>=20
>>>>> 2. CET.  CET wants us to find a few more bytes somewhere, and those
>>>>> bytes logically belong in ucontext, and here we are.
>>>>>=20
>>>>=20
>>>> Fortunately, we can spare CET the need of ucontext extension.  When the=

>>>> kernel handles sigreturn, the user-mode shadow stack pointer is right a=
t
>>>> the restore token.  There is no need to put that in ucontext.
>>>=20
>>> That seems entirely reasonable.  This might also avoid needing to
>>> teach CRIU about CET at all.
>> Wait, what's the actual shadow stack token format?  And is the token
>> on the new stack or the old stack when sigaltstack is in use?  For
>> that matter, is there any support for an alternate shadow stack for
>> signals?
>=20
> The restore token is a pointer pointing directly above itself and bit[0] i=
ndicates 64-bit mode.
>=20
> Because the shadow stack stores only return addresses, there is no alterna=
te shadow stack.  However, the application can allocate and switch to a new s=
hadow stack.

I think we should make the ABI support an alternate shadow stack even if we d=
on=E2=80=99t implement it initially. After all, some day someone might want t=
o register a handler for shadow stack overflow.

>=20
> Yu-cheng
