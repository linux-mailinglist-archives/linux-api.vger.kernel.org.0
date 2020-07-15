Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2484D2210DF
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGOP0g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 11:26:36 -0400
Received: from mail.efficios.com ([167.114.26.124]:41338 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGOP0g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 11:26:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 29CAE28294D;
        Wed, 15 Jul 2020 11:26:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id grExVuNJRgRK; Wed, 15 Jul 2020 11:26:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C097328294C;
        Wed, 15 Jul 2020 11:26:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C097328294C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594826794;
        bh=ixzZEBN0XBAyYhSOviuo0tkp9cwyUFPD/5SBxNhupsc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BNbb8FUQ2MgZ6UOsSMy5Au51v/ciP5PXPhZskRzaG86CQlYP+Nbj3InoGpKW3KaqG
         xCx7zPb4KWo5axCYCPZLGbAUv++GdwJ0YbYTKjM4CmCuIFJOJAwWBfGcPC1cQS2JRU
         Ynu+TB9zyoujWk/yliuZUUal4XrbPIMTrx99hmCL18LtZBMobp08xEEQJFWvI+zTo1
         leIVGf4h5emkgm3oOqL/9Pw3Wke6QTfF5Xpu+PTZUaM/XP93QdZuMzSQrBp1jCg2Hj
         Wzqp6QuURNu7YjFoTyaYwwwE+92mEH5r0uyV0TZet/sWgPJIHC2KyIlmMzYaT/5Fxz
         a0RyecZNnhtjA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dZoND3EixLPp; Wed, 15 Jul 2020 11:26:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id AF5BD28294B;
        Wed, 15 Jul 2020 11:26:34 -0400 (EDT)
Date:   Wed, 15 Jul 2020 11:26:34 -0400 (EDT)
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
Message-ID: <1506932521.14341.1594826794611.JavaMail.zimbra@efficios.com>
In-Reply-To: <87k0z4zuxq.fsf@oldenburg2.str.redhat.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com> <2053637148.14136.1594818777608.JavaMail.zimbra@efficios.com> <87y2nk29rp.fsf@oldenburg2.str.redhat.com> <882700738.14181.1594819884049.JavaMail.zimbra@efficios.com> <87mu4028uk.fsf@oldenburg2.str.redhat.com> <1481331967.14276.1594824846736.JavaMail.zimbra@efficios.com> <87k0z4zuxq.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: KF0DmHs4TFAoijps0DhfMC1cmdpo+Q==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 15, 2020, at 10:58 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Jul 15, 2020, at 9:42 AM, Florian Weimer fweimer@redhat.com wrote:
>>> * Mathieu Desnoyers:
>>> 
>> [...]
>>>> How would this allow early-rseq-adopter libraries to interact with
>>>> glibc ?
>>> 
>>> Under all extension proposals I've seen so far, early adopters are
>>> essentially incompatible with glibc rseq registration.  I don't think
>>> you can have it both ways.
>>
>> The basic question I'm not sure about is whether we are allowed to increase
>> the size and alignement of __rseq_abi from e.g. glibc 2.32 to glibc 2.33.
> 
> With the current mechanism (global TLS data symbol), we can do that
> using symbol versioning.  That means that we can only do this on a
> release boundary,

That should not be a problem.

> and that it's incompatible with other libraries which
> use an interposing unversioned symbol.

We have the freedom to define the ABI of this shared __rseq_abi symbol
right now. Maybe it's not such a good thing to let early adopters use
unversioned __rseq_abi symbols.

Let me wrap my head around this scenario then, please let me know if
I'm misunderstanding something:

1) glibc 2.32 exposes:
   __rseq_abi (GLIBC_2.32) with size == 32.
   __rseq_abi with size == 32 is available as a private symbol within glibc
   - both symbols alias the same contents.

2) glibc 2.33 exposes:
   __rseq_abi (GLIBC_2.32) with size == 32.
   __rseq_abi (GLIBC_2.33) with size == 64.
   __rseq_abi with size == 64 is available as a private symbol within glibc
   - the three symbols alias the same contents.

Then what happens if we have a program or preloaded library defining
__rseq_abi (without version) with size == 32 loaded with a glibc 2.33 ?

Or what happens if we have a program or preloaded libary defining
__rseq_abi (GLIBC_2.32) with size == 32 loaded with a glibc 2.33 ?

I wonder if "GLIBC_*" is the right version namespace for this. Considering
that the layout of this structure is defined by the Linux kernel UAPI, maybe
we'd want version named as "RSEQ_1.0", "RSEQ_2.0" or something similar.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
