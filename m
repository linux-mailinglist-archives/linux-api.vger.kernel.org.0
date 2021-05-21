Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAB138CE00
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbhEUTLz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 15:11:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhEUTLy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 15:11:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621624230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+06u+wdZEMxW6NyWmiNO0gVYIZ0+Re0+Y3ZmGldgwNc=;
        b=aaLl3EF2IgQnaSKKg1nxYMUJzsvLzbxaaLESyykkrwUQQ3XG8zEV2QFFm1+4uyf4OtkOEU
        blNSgH8NS5lOyUf/Zhg6cl38LntdeDIKu/xHEtkRXCUzm0fqiFqW+wy/mrj2emvPci7KXi
        h2/LQPAy8CUHrsL/L9YplBtsJ7P0U+ytWCcgMyY4xdoN9gD1hCJx0HgOiLFhPykNyyAkL8
        AYwELp2txsrvyG3du+fFCJWZ/CrEPT/nXlJqsMHo0fw9V3H1/qwYCTHqERTe6yErlRQOqA
        qpO23fsKqseiXxmZQ6v1vNGuL2uqqtEczwvdCoNJIiFgSOjL8K7pTUockbGAWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621624230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+06u+wdZEMxW6NyWmiNO0gVYIZ0+Re0+Y3ZmGldgwNc=;
        b=BuI+lIrOiz4aW1b3y5gyTkQmeZ3pQt+NK9nUepZLAoHA92B9QOS/3XH+sT9XY7q66mgtI1
        FHEigHsXuexcOiBw==
To:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Len Brown <lenb@kernel.org>, Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic>
 <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic>
 <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic>
 <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de>
 <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de>
 <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
 <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com>
 <87r1i06ow2.fsf@oldenburg.str.redhat.com>
 <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com>
Date:   Fri, 21 May 2021 21:10:29 +0200
Message-ID: <87k0nraonu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21 2021 at 09:31, Andy Lutomirski wrote:
> arch_prctl(SET_XSTATE_INIT_ON_FIRST_USE, TILE_STUFF);?
>
> As long as this is allowed to fail, I don=E2=80=99t have a huge problem w=
ith
> it.

I'm fine with that. It's still controlled by the OS and can return
-EPERM.

If allowed then the application would also accept to be insta killed if
that #NM allocation fails. Any bug report vs. that will be ignored.

> I think several things here are regrettable:
>
> 1. Legacy XSTATE code might assume that XCR0 is a constant.
>
> 2. Intel virt really doesn=E2=80=99t like us context switching XCR0, alth=
ough
> we might say that this is Intel=E2=80=99s fault and therefore Intel=E2=80=
=99s
> problem. AMD hardware doesn=E2=80=99t appear to have this issue.
>
> 3. AMX bring tangled up in XSTATE is unfortunate.  The whole XSTATE
> mechanism is less than amazing.
>
> IMO the best we can make of this whole situation is to make XCR0
> dynamic, but the legacy compatibility issues are potentially
> problematic.

Why? The bit can be enabled and #NM catches the violation of the ABI
contract if the application did not request usage. No XCR0 fiddling on
context switch required.

Thanks,

        tglx


