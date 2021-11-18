Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8F4558D6
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 11:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244690AbhKRKVh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 05:21:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245591AbhKRKUu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 05:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637230667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8eqRZecyj/j5XPB6t4e5kN3QtTyfvI/6epjyriZieOU=;
        b=CxpElZLpqm3xNZiOlkDgGyisjLBAhxGNnSY9ADO0MH7KWXe9f977qxfr0OPBCDQyU71AP2
        qD6t9O5ZkVRVW9/Mg+eYX1VSBiYGobIS2Lp4jEP6mkmKhQEznzS+WgFhs0TbofaLHNwT1a
        8TJRq6q+YXD5uIEu7jAn8MLHyAu+YKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-3ppug3E_MZ2FwhzM-8fOEw-1; Thu, 18 Nov 2021 05:17:42 -0500
X-MC-Unique: 3ppug3E_MZ2FwhzM-8fOEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F45F1808309;
        Thu, 18 Nov 2021 10:17:41 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3430A5C1D0;
        Thu, 18 Nov 2021 10:17:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     libc-alpha@sourceware.org
Cc:     linux-api@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Rich Felker <dalias@libc.org>
Subject: Bringing rseq back into glibc
Date:   Thu, 18 Nov 2021 11:17:36 +0100
Message-ID: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I would like to bring back rseq for glibc 2.35.  I propose the following
steps:

1. Enable rseq registration in glibc, for internal use only.  This time,
   put the rseq area into struct pthread, not into a initial-exec TLS
   symbol.  (This helps to avoid with initial-exec TLS bloat with dlopen
   and simplifies initialization somewhat.)

2. Add a tunable to disable rseq registration in glibc.  This way, if
   there is already an rseq user, it can be made to work again by
   setting the tunable.

3. Implement sched_getcpu on top of rseq.

4. Add public symbols __rseq_abi_offset, __rseq_abi_size (currently 32
   or 0), __rseq_abi_flags (currently 0).  __rseq_abi_offset is the
   offset to add to the thread pointer (see __builtin_thread_pointer) to
   get to the rseq area.  They will be public ABI symbols.  These
   variables are initialized before user code runs, and changing the
   results in undefined behavior.

Under this model, the rseq area offset is clearly constant across all
threads.  (This was previously implied by using initial-exec TLS
memory.)  rseq registration failure is indicated by __rseq_abi_size ==
0.  If the size is non-zero, rseq will be registered on all threads
created by glibc, and all the time as far as user code is concernes.
(This assumes that if rseq registration succeeds on the main thread, it
will succeed on all other threads.  We will terminate the process if
not.)  For example, if a JIT compiler sees __rseq_abi_size >= 32, in
generated code, it can inline a version of sched_getcpu that
materializes the thread pointer and loads the cpu_id field from the rseq
area, without further checks.  Under the old TLS-based model, it was
less clear that this was a valid optimization.

Furthermore, I believe this approach will be more compatible with
potential future kernel changes in this area.  If the kernel tells us
some day through the auxiliary vector that we should register a 128-byte
rseq area with 64-byte alignment, we can make that happen and change
__rseq_abi_offset and __rseq_abi_size accordingly.

Steps 1 to 3 are backportable to previous glibc version, especially to
2.34 with its integrated libpthread.

Comments?  As I said, I'd like to bring these changes into glibc 2.35,
hopefully in early December.

Thanks,
Florian

