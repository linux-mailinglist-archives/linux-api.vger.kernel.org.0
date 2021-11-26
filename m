Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7D45F62C
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 22:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbhKZVQd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 16:16:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbhKZVOc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 16:14:32 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637961078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gCM9kEhWoUkGOuKC2Aj4uPDGmWdwYkbfbhcTqi7DsY=;
        b=me44102yT0NMUViVyLMC06slnSGgufjN36cbpUgHj6rkyn+3p009+lPwTqrGdqulrdfRA+
        9h1//zwZq9b1+o+L5w6kVvA3r2r3+3yFg8IcSCNDJEo6AOcegcys7W9UGjGODXxywi/a9z
        afu31jyItoNBrE0HQg5EfoYyVSFNfu0gRGHsOT8vccyRwPkX6tAfduaKXkvWA6apkMEEc0
        CsioqYu+xcIA64n2xmjRRvsTJsfQJmLnLxyHQcFE7D7WAUdf8W0kJrQPM7x2ymYsLPU7qo
        Gr1zuy5UOQtvPDiVFoVsd+LuR48wn+0l5pbnzujo4aAqJNDipDHo9QSSI/u9IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637961078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5gCM9kEhWoUkGOuKC2Aj4uPDGmWdwYkbfbhcTqi7DsY=;
        b=RcHGvoHf5TfyyVW+fZX/Y4s635PSzKqB8O4YXbPhwUGL6QkOYegpmZfdJDuExMRuk1KW1Y
        SV/ifilsxWdczVCw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
In-Reply-To: <20211124211927.GG721624@worktop.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124211927.GG721624@worktop.programming.kicks-ass.net>
Date:   Fri, 26 Nov 2021 22:11:17 +0100
Message-ID: <877dcuhbbe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 24 2021 at 22:19, Peter Zijlstra wrote:
> On Mon, Nov 22, 2021 at 01:13:24PM -0800, Peter Oskolkov wrote:
>
>> +	 * Timestamp: a 46-bit CLOCK_MONOTONIC timestamp, at 16ns resolution.
>
>> +static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
>> +				bool may_fault)
>> +{
>> +	u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
>> +	u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
>
> I'm still very hesitant to use ktime (fear the HPET); but I suppose it
> makes sense to use a time base that's accessible to userspace. Was
> MONOTONIC_RAW considered?

MONOTONIC_RAW is not really useful as you can't sleep on it and it won't
solve the HPET crap either.

Thanks,

        tglx

