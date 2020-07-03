Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08685213EF7
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2020 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgGCRvH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 13:51:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgGCRvH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 13:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593798665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7N8C0ylSkVt52CpPmDfK6oXLgMs/h4S3a8iKhtYc04=;
        b=OJlOthlkmStdZ5Zia/kp8X2rr3Yv/6KcfngloQywAdCOosF/VY65Oty+wIRfUDbGE9MDEl
        9xv+A/DZsGA30A1Y39Ifi4JKmJ+ulVEG79xjnzYLoheCVa7HAhOuoS3WjSuDKVPU4iEZ9u
        CtDFqShLMQbpKm+l0TbFFLvHmm29P0A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-8fyy2rgoNsugJo_WibaWCw-1; Fri, 03 Jul 2020 13:51:03 -0400
X-MC-Unique: 8fyy2rgoNsugJo_WibaWCw-1
Received: by mail-qv1-f71.google.com with SMTP id q5so20986244qvp.23
        for <linux-api@vger.kernel.org>; Fri, 03 Jul 2020 10:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+7N8C0ylSkVt52CpPmDfK6oXLgMs/h4S3a8iKhtYc04=;
        b=XdfLFRwaQBIG7vuZPn4d1F5n4nJB3sMyKktC0ReUtXznMCtvsbdm1P/0eh0vI8iLLw
         eC6GNTJT2vaAl1FPECMajkGzoJZFf76pi7ZrwJ6lVyJ0ALOr75Pkeogr/LfrEPa4CU4/
         X+aAXL+tFMGaiitSzNnBfEFkrEreAn5FwhV2kjZ8OzfCqmqpgfaOIcI8N4pa5jxG0IvG
         ny1DzXyS391Mes8A5OOqc8YSWAlToseuTuimYoL9SXmZF8UQpiNRjvP6uiNAkfdfUz5Z
         2/hXLtg/jhp0jY6S0AYW9d10xkvADKeD2BNKjgvqHRoe/1eis69GLZLMUOs2DiRxx5FS
         LYmA==
X-Gm-Message-State: AOAM532lIHr88G9vFkar+KqPuKf9f7HzmwHLOVMRkj+HWwGx/Piw2GQS
        4sIQAc9vB8LY3UPUDwrS5hyGW/hv64WcZlGsW3lDgilihe0Mzm1JVEAuQJTOmdp5pvqYTzeOqp4
        kDZNSgwhbsv3srpH5FTRD
X-Received: by 2002:ac8:24e8:: with SMTP id t37mr38245599qtt.319.1593798662263;
        Fri, 03 Jul 2020 10:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqygbCTvDXxs/+iL1FjRBTGhWsR6PP3NMzt2MJgrawQtn0tIyhC9vS0/XAMiNz4Fz7HmbA/A==
X-Received: by 2002:ac8:24e8:: with SMTP id t37mr38245582qtt.319.1593798662026;
        Fri, 03 Jul 2020 10:51:02 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id t36sm12209686qtj.58.2020.07.03.10.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 10:51:01 -0700 (PDT)
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and
 thread creation (v22)
To:     Florian Weimer <fweimer@redhat.com>,
        Mathieu Desnoyers via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rich Felker <dalias@libc.org>, linux-api@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com>
 <20200629190036.26982-2-mathieu.desnoyers@efficios.com>
 <87o8oy9dqe.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <ac7b3d44-969a-c5bb-0b33-c997d29ea142@redhat.com>
Date:   Fri, 3 Jul 2020 13:50:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87o8oy9dqe.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/2/20 10:46 AM, Florian Weimer wrote:
> * Mathieu Desnoyers via Libc-alpha:
> 
>> Register rseq TLS for each thread (including main), and unregister for
>> each thread (excluding main).  "rseq" stands for Restartable Sequences.
>>
>> See the rseq(2) man page proposed here:
>>   https://lkml.org/lkml/2018/9/19/647
>>
>> Those are based on glibc master branch commit 3ee1e0ec5c.
>> The rseq system call was merged into Linux 4.18.
>>
>> The TLS_STATIC_SURPLUS define is increased to leave additional room for
>> dlopen'd initial-exec TLS, which keeps elf/tst-auditmany working.
>>
>> The increase (76 bytes) is larger than 32 bytes because it has not been
>> increased in quite a while.  The cost in terms of additional TLS storage
>> is quite significant, but it will also obscure some initial-exec-related
>> dlopen failures.
> 
> We need another change to get this working on most non-x86
> architectures:
> 
> diff --git a/elf/dl-tls.c b/elf/dl-tls.c
> index 817bcbbf59..ca13778ca9 100644
> --- a/elf/dl-tls.c
> +++ b/elf/dl-tls.c
> @@ -134,6 +134,12 @@ void
>  _dl_determine_tlsoffset (void)
>  {
>    size_t max_align = TLS_TCB_ALIGN;
> +  /* libc.so with rseq has TLS with 32-byte alignment.  Since TLS is
> +     initialized before audit modules are loaded and slotinfo
> +     information is available, this is not taken into account below in
> +     the audit case.  */
> +  max_align = MAX (max_align, 32U);
> +
>    size_t freetop = 0;
>    size_t freebottom = 0;
> 
> This isn't visible on x86-64 because TLS_TCB_ALIGN is already 64 there.
> 
> I plan to re-test with this fix and push the series.
> 
> Carlos, is it okay if I fold in the dl-tls.c change if testing looks
> good?

I have reviewed the above and I think it is the correct *pragmatic* fix.

The reality is that to fix this fully you must use a two stage loading
process to pre-examine all audit modules *before* setting the fundamental
alignment of the TCB.  This isn't easy with the current loader framework.
Therefore the above is a good pragmatic solution.

There is always going to be a bit of a chicken and an egg situation.
We want to provide a fundamental alignment requirement but we haven't
yet seen all the requirements on alignment. So the best we could do is
look over DT_NEEDED, DT_AUDIT, LD_PRELOAD, etc. get the best answer
and then fail any subsequent dlopen's that load objects with higher
fundamental requirements for alignment of the TCB.

The audit modules are problematic becuase they are loaded *before*
anything else is loaded, *before* we've examined any of the actual
objects we're about to load because they can influence the search
paths. Again, this means the above solution is a perfect pragmatic
choice. The real solution is to rearchitect the early audit module
loading into two stages and that's work we can do later.

OK with the above change.

-- 
Cheers,
Carlos.

