Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BCD220FF9
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 16:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGOOyI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 10:54:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:53588 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGOOyH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 10:54:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 019F228288D;
        Wed, 15 Jul 2020 10:54:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UI-Yt_BGGMDe; Wed, 15 Jul 2020 10:54:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C501428262B;
        Wed, 15 Jul 2020 10:54:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C501428262B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594824846;
        bh=54IAB4nGaEdAThpU9gOAvhwf7R9x5qsgZhVuNCgBOPQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=c67AszQopibnIZZ5NgaobX0YPlXDxRsEZybal42YWvqES/aSF8tql5QXiPN0jzITO
         nza83eErrmii8q09TFMTqDQt4A1MS7ERNW/80Mw847nL+vBOekZi80j6uSUS03vsqP
         tQKtXo/Z6jCSXB0lEvLX/D/nGuFEGJHJGnF50lPBEdN2GcuH5w4pxhyCDgZGAbAWcj
         3Yf5CDENNRAZmNXsUpZAxVINLO28Vd9RDfWw9SXHE/3MxNTZDhjqqhgAiqSMpB3uhz
         11zdUroTH5uEsInbg0eyVQoJy7PtmipkXP7VNk7UvMUbSBvWN93FEaaFmj8hJR2Y+d
         f0Xnh2A/ZLxSA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WerSgHc_o-Fa; Wed, 15 Jul 2020 10:54:06 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B8B4D282626;
        Wed, 15 Jul 2020 10:54:06 -0400 (EDT)
Date:   Wed, 15 Jul 2020 10:54:06 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <1481331967.14276.1594824846736.JavaMail.zimbra@efficios.com>
In-Reply-To: <87mu4028uk.fsf@oldenburg2.str.redhat.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <87a7028d5u.fsf@oldenburg2.str.redhat.com> <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com> <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com> <2053637148.14136.1594818777608.JavaMail.zimbra@efficios.com> <87y2nk29rp.fsf@oldenburg2.str.redhat.com> <882700738.14181.1594819884049.JavaMail.zimbra@efficios.com> <87mu4028uk.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: GU+HWQn+q08bfey6uiSkHPIIjdE8lw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 15, 2020, at 9:42 AM, Florian Weimer fweimer@redhat.com wrote:
> * Mathieu Desnoyers:
> 
[...]
>> How would this allow early-rseq-adopter libraries to interact with
>> glibc ?
> 
> Under all extension proposals I've seen so far, early adopters are
> essentially incompatible with glibc rseq registration.  I don't think
> you can have it both ways.

The basic question I'm not sure about is whether we are allowed to increase
the size and alignement of __rseq_abi from e.g. glibc 2.32 to glibc 2.33.
If not, then we just need to find another way to extend struct rseq, e.g. by
adding a pointer to another extended structure in the padding space we
have at the end of struct rseq.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
