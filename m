Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49D21269C
	for <lists+linux-api@lfdr.de>; Thu,  2 Jul 2020 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgGBOqm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Jul 2020 10:46:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54626 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729934AbgGBOqj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Jul 2020 10:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593701198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sfReHjMG1okIi6bUbbQpOqD3Ch8gtx1iU9O9hVtsN/8=;
        b=emc+bdZ4qTXh9qfjakR7wbzVYuHXSwygSqm2Lrv+4aywCVnZCuYlHXq9d1w6D80k1lcGnP
        bXkTp6BNpPGkO0DMMB46C7slWX0BkTTdRBKOOjLAK9JRrwVDnkqPSafPkoWqsJKxXjXPNT
        49SXu079n17mEPzr5PjHtzhd/aT2+ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-GbGUuS2aPx2QW6v9bWRqWQ-1; Thu, 02 Jul 2020 10:46:32 -0400
X-MC-Unique: GbGUuS2aPx2QW6v9bWRqWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C383A879512;
        Thu,  2 Jul 2020 14:46:24 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-162.ams2.redhat.com [10.36.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8557B1CA;
        Thu,  2 Jul 2020 14:46:18 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rich Felker <dalias@libc.org>, linux-api@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and thread creation (v22)
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com>
        <20200629190036.26982-2-mathieu.desnoyers@efficios.com>
Date:   Thu, 02 Jul 2020 16:46:17 +0200
In-Reply-To: <20200629190036.26982-2-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers via Libc-alpha's message of "Mon, 29 Jun 2020 15:00:34
        -0400")
Message-ID: <87o8oy9dqe.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers via Libc-alpha:

> Register rseq TLS for each thread (including main), and unregister for
> each thread (excluding main).  "rseq" stands for Restartable Sequences.
>
> See the rseq(2) man page proposed here:
>   https://lkml.org/lkml/2018/9/19/647
>
> Those are based on glibc master branch commit 3ee1e0ec5c.
> The rseq system call was merged into Linux 4.18.
>
> The TLS_STATIC_SURPLUS define is increased to leave additional room for
> dlopen'd initial-exec TLS, which keeps elf/tst-auditmany working.
>
> The increase (76 bytes) is larger than 32 bytes because it has not been
> increased in quite a while.  The cost in terms of additional TLS storage
> is quite significant, but it will also obscure some initial-exec-related
> dlopen failures.

We need another change to get this working on most non-x86
architectures:

diff --git a/elf/dl-tls.c b/elf/dl-tls.c
index 817bcbbf59..ca13778ca9 100644
--- a/elf/dl-tls.c
+++ b/elf/dl-tls.c
@@ -134,6 +134,12 @@ void
 _dl_determine_tlsoffset (void)
 {
   size_t max_align = TLS_TCB_ALIGN;
+  /* libc.so with rseq has TLS with 32-byte alignment.  Since TLS is
+     initialized before audit modules are loaded and slotinfo
+     information is available, this is not taken into account below in
+     the audit case.  */
+  max_align = MAX (max_align, 32U);
+
   size_t freetop = 0;
   size_t freebottom = 0;

This isn't visible on x86-64 because TLS_TCB_ALIGN is already 64 there.

I plan to re-test with this fix and push the series.

Carlos, is it okay if I fold in the dl-tls.c change if testing looks
good?

Thanks,
Florian

