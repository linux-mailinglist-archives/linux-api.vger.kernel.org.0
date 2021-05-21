Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524A138BABD
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 02:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhEUARW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 20:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhEUARV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 20:17:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E201C061574;
        Thu, 20 May 2021 17:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=o3zZXuheU23WahGAvIMKDA7Rb1yHjXqZyPacGw/Lpzs=; b=tC4dgnm1SR0y4T2wtg5Tazjnq2
        o9WBCBV40BIrEG2eGh6piTokKfOQAm7kHMfvsDSmQmP0bUXnH1wKDoiNxEqT4D9rDrZlkB3pxuSnG
        vMDUKlUbBDwzoL0NR9SSoLaeXvWcbhPlB7mcyTGnnHw73jHArcAaSoXdFNKguzyOll/fI+yjazmzS
        gqY3UmBYyAEigh9keOEB3ct0PpE1u6GPASil0ye/vV4QqcyJ19RiXhvvj+q91YT2R4HCqaLEuuAFX
        nP6RPh6jNUZR9swhwJPc+IlkJEi+t1aqgB8aXC+4izt2/rdpdIz58EAOxz/hRyHCRPYwx36c/HBhH
        56h6o/1w==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljspT-00GjDV-84; Fri, 21 May 2021 00:15:51 +0000
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Peter Oskolkov <posk@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
References: <20210520183614.1227046-1-posk@google.com>
 <87mtspm7fe.fsf@meer.lwn.net>
 <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c924d722-eee0-03ee-991d-c977089ecdbc@infradead.org>
Date:   Thu, 20 May 2021 17:15:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/20/21 2:38 PM, Peter Oskolkov wrote:
> On Thu, May 20, 2021 at 2:17 PM Jonathan Corbet <corbet@lwn.net> wrote:
>>
>> Peter Oskolkov <posk@google.com> writes:
>>
>>> As indicated earlier in the FUTEX_SWAP patchset:
>>>
>>> https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/
>>>
>>> "Google Fibers" is a userspace scheduling framework
>>> used widely and successfully at Google to improve in-process workload
>>> isolation and response latencies. We are working on open-sourcing
>>> this framework, and UMCG (User-Managed Concurrency Groups) kernel
>>> patches are intended as the foundation of this.
>>
>> So I have to ask...is there *any* documentation out there on what this
>> is and how people are supposed to use it?  Shockingly, typing "Google
>> fibers" into Google leads to a less than fully joyful outcome...  This
>> won't be easy for anybody to review if they have to start by
>> reverse-engineering what it's supposed to do.
> 
> Hi Jonathan,
> 
> There is this Linux Plumbers video: https://www.youtube.com/watch?v=KXuZi9aeGTw
> And the pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
> 
> I did not reference them in the patchset because links to sites other
> than kernel.org are strongly discouraged... I will definitely add a
> documentation patch.

Certainly for links to email, we prefer to use lore.kernel.org archives.
Are links to other sites discouraged?  If so, that's news to me.


> Feel free to reach out to me directly or through this LKML thread if
> you have any questions.
> 
> Do you think a documentation patch would be useful at this point, as
> opposed to a free-form email discussion?

thanks.
-- 
~Randy

