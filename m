Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2032B026
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbhCCDEm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 22:04:42 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:41937 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344137AbhCBRAw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 12:00:52 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C75A72223E;
        Tue,  2 Mar 2021 17:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614704371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JlHuWOPny519lb/zyMBEgaPndadrigbre2ILZ7KICM=;
        b=aIsuZAW7/uUq74cQH1wwlv/1J3mx4NjhSE0hH9sfWpgoSOpOGr20SMjMytSNk/22A0IEy1
        PuuqQofyh3kiJq25UbGJEB0hyYU5+FP9so/6u1mzW5D5Sn0qy4VIW+RR5NVFZ/4slQeHBe
        o8U3Dia5iS2yciyNfdM6sj1y0jbt2fs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 02 Mar 2021 17:59:31 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor.Ambarus@microchip.com
Subject: Re: [RFC PATCH] mtd: add OTP (one-time-programmable) erase ioctl
In-Reply-To: <a4464459-dc49-d5de-d969-b9ea96b025d6@ti.com>
References: <20210302110927.6520-1-michael@walle.cc>
 <b106264e-987f-cecc-28cb-0724d4af1f4c@ti.com>
 <74df918148be8c9820acc877e39adf3f@walle.cc>
 <a4464459-dc49-d5de-d969-b9ea96b025d6@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <be9c984f7366aa891591f4e2d003a8b1@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am 2021-03-02 17:33, schrieb Vignesh Raghavendra:
> On 3/2/21 9:49 PM, Michael Walle wrote:
>> Am 2021-03-02 16:30, schrieb Vignesh Raghavendra:
>>> Hi,
>>> 
>>> On 3/2/21 4:39 PM, Michael Walle wrote:
>>>> This may sound like a contradiction but some SPI-NOR flashes really
>>>> support erasing their OTP region until it is finally locked. Having 
>>>> the
>>>> possibility to erase an OTP region might come in handy during
>>>> development.
>>>> 
>>>> The ioctl argument follows the OTPLOCK style.
>>>> 
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>> ---
>>>> OTP support for SPI-NOR flashes may be merged soon:
>>>> https://lore.kernel.org/linux-mtd/20210216162807.13509-1-michael@walle.cc/
>>>> 
>>>> 
>>>> Tudor suggested to add support for the OTP erase operation most 
>>>> SPI-NOR
>>>> flashes have:
>>>> https://lore.kernel.org/linux-mtd/d4f74b1b-fa1b-97ec-858c-d807fe1f9e57@microchip.com/
>>>> 
>>>> 
>>>> Therefore, this is an RFC to get some feedback on the MTD side, once
>>>> this
>>>> is finished, I can post a patch for mtd-utils. Then we'll have a
>>>> foundation
>>>> to add the support to SPI-NOR.
>>>> 
>>>>  drivers/mtd/mtdchar.c      |  7 ++++++-
>>>>  drivers/mtd/mtdcore.c      | 12 ++++++++++++
>>>>  include/linux/mtd/mtd.h    |  3 +++
>>>>  include/uapi/mtd/mtd-abi.h |  2 ++
>>>>  4 files changed, 23 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
>>>> index 323035d4f2d0..da423dd031ae 100644
>>>> --- a/drivers/mtd/mtdchar.c
>>>> +++ b/drivers/mtd/mtdchar.c
>>>> @@ -661,6 +661,7 @@ static int mtdchar_ioctl(struct file *file, 
>>>> u_int
>>>> cmd, u_long arg)
>>>>      case OTPGETREGIONCOUNT:
>>>>      case OTPGETREGIONINFO:
>>>>      case OTPLOCK:
>>>> +    case OTPERASE:
>>> 
>>> This is not a Safe IOCTL. We are destroying OTP data. Need to check 
>>> for
>>> write permission before allowing the ioctl right?
>> 
>> Ah yes, of course. But this makes me wonder why OTPLOCK
>> is considered a safe command. As well as MEMLOCK and
>> MEMUNLOCK. And MEMSETBADBLOCK. Shouldn't these also
>> require write permissions?
>> 
> 
> Well, one argument would be that LOCK/UNLOCK in itself won't modify 
> data
> and thus does not need write permission.. Although can brick a flash
> from ever being writable again and change content of flash registers.

Whether not you can brick a device (I agree with you), it is writing
to the protection bits. But what is more imporant is that OTPLOCK
is actually write-once.

> I am fine with moving these to require write permissions as well
> (probably OTPLOCK as well).

Ok, I'm unsure about MEMSETBADBLOCK, though.

-michael
