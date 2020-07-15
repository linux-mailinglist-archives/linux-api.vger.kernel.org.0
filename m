Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B77220FD5
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgGOOuE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 10:50:04 -0400
Received: from mail.efficios.com ([167.114.26.124]:52348 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGOOuE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 10:50:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B8D4F2825C3;
        Wed, 15 Jul 2020 10:50:02 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fd-ChUQ4y-j4; Wed, 15 Jul 2020 10:50:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5681228245B;
        Wed, 15 Jul 2020 10:50:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5681228245B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594824602;
        bh=UKtsJI5QB1xU8LCcwpkPI3i1klkSLGG5bCDazvEjLm4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NKN85lyLk2KAd0gJFrbdUMOJxNjH92cQP2mnUkcXuAHTjHHKlN8Pimon02tsp1st/
         Ww+jEfodMeOWRm2KwjSxqDNdFytk5RM3UP6YXSacHVvpF4lwi8U+wfK6FEZ99ELYlU
         i5XsDFuUPQJnXNv9iOpuwYd+WBu+XMAfmlj9s+A71VJLECxtG7eE2UcWJwupbL431l
         4Ut5XiyLInXmBJRfdo+CtDlMa9preGCRPqb543iLSgZs7K9anuAjBrSUvyB8GgUlC5
         bGMcurpU/3SB6Lu2FPiWyvX3Jx6T3lu+4AmQuauDhbJ0LJyqsB/8spTU9cQNsvXdIS
         2gVnB0eV2EIlQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ANSTUrHF-juH; Wed, 15 Jul 2020 10:50:02 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 3AA0B282458;
        Wed, 15 Jul 2020 10:50:02 -0400 (EDT)
Date:   Wed, 15 Jul 2020 10:50:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chris Kennelly <ckennelly@google.com>
Cc:     Peter Oskolkov <posk@google.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>
Message-ID: <601595827.14270.1594824602119.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAEE+ybmt4BredezuTPdh-vf=FkKtu0yAhWuf+0daUe89AnbmPg@mail.gmail.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <CAFTs51UHaUqaKj5bEj0vQtEZrww9gnrqb-kGVk7DAgQJPBAR+w@mail.gmail.com> <775688146.12145.1594748580461.JavaMail.zimbra@efficios.com> <CAPNVh5fiCCJpyeLj_ciWzFrO4fasVXZNhpfKXJhJWJirXdJOjQ@mail.gmail.com> <CAEE+ybmt4BredezuTPdh-vf=FkKtu0yAhWuf+0daUe89AnbmPg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: bPI+2deu99arGuPk6Okd/MCPJ67vKA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 14, 2020, at 10:34 PM, Chris Kennelly ckennelly@google.com wrote:

> On Tue, Jul 14, 2020 at 2:33 PM Peter Oskolkov <posk@google.com> wrote:
>>
>> On Tue, Jul 14, 2020 at 10:43 AM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>> >
>> > ----- On Jul 14, 2020, at 1:24 PM, Peter Oskolkov posk@posk.io wrote:
>> >
>> > > At Google, we actually extended struct rseq (I will post the patches
>> > > here once they are fully deployed and we have specific
>> > > benefits/improvements to report). We did this by adding several fields
>> > > below __u32 flags (the last field currently), and correspondingly
>> > > increasing rseq_len in rseq() syscall. If the kernel does not know of
>> > > this extension, it will return -EINVAL due to an unexpected rseq_len;
>> > > then the application can either fall-back to the standard/upstream
>> > > rseq, or bail. If the kernel does know of this extension, it accepts
>> > > it. If the application passes the old rseq_len (32), the kernel knows
>> > > that this is an old application and treats it as such.
>> > >
>> > > I looked through the archives, but I did not find specifically why the
>> > > pretty standard approach described above is considered inferior to the
>> > > one taken in this patch (freeze rseq_len at 32, add additional length
>> > > fields to struct rseq). Can these be summarized?
>> >
>> > I think you don't face the issues I'm facing with libc rseq integration
>> > because you control the entire user-space software ecosystem at Google.
>> >
>> > The main issue we face is that the library responsible for registering
>> > rseq (either glibc 2.32+, an early-adopter librseq library, or the
>> > application) may very well not be the same library defining the __rseq_abi
>> > symbol used in the global symbol table. Interposition with ld preload or
>> > by defining the __rseq_abi in the program's executable are good examples
>> > of this kind of scenario, and those use-cases are supported.
> 
> Does this work if/when we run out of bytes in the current sizeof(__rseq_abi)?

Only if all libraries/programs involved (including glibc) expect that the size
of the __rseq_abi can be the smallest possible subset, and only consider it
to be "extended" if specific information in the ABI tells them it is the case.

> 
> Which library provides the TLS symbol (and N bytes of storage) seems
> sensitive to the choices the linker makes for us, once the symbol
> sizes diverge.

AFAIU, a symbol defined in the main executable will have precedence over
a preloaded library, which has precedence over shared library dependencies,
e.g. glibc.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
