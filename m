Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3324326FA18
	for <lists+linux-api@lfdr.de>; Fri, 18 Sep 2020 12:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIRKMx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 18 Sep 2020 06:12:53 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.120]:27885 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgIRKMc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 Sep 2020 06:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1600423947;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=DMHKZsicW8J57ZVAm7eS8Pk1AaPGm2y2Hu+eXQ7v84A=;
        b=BND+Ihtic4qxubnYNucvdUim/8CtrdAU2woxTR/7SCbfYiqTmNeIkhv9zmxPAz2emu
        gZskX6mdCD+b6hJZilXpiwD2Zq5slY3T+WxSZUK1QBNAu6FzI3Ub/6mQL7I7kiA84w0D
        0Gj6w9vuKPtY0n9CfAYfObYjbfODElbtzEbx+Z1wfzuD6P86CIMYhHfql19H/e4qtkyp
        c3eHk54M4Lq1z/g01lfc1QyUxBPGMNfreNmWMZd3HV7JeBERIclrY8HkRk9IRarsBqn7
        rfG50kfxTiXJSXg8FEAFoCXbAytOzvlnyzk1Xi72as8ZSWjvx00mpHVVZc4aUj4bewOn
        ENCw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaJPScXyVH"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw8IA0N2TL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 18 Sep 2020 12:00:23 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>, ebiggers@kernel.org
Subject: [PATCH v35 00/13] /dev/random - a new approach
Date:   Fri, 18 Sep 2020 11:47:36 +0200
Message-ID: <5667034.lOV4Wx5bFT@positron.chronox.de>
In-Reply-To: <5532247.MhkbZ0Pkbq@positron.chronox.de>
References: <2544450.mvXUDI8C0e@positron.chronox.de> <5532247.MhkbZ0Pkbq@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

The following patch set provides a different approach to /dev/random which
is called Linux Random Number Generator (LRNG) to collect entropy within
the Linux kernel.

The following advantages compared to the existing /dev/random
implementation are present:

* Sole use of crypto for data processing:

 - exclusive use of a hash operation for conditioning entropy data with
   a clear mathematical description as given in [2] section 2.2 -
   non-cryptographic operations like LFSR are not used

 - accelerated SHA-512 and software SHA-256 hash are available - LRNG works
   even if the kernel crypto API is not compiled

 - hash operations use NUMA-node-local hash instances to benefit large
   parallel systems

 - runtime-switchable DRNG and hash implementations which allows
   the use of an SP800-90A DRBG or other types of DRNGs

* Performance

 - faster by up to 75% in the critical code path of the interrupt handler
   depending on data collection size configurable at kernel compile time -
   the default is about equal in performance with existing /dev/random

 - configurable data collection sizes to accommodate small environments and
   big environments

 - entropy collection using an almost never contended lock to benefit
   large parallel systems - worst case rate of contention is the number
   of DRNG reseeds, usually the number of potential contentions per 5
   minutes is equal to number of NUMA nodes.

 - ChaCha20 DRNG is significantly faster as implemented in random.c

 - faster entropy collection during boot time to reach fully seeded level,
   including on virtual systems or systems with SSDs

* Testing

 - heuristic entropy estimation is based on analysis following SP800-90B
   and not on coincidental underestimation of entropy

 - power-on self tests for critical deterministic components
   (ChaCha20 DRNG, hash, and entropy collection logic) not already
   covered by power-up tests of the kernel crypto API

 - availability of test interfaces for all operational stages of the LRNG
   including boot-time raw entropy event data sampling

 - fully testable ChaCha20 DRNG - see [3]

* Entropy collection

 - The LRNG is fully compliant to SP800-90B requirements and is shipped with
   a full SP800-90B assessment and all required test tools in [1]. The
   existing /dev/random implementation on the other hand has architectural
   limitations which does not easily allow to bring the implementation in
   compliance with SP800-90B. The existing /dev/random is not easily made
   compliant with SP800-90B as outlined in [2] section 4.5.

 - full entropy assessment and description provided with [2], specifically
   section 3.2.6

 - guarantee that entropy events are not credited with entropy twice
   (the existing /dev/random implementation credits HID/disk and interrupt
   events with entropy which are a derivative of each other) and
   guarantee that entropy data is not reused for two different use cases
   (as done in the existing /dev/random implementation when injecting a
   part of fast_pool into the net_rand_state)

The LRNG patch set allows a user to select use of the existing /dev/random
or the LRNG during compile time. As the LRNG provides API and ABI compatible
interfaces to the existing /dev/random implementation, the user can freely
chose the RNG implementation without affecting kernel or user space
operations.

=46or users that are not interested in SP800-90B, the entire code for the
compliance as well as test interfaces can be deselected at compile time.

The design and implementation is driven by a set of goals described in [2]
that the LRNG completely implements. Furthermore, [2] includes the full
assessment of the SP800-90B compliance as well as a comparison with RNG
design suggestions of SP800-90C, and AIS20/31.

The LRNG provides a complete separation of the noise source maintenance
and the collection of entropy into per-CPU entropy pools from the
post-processing using a pseudo-random number generator. Different
DRNGs are supported, including:

* Built-in ChaCha20 DRNG which has no dependency to other kernel
  frameworks.

* SP800-90A DRBG using the kernel crypto API including its accelerated
  raw cipher implementations. This implies that the output of /dev/random,
  getrandom(2), /dev/urandom or get_random_bytes is fully compliant to
  SP800-90A.

* Arbitrary DRNGs registered with the kernel crypto API

Booting the patch with the kernel command line option
"dyndbg=3Dfile drivers/char/lrng/* +p" generates logs indicating the
operation of the LRNG. Each log is pre-pended with "lrng".

The LRNG has a flexible design by allowing an easy replacement of the
deterministic random number generator component as well as hash
component.

=46ull SP800-90B testing is performed on the following systems - details
are given in [2] appendix C:

* x86 KVM virtualized guest 32 and 64 bit systems

* x86 bare metal

* older and newer ARMv7 system

* ARM64

* POWER7 LE and POWER 8 BE

* IBM Z System mainframe

* old MIPS embedded device

* testing with GCC and Clang

[1] https://www.chronox.de/lrng.html - If the patch is accepted, I would
be volunteering to convert the documentation into RST format and
contribute it to the Linux kernel documentation directory.

[2] https://www.chronox.de/lrng/doc/lrng.pdf

[3] https://www.chronox.de/chacha20_drng.html

Changes (compared to the previous patch set):

* replace hash_df operation with simple hash to make code leaner without
  affecting entropy statements

* replace central LFSR with per-CPU entropy pools which implies that
  LRNG only uses a hash for conditioning - this makes data processing
  much cleaner (see [2] section 2.2) entropy assessment significantly
  easier (see [2] section 3.2.6)

* add aux_pool to process data received from user space and
  add_hwgenerator_randomness with a cryptographic hash compliant to
  SP800-90B section 3.1.6 to allow data from those sources and stay
  SP800-90B compliant

* remove duplicated code - add lrng_kcapi_hash.c to consolidate hash
  handling code from lrng_drbg.c and lrng_kcapi.c

* ensure that the NUMA pool allocation also allocates the hash instance
  as a precaution in case the DRNG switching code is executed before
  the NUMA allocation

* Make invocation of SHA-1 compliant to FIPS 180-4

* Addition of test interface for interrupt registers noise data -
  with that interface, all data potentially delivering entropy can be
  sampled.

* Addition of ACVT interface to validate correct invocation of SHA by
  LRNG (for test definition, see https://github.com/usnistgov/ACVP) -
  interface was used for successful testing of the SHA-256 and SHA-1
  handling of the LRNG.

* remove superfluous backslash from Makefile reported by
  Andy Lavr <andy.lavr@gmail.com>

* move prototype of lrng_reset() to a spot in lrng_internal.h that is
  compiled unconditional as requested by kernel test robot
  <lkp@intel.com>

* correctly advance *ppos in DebugFS read function for testing interfaces
  preventing successive read operations

* fix __latent_entropy usage as reported by kernel test robot
  <lkp@intel.com>

* use compxch_release / smp_load_acquire to set NUMA pool as suggested
  by Eric Biggers

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
CC: Eric Biggers <ebiggers@kernel.org>
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>

Stephan Mueller (13):
  Linux Random Number Generator
  LRNG - allocate one DRNG instance per NUMA node
  LRNG - sysctls and /proc interface
  LRNG - add switchable DRNG support
  LRNG - add common generic hash support
  crypto: DRBG - externalize DRBG functions for LRNG
  LRNG - add SP800-90A DRBG extension
  LRNG - add kernel crypto API PRNG extension
  crypto: provide access to a static Jitter RNG state
  LRNG - add Jitter RNG fast noise source
  LRNG - add SP800-90B compliant health tests
  LRNG - add interface for gathering of raw entropy
  LRNG - add power-on and runtime self-tests

 MAINTAINERS                                   |   7 +
 crypto/drbg.c                                 |  16 +-
 crypto/jitterentropy-kcapi.c                  |   3 +-
 crypto/jitterentropy.c                        |  31 +-
 drivers/char/Kconfig                          |   2 +
 drivers/char/Makefile                         |   9 +-
 drivers/char/lrng/Kconfig                     | 353 +++++++++
 drivers/char/lrng/Makefile                    |  20 +
 drivers/char/lrng/lrng_archrandom.c           |  93 +++
 drivers/char/lrng/lrng_aux.c                  | 136 ++++
 drivers/char/lrng/lrng_chacha20.c             | 352 +++++++++
 drivers/char/lrng/lrng_chacha20.h             |  29 +
 drivers/char/lrng/lrng_drbg.c                 | 197 +++++
 drivers/char/lrng/lrng_drng.c                 | 406 +++++++++++
 drivers/char/lrng/lrng_health.c               | 407 +++++++++++
 drivers/char/lrng/lrng_interfaces.c           | 649 +++++++++++++++++
 drivers/char/lrng/lrng_internal.h             | 426 +++++++++++
 drivers/char/lrng/lrng_jent.c                 |  88 +++
 drivers/char/lrng/lrng_kcapi.c                | 228 ++++++
 drivers/char/lrng/lrng_kcapi_hash.c           |  97 +++
 drivers/char/lrng/lrng_kcapi_hash.h           |  19 +
 drivers/char/lrng/lrng_numa.c                 | 108 +++
 drivers/char/lrng/lrng_pool.c                 | 478 ++++++++++++
 drivers/char/lrng/lrng_proc.c                 | 181 +++++
 drivers/char/lrng/lrng_selftest.c             | 344 +++++++++
 drivers/char/lrng/lrng_sw_noise.c             | 461 ++++++++++++
 drivers/char/lrng/lrng_sw_noise.h             |  56 ++
 drivers/char/lrng/lrng_switch.c               | 203 ++++++
 drivers/char/lrng/lrng_testing.c              | 687 ++++++++++++++++++
 include/crypto/drbg.h                         |   7 +
 .../crypto/internal}/jitterentropy.h          |   3 +
 include/linux/lrng.h                          |  79 ++
 32 files changed, 6165 insertions(+), 10 deletions(-)
 create mode 100644 drivers/char/lrng/Kconfig
 create mode 100644 drivers/char/lrng/Makefile
 create mode 100644 drivers/char/lrng/lrng_archrandom.c
 create mode 100644 drivers/char/lrng/lrng_aux.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.h
 create mode 100644 drivers/char/lrng/lrng_drbg.c
 create mode 100644 drivers/char/lrng/lrng_drng.c
 create mode 100644 drivers/char/lrng/lrng_health.c
 create mode 100644 drivers/char/lrng/lrng_interfaces.c
 create mode 100644 drivers/char/lrng/lrng_internal.h
 create mode 100644 drivers/char/lrng/lrng_jent.c
 create mode 100644 drivers/char/lrng/lrng_kcapi.c
 create mode 100644 drivers/char/lrng/lrng_kcapi_hash.c
 create mode 100644 drivers/char/lrng/lrng_kcapi_hash.h
 create mode 100644 drivers/char/lrng/lrng_numa.c
 create mode 100644 drivers/char/lrng/lrng_pool.c
 create mode 100644 drivers/char/lrng/lrng_proc.c
 create mode 100644 drivers/char/lrng/lrng_selftest.c
 create mode 100644 drivers/char/lrng/lrng_sw_noise.c
 create mode 100644 drivers/char/lrng/lrng_sw_noise.h
 create mode 100644 drivers/char/lrng/lrng_switch.c
 create mode 100644 drivers/char/lrng/lrng_testing.c
 rename {crypto =3D> include/crypto/internal}/jitterentropy.h (84%)
 create mode 100644 include/linux/lrng.h

=2D-=20
2.26.2




