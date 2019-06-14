Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CEC45D7F
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfFNNJp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 09:09:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfFNNJp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 14 Jun 2019 09:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F695368E0;
        Fri, 14 Jun 2019 13:09:35 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19C891001B1B;
        Fri, 14 Jun 2019 13:09:28 +0000 (UTC)
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
        <c16c9785-7f8c-430b-a4df-a53e47bf1600@redhat.com>
        <914051741.43025.1560348011775.JavaMail.zimbra@efficios.com>
        <802638054.3032.1560506584705.JavaMail.zimbra@efficios.com>
        <87ftocwkei.fsf@oldenburg2.str.redhat.com>
        <1635690189.3049.1560507249693.JavaMail.zimbra@efficios.com>
        <87tvcsv1pk.fsf@oldenburg2.str.redhat.com>
        <1190407525.3131.1560516910936.JavaMail.zimbra@efficios.com>
        <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com>
Date:   Fri, 14 Jun 2019 15:09:27 +0200
In-Reply-To: <1085273942.3137.1560517301721.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 14 Jun 2019 09:01:41 -0400
        (EDT)")
Message-ID: <87d0jguxdk.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 14 Jun 2019 13:09:45 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> But my original issue remains: if I define a variable called __rseq_handled
> within either the main executable or the preloaded library, it overshadows
> the libc one:
>
> efficios@compudjdev:~/test/libc-sym$ ./a
> __rseq_handled main: 0 0x56135fd5102c
> __rseq_abi.cpu_id main: 29 0x7fcbeca6d5a0
> efficios@compudjdev:~/test/libc-sym$ LD_PRELOAD=./s.so ./a
> __rseq_handled s.so: 0 0x558f70aeb02c
> __rseq_abi.cpu_id s.so: -1 0x7fdca78b7760
> __rseq_handled main: 0 0x558f70aeb02c
> __rseq_abi.cpu_id main: 27 0x7fdca78b7760
>
> Which is unexpected.

Why is this unexpected?  It has to be this way if the main program uses
a copy relocation of __rseq_handled.  As long as there is just one
address across the entire program and ld.so initializes the copy of the
variable that is actually used, everything will be fine.

Thanks,
Florian
