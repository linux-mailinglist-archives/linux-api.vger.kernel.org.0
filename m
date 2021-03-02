Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5397732B022
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbhCCDEK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 22:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839547AbhCBQhe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 11:37:34 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7205EC0611C0;
        Tue,  2 Mar 2021 08:23:14 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 19B5B2223E;
        Tue,  2 Mar 2021 17:19:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614701999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuTN0p7yoea8OaPYplG4dv/ZSs9CaBQssC3fqW0ZAFA=;
        b=ejCHgp85SnGbT6uEwty1tPTE6unz8gq+0ryV/1pxYRiLxQ0VK7iFUsMx5auwlFuEoGsjhU
        IHxjwdVs6hpwBxhPNT43kps4ekMNXHBOUWcfFzzWszwdGzjxS5NiZtz0hvYxWwbglyMyL8
        CpVGbFAbrwztYCVylE3oQ8Gr9ge97Yc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Mar 2021 17:19:55 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor.Ambarus@microchip.com
Subject: Re: [RFC PATCH] mtd: add OTP (one-time-programmable) erase ioctl
In-Reply-To: <b106264e-987f-cecc-28cb-0724d4af1f4c@ti.com>
References: <20210302110927.6520-1-michael@walle.cc>
 <b106264e-987f-cecc-28cb-0724d4af1f4c@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <74df918148be8c9820acc877e39adf3f@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am 2021-03-02 16:30, schrieb Vignesh Raghavendra:
> Hi,
> 
> On 3/2/21 4:39 PM, Michael Walle wrote:
>> This may sound like a contradiction but some SPI-NOR flashes really
>> support erasing their OTP region until it is finally locked. Having 
>> the
>> possibility to erase an OTP region might come in handy during
>> development.
>> 
>> The ioctl argument follows the OTPLOCK style.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> OTP support for SPI-NOR flashes may be merged soon:
>> https://lore.kernel.org/linux-mtd/20210216162807.13509-1-michael@walle.cc/
>> 
>> Tudor suggested to add support for the OTP erase operation most 
>> SPI-NOR
>> flashes have:
>> https://lore.kernel.org/linux-mtd/d4f74b1b-fa1b-97ec-858c-d807fe1f9e57@microchip.com/
>> 
>> Therefore, this is an RFC to get some feedback on the MTD side, once 
>> this
>> is finished, I can post a patch for mtd-utils. Then we'll have a 
>> foundation
>> to add the support to SPI-NOR.
>> 
>>  drivers/mtd/mtdchar.c      |  7 ++++++-
>>  drivers/mtd/mtdcore.c      | 12 ++++++++++++
>>  include/linux/mtd/mtd.h    |  3 +++
>>  include/uapi/mtd/mtd-abi.h |  2 ++
>>  4 files changed, 23 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
>> index 323035d4f2d0..da423dd031ae 100644
>> --- a/drivers/mtd/mtdchar.c
>> +++ b/drivers/mtd/mtdchar.c
>> @@ -661,6 +661,7 @@ static int mtdchar_ioctl(struct file *file, u_int 
>> cmd, u_long arg)
>>  	case OTPGETREGIONCOUNT:
>>  	case OTPGETREGIONINFO:
>>  	case OTPLOCK:
>> +	case OTPERASE:
> 
> This is not a Safe IOCTL. We are destroying OTP data. Need to check for
> write permission before allowing the ioctl right?

Ah yes, of course. But this makes me wonder why OTPLOCK
is considered a safe command. As well as MEMLOCK and
MEMUNLOCK. And MEMSETBADBLOCK. Shouldn't these also
require write permissions?

>>  	case ECCGETLAYOUT:
>>  	case ECCGETSTATS:
>>  	case MTDFILEMODE:
>> @@ -938,6 +939,7 @@ static int mtdchar_ioctl(struct file *file, u_int 
>> cmd, u_long arg)
>>  	}
>> 
>>  	case OTPLOCK:
>> +	case OTPERASE:
>>  	{
>>  		struct otp_info oinfo;
>> 
>> @@ -945,7 +947,10 @@ static int mtdchar_ioctl(struct file *file, u_int 
>> cmd, u_long arg)
>>  			return -EINVAL;
>>  		if (copy_from_user(&oinfo, argp, sizeof(oinfo)))
>>  			return -EFAULT;
>> -		ret = mtd_lock_user_prot_reg(mtd, oinfo.start, oinfo.length);
>> +		if (cmd == OTPLOCK)
>> +			ret = mtd_lock_user_prot_reg(mtd, oinfo.start, oinfo.length);
>> +		else
>> +			ret = mtd_erase_user_prot_reg(mtd, oinfo.start, oinfo.length);
>>  		break;
>>  	}
>> 
>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>> index 2d6423d89a17..d844d718ef77 100644
>> --- a/drivers/mtd/mtdcore.c
>> +++ b/drivers/mtd/mtdcore.c
>> @@ -1918,6 +1918,18 @@ int mtd_lock_user_prot_reg(struct mtd_info 
>> *mtd, loff_t from, size_t len)
>>  }
>>  EXPORT_SYMBOL_GPL(mtd_lock_user_prot_reg);
>> 
>> +int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t 
>> len)
>> +{
>> +	struct mtd_info *master = mtd_get_master(mtd);
>> +
>> +	if (!master->_erase_user_prot_reg)
>> +		return -EOPNOTSUPP;
>> +	if (!len)
>> +		return 0;
>> +	return master->_erase_user_prot_reg(master, from, len);
>> +}
>> +EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
>> +
>>  /* Chip-supported device locking */
>>  int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>>  {
>> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
>> index 157357ec1441..734ad7a8c353 100644
>> --- a/include/linux/mtd/mtd.h
>> +++ b/include/linux/mtd/mtd.h
>> @@ -336,6 +336,8 @@ struct mtd_info {
>>  				     size_t len, size_t *retlen, u_char *buf);
>>  	int (*_lock_user_prot_reg) (struct mtd_info *mtd, loff_t from,
>>  				    size_t len);
>> +	int (*_erase_user_prot_reg) (struct mtd_info *mtd, loff_t from,
>> +				     size_t len);
>>  	int (*_writev) (struct mtd_info *mtd, const struct kvec *vecs,
>>  			unsigned long count, loff_t to, size_t *retlen);
>>  	void (*_sync) (struct mtd_info *mtd);
>> @@ -517,6 +519,7 @@ int mtd_read_user_prot_reg(struct mtd_info *mtd, 
>> loff_t from, size_t len,
>>  int mtd_write_user_prot_reg(struct mtd_info *mtd, loff_t to, size_t 
>> len,
>>  			    size_t *retlen, u_char *buf);
>>  int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t 
>> len);
>> +int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t 
>> len);
>> 
>>  int mtd_writev(struct mtd_info *mtd, const struct kvec *vecs,
>>  	       unsigned long count, loff_t to, size_t *retlen);
>> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
>> index 65b9db936557..242015f60d10 100644
>> --- a/include/uapi/mtd/mtd-abi.h
>> +++ b/include/uapi/mtd/mtd-abi.h
>> @@ -205,6 +205,8 @@ struct otp_info {
>>   * without OOB, e.g., NOR flash.
>>   */
>>  #define MEMWRITE		_IOWR('M', 24, struct mtd_write_req)
>> +/* Erase a given range of user data (must be in mode 
>> %MTD_FILE_MODE_OTP_USER) */
>> +#define OTPERASE		_IOR('M', 25, struct otp_info)
>> 
> 
> Hmm, shouldn't this be:
> 
> #define OTPERASE		_IOW('M', 25, struct otp_info)
> 
> Userspace is writing struct otp_info to the driver. OTPLOCK should
> probably be _IOW() as well.

You're right.

NB. most OTP commands have a wrong direction flag.

>>  /*
>>   * Obsolete legacy interface. Keep it in order not to break userspace
>> 

-michael
