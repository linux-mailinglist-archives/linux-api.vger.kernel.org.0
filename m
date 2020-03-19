Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF7418BBB2
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 16:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCSP4h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 11:56:37 -0400
Received: from mail.efficios.com ([167.114.26.124]:56496 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgCSP4h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 11:56:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ED29C278DA8;
        Thu, 19 Mar 2020 11:56:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 00H5Rq2IezWF; Thu, 19 Mar 2020 11:56:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 76296278DA7;
        Thu, 19 Mar 2020 11:56:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 76296278DA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584633395;
        bh=wzmjzK7D6MR+WzKCsHdIPE5bCMu9VKLlVLXpnXJgfGI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=A1k9XRKuzGSqub6T4NlGnRKjrdw5bz7hGJ3vR4t8IuSsDZNszJQpnkGEnQepmSQcZ
         RxkzHUmfo5nMYCwQzrcTO1nuXH+xh9QYyqNcxuEL2y8SaDWymAZ/6/s/8j1QwIB7uy
         ootn5pshFMpisHmKlHtkZ2iQyTLc+cR29tTTVS8E+8vrYi/gMi+3KcyElMoArE7Nxf
         fcN0mW63vmSl1EMSjAigS4WFr9FKnj/Uu7h8dOueX8XlOGXhWfRRCdSwy9nyPo6t+p
         bv49rx+zfO/G2L7WdVCquT+saWIZI6IxeB9ZalnxEJE7W2eLyFAZxUXjkhdbjtOmSg
         k/0tRcj75960Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nYNsfCZiSBRm; Thu, 19 Mar 2020 11:56:35 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 619D7278DA6;
        Thu, 19 Mar 2020 11:56:35 -0400 (EDT)
Date:   Thu, 19 Mar 2020 11:56:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     libc-alpha <libc-alpha@sourceware.org>, carlos <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Message-ID: <2147217200.3240.1584633395285.JavaMail.zimbra@efficios.com>
In-Reply-To: <874kukpf9f.fsf@mid.deneb.enyo.de>
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com> <20200319144110.3733-5-mathieu.desnoyers@efficios.com> <874kukpf9f.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v15)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v15)
Thread-Index: +wQ/afczq9ft3jDapmb/EGDwKihxiQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 19, 2020, at 10:53 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers via Libc-alpha:
> 
>> Changes since v14:
>> - Update copyright range to include 2020.
>> - Introduce __ASSUME_RSEQ defined for --enable-kernel=4.18.0 and higher.
>> - Use ifdef __ASSUME_RSEQ rather than ifdef __NR_rseq to discover rseq
>>   availability. This is necessary now that the system call numbers are
>>   integrated within glibc.
> 
> It's not quite clear to me why you need __ASSUME_RSEQ.

This is how I noticed other Linux features were being integrated,
so I figured this is how I should do it. Monkey see, monkey do. ;-)

> Can you use __has_include in <sys/rseq.h>, with a copy of the kernel
> definitions if the kernel header is not available?

Sure. Should I pull a verbatim copy of uapi linux/rseq.h into glibc ?
If so, where should I put it ?

Thanks,

Mathieu




-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
