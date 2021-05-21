Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3038CDE6
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhEUTGk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 15:06:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55792 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbhEUTGi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 15:06:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621623913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SR6OQKV549q4JEmHXLaUA2oYN7XUebJWxPZZsjcwpXA=;
        b=Zv3ZMHsz/WqA2OZplcBOcXMjOU/yIE3KJx2qdGtwi23yV0Kv8Z05RG84DqldU3qTQsVscs
        wWviYdHkkDT2Gel7in/axP06urZjAtnqXmbHUJ4kgYfHtL7ThpT4G37dGJeXSTGpkMiG5G
        fUk1j9Jxc5SoaukIUVtfUQIvSDPoCMycxdIYXYUpfJxQUZC3HnDWrstt5DO96lPsmPzdrY
        d46LcFWDyNuOuCfJ6/fb5glFNG7YMIbP4bwwFE6tzJ2cc38+cX0Mci3Iye661ehz4B0CKt
        cxm8RR23b/vwDYFv+88Q4HewZYvABF4XLue/5SYTH8IO1m9oUjOcD+4npJa2gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621623913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SR6OQKV549q4JEmHXLaUA2oYN7XUebJWxPZZsjcwpXA=;
        b=KIQGYLB6834C1i8fuxGQgYAzy4USl9ZUZIDx704KQ4rHjuVYaBZxU70nTLv/D+Yu6NTMVY
        fu7haF6Uk4uH0pBw==
To:     Florian Weimer <fweimer@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Len Brown <lenb@kernel.org>, Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <87r1i06ow2.fsf@oldenburg.str.redhat.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic>
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
Date:   Fri, 21 May 2021 21:05:12 +0200
Message-ID: <87mtsnaown.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21 2021 at 18:19, Florian Weimer wrote:
> * Dave Hansen:
>> On 5/21/21 7:44 AM, Florian Weimer wrote:
>>> Why can't userspace look at XCR0 to make the decision?
>>
>> The thing we're trying to avoid is a #NM exception from XFD (the new
>> first-use detection feature) that occurs on the first use of AMX.
>> XCR0 will have XCR0[AMX]=1, even if XFD is "armed" and ready to
>> generate the #NM.
>
> I see.  So essentially the hardware wants to offer transparent
> initialize-on-use, but Linux does not seem to want to implement it this
> way.

The hardware offers an exception which can be used to implement that,
but the hardware does not dictate that usage.

If we'd go that way we lost any control over that resource and I can
demonstrate with AVX512 today what kind of consequences that has with
mixed criticality realtime workloads.

The only solution we have today is to disable AVX512 completely, which
sucks because restricted usage can be benefitial for some of the
computations.

The problem is that the approach of user space in general seems to be
blindly_select_max(AVX). I've seen that in quite some places.

With AMX (and the stuff coming next) we have the chance to do proper
resource control and it would be outright stupid not to take that
opportunity.

Thanks,

        tglx
