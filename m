Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2671FF9DF8
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2019 00:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLXQc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 18:16:32 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:28157 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLXQc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Nov 2019 18:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573600589;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7kNs8lG7ZeENLZX3h1otTzpdSsihM3PdKDO/39lmNXI=;
        b=f1qmCoURneJmYHeF8L2ad+5BQ1HHkhwG50xx3Y2uZ9EO6VDdUaUNZMzs9Ro8m9lhzc
        CF2KJQqjF+Ubor/pvB09HDyo+vViEV7XGvKX+PE+/a3Z4v6cG9IGwjEiLJcf+Y0ZO7Li
        dUlKO8MPFC+mVL0dH5CppFq5JfHpYGPskM0E6faBYOZCPu46QGoYdR1i/XDkRzr4vsRO
        2pKRvYrmOWo3G164IyPzbWNG/8NoBioKIYFvBjaFFJz92/C8CN075cN0g1vdbIP0S7f1
        1Pxpq6LVEpDF5XZraXqUw1XIvPSNd5LSqM52aw6BraZl+z7oZbtlVjWl0BqlRh5kN/EO
        g/sA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmwdNLqV/Nz7PsNPEA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id N09a57vACNFKA48
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 00:15:20 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v24 01/12] Linux Random Number Generator
Date:   Wed, 13 Nov 2019 00:15:18 +0100
Message-ID: <2207651.LDDDoSycXZ@positron.chronox.de>
In-Reply-To: <201911130648.YIqEERFA%lkp@intel.com>
References: <2369119.jSEA3qhmGI@positron.chronox.de> <201911130648.YIqEERFA%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 12. November 2019, 23:30:29 CET schrieb kbuild test robot:

Hi kbuild,

> Hi "Stephan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on char-misc/char-misc-testing]
> [also build test ERROR on v5.4-rc7 next-20191112]
> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system. BTW, we also suggest to use '--base' option to
> specify the base tree in git format-patch, please see
> https://stackoverflow.com/a/37406982]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-ap
> proach-with-full-SP800-90B-compliance/20191113-040847 base:  
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> 01b59c763fe2de845b65900485b141fdd7bbf93e config:
> i386-randconfig-f003-201945 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:0:0:
> 
>    include/linux/lrng.h: In function 'lrng_set_drng_cb':
> >> include/linux/lrng.h:80:61: error: 'EOPNOTSUPP' undeclared (first use in
> >> this function)

I need to include errno.h in lrng.h.

Thank you, it will be fixed in the next installment.

>     lrng_set_drng_cb(const struct lrng_crypto_cb *cb) { return -EOPNOTSUPP;
> } ^~~~~~~~~~ include/linux/lrng.h:80:61: note: each undeclared identifier
> is reported only once for each function it appears in
> 
> vim +/EOPNOTSUPP +80 include/linux/lrng.h
> 
>     74
>     75	/* Register cryptographic backend */
>     76	#ifdef CONFIG_LRNG_DRNG_SWITCH
>     77	int lrng_set_drng_cb(const struct lrng_crypto_cb *cb);
>     78	#else	/* CONFIG_LRNG_DRNG_SWITCH */
>     79	static inline int
> 
>   > 80	lrng_set_drng_cb(const struct lrng_crypto_cb *cb) { return
>   > -EOPNOTSUPP; }
>     81	#endif	/* CONFIG_LRNG_DRNG_SWITCH */
>     82
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology
> Center https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel
> Corporation


Ciao
Stephan


