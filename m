Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84813382DDF
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhEQNu3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 09:50:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:55610 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233718AbhEQNu3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 17 May 2021 09:50:29 -0400
IronPort-SDR: o+jqUplEFiIVZjbhtEGAz4ywUONgRkxo4mkQN8+LEnf8AZbK196Gx60Yu7QJ349ze61R4WVNGT
 Q3uw+5dvyeVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="187589768"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="187589768"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 06:49:12 -0700
IronPort-SDR: ZOL+ry6wZLlVgKgJuPhe6rOnNHAxySLURxlnWDEg+BqMR/8lJ6U9SbGED9w9WIx/bHsCeHGUg+
 fbOg+Oz7rQAg==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="410832083"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.212.212.163]) ([10.212.212.163])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 06:49:12 -0700
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
To:     Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
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
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <d0ded3e1-d23c-0d22-df4c-fac6b5d3b6b2@linux.intel.com>
Date:   Mon, 17 May 2021 06:49:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874kf11yoz.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> Having a proper interface (syscall, prctl) which user space can use to
> ask for permission and allocation of the necessary buffer(s) is clearly
> avoiding the downsides and provides the necessary mechanisms for proper
> control and failure handling.

this would need to be a "get / put" interface, so a refcount; that way things nest nicely.
For API symmetry I'd want to have the put there, even if we may decide to be infinitely lazy
in cleaning up the state.

it also would want it to take an arguement that's a bitmask, so that this can be applied
to future state as well.

Eh actually I'd start with also adding AVX512 to this. Even though for obvious compat reasons
that one is on by default (so at process start we might need to start with a count of 1)
it's interesting to fold that into this same framework.
(and who knows, dropping AVX512 state if you don't need it might improve context switches)

Syscalls are relatively cheap (and I can imagine the C library doing a TLS cache of the count
if it becomes an issue) so can be done on a relatively finegrained level.

I've worked on OpenBLAS before, and that library basically has a global initialization function
that ends up getting called on the first big math op (it may spawn threads as well etc) but which
"stays around" for consecutive math functions; a get/put model would work quite well for such math
library (since it's based on BLAS like almost all such math libraries, I expect this to be the common
pattern)

