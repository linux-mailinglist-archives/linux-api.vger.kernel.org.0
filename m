Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF00F218CE6
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2020 18:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgGHQW7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jul 2020 12:22:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59137 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbgGHQW6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jul 2020 12:22:58 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jtCqO-0003Mm-3u; Wed, 08 Jul 2020 16:22:48 +0000
Date:   Wed, 8 Jul 2020 18:22:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
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
Message-ID: <20200708162247.txdleelcalxkrfjy@wittgenstein>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
 <20200706204913.20347-4-mathieu.desnoyers@efficios.com>
 <87fta3zstr.fsf@mid.deneb.enyo.de>
 <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com>
 <874kqjzhkb.fsf@mid.deneb.enyo.de>
 <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com>
 <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com>
 <87zh8bw158.fsf@mid.deneb.enyo.de>
 <1448906726.3717.1594222431276.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1448906726.3717.1594222431276.JavaMail.zimbra@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 08, 2020 at 11:33:51AM -0400, Mathieu Desnoyers wrote:
> [ Context for Linus: I am dropping this RFC patch, but am curious to
>   hear your point of view on exposing to user-space which system call
>   behavior fixes are present in the kernel, either through feature
>   flags or system-call versioning. The intent is to allow user-space
>   to make better decisions on whether it should use a system call or
>   rely on fallback behavior. ]
> 
> ----- On Jul 7, 2020, at 3:55 PM, Florian Weimer fw@deneb.enyo.de wrote:
> 
> > * Carlos O'Donell:
> > 
> >> It's not a great fit IMO. Just let the kernel version be the arbiter of
> >> correctness.
> > 
> > For manual review, sure.  But checking it programmatically does not
> > yield good results due to backports.  Even those who use the stable
> > kernel series sometimes pick up critical fixes beforehand, so it's not
> > reliable possible for a program to say, “I do not want to run on this
> > kernel because it has a bad version”.  We had a recent episode of this
> > with the Go runtime, which tried to do exactly this.
> 
> FWIW, the kernel fix backport issue would also be a concern if we exposed
> a numeric "fix level version" with specific system calls: what should
> we do if a distribution chooses to include one fix in the sequence,
> but not others ? Identifying fixes are "feature flags" allow
> cherry-picking specific fixes in a backport, but versions would not
> allow that.
> 
> That being said, maybe it's not such a bad thing to _require_ the
> entire series of fixes to be picked in backports, which would be a
> fortunate side-effect of the per-syscall-fix-version approach.
> 
> But I'm under the impression that such a scheme ends up versioning
> a system call, which I suspect will be a no-go from Linus' perspective.

I've been following this a little bit. The kernel version itself doesn't
really mean anything and the kernel version is imho not at all
interesting to userspace applications. Especially for cross-distro
programs. We can't go around and ask Red Hat, SUSE, Ubuntu, Archlinux,
openSUSE and god knows who what other distro what their fixed kernel
version is. That's not feasible at all and not how must programs do it.
Sure, a lot of programs name a minimal kernel version they require but
realistically we can't keep bumping it all the time. So the best
strategy for userspace imho has been to introduce a re-versioned flag or
enum that indicates the fixed behavior.

So I would suggest to just introduce
RSEQ_FLAG_REGISTER_2                      = (1 << 2),
that's how these things are usually done (Netlink etc.). So not
introducing a fix bit or whatever but simply reversion your flag/enum.
We already deal with this today.

(Also, as a side-note. I see that you're passing struct rseq *rseq with
a length argument but you are not versioning by size. Is that
intentional? That basically somewhat locks you to the current struct
rseq layout and means users might run into problems when you extend
struct rseq in the future as they can't pass the new struct down to
older kernels. The way we deal with this is now - rseq might preceed
this - is copy_struct_from_user() (for example in sched_{get,set}attr(),
openat2(), bpf(), clone3(), etc.). Maybe you want to switch to that to
keep rseq extensible? Users can detect the new rseq version by just
passing a larger struct down to the kernel with the extra bytes set to 0
and if rseq doesn't complain they know they're dealing with an rseq that
knows larger struct sizes. Might be worth it if you have any reason to
belive that struct rseq might need to grow.)

Christian
