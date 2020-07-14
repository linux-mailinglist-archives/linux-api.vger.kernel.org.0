Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29621F863
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgGNRnC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 13:43:02 -0400
Received: from mail.efficios.com ([167.114.26.124]:54638 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgGNRnC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 13:43:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0C1112C05BD;
        Tue, 14 Jul 2020 13:43:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nhR_Ah5mzdji; Tue, 14 Jul 2020 13:43:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9B5322C05BA;
        Tue, 14 Jul 2020 13:43:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9B5322C05BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594748580;
        bh=seWsR9nNwIwjY1q15u9E8IBkaous6A8kQWGjHM+M0II=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QJj2qL1Ma0h6IeEjzZADML6kkN8v4eT107DDZrwJ+tyI/VsmDvqiGp9CQxSDmgAqI
         bhx5+yyK0iAMlqrjXYMtrw9il4bcv6lnlp3KUYX05k/X9eOWRn63jqe+M8mSarDD7P
         zb/k68oYI+Bgwp96llrOudcKEGHJRQmuBSYNk/fuB8aoGBsVdPorwgf2uzONz2naDW
         5YMPhncirtjqTJtLMXSeNz3gS44bQpeuMRKuZSxPWQjJ++w7QNe9P7yoKa2FVKfQVx
         eFmZwoNld+EOjWWgz6LwfMFxwLjgvSA0NYRGfntx4UdxatKUwt9URxE0NVDZCcYKsO
         AcmeEVBLv1roA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yo41s664PUBE; Tue, 14 Jul 2020 13:43:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 85BEE2C05B9;
        Tue, 14 Jul 2020 13:43:00 -0400 (EDT)
Date:   Tue, 14 Jul 2020 13:43:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos <carlos@redhat.com>,
        Peter Oskolkov <posk@google.com>
Message-ID: <775688146.12145.1594748580461.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFTs51UHaUqaKj5bEj0vQtEZrww9gnrqb-kGVk7DAgQJPBAR+w@mail.gmail.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <CAFTs51UHaUqaKj5bEj0vQtEZrww9gnrqb-kGVk7DAgQJPBAR+w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: vGEUEey8cuOfMMOgr2MenI2vkLZz+g==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 14, 2020, at 1:24 PM, Peter Oskolkov posk@posk.io wrote:

> At Google, we actually extended struct rseq (I will post the patches
> here once they are fully deployed and we have specific
> benefits/improvements to report). We did this by adding several fields
> below __u32 flags (the last field currently), and correspondingly
> increasing rseq_len in rseq() syscall. If the kernel does not know of
> this extension, it will return -EINVAL due to an unexpected rseq_len;
> then the application can either fall-back to the standard/upstream
> rseq, or bail. If the kernel does know of this extension, it accepts
> it. If the application passes the old rseq_len (32), the kernel knows
> that this is an old application and treats it as such.
> 
> I looked through the archives, but I did not find specifically why the
> pretty standard approach described above is considered inferior to the
> one taken in this patch (freeze rseq_len at 32, add additional length
> fields to struct rseq). Can these be summarized?

I think you don't face the issues I'm facing with libc rseq integration
because you control the entire user-space software ecosystem at Google.

The main issue we face is that the library responsible for registering
rseq (either glibc 2.32+, an early-adopter librseq library, or the
application) may very well not be the same library defining the __rseq_abi
symbol used in the global symbol table. Interposition with ld preload or
by defining the __rseq_abi in the program's executable are good examples
of this kind of scenario, and those use-cases are supported.

So the size of the __rseq_abi structure may be larger than the struct
rseq known by glibc (and eventually smaller, if future glibc versions
extend their __rseq_abi size but is loaded with an older program/library
doing __rseq_abi interposition).

So we need some way to allow code defining the __rseq_abi to let the kernel
know how much room is available, without necessarily requiring the code
responsible for rseq registration to be aware of that extended layout.
This is the purpose of the __rseq_abi.flags RSEQ_FLAG_TLS_SIZE and field
__rseq_abi.user_size.

And we need some way to allow the kernel to let user-space rseq critical
sections (user code) know how much of those fields are actually populated
by the kernel. This is the purpose of __rseq_abi.flags RSEQ_FLAG_TLS_SIZE
with __rseq_abi.kernel_size.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
