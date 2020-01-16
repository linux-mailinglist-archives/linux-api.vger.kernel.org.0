Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1875713D0FC
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 01:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgAPARk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jan 2020 19:17:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgAPARk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jan 2020 19:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MQr6tj+Mp45NCi5STZEnxYiRcYedUwjyvwRnYKIeYBs=; b=uY1sPTi8qPTWhuGaHChPdG568
        A6N9YE8YuawRE0rXDlxU2rNZNLpKeg0Ikb6FcoQwapUWphNigQS5QgbiDkZoP2Q87W9gldCQ8K3VL
        lpMNupV1/VYJBztc8X6Tfy8RUXCsNDYwHsU3ZhOxrlbpnBVWgdXMUBrjdjl6gwVWqYmx5j3b+GuWn
        KWhCu+YJk7uhblu59dcRVuUb9nAMy2RL5NDWbRtXnim4Obx1Nk1GOSZ3SsiffsmyQ8x1fj62pYOiZ
        BWb685e9T7PSjqNrWJE+LS59E3uVybTEdtIU2aFtd1Te2NukAImJf4rfsOAck81wtWBsWu9z/sqqr
        C4fyJh/0g==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irsqQ-0003a4-T5; Thu, 16 Jan 2020 00:17:06 +0000
Subject: Re: [PATCH v28 09/12] LRNG - add Jitter RNG fast noise source
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
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
 <2641155.iNH938UiKq@positron.chronox.de>
 <5951792.lmNsirYsPE@positron.chronox.de>
 <2704719.5neY5jeiZ3@positron.chronox.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e354fe2f-2040-689a-4293-e1d919f14b74@infradead.org>
Date:   Wed, 15 Jan 2020 16:17:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <2704719.5neY5jeiZ3@positron.chronox.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/15/20 2:34 AM, Stephan Müller wrote:

> 
> CC: "Eric W. Biederman" <ebiederm@xmission.com>
> CC: "Alexander E. Patrakov" <patrakov@gmail.com>
> CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
> CC: "Theodore Y. Ts'o" <tytso@mit.edu>
> CC: Willy Tarreau <w@1wt.eu>
> CC: Matthew Garrett <mjg59@srcf.ucam.org>
> CC: Vito Caputo <vcaputo@pengaru.com>
> CC: Andreas Dilger <adilger.kernel@dilger.ca>
> CC: Jan Kara <jack@suse.cz>
> CC: Ray Strode <rstrode@redhat.com>
> CC: William Jon McCann <mccann@jhu.edu>
> CC: zhangjs <zachary@baishancloud.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Florian Weimer <fweimer@redhat.com>
> CC: Lennart Poettering <mzxreary@0pointer.de>
> CC: Nicolai Stange <nstange@suse.de>
> Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> Tested-by: Roman Drahtmüller <draht@schaltsekun.de>
> Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Tested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  drivers/char/lrng/Kconfig     | 11 +++++
>  drivers/char/lrng/Makefile    |  1 +
>  drivers/char/lrng/lrng_jent.c | 89 +++++++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+)
>  create mode 100644 drivers/char/lrng/lrng_jent.c
> 
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index 0d070a3897dd..10b7cbdb8c8e 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -92,4 +92,15 @@ config LRNG_KCAPI
>  	  provided by the selected kernel crypto API RNG.
>  endif # LRNG_DRNG_SWITCH
>  
> +config LRNG_JENT
> +	bool "Enable Jitter RNG as LRNG Seed Source"
> +	select CRYPTO_JITTERENTROPY

Don't select unless CRYPTO is already set/enabled.

> +	help
> +	  The Linux RNG may use the Jitter RNG as noise source. Enabling
> +	  this option enables the use of the Jitter RNG. Its default
> +	  entropy level is 16 bits of entropy per 256 data bits delivered
> +	  by the Jitter RNG. This entropy level can be changed at boot
> +	  time or at runtime with the lrng_base.jitterrng configuration
> +	  variable.
> +
>  endif # LRNG

> diff --git a/drivers/char/lrng/lrng_jent.c b/drivers/char/lrng/lrng_jent.c
> new file mode 100644
> index 000000000000..ff0bbe2680c4
> --- /dev/null
> +++ b/drivers/char/lrng/lrng_jent.c
> @@ -0,0 +1,89 @@
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

One line for the string, please, not split to 2 lines.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
