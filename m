Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D800136455
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 01:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgAJAZV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jan 2020 19:25:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730169AbgAJAZV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jan 2020 19:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/f2runeNBw6RnPGtAhc9+ZVQ9RgfOZH+rYsz78EvOG8=; b=PoXKKEJJei3qRhn4QaYaTkEfx
        rYg+orz4hpYeb15+KTic/aiDGubbxAuzN6jjkltLsHmaXtQNxOUyLzf17Eeg5jJQIvgExe4IJfMFu
        y61G6O4Upe3zvP/KH+35vVTPBFjfSuaUEAdtjpb/my9/bfDjTs+FloAB7fBUGhN7MCSucmLpndFND
        4+9gfZJ4gtbw9kwkZ/R0or5HRFfta9TtcZi03VD31opqR7aY9DKWdIRsxiUUkz1BZmozLu48j2EFt
        qhMqOa8wS6Jab0+GxuJAkr2cRzgxfLfXZ8VDlxSmQBTtAIRunNPNARC0OLRfYhlBASnYOH6sO5lOQ
        64nXFY7YA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipi6b-0004L4-8i; Fri, 10 Jan 2020 00:24:49 +0000
Subject: Re: [PATCH v27 09/12] LRNG - add Jitter RNG fast noise source
To:     =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
 <2722222.P16TYeLAVu@positron.chronox.de>
 <2641155.iNH938UiKq@positron.chronox.de>
 <6341883.UacF4FzDma@positron.chronox.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ba976fa-fed1-4720-c039-043160dbce9e@infradead.org>
Date:   Thu, 9 Jan 2020 16:24:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <6341883.UacF4FzDma@positron.chronox.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On 1/9/20 12:34 AM, Stephan Müller wrote:

> ---
>  drivers/char/lrng/Kconfig     | 11 +++++
>  drivers/char/lrng/Makefile    |  1 +
>  drivers/char/lrng/lrng_jent.c | 87 +++++++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 drivers/char/lrng/lrng_jent.c
> 

> diff --git a/drivers/char/lrng/lrng_jent.c b/drivers/char/lrng/lrng_jent.c
> new file mode 100644
> index 000000000000..97c0d192e9c8
> --- /dev/null
> +++ b/drivers/char/lrng/lrng_jent.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * LRNG Fast Noise Source: Jitter RNG
> + *
> + * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/types.h>
> +#include <crypto/internal/jitterentropy.h>
> +
> +#include "lrng_internal.h"
> +
> +/*
> + * Estimated entropy of data is a 16th of LRNG_DRNG_SECURITY_STRENGTH_BITS.
> + * Albeit a full entropy assessment is provided for the noise source indicating
> + * that it provides high entropy rates and considering that it deactivates
> + * when it detects insufficient hardware, the chosen under estimation of
> + * entropy is considered to be acceptable to all reviewers.
> + */
> +static u32 jitterrng = LRNG_DRNG_SECURITY_STRENGTH_BITS>>4;
> +module_param(jitterrng, uint, 0644);
> +MODULE_PARM_DESC(jitterrng, "Entropy in bits of 256 data bits from Jitter "
> +			    "RNG noise source");
> +
> +/**
> + * Get Jitter RNG entropy
> + *
> + * @outbuf buffer to store entropy
> + * @outbuflen length of buffer
> + * @return > 0 on success where value provides the added entropy in bits
> + *	   0 if no fast source was available
> + */

Don't begin the comment block with /**
or convert it to Linux kernel-doc notation format.

> +static struct rand_data *lrng_jent_state;
> +
> +u32 lrng_get_jent(u8 *outbuf, unsigned int outbuflen)
> +{
> +	int ret;
> +	u32 ent_bits = jitterrng;
> +	unsigned long flags;
> +	static DEFINE_SPINLOCK(lrng_jent_lock);
> +	static int lrng_jent_initialized = 0;
> +
> +	spin_lock_irqsave(&lrng_jent_lock, flags);
> +
> +	if (!ent_bits || (lrng_jent_initialized == -1)) {
> +		spin_unlock_irqrestore(&lrng_jent_lock, flags);
> +		return 0;
> +	}
> +
> +	if (!lrng_jent_initialized) {
> +		lrng_jent_state = jent_lrng_entropy_collector();
> +		if (!lrng_jent_state) {
> +			jitterrng = 0;
> +			lrng_jent_initialized = -1;
> +			spin_unlock_irqrestore(&lrng_jent_lock, flags);
> +			pr_info("Jitter RNG unusable on current system\n");
> +			return 0;
> +		}
> +		lrng_jent_initialized = 1;
> +		pr_debug("Jitter RNG working on current system\n");
> +	}
> +	ret = jent_read_entropy(lrng_jent_state, outbuf, outbuflen);
> +	spin_unlock_irqrestore(&lrng_jent_lock, flags);
> +
> +	if (ret) {
> +		pr_debug("Jitter RNG failed with %d\n", ret);
> +		return 0;
> +	}
> +
> +	/* Obtain entropy statement */
> +	if (outbuflen != LRNG_DRNG_SECURITY_STRENGTH_BYTES)
> +		ent_bits = (ent_bits * outbuflen<<3) /
> +			   LRNG_DRNG_SECURITY_STRENGTH_BITS;
> +	/* Cap entropy to buffer size in bits */
> +	ent_bits = min_t(u32, ent_bits, outbuflen<<3);
> +	pr_debug("obtained %u bits of entropy from Jitter RNG noise source\n",
> +		 ent_bits);
> +
> +	return ent_bits;
> +}
> +
> +u32 lrng_jent_entropylevel(void)
> +{
> +	return min_t(u32, jitterrng, LRNG_DRNG_SECURITY_STRENGTH_BITS);
> +}
> 

thanks.
-- 
~Randy

