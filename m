Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD5632C68A
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhCDA3L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:29:11 -0500
Received: from mail.efficios.com ([167.114.26.124]:41054 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349563AbhCCTE6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Mar 2021 14:04:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 64221322273;
        Wed,  3 Mar 2021 13:55:39 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nzmyisAEtpyn; Wed,  3 Mar 2021 13:55:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 21F7D3224BB;
        Wed,  3 Mar 2021 13:55:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 21F7D3224BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614797739;
        bh=/+Cqqku+yj2v49ObRIAAYZyDmnbTz9LGncxn1fI29Ps=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GbxlIVqm7efnQ45RtVCzOCfqdFevWnV4Wyzn7JHHpWE+0kW93ElqMjI6yq7dxzt8l
         2WSXEedfphWhw6AYPFWyvpLK3G4CgbjsKgPvcbVMxE+hZr9w/SRnut1hmufF0EqRPn
         KEWcysdPcD3O3rqaWGuheyIyrdjF8s8WjULftPOz7JT9Ecerk/QvFsEbHCPrjxiLIX
         bQyl7wpB14EYEWRAGflHweOC9547veDzzjHeKTMYkR0LFbUn61awhCuCK5Jp2QtLZm
         vxWNO+i6I/PWSt/4u0hde3c1CSJsbgHjBvJzG/Zpaep3cex7+psgOkSGqQ7Da80P9G
         wDXxuw/fAZsLg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RSvuoPlpXd8c; Wed,  3 Mar 2021 13:55:39 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 11C6A3226AB;
        Wed,  3 Mar 2021 13:55:39 -0500 (EST)
Date:   Wed, 3 Mar 2021 13:55:39 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Piotr Figiel <figiel@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Paul Turner <pjt@google.com>, emmir <emmir@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1647666880.9529.1614797739047.JavaMail.zimbra@efficios.com>
In-Reply-To: <YDkchUnCe5ctDwYB@google.com>
References: <20210226135156.1081606-1-figiel@google.com> <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com> <YDkchUnCe5ctDwYB@google.com>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Thread-Index: +gCa2M7/7eePF4mAiSVH9mBBgTSE+w==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Feb 26, 2021, at 11:06 AM, Piotr Figiel figiel@google.com wrote:

> Hi,
> 
> On Fri, Feb 26, 2021 at 10:32:35AM -0500, Mathieu Desnoyers wrote:
>> > +static long ptrace_get_rseq_configuration(struct task_struct *task,
>> > +					  unsigned long size, void __user *data)
>> > +{
>> > +	struct ptrace_rseq_configuration conf = {
>> > +		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
>> > +		.rseq_abi_size = sizeof(*task->rseq),
>> > +		.signature = task->rseq_sig,
>> > +		.flags = 0,
>> > +	};
>> > +
>> > +	size = min_t(unsigned long, size, sizeof(conf));
>> > +	if (copy_to_user(data, &conf, size))
>> > +		return -EFAULT;
>> > +	return sizeof(conf);
>> > +}
>> 
>> I think what Florian was after would be:
>> 
>> struct ptrace_rseq_configuration {
>> 	__u32 size;  /* size of struct ptrace_rseq_configuration */
>> 	__u32 flags;
>> 	__u64 rseq_abi_pointer;
>> 	__u32 signature;
>> 	__u32 pad;
>> };
>> 
>> where:
>> 
>>     .size = sizeof(struct ptrace_rseq_configuration),
>> 
>> This way, the configuration structure can be expanded in the future. The
>> rseq ABI structure is by definition fixed-size, so there is no point in
>> having its size here.
> 
> Still rseq syscall accepts the rseq ABI structure size as a paremeter.
> I think this way the information returned from ptrace is consistent with
> the userspace view of the rseq state and allows expansion in case the
> ABI structure would have to be extended (in spite of it's current
> definition).
> 
> The configuration structure still can be expanded as its size is
> reported to userspace as return value from the request (in line with
> Dmitry's comments).

Fair enough. And now with the reply from Florian I see that I misunderstood his
point.

Thanks,

Mathieu

> 
> Best regards, Piotr.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
