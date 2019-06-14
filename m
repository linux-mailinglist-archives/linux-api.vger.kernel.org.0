Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC9845E73
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfFNNjN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:39:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:41242 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfFNNjN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 09:39:13 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A563B251635;
        Fri, 14 Jun 2019 09:39:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id GnCFb0jxdTlM; Fri, 14 Jun 2019 09:39:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3112D25162D;
        Fri, 14 Jun 2019 09:39:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3112D25162D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560519551;
        bh=g11SeW4F7paEUETkOqOR7pC/7HcUtfs8xDR7RV9Lcyc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bmoEbTEoy8FbWGZKWm4OIDeztip9KPC7WHuudiL4/WygRNBbB7MHLq6cp/Q82/u6s
         MZIRFg9ankQrHB1IzwB0XutT1gJsfq6AbpKOJKLnxO6d2R2CG6Ip36uB8VWPKzR8tl
         ekw891XGCbzwWZuE0IGxHiJARWkEVrp8Oges+tXqhNN7+jmCWR+/WaiU1mj2l0iG9H
         i5JJ5gPseoFn5cp5Py420JTHRMp/OnxxyDNLeWQ1xEkbMDtS5/J9FMaSCCaACvg6zA
         MoMmMPoqcmd/uqWeo24R6bn/rV/DTXW1kLtdZDyl2G+Prz6V9YKvKfw3Sa1On3BbqL
         j9mOh7xxX9GqQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id A4nfGl2sb7Zt; Fri, 14 Jun 2019 09:39:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 176B2251626;
        Fri, 14 Jun 2019 09:39:11 -0400 (EDT)
Date:   Fri, 14 Jun 2019 09:39:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Florian Weimer <fweimer@redhat.com>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1503067753.3387.1560519550939.JavaMail.zimbra@efficios.com>
In-Reply-To: <69a53ec2ce184af29c4cae58e0b2fb57@AcuMS.aculab.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com> <87ftocwkei.fsf@oldenburg2.str.redhat.com> <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com> <87tvcsv1pk.fsf@oldenburg2.str.redhat.com> <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com> <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com> <69a53ec2ce184af29c4cae58e0b2fb57@AcuMS.aculab.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: AdUitTFqJqb3c4uCSB28nMsheH09dGcCn4Ez
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 14, 2019, at 3:29 PM, David Laight David.Laight@ACULAB.COM wrote:

> From: Mathieu Desnoyers
>> Sent: 14 June 2019 14:02
> ...
>> But my original issue remains: if I define a variable called __rseq_handled
>> within either the main executable or the preloaded library, it overshadows
>> the libc one:
> 
> 1) That is the was elf symbol resolution is required to work.
>   Otherwise variables like 'errno' (non-thread safe form) wouldn't work.
> 
> 2) Don't do it then :-)
>   Names starting with __ will be reserved (probably 'for the implementation').
> 
> The real 'fun' starts because, under some circumstances, looking up a symbol as:
>	foo = dlsym(lib_handle, "foo");
> Can find the data item instead of the function!
> Usually it works (even when foo is global data) because 'lib_handle' refers
> to a different symbol table.
> But it can go horribly wrong.

I was setting __rseq_handled too soon, before re-relocation of the dynamic linker.
I moved the initialization after re-relocation and it works fine now.

The purpose of __rseq_handled is to allow early adopter libraries and applications
to define their own global instance of the symbol, and check whether the libc
they are linked against handle rseq registration or not.

libc specifies the layout of that variable (an integer). The dynamic linker
chooses one of those instances so it's used in the global symbol table of the
program. The important thing is that all libraries agree on that global symbol.
Of course this is not compatible with libraries compiled with forced "hidden"
symbols only.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
