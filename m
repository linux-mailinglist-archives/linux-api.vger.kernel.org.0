Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23DC35F179
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhDNK1t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 06:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232276AbhDNK1s (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 06:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618396047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vMLyJy+yuIUeQ69Nie1nVj2ps7AR8ETn5DL2B4VvFQI=;
        b=JE8ws063FQoAIwfFCDHiF/5SIqJ3/seymoUwLVt6tG8bCgvywBs+lpMpOMSw5rUkaTAR48
        +fgCULGhpQ2aRwrJZsUmMhKLrCYOCrGxvBcn70v1puUM5AfHy86XguuiGi7syzviuB+yd3
        f9qdlaoajc2vXhH+V9iYVLmaF4Q2Wj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-qkYKl8RuMciGaPIHYwMLdg-1; Wed, 14 Apr 2021 06:27:23 -0400
X-MC-Unique: qkYKl8RuMciGaPIHYwMLdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EEBE8030C4;
        Wed, 14 Apr 2021 10:27:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-148.ams2.redhat.com [10.36.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A5D41A86B;
        Wed, 14 Apr 2021 10:27:14 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
References: <20210414055217.543246-1-avagin@gmail.com>
Date:   Wed, 14 Apr 2021 12:27:28 +0200
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com> (Andrei Vagin's
        message of "Tue, 13 Apr 2021 22:52:13 -0700")
Message-ID: <87blahb1pr.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Andrei Vagin:

> We already have process_vm_readv and process_vm_writev to read and write
> to a process memory faster than we can do this with ptrace. And now it
> is time for process_vm_exec that allows executing code in an address
> space of another process. We can do this with ptrace but it is much
> slower.
>
> = Use-cases =

We also have some vaguely related within the same address space: running
code on another thread, without modifying its stack, while it has signal
handlers blocked, and without causing system calls to fail with EINTR.
This can be used to implement certain kinds of memory barriers.  It is
also necessary to implement set*id with POSIX semantics in userspace.
(Linux only changes the current thread credentials, POSIX requires
process-wide changes.)  We currently use a signal for set*id, but it has
issues (it can be blocked, the signal could come from somewhere, etc.).
We can't use signals for barriers because of the EINTR issue, and
because the signal context is stored on the stack.

Thanks,
Florian

