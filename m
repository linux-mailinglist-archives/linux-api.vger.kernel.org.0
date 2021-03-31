Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12B350523
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 18:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhCaQyZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhCaQyE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Mar 2021 12:54:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE1C06174A
        for <linux-api@vger.kernel.org>; Wed, 31 Mar 2021 09:53:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d8so8211237plh.11
        for <linux-api@vger.kernel.org>; Wed, 31 Mar 2021 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=hk1eGF9UROjG/f/Flt2fUdcK/q5+Gj+fZdKcwTUQYH8=;
        b=p+WEaeVoSyBA0mxHcFAHnmyH9tTYKSvE0ibbhRPxRDUQduiljO1luAFiZb0qjbpql6
         yR63zxtgjsqVT5o0BG22OkkyaaORrogc0OnDKFQYB1CGkphoBz6f3pnHxINsKeiIDeHo
         QmKzsRo6qrh1XZIjHSbNg7nUie179ftSIvOBYA3VBHo6lAMyCnN9epfUA3JgHHzPQQyB
         yJK8ezTHafDcb4LNLHpYEAanQCevhoOyrdAnNF8cRDRHEFryHQ/NgOspx+hulpe53Gu5
         W0h7y+beCdqcy+xmBVO0GXQo+aMHRhis0bjX3Ua1aODL520iFPaH0piN32KcU4Ul9h7L
         ELEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=hk1eGF9UROjG/f/Flt2fUdcK/q5+Gj+fZdKcwTUQYH8=;
        b=YblFZMNCQCJIG74sdB84M2I3kZblNca+eUcYVQYLM+ygq5+7IXjhmJX6VOKVSuf8NF
         szI12C/RFcgjYW0TCMHZ3Lo3LReRLYHu7EM1aabHtKzU4NLtr5hb0tCyROmsX9ancRqf
         L9lb6wgA5iaqwi4Xu1Sprq2B4YyzOUdGWuIe0LVQKzBWJvsIp6+UdV30yjOzay+c1wHh
         D/FaWg7HcyINKBVR5nuT3pEmVDKZLJPKcRNFzTthJe+AXqcViF+wAMuQRZAMWaAmWA6E
         7xM8Svv1sXas5feO+w4kcqbAG66MNWH38O++IeRfbXzBaxvwE+9Uqhz4hWGdQh/ZEYgw
         2OAA==
X-Gm-Message-State: AOAM53318R72mTYWP3j69fS9teOHZqxuHR8ZU2D1t9W98ImYEJn3hha6
        MCAoTQ83+rtjcMVL/vRVmt6gGA==
X-Google-Smtp-Source: ABdhPJx30pIX87T/1v4szyFkgLQbcJSdPKomLZItBbXr12z7PTW6nzPFAxKb6rJCAsys+wAg7E0kfw==
X-Received: by 2002:a17:90a:c08a:: with SMTP id o10mr4369678pjs.67.1617209631861;
        Wed, 31 Mar 2021 09:53:51 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:6c04:8e42:2555:a3ed? ([2601:646:c200:1ef2:6c04:8e42:2555:a3ed])
        by smtp.gmail.com with ESMTPSA id h15sm2848098pfo.20.2021.03.31.09.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:53:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
Date:   Wed, 31 Mar 2021 09:53:50 -0700
Message-Id: <E8BCA270-4F23-4E1B-BAD6-917DBE36F5F6@amacapital.net>
References: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <CAJvTdK=evAofQRcmt_iwtYx2f_wTGUDpXzvjuiVwgZZ6BZV_Qg@mail.gmail.com>
To:     Len Brown <lenb@kernel.org>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Mar 31, 2021, at 9:31 AM, Len Brown <lenb@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 30, 2021 at 6:01 PM David Laight <David.Laight@aculab=
.com> wrote:
>=20
>>> Can we leave it in live registers?  That would be the speed-of-light
>>> signal handler approach.  But we'd need to teach the signal handler to
>>> not clobber it.  Perhaps that could be part of the contract that a
>>> fast signal handler signs?  INIT=3D0 AMX state could simply sit
>>> patiently in the AMX registers for the duration of the signal handler.
>>> You can't get any faster than doing nothing :-)
>>>=20
>>> Of course part of the contract for the fast signal handler is that it
>>> knows that it can't possibly use XRESTOR of the stuff on the stack to
>>> necessarily get back to the state of the signaled thread (assuming we
>>> even used XSTATE format on the fast signal handler stack, it would
>>> forget the contents of the AMX registers, in this example)
>>=20
>> gcc will just use the AVX registers for 'normal' code within
>> the signal handler.
>> So it has to have its own copy of all the registers.
>> (Well, maybe you could make the TMX instructions fault,
>> but that would need a nested signal delivered.)
>=20
> This is true, by default, but it doesn't have to be true.
>=20
> Today, gcc has an annotation for user-level interrupts
> https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html#x86-Functi=
on-Attributes
>=20
> An analogous annotation could be created for fast signals.
> gcc can be told exactly what registers and instructions it can use for
> that routine.
>=20
> Of course, this begs the question about what routines that handler calls,
> and that would need to be constrained too.
>=20
> Today signal-safety(7) advises programmers to limit what legacy signal han=
dlers
> can call.  There is no reason that a fast-signal-safety(7) could not be cr=
eated
> for the fast path.
>=20
>> There is also the register save buffer that you need in order
>> to long-jump out of a signal handler.
>> Unfortunately that is required to work.
>> I'm pretty sure the original setjmp/longjmp just saved the stack
>> pointer - but that really doesn't work any more.
>>=20
>> OTOH most signal handlers don't care - but there isn't a flag
>> to sigset() (etc) so ask for a specific register layout.
>=20
> Right, the idea is to optimize for *most* signal handlers,
> since making any changes to *all* signal handlers is intractable.
>=20
> So the idea is that opting-in to a fast signal handler would opt-out
> of some legacy signal capibilities.  Complete state is one of them,
> and thus long-jump is not supported, because the complete state
> may not automatically be available.

Long jump is probably the easiest problem of all: sigsetjmp() is a *function=
*, following ABI, so sigsetjmp() is expected to clobber most or all of the e=
xtended state.

But this whole annotation thing will require serious compiler support. We al=
ready have problems with compilers inlining functions and getting confused a=
bout attributes.

An API like:

if (get_amx()) {
 use AMX;
} else {
 don=E2=80=99t;
}

Avoids this problem. And making XCR0 dynamic, for all its faults, at least h=
elps force a degree of discipline on user code.


>=20
> thanks,
> Len Brown, Intel Open Source Technology Center
