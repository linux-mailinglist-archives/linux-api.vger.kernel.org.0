Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C938B911
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 23:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhETVmf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhETVmf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 17:42:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DEDC061574;
        Thu, 20 May 2021 14:41:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621546870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wW24DYlPkr7pkQEBZ+G/csAqmXvvJc049o7EdOTc3zo=;
        b=xRH/tK+52B87Eo7tPeRpYoYXWeciTZlh3DrLShYY6C/r7eRkNbhXgC3E87qFFxreJ+aWzF
        rglswI+ZNypjQW/nKyPY4U9en/I1zCYrlY3NCanNtMeqLTmAmZOK3locY19d19ClxPZgHu
        nrn80/1udqRFZqo2RR/L7hynJcsKJR8DQkAf5gNKrQ4ghXfFQkKKmliHSQ4xoh+t2EHrnn
        PlpyNiyDO8m0sc3x2Tc3H5+OhXucTJ2ohfGDYZWgNymONVKHwrNLymfYbcyjENDKaJ8erH
        rYPCXBQZ13pQICaHdy0pHWj6NTNFra8CD02Con9mhZuKlkM4bM98+F7hTPmFOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621546870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wW24DYlPkr7pkQEBZ+G/csAqmXvvJc049o7EdOTc3zo=;
        b=PUh5AoPcGtdQLFK71CDr1AwyPujneKlpGAe6G+Onzh4cRGB/p+/eOXwPvVioU/1JzKlzEM
        Bo8COlGOrVrd70BQ==
To:     Len Brown <lenb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <CAJvTdK=DCdwc86VdCVsCH+et6aGuAE3hi-wKmE5769SA0g1H-Q@mail.gmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com> <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com> <87k0ntazyn.ffs@nanos.tec.linutronix.de> <CAJvTdK=DCdwc86VdCVsCH+et6aGuAE3hi-wKmE5769SA0g1H-Q@mail.gmail.com>
Date:   Thu, 20 May 2021 23:41:10 +0200
Message-ID: <87h7ixaxs9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Len,

On Thu, May 20 2021 at 17:22, Len Brown wrote:
> On Thu, May 20, 2021 at 4:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > AMX is analogous to the multiplier used by AVX-512.
>> > The architectural state must exist on every CPU, including HT siblings.
>> > Today, the HT siblings share the same execution unit,
>> > and I have no reason to expect that will change.
>>
>> I'm well aware that HT siblings share the same execution unit for
>> AVX.
>>
>> Though AMX is if I remember the discussions two years ago correctly
>> shared by more than the HT siblings which makes things worse.
>
> I regret that we were unable to get together in the last year to have
> an updated discussion.  I think if we had, then we would have saved
> a lot of mis-understanding and a lot of email!
>
> So let me emphasize here:
>
> There is one TMUL execution unit per core.
> It is shared by the HT siblings within that core.
>
> So the comparison to the AVX-512 multiplier is a good one.

Fine, but that does not at all change the facts that:

  1) It's shared between logical CPUs

  2) It has effects on power/thermal and therefore effects which reach
     outside of the core scope

  3) Your appproach of making it unconditionlly available via the
     proposed #NM prevents the OS and subsequently the system admin /
     system designer to implement fine grained control over that
     resource.

     And no, an opt-in approach by providing a non-mandatory
     preallocation prctl does not solve that problem.

Thanks,

        tglx
