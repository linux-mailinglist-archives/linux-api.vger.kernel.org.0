Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B9F7FD6
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 20:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKKTZk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 14:25:40 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.179]:27438 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfKKTZk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 14:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573500334;
        s=strato-dkim-0002; d=chronox.de;
        h=Message-ID:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=7vwgCAEN7oJOVzriDotgWu4mTpr4jmrm5MfR+TKI5A8=;
        b=CILqfhUssRqAKucBP+9CRSEDWJ9gWHm/fX+66T+4zhExkN/Z1kJxfwD3AEfzZgm3Bt
        SCGhekC1sAgXd+0BmERTll+KAX0jQanoLHEUX6Orbzhyg9NEACrfzc7ggD6Z1FJBqxCv
        71OpwVGQHZ74wPa3p2VBjMYz+o59kSEKDE6gAyJD8CWdrcoa1voMro3EXgAtGFerc5uR
        zj/F8Ee4n3YvVSPrU81isPDoR3kf1NQ0uqqXvsimy/RYwTuylf75Fsx5ppqsnJ1dHVti
        fXSMn1poHjGPu/UnXB80TJnFY/0y8cXDyaCgx7S2rTEu1x+W4MjyUUoNk9AnMNhOU9/E
        8yrQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmgLKehaO2hZDSTWbgzIOA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id N09a57vABJDU3Xe
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 11 Nov 2019 20:13:30 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
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
        Neil Horman <nhorman@redhat.com>
Subject: [PATCH v24 00/12] /dev/random - a new approach with full SP800-90B compliance
Date:   Mon, 11 Nov 2019 19:17:30 +0100
Message-ID: <6157374.ptSnyUpaCn@positron.chronox.de>
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
the LKML is considered to be necessary.

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
"dyndbg=3Dfile drivers/char/lrng* +p" generates logs indicating the operati=
on
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

Changes (compared to the previous patch set for 5.2):

* breakup of the monolithic code base into several logically isolated
  files and move all files into drivers/char/lrng/ - this also reduces
  the number of ifdefs in the code significantly as the make system is
  used to select the enabled code

* Add Tested-by and Reviewed-by lines

* Significant speedup of code executing in interrupt handler: the LRNG
  is now almost 50% faster as the existing /dev/random. On one example
  system, the LRNG interrupt handling code executes within an average of
  65 cycles whereas the existing /dev/random on the same device takes
  about 97 cycles.

* SP800-90B compliance
	- use hash_df function defined in SP800-90A section 10.3.1 to read
	  entropy pool
	- add compile time configurable SP800-90B health tests and eliminate
	  any FIPS 140-2 code from the base code
	- consider entropy reduction of conditioning operation compliant
	  to SP800-90B
	- complete entropy assessment and entropy assessment tests available
	at [1]

* prune base LRNG code of any FIPS-related code - all FIPS-related code is
  in the SP800-90B compliance code that can be deactivated at compile time

* testing performed with all tests offered at [1] including all required
  SP800-90B tests, as well as KASAN, UBSAN, and lockdep while executing
  stress tests. Tests were performed on: x86, S390

* make DRNG switching support compile-time configurable

* selection of entropy pool size is now a configure option

* support deactivation of TRNG (i.e. blocking behavior of /dev/random)
  at compile time. If deactivated, /dev/random behaves like
  getrandom(2).

* conditionally compile NUMA support

* eliminate in_atomic() invocation: In-kernel consumers always use
  the ChaCha20 DRNG unless the new API call get_random_bytes_full
  is invoked which may sleep but offer access to the full functionality
  of the LRNG including all types of DRNG.

* use debugfs file for obtaining raw entropy test data required to fulfill
  SP800-90B requirements

* fix: ensure that gathering raw entropy does not affect runtime of the ker=
nel

* fix: import upstream patch b7d5dc21072cda7124d13eae2aefb7343ef94197

* fix: import upstream patch 428826f5358c922dc378830a1717b682c0823160

* fix: integrate patch "random: Don't freeze in add_hwgenerator_randomness()
  if stopping kthread"

* documentation enhancement: import upstream patch
  92e507d216139b356a375afbda2824e85235e748 into documentation to cover all
  interfaces of the LRNG

* speedup of injection of non-aligned data into entropy pool

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
Tested-by: Neil Horman <nhorman@redhat.com>

Stephan Mueller (12):
  Linux Random Number Generator
  LRNG - allocate one SDRNG instance per NUMA node
  LRNG - /proc interface
  LRNG - add switchable DRNG support
  crypto: DRBG - externalize DRBG functions for LRNG
  LRNG - add SP800-90A DRBG extension
  LRNG - add kernel crypto API PRNG extension
  crypto: provide access to a static Jitter RNG state
  LRNG - add Jitter RNG fast noise source
  LRNG - add TRNG support
  LRNG - add SP800-90B compliance
  LRNG - add interface for gathering of raw entropy

 MAINTAINERS                         |   7 +
 crypto/drbg.c                       |  16 +-
 crypto/jitterentropy.c              |  23 +
 drivers/char/Kconfig                |   2 +
 drivers/char/Makefile               |   9 +-
 drivers/char/lrng/Kconfig           | 145 ++++++
 drivers/char/lrng/Makefile          |  19 +
 drivers/char/lrng/lrng_archrandom.c | 105 +++++
 drivers/char/lrng/lrng_aux.c        | 161 +++++++
 drivers/char/lrng/lrng_chacha20.c   | 341 ++++++++++++++
 drivers/char/lrng/lrng_drbg.c       | 274 +++++++++++
 drivers/char/lrng/lrng_health.c     | 424 ++++++++++++++++++
 drivers/char/lrng/lrng_interfaces.c | 648 ++++++++++++++++++++++++++
 drivers/char/lrng/lrng_internal.h   | 322 +++++++++++++
 drivers/char/lrng/lrng_jent.c       | 101 +++++
 drivers/char/lrng/lrng_kcapi.c      | 341 ++++++++++++++
 drivers/char/lrng/lrng_numa.c       | 114 +++++
 drivers/char/lrng/lrng_pool.c       | 673 ++++++++++++++++++++++++++++
 drivers/char/lrng/lrng_proc.c       | 192 ++++++++
 drivers/char/lrng/lrng_sdrng.c      | 458 +++++++++++++++++++
 drivers/char/lrng/lrng_sw_noise.c   | 156 +++++++
 drivers/char/lrng/lrng_switch.c     | 198 ++++++++
 drivers/char/lrng/lrng_testing.c    | 324 +++++++++++++
 drivers/char/lrng/lrng_trng.c       | 301 +++++++++++++
 include/crypto/drbg.h               |   7 +
 include/linux/lrng.h                |  83 ++++
 26 files changed, 5437 insertions(+), 7 deletions(-)
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




