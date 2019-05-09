Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B07194D9
	for <lists+linux-api@lfdr.de>; Thu,  9 May 2019 23:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEIVoc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 17:44:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36514 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIVoc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 17:44:32 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x49LiG3a106503;
        Thu, 9 May 2019 16:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557438256;
        bh=Q9Z3Cdxba9fPA3W2vhRBY2VSHgjkNI6BHfKusWm8Mp4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bmIfRFy/ovPoRVIcnoCf8Y7JxDQqH7kkbi3CNdJjibENrV1yMOGIflHaS34rFdcI6
         TnHtORV+qV6HC0PilD9ix7uV/TfWyYCXC9Vh/sJXbaohhJsp0RnFTTvXkXrvIvd3VG
         8R/WiuMfVtuOEcq0cqGHo6B3xUhBL/6aFwF8goho=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x49LiG2J124075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 May 2019 16:44:16 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 9 May
 2019 16:44:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 9 May 2019 16:44:16 -0500
Received: from [10.250.146.137] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x49LiBmv083926;
        Thu, 9 May 2019 16:44:12 -0500
Subject: Re: [PATCH v3 09/11] platform/x86: asus-wmi: Control RGB keyboard
 backlight
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
 <2f26dd9e-ada7-8e20-c810-a647854c338c@ti.com>
 <CAHp75VcSVumVg74==bM3cBcZZ2iUNDnUao6h9Q6ktcyEuAKDew@mail.gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <962ec05e-b4ca-89b7-405c-f8a76f19427c@ti.com>
Date:   Thu, 9 May 2019 16:44:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcSVumVg74==bM3cBcZZ2iUNDnUao6h9Q6ktcyEuAKDew@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andy

On 5/9/19 4:06 PM, Andy Shevchenko wrote:
> On Thu, May 9, 2019 at 11:45 PM Dan Murphy <dmurphy@ti.com> wrote:
>> On 5/9/19 2:04 PM, Yurii Pavlovskyi wrote:
>> We are working on a framework for this.
>>
>> Please see this series
>> https://lore.kernel.org/patchwork/project/lkml/list/?series=390141
>>
>> It is still a work in progress
> 
> Side question:
> Have you considered to convert existing color LED controllers? (It
> seems to me that your proposal lacks of the idea to keep back
> compatibility with the existing controllers whre user may create a
> sysfs node based on the arbitrary label, while it's good to have
> multicolor infrastructure like in your proposal. Did I miss
> something?)
> 
> 

Yes that is part of the work that is in progress.
The LED driver should be able to register either a single color LED or a group of colored LEDs.

This can be based on a firmware entry and which LED framework the driver chooses to register to. Either the
multicolor framework or the base LED framework.  Of course we can put this in code and keep it
out of the firmware nodes again thats why it is wip.

I have convert a couple of drivers over in my testing that support RGB modules or have a RGB cluter used to mix
colors.

If the product wants to expose a single red LED via the label then they use legacy registration.
If the product wants to expose RGBW as a single group then the multicolor framework should be registered too.


Dan
