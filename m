Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03ECEF3987
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 21:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKGUcL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 15:32:11 -0500
Received: from albireo.enyo.de ([37.24.231.21]:46300 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfKGUcK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 7 Nov 2019 15:32:10 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iSoRq-00035X-27; Thu, 07 Nov 2019 20:32:06 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iSoRp-0000yO-VZ; Thu, 07 Nov 2019 21:32:05 +0100
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
Date:   Thu, 07 Nov 2019 21:32:05 +0100
In-Reply-To: <086ffddf-553f-453d-a046-4d5e6abead21@redhat.com> (Carlos
        O'Donell's message of "Thu, 7 Nov 2019 13:05:19 -0500")
Message-ID: <875zjvo2be.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Carlos O'Donell:

> On 11/7/19 11:21 AM, Szabolcs Nagy wrote:
>>> Or just giving up and telling users they can't just directly include
>>> both libc headers and kernel headers?
>> 
>> including both libc and linux headers is fragile and
>> will break differently across the different linux
>> libc implementations.
>
> We saw this all the time working in embedded.

Do you mean you saw problems while you working in the embedded space?
