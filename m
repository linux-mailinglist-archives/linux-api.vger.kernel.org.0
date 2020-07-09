Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB421A03D
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 14:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGIMtt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 08:49:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34999 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGIMtt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 08:49:49 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jtVzi-0007Z6-BB; Thu, 09 Jul 2020 12:49:42 +0000
Date:   Thu, 9 Jul 2020 14:49:41 +0200
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
Message-ID: <20200709124941.u4quvvaiabx36ee3@wittgenstein>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
 <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com>
 <874kqjzhkb.fsf@mid.deneb.enyo.de>
 <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com>
 <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com>
 <87zh8bw158.fsf@mid.deneb.enyo.de>
 <1448906726.3717.1594222431276.JavaMail.zimbra@efficios.com>
 <20200708162247.txdleelcalxkrfjy@wittgenstein>
 <1565638541.5051.1594229688015.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1565638541.5051.1594229688015.JavaMail.zimbra@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 08, 2020 at 01:34:48PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 8, 2020, at 12:22 PM, Christian Brauner christian.brauner@ubuntu.com wrote:
> [...]
> > I've been following this a little bit. The kernel version itself doesn't
> > really mean anything and the kernel version is imho not at all
> > interesting to userspace applications. Especially for cross-distro
> > programs. We can't go around and ask Red Hat, SUSE, Ubuntu, Archlinux,
> > openSUSE and god knows who what other distro what their fixed kernel
> > version is. That's not feasible at all and not how must programs do it.
> > Sure, a lot of programs name a minimal kernel version they require but
> > realistically we can't keep bumping it all the time. So the best
> > strategy for userspace imho has been to introduce a re-versioned flag or
> > enum that indicates the fixed behavior.
> > 
> > So I would suggest to just introduce
> > RSEQ_FLAG_REGISTER_2                      = (1 << 2),
> > that's how these things are usually done (Netlink etc.). So not
> > introducing a fix bit or whatever but simply reversion your flag/enum.
> > We already deal with this today.
> 
> Because rseq is effectively a per-thread resource shared across application
> and libraries, it is not practical to merge the notion of version with the
> registration. Typically __rseq_abi is registered by libc, and can be used
> by the application and by many libraries. Early adopter libraries and
> applications (e.g. librseq, tcmalloc) can also choose to handle registration
> if it's not already done by libc.

I'm probably missing the elephant in the room but I was briefly looking
at github.com/compudj/librseq and it seems to me that the registration
you're talking about is:

extern __thread struct rseq __rseq_abi;
extern int __rseq_handled;

and it's done in int rseq_register_current_thread(void) afaict and
currently registration is done with flags set to 0.

What is the problem with either adding a - I don't know -
RSEG_FLAG_REGISTER/RSEQ_RELIABLE_CPU_FIELD flag that is also recorded in
__rseq_abi.flags. If the kernel doesn't support the flag it will fail
registration with EINVAL. So the registering program can detect it. If a
caller needs to know whether another thread uses the new flag it can
query __rseq_abi.flags. Some form of coordination must be possible in
userspace otherwise you'll have trouble with any new feature you add. I
general, I don't see how this is different from adding a new feature to
rseq. It should be the same principle.

I also don't understand the "not practical to merge the notion of
version with the registration". I'm not sure what that means to be
honest. :)
But just thinking about adding a new feature to rseq. Then you're in the
same spot, I think. When you register a bumped rseq - because you added
a new flag or whatever - you register a new version one way or the other
since a new feature - imho - is always a version bump. In fact, you
could think of your "reliable cpu" as a new feature not a bug. ;)

Also, you seem to directly version struct rseq_cs already through the
"version" member. So even if you are against the new flag I wouldn't
know what would stop you from directly versioning struct rseq itself.

And it's not that we don't version syscalls. We're doing it in multiple
ways to be honest, syscalls with a flag argument that reject unknown
flags are bumped in their version every time you add a new flag that
they accept. We don't spell this out but this is effectively what it is.
Think of it as a minor version bump. Extensible syscalls are versioned
by size and when their struct grows are bumped in their (minor) version.
In fact extensible syscalls with flags argument embedded in the struct
can be version bumped in two ways: growing a new flag argument or
growing a new struct member.

> 
> For instance, it is acceptable for glibc to register rseq for all threads,
> even in the presence of the cpu_id field inaccuracy, for use by the
> sched_getcpu(3) implementation. However, users of rseq which need to
> implement critical sections performing per-cpu data updates may want
> to know whether the cpu_id field is reliable to ensure they do not crash
> the process due to per-cpu data corruption.
> 
> This led me to consider exposing a feature-specific flag which can be
> queried by specific users to know whether rseq has specific set of correct
> behaviors implemented.
> 
> > (Also, as a side-note. I see that you're passing struct rseq *rseq with
> > a length argument but you are not versioning by size. Is that
> > intentional? That basically somewhat locks you to the current struct
> > rseq layout and means users might run into problems when you extend
> > struct rseq in the future as they can't pass the new struct down to
> > older kernels. The way we deal with this is now - rseq might preceed
> > this - is copy_struct_from_user() (for example in sched_{get,set}attr(),
> > openat2(), bpf(), clone3(), etc.). Maybe you want to switch to that to
> > keep rseq extensible? Users can detect the new rseq version by just
> > passing a larger struct down to the kernel with the extra bytes set to 0
> > and if rseq doesn't complain they know they're dealing with an rseq that
> > knows larger struct sizes. Might be worth it if you have any reason to
> > belive that struct rseq might need to grow.)
> 
> In the initial iterations of the rseq patch set, we initially had the rseq_len
> argument hoping we would eventually be able to extend struct rseq. However,
> it was finally decided against making it extensible, so the rseq ABI merged
> into the Linux kernel with a fixed-size.
> 
> One of the key reasons for this is explained in
> commit 83b0b15bcb0f ("rseq: Remove superfluous rseq_len from task_struct")
> 
>     The rseq system call, when invoked with flags of "0" or
>     "RSEQ_FLAG_UNREGISTER" values, expects the rseq_len parameter to
>     be equal to sizeof(struct rseq), which is fixed-size and fixed-layout,
>     specified in uapi linux/rseq.h.
>     
>     Expecting a fixed size for rseq_len is a design choice that ensures
>     multiple libraries and application defining __rseq_abi in the same
>     process agree on its exact size.
> 
> The issue here is caused by the fact that the __rseq_abi variable is
> shared across application/libraries for a given thread. So it's not
> enough to agree between kernel and user-space on the extensibility
> scheme, but we'd also have to find a way for all users within a process
> to agree on the layout.

But you're in the same boat if you add any new feature, no? In your
model, wouldn't you need all users to agree on the feature set as well?
Not just the struct rseq size. If that's the case then rseq would be
unextendable (for now).

But specifically about the size-versioning part. Well, one way to solve
this - imho - would be to add a output size parameter to struct rseq and
introduce a little more vetting than we have right now.
So the kernel is what ultimately registers struct rseq iiuc. If there
were a size output parameter the kernel could set the size of the struct
it knows about before registering it.
So a caller passing down a larger struct with e.g. a new field set to a
non-zero value would get an error from the kernel and the size of the
supported struct. The caller can then adjust and simply zero out the
unsupported field and retry. Other callers in userspace can query the
size and find out what size of struct is registered. If it's larger than
what they know about they can infer they are on a newer kernel with new
features but they can simply ignore the unknown fields. If it's smaller
than they know what fields to ignore.

I hope I'm not derailing this discussion. I'm just trying to show that
there's some hope.
In short, imho, I think adding a flag indicating the new "reliable cpu"
feature is probably the best way to go. Think of it not as the kernel
indicating the absence of a bug but as the presence of a feature. :)

Thanks!
Christian
