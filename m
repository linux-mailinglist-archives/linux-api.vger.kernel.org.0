Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D585D13D49D
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 07:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgAPGtO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 01:49:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgAPGtN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jan 2020 01:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZH6TbtHlgpYJkkCSitMQjjtRHf50m8KSlIQRVZB5JTw=; b=KFR5dNqEqdHKKOIfc7qGWbzvS
        BIwY/hScLhqE91/DyGlC3IUljLSM7Ekgo2ZUJjLr1reelMqYgOjYX2Y+rtKrLr/a334tZ2ykaeE+2
        imzQ7yKhJCOdDWXABh3yxc0/IglmXR69ah7fr1Yg37daAFgGzLNfqeuP9uSq2Lj4Nq0zWaW9DjWsA
        VdJL8jQi1U1a09bc6ZIQvgjOcRc8nCoh8PtlM+2QzS3fvt0iPEKkw+vEZvPdM5YIhj1DavXBPB2IL
        s99VN1HpxhSCUq5/qFu5J9GG6r0cl1mmTv60LucRlSWtzEMqfd3chYKQKYegJXx544BULvIp7QvDQ
        QFGxkPqcA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iryx6-00068M-9U; Thu, 16 Jan 2020 06:48:24 +0000
Subject: Re: [PATCH v28 11/12] LRNG - add interface for gathering of raw
 entropy
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
 <2048458.ADJAtTWDj8@positron.chronox.de>
 <abde84fe-2599-0db8-2bad-d2ff29a3c4f0@infradead.org>
 <9116265.6Va6cPe1zF@tauon.chronox.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <72a57d93-737a-c6c1-82c4-e14f73054ad5@infradead.org>
Date:   Wed, 15 Jan 2020 22:48:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9116265.6Va6cPe1zF@tauon.chronox.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/15/20 10:43 PM, Stephan Mueller wrote:
> Am Donnerstag, 16. Januar 2020, 01:18:18 CET schrieb Randy Dunlap:
> 
> Hi Randy,
> 
>> On 1/15/20 2:35 AM, Stephan Müller wrote:
>>> CC: "Eric W. Biederman" <ebiederm@xmission.com>
>>> CC: "Alexander E. Patrakov" <patrakov@gmail.com>
>>> CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
>>> CC: "Theodore Y. Ts'o" <tytso@mit.edu>
>>> CC: Willy Tarreau <w@1wt.eu>
>>> CC: Matthew Garrett <mjg59@srcf.ucam.org>
>>> CC: Vito Caputo <vcaputo@pengaru.com>
>>> CC: Andreas Dilger <adilger.kernel@dilger.ca>
>>> CC: Jan Kara <jack@suse.cz>
>>> CC: Ray Strode <rstrode@redhat.com>
>>> CC: William Jon McCann <mccann@jhu.edu>
>>> CC: zhangjs <zachary@baishancloud.com>
>>> CC: Andy Lutomirski <luto@kernel.org>
>>> CC: Florian Weimer <fweimer@redhat.com>
>>> CC: Lennart Poettering <mzxreary@0pointer.de>
>>> CC: Nicolai Stange <nstange@suse.de>
>>> Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
>>> Tested-by: Roman Drahtmüller <draht@schaltsekun.de>
>>> Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
>>> Tested-by: Neil Horman <nhorman@redhat.com>
>>> Signed-off-by: Stephan Mueller <smueller@chronox.de>
>>> ---
>>>
>>>  drivers/char/lrng/Kconfig        |  16 ++
>>>  drivers/char/lrng/Makefile       |   1 +
>>>  drivers/char/lrng/lrng_testing.c | 271 +++++++++++++++++++++++++++++++
>>>  3 files changed, 288 insertions(+)
>>>  create mode 100644 drivers/char/lrng/lrng_testing.c
>>>
>>> diff --git a/drivers/char/lrng/lrng_testing.c
>>> b/drivers/char/lrng/lrng_testing.c new file mode 100644
>>> index 000000000000..0e287eccd622
>>> --- /dev/null
>>> +++ b/drivers/char/lrng/lrng_testing.c
>>> @@ -0,0 +1,271 @@
>>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>> +/*
>>> + * Linux Random Number Generator (LRNG) Raw entropy collection tool
>>> + *
>>> + * Copyright (C) 2019 - 2020, Stephan Mueller <smueller@chronox.de>
>>> + */
>>> +
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +
>>> +#include <linux/atomic.h>
>>> +#include <linux/bug.h>
>>> +#include <linux/debugfs.h>
>>> +#include <linux/module.h>
>>> +#include <linux/sched.h>
>>> +#include <linux/sched/signal.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/string.h>
>>> +#include <linux/types.h>
>>> +#include <linux/uaccess.h>
>>> +#include <linux/workqueue.h>
>>> +#include <asm/errno.h>
>>> +
>>> +#include "lrng_internal.h"
>>> +
>>> +#define LRNG_TESTING_RINGBUFFER_SIZE	1024
>>> +#define LRNG_TESTING_RINGBUFFER_MASK	(LRNG_TESTING_RINGBUFFER_SIZE - 1)
>>> +
>>> +static u32 lrng_testing_rb[LRNG_TESTING_RINGBUFFER_SIZE];
>>> +static u32 lrng_rb_reader = 0;
>>> +static u32 lrng_rb_writer = 0;
>>> +static atomic_t lrng_testing_enabled = ATOMIC_INIT(0);
>>> +
>>> +static DECLARE_WAIT_QUEUE_HEAD(lrng_raw_read_wait);
>>> +static DEFINE_SPINLOCK(lrng_raw_lock);
>>> +
>>> +/*
>>> + * 0 ==> No boot test, gathering of runtime data allowed
>>> + * 1 ==> Boot test enabled and ready for collecting data, gathering
>>> runtime + *	 data is disabled
>>> + * 2 ==> Boot test completed and disabled, gathering of runtime data is
>>> + *	 disabled
>>> + */
>>> +static u32 boot_test = 0;
>>> +module_param(boot_test, uint, 0644);
>>> +MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of the
>>> first" +			    " entropy events");
>>
>> One line for the string, please.
> 
> may I ask the question whether this should be done for all lines with printk 
> statements? As checkpatch.pl will complain if you have lines larger than 80 
> chars and complains about line-broken printk statements, I am always unsure 
> which way to go.
> 
> All printk statements in the patch series have line-broken printk statements.

It's for grep-ability of the strings.
grepping for partial strings would work as is, but then one would need to know
what partial string to search for.

-- 
~Randy

