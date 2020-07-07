Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DB216AAA
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGKsR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 06:48:17 -0400
Received: from mail.efficios.com ([167.114.26.124]:49338 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGKsR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 06:48:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BDF6C2603;
        Tue,  7 Jul 2020 06:48:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WrIAjRWZrLYx; Tue,  7 Jul 2020 06:48:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7D2D926D0;
        Tue,  7 Jul 2020 06:48:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7D2D926D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594118895;
        bh=SEZo62sgXX1yjYgPrkJmMf2plZSVRbldxmKP5S78mc8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=h6Jm5q8RePncs+Ip0THH4GjA7d46906VsncUVa1anyOa/5IUi5dIYyPPJjQbysmjL
         ewAHda1Bqf6QC6KM83ljnlZyu/Xeo8tlFNRggaIt713ilezDvIpJxcTTJVbmweovAa
         QdJImFlAOypo2xt0I1KMHScNvbsCTB1ReCAO08LgPyhutgm+t7LAZqwHa1GQkp5V23
         HbfSMc7pAsS/5sm/oxF9e7VO4yEfwXB86WrxzSYgysXs/J8/XY6tHNGzaq3FaG+04E
         vyZ3NXbNZkL9wP3kTf6yi3AaFxpAwk7wqG5/gQ4QHwI8H4zimIHPFx4pLAH5TamWUA
         aiI7M29Z5xubA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id f5Bw7qcXPthX; Tue,  7 Jul 2020 06:48:15 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6C0F726C9;
        Tue,  7 Jul 2020 06:48:15 -0400 (EDT)
Date:   Tue, 7 Jul 2020 06:48:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Message-ID: <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com>
In-Reply-To: <87fta3zstr.fsf@mid.deneb.enyo.de>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com> <20200706204913.20347-4-mathieu.desnoyers@efficios.com> <87fta3zstr.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce
 RSEQ_FLAG_RELIABLE_CPU_ID
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
Thread-Index: cnNSSEN40kq5dPdzDK9Vrs4pN+iz1g==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 7, 2020, at 3:29 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> commit 93b585c08d16 ("Fix: sched: unreliable rseq cpu_id for new tasks")
>> addresses an issue with cpu_id field of newly created processes. Expose
>> a flag which can be used by user-space to query whether the kernel
>> implements this fix.
>>
>> Considering that this issue can cause corruption of user-space per-cpu
>> data updated with rseq, it is recommended that user-space detects
>> availability of this fix by using the RSEQ_FLAG_RELIABLE_CPU_ID flag
>> either combined with registration or on its own before using rseq.
> 
> Presumably, the intent is that glibc uses RSEQ_FLAG_RELIABLE_CPU_ID to
> register the rseq area.  That will surely prevent glibc itself from
> activating rseq on broken kernels.  But if another rseq library
> performs registration and has not been updated to use
> RSEQ_FLAG_RELIABLE_CPU_ID, we still end up with an active rseq area
> (and incorrect CPU IDs from sched_getcpu in glibc).  So further glibc
> changes will be needed.  I suppose we could block third-party rseq
> registration with a registration of a hidden rseq area (not
> __rseq_abi).  But then the question is if any of the third-party rseq
> users are expecting the EINVAL error code from their failed
> registration.
> 
> The rseq registration state machine is quite tricky already, and the
> need to use RSEQ_FLAG_RELIABLE_CPU_ID would make it even more
> complicated.  Even if we implemented all the changes, it's all going
> to be essentially dead, untestable code in a few months, when the
> broken kernels are out of circulation.  It does not appear to be good
> investment to me.

Those are very good points. One possibility we have would be to let
glibc do the rseq registration without the RSEQ_FLAG_RELIABLE_CPU_ID
flag. On kernels with the bug present, the cpu_id field is still good
enough for typical uses of sched_getcpu() which does not appear to
have a very strict correctness requirement on returning the right
cpu number.

Then libraries and applications which require a reliable cpu_id field
could check this on their own by calling rseq with the
RSEQ_FLAG_RELIABLE_CPU_ID flag. This would not make the state more
complex in __rseq_abi, and let each rseq user decide about its own fate:
whether it uses rseq or keeps using an rseq-free fallback.

I am still tempted to allow combining RSEQ_FLAG_REGISTER | RSEQ_FLAG_RELIABLE_CPU_ID
for applications which would not be using glibc, and want to check this flag on
thread registration.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
