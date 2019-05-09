Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AAD193BB
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfEIUpw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 16:45:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47798 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfEIUpw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 16:45:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x49KjV1o007053;
        Thu, 9 May 2019 15:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557434731;
        bh=so+kgEsX8fl08a9xg8829eOOnsY9R7I2gwQmZB06kJ8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x0aONXG6oR+deYi77Ry2mud/fuW0Q2mzpNxyhy1tfu2STOyIXII8W56aDfZ+7JRY0
         ciyt4+LF4INIuo3K53Tos3MO2nHj4GIhTSXZCs1895HTuRWskZqTC/EDSoYjIS3SFM
         QlqxYkcb8A3EYVMYchUEDrWmacq0zM0OtHhdWm88=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x49KjVCe052719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 May 2019 15:45:31 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 9 May
 2019 15:45:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 9 May 2019 15:45:31 -0500
Received: from [10.250.146.137] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x49KjQ8K101761;
        Thu, 9 May 2019 15:45:27 -0500
Subject: Re: [PATCH v3 09/11] platform/x86: asus-wmi: Control RGB keyboard
 backlight
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <c953b43b-6186-77e9-54b1-b1cd1d7d1eb6@gmail.com>
 <CAHp75Vf9uPG7_K0P26nHYCH0WB6LFX3wk8aJBpLWQ-r46kDw9w@mail.gmail.com>
 <20190508171229.GA22024@amd> <52e73640-9fbf-437b-537a-7b3dc167052f@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <2f26dd9e-ada7-8e20-c810-a647854c338c@ti.com>
Date:   Thu, 9 May 2019 15:45:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <52e73640-9fbf-437b-537a-7b3dc167052f@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Yurii

On 5/9/19 2:04 PM, Yurii Pavlovskyi wrote:
> First of all, thanks to Andy for all the review comments!
> 
> I will implement all the ones that I didn't directly answer on as well and
> update this series shortly.
> 
> Regarding this patch,
> 
> On 08.05.19 19:12, Pavel Machek wrote:
>>> Shouldn't be the LED subsystem driver for this?
>>
>> Yes, please. We have common interface for LED drivers; this needs to
>> use it.
> 
> That is indeed a better option and I did in fact considered this first and
> even did a test implementation. The discoveries were:
> 1. The WMI methods are write-only and only written all at once in a
> transaction manner (also invoking solely first RGB-interface method has no
> effect until some other keyboard backlight method is called).
> 2. In addition to RGB there are several control values, which switch
> effects, speed and enable or disable the backlight under specific
> conditions or switch whether it is set temporarily or permanently (not that
> these are critical functionalities, but for the sake of completeness).
> 3. The EC is really slow
> # time bash -c "echo 1 > /sys/devices/platform/faustus/kbbl_set"
> 
> real	0m0,691s
> user	0m0,000s
> sys	0m0,691s
> 
> (please ignore the sysfs-path there, it's essentially the same code running
> as in this patch). It is consistently same for both temporary and permanent
> configuration. Writing after every change would take about (6+)x of that.
> Not that it's that unbearable though as it is not likely to be done often.
> 
> I was not quite happy with that implementation so I opted for writing sort
> of sysfs wrapper instead that would allow same sort of transactions as
> provided by BIOS. I agree that it's non-standard solution.
> 
> If I understood correctly, the typical current RGB led_class devices from
> the Linux tree currently provide channels as separate LEDs. There are also
> blink / pattern options present, I guess one could misuse them for setting
> effects and speed. So one could make 3 devices for RGB + 3 for awake,
> sleep, boot modes + 1 for setting effect / speed.
> 
> I'd guess the end solution might be also either something like combination
> of both approaches (RGB leds + separate sysfs interface) or some extension
> of the led_class device interface. Dropping support of the non-essential
> features for the sake of uniformity of ABI would also be an option to
> consider (exposing just three RGB LEDs with brightness only), not happy one
> though.
> 
> In any case this looks like it might need some additional research,
> discussion, development, and a pair of iterations so I tend to separate
> this patch from the series and post it extra after the others are through
> to avoid dragging 10+ patches around.
> 
> Any suggestions on how to do this properly would be appreciated. That's the
> best I could come up with at the moment.
> 

We are working on a framework for this.

Please see this series
https://lore.kernel.org/patchwork/project/lkml/list/?series=390141

It is still a work in progress

> Thanks,
> Yurii
> 
