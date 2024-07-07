Return-Path: <linux-api+bounces-1856-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2CE92961C
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 02:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E337F284236
	for <lists+linux-api@lfdr.de>; Sun,  7 Jul 2024 00:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BB63C7;
	Sun,  7 Jul 2024 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N13wZYMa"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0786112;
	Sun,  7 Jul 2024 00:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312034; cv=none; b=Yp3AUMsGm5IRbGEEb/1GQcHIKwWF8KkNUYcvZeCctnkIm8Ua/rDL+GpQd2djSuqpJHjwmTJs0ls85b1iJhXrtvyHDazerNCtkZQdR4yZm9xjW9dR+66F5cMDqYjZ2XabXK/UBAiCMGWGJ1p4E9bwkvOCBvGS6pGWRbr/ZWpN/I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312034; c=relaxed/simple;
	bh=L5JbagMUbJt08yuYQI9FS0omO4BxfsUUqnPF8ooyYn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pxHEA/bM0mHXvP91g1o2b+cQ46kJ18NyRKFnyTqK4uk17y4FfP72tAl8B+vJL/apqOWX58/vjkN2jDOYTMOH1cgGDCcoY3j/XB5/bNc+BviQqBI7Q8I73jmzxfgyH/70EVBGxO+dEO0THVW4Du77EZ6+aRUzgcqi22O1Ekz4Fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=N13wZYMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D5CC4AF0A;
	Sun,  7 Jul 2024 00:27:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N13wZYMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720312029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LHq8XfHVr/Er/seq5fzt+staVUiCGh94aZm7Brs1gKI=;
	b=N13wZYMaqsyR07hZJ3uAEKhMZPN/yeOhVrmFOlBqk9TI+/KXSdgeXtS/VB0H2FZAIn90b2
	oi0MrTgwsd5nZ3FaRBRI4fldELR/7AOfvqe/TjEAQQQLGqiafOCBns9dlxkxvHVieGAJes
	gyjrQOmhba/JzhRG+Lu+1V+hKG96j+Y=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83b94709 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 7 Jul 2024 00:27:09 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	tglx@linutronix.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: [PATCH v21 0/4] implement getrandom() in vDSO
Date: Sun,  7 Jul 2024 02:26:50 +0200
Message-ID: <20240707002658.1917440-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The plan for this series is to take it through my random.git tree for 6.11.
It's cooking in linux-next now.

Changes v20->v21:

- After extensive conversation with Linus, we're nixing the entire
  vgetrandom_alloc() syscall, in favor of just exposing the functionality
  needed through mmap() and having the kernel communicate to the caller what
  arguments/sizes it should pass to mmap(). This simplifies the series
  considerably. It also means that the first commit adds some new MAP_*
  constants for mmap().

- Separate vDSO selftests out into separate commit.

--------------

Useful links:

- This series:
  - https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/

- In case you're actually interested in the v≤14 design where faults were
  non-fatal and instructions were skipped (which I think is more coherent, even
  if the implementation is controversial), this lives in my branch here:
  - https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/?h=jd/vdso-skip-insn
  Note that I'm *not* actually proposing this for upstream at this time. But it
  may be of conversational interest.

-------------

Two statements:

  1) Userspace wants faster cryptographically secure random numbers of
     arbitrary size, big or small.

  2) Userspace is currently unable to safely roll its own RNG with the
     same security profile as getrandom().

Statement (1) has been debated for years, with arguments ranging from
"we need faster cryptographically secure card shuffling!" to "the only
things that actually need good randomness are keys, which are few and
far between" to "actually, TLS CBC nonces are frequent" and so on. I
don't intend to wade into that debate substantially, except to note that
recently glibc added arc4random(), whose goal is to return a
cryptographically secure uint32_t, and there are real user reports of it
being too slow. So here we are.

Statement (2) is more interesting. The kernel is the nexus of all
entropic inputs that influence the RNG. It is in the best position, and
probably the only position, to decide anything at all about the current
state of the RNG and of its entropy. One of the things it uniquely knows
about is when reseeding is necessary.

For example, when a virtual machine is forked, restored, or duplicated,
it's imparative that the RNG doesn't generate the same outputs. For this
reason, there's a small protocol between hypervisors and the kernel that
indicates this has happened, alongside some ID, which the RNG uses to
immediately reseed, so as not to return the same numbers. Were userspace
to expand a getrandom() seed from time T1 for the next hour, and at some
point T2 < hour, the virtual machine forked, userspace would continue to
provide the same numbers to two (or more) different virtual machines,
resulting in potential cryptographic catastrophe. Something similar
happens on resuming from hibernation (or even suspend), with various
compromise scenarios there in mind.

There's a more general reason why userspace rolling its own RNG from a
getrandom() seed is fraught. There's a lot of attention paid to this
particular Linuxism we have of the RNG being initialized and thus
non-blocking or uninitialized and thus blocking until it is initialized.
These are our Two Big States that many hold to be the holy
differentiating factor between safe and not safe, between
cryptographically secure and garbage. The fact is, however, that the
distinction between these two states is a hand-wavy wishy-washy inexact
approximation. Outside of a few exceptional cases (e.g. a HW RNG is
available), we actually don't really ever know with any rigor at all
when the RNG is safe and ready (nor when it's compromised). We do the
best we can to "estimate" it, but entropy estimation is fundamentally
impossible in the general case. So really, we're just doing guess work,
and hoping it's good and conservative enough. Let's then assume that
there's always some potential error involved in this differentiator.

In fact, under the surface, the RNG is engineered around a different
principle, and that is trying to *use* new entropic inputs regularly and
at the right specific moments in time. For example, close to boot time,
the RNG reseeds itself more often than later. At certain events, like VM
fork, the RNG reseeds itself immediately. The various heuristics for
when the RNG will use new entropy and how often is really a core aspect
of what the RNG has some potential to do decently enough (and something
that will probably continue to improve in the future from random.c's
present set of algorithms). So in your mind, put away the metal
attachment to the Two Big States, which represent an approximation with
a potential margin of error. Instead keep in mind that the RNG's primary
operating heuristic is how often and exactly when it's going to reseed.

So, if userspace takes a seed from getrandom() at point T1, and uses it
for the next hour (or N megabytes or some other meaningless metric),
during that time, potential errors in the Two Big States approximation
are amplified. During that time potential reseeds are being lost,
forgotten, not reflected in the output stream. That's not good.

The simplest statement you could make is that userspace RNGs that expand
a getrandom() seed at some point T1 are nearly always *worse*, in some
way, than just calling getrandom() every time a random number is
desired.

For those reasons, after some discussion on libc-alpha, glibc's
arc4random() now just calls getrandom() on each invocation. That's
trivially safe, and gives us latitude to then make the safe thing faster
without becoming unsafe at our leasure. Card shuffling isn't
particularly fast, however.

How do we rectify this? By putting a safe implementation of getrandom()
in the vDSO, which has access to whatever information a
particular iteration of random.c is using to make its decisions. I use
that careful language of "particular iteration of random.c", because the
set of things that a vDSO getrandom() implementation might need for making
decisions as good as the kernel's will likely change over time. This
isn't just a matter of exporting certain *data* to userspace. We're not
going to commit to a "data API" where the various heuristics used are
exposed, locking in how the kernel works for decades to come, and then
leave it to various userspaces to roll something on top and shoot
themselves in the foot and have all sorts of complexity disasters.
Rather, vDSO getrandom() is supposed to be the *same exact algorithm*
that runs in the kernel, except it's been hoisted into userspace as
much as possible. And so vDSO getrandom() and kernel getrandom() will
always mirror each other hermetically.

API-wise, the vDSO gains this function:

  ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags,
                     void *opaque_state, size_t opaque_len);

The return value and the first 3 arguments are the same as ordinary
getrandom(), while the penultimate argument is a pointer to some state
allocated with the right flags passed to mmap(2), explained below. Were all
five arguments passed to the getrandom syscall, nothing different would happen,
and the functions would have the exact same behavior.

If vgetrandom(NULL, 0, 0, &params, ~0UL) is called, then params gets populated
with information about what flags and prot fields to pass to mmap(2), as well
as how big each state should be, so that the caller can slice up returned
memory from mmap(2) into chunks for passing to vgetrandom().

Libc is expected to allocate a chunk of these on first use, and then
dole them out to threads as they're created, allocating more when
needed.

The interesting meat of the implementation is in lib/vdso/getrandom.c,
as generic C code, and it aims to mainly follow random.c's buffered fast
key erasure logic. Before the RNG is initialized, it falls back to the
syscall. Right now it uses a simple generation counter to make its decisions
on reseeding (though this could be made more extensive over time).

The actual place that has the most work to do is in all of the other
files. Most of the vDSO shared page infrastructure is centered around
gettimeofday, and so the main structs are all in arrays for different
timestamp types, and attached to time namespaces, and so forth. I've
done the best I could to add onto this in an unintrusive way.

In my test results, performance is pretty stellar (around 15x for uint32_t
generation), and it seems to be working. There's an extended example in the
last commit of this series, showing how the syscall and the vDSO function
are meant to be used together.

Cc: linux-crypto@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <dhildenb@redhat.com>

Jason A. Donenfeld (4):
  mm: add VM_DROPPABLE for designating always lazily freeable mappings
  random: introduce generic vDSO getrandom() implementation
  x86: vdso: Wire up getrandom() vDSO implementation
  selftests/vDSO: add tests for vgetrandom

 MAINTAINERS                                   |   4 +
 arch/alpha/include/uapi/asm/mman.h            |   3 +
 arch/mips/include/uapi/asm/mman.h             |   3 +
 arch/parisc/include/uapi/asm/mman.h           |   3 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/Makefile                  |   3 +-
 arch/x86/entry/vdso/vdso.lds.S                |   2 +
 arch/x86/entry/vdso/vgetrandom-chacha.S       | 178 +++++++++++
 arch/x86/entry/vdso/vgetrandom.c              |  17 ++
 arch/x86/include/asm/vdso/getrandom.h         |  55 ++++
 arch/x86/include/asm/vdso/vsyscall.h          |   2 +
 arch/x86/include/asm/vvar.h                   |  16 +
 arch/xtensa/include/uapi/asm/mman.h           |   3 +
 drivers/char/random.c                         |  18 +-
 fs/proc/task_mmu.c                            |   3 +
 include/linux/mm.h                            |   8 +
 include/trace/events/mmflags.h                |   7 +
 include/uapi/asm-generic/mman-common.h        |   4 +
 include/uapi/linux/random.h                   |  15 +
 include/vdso/datapage.h                       |  11 +
 include/vdso/getrandom.h                      |  46 +++
 lib/vdso/Kconfig                              |   6 +
 lib/vdso/getrandom.c                          | 252 +++++++++++++++
 mm/Kconfig                                    |   3 +
 mm/mmap.c                                     |  15 +
 mm/mprotect.c                                 |   2 +-
 mm/rmap.c                                     |  16 +-
 tools/include/asm/rwonce.h                    |   0
 tools/include/uapi/asm-generic/mman-common.h  |   4 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/droppable.c        |  53 ++++
 tools/testing/selftests/vDSO/.gitignore       |   2 +
 tools/testing/selftests/vDSO/Makefile         |  15 +
 .../testing/selftests/vDSO/vdso_test_chacha.c |  43 +++
 .../selftests/vDSO/vdso_test_getrandom.c      | 288 ++++++++++++++++++
 36 files changed, 1097 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 include/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 tools/include/asm/rwonce.h
 create mode 100644 tools/testing/selftests/mm/droppable.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_chacha.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getrandom.c


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.45.2


