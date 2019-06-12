Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BFF42972
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfFLOgG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 10:36:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:54476 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfFLOgG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 10:36:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8911D249436;
        Wed, 12 Jun 2019 10:36:04 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id lj07YLCufUMI; Wed, 12 Jun 2019 10:36:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5599B24942E;
        Wed, 12 Jun 2019 10:36:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5599B24942E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560350163;
        bh=CQJvFqLWHjpXxyGISC4bp4dzIRicyxqlzHNr21zpE6c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=q33EV28kaNy1/vmwbhSQwXx5/2HYtlLIrgzGsf17zDqgBPwm+IgEW5rqsJWmfAWI9
         nFa53eojvq5rojoCsVg3pdaYCesQAEsSSWolBHdDaR40KlaoSPOtR7PojlDH0uHiMW
         fwn5MfPk/sIQysQe0J2I2FPqVXOlVzIBVmiOpOCLlcJN130xde0kaPlT8SuNY83tSO
         5Iipld3BzRO5V/FA/lnKTC6o5hsWI0lJ7iaddqf1GaYnprFBYANpExfZnQ7Pw9iIMO
         /tWdrX2lJVRXxstD27aqInD6EO7tHO7rfLeAsLe5cjb9/mfQnxCZGGKojz4TxOvGoD
         4jRHQSEjds9wA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id YBV3Ug4T_Nce; Wed, 12 Jun 2019 10:36:03 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3D439249426;
        Wed, 12 Jun 2019 10:36:03 -0400 (EDT)
Date:   Wed, 12 Jun 2019 10:36:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
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
Message-ID: <512441263.43096.1560350163180.JavaMail.zimbra@efficios.com>
In-Reply-To: <87blz27uio.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <87muj2k4ov.fsf@oldenburg2.str.redhat.com> <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com> <87o93d4lqb.fsf@oldenburg2.str.redhat.com> <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com> <87wohzorj0.fsf@oldenburg2.str.redhat.com> <1329439108.43041.1560348962006.JavaMail.zimbra@efficios.com> <87blz27uio.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: QXw97AD98r6EHKvsnZ7iwPC2gI7hig==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 12, 2019, at 4:22 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>>> It's the registration from libc.so which needs some care.  In
>>> particular, we must not override an existing registration.
>>
>> OK, so it could check if __rseq_abi.cpu_id is -1, and only
>> perform registration if it is the case. Or do you have another
>> approach in mind ?
> 
> No, __rseq_abi will not be shared with the outer libc, so the inner libc
> will always see -1 there, even if the outer libc has performed
> registration.
> 
> libio/vtables.c has some example what you can do:
> 
>  /* In case this libc copy is in a non-default namespace, we always
>     need to accept foreign vtables because there is always a
>     possibility that FILE * objects are passed across the linking
>     boundary.  */
>  {
>    Dl_info di;
>    struct link_map *l;
>    if (!rtld_active ()
>        || (_dl_addr (_IO_vtable_check, &di, &l, NULL) != 0
>            && l->l_ns != LM_ID_BASE))
>      return;
>  }
> 
> _IO_vtable_check would have to be replaced with your own function; the
> actual function doesn't really matter.
> 
> The rtld_active check covers the static dlopen case, where
> rtld_active () is false in the inner libc.

Then out of curiosity, would it also work if I check for

if (!__libc_multiple_libcs)

in LIBC_START_MAIN ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
