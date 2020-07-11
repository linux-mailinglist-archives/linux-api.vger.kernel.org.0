Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBAD21C4E8
	for <lists+linux-api@lfdr.de>; Sat, 11 Jul 2020 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgGKPzP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 11 Jul 2020 11:55:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53967 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGKPzO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 11 Jul 2020 11:55:14 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1juHq8-0007l1-HU; Sat, 11 Jul 2020 15:55:00 +0000
Date:   Sat, 11 Jul 2020 17:54:59 +0200
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
Message-ID: <20200711155459.4mswacrvosw377tk@wittgenstein>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
 <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com>
 <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com>
 <87zh8bw158.fsf@mid.deneb.enyo.de>
 <1448906726.3717.1594222431276.JavaMail.zimbra@efficios.com>
 <20200708162247.txdleelcalxkrfjy@wittgenstein>
 <1565638541.5051.1594229688015.JavaMail.zimbra@efficios.com>
 <20200709124941.u4quvvaiabx36ee3@wittgenstein>
 <1197598149.7002.1594307757307.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1197598149.7002.1594307757307.JavaMail.zimbra@efficios.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 09, 2020 at 11:15:57AM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 9, 2020, at 8:49 AM, Christian Brauner christian.brauner@ubuntu.com wrote:
> 
> > On Wed, Jul 08, 2020 at 01:34:48PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Jul 8, 2020, at 12:22 PM, Christian Brauner
> >> christian.brauner@ubuntu.com wrote:
> >> [...]
> >> > I've been following this a little bit. The kernel version itself doesn't
> >> > really mean anything and the kernel version is imho not at all
> >> > interesting to userspace applications. Especially for cross-distro
> >> > programs. We can't go around and ask Red Hat, SUSE, Ubuntu, Archlinux,
> >> > openSUSE and god knows who what other distro what their fixed kernel
> >> > version is. That's not feasible at all and not how must programs do it.
> >> > Sure, a lot of programs name a minimal kernel version they require but
> >> > realistically we can't keep bumping it all the time. So the best
> >> > strategy for userspace imho has been to introduce a re-versioned flag or
> >> > enum that indicates the fixed behavior.
> >> > 
> >> > So I would suggest to just introduce
> >> > RSEQ_FLAG_REGISTER_2                      = (1 << 2),
> >> > that's how these things are usually done (Netlink etc.). So not
> >> > introducing a fix bit or whatever but simply reversion your flag/enum.
> >> > We already deal with this today.
> >> 
> >> Because rseq is effectively a per-thread resource shared across application
> >> and libraries, it is not practical to merge the notion of version with the
> >> registration. Typically __rseq_abi is registered by libc, and can be used
> >> by the application and by many libraries. Early adopter libraries and
> >> applications (e.g. librseq, tcmalloc) can also choose to handle registration
> >> if it's not already done by libc.
> > 
> > I'm probably missing the elephant in the room but I was briefly looking
> > at github.com/compudj/librseq and it seems to me that the registration
> > you're talking about is:
> > 
> > extern __thread struct rseq __rseq_abi;
> > extern int __rseq_handled;
> 
> Note that __rseq_handled has now vanished, adapting to glibc's ABI. I just
> updated librseq's header accordingly.
> 
> > 
> > and it's done in int rseq_register_current_thread(void) afaict and
> > currently registration is done with flags set to 0.
> 
> Correct, however that registration will become a no-op when linked against a
> glibc 2.32+, because the glibc will already have handled the registration
> at thread creation.

The registration is a thread-group property I'll assume, right, i.e. all
threads will have rseq TLS or no thread will have it? Some things I seem
to be able to assume (correct me if I'm wrong):
- rseq registration is expected to be done at thread creation time
- rseq registration _should_ only be done once, i.e. if a caller detects
  that rseq is already registered for a thread, then they could
  technically re-register rseq - risking a feature mismatch if doing so
  - but they shouldn't re-register but simply assume that someone else
  is in control of rseq. If they violate that assumption than you're
  hosed anyway.
So it seems as long as callers leave rseq registration alone whenever
they detect that it is already registered then one can assume that rseq
is under consistent control of a single library/program. If that's the
case it should safe to assume that the library will use the same rseq
registration for all threads bounded by the available kernel features or
by the set of features it is aware of.

> 
> > 
> > What is the problem with either adding a - I don't know -
> > RSEG_FLAG_REGISTER/RSEQ_RELIABLE_CPU_FIELD flag that is also recorded in
> > __rseq_abi.flags. If the kernel doesn't support the flag it will fail
> > registration with EINVAL. So the registering program can detect it. If a
> > caller needs to know whether another thread uses the new flag it can
> > query __rseq_abi.flags. Some form of coordination must be possible in
> > userspace otherwise you'll have trouble with any new feature you add. I
> > general, I don't see how this is different from adding a new feature to
> > rseq. It should be the same principle.
> 
> The problem with "extending" struct rseq is that it becomes complex
> because it is shared between libraries and application. Let's suppose
> the library doing the rseq registration does the scheme you describe:
> queries the kernel for features, and stores them in the __rseq_abi.flags.
> We end up with the following upgrade transition headhaches for an
> application using __rseq_abi:
> 
> Kernel     |   glibc     |   librseq    | __rseq_abi registration owner
> ----------------------------------------------------------------------
> 4.18       |   2.31      |     no       | application (reliable cpu_id = false)
> 4.18       |   2.31      |     yes      | librseq (reliable cpu_id = false)
> 5.8        |   2.31      |     yes      | librseq (reliable cpu_id = true)
> 5.8        |   2.32      |     yes      | glibc (reliable cpu_id = false)        
> 5.8        |   2.33+     |     yes      | glibc (reliable cpu_id = true)
> 
> This kind of transition regressing feature-wise when upgrading a glibc
> can be confusing for users.

Sure, but that's seems like a problem that is not specific to rseq.
That's a problem that any interface has which introduces new features or
fixes bugs.

> 
> One possibility would be to have the kernel store the "reliable cpu_id"
> flag directly into a new __rseq_abi.kernel_flags (because __rseq_abi.flags
> is documented as only read by the kernel). This would remove the registration

Ah, there we go. That's a missing piece of information I didn't have.
Thank you.

> owner from the upgrade scenarios. But what would we gain by exposing this
> flag within struct rseq ? The only real reason for doing so over using an

I proposed that specific scheme because I was under the impression that
you are in need of a mechanism for a caller (at thread creation I
assume) to check what feature set is supported by rseq _without_
issung a system call. If you were to record the requested flags in
struct rseq or in some other way, then another library which tries to
register rseq for a thread but detects it has already been registered
can look at e.g. whether the reliable cpu feature is around and then
adjust it's behavior accordingly.
Another reason why this seems worthwhile is because of how rseq works in
general. Since it registers a piece of userspace memory which userspace
can trivially access enforcing that userspace issue a syscall to get at
the feature list seems odd when you can just record it in the struct.
But that's a matter of style, I guess.

Also, I'm thinking about the case of adding one or two new features that
introduce mutually exclusive behavior for rseq, i.e. if you register
rseq with FEAT1 and someone else registers it with FEAT2 and FEAT1 and
FEAT2 would lead to incompatible behavior for an aspect or all of rseq.
Even if you had a way to query the kernel for FEAT1 and FEAT2 in the
rseq syscall it still be a problem since a caller wouldn't know at rseq
registration time whether the library registered rseq with FEAT1 or
FEAT2. If you record the behavior somewhere - kernel_flags or whatever -
then the caller could check at registration time "ah, rseq is registered
with this behavior" I need to adjust my behavior.

> explicit system call is typically speed, and querying the kernel for a
> feature does not need to be done often, so this is why I originally favored
> exposing this information through a new system call flag without changing
> the content of struct rseq_cs.

Sure, there are multiple ways of doing this. What you're proposing is
one. Though that is not as simple as it seems, I fear. :)
If you add a new flag to the system call that effectively only exists to
query the supported features then you need to decide whether checking
for a feature means the system call just returns and all it does is to
give you back the features it supports, i.e. it doesn't do any real work
or if it actually does real work.
That becomes a little more tricky actually. If the system call does the
feature checking and registration in one shot you need to decide whether
it should fail registration if a feature is not supported or whether it
should just move one. If the latter then you likely want a way for the
kernel to report back on the features it supports. That's not a big deal
if it's only a single feature but it becomes more tricky if you
introduce multiple features because then you don't know what feature
the kernel doesn't support and you likely want to know what feature made
the system call fail, i.e. what feature is missing. :)
Thinking about this a little bit I would think what makes the most sense
for such a scheme is the following:
- introduce a flag CHECK_FEATURES flag wich by default makes the system
  call a noop effectively and just reports back (somewhere in struct
  rseq) the features it has and e.g. masking out any features it doesn't
  know about.
- introduce another flag (again, dummy names here)
  IGNORE_UNKNOWN_FEATURES which makes the system call succeed making use
  of all the features requested that it supports, masking out any
  features it doesn't know about.
  This way a library/caller can decide what behavior it wants to have.
That's advanced behavior though and maybe that "just introduce a flag
and make it fail if not supported by the kernel" is enough for your
use-case now and the other stuff can be added when more features happen.

> 
> One additional thing to keep in mind: the application can itself choose
> to define the __rseq_abi TLS, which AFAIU (please let me know if I am
> wrong) would take precedence over glibc's copy. So extending the

You mean either that an application could simply choose to ignore that e.g.
glibc has already registered rseq and e.g. unregister it and register
it's own or that it registers it's own rseq before glibc comes into the
play?
I mean, if I interpreted what you're trying to say correctly, I think
one needs to work under the assumption that if someone else has already
registered rseq than it becomes the single source of truth. I think that
basically needs to be the contract. Same way you expect a user of
pthreads to not suddenly go and call clone3() with CLONE_THREAD |
CLONE_VM | [...] and assume that this won't mess with glibc's internal
state.

> size of struct rseq seems rather tricky because the application may
> provide a smaller __rseq_abi, even if both the kernel and glibc agree
> on a larger size.
> 
> > 
> > I also don't understand the "not practical to merge the notion of
> > version with the registration". I'm not sure what that means to be
> > honest. :)
> 
> The notion of "version" here would be to replace the "RELIABLE_CPU_FIELD"
> flag I proposed with a steadily-increasing "fix" version instead.

Sure.

> 
> For both approaches, we could either pass them as parameters with rseq
> registration, and make rseq registration success conditional on the
> kernel implementing those feature/fix-version, or validate the flag/version
> separately from registration.
> 
> If this is done on registration, it means glibc will eventually have to
> handle this. This prevents user libraries with specific needs to query
> whether their features are available. Doing the feature/version validation
> separately from registration allows each user library to make its own
> queries and take advantage of new kernel features before glibc is
> upgraded to be made aware of them.

Why isn't there a "dual scheme"? I.e. you record the features somewhere
in struct rseq or some other place so userspace can query an already
registered thread for the features it was registered with and have a way
to query the kernel for the supported features through the system call
(See what I suggested above with the feature checking flags.).

> 
> > But just thinking about adding a new feature to rseq. Then you're in the
> > same spot, I think. When you register a bumped rseq - because you added
> > a new flag or whatever - you register a new version one way or the other
> > since a new feature - imho - is always a version bump. In fact, you
> > could think of your "reliable cpu" as a new feature not a bug. ;)
> 
> Indeed.
> 
> > Also, you seem to directly version struct rseq_cs already through the
> > "version" member. So even if you are against the new flag I wouldn't
> > know what would stop you from directly versioning struct rseq itself.
> 
> struct rseq needs to be shared between application and libraries, with
> issues about what to do if size changes when we have an application
> defining a small struct rseq (taking precedence over glibc's), and glibc
> agreeing with the kernel on a larger structure. So there is little hope
> in changing that layout.

I really think this is not an rseq specific problem. This seems to be a
generic problem any interface has when it e.g. makes use of an extended
struct and e.g. decides to make its own syscalls without going through
the glibc wrappers (If there are any...). That's the reality right now
and will likely always be that way short of us blocking non-libc
syscalls similar to some bsds at which point we need a 1:1 kernel + libc
development. :) That's not going to happen. The problem ranges from
struct statx to struct clone_args and struct open_how and so on.

But one question. Musn't the assumption be that all threads in a
thread-group if they have registered rseq then the same
application/library has done that registration? And if that's the case
then the application/library doing the registration is what defines the
layout for that thread-group and becomes the one source of truth.
Basically, if an application uses it's own rseq then glibc must be out
of the picture. If that's not part of the contract then it feels to me
that rseq cannot be extended (for now).

> 
> The case of struct rseq_cs is simpler: it is only used as interface between
> a specific library/application user and the kernel, which allows us to
> version the structure and create new layouts as needed.
> 
> > 
> > And it's not that we don't version syscalls. We're doing it in multiple
> > ways to be honest, syscalls with a flag argument that reject unknown
> > flags are bumped in their version every time you add a new flag that
> > they accept. We don't spell this out but this is effectively what it is.
> > Think of it as a minor version bump. Extensible syscalls are versioned
> > by size and when their struct grows are bumped in their (minor) version.
> > In fact extensible syscalls with flags argument embedded in the struct
> > can be version bumped in two ways: growing a new flag argument or
> > growing a new struct member.
> 
> The issue with struct rseq extensibility is not so much ABI between kernel
> and user-space, but rather ABI between userspace libraries/application users.
> 
> > 
> >> 
> >> For instance, it is acceptable for glibc to register rseq for all threads,
> >> even in the presence of the cpu_id field inaccuracy, for use by the
> >> sched_getcpu(3) implementation. However, users of rseq which need to
> >> implement critical sections performing per-cpu data updates may want
> >> to know whether the cpu_id field is reliable to ensure they do not crash
> >> the process due to per-cpu data corruption.
> >> 
> >> This led me to consider exposing a feature-specific flag which can be
> >> queried by specific users to know whether rseq has specific set of correct
> >> behaviors implemented.
> >> 
> >> > (Also, as a side-note. I see that you're passing struct rseq *rseq with
> >> > a length argument but you are not versioning by size. Is that
> >> > intentional? That basically somewhat locks you to the current struct
> >> > rseq layout and means users might run into problems when you extend
> >> > struct rseq in the future as they can't pass the new struct down to
> >> > older kernels. The way we deal with this is now - rseq might preceed
> >> > this - is copy_struct_from_user() (for example in sched_{get,set}attr(),
> >> > openat2(), bpf(), clone3(), etc.). Maybe you want to switch to that to
> >> > keep rseq extensible? Users can detect the new rseq version by just
> >> > passing a larger struct down to the kernel with the extra bytes set to 0
> >> > and if rseq doesn't complain they know they're dealing with an rseq that
> >> > knows larger struct sizes. Might be worth it if you have any reason to
> >> > belive that struct rseq might need to grow.)
> >> 
> >> In the initial iterations of the rseq patch set, we initially had the rseq_len
> >> argument hoping we would eventually be able to extend struct rseq. However,
> >> it was finally decided against making it extensible, so the rseq ABI merged
> >> into the Linux kernel with a fixed-size.
> >> 
> >> One of the key reasons for this is explained in
> >> commit 83b0b15bcb0f ("rseq: Remove superfluous rseq_len from task_struct")
> >> 
> >>     The rseq system call, when invoked with flags of "0" or
> >>     "RSEQ_FLAG_UNREGISTER" values, expects the rseq_len parameter to
> >>     be equal to sizeof(struct rseq), which is fixed-size and fixed-layout,
> >>     specified in uapi linux/rseq.h.
> >>     
> >>     Expecting a fixed size for rseq_len is a design choice that ensures
> >>     multiple libraries and application defining __rseq_abi in the same
> >>     process agree on its exact size.
> >> 
> >> The issue here is caused by the fact that the __rseq_abi variable is
> >> shared across application/libraries for a given thread. So it's not
> >> enough to agree between kernel and user-space on the extensibility
> >> scheme, but we'd also have to find a way for all users within a process
> >> to agree on the layout.
> > 
> > But you're in the same boat if you add any new feature, no? In your
> > model, wouldn't you need all users to agree on the feature set as well?
> > Not just the struct rseq size. If that's the case then rseq would be
> > unextendable (for now).
> 
> As a consequence of this, my current approach to add a "node_id" field to rseq
> (in a prototype patch) is far from ideal: it defines another TLS symbol, e.g.
> __rseq_abi2, with an extended layout, and registers it with new rseq flags.
> 
> I would really like to be able to extend struct rseq, but because of ABI
> compatibility required between user-space libraries/applications, it seems
> rather tricky to do so.
> 
> > But specifically about the size-versioning part. Well, one way to solve
> > this - imho - would be to add a output size parameter to struct rseq and
> > introduce a little more vetting than we have right now.
> > So the kernel is what ultimately registers struct rseq iiuc. If there
> > were a size output parameter the kernel could set the size of the struct
> > it knows about before registering it.
> > So a caller passing down a larger struct with e.g. a new field set to a
> > non-zero value would get an error from the kernel and the size of the
> > supported struct. The caller can then adjust and simply zero out the
> > unsupported field and retry. Other callers in userspace can query the
> > size and find out what size of struct is registered. If it's larger than
> > what they know about they can infer they are on a newer kernel with new
> > features but they can simply ignore the unknown fields. If it's smaller
> > than they know what fields to ignore.
> 
> How would that work in the case of an application defining its own copy of
> struct rseq __rseq_abi TLS with sizeof(struct rseq) == 32, and then upgrading
> its glibc to a new glibc which implements a larger structure, which agrees with
> the kernel on that larger layout ?

Wouldn't the non-updated application just access fields and methods of
the smaller struct? The way struct extensions work is that we only
extend them after the last member and always correctly 64 bit aligned.
And as long as you only extend the struct at the end wouldn't that be
ok? An application with a non-updated/smaller struct rseq would just
access fields that the larger struct supports, no?

Thanks!
Christian
