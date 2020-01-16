Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD113D0F2
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 01:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbgAPAPK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jan 2020 19:15:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbgAPAPK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jan 2020 19:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PnlXUyX2Z9J9BUtgQuw/WagY/FH8JJ7XcwtkLdBPXwM=; b=Vt/P5eKBXgWFLBOpSwOatXGUg
        00QTm7shnZEbzqSPbFyfx8k8g90D7HafSYy2PRBLTnCmVeuN6wNmQud4K94s1IAkxIZgt4Ye0C7or
        Eeg2w2WkWmoavxaUekc6BgXawxmWW6do8kcoqN0IGnmIIigJjNhJ7gNkqjSM57YkqisS3qaXksN1U
        F5nZKh4AjE0El/zbxg0GZWrUWsotrpJg7d+KLmc934+sMJStJJJQpCHE866flhraExuAH27hcGM2C
        rXtkHw0our8XwJ9uPUeuqyIt4aefByrSXiEqS3jPjkYFiRIH6p62J0MyXuDpwEYNYO/UgFCVScqeu
        DkifUHwWA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irso0-0002DV-QW; Thu, 16 Jan 2020 00:14:36 +0000
Subject: Re: [PATCH v28 06/12] LRNG - add SP800-90A DRBG extension
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
 <12396284.QuoJzrrf7p@positron.chronox.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <55a89cdf-e36d-fb36-29fa-46ebfb139294@infradead.org>
Date:   Wed, 15 Jan 2020 16:14:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <12396284.QuoJzrrf7p@positron.chronox.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/15/20 2:33 AM, Stephan Müller wrote:

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
> Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> Tested-by: Roman Drahtmüller <draht@schaltsekun.de>
> Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Tested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  drivers/char/lrng/Kconfig     |  11 ++
>  drivers/char/lrng/Makefile    |   1 +
>  drivers/char/lrng/lrng_drbg.c | 260 ++++++++++++++++++++++++++++++++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 drivers/char/lrng/lrng_drbg.c
> 
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index cb701bb0b8b6..15fb623d9d1f 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -71,4 +71,15 @@ menuconfig LRNG_DRNG_SWITCH
>  	  accessible via the external interfaces. With this configuration
>  	  option other DRNGs can be selected and loaded at runtime.
>  
> +if LRNG_DRNG_SWITCH
> +config LRNG_DRBG
> +	tristate "SP800-90A support for the LRNG"
> +	select CRYPTO_DRBG_MENU
> +	select CRYPTO_CMAC if CRYPTO_DRBG_CTR

Don't select these if CRYPTO is not already set/enabled.
It causes Kconfig warnings and possible build errors.

> +	help
> +	  Enable the SP800-90A DRBG support for the LRNG. Once the
> +	  module is loaded, output from /dev/random, /dev/urandom,
> +	  getrandom(2), or get_random_bytes is provided by a DRBG.
> +endif # LRNG_DRNG_SWITCH
> +
>  endif # LRNG

> diff --git a/drivers/char/lrng/lrng_drbg.c b/drivers/char/lrng/lrng_drbg.c
> new file mode 100644
> index 000000000000..8bf2badb1fe0
> --- /dev/null
> +++ b/drivers/char/lrng/lrng_drbg.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Backend for the LRNG providing the cryptographic primitives using the
> + * kernel crypto API and its DRBG.
> + *
> + * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <crypto/drbg.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/lrng.h>
> +
> +/*
> + * Define a DRBG plus a hash / MAC used to extract data from the entropy pool.
> + * For LRNG_HASH_NAME you can use a hash or a MAC (HMAC or CMAC) of your choice
> + * (Note, you should use the suggested selections below -- using SHA-1 or MD5
> + * is not wise). The idea is that the used cipher primitive can be selected to
> + * be the same as used for the DRBG. I.e. the LRNG only uses one cipher
> + * primitive using the same cipher implementation with the options offered in
> + * the following. This means, if the CTR DRBG is selected and AES-NI is present,
> + * both the CTR DRBG and the selected cmac(aes) use AES-NI.
> + *
> + * The security strengths of the DRBGs are all 256 bits according to
> + * SP800-57 section 5.6.1.
> + *
> + * This definition is allowed to be changed.
> + */
> +#ifdef CONFIG_CRYPTO_DRBG_CTR
> +static unsigned int lrng_drbg_type = 0;
> +#elif defined CONFIG_CRYPTO_DRBG_HMAC
> +static unsigned int lrng_drbg_type = 1;
> +#elif defined CONFIG_CRYPTO_DRBG_HASH
> +static unsigned int lrng_drbg_type = 2;
> +#else
> +#error "Unknown DRBG in use"
> +#endif
> +
> +/* The parameter must be r/o in sysfs as otherwise races appear. */
> +module_param(lrng_drbg_type, uint, 0444);
> +MODULE_PARM_DESC(lrng_drbg_type, "DRBG type used for LRNG (0->CTR_DRBG, "
> +				 "1->HMAC_DRBG, 2->Hash_DRBG)");

One line for the string, please, not split.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
