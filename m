Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 136C4F415A
	for <lists+linux-api@lfdr.de>; Fri,  8 Nov 2019 08:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfKHH2X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 Nov 2019 02:28:23 -0500
Received: from albireo.enyo.de ([37.24.231.21]:50802 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfKHH2X (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 8 Nov 2019 02:28:23 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iSygt-00077I-8k; Fri, 08 Nov 2019 07:28:19 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iSygc-0003Ot-Px; Fri, 08 Nov 2019 08:28:02 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elichai Turkel <elichai.turkel@gmail.com>, nd <nd@arm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
Subject: Re: Continuing the UAPI split
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
        <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
        <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
        <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
        <facb4d0d-4e20-41f0-4c01-b210c677c24c@arm.com>
        <086ffddf-553f-453d-a046-4d5e6abead21@redhat.com>
        <875zjvo2be.fsf@mid.deneb.enyo.de>
        <70a264b5-427f-fa6e-7f70-768724202d14@redhat.com>
Date:   Fri, 08 Nov 2019 08:28:02 +0100
In-Reply-To: <70a264b5-427f-fa6e-7f70-768724202d14@redhat.com> (Carlos
        O'Donell's message of "Thu, 7 Nov 2019 17:32:01 -0500")
Message-ID: <87sgmyvnct.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Carlos O'Donell:

> On 11/7/19 3:32 PM, Florian Weimer wrote:
>> * Carlos O'Donell:
>> 
>>> On 11/7/19 11:21 AM, Szabolcs Nagy wrote:
>>>>> Or just giving up and telling users they can't just directly include
>>>>> both libc headers and kernel headers?
>>>>
>>>> including both libc and linux headers is fragile and
>>>> will break differently across the different linux
>>>> libc implementations.
>>>
>>> We saw this all the time working in embedded.
>> 
>> Do you mean you saw problems while you working in the embedded space?
>  
> Yes, embedded Linux to be specific.
>
> There is a strong coupling between the kernel version and the toolchain
> version, specifically because the strategies we take to solve these
> problems end up being brittle in this regard.
>
> Too new a kernel and you get new header problems not solved by your
> old libc. Too new a libc and the kernel doesn't have the header
> coordination fixes required for the newer software that needed the
> newer libc.
>
> Does that clarify my point?

Yes, it does.  It wasn't clear to me if you wanted to say that this
was actually working for the embedded case.
