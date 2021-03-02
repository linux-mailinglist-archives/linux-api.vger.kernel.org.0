Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282E132B01B
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbhCCDDW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 22:03:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40874 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835100AbhCBQh2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 11:37:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 122GXYPc015348;
        Tue, 2 Mar 2021 10:33:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614702814;
        bh=wld4sEYrbNAw/+pwRpknTrx7MkJjuJSJK47ViMmK7ec=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=p1I5gOxsyqynKIhqVCAAtZE5rD7PoA/eM/u8igWMLLq1wePr4FRPFu5vTnKgIeXol
         WPIQNYIh7JDWV3sAwwXQjJBij0OBxvX0yeyfG3i+FjSEe6NFqhstSF0XzG3SBq7ao1
         qiCq9Ret1Y+wfUpPGxqBr5ViONP7/avZV0alqooI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 122GXYS7064947
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Mar 2021 10:33:34 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Mar
 2021 10:33:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Mar 2021 10:33:33 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 122GXUiH117369;
        Tue, 2 Mar 2021 10:33:31 -0600
Subject: Re: [RFC PATCH] mtd: add OTP (one-time-programmable) erase ioctl
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <Tudor.Ambarus@microchip.com>
References: <20210302110927.6520-1-michael@walle.cc>
 <b106264e-987f-cecc-28cb-0724d4af1f4c@ti.com>
 <74df918148be8c9820acc877e39adf3f@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a4464459-dc49-d5de-d969-b9ea96b025d6@ti.com>
Date:   Tue, 2 Mar 2021 22:03:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <74df918148be8c9820acc877e39adf3f@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 3/2/21 9:49 PM, Michael Walle wrote:
> Am 2021-03-02 16:30, schrieb Vignesh Raghavendra:
>> Hi,
>>
>> On 3/2/21 4:39 PM, Michael Walle wrote:
>>> This may sound like a contradiction but some SPI-NOR flashes really
>>> support erasing their OTP region until it is finally locked. Having the
>>> possibility to erase an OTP region might come in handy during
>>> development.
>>>
>>> The ioctl argument follows the OTPLOCK style.
>>>
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>> OTP support for SPI-NOR flashes may be merged soon:
>>> https://lore.kernel.org/linux-mtd/20210216162807.13509-1-michael@walle.cc/
>>>
>>>
>>> Tudor suggested to add support for the OTP erase operation most SPI-NOR
>>> flashes have:
>>> https://lore.kernel.org/linux-mtd/d4f74b1b-fa1b-97ec-858c-d807fe1f9e57@microchip.com/
>>>
>>>
>>> Therefore, this is an RFC to get some feedback on the MTD side, once
>>> this
>>> is finished, I can post a patch for mtd-utils. Then we'll have a
>>> foundation
>>> to add the support to SPI-NOR.
>>>
>>>  drivers/mtd/mtdchar.c      |  7 ++++++-
>>>  drivers/mtd/mtdcore.c      | 12 ++++++++++++
>>>  include/linux/mtd/mtd.h    |  3 +++
>>>  include/uapi/mtd/mtd-abi.h |  2 ++
>>>  4 files changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
>>> index 323035d4f2d0..da423dd031ae 100644
>>> --- a/drivers/mtd/mtdchar.c
>>> +++ b/drivers/mtd/mtdchar.c
>>> @@ -661,6 +661,7 @@ static int mtdchar_ioctl(struct file *file, u_int
>>> cmd, u_long arg)
>>>      case OTPGETREGIONCOUNT:
>>>      case OTPGETREGIONINFO:
>>>      case OTPLOCK:
>>> +    case OTPERASE:
>>
>> This is not a Safe IOCTL. We are destroying OTP data. Need to check for
>> write permission before allowing the ioctl right?
> 
> Ah yes, of course. But this makes me wonder why OTPLOCK
> is considered a safe command. As well as MEMLOCK and
> MEMUNLOCK. And MEMSETBADBLOCK. Shouldn't these also
> require write permissions?
> 

Well, one argument would be that LOCK/UNLOCK in itself won't modify data
and thus does not need write permission.. Although can brick a flash
from ever being writable again and change content of flash registers.

I am fine with moving these to require write permissions as well
(probably OTPLOCK as well).

[...]
>>> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
>>> index 65b9db936557..242015f60d10 100644
>>> --- a/include/uapi/mtd/mtd-abi.h
>>> +++ b/include/uapi/mtd/mtd-abi.h
>>> @@ -205,6 +205,8 @@ struct otp_info {
>>>   * without OOB, e.g., NOR flash.
>>>   */
>>>  #define MEMWRITE        _IOWR('M', 24, struct mtd_write_req)
>>> +/* Erase a given range of user data (must be in mode
>>> %MTD_FILE_MODE_OTP_USER) */
>>> +#define OTPERASE        _IOR('M', 25, struct otp_info)
>>>
>>
>> Hmm, shouldn't this be:
>>
>> #define OTPERASE        _IOW('M', 25, struct otp_info)
>>
>> Userspace is writing struct otp_info to the driver. OTPLOCK should
>> probably be _IOW() as well.
> 
> You're right.
> 
> NB. most OTP commands have a wrong direction flag.
> 

Unfortunately, yes :(


Regards
Vignesh
