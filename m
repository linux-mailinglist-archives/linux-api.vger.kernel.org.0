Return-Path: <linux-api+bounces-6656-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BG1ZLJ9fPGq4nQgAu9opvQ
	(envelope-from <linux-api+bounces-6656-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 00:52:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF46C1D39
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 00:52:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b="q h0Jbb/";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=cOXQN8PK;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6656-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6656-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 533A33017BB2
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 22:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34903B5311;
	Wed, 24 Jun 2026 22:52:12 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C963B4EB7;
	Wed, 24 Jun 2026 22:52:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782341532; cv=none; b=hVVvDArcQ3I5Xj5Z9M0ohm59eKDR+ctNn2/CP6zvsDIfSGfN7ATX54PJFgtSwYmlruC4QaGwMWdncHqh7NQyLd/2xYV65bSRWnvErmuY+mEnjWs7V9H9g6yFFmO+eCracQVw4dERThj88ZxJMITOSvec7zq4t6xWuH6oW6T7aPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782341532; c=relaxed/simple;
	bh=SDc2NsUP+jKL+0/+xfeV9B0HFWDDARRFz8HkqwCFVyQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=V62JHf6YEmjNUZFQWMjWiV6/uJW4R0YQxCeM8aUxdwOu+CP+mSYMOBV9r7iSHkfLe7xKDQ0PQJP8tOywhMEcy2P4yP61nYf9ivePWgWkn5BSn2Q8jrvlXIJ4qYgySh/FXJ/BauoFv4ab5lwqpue032xLCn3gnkrQFvwy/ISllPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=qh0Jbb/d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOXQN8PK; arc=none smtp.client-ip=103.168.172.142
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id CEA3F13804BE;
	Wed, 24 Jun 2026 18:52:09 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 18:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1782341529; x=
	1782348729; bh=kNEKoSPVRG9xuRzyQZQXCoFYuW5nNtnedBCyvClkfsY=; b=q
	h0Jbb/dI7ZEEbs2Lm6I+9chkUtRohsZMAx6FtonKUTd0I4ny44vYuL8YYsdfF/0t
	C7+Aod66y5gXKj+d3phqebilzMay/GmXqna64XVM2v/Da7i5K7zX8yzVnPcbmTxz
	wHPkmS7+RVYpQ6BszP6ENYUu5EbnpYjrgVo8HJSPHZOAQ15YSJVEJinFb6yYHIM/
	43Vmsl7jw12muE/yEZpdJPKKFWeBs/wzGWdqz8zhFO9w5f3KxCFghH0h1+0nDWgk
	2p+gRTidVhZs6zJaBKqoxPiXZITBFsIzoCVVqxogKLifWbr0NySCaevGLRSWLYWP
	C0Kyvqk4wOzNf1z3XoNbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782341529; x=1782348729; bh=kNEKoSPVRG9xuRzyQZQXCoFYuW5n
	NtnedBCyvClkfsY=; b=cOXQN8PKDvH9vCsuqVAbF3cH+S000CrarUU4hH+EWF4k
	Oxn/INBHYA2tdMCXNhP433KxIDuN4KGmDXLdkZtZER+8E++RdF/Slktuinkf2PEY
	YP7+5w2UQBUdVfwXt8C5JWUnTg17Yjy3paSmRUF7yIp0l7m8LzRwxfOuClZrkJkN
	dOmzjuNYxgL5SV6IjbIEjzyNZLaikc7Udsb6cRpbmErABNJo8F6iQr/rpuOkVNVV
	KnYFL27PKKEjHbtvoG5aIq3XsnE5SoHHCW9F0TjP/JUu73SORnw4PRrleZNWYQy9
	Il/G9kmphYTsGI8cOb/rydeT+ddOSfHyN04ofEeDIg==
X-ME-Sender: <xms:l188aozTUEmULvIUb0i5JDAvKzfVED6Q7rDbf_Wqn9HAEaYHrGbg0w>
    <xme:l188anGuGB5vc9KXZH3H8m3gKPYDuhYfZh7dYY-1t4HvpeQgBg6AwCnJl8Me7tBR-
    frPuoQCG7-KbN-xBwp411wIRt8GERrvT7t1JbaYHkiaVPTAXIlKLnQ>
X-ME-Proxy-Cause: dmFkZTE3myjJ5yD9Pt6Ld2GGDGWzH6y4SjanE++u1dAE84asQUJInKI+iM90ruiX9KPZrt
    Y/GHke9j9Q9v8EGH6yY57M0DotYOEf1XzH6EtAVw9bkTHoJje8Hdc4xQuOkLbuHw67vWyI
    q0Y8WdXy4hpaqYkipyfTtrhG7Hd1VBByA1ZWz9mT30Aj9/rFnWRIW5yAU3ffaj5p+82WPT
    usoaoJ9z0NI/1q4o7G27CGPtw/yjsIpI8UCttrqOb3xqWTX7MGeb5hK4BPs+Ew1SoLqMoZ
    LbIdLoGe5lxEl62pS0z4pWv63gwZ9Zeb5mlhBQpw+JTTByUdVtyqzZgfC26IisBiO7W5QI
    ZLSJITLlGsBD7k+WA+/MEG4x8r92g8KG1NI6uy8pD2EcttM9r4+moWr7Ex6C+GvxdMUbHF
    5aFBGQtBrU1G1FRvj0gMK5b2vff4jfbRPKJcEX1T8xK7+OKq4goCqdTRN/Hee39GPn0Cub
    hsrNog/AIh5LXNZXcpToAZ0v2Hik1SUSqIYxhq1yl/Z51pMmic0WoxP0EPX4/n67w5R6ij
    9QM3k0XbcrM16qnBzHYQfBqMg5nr31HQnRmRp0V3BTSUVYvmbBEyaXy5uoc+xrPWQUtTuk
    bOWzkZGH1/VGcDJFIGXG52pa6FE8CiZGpvYoyfkTAFOZjbJXPN1uSRit318Q
X-ME-Proxy: <xmx:l188ajNyrKa7W1l-0XGF3mwa3u2DOW-5FMdq65BL8oT1fZ3hh4ixmA>
    <xmx:l188alnqwV6B9EzNrYMx_utfEp5ewWuPvWzXqfn5EhjBLgaMokaOow>
    <xmx:l188aifF8d4Oxv99DH9BbFu4isrovBByW30tarMSj57EEGPumNzFKQ>
    <xmx:l188avvgxxwTTeMDOWL3wZCWNueLuE9xmWxV_mAgwdLCGkiz-uye-g>
    <xmx:mV88aiiZFHSiBm4FlvALT_gyHdGJ98sJP_aPz8nbH0eHlsiMSao6yRNE>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 775672CC0086; Wed, 24 Jun 2026 18:52:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG8qDlxFSDr7
Date: Wed, 24 Jun 2026 18:51:47 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Li Chen" <me@linux.beauty>, "Cong Wang" <cwang@multikernel.io>,
 "Christian Brauner" <brauner@kernel.org>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Kees Cook" <kees@kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "Farid Zakaria" <farid.m.zakaria@gmail.com>
Message-Id: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
Subject: [RFC] Null Namespaces
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6656-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8EF46C1D39

Hello, I am hoping to discuss an idea I've had for a while, that I am
calling "null namespaces" that has become more relevant with some recent
other discussions. First I'll discuss null namespaces in general terms,
and then I'll link those recent discussions and relate null namespaces
to them.

### Null namespaces

The essence of null namespaces is trying to give processes as little
ambient authority as possible, so they are lighter weight and allowed to
do even less than fully unshared processes today.

Namespaces as they exist today are frequently described as an isolation
mechanism, but I think this is the conflation of two different things.
*Removing* a new process from its parent's namespaces unquestionably is
increasing isolation --- no disagreement there. But putting the process
in new namespaces is something else; I would call it supporting
"delusions of grandeur" of that process. For example, namespaces allow a
process to do mounts, have `CAP_SYS_ADMIN`, create network interfaces,
look up other processes by PID, etc.

Conceptually, to remove a process from one ambient authority scope (the
very name "namespaces" indicates they are about ambient authority)
should not require putting it in some ambient authority scope. Just
because, for example, the process cannot see one mount tree, doesn't
mean it needs to see another.

Here's what I am thinking would happen concretely:

First, the simpler cases:

#### Null mount namespace

- requires:

  - null root file system: absolute paths don't work.

  - null current working directory: relative paths with traditional,
    non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't work.

- All operations relating to the "ambient" mount tree don't work.

- `*at` operations with a file descriptor do work.

- The new fd-based mount APIs with detached mounts do work, modulo
  the calling process having enough permissions (as usual).

#### Null network namespace

- No network interfaces

- No abstract Unix sockets

#### Null IPC namespace

- cannot create or look up either type of message queue

#### Null UTS namespace

- no hostname or domainname: `uname`, `gethostname`/`sethostname`, and the
  related `/proc/sys/kernel` sysctls all fail.

#### Null user namespace

- Process has no user or group ids

- All uid/gid-based authorization lookups return "denied"

- -1 / "nobody" IDs for operations we don't want to fail (like `fstat`)
  can be used.

Note how in each of these, the notion of there "existing" a "single"
null namespace or not is degenerate --- every process with a null
namespace field is as isolated from one another (in terms of the axis
that namespace regulates) as they are from processes that are in other
namespaces. It is truly a minimal permission level, and (as we shall
see) cheap too, because it is just a null pointer in `task_struct`.

Then for the nested ones --- PID and cgroup --- we cannot have quite a
null namespace in the same sense, because it is an important property
that these namespaces are hierarchical up to the root namespaces.
Instead of having a disjoint null namespace, we need a null namespace
with a parent.

#### Null PID namespace

- cannot look up other processes by PID

- current process ID lookup fails

- current process's parent process ID lookup fails

- current process still assigned IDs in parent PID namespaces, per usual

#### Null cgroup namespace

- Process still can have resources restricted according to parent cgroup

- Process unaware of cgroup hierarchy though --- blind to who/how it is
  constrained

In these cases, we cannot just implement with a null pointer, because we
still need a valid parent namespace. However, we shouldn't need any info
*but* the parent namespace. A pair of a pointer and a bool indicating
null namespace with parent namespace or actual namespace membership,
with some sort of helper to get the parent namespace in either case
(since the actual namespace has its parent), should implement this.

Finally there is the time namespace. Conceptually a null time namespace
is simple enough --- you cannot look up the time! --- but the
implementation is a bit more complex to get right because of the vDSO
for certain timing operations.

### General Motivation

Why am I so interested in this stuff?

Firstly it is because I have always been interested in a more strictly
object-capability-based userland, and projects like
Capsicum/CloudABI/WASI. I think going all in on file descriptors is
generally the direction that Linux has been going in, and it creates a
genuinely better programming model than the traditional Unix one with
all its ambient authority, and the TOCTOU and other issues that attend
it.

Today's container idioms and the "delusions of grandeur" that namespaces
provide are great for retrofitting existing software to run in a more
isolated environment. But I don't want that to be the ceiling of our
ambitions. Especially in this age of LLM refactoring, it is very easy to
get both new and existing software to abide by the more limited set of
allowed operations that null-namespace processes allow. And the
modifications that that entails (more `openat`, more socket activation,
etc.) make that software (in my view) simply *better* --- I would want
it to work that way with or without these constraints forcing the issue.

Secondly, and more concretely/imminently as a Nix developer, I am very
interested in the performance and overhead of process isolation. It is
very much my ambition to move Nix into the Bazel/Buck space of ever more
numerous and fine-grained atomic build steps (i.e. small compilation
units, not "packages"), but to do this *without* sacrificing Nix's
strong sandboxing guarantees that make our build plans so self-contained
and thus the ease of onboarding new Nix users.

I think this "null namespace" sandboxing will likely be simpler and more
performant than creating and destroying a bunch of regular namespaces
for each compilation unit. And while it will no doubt take some compiler
/ other tool patching to fix up any assumptions that get in the way of
running processes with so few permissions, I am happy to take a stab at
that too. Nix is, after all, for "tool-assisted yak shaves" as one put
it --- patching GCC / Clang / whatever and then rebuilding the world is
something we are quite good at.

Lastly, I'll add that the traditional way people have thought about
things like Capsicum/CloudABI is custom personalities/seccomp rules, but
IMO trying to tackle the massive UAPI surface area so shallowly is ugly
and unmaintainable. Nulling out namespace fields in `task_struct`,
conversely, attacks the problem at its core, much more elegantly, and
makes it easy to handle both current *and future* syscalls in a
minimally invasive and maintainable manner.

### Null namespaces and process spawning

Why bring this up now?

Recently [1], Li Chen took a stab at the venerable old goal of making a
better process spawning UAPI than fork/clone + exec. I am quite excited
to see this happen, as it generally dovetails very nicely with the
object capability goals I have above. (E.g. making it performant and
idiomatic to opt-in, rather than opt-out of sharing file descriptors
with a child process is very good for a world where all
resource/privilege sharing is done with file descriptors.)

One problem with clone that didn't yet come up is that its defaults are
not good from a security perspective: sharing by default, and unsharing
as the opt in means that one must remember and take active measures to
ensure that child processes get *less* privileges. This is very bad ---
secure practices mean that the "lazy programmer" and the "smallest
program" must always err on the side of giving the child process *less*
privileges. This is the only way economics and the "principle of least
privilege" will work together, rather than against each other (and
economics is quite likely to win when they are working against each
other).

The reason that clone *doesn't* work that way is, of course,
performance: it would be wasteful to unshare and create new namespaces
when they are just going to be thrown away because the user wants to
share after all.

Null namespaces I think elegantly work around this performance/security
trade-off, while also avoiding the need for gazillion-parameter syscalls
like clone. This is because, as the most secure option, and a cheap
option, they are the rightful default for a new process creation API.

1. When an "embryonic" (under construction, not yet ready to be
   scheduled) task is first created, it should have all null namespaces.

2. Separate syscalls (`io_uring` exists for batching, we don't need to
   reinvent an ad-hoc batch solution) can exist for setting the
   namespaces on the process, where either "sharing" (use parent process
   namespace) or "unsharing" (use fresh namespace, usually derived from
   the parent process namespace but perhaps derived from a different
   one) are choices that can be opted into instead of the null namespace
   default.

3. After all state is initialized (arguments, environment variables,
   file descriptors, namespaces, etc.), the process can be "birthed",
   and submitted as ready to be scheduled.

This design is very natural to me, but its full naturality is *only*
available with the null namespace option. Otherwise we are stuck in a
place of no good defaults, and the "builder pattern" seems more awkward.

Also in [2], I bring up a design for unix sockets without the file
system or the "abstract" socket namespace, and how I want to avoid both
in order to firmly rule out TOCTOU and other ambient authority issues. I
think those arguments stand on their own, but the possibility of a null
network namespace sharpens the issue: it forces the `O_PATH` FD stuff I
discuss to be the only viable option.

### Implementation

I've "LLM'd" out some draft patches [3] for this. I'm not submitting
them because I still need to review and test them, and I don't want
(currently, pre those steps) low-quality slop to tarnish this proposal.
What this initial exploration did, however, confirm for me is that these
changes should be quite lightweight to implement. (Also, what I propose
is slightly different from my implementation draft in a few cases where
I think the design I proposed here is better than my draft
implementation.)

If the discussion here starts moving towards consensus, I'll clean up
and rework those patches along the lines of the consensus. Ideally I
would submit them one at a time, I figure, since the implementations for
different namespaces are necessarily changes to different subsystems.

Cheers!

John

[1]: https://lore.kernel.org/all/20260528095235.2491226-1-me@linux.beauty/

[2]: https://lore.kernel.org/all/455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com/

[3]: https://github.com/Ericson2314/linux/commits/null-namespace

