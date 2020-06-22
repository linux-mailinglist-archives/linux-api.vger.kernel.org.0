Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26774203AF8
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgFVPdc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 11:33:32 -0400
Received: from mail.efficios.com ([167.114.26.124]:48590 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbgFVPdc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 11:33:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 689812B5439;
        Mon, 22 Jun 2020 11:33:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CPehp3O9YD6P; Mon, 22 Jun 2020 11:33:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 21AE72B5438;
        Mon, 22 Jun 2020 11:33:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 21AE72B5438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1592840011;
        bh=qKn3NIaqc59Pct1rdS+sjFcxV4/S01BfHPl2vuKIfiU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=V4GkxOoLBqwoTp8GzcAqrsBAlGjRr1twqCyDWlPas+U7JPBEdd6Ub92DrmBl0hjwm
         mJc5yxrXTOLH2MDWMXhAo54QuDypBwi/cacuoPsMLAJPwhPhs67zhBhpxLKQtEg5Hd
         RpKS9TDGBxfwqnSyhjPq8e2VqCpq8v/QLkaqzssPxyulLwGINhLl2SFnqMZOvjUKlb
         l51Q7JShGWYLg85pUmWT4tKeMtoEXm3vgrZdM0Ilbj73IH49oahAXnFz2dRlnulnGg
         KF6JGexhFprmz+ImCzMqOmMpgjKPFmwablY5gxZzQhxpKRl+w536h2nQWw+I8xHGbD
         iUyVyO3tUN5aw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qJ1zYRJkj2A7; Mon, 22 Jun 2020 11:33:31 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0F32A2B5437;
        Mon, 22 Jun 2020 11:33:31 -0400 (EDT)
Date:   Mon, 22 Jun 2020 11:33:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>
Message-ID: <79974973.8453.1592840011012.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.2006112026090.18393@digraph.polyomino.org.uk>
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com> <20200527185130.5604-2-mathieu.desnoyers@efficios.com> <87d06gxsla.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.2006031718070.7179@digraph.polyomino.org.uk> <188671972.53608.1591269056445.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2006041745360.8237@digraph.polyomino.org.uk> <419546979.1229.1591897672174.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.2006112026090.18393@digraph.polyomino.org.uk>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v20)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v20)
Thread-Index: LemSq8R3trB8bb1KZi/muKx7JuxCcw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 11, 2020, at 4:26 PM, Joseph Myers joseph@codesourcery.com wrote:

> On Thu, 11 Jun 2020, Mathieu Desnoyers wrote:
> 
>> I managed to get a repository up and running for librseq, and have integrated
>> the rseq.2 man page with comments from Michael Kerrisk here:
>> 
>> https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2
>> 
>> Is that a suitable URL ? Can we simply point to it from glibc's manual ?
> 
> Yes, that seems something reasonable to link to.

OK, I'll point to that then. I've been waiting for Michael Kerrisk to act on
rseq(2) for more than a year now, and this is getting in the way of upstreaming
rseq support into glibc 2.32.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
