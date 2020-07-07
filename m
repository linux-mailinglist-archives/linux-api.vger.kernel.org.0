Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95618217725
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 20:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGGSxs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 14:53:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728029AbgGGSxs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 14:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594148026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qd7GvFWxfTyKmbpo/F2p4KRc33HgtT765IWzuAxWIYI=;
        b=Rylo5hh0YwOis+gV36Cs4ivXf0O5ymydR7MJpZh51DLzTK+kFmE0VOmlDNn2DMU9LVrvGS
        +SP9SPVqTg+zADdgqYWPw1IVwaE661pmrx/mNkji32LamPe8Njc34ldXbP2zaV8EUDjnBV
        WKwe+9Iyv0ILMlKoZwsbZMYezZ9fj6Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-ewNiGJ9OMKSP9ANMLxwspg-1; Tue, 07 Jul 2020 14:53:44 -0400
X-MC-Unique: ewNiGJ9OMKSP9ANMLxwspg-1
Received: by mail-qt1-f199.google.com with SMTP id o11so31307559qti.23
        for <linux-api@vger.kernel.org>; Tue, 07 Jul 2020 11:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Qd7GvFWxfTyKmbpo/F2p4KRc33HgtT765IWzuAxWIYI=;
        b=JnecA8f+fLpjDyfpyHbBbjlSQDOzRJc5T1VEiYn8UgE8BbuUjnMWof2BcqXlB4AxyU
         QSbtjM0ttQBSFljnsWgeowKFdn84iiyYReYFrBnSwG0yDPLdZOdBoSvO0yywycRIf21v
         bpv67xBGjq0iha/rMRJ65gl/8xmsPXVJ7LcFUdhnYuULxAFZxHEw7lWxAUBfYxNrBvxb
         NWDZzZgdZrYa79SFmqX7Ub2Zv0iAfsU5cyYtQ/Q8apQBzS7OMxHhdOjzFpfzODI5NmkV
         c0IWOpx5eTqFPKnmac6fFYsdNwguAFqao42+jGCUt7zEEIyCYyJMv/tZFcvQ0wrl1slo
         5c9A==
X-Gm-Message-State: AOAM531Vebl6FXNBdqyMkJOZtKjnYHYOh0oZByeLPES5Y82a0Mzm7iBJ
        J0YyIorGkQngntJzLAlRMW1a/VRyOb5EcUtET/TOGjWWfpj+ZOV0wxhD5vGGvN53Fg00Wlfkj0d
        LqGmHj3dNbEwVs8FgNgBl
X-Received: by 2002:a37:64cd:: with SMTP id y196mr44880295qkb.303.1594148024015;
        Tue, 07 Jul 2020 11:53:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR00NCuC+wWsuRVMna6tP+BHj3IB5WxyNjpTX+b7L1EfMmtMFmi7fdb8X2pT7uHkbWKKSCLA==
X-Received: by 2002:a37:64cd:: with SMTP id y196mr44880268qkb.303.1594148023641;
        Tue, 07 Jul 2020 11:53:43 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id x29sm20420381qtx.74.2020.07.07.11.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 11:53:42 -0700 (PDT)
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fw@deneb.enyo.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
 <20200706204913.20347-4-mathieu.desnoyers@efficios.com>
 <87fta3zstr.fsf@mid.deneb.enyo.de>
 <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com>
 <874kqjzhkb.fsf@mid.deneb.enyo.de>
 <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com>
Date:   Tue, 7 Jul 2020 14:53:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/7/20 8:06 AM, Mathieu Desnoyers wrote:
> ----- On Jul 7, 2020, at 7:32 AM, Florian Weimer fw@deneb.enyo.de wrote:
> 
>> * Mathieu Desnoyers:
>>
>>> Those are very good points. One possibility we have would be to let
>>> glibc do the rseq registration without the RSEQ_FLAG_RELIABLE_CPU_ID
>>> flag. On kernels with the bug present, the cpu_id field is still good
>>> enough for typical uses of sched_getcpu() which does not appear to
>>> have a very strict correctness requirement on returning the right
>>> cpu number.
>>>
>>> Then libraries and applications which require a reliable cpu_id
>>> field could check this on their own by calling rseq with the
>>> RSEQ_FLAG_RELIABLE_CPU_ID flag. This would not make the state more
>>> complex in __rseq_abi, and let each rseq user decide about its own
>>> fate: whether it uses rseq or keeps using an rseq-free fallback.
>>>
>>> I am still tempted to allow combining RSEQ_FLAG_REGISTER |
>>> RSEQ_FLAG_RELIABLE_CPU_ID for applications which would not be using
>>> glibc, and want to check this flag on thread registration.
>>
>> Well, you could add a bug fix level field to the __rseq_abi variable.
> 
> Even though I initially planned to make the struct rseq_abi extensible,
> the __rseq_abi variable ends up being fix-sized, so we need to be very
> careful in choosing what we place in the remaining 12 bytes of padding.
> I suspect we'd want to keep 8 bytes to express a pointer to an
> "extended" structure.
> 
> I wonder if a bug fix level "version" is the right approach. We could
> instead have a bitmask of fixes, which the application could independently
> check. For instance, some applications may care about cpu_id field
> reliability, and others not.

I agree with Florian.

Developers are not interested in a bitmask of fixes.

They want a version they can check and that at a given version everything
works as expected.

In reality today this is the kernel version.

So rseq is broken from a developer perspective until they can get a new
kernel or an agreement from their downstream vendor that revision Z of
the kernel they are using has the fix you've just committed.

Essentially this problem solves itself at level higher than the interfaces
we're talking about today.

Encoding this as a bitmask of fixes is an overengineered solution for a
problem that the downstream communities already know how to solve.

I would strongly suggest a "version" or nothing.

>> Then applications could check if the kernel has the appropriate level
>> of non-buggyness.  But the same thing could be useful for many other
>> kernel interfaces, and I haven't seen such a fix level value for them.
>> What makes rseq so special?
> 
> I guess my only answer is because I care as a user of the system call, and
> what is a system call without users ? I have real applications which work
> today with end users deploying them on various kernels, old and new, and I
> want to take advantage of this system call to speed them up. However, if I
> have to choose between speed and correctness (in other words, not crashing
> a critical application), I will choose correctness. So if I cannot detect
> that I can safely use the system call, it becomes pretty much useless even
> for my own use-cases.

Yes.

In the case of RHEL we have *tons*  of users in the same predicament.

They just wait until the RHEL kernel team releases a fixed kernel version
and check for that version and deploy with that version.

Likewise every other user of a kernel. They solve it by asking their
kernel provider, internal or external, to verify the fix is applied to
the deployment kernel.

If they are an ISV they have to test and deploy similar strategies for
multiple kernel version.

By trying to automate this you are encoding into the API some level of
package management concepts e.g. patch level, revision level, etc.

This is difficult to do without a more generalized API. Why do it just
for rseq? Why do it with the few bits you have?

It's not a great fit IMO. Just let the kernel version be the arbiter of
correctness.
 
>> It won't help with the present bug, but maybe we should add an rseq
>> API sub-call that blocks future rseq registration for the thread.
>> Then we can add a glibc tunable that flips off rseq reliably if people
>> do not want to use it for some reason (and switch to the non-rseq
>> fallback code instead).  But that's going to help with future bugs
>> only.
> 
> I don't think it's needed. All I really need is to have _some_ way to
> let lttng-ust or liburcu query whether the cpu_id field is reliable. This
> state does not have to be made quickly accessible to other libraries,
> nor does it have to be shared between libraries. It would allow each
> user library or application to make its own mind on whether it can use
> rseq or not.
 
That check is "kernel version > x.y.z" :-)

or

"My kernel vendor told me it's fixed."

-- 
Cheers,
Carlos.

