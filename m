Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF532C68E
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346632AbhCDA3M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:29:12 -0500
Received: from mail.efficios.com ([167.114.26.124]:41052 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349597AbhCCTFJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Mar 2021 14:05:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D15D43220FC;
        Wed,  3 Mar 2021 13:55:00 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aAXDIHMqpOpt; Wed,  3 Mar 2021 13:55:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6A56B3220FB;
        Wed,  3 Mar 2021 13:55:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6A56B3220FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614797700;
        bh=rCq90Cemnj8uIDnzvWa7FZTmINWyPkoJYeBmJ7lHhLM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GTVjsfF3WiOHC2+vY+c6TYY9cvcQDkrU+9bfM2NO0e0kcGRUbJPZ0w9WB4tmtup/O
         /LgQNvgx5blMss5mLTbGC9t8q4ylQ16nXq7t1NqOuSDMIkpVJNKhkDhZTLiytPfJSw
         MRhu+8V5EYuKKUx76PvITOIXlmpXwlhmi0HxnUZD8Uwp3x4PFWgi0ciJxLXAWirSOL
         ooJYN9AFHuC1x9a/aVWn5SAfeEHXL/ZH/hbwr8bZKq2wQu8X1Aepe5ZPVag69T3yK2
         wNgkYVqjbqXR69ZZ5TlGr/Fhhts25RH9eLhlk55OZ1icgBvm/5YTBHk+GeFxjls+Ga
         T+VjiPIxCa9pQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z7lHbMmAUfH0; Wed,  3 Mar 2021 13:55:00 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 562F43224B8;
        Wed,  3 Mar 2021 13:55:00 -0500 (EST)
Date:   Wed, 3 Mar 2021 13:55:00 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Piotr Figiel <figiel@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir <emmir@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1698111952.9528.1614797700222.JavaMail.zimbra@efficios.com>
In-Reply-To: <YDkBlYp76PGsgUZs@google.com>
References: <20210222100443.4155938-1-figiel@google.com> <1521573573.29432.1614005597395.JavaMail.zimbra@efficios.com> <YDkBlYp76PGsgUZs@google.com>
Subject: Re: [PATCH] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Thread-Index: cQoLUNh7wF6cm+pfSb0FxCqp8YWzpA==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Feb 26, 2021, at 9:11 AM, Piotr Figiel figiel@google.com wrote:

> Hi,
> 
> On Mon, Feb 22, 2021 at 09:53:17AM -0500, Mathieu Desnoyers wrote:
> 
>> I notice that other structures defined in this UAPI header are not
>> packed as well.  Should we add an attribute packed on new structures ?
>> It seems like it is generally a safer course of action, even though
>> each field is naturally aligned here (there is no padding/hole in the
>> structure).
> 
> I considered this for quite a while. There are some gains for this
> approach, i.e. it's safer towards the ISO C, as theoretically compiler
> can generate arbitrary offsets as long as struct elements have correct
> order in memory.
> Also with packed attribute it would be harder to make it incorrect in
> future modifications.
> User code also could theoretically put the structure on any misaligned
> address.
> 
> But the drawback is that all accesses to the structure contents are
> inefficient and some compilers may generate large chunks of code
> whenever the structure elements are accessed (I recall at least one ARM
> compiler which generates series of single-byte accesses for those). For
> kernel it doesn't matter much because the structure type is used in one
> place, but it may be different for the application code.
> 
> The change would be also inconsistent with the rest of the file and IMO
> the gains are only theoretical.
> 
> If there are more opinions on this or you have some argument I'm missing
> please let me know I can send v3 with packed and explicit padding
> removed. I think this is rather borderline trade off.

I personally don't have a strong opinion on this and completely agree with
your analysis. Maybe for pre-existing system calls adding more non-packed
structures might be kind-of OK if some were already exposed, even though
it seems rather fragile wrt ISO C.

Thanks,

Mathieu

> 
> Best regards and thanks for looking at this,
> Piotr.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
