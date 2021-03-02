Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FC32B035
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbhCCDFA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 22:05:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40748 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577221AbhCBSew (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 13:34:52 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 122FUAeU117081;
        Tue, 2 Mar 2021 09:30:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614699010;
        bh=XY9GrYoBtIXthyWuNY6TPQxiQEz+xHQrzqPT/wtKqbw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UokPXdDqLwE75ptLZwzXmbE+AmnhfCwm9SbRtcDFaVm8ZC/1vf+b5WX5Oky8/XjnA
         UdRFNDHgxfCWgjpuyDvN0pWcVCfq7t4Aevh6IT00/0kgXzRkj46ZYb5+M9lJbkFKBo
         xIfhoBxflve5g0d4mNJ5eap+agBsNJNe+su5ZJlw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 122FUAoN065541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Mar 2021 09:30:10 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Mar
 2021 09:30:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Mar 2021 09:30:09 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 122FU6QY102733;
        Tue, 2 Mar 2021 09:30:07 -0600
Subject: Re: [RFC PATCH] mtd: add OTP (one-time-programmable) erase ioctl
To:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <Tudor.Ambarus@microchip.com>
References: <20210302110927.6520-1-michael@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b106264e-987f-cecc-28cb-0724d4af1f4c@ti.com>
Date:   Tue, 2 Mar 2021 21:00:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302110927.6520-1-michael@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On 3/2/21 4:39 PM, Michael Walle wrote:
> This may sound like a contradiction but some SPI-NOR flashes really
> support erasing their OTP region until it is finally locked. Having the
> possibility to erase an OTP region might come in handy during
> development.
> 
> The ioctl argument follows the OTPLOCK style.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> OTP support for SPI-NOR flashes may be merged soon:
> https://lore.kernel.org/linux-mtd/20210216162807.13509-1-michael@walle.cc/
> 
> Tudor suggested to add support for the OTP erase operation most SPI-NOR
> flashes have:
> https://lore.kernel.org/linux-mtd/d4f74b1b-fa1b-97ec-858c-d807fe1f9e57@microchip.com/
> 
> Therefore, this is an RFC to get some feedback on the MTD side, once this
> is finished, I can post a patch for mtd-utils. Then we'll have a foundation
> to add the support to SPI-NOR.
> 
>  drivers/mtd/mtdchar.c      |  7 ++++++-
>  drivers/mtd/mtdcore.c      | 12 ++++++++++++
>  include/linux/mtd/mtd.h    |  3 +++
>  include/uapi/mtd/mtd-abi.h |  2 ++
>  4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 323035d4f2d0..da423dd031ae 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -661,6 +661,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>  	case OTPGETREGIONCOUNT:
>  	case OTPGETREGIONINFO:
>  	case OTPLOCK:
> +	case OTPERASE:

This is not a Safe IOCTL. We are destroying OTP data. Need to check for
write permission before allowing the ioctl right?

>  	case ECCGETLAYOUT:
>  	case ECCGETSTATS:
>  	case MTDFILEMODE:
> @@ -938,6 +939,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>  	}
>  
>  	case OTPLOCK:
> +	case OTPERASE:
>  	{
>  		struct otp_info oinfo;
>  
> @@ -945,7 +947,10 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>  			return -EINVAL;
>  		if (copy_from_user(&oinfo, argp, sizeof(oinfo)))
>  			return -EFAULT;
> -		ret = mtd_lock_user_prot_reg(mtd, oinfo.start, oinfo.length);
> +		if (cmd == OTPLOCK)
> +			ret = mtd_lock_user_prot_reg(mtd, oinfo.start, oinfo.length);
> +		else
> +			ret = mtd_erase_user_prot_reg(mtd, oinfo.start, oinfo.length);
>  		break;
>  	}
>  
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 2d6423d89a17..d844d718ef77 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1918,6 +1918,18 @@ int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(mtd_lock_user_prot_reg);
>  
> +int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
> +{
> +	struct mtd_info *master = mtd_get_master(mtd);
> +
> +	if (!master->_erase_user_prot_reg)
> +		return -EOPNOTSUPP;
> +	if (!len)
> +		return 0;
> +	return master->_erase_user_prot_reg(master, from, len);
> +}
> +EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
> +
>  /* Chip-supported device locking */
>  int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  {
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 157357ec1441..734ad7a8c353 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -336,6 +336,8 @@ struct mtd_info {
>  				     size_t len, size_t *retlen, u_char *buf);
>  	int (*_lock_user_prot_reg) (struct mtd_info *mtd, loff_t from,
>  				    size_t len);
> +	int (*_erase_user_prot_reg) (struct mtd_info *mtd, loff_t from,
> +				     size_t len);
>  	int (*_writev) (struct mtd_info *mtd, const struct kvec *vecs,
>  			unsigned long count, loff_t to, size_t *retlen);
>  	void (*_sync) (struct mtd_info *mtd);
> @@ -517,6 +519,7 @@ int mtd_read_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
>  int mtd_write_user_prot_reg(struct mtd_info *mtd, loff_t to, size_t len,
>  			    size_t *retlen, u_char *buf);
>  int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len);
> +int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len);
>  
>  int mtd_writev(struct mtd_info *mtd, const struct kvec *vecs,
>  	       unsigned long count, loff_t to, size_t *retlen);
> diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
> index 65b9db936557..242015f60d10 100644
> --- a/include/uapi/mtd/mtd-abi.h
> +++ b/include/uapi/mtd/mtd-abi.h
> @@ -205,6 +205,8 @@ struct otp_info {
>   * without OOB, e.g., NOR flash.
>   */
>  #define MEMWRITE		_IOWR('M', 24, struct mtd_write_req)
> +/* Erase a given range of user data (must be in mode %MTD_FILE_MODE_OTP_USER) */
> +#define OTPERASE		_IOR('M', 25, struct otp_info)
>  

Hmm, shouldn't this be:

#define OTPERASE		_IOW('M', 25, struct otp_info)

Userspace is writing struct otp_info to the driver. OTPLOCK should
probably be _IOW() as well.

>  /*
>   * Obsolete legacy interface. Keep it in order not to break userspace
> 

Regards
Vignesh
