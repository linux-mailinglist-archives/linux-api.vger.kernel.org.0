Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4219220E88
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 15:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgGON4H (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 09:56:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48121 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgGON4H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 09:56:07 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvht5-0005LP-Jl; Wed, 15 Jul 2020 13:55:55 +0000
Date:   Wed, 15 Jul 2020 15:55:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        carlos <carlos@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
Message-ID: <20200715135554.4q6aamx4iqd4mnqh@wittgenstein>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <87mu42bepq.fsf@oldenburg2.str.redhat.com>
 <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com>
 <87a7028d5u.fsf@oldenburg2.str.redhat.com>
 <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com>
 <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com>
 <2053637148.14136.1594818777608.JavaMail.zimbra@efficios.com>
 <87y2nk29rp.fsf@oldenburg2.str.redhat.com>
 <882700738.14181.1594819884049.JavaMail.zimbra@efficios.com>
 <87mu4028uk.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mu4028uk.fsf@oldenburg2.str.redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 15, 2020 at 03:42:11PM +0200, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
> > So indeed it could be done today without upgrading the toolchains by
> > writing custom assembler for each architecture to get the thread's
> > struct rseq. AFAIU the ABI to access the thread pointer is fixed for
> > each architecture, right ?
> 
> Yes, determining the thread pointer and access initial-exec TLS
> variables is baked into the ABI.
> 
> > How would this allow early-rseq-adopter libraries to interact with
> > glibc ?
> 
> Under all extension proposals I've seen so far, early adopters are
> essentially incompatible with glibc rseq registration.  I don't think
> you can have it both ways.

Who are the early adopters? And if we aren't being compatible with them
under the extensible schemes proposed we should be able to achieve
compatibility with non-early adopters, right? Which I guess is more
important. (I still struggle to make sense what qualifies as an early
adopter/what the difference to a non-early adopter is.)

Christian
