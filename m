Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0299938CF5F
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 22:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhEUUxa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 16:53:30 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60228 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhEUUx3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 16:53:29 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C67DC72C8B8;
        Fri, 21 May 2021 23:52:04 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B4B687CC8A6; Fri, 21 May 2021 23:52:04 +0300 (MSK)
Date:   Fri, 21 May 2021 23:52:04 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Matheus Castanho <msc@linux.ibm.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Matheus Castanho via Libc-alpha <libc-alpha@sourceware.org>,
        Nicholas Piggin <npiggin@gmail.com>, musl@lists.openwall.com,
        linux-api@vger.kernel.org, libc-dev@lists.llvm.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Linux powerpc new system call instruction and ABI
Message-ID: <20210521205204.GA24309@altlinux.org>
References: <20200611081203.995112-1-npiggin@gmail.com>
 <20210518231331.GA8464@altlinux.org>
 <1621385544.nttlk5qugb.astroid@bobo.none>
 <1621400263.gf0mbqhkrf.astroid@bobo.none>
 <87a6oo4312.fsf@linux.ibm.com>
 <87k0nr6ezw.fsf@oldenburg.str.redhat.com>
 <87eedz3li3.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eedz3li3.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 05:00:36PM -0300, Matheus Castanho wrote:
> Florian Weimer <fweimer@redhat.com> writes:
> > * Matheus Castanho via Libc-alpha:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >> Subject: [PATCH 1/1] powerpc: Fix handling of scv return error codes
> >>
> >> When using scv on templated ASM syscalls, current code interprets any
> >> negative return value as error, but the only valid error codes are in
> >> the range -4095..-1 according to the ABI.
> >>
> >> Reviewed-by: Matheus Castanho <msc@linux.ibm.com>
> >
> > Please reference bug 27892 in the commit message.  I'd also appreciate a
> > backport to the 2.33 release branch (where you need to add NEWS manually
> > to add the bug reference).
> 
> No problem. [BZ #27892] appended to the commit title. I'll make sure to
> backport to 2.33 as well.

Could you also mention in the commit message that the change fixes
'signal.gen.test' strace test where it was observed initially?


-- 
ldv
