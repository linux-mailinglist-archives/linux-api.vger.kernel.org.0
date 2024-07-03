Return-Path: <linux-api+bounces-1827-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33BE926839
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 20:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECF41C24B70
	for <lists+linux-api@lfdr.de>; Wed,  3 Jul 2024 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E418EFE6;
	Wed,  3 Jul 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XlRrVswu"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424818E777;
	Wed,  3 Jul 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031488; cv=none; b=U9k+U3NDpECNK3hSCelkm6K0dCMOCIHR7zndGX/V3wyZeAtrBB8NqVxJ92WlmSbSywVknt59DxrMJ94IQS3Lrcw6FPlkq4as88cKM4oxok/ZJAMKlomTH9YKwDwTTtrtvwcaw7oN/ocraxOwBf+9i39ZR0S5ZCweYZRYq/frP/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031488; c=relaxed/simple;
	bh=o+jAGmNmg/EbKZkmdqxSAqMgW3+DpW3QW/DcUaryVxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/QrOqsm0qWVMMUJ8b+95J9nvn9JDxScfWRcD45gtV/LHgFdgO90+vY7ESe8liamYBgPuP9LcqjpH2CDx27LmQNCaSOmTFYVEjlHycLgASlktfD8smY3x3QN3qyTAssb7GBDwIHoGlryrZo8Ulw3Na70rJa/RMkVOWyHUq129ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=XlRrVswu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63047C32781;
	Wed,  3 Jul 2024 18:31:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XlRrVswu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720031484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PGhXV5DYRHuEQI1xMnU1PR8Q318odFD06EpSsSfipRg=;
	b=XlRrVswuN1tGty9KnRqJSTvn1VW+DGYeaW9viEL3TaR6XhEger6A5UYdGS7lmp8v3xJrmK
	vHifzhgV/SIo/uGTlJ3aoJA4a4b913dDZBCKJySyGpAZ193PK0rgqtb2kPQvjg90fPXz9r
	KbMcvvZFMNi4CsDIgtt/8Bo51qoaeiY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f1c3899b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jul 2024 18:31:23 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	tglx@linutronix.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: [PATCH v20 0/5] implement getrandom() in vDSO
Date: Wed,  3 Jul 2024 20:31:09 +0200
Message-ID: <20240703183115.1075219-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes v14->{present}:
----------------------
This is back after a bit of a hiatus. In the last attempt to do this in
the beginning of 2023, I think we reached consensus on a few things --
the use case, the vDSO implementation and semantics, its integration
with libc, the test code and documentation, and so forth. It was
basically "ready to go". Almost. But there was a lingering issue that
bogged this down, which is that it demanded some new mm semantics that
weren't very popular.

In particular, the series from last year made use of the x86 instruction
decoder to just skip over faulting instructions. I still think this is
nifty, but it's not actually essential for the semantics needed, and I
can understand why this was by far the largest objection. So all of that
is dropped, which simplifies quite a bit.

In another avenue of the mm discussion, Andy had mentioned using
_install_special_mapping() instead of the VM_DROPPABLE work, and I spent
a long while looking into this, and attempted several times to code up a
working implementation that used that. But the semantics really just
weren't possible without adding hooks to lots of other core code, and
duplicating a lot of code that really ought not to be. So I've kept the
VM_DROPPABLE patch here, but because the x86 instruction decoding stuff
has been removed, that patch is actually a lot smaller and simpler and I
don't think should be too controversial. In terms of actual C code, it
only adds around 6 lines, and is compact enough that you can just grep
for VM_DROPPABLE to see the whole thing.

The original cover letter is produced below. I'm eager to finally get
this patchset moving, and sorry for the delay in producing the v+1 from
before.

Assuming this goes well, the plan would be to take this through my
random.git tree for 6.11. It's cooking in linux-next now.

Thanks ahead of time for taking a look at it.

Changes v19->v20:
- Update compat syscall count macro on arm64.
- Fix page straddling calculation in test code.
- Due to potential merge conflicts with 6.11 on the syscall number, take pains
  to avoid writing it in commit messages or test code.
- Add test of VM_DROPPABLE to vgetrandom_alloc() selftest.
- Add comments to VM_DROPPABLE code in rmap to distinguish it from MADV_FREE.

Changes v18->v19:
- Collect acks from tglx. (And this series is now in linux-next.)
- Rebase onto rc6 to prevent conflicts.
- Move vgetrandom_alloc() syscall to using the new "extensible struct" pattern,
  similar to clone3().

Changes v17->v18:
- Commit message typos.
- Rebase on later 6.10 commit, because some conflicts got introduced that are
  easily resolved this way.
- Add line breaks to cflags in kselftests makefile. There may be more makefile
  fixups in store, but those depend on other patches John posted on LKML that
  haven't landed yet, so that'll have to be fixed later.
- Add "opaque_len" argument to vgetrandom() to address CRIU concerns.
- Use proper smp ordering for generation changes, and document pairing of release/acquires.

Changes v16->v17:
- Generate patchset using --base.
- Rebase on 6.10-rc1, which means bumping the syscall number to 463.
- Adjust documentation and example code to specify proper munmap() deallocation
  calculation.
- Use %xmm0 instead of %xmm8 as temp register for more compact encoding.
- Documentation comment syntax fixups.
- If page-straddling address is passed to vgetrandom, rather than falling back
  to the syscall, return -EFAULT.
- Get rid of vdso_kernel_ulong type and just use u64 uniformly.
- Don't include crypto/chacha.h inside of a vdso header, to keep kernel code
  out of the vdso user code.
- Balance christmas trees.
- Improve comments of vgetrandom() function.
- Get rid of NOWARN|NORETRY memory allocation logic, and also don't clear the
  OOM flag on failure. This is kind of a problem, but Jann and Michal thought
  that it was better to crash than for userspace to keep retrying instructions.
  And the pre-v14 series that tried to skip the instruction instead of retrying
  was marred by controversy. So just table this for later; it's probably not
  essential now.

Changes v15->v16:
- DavidH pointed out a missing swap edge case in 1/5.
- Mostly just a resend because I forgot --cc-cover, and sent it during
  the merge window. 

--------------

Useful links:

- This series:
  - https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/

- Glibc patches by Adhemerval and me against glibc-2.39:
  - https://git.zx2c4.com/glibc/log/?h=vdso

- You may also want these if you're daily driving this as I am on a normal
  desktop system:
  - systemd patch: https://github.com/systemd/systemd/pull/25519
  - libseccomp patch: https://github.com/seccomp/libseccomp/pull/395

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

  ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);

The return value and the first 3 arguments are the same as ordinary
getrandom(), while the last argument is a pointer to some state
allocated with vgetrandom_alloc(), explained below. Were all four
arguments passed to the getrandom syscall, nothing different would
happen, and the functions would have the exact same behavior.

Then, we introduce a new syscall:

  void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each,
                         unsigned long addr, unsigned int flags);

This takes a hinted number of opaque states in `num`, and returns a
pointer to an array of opaque states, the number actually allocated back
in `num`, and the size in bytes of each one in `size_per_each`, enabling
a libc to slice up the returned array into a state per each thread. (The
`flags` and `addr` arguments, as well as the `*size_per_each` input
value, are reserved for the future and are forced to be zero for now.)

Libc is expected to allocate a chunk of these on first use, and then
dole them out to threads as they're created, allocating more when
needed. The returned address of the first state may be passed to
munmap(2) with a length of `num * size_per_each`, in order to deallocate
the memory.

We very intentionally do *not* leave state allocation up to the caller
of vgetrandom, but provide vgetrandom_alloc for that allocation. There
are too many weird things that can go wrong, and it's important that
vDSO does not provide too generic of a mechanism. It's not going to
store its state in just any old memory address. It'll do it only in ones
it allocates.

Right now this means it uses a new mm flag called VM_DROPPABLE, along
with VM_WIPEONFORK. In the future maybe there will be other interesting
page flags or anti-heartbleed measures, or other platform-specific
kernel-specific things that can be set from the syscall. Again, it's
important that the kernel has a say in how this works rather than
agreeing to operate on any old address; memory isn't neutral.

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
second commit of this series, showing how the syscall and the vDSO function
are meant to be used together.

Cc: linux-crypto@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <dhildenb@redhat.com>

Jason A. Donenfeld (5):
  mm: add VM_DROPPABLE for designating always lazily freeable mappings
  random: add vgetrandom_alloc() syscall
  arch: allocate vgetrandom_alloc() syscall number
  random: introduce generic vDSO getrandom() implementation
  x86: vdso: Wire up getrandom() vDSO implementation

 MAINTAINERS                                   |   4 +
 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd.h               |   2 +-
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/x86/entry/vdso/Makefile                  |   3 +-
 arch/x86/entry/vdso/vdso.lds.S                |   2 +
 arch/x86/entry/vdso/vgetrandom-chacha.S       | 178 ++++++++++
 arch/x86/entry/vdso/vgetrandom.c              |  17 +
 arch/x86/include/asm/vdso/getrandom.h         |  55 +++
 arch/x86/include/asm/vdso/vsyscall.h          |   2 +
 arch/x86/include/asm/vvar.h                   |  16 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 drivers/char/random.c                         | 140 +++++++-
 fs/proc/task_mmu.c                            |   3 +
 include/linux/mm.h                            |   8 +
 include/linux/syscalls.h                      |   3 +
 include/trace/events/mmflags.h                |   7 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/random.h                   |  17 +
 include/vdso/datapage.h                       |  11 +
 include/vdso/getrandom.h                      |  46 +++
 kernel/sys_ni.c                               |   3 +
 lib/vdso/Kconfig                              |   6 +
 lib/vdso/getrandom.c                          | 236 +++++++++++++
 mm/Kconfig                                    |   3 +
 mm/mprotect.c                                 |   2 +-
 mm/rmap.c                                     |  16 +-
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   1 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 tools/testing/selftests/vDSO/.gitignore       |   2 +
 tools/testing/selftests/vDSO/Makefile         |  19 +
 .../testing/selftests/vDSO/vdso_test_chacha.c |  43 +++
 .../selftests/vDSO/vdso_test_getrandom.c      | 330 ++++++++++++++++++
 50 files changed, 1197 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 include/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_chacha.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getrandom.c


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.45.2


