Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B81BAA4C
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 18:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgD0QrN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 12:47:13 -0400
Received: from mail.efficios.com ([167.114.26.124]:45496 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgD0QrM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 12:47:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3828A25ABA2;
        Mon, 27 Apr 2020 12:47:11 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6kZC_M8qLWLq; Mon, 27 Apr 2020 12:47:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E626125A555;
        Mon, 27 Apr 2020 12:47:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E626125A555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588006030;
        bh=SCR0YXx7Ksd6h99vRKL/EL/KUijBXa/Pxw+bu0rC7s0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XzBc9jheMqKkakYI4T8Slk1bFyXwnehB7UObX8kVXkYJLfX08xI5Z2kv2y36y68X8
         WXVLBPxJ01RijyBeP+yZKKGD8DEaU1SJgIaYf+NJXhF5iWXoQLV8wJBdyKUSJukUVQ
         q4BhuocKu/3vgKQbbraPbhhe6FGkG+wgtv2DNFX6REUe8FdibYsSl0Khh5mz3N6bgc
         u6og0JGtglLEc9jUicZfuET+mo84zxJ2X8Tn5K7iItHkFDSFOerkZBDIF4hjqpudlb
         upqYZBGiSBjMjq4xV7p6klXNqaEDq4OAmcArVPTeOlx2VKGS4SW7BACoriYacfbkje
         xkHQNPDkyw3Tg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pxMlmkdvfxuZ; Mon, 27 Apr 2020 12:47:10 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D4F4825A551;
        Mon, 27 Apr 2020 12:47:10 -0400 (EDT)
Date:   Mon, 27 Apr 2020 12:47:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        Carlos O'Donell <carlos@redhat.com>,
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
Message-ID: <1660640739.70637.1588006030777.JavaMail.zimbra@efficios.com>
In-Reply-To: <87ftcpxhpw.fsf@mid.deneb.enyo.de>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com> <20200326155633.18236-6-mathieu.desnoyers@efficios.com> <87ftcpxhpw.fsf@mid.deneb.enyo.de>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v17)
Thread-Index: +/FwB08aOPyK5lJHGmbcAUAOKgI6cw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 27, 2020, at 7:59 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers via Libc-alpha:
> 
>> diff --git a/elf/libc_early_init.c b/elf/libc_early_init.c
>> index 1ac66d895d..30466afea0 100644
>> --- a/elf/libc_early_init.c
>> +++ b/elf/libc_early_init.c
>> @@ -18,10 +18,13 @@
>>  
>>  #include <ctype.h>
>>  #include <libc-early-init.h>
>> +#include <rseq-internal.h>
>>  
>>  void
>>  __libc_early_init (void)
>>  {
>>    /* Initialize ctype data.  */
>>    __ctype_init ();
>> +  /* Register rseq ABI to the kernel.   */
>> +  (void) rseq_register_current_thread ();
>>  }
> 
> I think the registration must be restricted to the primary namespace.
> Otherwise, LD_AUDIT will register the area to the secondary libc (in
> the audit module), not the primary libc for the entire process.
> 
> I think the easiest way to implement this for now is a flag argument
> for __libc_early_init (as the upstream __libc_multiple_libcs is not
> entirely accurate).  I will submit a patch.

OK, once I get the patch, I will pick it up in my series.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
