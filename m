Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1301D218E44
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2020 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgGHReu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jul 2020 13:34:50 -0400
Received: from mail.efficios.com ([167.114.26.124]:58876 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGHReu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jul 2020 13:34:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A1CE01B6F75;
        Wed,  8 Jul 2020 13:34:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gbURYgv__2qT; Wed,  8 Jul 2020 13:34:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2CCED1B6F74;
        Wed,  8 Jul 2020 13:34:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2CCED1B6F74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594229688;
        bh=F9wQTbY00HPkAjvr2iyVlx1rtmlWKZNein6GROXch/8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=sR6tQwZ2HkhnXkj6M6x8PhIBXyURMoHiqFif+TCiuWv6zUJ/L7iwo3gJtmSShlsz4
         Vnqcz281yb6k+jHmAwBIpgnQRBI2bebWAoDJjum1WTf9gPpx6VkW6eZTcm7mdBFH98
         8YbPI1ttqplXU/W0Telo7DirvSegGkl6gutJo4Iwozbn/lcIAN4Z0/tCFUdoYylDui
         OqfDHUwqYA+xT61KAv2OXYzlnH8nxZkfGQa6JRc4ZVWP/0SziNn9Wp/NTokIlY8++h
         EIi1MoJvrZwPk32f5pCvFIIoJXRKP3CTCPnEm2DjNKvLXS8B+Jcx/Q2FOQomPSKeTd
         ZNiy4KDbEmlHw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Sb0aekqiqKTE; Wed,  8 Jul 2020 13:34:48 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 19ECB1B7593;
        Wed,  8 Jul 2020 13:34:48 -0400 (EDT)
Date:   Wed, 8 Jul 2020 13:34:48 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Message-ID: <1565638541.5051.1594229688015.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200708162247.txdleelcalxkrfjy@wittgenstein>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com> <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com> <874kqjzhkb.fsf@mid.deneb.enyo.de> <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com> <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com> <87zh8bw158.fsf@mid.deneb.enyo.de> <1448906726.3717.1594222431276.JavaMail.zimbra@efficios.com> <20200708162247.txdleelcalxkrfjy@wittgenstein>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce
 RSEQ_FLAG_RELIABLE_CPU_ID
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
Thread-Index: 6lwd2SWsS2D69oaZ0X1kmR6fK6XGGg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 8, 2020, at 12:22 PM, Christian Brauner christian.brauner@ubuntu.com wrote:
[...]
> I've been following this a little bit. The kernel version itself doesn't
> really mean anything and the kernel version is imho not at all
> interesting to userspace applications. Especially for cross-distro
> programs. We can't go around and ask Red Hat, SUSE, Ubuntu, Archlinux,
> openSUSE and god knows who what other distro what their fixed kernel
> version is. That's not feasible at all and not how must programs do it.
> Sure, a lot of programs name a minimal kernel version they require but
> realistically we can't keep bumping it all the time. So the best
> strategy for userspace imho has been to introduce a re-versioned flag or
> enum that indicates the fixed behavior.
> 
> So I would suggest to just introduce
> RSEQ_FLAG_REGISTER_2                      = (1 << 2),
> that's how these things are usually done (Netlink etc.). So not
> introducing a fix bit or whatever but simply reversion your flag/enum.
> We already deal with this today.

Because rseq is effectively a per-thread resource shared across application
and libraries, it is not practical to merge the notion of version with the
registration. Typically __rseq_abi is registered by libc, and can be used
by the application and by many libraries. Early adopter libraries and
applications (e.g. librseq, tcmalloc) can also choose to handle registration
if it's not already done by libc.

For instance, it is acceptable for glibc to register rseq for all threads,
even in the presence of the cpu_id field inaccuracy, for use by the
sched_getcpu(3) implementation. However, users of rseq which need to
implement critical sections performing per-cpu data updates may want
to know whether the cpu_id field is reliable to ensure they do not crash
the process due to per-cpu data corruption.

This led me to consider exposing a feature-specific flag which can be
queried by specific users to know whether rseq has specific set of correct
behaviors implemented.

> (Also, as a side-note. I see that you're passing struct rseq *rseq with
> a length argument but you are not versioning by size. Is that
> intentional? That basically somewhat locks you to the current struct
> rseq layout and means users might run into problems when you extend
> struct rseq in the future as they can't pass the new struct down to
> older kernels. The way we deal with this is now - rseq might preceed
> this - is copy_struct_from_user() (for example in sched_{get,set}attr(),
> openat2(), bpf(), clone3(), etc.). Maybe you want to switch to that to
> keep rseq extensible? Users can detect the new rseq version by just
> passing a larger struct down to the kernel with the extra bytes set to 0
> and if rseq doesn't complain they know they're dealing with an rseq that
> knows larger struct sizes. Might be worth it if you have any reason to
> belive that struct rseq might need to grow.)

In the initial iterations of the rseq patch set, we initially had the rseq_len
argument hoping we would eventually be able to extend struct rseq. However,
it was finally decided against making it extensible, so the rseq ABI merged
into the Linux kernel with a fixed-size.

One of the key reasons for this is explained in
commit 83b0b15bcb0f ("rseq: Remove superfluous rseq_len from task_struct")

    The rseq system call, when invoked with flags of "0" or
    "RSEQ_FLAG_UNREGISTER" values, expects the rseq_len parameter to
    be equal to sizeof(struct rseq), which is fixed-size and fixed-layout,
    specified in uapi linux/rseq.h.
    
    Expecting a fixed size for rseq_len is a design choice that ensures
    multiple libraries and application defining __rseq_abi in the same
    process agree on its exact size.

The issue here is caused by the fact that the __rseq_abi variable is
shared across application/libraries for a given thread. So it's not
enough to agree between kernel and user-space on the extensibility
scheme, but we'd also have to find a way for all users within a process
to agree on the layout.

The "rseq_len" parameter could eventually become useful when combined
with additional flags, but currently its size is fixed.

There are indeed clear use-cases for extending struct rseq (or add a new
similar TLS structure), for instance exposing the current numa node id,
or to implement a fast signal-disabling scheme. But the fact that struct rseq
is shared across application/libraries makes it tricky to "just extend" struct
rseq.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
