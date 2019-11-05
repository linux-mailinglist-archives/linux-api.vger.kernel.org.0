Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA02BEFFB2
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 15:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbfKEO2M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 09:28:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731004AbfKEO2M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 09:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572964090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlN265FK/KABiSoVogEIXFyTpEA9h+bE+0OpX/KyINw=;
        b=LGUby+oJiaAbTK3yPxhKdl/kYMSQifh90eqZctBzeR+1URZ5LyAXxzhpPfR2BcOC5Yvghv
        VjAvJivTOuT/eHytKLRVGarWcc6bbCPdoG9qICugAjG+uNq+BqA5nihmpj8Z4va8FeumKd
        0wIQGjLoCK+4ADS90lu0SN2mfKaA6CM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-pRg-AAxWM4y88l7D9tLXQw-1; Tue, 05 Nov 2019 09:28:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D39E2107ACC3;
        Tue,  5 Nov 2019 14:28:04 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1D225D713;
        Tue,  5 Nov 2019 14:27:49 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shawn Landden <shawn@git.icu>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking ABIs at the same time.
References: <20191104002909.25783-1-shawn@git.icu>
        <87woceslfs.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
        <87sgn2skm6.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>
        <f11d82f1-1e81-e344-3ad2-76e4cb488a3d@redhat.com>
Date:   Tue, 05 Nov 2019 15:27:48 +0100
In-Reply-To: <f11d82f1-1e81-e344-3ad2-76e4cb488a3d@redhat.com> (Carlos
        O'Donell's message of "Tue, 5 Nov 2019 09:10:38 -0500")
Message-ID: <87o8xqqty3.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: pRg-AAxWM4y88l7D9tLXQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Carlos O'Donell:

> On 11/5/19 6:56 AM, Thomas Gleixner wrote:
>> On Tue, 5 Nov 2019, Florian Weimer wrote:
>>> * Thomas Gleixner:
>>>> On Tue, 5 Nov 2019, Florian Weimer wrote:
>>>>> * Shawn Landden:
>>>>>> If this new ABI is used, then bit 1 of the *next pointer of the
>>>>>> user-space robust_list indicates that the futex_offset2 value should
>>>>>> be used in place of the existing futex_offset.
>>>>>
>>>>> The futex interface currently has some races which can only be fixed =
by
>>>>> API changes.  I'm concerned that we sacrifice the last bit for some
>>>>> rather obscure feature.  What if we need that bit for fixing the
>>>>> correctness issues?
>>>>
>>>> That current approach is going nowhere and if we change the ABI ever t=
hen
>>>> this needs to happen with all *libc folks involved and agreeing.
>>>>
>>>> Out of curiosity, what's the race issue vs. robust list which you are
>>>> trying to solve?
>>>
>>> Sadly I'm not trying to solve them.  Here's one of the issues:
>>>
>>>   <https://sourceware.org/bugzilla/show_bug.cgi?id=3D14485>
>>=20
>> That one seems more a life time problem, i.e. the mutex is destroyed,
>> memory freed and map address reused while another thread was not yet out=
 of
>> the mutex_unlock() call. Nasty.
>
> It is difficult to fix.
>
> The other issue is this:
>
> "Robust mutexes do not take ROBUST_LIST_LIMIT into account"
> https://sourceware.org/bugzilla/show_bug.cgi?id=3D19089

That's just a missing check in our implementation and something that few
applications will encounter, if any.  There is this one here:

  <https://sourceware.org/bugzilla/show_bug.cgi?id=3D19004>

It contains a kernel patch.

I thought that there were more issues in the current implementation, but
I can't a record of them. 8-(

Thanks,
Florian

