Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84E8818BC3A
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgCSQRC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 19 Mar 2020 12:17:02 -0400
Received: from albireo.enyo.de ([37.24.231.21]:49206 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbgCSQRB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Mar 2020 12:17:01 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jExff-0006BE-FU; Thu, 19 Mar 2020 16:05:23 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jExdz-0000h9-3G; Thu, 19 Mar 2020 17:03:39 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>, carlos <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C startup and thread creation (v15)
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com>
        <20200319144110.3733-5-mathieu.desnoyers@efficios.com>
        <874kukpf9f.fsf@mid.deneb.enyo.de>
        <2147217200.3240.1584633395285.JavaMail.zimbra@efficios.com>
Date:   Thu, 19 Mar 2020 17:03:39 +0100
In-Reply-To: <2147217200.3240.1584633395285.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 19 Mar 2020 11:56:35 -0400
        (EDT)")
Message-ID: <87r1xo5o2s.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>> Can you use __has_include in <sys/rseq.h>, with a copy of the kernel
>> definitions if the kernel header is not available?
>
> Sure. Should I pull a verbatim copy of uapi linux/rseq.h into glibc ?
> If so, where should I put it ?

Probably into <sys/rseq.h>, perhaps with a construct like this
(untested):

#ifdef __has_include
# if __has_include ("linux/rseq.h")
#   define __GLIBC_HAVE_KERNEL_RSEQ
# endif
#else
# include <linux/version.h>
# if LINUX_VERSION_CODE >= KERNEL_VERSION (4, 18, 0)
#   define __GLIBC_HAVE_KERNEL_RSEQ
# endif
#endif

#ifdef __GLIBC_HAVE_KERNEL_RSEQ
# include <linux/rseq.h>
#else

… (fallback goes here)
#endif

We have an ongoing debate whether the fallback definition should use
__u64 or uint64_t.

You also need to add an assert that the compiler supports
__attribute__ ((aligned)) because ignoring it produces an
ABI-incompatible header.  The struct rseq/struct rseq_cs definitions
are broken, they should not try to change the alignment.

PS: I have Internet connection trouble.  Nobody should be worried if I
drop off the net for a while.  I understand this is quite a bad time
for that. 8-(
