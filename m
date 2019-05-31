Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A29309D6
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 10:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfEaIGc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 04:06:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfEaIGc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 31 May 2019 04:06:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AAEE30C31B7;
        Fri, 31 May 2019 08:06:31 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-86.ams2.redhat.com [10.36.116.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49EDA5126B;
        Fri, 31 May 2019 08:06:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v10)
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
        <20190503184219.19266-2-mathieu.desnoyers@efficios.com>
        <87h89gjgaf.fsf@oldenburg2.str.redhat.com>
        <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com>
        <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
        <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com>
Date:   Fri, 31 May 2019 10:06:19 +0200
In-Reply-To: <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 30 May 2019 16:56:41 -0400
        (EDT)")
Message-ID: <875zprm4jo.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 31 May 2019 08:06:31 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> I found that it's because touching a __thread variable from
> ld-linux-x86-64.so.2 ends up setting the DF_STATIC_TLS flag
> for that .so, which is really not expected.
>
> Even if I tweak the assert to make it more lenient there,
> touching the __thread variable ends up triggering a SIGFPE.

Sorry, I got distracted at this critical juncture.  Yes, I forgot that
there isn't TLS support in the dynamic loader today.

> So rather than touching the TLS from ld-linux-x86-64.so.2,
> I've rather experimented with moving the rseq initialization
> for both SHARED and !SHARED cases to a library constructor
> within libc.so.
>
> Are you aware of any downside to this approach ?

The information whether the kernel supports rseq would not be available
to IFUNC resolvers.  And in some cases, ELF constructors for application
libraries could run before the libc.so.6 constructor, so applications
would see a transition from lack of kernel support to kernel support.

> +static
> +__attribute__ ((constructor))
> +void __rseq_libc_init (void)
> +{
> +  rseq_init ();
> +  /* Register rseq ABI to the kernel.   */
> +  (void) rseq_register_current_thread ();
> +}

I think the call to rseq_init (and the __rseq_handled variable) should
still be part of the dynamic loader.  Otherwise there could be confusion
about whether glibc handles the registration (due the constructor
ordering issue).

Thanks,
Florian
