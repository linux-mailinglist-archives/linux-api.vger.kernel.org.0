Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCB5B04D0
	for <lists+linux-api@lfdr.de>; Wed, 11 Sep 2019 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfIKUUx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Sep 2019 16:20:53 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:48022 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbfIKUUx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Sep 2019 16:20:53 -0400
X-Greylist: delayed 718 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 16:20:52 EDT
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1i88uY-0003DM-00; Wed, 11 Sep 2019 20:08:18 +0000
Date:   Wed, 11 Sep 2019 16:08:18 -0400
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH glibc 2.31 1/5] glibc: Perform rseq(2) registration at C
 startup and thread creation (v12)
Message-ID: <20190911200818.GB9017@brightrain.aerifal.cx>
References: <20190807142726.2579-1-mathieu.desnoyers@efficios.com>
 <20190807142726.2579-2-mathieu.desnoyers@efficios.com>
 <8736h2sn8y.fsf@oldenburg2.str.redhat.com>
 <7db64714-3dc5-b322-1edc-736b08ee7d63@redhat.com>
 <87ef0mr6qj.fsf@oldenburg2.str.redhat.com>
 <4a6f6326-ea82-e031-0fe0-7263ed97e797@redhat.com>
 <877e6er4ls.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877e6er4ls.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 11, 2019 at 09:54:23PM +0200, Florian Weimer wrote:
> * Carlos O'Donell:
> 
> > On 9/11/19 3:08 PM, Florian Weimer wrote:
> >> * Carlos O'Donell:
> >> 
> >>> It would be easier to merge the patch set if it were just an unconditional
> >>> registration like we do for set_robust_list().
> >> 
> >> Note that this depends on the in-tree system call numbers list, which I
> >> still need to finish according to Joseph's specifications.
> >
> > Which work is this? Do you have a URL reference to WIP?
> 
>   <https://sourceware.org/ml/libc-alpha/2019-05/msg00630.html>
>   <https://sourceware.org/ml/libc-alpha/2019-06/msg00015.html>
> 
> I think realistically this is needed for the Y2038 work as well if we
> want to support building glibc with older kernel headers.  “glibc 2..31
> will have Y2038 support and rseq support, but only if it runs on a
> current and it happens to have been built against sufficiently recent
> kernel headers” is a bit difficult to explain.  The current kernel part
> is easy enough to understand, but the impact of the kernel headers on
> the feature set has always been tough to explain.  Especially if you
> factor in vendor kernels with system call backports.

I'm in favor of in-tree syscall numbers list. If you don't want O(n)
per-arch work, though, you could just define the 'base number' for
each arch and use the fact that all the new syscalls share a common
numbering (i.e. base + constant depending only on syscall). I think
including the list with glibc is more robust though, and would
eliminate the need to check for definitions of older (pre-unification)
syscalls glibc wants to use.

Rich
