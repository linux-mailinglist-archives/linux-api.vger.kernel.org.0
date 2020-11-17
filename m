Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179BC2B6B9D
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgKQRWd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 12:22:33 -0500
Received: from albireo.enyo.de ([37.24.231.21]:47036 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbgKQRWd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 17 Nov 2020 12:22:33 -0500
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 12:22:32 EST
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kf4ai-0003wT-Ke; Tue, 17 Nov 2020 17:16:28 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kf4ai-0008LT-Gm; Tue, 17 Nov 2020 18:16:28 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: Is adding an argument to an existing syscall okay?
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
Date:   Tue, 17 Nov 2020 18:16:28 +0100
In-Reply-To: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
        (Andy Lutomirski's message of "Mon, 16 Nov 2020 15:57:40 -0800")
Message-ID: <87k0uj6h03.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Andy Lutomirski:

> Linux 5.10 contains this patch:
>
> commit 2a36ab717e8fe678d98f81c14a0b124712719840
> Author: Peter Oskolkov <posk@google.com>
> Date:   Wed Sep 23 16:36:16 2020 -0700
>
>     rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
>
> This adds an argument to an existing syscall.  Before the patch,
> membarrier had 2 parameters; now it has 3.  Is this really okay?  At
> least the patch is careful and ignores the third parameter unless a
> previously unused flag bit is set.

It's really iffy.  It's hard to break this in system call wrappers on
x86-64, where we just load %eax and call into the kernel.  But on
architectures which require argument shuffling, it will break.

If there were a system call wrapper in glibc (my patch was rejected
due to lack of documentation fo the semantics, so we got lucky there),
we'd have to add a new symbol version for this.  It happened before in
the dark ages, repeatedly, but it's a bit disappointing to be in this
situation again.

In general the main problem I see is the poor source code
compatibility.  We really, really don't want variadic system call
wrappers, and we specifically do not want to introduce them
retroactively.  (Changing an implementation from non-variadic to
variadic is not an ABI-safe change on POWER and probably other
targets.)  So we'd require that from now on, the programmer has to
pass the zero argument explicitly.  Porting is simpler than the recent
futex_time64 breakage, but the downside is that immediately impacts
all targets.

Cc: linux-toolchains for ABI impact.
