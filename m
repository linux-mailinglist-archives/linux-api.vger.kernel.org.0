Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC78B3829A8
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 12:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhEQKTa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 06:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEQKT3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 May 2021 06:19:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF60C061573;
        Mon, 17 May 2021 03:18:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621246690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zz3NPs+wt6StysgikNkYNgGUFeAfLSA7zXm/ZKg27k=;
        b=DXHJbrfh4uoRQpWx9h9zfiHD+Q5JOAd143oFu1shjaH85Ky7o+V2cari7L/ZvBUb1hLYO8
        5wSieOg2XbhI/alz4CI6023AiDJs6hVTk1cukX8VuDXNExOc9KX2CtkJcAwqec9W8j+sJs
        DnQXwtEdD3dunRZ38Pl4rmKiCWoZdwWFWSEExbHKxmGjM3ZISfWS0J+dsO0pD8FvXg1a2T
        kUFf8RqIrMEeXqPl+CR2LS6XhbT6WaYoQfT5EOn0mwS+3PapV0t/kEQmEDHDpKablHwjYy
        dz7DPdTEbKJ3GzwmGMr4PU/N6/jixx70Okrj+Ju7DOT82ZmNCrOUCEnsPnYfNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621246690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zz3NPs+wt6StysgikNkYNgGUFeAfLSA7zXm/ZKg27k=;
        b=mghAS2q0UHTE2Lmbb//Xqw/ACQntH5qxeu2VotZwfZuEumALz9iuphq2aT5JdwvI9gFMi6
        04sD7+l4zKemAkBA==
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <87pmxpk7jo.fsf@oldenburg.str.redhat.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com> <874kf11yoz.ffs@nanos.tec.linutronix.de> <87pmxpk7jo.fsf@oldenburg.str.redhat.com>
Date:   Mon, 17 May 2021 12:18:10 +0200
Message-ID: <87y2cdzmsd.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 17 2021 at 11:56, Florian Weimer wrote:
> * Thomas Gleixner:
>
>> Having a proper interface (syscall, prctl) which user space can use to
>> ask for permission and allocation of the necessary buffer(s) is clearly
>> avoiding the downsides and provides the necessary mechanisms for proper
>> control and failure handling.
>>
>> It's not the end of the world if something which wants to utilize this
>> has do issue a syscall during detection. It does not matter whether
>> that's a library or just the application code itself.
>>
>> That's a one off operation and every involved entity can cache the
>> result in TLS.
>
> I'm not sure if it's a good idea to have each AMX consumer to set up its
> own TLS cache.  How expensive is checking XCR0 via XGETBV instead on the
> AMX path?  Then AMX can be enabled on the thread via a system call. 

Right, did not think about that.

> It also allows disabling of AMX.

That needs reference counting, but yes it's possible.

> It would also need an AT_HWCAP2 feature flag telling user space that AMX
> support is available after that system call (switching on AMX to check
> whether AMX paths should enabled later seems potentially wasteful if the
> AMX paths are never taken after all).

Either that or just have:

       prctl(PR_QUERY_XSTATE_FEATURES,....
       prctl(PR_ENABLE_XSTATE_FEATURES,....
       prctl(PR_DISABLE_XSTATE_FEATURES,....

Thanks,

        tglx
