Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA83222418
	for <lists+linux-api@lfdr.de>; Thu, 16 Jul 2020 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgGPNjn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jul 2020 09:39:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbgGPNjm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jul 2020 09:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594906780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGlaU8B/mICKZzO5a2jzqgO8r5hQ5/oeUPmxVGyuSuk=;
        b=RDLYgZyEa/Trtz9nRgcaTpfiTXlHln7KZy4IVsYkDhmt9CuzSo4xeXHTozIaCKgt5y7VLt
        b6sGDF3K8pvtRzN0WBKEvspn/k6PNsmsvlZmJM+LYeosP5EY1ekybma79wqrYmzt+0Rohb
        NvfIR/6HyKpjlv+wEAZxqYx+3c/oeYg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-fkruBIZdPbyD0k4ilFpWXQ-1; Thu, 16 Jul 2020 09:39:29 -0400
X-MC-Unique: fkruBIZdPbyD0k4ilFpWXQ-1
Received: by mail-qv1-f69.google.com with SMTP id a12so3412264qvt.22
        for <linux-api@vger.kernel.org>; Thu, 16 Jul 2020 06:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tGlaU8B/mICKZzO5a2jzqgO8r5hQ5/oeUPmxVGyuSuk=;
        b=q66PXFQhkt3i7/bQeZ+q2UGXX1/f/J/IX31MKHBt4JdtU+jxvd0qJRmmqIh7IDPMTc
         +obxpWaDmNw3Tg3HDWxq/Fz4epnuXThWG1YbiHL0Wtcir9SYNzceXvS2nfWqTDK4olL8
         dQ9cgaGN4uq4pIheCel6NLAxfOj3zN0LOqHNlsYtOwH2yL5R+fKDarnyDTHbiTSa/DjT
         sWzxobfPQ0rtG5MsdMz4V9QfD34TJXBbn80cmm0dm+lJlao2Jd6Ai9/uenWMtH4qYrYZ
         9y3gEprrNBuijoKf5jqs89xcACOf3Upt+Ooukwzxlzfmq/HLjYW1OkzYCOeHVdvEms9d
         i3ew==
X-Gm-Message-State: AOAM533SKYlMMtg8sXZ4ve1EToM1QCwDlmdv6834EEF/XmLzfGY/w7gt
        2BSntRcDT3UM5MuPn0SGQffleGawc04Vc3mcG3Y7WMxV2BiM1sI8Name7V42YYumg+k3bV3wOtY
        HXLyS+yV9vC1H5BV9+ylS
X-Received: by 2002:a37:7747:: with SMTP id s68mr4049280qkc.42.1594906768819;
        Thu, 16 Jul 2020 06:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKM5P3+IZq5goVdvDzMZx0lVmekjoB4avKgCmnXJcVGiTBB0mDzG8Hy2OswjdzKUzfna6M5g==
X-Received: by 2002:a37:7747:: with SMTP id s68mr4049243qkc.42.1594906768348;
        Thu, 16 Jul 2020 06:39:28 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id z17sm8730028qth.24.2020.07.16.06.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 06:39:27 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] rseq: Introduce extensible struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Chris Kennelly <ckennelly@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com>
 <1190016739.14119.1594818179014.JavaMail.zimbra@efficios.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <9f747c44-be54-c547-7e4c-a978499f06c0@redhat.com>
Date:   Thu, 16 Jul 2020 09:39:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1190016739.14119.1594818179014.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/15/20 9:02 AM, Mathieu Desnoyers wrote:
> At this point, the main question I would like answered is whether
> it would be acceptable to increase the size and alignment of
> the __rseq_abi symbol (which will be exposed by glibc) between
> e.g. glibc 2.32 and 2.33. If it's not possible, then we can
> find other solutions, for instance using an indirection with
> a pointer to an extended structure, but this appears to be
> slightly less efficient.

The answer is always a soft "maybe" because it depends exactly
on how we do it and what consequences we are willing to accept
in the design.

For example, static applications that call dlopen will fail if
we increase the alignment beyond 32 because we had to special
case this scenario. Why did we have to special case it? Because
the "static" part of the runtime needs to create the initial
thread's static TLS space, and since it doesn't know apriori
what will be loaded in the shared library, it needs to make a
"best guess" at the alignment requirement at startup.
We need to discuss this and agree that it's OK. We already want
to deprecate dynamic loading from static applications, so this
may not be a problem in general, but I hope you see my point.
That there are corner cases to be considered and ironed out.

I want to see a detailed design document explaining the various
compatibility issues and how we solve them along with the way
the extension mechanism would work and how it would be compliant
with C/C++ language rules in userspace without adding undue burden
of potentially having to use atomic instructions all the time.
This includes discussing how the headers change. We should also
talk out the options for symbol versioning and their consequences.
  
I haven't seen enough details, and there isn't really enough
time to discuss this. I think it is *great* that we are discussing
it, but it's safest if we revert rseq, finish the discussion,
and then finalize the inclusion for 2.33 with these details
ironed out.

I feel like we've made all the technical process we need to actually
include rseq in glibc, but this discussion, and the google example
(even if it doesn't match our use case) shows that if we spend another
month hammering out the extension details could yield something we
can use for years to come while we work out other details e.g. cpu_opv.

I can set aside time in the next month to write up such a document
and discuss these issues with you and Florian. The text would form
even more of the language we'd have to include in the man page for
the feature.

In the meantime I think we should revert rseq in glibc and take
our time to hash this out without the looming deadline of August 1st
for the ABI going out the door.

I know this is disappointing, but I think in a month you'll look
back at this, we'll have Fedora Rawhide using the new extensible
version (and you'll be able to point people at that), and we'll
only be 5 months away from an official release with extensible
rseq.

Could you please respond to Florian's request to revert here?
https://sourceware.org/pipermail/libc-alpha/2020-July/116368.html

I'm looking for a Signed-off-by from you that you're OK with
reverting.

-- 
Cheers,
Carlos.

