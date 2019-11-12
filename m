Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B26F9DE4
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2019 00:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKLXOV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 18:14:21 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:27973 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKLXOU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Nov 2019 18:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573600458;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=VtgFCnJQ28ddShV9oBzN0C3DruOGikYUIYBF103YZk4=;
        b=QSYazGdgv+homWRpsX7658WQKmqv6RthXGBMoXvQPpvmne0/8KVZSZS7RHPYQNZKJY
        Mqj+gxdSWv/2Td2CNqrXQg/GL8zSb8BMu/p2HWjgEXSG0RXzz6dgEI901vcDEB5w0dcQ
        vxHqhIbRqLJDHsApWhlYJnjja6jGHXtBaz2q9gAuIHgZxf+3hWO688ZHpO6unldp1P/w
        p3bBX+EDBKnK6Pozk+cOmbFUTVyulzR++PxBmariQCUGD4wPUzVM5MlAGlFi0VUFpBrD
        zshC/amxP5WfTXWOIp4MRXu6QEAkgxJRKC+6/T25vCJxf+mMpKTs8yNCfMhF7z+eY+cD
        Sf3A==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmwdNLqV/Nz7PsNPEA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id N09a57vACNDBA3X
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 00:13:11 +0100 (CET)
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
Subject: Re: [PATCH v24 12/12] LRNG - add interface for gathering of raw entropy
Date:   Wed, 13 Nov 2019 00:13:09 +0100
Message-ID: <16924163.rk3kQpxnsR@positron.chronox.de>
In-Reply-To: <201911130440.pXLcGJwR%lkp@intel.com>
References: <3516786.qqN2r2gKvT@positron.chronox.de> <201911130440.pXLcGJwR%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 12. November 2019, 21:55:10 CET schrieb kbuild test robot:

Hi kbuild,

> Hi "Stephan,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on char-misc/char-misc-testing]
> [also build test WARNING on v5.4-rc7 next-20191111]
> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system. BTW, we also suggest to use '--base' option to
> specify the base tree in git format-patch, please see
> https://stackoverflow.com/a/37406982]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-ap
> proach-with-full-SP800-90B-compliance/20191113-040847 base:  
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> 01b59c763fe2de845b65900485b141fdd7bbf93e config: sh-allmodconfig (attached
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
> All warnings (new ones prefixed by >>):
> 
>    drivers/char/lrng/lrng_testing.c: In function 'lrng_raw_extract_user':
> >> drivers/char/lrng/lrng_testing.c:237:1: warning: the frame size of 1076
> >> bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     }
>     ^
> 
> vim +237 drivers/char/lrng/lrng_testing.c
> 
>    196
>   
> 197	/**********************************************************************
> **** 198	 * Debugfs interface
>    199	
> **************************************************************************/
> 200	static int lrng_raw_extract_user(void __user *buf, size_t nbytes) 201	{
>    202		u8 tmp[LRNG_TESTING_RINGBUFFER_SIZE] 
__aligned(sizeof(u32));

This is the offending line.

I will need to kzalloc the code here.

Thank you.

>    203		int ret = 0, large_request = (nbytes > 256);
>    204
>    205		while (nbytes) {
>    206			int i;
>    207
>    208			if (large_request && need_resched()) {
>    209				if (signal_pending(current)) {
>    210					if (ret == 0)
>    211						ret = -ERESTARTSYS;
>    212					break;
>    213				}
>    214				schedule();
>    215			}
>    216
>    217			i = min_t(int, nbytes, sizeof(tmp));
>    218			i = lrng_raw_entropy_reader(tmp, i);
>    219			if (i <= 0) {
>    220				if (i < 0)
>    221					ret = i;
>    222				break;
>    223			}
>    224			if (copy_to_user(buf, tmp, i)) {
>    225				ret = -EFAULT;
>    226				break;
>    227			}
>    228
>    229			nbytes -= i;
>    230			buf = (u8 *)buf + i;
>    231			ret += i;
>    232		}
>    233
>    234		memzero_explicit(tmp, sizeof(tmp));
>    235
>    236		return ret;
> 
>  > 237	}
> 
>    238
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology
> Center https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel
> Corporation


Ciao
Stephan


