Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F186E102AA9
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 18:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKSRSi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Nov 2019 12:18:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfKSRSi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 Nov 2019 12:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aYmtuEFF+xOPB8Y3q63c5aivou+rssRsl1ZruqJR3YQ=; b=Xhk2Ba4RE5sQp6Xhrisp9yAdb
        a6kScEfJGorN4s9IyqONGBGD5r+WATKiUvRdIQnzS4br3J7RnbMIEnrmIoCld00T/GpT5aE+5LiR/
        OF0sbcikg0yYYpSsoFudFBK83cuHjU1DclZiT5VgYYIZjvaVzDFWAYZM2kUJwu8RVQBZ49L/gAe/2
        3DDhaEO00s4S+UoRQUxXfGpNwb1jdI/bH94DFda+jGmReOHtsJZCUs8Q9d1GofxsE7vY2xNFWLj2K
        7wEQzVjFDeoSY8altim3LTauF4vMSWHneoYWT9269fKCOZXOjCWjWBkuJwLNcFoNs3TUW6rBFrxA0
        Tc7YVGxBw==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iX78X-0002YZ-J1; Tue, 19 Nov 2019 17:17:57 +0000
Subject: Re: [PATCH v25 12/12] LRNG - add interface for gathering of raw
 entropy
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
        Neil Horman <nhorman@redhat.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
 <2787174.DQlWHN5GGo@positron.chronox.de>
 <3610406.x8mDjznOIz@positron.chronox.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ea5e2cf5-d622-03c1-eb96-7f7e4893ae04@infradead.org>
Date:   Tue, 19 Nov 2019 09:17:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3610406.x8mDjznOIz@positron.chronox.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On 11/16/19 1:38 AM, Stephan Müller wrote:
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index e6ca3acc1e48..4ccc710832ef 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -169,4 +169,20 @@ config LRNG_APT_CUTOFF
>  	default 325 if !LRNG_APT_BROKEN
>  	default 32 if LRNG_APT_BROKEN
>  
> +config LRNG_TESTING
> +	bool "Enable entropy test interface to LRNG noise source"
> +	select CONFIG_DEBUG_FS

	That should be spelled as DEBUG_FS and preferably would be "depends on"
	instead of 'select'.


> +	help
> +	  The test interface allows a privileged process to capture
> +	  the raw unconditioned noise that is collected by the LRNG
> +	  for statistical analysis. Extracted noise data is not used
> +	  to seed the LRNG.
> +
> +	  The raw noise data can be obtained using the lrng_raw
> +	  debugfs file. Using the option lrng_testing.boot_test=1
> +	  the raw noise of the first 1000 entropy events since boot
> +	  can be sampled.
> +
> +	  If unsure, say N.
> +
>  endif # LRNG

thanks.
-- 
~Randy

