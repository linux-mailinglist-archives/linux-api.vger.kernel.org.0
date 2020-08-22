Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0504E24E584
	for <lists+linux-api@lfdr.de>; Sat, 22 Aug 2020 06:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgHVEuS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Aug 2020 00:50:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:11649 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgHVEuR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Aug 2020 00:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598071815;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7jcMal0RXGcmBo3zYahrDP9hAL12aQjPjkXNusGqm2g=;
        b=WEBOQpoXY4w/YsRh/1uCZQ1TZp0zSN3qc4BTFtOEhqzHfKdEmQYcc8RXd/eedD5Odm
        H+q6vwlfX60M6RoCQKVRp8m12qx+7gWmoxey04JOG7f/NjkgDkqtuuBGCL+RKvy0bipZ
        iGb5lpD1lrFdM0xuwsrFa2l7WSlyVDXiJBSFaC+la7E9zThX4G1SkG3+KXiNerDFBVIL
        nKOob0h2fjk3/gW64/qdytZz4039ATLneyQ+lDjLe9+x/sObxyQRj/a6NhgnC1fLR/Uc
        8zZYzEB6MD2xFKK8MJPA8jXOOyO/Bdqahi/qdezxL+S9Kl4MzXRjFhoV/6maBxLX44Up
        6zLA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xm0dNS3IdRAZAL+p6A=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw7M4nRLT1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 22 Aug 2020 06:49:27 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v33 01/12] Linux Random Number Generator
Date:   Sat, 22 Aug 2020 06:49:27 +0200
Message-ID: <5635338.lOV4Wx5bFT@positron.chronox.de>
In-Reply-To: <202008220336.BQnuDlaK%lkp@intel.com>
References: <7836152.NyiUUSuA9g@positron.chronox.de> <202008220336.BQnuDlaK%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Freitag, 21. August 2020, 21:42:17 CEST schrieb kernel test robot:

Hi,
> 
>    hppa-linux-ld: lib/random32.o: in function `prandom_u32':
> >> (.text+0x318): undefined reference to `__tracepoint_prandom_u32'
> >> hppa-linux-ld: (.text+0x31c): undefined reference to
> >> `__tracepoint_prandom_u32' hppa-linux-ld:
> >> lib/random32.o:(__jump_table+0x8): undefined reference to
> >> `__tracepoint_prandom_u32'

This is caused by the fact that the LRNG code does not include trace/events/
random.h. However, a patch to lib/random32.c now requires this file to be 
included and creating a tracepoint. I.e. lib/random32.c code now relies on 
some other code to create the necessary hook.

I have added the include and will provide it with the next release although I 
am not sure lib/random32.c should rely on some other code to create its 
dependencies.

Ciao
Stephan


