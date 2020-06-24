Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5C207C14
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405429AbgFXTQl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 15:16:41 -0400
Received: from mail.efficios.com ([167.114.26.124]:52714 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404563AbgFXTQk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 15:16:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 32B2E2C41EA;
        Wed, 24 Jun 2020 15:16:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Sy_hIEQaqNSw; Wed, 24 Jun 2020 15:16:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D4A622C41E9;
        Wed, 24 Jun 2020 15:16:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D4A622C41E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593026198;
        bh=3iQZiVLyuzca+V6wzidMMRJWMtP3eZM0DyCNIq1qy5A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gLi7cDDYKoLA6fi9D2m9YjL4neyMZO3/xX+0sRd9xuPY3k0RAYiL9OKhPETdy2UrJ
         z8tHPffjw7aJNS6TM58GTkea3FuJmkbJ/N9FJ2M0fQVImRVEP180V4OPxhzjxHUalS
         07Ll1v+SfqY+Hb4T8BhRTC1Dx9iP6XrTBhlA1xoU1cn14782maIaB7LFY2rHp6rqdQ
         dkeih0Scg2lV3eG8CIHF5Hg3DUv81hNLJ5IQw1+ESr/UxfA0vRupwMsvhuaVJs/9Tk
         EZo+kBGQXt8rOYsiXVTPro3r2CsdtcB1ey32YpvI7/ma+gmd/5s7hXuJodUtdbpp9v
         tQbeTDgR83aLQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DBrbA6G8I6OI; Wed, 24 Jun 2020 15:16:38 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BF3DA2C448D;
        Wed, 24 Jun 2020 15:16:38 -0400 (EDT)
Date:   Wed, 24 Jun 2020 15:16:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1248023868.11643.1593026198678.JavaMail.zimbra@efficios.com>
In-Reply-To: <87r1u48eix.fsf@oldenburg2.str.redhat.com>
References: <20200622180803.1449-1-mathieu.desnoyers@efficios.com> <20200622180803.1449-2-mathieu.desnoyers@efficios.com> <87d05obl4w.fsf@oldenburg2.str.redhat.com> <1158112159.11628.1593025203438.JavaMail.zimbra@efficios.com> <87r1u48eix.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and
 thread creation (v21)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v21)
Thread-Index: YkL95Fw6DEDAnKFpYDNCDQAteeHIAQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 24, 2020, at 3:11 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>>> I'm still worried that __rseq_static_assert and __rseq_alignof will show
>>> up in the UAPI with textually different definitions.  (This does not
>>> apply to __rseq_tls_model_ie.)
>>
>> What makes this worry not apply to __rseq_tls_model_ie ?
> 
> It's not needed by the kernel header because it doesn't contain a
> __rseq_abi declaration.
> 
>>> 
>>> Is my worry unfounded?
>>
>> So AFAIU you worry that eventually sys/rseq.h and linux/rseq.h carry different
>> definitions of __rseq_static_assert and __rseq_alignof.
>>
>> Indeed, I did not surround those #define with #ifndef/#endif. Maybe we should ?
>>
>> Just in case the definitions end up being different (worse case scenario), we
>> should expect their behavior to be pretty much equivalent. So going for the
>> following should address your concern I think:
> 
> I think we should keep things simple on the glibc side for now and do
> this changes to the kernel headers first.

Just to be sure I understand what you mean by "keep things simple", do you
recommend removing the following lines completely for now from sys/rseq.h ?

/* Ensure the compiler supports rseq_align.  */
__rseq_static_assert (__rseq_alignof (struct rseq_cs) >= 32, "alignment");
__rseq_static_assert (__rseq_alignof (struct rseq) >= 32, "alignment");

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
