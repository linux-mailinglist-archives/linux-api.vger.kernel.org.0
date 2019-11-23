Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9524E108093
	for <lists+linux-api@lfdr.de>; Sat, 23 Nov 2019 21:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfKWUkC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 23 Nov 2019 15:40:02 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:28710 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfKWUj5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 23 Nov 2019 15:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574541592;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Njzpuhzu3QI0QeVkB6DxZ54XWWONzVk6srPWpER7Bj0=;
        b=Hdtgou8g/OV+jj536BlHIO1BZmylY8+dNJoKDIW+tlLzZqz1uokQhleW8IFPsp6lIT
        ijegdWDgJkRhIbnaLZmeHtUxyGCWGBrJi+ssX6JfWnp/BkB6gg+LDNJ2x2ICOwI4kxov
        SPfxalBuzOlRxefr2sRMusDwhFR8GrcATyUyZWQBbmxl5ZgmG0bPGMNlydf/qkRXnaPc
        Sr3hv0etrGXgyLlXXZ/zSyxp8kV26oyqpNo1RdvAHBOpomutMSNTOwkkIKCCburJJGf6
        be+/OgE3ycZdhHOeBcAWoIw/7DsFZVYyDCg8KKq9YF4nYeabl4jGSlg2v5uPxgy2b/nh
        t9Sw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJfSfWrhX"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vANKcg3yc
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 23 Nov 2019 21:38:42 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v26 00/12] /dev/random - a new approach with full SP800-90B
Date:   Sat, 23 Nov 2019 21:08:41 +0100
Message-ID: <2722222.P16TYeLAVu@positron.chronox.de>
In-Reply-To: <2787174.DQlWHN5GGo@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2787174.DQlWHN5GGo@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

The following patch set provides a different approach to /dev/random which =
is
called Linux Random Number Generator (LRNG) to collect entropy within the L=
inux
kernel. The main improvements compared to the existing /dev/random is to pr=
ovide
sufficient entropy during boot time as well as in virtual environments and =
when
using SSDs. A secondary design goal is to limit the impact of the entropy
collection on massive parallel systems and also allow the use accelerated
cryptographic primitives. Also, all steps of the entropic data processing a=
re
testable.

The LRNG patch set allows a user to select use of the existing /dev/random =
or
the LRNG during compile time. As the LRNG provides API and ABI compatible
interfaces to the existing /dev/random implementation, the user can freely =
chose
the RNG implementation without affecting kernel or user space operations.

This patch set provides early boot-time entropy which implies that no
additional flags to the getrandom(2) system call discussed recently on
the LKML is considered to be necessary. Yet, if additional flags are
introduced to cover special hardware, the LRNG implementation will also
provide them to be fully ABI and API compliant as already discussed on
LKML.

The LRNG is fully compliant to SP800-90B requirements and is shipped with a
full SP800-90B assessment and all required test tools. The existing /dev/ra=
ndom
implementation on the other hand has architectural limitations which
does not easily allow to bring the implementation in compliance with
SP800-90B. The key statement that causes concern is SP800-90B section
3.1.6. This section denies crediting entropy to multiple similar noise
sources. This section explicitly references different noise sources resting
on the timing of events and their derivatives (i.e. it is a direct complaint
to the existing existing /dev/random implementation). Therefore, SP800-90B
now denies the very issue mentioned in [1] with the existing /dev/random
implementation for a long time: crediting entropy to interrupts as well as
crediting entropy to derivatives of interrupts (HID and disk events). This =
is
not permissible with SP800-90B.

SP800-90B specifies various requirements for the noise source(s) that seed =
any
DRNG including SP800-90A DRBGs. In about a year from now, SP800-90B will be
mandated for all noise sources that provide entropy to DRBGs as part of a F=
IPS
140-[2|3] validation or other evaluation types. That means, if we there are=
 no
solutions to comply with the requirements of SP800-90B found till one year
from now, any random number generation and ciphers based on random numbers
on Linux will be considered and treated as not applicable and delivering
no entropy! As /dev/urandom, getrandom(2) and /dev/random are the most
common and prevalent noise sources for DRNGs, all these DRNGs are affected.
This applies across the board for all validations of cryptography executing=
 on
Linux (kernel and user space modules).

=46or users that are not interested in SP800-90B, the entire code for the
compliance as well as test interfaces can be deselected at compile time.

The design and implementation is driven by a set of goals described in [1]
that the LRNG completely implements. Furthermore, [1] includes the full
assessment of the SP800-90B compliance as well as a comparison with RNG
design suggestions of SP800-90C, and AIS20/31.

The LRNG provides a complete separation of the noise source maintenance
and the collection of entropy into an entropy pool from the post-processing
using a pseudo-random number generator. Different DRNGs are supported,
including:

* The LRNG can be compile-time enabled to replace the existing /dev/random
  implementation. When not selecting the LRNG at compile time (default), the
  existing /dev/random implementation is built.

* Built-in ChaCha20 DRNG which has no dependency to other kernel
  frameworks.

* SP800-90A DRBG using the kernel crypto API including its accelerated
  raw cipher implementations. This implies that the output of /dev/random,
  getrandom(2), /dev/urandom or get_random_bytes is fully compliant to
  SP800-90A.

* Arbitrary DRNGs registered with the kernel crypto API

* Full compliance with SP800-90B which covers the startup and runtime health
  tests mandated by SP800-90B as well as providing the test tools and test
  interfaces to obtain raw noise data securely. The test tools are provided=
 at
  [1].

Booting the patch with the kernel command line option
"dyndbg=3Dfile drivers/char/lrng/* +p" generates logs indicating the operat=
ion
of the LRNG. Each log is pre-pended with "lrng".

The LRNG has a flexible design by allowing an easy replacement of the
deterministic random number generator component.

Compared to the existing /dev/random implementation, the compiled binary
is smaller when the LRNG is compiled with all options equal to the
existing /dev/random (i.e. only CONFIG_LRNG and
CONFIG_LRNG_TRNG_SUPPORT are set): random.o is 52.5 kBytes whereas
all LRNG object files are in 49 kBytes in size. The fully
SP800-90A/SP800-90B compliant binary code (CONFIG_LRNG,
CONFIG_LRNG_DRNG_SWITCH, CONFIG_LRNG_DRBG, CONFIG_LRNG_HEALTH_TESTS)
uses some 61 kBytes.

[1] http://www.chronox.de/lrng.html - If the patch is accepted, I would
be volunteering to convert the documentation into RST format and
contribute it to the Linux kernel documentation directory.

Changes (compared to the previous patch set):

* Extract the time initalization code into its own function
  lrng_init_time_source and invoke it with core_initcall as reported
  by Nicolai Stange

* Add linux/errno.h include to lrng.h as suggested by Nicolai Stange

* Add linux/slab.h to lrng_chacha20.h

* Changed lrng_testing.c reading/writing of ring buffer to use a lock
  as suggested by Andy Lutomirski

* Use "depends on DEBUG_FS" for lrng_testing.c Kconfig entry as
  suggested by Randy Dunlap

* Remove declaration of random_table from lrng_proc.c as suggested by
  Eric W. Biederman

* Move the lrng_type file out of the sysctl table into its own file
  /proc/lrng_type since its purpose is not to serve as a sysctl
  as suggested by Eric W. Biederman

* Update patch description for /proc patch to refer to sysctls as suggested
  by Eric W. Biederman

* /dev/random and getrandom(GRND_RANDOM) now invokes the secondary DRNG
  ensuring that the DRNG is fully seeded before requests are served. With
  this change, /dev/random is no TRNG any more. This change implements
  the suggestion from Andy Lutomirski and is based on the discussions
  previously on the LKML and the changes developed by Andy for the existing
  random.c implementation.

* Simplification of the debugfs code in lrng_testing.c as return code
  checks are not further needed any more as suggested by Nicolai Stange.

* Addition of GRND_TRUERANDOM to the getrandom(2) syscall to make the TRNG
  externally accessible as a TRNG. The change also includes the GRND_INSECU=
RE
  flag as proposed by Andy Lutomirski. To avoid touching the random.h and
  potentially clashing with Andy's patch set, I kept the symbol definitions
  in lrng_interfaces.c noting that they should be moved to random.h. The
  GRND_TRUERANDOM allows unprivileged user space to access the TRNG as foll=
ows:
  if CAP_SYS_ADMIN calls, the whole entropy available to the LRNG is used. =
If
  an unprivileged process invokes GRND_TRUERANDOM, at least 1024 bits of en=
tropy
  will remain in the pool to serve CAP_SYS_ADMIN and all secondary DRNGs
  serving /dev/urandom, /dev/random and getrandom(.., 0) with entropy. With
  that unprivileged processes calling GRND_TRUERANDOM have the lowest prior=
ity
  in getting entropy and must wait accordingly. If the TRNG is not present,
  GRND_TRUERANDOM returns -EOPNOTSUPP. A new test tool is provided as part
  of the LRNG test archive found at [1] allowing to analyze all four types
  of RNGs accessible via getrandom(2).

* Remove duplication of MODULE_LICENSE/AUTHOR/DESCRIPTION from lrng_testing=
=2Ec

A patch for adding power-up self tests is prepared but I did not want to ad=
d it
now to support code review of a code base with minimal changes. It will be
provided once the code review is completed. With this pending code, the
following tests are available:

* power-on self test: LFSR self test

* power-on self test: ChaCha20 DRNG self test

* power-on self test: time stamp array handling in lrng_sw_noise.c

* power-on self test: SP800-90A DRBG self test

* runtime test: raw noise source data collection, if enabled

* separate test: SP800-90B APT and RCT test enforcement validation if enabl=
ed

As a side node: With the switchable DRNG support offered in this patch set,
the following areas could be removed. As the existing /dev/random has no su=
pport
for switchable DRNGs, however, this is not yet feasible though.

* remove lrng_ready_list and all code around it in lrng_interfaces.c

* remove the kernel crypto API RNG API to avoid having two random number
  providing APIs - this would imply that all RNGs developed for this API wo=
uld
  be converted to the LRNG interface

CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Alexander E. Patrakov" <patrakov@gmail.com>
CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>
CC: Willy Tarreau <w@1wt.eu>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Vito Caputo <vcaputo@pengaru.com>
CC: Andreas Dilger <adilger.kernel@dilger.ca>
CC: Jan Kara <jack@suse.cz>
CC: Ray Strode <rstrode@redhat.com>
CC: William Jon McCann <mccann@jhu.edu>
CC: zhangjs <zachary@baishancloud.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Florian Weimer <fweimer@redhat.com>
CC: Lennart Poettering <mzxreary@0pointer.de>
CC: Nicolai Stange <nstange@suse.de>
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>

Stephan Mueller (12):
  Linux Random Number Generator
  LRNG - allocate one SDRNG instance per NUMA node
  LRNG - sysctls and /proc interface
  LRNG - add switchable DRNG support
  crypto: DRBG - externalize DRBG functions for LRNG
  LRNG - add SP800-90A DRBG extension
  LRNG - add kernel crypto API PRNG extension
  crypto: provide access to a static Jitter RNG state
  LRNG - add Jitter RNG fast noise source
  LRNG - add TRNG support
  LRNG - add SP800-90B compliant health tests
  LRNG - add interface for gathering of raw entropy

 MAINTAINERS                         |   7 +
 crypto/drbg.c                       |  16 +-
 crypto/jitterentropy.c              |  23 +
 drivers/char/Kconfig                |   2 +
 drivers/char/Makefile               |   9 +-
 drivers/char/lrng/Kconfig           | 188 ++++++++
 drivers/char/lrng/Makefile          |  19 +
 drivers/char/lrng/lrng_archrandom.c |  92 ++++
 drivers/char/lrng/lrng_aux.c        | 148 ++++++
 drivers/char/lrng/lrng_chacha20.c   | 329 ++++++++++++++
 drivers/char/lrng/lrng_drbg.c       | 261 +++++++++++
 drivers/char/lrng/lrng_health.c     | 409 +++++++++++++++++
 drivers/char/lrng/lrng_interfaces.c | 665 +++++++++++++++++++++++++++
 drivers/char/lrng/lrng_internal.h   | 320 +++++++++++++
 drivers/char/lrng/lrng_jent.c       |  88 ++++
 drivers/char/lrng/lrng_kcapi.c      | 328 ++++++++++++++
 drivers/char/lrng/lrng_numa.c       | 101 +++++
 drivers/char/lrng/lrng_pool.c       | 671 ++++++++++++++++++++++++++++
 drivers/char/lrng/lrng_proc.c       | 179 ++++++++
 drivers/char/lrng/lrng_sdrng.c      | 420 +++++++++++++++++
 drivers/char/lrng/lrng_sw_noise.c   | 144 ++++++
 drivers/char/lrng/lrng_switch.c     | 185 ++++++++
 drivers/char/lrng/lrng_testing.c    | 269 +++++++++++
 drivers/char/lrng/lrng_trng.c       | 297 ++++++++++++
 include/crypto/drbg.h               |   7 +
 include/linux/lrng.h                |  71 +++
 26 files changed, 5241 insertions(+), 7 deletions(-)
 create mode 100644 drivers/char/lrng/Kconfig
 create mode 100644 drivers/char/lrng/Makefile
 create mode 100644 drivers/char/lrng/lrng_archrandom.c
 create mode 100644 drivers/char/lrng/lrng_aux.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.c
 create mode 100644 drivers/char/lrng/lrng_drbg.c
 create mode 100644 drivers/char/lrng/lrng_health.c
 create mode 100644 drivers/char/lrng/lrng_interfaces.c
 create mode 100644 drivers/char/lrng/lrng_internal.h
 create mode 100644 drivers/char/lrng/lrng_jent.c
 create mode 100644 drivers/char/lrng/lrng_kcapi.c
 create mode 100644 drivers/char/lrng/lrng_numa.c
 create mode 100644 drivers/char/lrng/lrng_pool.c
 create mode 100644 drivers/char/lrng/lrng_proc.c
 create mode 100644 drivers/char/lrng/lrng_sdrng.c
 create mode 100644 drivers/char/lrng/lrng_sw_noise.c
 create mode 100644 drivers/char/lrng/lrng_switch.c
 create mode 100644 drivers/char/lrng/lrng_testing.c
 create mode 100644 drivers/char/lrng/lrng_trng.c
 create mode 100644 include/linux/lrng.h

=2D-=20
2.23.0




