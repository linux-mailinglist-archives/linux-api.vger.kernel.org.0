Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA425F9F5C
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2019 01:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKMAiD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 19:38:03 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:9568 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfKMAiD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Nov 2019 19:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573605481;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=odJ7n5ZEnkLtRoB5zC5Ulu/wysvbhjc5UXNa+NovNYM=;
        b=JzkEBA51bxZIc034cc9Ag0QRwE4/0IKyT6/CRkoM3TDJ78KPpafdrmeRp3h5374LLp
        Lhlc4fL2W5Onv+8TAlcUsdpqCqtQzNPZctxxt14m1OZQrt/JJjbFgWK2gnKOjNWS1g+c
        JzZKT+I4AV0tqoOsVAFYlpIPiLG01r0iMqc3FkZQtr5umE6sEtZii0IkJ4mNALE2KWJ2
        7LGnhuKICUh1B/bb/cYzUL0O7wAf0eTBYs/qiYs5nqCKQOIzyffLaRh8NRSzrlMYSfO1
        XC1XEdCSO4o2HyEqC4Pw86NJJW+4MvDHEXVwIuc5B9vDP3FksahJotVZ28ELQjJWNgl1
        +PIA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmwdNLqV/Nz7PsNPEA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id N09a57vAD0aOACK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 01:36:24 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
Subject: Re: [PATCH v24 11/12] LRNG - add SP800-90B compliant health tests
Date:   Wed, 13 Nov 2019 01:36:22 +0100
Message-ID: <9152597.fJySsU3eCD@positron.chronox.de>
In-Reply-To: <556c89ae-4272-970d-1644-cb77dc3c7946@gmail.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <3385183.Cb3iLDTLdO@positron.chronox.de> <556c89ae-4272-970d-1644-cb77dc3c7946@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 12. November 2019, 20:58:32 CET schrieb Alexander E. Patrakov:

Hi Alexander,
 
> > +config LRNG_HEALTH_TESTS
> > +	bool "Enable noise source online health tests"
> > +	help
> > +	  The online health tests validate the noise source at
> > +	  runtime for fatal errors. These tests include SP800-90B
> > +	  compliant tests which are invoked if the system is booted
> > +	  with fips=1. In case of fatal errors during active
> > +	  SP800-90B tests, the issue is logged and the noise
> > +	  data is discarded. These tests are required for full
> > +	  compliance with SP800-90B.
> 
> How have you tested that these tests work at runtime? Maybe add some
> code under a new CONFIG item that depends on CONFIG_BROKEN that
> deliberately botches the RNG and triggers failures?


I am unable to find sensible information about CONFIG_BROKEN in the recent 
kernel tree. 

Do you happen to have a pointer on how that option is to be used?

Thanks a lot

Ciao
Stephan


