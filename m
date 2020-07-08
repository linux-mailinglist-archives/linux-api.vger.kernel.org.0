Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A286218D0B
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2020 18:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgGHQgM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jul 2020 12:36:12 -0400
Received: from albireo.enyo.de ([37.24.231.21]:57546 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbgGHQgM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 8 Jul 2020 12:36:12 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jtD3D-0003zF-QC; Wed, 08 Jul 2020 16:36:03 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jtD3D-0002Vp-NX; Wed, 08 Jul 2020 18:36:03 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        carlos <carlos@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
        <20200706204913.20347-4-mathieu.desnoyers@efficios.com>
        <87fta3zstr.fsf@mid.deneb.enyo.de>
        <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com>
        <874kqjzhkb.fsf@mid.deneb.enyo.de>
        <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com>
        <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com>
        <87zh8bw158.fsf@mid.deneb.enyo.de>
        <1448906726.3717.1594222431276.JavaMail.zimbra@efficios.com>
        <20200708162247.txdleelcalxkrfjy@wittgenstein>
Date:   Wed, 08 Jul 2020 18:36:03 +0200
In-Reply-To: <20200708162247.txdleelcalxkrfjy@wittgenstein> (Christian
        Brauner's message of "Wed, 8 Jul 2020 18:22:47 +0200")
Message-ID: <87zh8aufpo.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Christian Brauner:

> I've been following this a little bit. The kernel version itself doesn't
> really mean anything and the kernel version is imho not at all
> interesting to userspace applications. Especially for cross-distro
> programs. We can't go around and ask Red Hat, SUSE, Ubuntu, Archlinux,
> openSUSE and god knows who what other distro what their fixed kernel
> version is.

And Red Hat Enterprise Linux only has a dozen or two kernel branches
under active maintenance, each with their own succession of version
numbers.  It's just not feasible.  Even figuring out the branch based
on the kernel version can be tricky!

> (Also, as a side-note. I see that you're passing struct rseq *rseq with
> a length argument but you are not versioning by size. Is that
> intentional? That basically somewhat locks you to the current struct
> rseq layout and means users might run into problems when you extend
> struct rseq in the future as they can't pass the new struct down to
> older kernels. The way we deal with this is now - rseq might preceed
> this - is copy_struct_from_user()

The kernel retains the pointer after the system call returns.
Basically, ownership of the memory area is transferred to the kernel.
It's like set_robust_list in this regard.
