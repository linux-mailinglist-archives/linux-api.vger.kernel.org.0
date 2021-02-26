Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA573264C6
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBZPdV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 10:33:21 -0500
Received: from mail.efficios.com ([167.114.26.124]:57494 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZPdU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 10:33:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6D5E830F9D0;
        Fri, 26 Feb 2021 10:32:36 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1wx23JkX2j13; Fri, 26 Feb 2021 10:32:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E7E1A30F9CF;
        Fri, 26 Feb 2021 10:32:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E7E1A30F9CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614353556;
        bh=lIk0nJ/zoaoI4S6yz+QKK2lq/rImbycdfBHkfxXXItg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=b/t4RyJaCI9evNkbJeINEt0bSsVocZtyHQIvdGzgoGqVZ7mimfuomwXIX3wMj3yTP
         R1FszRRf2HOPLXyFLuAu+XeUAPa1DFVwh4DTLZragq7YI58oXxK2XaDCb71RFdR93S
         uMtdalk1ZnfSieo2pa4bTjeqTveMn8GNMMEZWq+8Oqlq6BZ0Kyt9VAk4BmReYTFT3w
         Ma8oFLbAiOcm4EDUhlitHn1n9b6GbHcpxvJOuSaNjFw/TWeLhDQYIIMrceeDl37yP4
         KVbh0Wu1CZW3JBtuJV7kqgulO3QuM2bchgjdceFsa75T0vDch/xM5c0hKSufey1L10
         JlHdgrGAHhk5Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nI_BGAxrNA_7; Fri, 26 Feb 2021 10:32:35 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D4EED30F9CE;
        Fri, 26 Feb 2021 10:32:35 -0500 (EST)
Date:   Fri, 26 Feb 2021 10:32:35 -0500 (EST)
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
Message-ID: <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210226135156.1081606-1-figiel@google.com>
References: <20210226135156.1081606-1-figiel@google.com>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Thread-Index: 8ww6gQARVjS9yplUpDDdbZG1dtieAw==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Feb 26, 2021, at 8:51 AM, Piotr Figiel figiel@google.com wrote:
[...]
> ---
> v2:
> Applied review comments:
> - changed return value from the ptrace request to the size of the
>   configuration structure
> - expanded configuration structure with the flags field and
>   the rseq abi structure size
> 
[...]
> +#define PTRACE_GET_RSEQ_CONFIGURATION	0x420f
> +
> +struct ptrace_rseq_configuration {
> +	__u64 rseq_abi_pointer;
> +	__u32 rseq_abi_size;
> +	__u32 signature;
> +	__u32 flags;
> +	__u32 pad;
> +};
> +
[...]
> +#ifdef CONFIG_RSEQ
> +static long ptrace_get_rseq_configuration(struct task_struct *task,
> +					  unsigned long size, void __user *data)
> +{
> +	struct ptrace_rseq_configuration conf = {
> +		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
> +		.rseq_abi_size = sizeof(*task->rseq),
> +		.signature = task->rseq_sig,
> +		.flags = 0,
> +	};
> +
> +	size = min_t(unsigned long, size, sizeof(conf));
> +	if (copy_to_user(data, &conf, size))
> +		return -EFAULT;
> +	return sizeof(conf);
> +}

I think what Florian was after would be:

struct ptrace_rseq_configuration {
	__u32 size;  /* size of struct ptrace_rseq_configuration */
	__u32 flags;
	__u64 rseq_abi_pointer;
	__u32 signature;
	__u32 pad;
};

where:

    .size = sizeof(struct ptrace_rseq_configuration),

This way, the configuration structure can be expanded in the future. The
rseq ABI structure is by definition fixed-size, so there is no point in
having its size here.

Florian, did I understand your request correctly, or am I missing your point ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
