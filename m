Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE0A13D0F5
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 01:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgAPAQW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jan 2020 19:16:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgAPAQW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jan 2020 19:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7u+WlEBhsp1gkriNX6Iac42b3jLX93SD/7RSh7qn1JQ=; b=p2HygVnAu42U6LDQB4yU7bUpQ
        JQmEQK5nPR4zGPQUozwCaKdHvldcA3Zy1r40HuSqtDCVrR3f4Up13FxoL1Kqm4vCQerIhukniLqTK
        lCi5WMRmKWp6jWB1INfMVXEn0tVfrxGoGOjtAslynH2BLzGdhPNJzPSh3H646C/MGm4rmPcGmY5HW
        7BlhisMwO5vUy6K9HHp25ZVTdgi4F4Skp5CirX8XZTGrQKEmeeEIkvb/bFtcCfQw54xIwQAPNkW91
        buEdul83/LlzJJB460Y0Ew2Z6HW3cUMA1Kfnlcbm8D4kpuqyaRoBjfJArNtxlsj6QAV8hGQcJdbsh
        p7ja7BjKA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irspA-0003WX-Ce; Thu, 16 Jan 2020 00:15:48 +0000
Subject: Re: [PATCH v28 07/12] LRNG - add kernel crypto API PRNG extension
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
 <526421170.FD02tCEzJt@positron.chronox.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d98e7a45-3d1b-8119-1ed0-87aea0f3c6f3@infradead.org>
Date:   Wed, 15 Jan 2020 16:15:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <526421170.FD02tCEzJt@positron.chronox.de>
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
>  drivers/char/lrng/Kconfig      |  10 +
>  drivers/char/lrng/Makefile     |   1 +
>  drivers/char/lrng/lrng_kcapi.c | 327 +++++++++++++++++++++++++++++++++
>  3 files changed, 338 insertions(+)
>  create mode 100644 drivers/char/lrng/lrng_kcapi.c
> 
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index 15fb623d9d1f..0d070a3897dd 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -80,6 +80,16 @@ config LRNG_DRBG
>  	  Enable the SP800-90A DRBG support for the LRNG. Once the
>  	  module is loaded, output from /dev/random, /dev/urandom,
>  	  getrandom(2), or get_random_bytes is provided by a DRBG.
> +
> +config LRNG_KCAPI
> +	tristate "Kernel Crypto API support for the LRNG"
> +	select CRYPTO_RNG

Don't select CRYPTO_RNG unless you know that CRYPTO is set/enabled.

> +	help
> +	  Enable the support for generic pseudo-random number
> +	  generators offered by the kernel crypto API with the
> +	  LRNG. Once the module is loaded, output from /dev/random,
> +	  /dev/urandom, getrandom(2), or get_random_bytes is
> +	  provided by the selected kernel crypto API RNG.
>  endif # LRNG_DRNG_SWITCH
>  
>  endif # LRNG


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
