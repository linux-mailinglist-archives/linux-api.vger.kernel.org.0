Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2C38B8E3
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhETVSw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhETVSu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 17:18:50 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC40C061574;
        Thu, 20 May 2021 14:17:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BFEE12F3;
        Thu, 20 May 2021 21:17:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BFEE12F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621545445; bh=wEoEWkmh9unv7tC8nNiVNMD01nU61GT8xINDNNIpZYk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JXQWzTxbuHYe5RZPql1VxGK/csjp8yDkdjB2OFfJzruYe4Z46INES0AIUR3//LR5S
         GjG0UNKUivAt8YEcZTLsXm4TeF/i12cnRA3XRbyIY2SXkHgZHIPCIySwfWcShJIzy6
         P9I379J0v2yl3naobXjYP8vgtDzEzhc3z6gXlPq5w4GCnjrHEyAKaLGiW1Dsk738C3
         4K92b0e+l1E5Mr/VslpAo5bBfLgB6/i6GA6oj/0gaNSEfLrNuIcQfwook9tcGaPE68
         46kdraHRD+s7FBPxKV4zejFBIERtUqtZXWvlvUQ1hiJvpLoigEF4CExGSucGMl91RG
         sl4dfyeFjjN4A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
In-Reply-To: <20210520183614.1227046-1-posk@google.com>
References: <20210520183614.1227046-1-posk@google.com>
Date:   Thu, 20 May 2021 15:17:25 -0600
Message-ID: <87mtspm7fe.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Oskolkov <posk@google.com> writes:

> As indicated earlier in the FUTEX_SWAP patchset:
>
> https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/
>
> "Google Fibers" is a userspace scheduling framework
> used widely and successfully at Google to improve in-process workload
> isolation and response latencies. We are working on open-sourcing
> this framework, and UMCG (User-Managed Concurrency Groups) kernel
> patches are intended as the foundation of this.

So I have to ask...is there *any* documentation out there on what this
is and how people are supposed to use it?  Shockingly, typing "Google
fibers" into Google leads to a less than fully joyful outcome...  This
won't be easy for anybody to review if they have to start by
reverse-engineering what it's supposed to do.

Thanks,

jon
