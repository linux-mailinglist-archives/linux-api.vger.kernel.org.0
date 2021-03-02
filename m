Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0532B2F1
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbhCCDCM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 2 Mar 2021 22:02:12 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48615 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444947AbhCBMvB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 07:51:01 -0500
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id CE2FE3A6AA8;
        Tue,  2 Mar 2021 12:50:05 +0000 (UTC)
Received: from xps13 (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 537E9240002;
        Tue,  2 Mar 2021 12:46:19 +0000 (UTC)
Date:   Tue, 2 Mar 2021 13:46:17 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor.Ambarus@microchip.com
Subject: Re: [RFC PATCH] mtd: add OTP (one-time-programmable) erase ioctl
Message-ID: <20210302134617.5aa78cc4@xps13>
In-Reply-To: <20210302110927.6520-1-michael@walle.cc>
References: <20210302110927.6520-1-michael@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Michael,

Michael Walle <michael@walle.cc> wrote on Tue,  2 Mar 2021 12:09:27
+0100:

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

Should we add a sanity check enforcing that we don't try to access
beyond the end of the OTP area?

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
>  /*
>   * Obsolete legacy interface. Keep it in order not to break userspace

Thanks,
Miquèl
