Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005AB3265BC
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhBZQmi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 11:42:38 -0500
Received: from mail.efficios.com ([167.114.26.124]:36424 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBZQmh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 11:42:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AFBCA30FFD5;
        Fri, 26 Feb 2021 11:41:54 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CpPO6ujUHOK6; Fri, 26 Feb 2021 11:41:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5644330FFD4;
        Fri, 26 Feb 2021 11:41:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5644330FFD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614357714;
        bh=9EqQ5l+XNXPd5I1zSOvJAP0xTZ+Swb445kGkcyrpk8U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Z0WEmsDshbewOVhb0LWdVoVeUqkFM6z29cy7WbqIfMl0OkeZEbtRIeihwDZ+1oNER
         3kWTdFN0yvkhrEEpFtsQ3Dc2IchPGFg9yUGZgWnhX7sjh1xigATUc0RF5dUhUw08DO
         yD/Esss/cvDaG2ufKqtHe3tT+ZX5NvSPzksMk18mlpj9S5WAazLyQPDmAIia1j5cAF
         WuWkAVRmRBFqh7kBdLoT2ibTFVMMUvyjGE/TuHNdDj9Hcbs4MJQ9LQVwDcu+PKzuWF
         bvyjeLyW+DnMphE2XU4rKWBlfvUkGBHEU8tPpiFC0lh3AQR4pH7zZ7sKTAoLykFH2d
         CkCqg8nEHARsw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gQj5kSzTepm5; Fri, 26 Feb 2021 11:41:54 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 419EA30FFCF;
        Fri, 26 Feb 2021 11:41:54 -0500 (EST)
Date:   Fri, 26 Feb 2021 11:41:54 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     emmir <emmir@google.com>
Cc:     Piotr Figiel <figiel@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Florian Weimer <fweimer@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1701013445.8323.1614357714148.JavaMail.zimbra@efficios.com>
In-Reply-To: <CABb0KFFhbxU0xq0A=m2FO83j04vrzwVa2-JwKJi1mtRhu_0kSg@mail.gmail.com>
References: <20210226135156.1081606-1-figiel@google.com> <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com> <CABb0KFFhbxU0xq0A=m2FO83j04vrzwVa2-JwKJi1mtRhu_0kSg@mail.gmail.com>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Thread-Index: fQP+S8uPXpOVtfpNg34/mjrGX16yEg==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Feb 26, 2021, at 11:04 AM, emmir emmir@google.com wrote:

> On Fri, 26 Feb 2021 at 16:32, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Feb 26, 2021, at 8:51 AM, Piotr Figiel figiel@google.com wrote:
>> [...]
>> > ---
>> > v2:
>> > Applied review comments:
>> > - changed return value from the ptrace request to the size of the
>> >   configuration structure
>> > - expanded configuration structure with the flags field and
>> >   the rseq abi structure size
>> >
>> [...]
>> > +#define PTRACE_GET_RSEQ_CONFIGURATION        0x420f
>> > +
>> > +struct ptrace_rseq_configuration {
>> > +     __u64 rseq_abi_pointer;
>> > +     __u32 rseq_abi_size;
>> > +     __u32 signature;
>> > +     __u32 flags;
>> > +     __u32 pad;
>> > +};
>> > +
>> [...]
>> > +#ifdef CONFIG_RSEQ
>> > +static long ptrace_get_rseq_configuration(struct task_struct *task,
>> > +                                       unsigned long size, void __user *data)
>> > +{
>> > +     struct ptrace_rseq_configuration conf = {
>> > +             .rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
>> > +             .rseq_abi_size = sizeof(*task->rseq),
>> > +             .signature = task->rseq_sig,
>> > +             .flags = 0,
>> > +     };
>> > +
>> > +     size = min_t(unsigned long, size, sizeof(conf));
>> > +     if (copy_to_user(data, &conf, size))
>> > +             return -EFAULT;
>> > +     return sizeof(conf);
>> > +}
>>
>> I think what Florian was after would be:
>>
>> struct ptrace_rseq_configuration {
>>         __u32 size;  /* size of struct ptrace_rseq_configuration */
>>         __u32 flags;
>>         __u64 rseq_abi_pointer;
>>         __u32 signature;
>>         __u32 pad;
>> };
>>
>> where:
>>
>>     .size = sizeof(struct ptrace_rseq_configuration),
>>
>> This way, the configuration structure can be expanded in the future. The
>> rseq ABI structure is by definition fixed-size, so there is no point in
>> having its size here.
>>
>> Florian, did I understand your request correctly, or am I missing your point ?
> 
> In this case returning sizeof(conf) would serve the same purpose, wouldn't it?

If the size is received as input from user-space as well, this can be used to
make sure the kernel detects what size is expected by user-space and act accordingly.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
