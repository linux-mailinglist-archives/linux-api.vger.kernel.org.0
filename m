Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8A2B6D9A
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgKQSlS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 13:41:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:47183 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgKQSlS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 17 Nov 2020 13:41:18 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0AHIas0V021424;
        Tue, 17 Nov 2020 12:36:54 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 0AHIaqNQ021421;
        Tue, 17 Nov 2020 12:36:52 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 17 Nov 2020 12:36:52 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: Is adding an argument to an existing syscall okay?
Message-ID: <20201117183652.GD2672@gate.crashing.org>
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com> <87k0uj6h03.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0uj6h03.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 17, 2020 at 06:16:28PM +0100, Florian Weimer wrote:
> * Andy Lutomirski:
> 
> > Linux 5.10 contains this patch:
> >
> > commit 2a36ab717e8fe678d98f81c14a0b124712719840
> > Author: Peter Oskolkov <posk@google.com>
> > Date:   Wed Sep 23 16:36:16 2020 -0700
> >
> >     rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
> >
> > This adds an argument to an existing syscall.  Before the patch,
> > membarrier had 2 parameters; now it has 3.  Is this really okay?  At
> > least the patch is careful and ignores the third parameter unless a
> > previously unused flag bit is set.
> 
> It's really iffy.  It's hard to break this in system call wrappers on
> x86-64, where we just load %eax and call into the kernel.  But on
> architectures which require argument shuffling, it will break.
> 
> If there were a system call wrapper in glibc (my patch was rejected
> due to lack of documentation fo the semantics, so we got lucky there),
> we'd have to add a new symbol version for this.  It happened before in
> the dark ages, repeatedly, but it's a bit disappointing to be in this
> situation again.
> 
> In general the main problem I see is the poor source code
> compatibility.  We really, really don't want variadic system call
> wrappers, and we specifically do not want to introduce them
> retroactively.  (Changing an implementation from non-variadic to
> variadic is not an ABI-safe change on POWER and probably other
> targets.)

But this isn't variadic in the sense of "..." -- on Power that always
passes the unspecified arguments in memory, while in this case it just
passes in either two or three registers.  I don't know any arg where
that would not work, given the Linux system call restrictions.

This is similar to the "open" system call.

> So we'd require that from now on, the programmer has to
> pass the zero argument explicitly.  Porting is simpler than the recent
> futex_time64 breakage, but the downside is that immediately impacts
> all targets.
> 
> Cc: linux-toolchains for ABI impact.

It certainly would simplify matters if this was simply not done ;-)


Segher
