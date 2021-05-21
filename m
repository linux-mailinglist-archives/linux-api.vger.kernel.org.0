Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05C038D003
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 23:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhEUVpE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 17:45:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56534 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUVpD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 17:45:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621633418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2Zvf4YEm1tFPNzEd7n/UJedCF9RvfBvtdYegG4LEec=;
        b=iFF+GrJjH231ECxDi6mr1GS+vUU+Muc9cB7hxoXY+5Mqlmhu4PAbAfPaP6XJGNI0MJEoWV
        fbRXPRxJOM4XVuZOYkUSeTz4LoowD74WdZvUhbE+y21la0hu9hZq2ylnJVlqQ0CpTV4LHF
        YVXlhEaSgpUyrlTsNRAEj/BORwjunbOhu4sujqy0zrTjRPWOAzGqnPfXV3I/QXoq9AzN2B
        gHhTr0kX6LHLDByw5JYf3nRv2RskZ49+e45sAoMjkNi0D4KCMMNIAB2JDqsybpGePxKh6c
        qB4efT0uKcagFsa7Zw5loWSuTNeyp3GRNfpHiEOSqTeZBznxQ0huT+30yPy0Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621633418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2Zvf4YEm1tFPNzEd7n/UJedCF9RvfBvtdYegG4LEec=;
        b=FQvivXj6EAnAS/ROEOttaW8WjCkuzfYbXboYPCGOpz+27FOorQZFKcw+ao6rwvRtr4Kie6
        oUJHCIhRsRIj8iDA==
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
In-Reply-To: <6c9c4597-a1af-4cbb-9dc8-424999d04793@www.fastmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210419141454.GE9093@zn.tnic>
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
 <87k0nraonu.ffs@nanos.tec.linutronix.de>
 <6c9c4597-a1af-4cbb-9dc8-424999d04793@www.fastmail.com>
Date:   Fri, 21 May 2021 23:43:38 +0200
Message-ID: <87h7ivahkl.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21 2021 at 13:07, Andy Lutomirski wrote:
> On Fri, May 21, 2021, at 12:10 PM, Thomas Gleixner wrote:
>> Why? The bit can be enabled and #NM catches the violation of the ABI
>> contract if the application did not request usage. No XCR0 fiddling on
>> context switch required.
>
> XFD does nothing about signals.

It's a matter of what's implemented in #NM. XFD just arms #NM

> It also doesn=E2=80=99t help give applications a non-Linux-specific way t=
o ask
> if AMX is available. The SDM says that one can read XCR0.  Sure, we
> can use it, but cross platform libraries seem likely to get it wrong.

Well, that's the inevitable consequence of Intel declaring that
everything needs to be exposed unconditionally for the very wrong
reasons.

Thanks,

        tglx


