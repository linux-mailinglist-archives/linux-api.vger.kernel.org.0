Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D845B8A
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 13:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfFNLf7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 07:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfFNLf7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 14 Jun 2019 07:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 981DA5945B;
        Fri, 14 Jun 2019 11:35:58 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A5EA5D9D2;
        Fri, 14 Jun 2019 11:35:52 +0000 (UTC)
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
        <87o93d4lqb.fsf@oldenburg2.str.redhat.com>
        <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com>
        <87wohzorj0.fsf@oldenburg2.str.redhat.com>
        <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com>
        <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com>
        <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com>
        <87ftocwkei.fsf@oldenburg2.str.redhat.com>
        <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com>
Date:   Fri, 14 Jun 2019 13:35:51 +0200
In-Reply-To: <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 14 Jun 2019 06:14:09 -0400
        (EDT)")
Message-ID: <87tvcsv1pk.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Jun 2019 11:35:58 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> * Makefile:
>
> LIBCPATH=/home/efficios/glibc-test/lib
> KERNEL_HEADERS=/home/efficios/git/linux-percpu-dev/usr/include
> CFLAGS=-I${KERNEL_HEADERS} -L${LIBCPATH} -Wl,--rpath=${LIBCPATH} -Wl,--dynamic-linker=${LIBCPATH}/ld-linux-x86-64.so.2
>
> all:
> 	gcc ${CFLAGS} -o a a.c
> 	gcc ${CFLAGS} -shared -fPIC -o s.so s.c

For me, that does not correctly link against the built libc because the
system dynamic loader seeps into the link.

> specifically this commit:
> https://github.com/compudj/glibc-dev/commit/c49a286497d065a7fc00aafd846e6edce14f97fc

This commit links __rseq_handled into libc.so.6 via rseq-sym.c, but does
not export it from there.

Thanks,
Florian
