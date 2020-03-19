Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EDE18BA32
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 16:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgCSPDW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 11:03:22 -0400
Received: from albireo.enyo.de ([37.24.231.21]:47372 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbgCSPDV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Mar 2020 11:03:21 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jEwa5-0004U0-7Q; Thu, 19 Mar 2020 14:55:33 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jEwYO-0004nA-PY; Thu, 19 Mar 2020 15:53:48 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rich Felker <dalias@libc.org>, linux-api@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C startup and thread creation (v15)
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com>
        <20200319144110.3733-5-mathieu.desnoyers@efficios.com>
Date:   Thu, 19 Mar 2020 15:53:48 +0100
In-Reply-To: <20200319144110.3733-5-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers via Libc-alpha's message of "Thu, 19 Mar 2020 10:41:06
        -0400")
Message-ID: <874kukpf9f.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers via Libc-alpha:

> Changes since v14:
> - Update copyright range to include 2020.
> - Introduce __ASSUME_RSEQ defined for --enable-kernel=4.18.0 and higher.
> - Use ifdef __ASSUME_RSEQ rather than ifdef __NR_rseq to discover rseq
>   availability. This is necessary now that the system call numbers are
>   integrated within glibc.

It's not quite clear to me why you need __ASSUME_RSEQ.

Can you use __has_include in <sys/rseq.h>, with a copy of the kernel
definitions if the kernel header is not available?
