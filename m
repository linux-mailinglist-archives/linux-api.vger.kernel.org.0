Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088FA136450
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 01:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgAJAXZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jan 2020 19:23:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgAJAXZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jan 2020 19:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KHYqPOLkvD0DruHaQLvI+6S0eV5ygHhxNMiENbeQCNo=; b=Yb89A2gvn+1hy4rS/2JNVOaHs
        QZWgF57IYhbnSQQQOTuOe6Aa0UNp7kTyuUVHPxK3KL793c+uzrrLMoIIUz+FAck5UuP0FLBiPLk9H
        fiOvgxTl0FG5Bl8IYo6Q9qLltGiSfxShteNWSIEAX5Zj0HKd06QASrk4kwZ+jRRJuyEBkqVEpcyoc
        +H1CZGxDdBiaPX9eAQ2GTf9auakmhm1Oxp7L4Yb5pvuy6i5R5OmHFZOOqk5tB1XMnjOXy7QlKQhfe
        lxZlNYvWSkEz7uT9KzXw0QypWL0PSUHboONZ12GVBPxktOP++70hYLSCx2D4YmUGVlX/v45T79urh
        soxbRylYg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipi4j-0004Ao-09; Fri, 10 Jan 2020 00:22:53 +0000
Subject: Re: [PATCH v27 12/12] LRNG - add power-on and runtime self-tests
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
 <2355906.JbblJTOqSk@positron.chronox.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2f225250-c1e1-c6e1-026c-9c63853ab7d1@infradead.org>
Date:   Thu, 9 Jan 2020 16:22:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <2355906.JbblJTOqSk@positron.chronox.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On 1/9/20 12:35 AM, Stephan Müller wrote:

> ---
>  drivers/char/lrng/Kconfig         |  25 ++
>  drivers/char/lrng/Makefile        |   1 +
>  drivers/char/lrng/lrng_selftest.c | 418 ++++++++++++++++++++++++++++++
>  3 files changed, 444 insertions(+)
>  create mode 100644 drivers/char/lrng/lrng_selftest.c
> 
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index 394066aa5a86..e9827e7df715 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -175,4 +175,29 @@ config LRNG_TESTING
>  
>  	  If unsure, say N.
>  
> +config LRNG_SELFTEST
> +	bool "Enable power-on and on-demand self-tests"
> +	help
> +	  The power-on self tests are executed during boot time

	               self-tests

> +	  covering the ChaCha20 DRNG, the LFSR processing and the
> +	  time stamp management of the LRNG.
> +
> +	  The on-demand self-tests are triggered by writing any
> +	  value into the SysFS file selftest_status. At the same
> +	  time, when reading this file, the test status is
> +	  returned. A zero indicates that all tests were executed
> +	  successfully.
> +
> +	  If unsure, say Y.
> +
> +if LRNG_SELFTEST
> +
> +config LRNG_SELFTEST_PANIC
> +	bool "Panic the kernel upon self-test failure"
> +	help
> +	  If the option is enabled, the kernel is terminated if an
> +	  LRNG power-on self-test failure is detected.
> +
> +endif # LRNG_SELFTEST
> +
>  endif # LRNG


-- 
~Randy

