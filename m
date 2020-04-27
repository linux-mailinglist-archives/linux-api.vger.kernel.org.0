Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03EE1BA30E
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 13:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgD0L7Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 07:59:16 -0400
Received: from albireo.enyo.de ([37.24.231.21]:51092 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgD0L7Q (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 07:59:16 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jT2Pj-0001h5-7F; Mon, 27 Apr 2020 11:59:07 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jT2Pj-0006cz-2z; Mon, 27 Apr 2020 13:59:07 +0200
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
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C startup and thread creation (v17)
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
        <20200326155633.18236-6-mathieu.desnoyers@efficios.com>
Date:   Mon, 27 Apr 2020 13:59:07 +0200
In-Reply-To: <20200326155633.18236-6-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers via Libc-alpha's message of "Thu, 26 Mar 2020 11:56:29
        -0400")
Message-ID: <87ftcpxhpw.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers via Libc-alpha:

> diff --git a/elf/libc_early_init.c b/elf/libc_early_init.c
> index 1ac66d895d..30466afea0 100644
> --- a/elf/libc_early_init.c
> +++ b/elf/libc_early_init.c
> @@ -18,10 +18,13 @@
>  
>  #include <ctype.h>
>  #include <libc-early-init.h>
> +#include <rseq-internal.h>
>  
>  void
>  __libc_early_init (void)
>  {
>    /* Initialize ctype data.  */
>    __ctype_init ();
> +  /* Register rseq ABI to the kernel.   */
> +  (void) rseq_register_current_thread ();
>  }

I think the registration must be restricted to the primary namespace.
Otherwise, LD_AUDIT will register the area to the secondary libc (in
the audit module), not the primary libc for the entire process.

I think the easiest way to implement this for now is a flag argument
for __libc_early_init (as the upstream __libc_multiple_libcs is not
entirely accurate).  I will submit a patch.
