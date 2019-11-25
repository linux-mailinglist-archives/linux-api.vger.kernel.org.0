Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C321088B3
	for <lists+linux-api@lfdr.de>; Mon, 25 Nov 2019 07:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfKYGbU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 Nov 2019 01:31:20 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:8085 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKYGbU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Nov 2019 01:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574663474;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5eCeta8MKcJIfHvMVLppIqd/LCwgywvnaMFjyKsCE0U=;
        b=Jz7a4VxDoAajqASofz+4R/k5FS4obxNH+vDsL/IunuTTEJV+tCDQS2/eoJjAsQHBKv
        2WCePWn6SJdvGLOzTzkBknA13fvkJcdlgrN7gakEphLPAdCcSUTc1kVL0BAI0oMjwPKx
        bjtuMoVhUpzg/Gsv0Dr35N5T+d4EhN2zgQEAK1+ulj2TqwsoPrlQyvlRK4k/CGDP+TmI
        Ut7tKOYAC6a+8j8np9laaYhs1CAgETcZqJb41t/saLrEXI2zwcEr5A7C+NgKACOw1FyM
        eWfFPWMQozlJcHPpSHxtj4QAk/BpPyQbC+J4YXoR2i0r+uyRYZqDFHMv0evC60DllkE0
        meKw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSbPHo="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAP6Te8o5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 25 Nov 2019 07:29:40 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
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
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v26 01/12] Linux Random Number Generator
Date:   Mon, 25 Nov 2019 07:29:40 +0100
Message-ID: <1779530.Tceqp9pKDQ@tauon.chronox.de>
In-Reply-To: <201911250614.ZLzn1B8q%lkp@intel.com>
References: <4092523.WvKr7FP7fE@positron.chronox.de> <201911250614.ZLzn1B8q%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Sonntag, 24. November 2019, 23:44:13 CET schrieb kbuild test robot:

Hi kbuild,

> Hi "Stephan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on char-misc/char-misc-testing]
> [also build test ERROR on v5.4-rc8 next-20191122]
> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system. BTW, we also suggest to use '--base' option to
> specify the base tree in git format-patch, please see
> https://stackoverflow.com/a/37406982]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-ap
> proach-with-full-SP800-90B/20191125-042152 base:  
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> b78cda795ac83333293f1bfa3165572a47e550c2 config: sh-allmodconfig (attached
> as .config)
> compiler: sh4-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
> ~/bin/make.cross chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=sh
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/printk.h:6:0,
>                     from include/linux/kernel.h:15,
>                     from include/asm-generic/bug.h:19,
>                     from arch/sh/include/asm/bug.h:112,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/percpu.h:5,
>                     from include/asm-generic/irq_regs.h:11,
>                     from ./arch/sh/include/generated/asm/irq_regs.h:1,
> 
>                     from drivers/char/lrng/lrng_pool.c:10:
> >> drivers/char/lrng/lrng_pool.c:216:15: error: initialization from
> >> incompatible pointer type [-Werror=incompatible-pointer-types]

The function prototype needs to return an int - I wonder why that did not show 
in my x86 compile run.

It will be fixed in the next set.

>     core_initcall(lrng_init_time_source);
>                   ^
>    include/linux/init.h:197:50: note: in definition of macro
> '___define_initcall' __attribute__((__section__(#__sec ".init"))) = fn;
>                                                      ^~
>    include/linux/init.h:218:28: note: in expansion of macro
> '__define_initcall' #define core_initcall(fn)  __define_initcall(fn, 1)
>                                ^~~~~~~~~~~~~~~~~
> 
> >> drivers/char/lrng/lrng_pool.c:216:1: note: in expansion of macro
> >> 'core_initcall'
>     core_initcall(lrng_init_time_source);
>     ^~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +216 drivers/char/lrng/lrng_pool.c
> 
>    215
> 
>  > 216	core_initcall(lrng_init_time_source);
> 
>    217
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology
> Center https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel
> Corporation



Ciao
Stephan


