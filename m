Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164AB73A4E0
	for <lists+linux-api@lfdr.de>; Thu, 22 Jun 2023 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjFVP1g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jun 2023 11:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjFVP1M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Jun 2023 11:27:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8418268A
        for <linux-api@vger.kernel.org>; Thu, 22 Jun 2023 08:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B18618D1
        for <linux-api@vger.kernel.org>; Thu, 22 Jun 2023 15:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E1BC433B6
        for <linux-api@vger.kernel.org>; Thu, 22 Jun 2023 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687447611;
        bh=B+Z7cw05eGhQpRQ1oXi2HuFt1eCXDFTqYg6Ryju6Ww0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nB4Y9/mqZhxnx/pFiZBoNBxlRj3GtfxbTI/3RPgVEDLBZ9tSwzxps1pK/FQLkfp8m
         2qV4QyEUtFnGxcAOSBOKqxmf+mjEQlT+oD7F+IZMBfK/6H29YsojXnVfZAWUR7e+Br
         TY3+JMLjHU3aSxMzDWPqFIw/F6KzFPbtIrAoxOyFhqGqjkywr1wA1B9F0zYfW4kv+L
         6bsftSbGuntuOjTUeKkG+D8cOSybdZRMntDtfPXn6PdN0Vl5H8s0rXbnwDS5u8dc/b
         gAYfIszVLkFque5+UEWvZTdTPPFfwBEBF48476mbNgGpvjK+WREtkR5lL4qGOORkke
         fK4+Zatf615Lg==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f9c532fa45so18316505e9.2
        for <linux-api@vger.kernel.org>; Thu, 22 Jun 2023 08:26:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDwhk/S0BLSQD1o+iWdLVk4r0bbunbh0vfNzvudB+sc2XHl3le4g
        k+RsHBLx0L7rb+JO1Ev5eEzoOkrj09pM+nI2me6hpQ==
X-Google-Smtp-Source: ACHHUZ7ewJB4p0OlgjL9jrGWucQ4lnAZcdwnRyYRE2RVvAZbSPiRVU6sOkh+C0Lymc07Bd7gWh87WrIEBULLZsT4gxA=
X-Received: by 2002:aa7:c594:0:b0:51a:44b7:14c2 with SMTP id
 g20-20020aa7c594000000b0051a44b714c2mr9734462edq.40.1687447589330; Thu, 22
 Jun 2023 08:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk>
 <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com> <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com> <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com> <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com> <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com>
In-Reply-To: <ZJQR7slVHvjeCQG8@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Jun 2023 08:26:17 -0700
X-Gmail-Original-Message-ID: <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
Message-ID: <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack description
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 22, 2023 at 2:28=E2=80=AFAM szabolcs.nagy@arm.com
<szabolcs.nagy@arm.com> wrote:
>
> The 06/21/2023 18:54, Edgecombe, Rick P wrote:
> > On Wed, 2023-06-21 at 12:36 +0100, szabolcs.nagy@arm.com wrote:
> > > > The 06/20/2023 19:34, Edgecombe, Rick P wrote:
> > > > > > I actually did a POC for this, but rejected it. The problem is,
> > > > > > if
> > > > > > there is a shadow stack overflow at that point then the kernel
> > > > > > > > can't
> > > > > > push the shadow stack token to the old stack. And shadow stack
> > > > > > > > overflow
> > > > > > is exactly the alt shadow stack use case. So it doesn't really
> > > > > > > > solve
> > > > > > the problem.
> > > >
> > > > the restore token in the alt shstk case does not regress anything
> > > > but
> > > > makes some use-cases work.
> > > >
> > > > alt shadow stack is important if code tries to jump in and out of
> > > > signal handlers (dosemu does this with swapcontext) and for that a
> > > > restore token is needed.
> > > >
> > > > alt shadow stack is important if the original shstk did not
> > > > overflow
> > > > but the signal handler would overflow it (small thread stack, huge
> > > > sigaltstack case).
> > > >
> > > > alt shadow stack is also important for crash reporting on shstk
> > > > overflow even if longjmp does not work then. longjmp to a
> > > > makecontext
> > > > stack would still work and longjmp back to the original stack can
> > > > be
> > > > made to mostly work by an altshstk option to overwrite the top
> > > > entry
> > > > with a restore token on overflow (this can break unwinding though).
> > > >
> >
> > There was previously a request to create an alt shadow stack for the
> > purpose of handling shadow stack overflow. So you are now suggesting to
> > to exclude that and instead target a different use case for alt shadow
> > stack?
>
> that is not what i said.
>
> > But I'm not sure how much we should change the ABI at this point since
> > we are constrained by existing userspace. If you read the history, we
> > may end up needing to deprecate the whole elf bit for this and other
> > reasons.
>
> i'm not against deprecating the elf bit, but i think binary
> marking will be difficult for this kind of feature no matter what
> (code may be incompatible for complex runtime dependent reasons).
>
> > So should we struggle to find a way to grow the existing ABI without
> > disturbing the existing userspace? Or should we start with something,
> > finally, and see where we need to grow and maybe get a chance at a
> > fresh start to grow it?
> >
> > Like, maybe 3 people will show up saying "hey, I *really* need to use
> > shadow stack and longjmp from a ucontext stack", and no one says
> > anything about shadow stack overflow. Then we know what to do. And
> > maybe dosemu decides it doesn't need to implement shadow stack (highly
> > likely I would think). Now that I think about it, AFAIU SS_AUTODISARM
> > was created for dosemu, and the alt shadow stack patch adopted this
> > behavior. So it's speculation that there is even a problem in that
> > scenario.
> >
> > Or maybe people just enable WRSS for longjmp() and directly jump back
> > to the setjmp() point. Do most people want fast setjmp/longjmp() at the
> > cost of a little security?
> >
> > Even if, with enough discussion, we could optimize for all
> > hypotheticals without real user feedback, I don't see how it helps
> > users to hold shadow stack. So I think we should move forward with the
> > current ABI.
>
> you may not get a second chance to fix a security feature.
> it will be just disabled if it causes problems.

*I* would use altshadowstack.

I run a production system (that cares about correctness *and*
performance, but that's not really relevant here -- SHSTK ought to be
fast).  And, if it crashes, I want to know why.  So I handle SIGSEGV,
etc so I have good logs if it crashes.  And I want those same logs if
I overflow the stack.

That being said, I have no need for longjmp or siglongjmp for this.  I
use exit(2) to escape.

For what it's worth, setjmp/longjmp is a bad API.  The actual pattern
that ought to work well (and that could be supported well by fancy
compilers and non-C languages, as I understand it) is more like a
function call that has two ways out.  Like this (pseudo-C):

void function(struct better_jmp_buf &buf, args...)
{
   ...
       if (condition)
          better_long_jump(buf);  // long jumps out!
       // could also pass buf to another function
   ...
       // could also return normally
}

better_call_with_jmp_buf(function, args);

*This* could support altshadowstack just fine.  And many users might
be okay with the understanding that, if altshadowstack is on, you have
to use a better long jump to get out (or a normal sigreturn or _exit).
No one is getting an altshadowstack signal handler without code
changes.

siglongjmp() could support altshadowstack with help from the kernel,
but we probably don't want to go there.

--Andy
