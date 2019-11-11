Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BAEF7FD7
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 20:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKKTZz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 14:25:55 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.123]:36705 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfKKTZz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 14:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573500327;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rLoMZFHRYbptlPWn+PzR2JCTewNQ+U+uLawIuIPI3Bk=;
        b=ZgSceS7/+34L2DmvZEiI96gFIECuuRK+HiYc5j5S4xrOGdhxrcEWxaMTMNL0TNHeZp
        2Y8iJDMgmecU98jYLR/UI7P7j5ao0urqBEjORMU7fVdMgQmeS75W/53Yb3zNE4qZgXwH
        fuRBfbeltE2JrVj9k4ZTTirXiDhnQkzLWV+vPpeqx1F49Eh/ZV1nCumJ4ASihxjwu3Pa
        Yn/VLCMydZ3yA3rv709WtEvtxNJ04VfluzyP2MLR1D+gpJD/YISOgIrbfNqqpDpKcy8F
        lFb5Jlak6yYDpbAjgCE0qUnv/0nNHqoa0HyprIHFHtoeBdSwM3ww21avvMTol+O/SM+U
        65OQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmgLKehaO2hZDSTWbgzIOA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id N09a57vABJDK3Xc
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 11 Nov 2019 20:13:20 +0100 (CET)
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
        Neil Horman <nhorman@redhat.com>
Subject: [PATCH v24 01/12] Linux Random Number Generator
Date:   Mon, 11 Nov 2019 19:18:33 +0100
Message-ID: <2369119.jSEA3qhmGI@positron.chronox.de>
In-Reply-To: <6157374.ptSnyUpaCn@positron.chronox.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In an effort to provide a flexible implementation for a random number
generator that also delivers entropy during early boot time, allows
replacement of the deterministic random number generation mechanism,
implement the various components in separate code for easier
maintenance, and provide compliance to SP800-90[A|B|C], introduce
the Linux Random Number Generator (LRNG) framework.

The general design is as follows. Additional implementation details
are given in [1]. The LRNG consists of the following components:

1. The LRNG may contain a True Random Number Generator (TRNG). The
TRNG is a deterministic random number generator that is operated as
a true random number generator. Using SP800-90A terminology, the
TRNG is a DRBG with prediction resistance. The TRNG has a behavior
similar to SP800-90A's concept of prediction resistance by only
generating output when it is re-seeded with an equal amount of
entropy. Every time a caller requests random numbers, the TRNG
must be re-seeded with at least that amount of entropy from its noise
sources. During boot time, the TRNG is not yet operated with
prediction resistance. As the external interfaces to the TRNG to
obtain random numbers start to be accessible after boot time
completes, random numbers generated via these interfaces always
access the TRNG that is operated with prediction resistance.

2. The LRNG implements a secondary DRNG. The secondary DRNG always
generates the requested amount of output. When using the SP800-90A
terminology it operates without prediction resistance. The secondary
DRNG maintains a counter of how many bytes were generated since last
re-seed and a timer of the elapsed time since last re-seed. If either
the counter or the timer reaches a threshold, the secondary DRNG is
seeded from the TRNG.

In case the Linux kernel detects a NUMA system, one secondary DRNG
instance per NUMA node is maintained.

3. The TRNG is seeded by concatenating the data from the
following sources:

(a) the output of the entropy pool,

(b) the Jitter RNG if available and enabled, and

(c) the CPU-based noise source such as Intel RDRAND if available and
enabled.

The entropy estimate of the data of all noise sources are added to
form the entropy estimate of the data used to seed the TRNG with.
The LRNG ensures, however, that the TRNG after seeding is at
maximum the security strength of the TRNG.

The LRNG is designed such that none of these noise sources can dominate
the other noise sources to provide seed data to the TRNG during
boot time due to the following:

(a) During boot time, the amount of received interrupts are the trigger
points to (re)seed the TRNG.

(b) At runtime, the caller requesting random numbers from the primary
TRNG drives the reseeding where always as much entropy as available is
used to reseed the TRNG.

4. The entropy pool accumulates entropy obtained from certain events,
which will henceforth be collectively called "slow noise sources".
The entropy pool collects noise data from slow noise sources. Any data
received by the LRNG from the slow noise sources is inserted into the
entropy pool using an LFSR with a primitive and irreducible polynomial.
The following sources of entropy are used:

 (a) When an interrupt occurs, the high-resolution time stamp is mixed
into the LFSR. This time stamp is credited with heuristically implied
entropy.

 (b) HID event data like the key stroke or the mouse coordinates are
mixed into the LFSR. This data is not credited with entropy by the LRNG.

 (c) Device drivers may provide data that is mixed into the LFSR. This
data is not credited with entropy by the LRNG.

 (d) After the entropy pool is ``read'' by the TRNG, the data
used to seed the TRNG is mixed back into the entropy pool to
stir the pool. This data is not credited with entropy by the LRNG.

Any data provided from user space by either writing to /dev/random,
/dev/urandom or the IOCTL of RNDADDENTROPY on both device files
are always injected into the entropy pool.

In addition, when a hardware random number generator covered by the
Linux kernel HW generator framework wants to deliver random numbers,
it is injected into the entropy pool as well. HW generator noise source
is handled separately from the other noise source due to the fact that
the HW generator framework may decide by itself when to deliver data
whereas the other noise sources always requested for data driven by the
LRNG operation. Similarly any user space provided data is inserted into
the entropy pool.

When the TRNG requires data from the entropy pool, the entire
entropy pool is processed with an SP800-90A section 10.3.1 compliant
hash_df function to generate random numbers.

To speed up the interrupt handling code of the LRNG, the time stamp
collected for an interrupt event is truncated to the 8 least
significant bits. 64 truncated time stamps are concatenated and then
jointly inserted into the LFSR. During boot time, until the fully seeded
stage is reached, each time stamp with its 32 least significant bits is
inserted into the LFSR at the time of arrival.

The LRNG allows the TRNG and secondary DRNG mechanism to be changed
at runtime. Per default, a ChaCha20-based DRNG is used. The ChaCha20-DRNG
implemented for the LRNG is also provided as a stand-alone user space
deterministic random number generator. The LRNG also offers an
SP800-90A DRBG based on the Linux kernel crypto API DRBG implementation.

The DRNG allows two methods of obtaining random data:

* For users requiring random numbers from a seeded and frequently reseeded
secondary DRNG, such as the /dev/urandom, the getrandom system call or
the in-kernel get_random_bytes function, the secondary DRNG is accessed
directly by invoking its generate function. This generate function
complies with the generate function discussed in SP800-90A.

* Users requiring random data that contains information theoretical
entropy, such as for seeding other DRNGs also use the TRNG's
generate function via the /dev/random device file and the getrandom
system call when invoked with GRND_RANDOM. The difference to the
/dev/urandom handling is that:

 1. each TRNG generate request is limited to the amount of entropy
the of the DRNG was seeded with, and

 2. each TRNG generate request is preceded by a reseeding of the
DRNG to implement a TRNG / a DRNG with prediction resistance.

The processing of entropic data from the noise source before injecting
them into the TRNG is performed with the following mathematical
operations:

1. LFSR: The 8 least significant bits of the time stamp data received
from the interrupts are processed with an LFSR. That LFSR is implemented
identically to the LSFR used in the existing /dev/random implementation
except that it is capable of processing an entire word and that a
different polynomial is used. The reason for the different polynomial
is performance in a performance sensitive code section, the interrupt
handler. The chosen polynomials have 4 taps. Also, this LFSR-approach
is used in the OpenBSD /dev/random equivalent.

2. Concatenation: The temporary seed buffer used to seed the TRNG is
a concatenation of parts of the entropy pool data, and the CPU noise
source output.

The TRNG always tries to seed itself with 256 bits of entropy,
except during boot. In any case, if the noise sources cannot deliver
that amount, the available entropy is used and the TRNG keeps
track on how much entropy it was seeded with. The entropy implied by
the LRNG available in the entropy pool may be too conservative.
To ensure that during boot time all available entropy from the entropy
pool is transferred to the TRNG, the hash_df function always
generates 256 data bits during boot to seed the TRNG. Yet, the
TRNG entropy estimate is only increased by the amount of entropy the
LRNG assumes to be present in that data. During boot, the TRNG
is seeded as follows:

1. The DRNG is reseeded from the entropy pool and potentially the fast
noise sources if the entropy pool has collected at least 32 bits of
entropy from the interrupt noise source. The goal of this step is to
ensure that the primary and secondary DRNG receive some initial entropy
as early as possible. In addition it receives the entropy available from
the fast noise sources.

2. The DRNG is reseeded from the entropy pool and potentially the fast
noise sources if all noise sources collectively can provide at least
128 bits of entropy.

3. The DRNG is reseeded from the entropy pool and potentially the fast
noise sources if all noise sources collectivel can provide at least 256
bits.

At the time of the reseeding steps, the DRNG requests as much entropy as
is available in order to skip certain steps and reach the seeding level
of 256 bits. This may imply that one or more of the aforementioned steps
are skipped.

In all listed steps, the secondary DRNG is (re)seeded with a number of
random bytes from the TRNG that is equal to the amount of
entropy the TRNG was seeded with. This means that when the
TRNG is seeded with 128 or 256 bits of entropy, the secondary
DRNG is seeded with that amount of entropy as well. There is only one
exception to that rule: during initialization before the seed level of
128 bits is reached, a random number with 128 bit is generated by the
TRNG to seed the secondary DRNG.

Before the TRNG is seeded with 256 bits of entropy in step 3,
requests of random data from /dev/random are not processed.

At runtime, the TRNG delivers only random bytes equal to the
entropy amount it was seeded with. E.g. if the TRNG was seeded
with 128 bits of entropy, it will return only 128 bits of random data.
Subsequent requests for random data are only fulfilled after a
reseeding operation of the TRNG.

The TRNG will always require that all entropy sources collectively
can deliver at least as many entropy bits as configured with
/proc/sys/kernel/random/read_wakeup_threshold, i.e. per default 129 bits
(128 bits of entropy for seeding plus one bit of entropy that is lost
with the post processing as defined in SP800-90B).

The secondary DRNG operates as deterministic random number generator with
the following properties:

* The maximum number of random bytes that can be generated with one
DRNG generate operation is limited to 4096 bytes. When longer random
numbers are requested, multiple DRNG generate operations are performed.
The ChaCha20 DRNG as well as the SP800-90A DRBGs implement an update of
their state after completing a generate request for backtracking
resistance.

* The secondary DRNG is reseeded with whatever entropy is available =E2=80=
=93
in the worst case where no additional entropy can be provided by the
noise sources, the DRNG is not re-seeded and continues its operation
to try to reseed again after again the expiry of one of these thresholds:

 - If the last reseeding of the secondary DRNG is more than 600 seconds
   ago, or

 - 2^20 DRNG generate operations are performed, whatever comes first, or

 - the secondary DRNG is forced to reseed before the next generation of
   random numbers if data has been injected into the LRNG by writing data
   into /dev/random or /dev/urandom.

The chosen values prevent high-volume requests from user space to cause
frequent reseeding operations which drag down the performance of the
DRNG.

When the secondary DRNG requests a reseeding from the TRNG and
the TRNG pulls from the entropy pool, an emergency entropy level
of 512 bits of entropy is left in the entropy pool. This emergency
entropy is provided to serve /dev/random even while /dev/urandom is
stressed.

With the automatic reseeding after 600 seconds, the LRNG is triggered
to reseed itself before the first request after a suspend that put the
hardware to sleep for longer than 600 seconds.

The TRNG may not be compiled. In this case, the aforementioned
statements covering the TRNG are not applicable. The secondary DRNG is
seeded directly from the entropy pool just like the TRNG would have been
seeded.

The LRNG has the following properties:

* internal noise source: interrupts timing with fast boot time seeding

* high performance of interrupt handling code: The LRNG impact on the
interrupt handling has been reduced to a minimum. On one example
system, the LRNG interrupt handling code executes within an average
of 65 cycles whereas the existing /dev/random on the same device
takes about 97 cycles when measuring the execution time of
add_interrupt_randomness().

* lockless LFSR to collect raw entropy

* use of standalone ChaCha20 based RNG with the option to use a
  different DRNG selectable at compile time

* "atomic" seeding of secondary DRBG to ensure full entropy transport

* instantiate one DRNG per NUMA node

* support for runtime switchable output DRNGs

* support for TRNG deactivation: The LRNG supports the compile-time
deactivation of the TRNG (i.e. the blocking behavior of /dev/random).
If deactivated, /dev/random operates like getrandom(2). This is
intended to cover the recent discussions about removing the
blocking_pool from the existing random.c.

* use of only well-defined entropy-preserving operations to collect,
compress and forward entropy: concatenation, LFSR, SP800-90A hash_df
function

* compile-time selectable entropy pool size: the choice also
uses the applicable LFSR polynomial to maintain the entropy pool
size

=46urther details including the rationale for the design choices and
properties of the LRNG together with testing is provided at [1].
In addition, the documentation explains the conducted regression
tests to verify that the LRNG is API and ABI compatible with the
existing /dev/random implementation.

[1] https://www.chronox.de/lrng.html

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
Mathematical aspects Reviewed-by: "Peter, Matthias" <matthias.peter@bsi.bun=
d.de>
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Roman Drahtm=C3=BCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 MAINTAINERS                         |   7 +
 drivers/char/Kconfig                |   2 +
 drivers/char/Makefile               |   9 +-
 drivers/char/lrng/Kconfig           |  55 +++
 drivers/char/lrng/Makefile          |   9 +
 drivers/char/lrng/lrng_archrandom.c | 105 +++++
 drivers/char/lrng/lrng_aux.c        | 161 +++++++
 drivers/char/lrng/lrng_chacha20.c   | 341 ++++++++++++++
 drivers/char/lrng/lrng_interfaces.c | 649 +++++++++++++++++++++++++++
 drivers/char/lrng/lrng_internal.h   | 313 +++++++++++++
 drivers/char/lrng/lrng_pool.c       | 673 ++++++++++++++++++++++++++++
 drivers/char/lrng/lrng_sdrng.c      | 458 +++++++++++++++++++
 drivers/char/lrng/lrng_sw_noise.c   | 156 +++++++
 include/linux/lrng.h                |  83 ++++
 14 files changed, 3020 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/lrng/Kconfig
 create mode 100644 drivers/char/lrng/Makefile
 create mode 100644 drivers/char/lrng/lrng_archrandom.c
 create mode 100644 drivers/char/lrng/lrng_aux.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.c
 create mode 100644 drivers/char/lrng/lrng_interfaces.c
 create mode 100644 drivers/char/lrng/lrng_internal.h
 create mode 100644 drivers/char/lrng/lrng_pool.c
 create mode 100644 drivers/char/lrng/lrng_sdrng.c
 create mode 100644 drivers/char/lrng/lrng_sw_noise.c
 create mode 100644 include/linux/lrng.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095547fd..7232989d3a1c 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9488,6 +9488,13 @@ F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/memory-barriers.txt
=20
+LINUX RANDOM NUMBER GENERATOR (LRNG) DRIVER
+M:	Stephan Mueller <smueller@chronox.de>
+S:	Maintained
+W:	https://www.chronox.de/lrng.html
+F:	drivers/char/lrng/*
+F:	include/linux/lrng.h
+
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index df0fc997dc3e..cebb3a62c2ca 100644
=2D-- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -535,6 +535,8 @@ config ADI
 	  and SSM (Silicon Secured Memory).  Intended consumers of this
 	  driver include crash and makedumpfile.
=20
+source "drivers/char/lrng/Kconfig"
+
 endmenu
=20
 config RANDOM_TRUST_CPU
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 7c5ea6f9df14..46ede09fd6d3 100644
=2D-- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -3,7 +3,14 @@
 # Makefile for the kernel character device drivers.
 #
=20
=2Dobj-y				+=3D mem.o random.o
+obj-y				+=3D mem.o
+
+ifeq ($(CONFIG_LRNG),y)
+  obj-y				+=3D lrng/
+else
+  obj-y				+=3D random.o
+endif
+
 obj-$(CONFIG_TTY_PRINTK)	+=3D ttyprintk.o
 obj-y				+=3D misc.o
 obj-$(CONFIG_ATARI_DSP56K)	+=3D dsp56k.o
diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
new file mode 100644
index 000000000000..edf8be6aa0b1
=2D-- /dev/null
+++ b/drivers/char/lrng/Kconfig
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Linux Random Number Generator configuration
+#
+
+menuconfig LRNG
+	bool "Linux Random Number Generator"
+	help
+	  The Linux Random Number Generator (LRNG) is the replacement
+	  of the existing /dev/random provided with drivers/char/random.c.
+	  It generates entropy from different noise sources and
+	  delivers significant entropy during boot.
+
+if LRNG
+
+choice
+	prompt "LRNG Entropy Pool Size"
+	default LRNG_POOL_SIZE_4096
+	help
+	  Select the size of the LRNG entropy pool. The size of the
+	  entropy pool is relevant for the amount of entropy that
+	  the LRNG can maintain as a maximum. The larger the size
+	  of the entropy pool is the more entropy can be maintained
+	  but the less often older entropic values are overwritten
+	  with new entropy.
+
+	config LRNG_POOL_SIZE_4096
+		bool "4096 bits (default)"
+
+	config LRNG_POOL_SIZE_8192
+		bool "8192 bits"
+
+	config LRNG_POOL_SIZE_16384
+		bool "16384 bits"
+
+	config LRNG_POOL_SIZE_32768
+		bool "32768 bits"
+
+	config LRNG_POOL_SIZE_65536
+		bool "65536 bits"
+
+	config LRNG_POOL_SIZE_131072
+		bool "131072 bits"
+endchoice
+
+config LRNG_POOL_SIZE
+	int
+	default 0 if LRNG_POOL_SIZE_4096
+	default 1 if LRNG_POOL_SIZE_8192
+	default 2 if LRNG_POOL_SIZE_16384
+	default 3 if LRNG_POOL_SIZE_32768
+	default 4 if LRNG_POOL_SIZE_65536
+	default 5 if LRNG_POOL_SIZE_131072
+
+endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
new file mode 100644
index 000000000000..2761623715d2
=2D-- /dev/null
+++ b/drivers/char/lrng/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Linux Random Number Generator.
+#
+
+obj-y				+=3D lrng_pool.o lrng_aux.o \
+				   lrng_sw_noise.o lrng_archrandom.o \
+				   lrng_sdrng.o lrng_chacha20.o \
+				   lrng_interfaces.o \
diff --git a/drivers/char/lrng/lrng_archrandom.c b/drivers/char/lrng/lrng_a=
rchrandom.c
new file mode 100644
index 000000000000..c448f4827794
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_archrandom.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Fast Noise Source: CPU-based noise source
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+
+/*
+ * Estimated entropy of data is a 32th of LRNG_DRNG_SECURITY_STRENGTH_BITS.
+ * As we have no ability to review the implementation of those noise sourc=
es,
+ * it is prudent to have a conservative estimate here.
+ */
+#define LRNG_ARCHRANDOM_DEFAULT_STRENGTH (LRNG_DRNG_SECURITY_STRENGTH_BITS=
>>5)
+#define LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH LRNG_DRNG_SECURITY_STRENGTH_BITS
+#ifdef CONFIG_RANDOM_TRUST_CPU
+static u32 archrandom =3D LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH;
+#else
+static u32 archrandom =3D LRNG_ARCHRANDOM_DEFAULT_STRENGTH;
+#endif
+module_param(archrandom, uint, 0644);
+MODULE_PARM_DESC(archrandom, "Entropy in bits of 256 data bits from CPU no=
ise "
+			     "source (e.g. RDRAND)");
+
+static int __init lrng_parse_trust_cpu(char *arg)
+{
+	int ret;
+	bool trust_cpu =3D false;
+
+	ret =3D kstrtobool(arg, &trust_cpu);
+	if (ret)
+		return ret;
+
+	if (trust_cpu)
+		archrandom =3D LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH;
+	else
+		archrandom =3D LRNG_ARCHRANDOM_DEFAULT_STRENGTH;
+
+	return 0;
+}
+early_param("random.trust_cpu", lrng_parse_trust_cpu);
+
+/**
+ * Get CPU noise source entropy
+ *
+ * @outbuf: buffer to store entropy of size LRNG_DRNG_SECURITY_STRENGTH_BY=
TES
+ * @return: > 0 on success where value provides the added entropy in bits
+ *	    0 if no fast source was available
+ */
+u32 lrng_get_arch(u8 *outbuf)
+{
+	u32 i, ent_bits =3D archrandom;
+
+	/* operate on full blocks */
+	BUILD_BUG_ON(LRNG_DRNG_SECURITY_STRENGTH_BYTES % sizeof(unsigned long));
+	/* ensure we have aligned buffers */
+	BUILD_BUG_ON(LRNG_KCAPI_ALIGN % sizeof(unsigned long));
+
+	if (!ent_bits)
+		return 0;
+
+	for (i =3D 0; i < LRNG_DRNG_SECURITY_STRENGTH_BYTES;
+	     i +=3D sizeof(unsigned long)) {
+		if (!arch_get_random_seed_long((unsigned long *)(outbuf + i)) &&
+		    !arch_get_random_long((unsigned long *)(outbuf + i))) {
+			archrandom =3D 0;
+			return 0;
+		}
+	}
+
+	/* Obtain entropy statement -- cap entropy to buffer size in bits */
+	ent_bits =3D min_t(u32, ent_bits, LRNG_DRNG_SECURITY_STRENGTH_BITS);
+	pr_debug("obtained %u bits of entropy from CPU RNG noise source\n",
+		 ent_bits);
+	return ent_bits;
+}
+
+u32 lrng_slow_noise_req_entropy(u32 required_entropy_bits)
+{
+	u32 arch_ent_bits =3D min_t(u32, archrandom,
+				  LRNG_DRNG_SECURITY_STRENGTH_BITS);
+	u32 fast_noise_entropy =3D arch_ent_bits + lrng_jent_entropylevel();
+
+	if (fast_noise_entropy > required_entropy_bits)
+		return 0;
+	return (required_entropy_bits - fast_noise_entropy);
+}
diff --git a/drivers/char/lrng/lrng_aux.c b/drivers/char/lrng/lrng_aux.c
new file mode 100644
index 000000000000..28120b48e914
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_aux.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG auxiliary interfaces
+ *
+ * Copyright (C) 2019 Stephan Mueller <smueller@chronox.de>
+ * Copyright (C) 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All
+ * Rights Reserved.
+ * Copyright (C) 2016 Jason Cooper <jason@lakedaemon.net>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#include <linux/mm.h>
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+
+struct batched_entropy {
+	union {
+		u64 entropy_u64[LRNG_DRNG_BLOCKSIZE / sizeof(u64)];
+		u32 entropy_u32[LRNG_DRNG_BLOCKSIZE / sizeof(u32)];
+	};
+	unsigned int position;
+	spinlock_t batch_lock;
+};
+
+/*
+ * Get a random word for internal kernel use only. The quality of the rand=
om
+ * number is either as good as RDRAND or as good as /dev/urandom, with the
+ * goal of being quite fast and not depleting entropy.
+ */
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) =3D {
+	.batch_lock	=3D __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+};
+
+u64 get_random_u64(void)
+{
+	u64 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+
+#if BITS_PER_LONG =3D=3D 64
+	if (arch_get_random_long((unsigned long *)&ret))
+		return ret;
+#else
+	if (arch_get_random_long((unsigned long *)&ret) &&
+	    arch_get_random_long((unsigned long *)&ret + 1))
+		return ret;
+#endif
+
+	lrng_debug_report_seedlevel("get_random_u64");
+
+	batch =3D raw_cpu_ptr(&batched_entropy_u64);
+	spin_lock_irqsave(&batch->batch_lock, flags);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u64) =3D=3D 0) {
+		lrng_sdrng_get_atomic((u8 *)batch->entropy_u64,
+				      LRNG_DRNG_BLOCKSIZE);
+		batch->position =3D 0;
+	}
+	ret =3D batch->entropy_u64[batch->position++];
+	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u64);
+
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) =3D {
+	.batch_lock	=3D __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
+};
+
+u32 get_random_u32(void)
+{
+	u32 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+
+	if (arch_get_random_int(&ret))
+		return ret;
+
+	lrng_debug_report_seedlevel("get_random_u32");
+
+	batch =3D raw_cpu_ptr(&batched_entropy_u32);
+	spin_lock_irqsave(&batch->batch_lock, flags);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u32) =3D=3D 0) {
+		lrng_sdrng_get_atomic((u8 *)batch->entropy_u32,
+				      LRNG_DRNG_BLOCKSIZE);
+		batch->position =3D 0;
+	}
+	ret =3D batch->entropy_u32[batch->position++];
+	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u32);
+
+/*
+ * It's important to invalidate all potential batched entropy that might
+ * be stored before the crng is initialized, which we can do lazily by
+ * simply resetting the counter to zero so that it's re-extracted on the
+ * next usage.
+ */
+void invalidate_batched_entropy(void)
+{
+	int cpu;
+	unsigned long flags;
+
+	for_each_possible_cpu(cpu) {
+		struct batched_entropy *batched_entropy;
+
+		batched_entropy =3D per_cpu_ptr(&batched_entropy_u32, cpu);
+		spin_lock_irqsave(&batched_entropy->batch_lock, flags);
+		batched_entropy->position =3D 0;
+		spin_unlock(&batched_entropy->batch_lock);
+
+		batched_entropy =3D per_cpu_ptr(&batched_entropy_u64, cpu);
+		spin_lock(&batched_entropy->batch_lock);
+		batched_entropy->position =3D 0;
+		spin_unlock_irqrestore(&batched_entropy->batch_lock, flags);
+	}
+}
+
+/**
+ * randomize_page - Generate a random, page aligned address
+ * @start:	The smallest acceptable address the caller will take.
+ * @range:	The size of the area, starting at @start, within which the
+ *		random address must fall.
+ *
+ * If @start + @range would overflow, @range is capped.
+ *
+ * NOTE: Historical use of randomize_range, which this replaces, presumed =
that
+ * @start was already page aligned.  We now align it regardless.
+ *
+ * Return: A page aligned address within [start, start + range).  On error,
+ * @start is returned.
+ */
+unsigned long randomize_page(unsigned long start, unsigned long range)
+{
+	if (!PAGE_ALIGNED(start)) {
+		range -=3D PAGE_ALIGN(start) - start;
+		start =3D PAGE_ALIGN(start);
+	}
+
+	if (start > ULONG_MAX - range)
+		range =3D ULONG_MAX - start;
+
+	range >>=3D PAGE_SHIFT;
+
+	if (range =3D=3D 0)
+		return start;
+
+	return start + (get_random_long() % range << PAGE_SHIFT);
+}
diff --git a/drivers/char/lrng/lrng_chacha20.c b/drivers/char/lrng/lrng_cha=
cha20.c
new file mode 100644
index 000000000000..aa8121fe88db
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_chacha20.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Backend for the LRNG providing the cryptographic primitives using
+ * ChaCha20 cipher implementations.
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/chacha.h>
+#include <linux/cryptohash.h>
+#include <linux/lrng.h>
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+
+/******************************* ChaCha20 DRNG ***************************=
****/
+
+/* State according to RFC 7539 section 2.3 */
+struct chacha20_block {
+	u32 constants[4];
+#define CHACHA_KEY_SIZE_WORDS (CHACHA_KEY_SIZE / sizeof(u32))
+	union {
+		u32 u[CHACHA_KEY_SIZE_WORDS];
+		u8  b[CHACHA_KEY_SIZE];
+	} key;
+	u32 counter;
+	u32 nonce[3];
+};
+
+#define CHACHA_BLOCK_WORDS	(CHACHA_BLOCK_SIZE / sizeof(u32))
+
+struct chacha20_state {
+	struct chacha20_block block;
+};
+
+/*
+ * Have two static memory blocks for two ChaCha20 DRNG instances (the prim=
ary
+ * and the secondary DRNG) to avoid calling kmalloc too early in the boot =
cycle.
+ * for subsequent allocation requests, such as per-NUMA-node DRNG instance=
s,
+ * kmalloc will be used.
+ */
+struct chacha20_state primary_chacha20;
+struct chacha20_state secondary_chacha20;
+
+/**
+ * Update of the ChaCha20 state by either using an unused buffer part or by
+ * generating one ChaCha20 block which is half of the state of the ChaCha2=
0.
+ * The block is XORed into the key part of the state. This shall ensure
+ * backtracking resistance as well as a proper mix of the ChaCha20 state o=
nce
+ * the key is injected.
+ */
+static void lrng_chacha20_update(struct chacha20_state *chacha20_state,
+				 u32 *buf, u32 used_words)
+{
+	struct chacha20_block *chacha20 =3D &chacha20_state->block;
+	u32 i, tmp[CHACHA_BLOCK_WORDS];
+
+	BUILD_BUG_ON(sizeof(struct chacha20_block) !=3D CHACHA_BLOCK_SIZE);
+	BUILD_BUG_ON(CHACHA_BLOCK_SIZE !=3D 2 * CHACHA_KEY_SIZE);
+
+	if (used_words > CHACHA_KEY_SIZE_WORDS) {
+		chacha20_block(&chacha20->constants[0], (u8 *)tmp);
+		for (i =3D 0; i < CHACHA_KEY_SIZE_WORDS; i++)
+			chacha20->key.u[i] ^=3D tmp[i];
+		memzero_explicit(tmp, sizeof(tmp));
+	} else {
+		for (i =3D 0; i < CHACHA_KEY_SIZE_WORDS; i++)
+			chacha20->key.u[i] ^=3D buf[i + used_words];
+	}
+
+	/* Deterministic increment of nonce as required in RFC 7539 chapter 4 */
+	chacha20->nonce[0]++;
+	if (chacha20->nonce[0] =3D=3D 0)
+		chacha20->nonce[1]++;
+	if (chacha20->nonce[1] =3D=3D 0)
+		chacha20->nonce[2]++;
+
+	/* Leave counter untouched as it is start value is undefined in RFC */
+}
+
+/**
+ * Seed the ChaCha20 DRNG by injecting the input data into the key part of
+ * the ChaCha20 state. If the input data is longer than the ChaCha20 key s=
ize,
+ * perform a ChaCha20 operation after processing of key size input data.
+ * This operation shall spread out the entropy into the ChaCha20 state bef=
ore
+ * new entropy is injected into the key part.
+ */
+static int lrng_cc20_drng_seed_helper(void *drng, const u8 *inbuf, u32 inb=
uflen)
+{
+	struct chacha20_state *chacha20_state =3D (struct chacha20_state *)drng;
+	struct chacha20_block *chacha20 =3D &chacha20_state->block;
+
+	while (inbuflen) {
+		u32 i, todo =3D min_t(u32, inbuflen, CHACHA_KEY_SIZE);
+
+		for (i =3D 0; i < todo; i++)
+			chacha20->key.b[i] ^=3D inbuf[i];
+
+		/* Break potential dependencies between the inbuf key blocks */
+		lrng_chacha20_update(chacha20_state, NULL,
+				     CHACHA_BLOCK_WORDS);
+		inbuf +=3D todo;
+		inbuflen -=3D todo;
+	}
+
+	return 0;
+}
+
+/**
+ * Chacha20 DRNG generation of random numbers: the stream output of ChaCha=
20
+ * is the random number. After the completion of the generation of the
+ * stream, the entire ChaCha20 state is updated.
+ *
+ * Note, as the ChaCha20 implements a 32 bit counter, we must ensure
+ * that this function is only invoked for at most 2^32 - 1 ChaCha20 blocks
+ * before a reseed or an update happens. This is ensured by the variable
+ * outbuflen which is a 32 bit integer defining the number of bytes to be
+ * generated by the ChaCha20 DRNG. At the end of this function, an update
+ * operation is invoked which implies that the 32 bit counter will never be
+ * overflown in this implementation.
+ */
+static int lrng_cc20_drng_generate_helper(void *drng, u8 *outbuf, u32 outb=
uflen)
+{
+	struct chacha20_state *chacha20_state =3D (struct chacha20_state *)drng;
+	struct chacha20_block *chacha20 =3D &chacha20_state->block;
+	u32 aligned_buf[CHACHA_BLOCK_WORDS], ret =3D outbuflen,
+	    used =3D CHACHA_BLOCK_WORDS;
+	int zeroize_buf =3D 0;
+
+	while (outbuflen >=3D CHACHA_BLOCK_SIZE) {
+		chacha20_block(&chacha20->constants[0], outbuf);
+		outbuf +=3D CHACHA_BLOCK_SIZE;
+		outbuflen -=3D CHACHA_BLOCK_SIZE;
+	}
+
+	if (outbuflen) {
+		chacha20_block(&chacha20->constants[0], (u8 *)aligned_buf);
+		memcpy(outbuf, aligned_buf, outbuflen);
+		used =3D ((outbuflen + sizeof(aligned_buf[0]) - 1) /
+			sizeof(aligned_buf[0]));
+		zeroize_buf =3D 1;
+	}
+
+	lrng_chacha20_update(chacha20_state, aligned_buf, used);
+
+	if (zeroize_buf)
+		memzero_explicit(aligned_buf, sizeof(aligned_buf));
+
+	return ret;
+}
+
+/**
+ * ChaCha20 DRNG that provides full strength, i.e. the output is capable
+ * of transporting 1 bit of entropy per data bit, provided the DRNG was
+ * seeded with 256 bits of entropy. This is achieved by folding the ChaCha=
20
+ * block output of 512 bits in half using XOR.
+ *
+ * Other than the output handling, the implementation is conceptually
+ * identical to lrng_drng_generate_helper.
+ */
+static int lrng_cc20_drng_generate_helper_full(void *drng, u8 *outbuf,
+					       u32 outbuflen)
+{
+	struct chacha20_state *chacha20_state =3D (struct chacha20_state *)drng;
+	struct chacha20_block *chacha20 =3D &chacha20_state->block;
+	u32 aligned_buf[CHACHA_BLOCK_WORDS];
+	u32 ret =3D outbuflen;
+
+	while (outbuflen >=3D CHACHA_BLOCK_SIZE) {
+		u32 i;
+
+		chacha20_block(&chacha20->constants[0], outbuf);
+
+		/* fold output in half */
+		for (i =3D 0; i < (CHACHA_BLOCK_WORDS / 2); i++)
+			outbuf[i] ^=3D outbuf[i + (CHACHA_BLOCK_WORDS / 2)];
+
+		outbuf +=3D CHACHA_BLOCK_SIZE / 2;
+		outbuflen -=3D CHACHA_BLOCK_SIZE / 2;
+	}
+
+	while (outbuflen) {
+		u32 i, todo =3D min_t(u32, CHACHA_BLOCK_SIZE / 2, outbuflen);
+
+		chacha20_block(&chacha20->constants[0], (u8 *)aligned_buf);
+
+		/* fold output in half */
+		for (i =3D 0; i < (CHACHA_BLOCK_WORDS / 2); i++)
+			aligned_buf[i] ^=3D
+				aligned_buf[i + (CHACHA_BLOCK_WORDS / 2)];
+
+		memcpy(outbuf, aligned_buf, todo);
+		outbuflen -=3D todo;
+		outbuf +=3D todo;
+	}
+	memzero_explicit(aligned_buf, sizeof(aligned_buf));
+
+	lrng_chacha20_update(chacha20_state, NULL, CHACHA_BLOCK_WORDS);
+
+	return ret;
+}
+
+void lrng_cc20_init_state(struct chacha20_state *state)
+{
+	struct chacha20_block *chacha20 =3D &state->block;
+	unsigned long v;
+	u32 i;
+
+	memcpy(&chacha20->constants[0], "expand 32-byte k", 16);
+
+	for (i =3D 0; i < CHACHA_KEY_SIZE_WORDS; i++) {
+		chacha20->key.u[i] ^=3D jiffies;
+		chacha20->key.u[i] ^=3D random_get_entropy();
+		if (arch_get_random_seed_long(&v) || arch_get_random_long(&v))
+			chacha20->key.u[i] ^=3D v;
+	}
+
+	for (i =3D 0; i < 3; i++) {
+		chacha20->nonce[i] ^=3D jiffies;
+		chacha20->nonce[i] ^=3D random_get_entropy();
+		if (arch_get_random_seed_long(&v) || arch_get_random_long(&v))
+			chacha20->nonce[i] ^=3D v;
+	}
+
+	pr_info("ChaCha20 core initialized\n");
+}
+
+/**
+ * Allocation of the DRNG state
+ */
+static void *lrng_cc20_drng_alloc(u32 sec_strength)
+{
+	struct chacha20_state *state =3D NULL;
+
+	if (sec_strength > CHACHA_KEY_SIZE) {
+		pr_err("Security strength of ChaCha20 DRNG (%u bits) lower "
+		       "than requested by LRNG (%u bits)\n",
+			CHACHA_KEY_SIZE * 8, sec_strength * 8);
+		return ERR_PTR(-EINVAL);
+	}
+	if (sec_strength < CHACHA_KEY_SIZE)
+		pr_warn("Security strength of ChaCha20 DRNG (%u bits) higher "
+			"than requested by LRNG (%u bits)\n",
+			CHACHA_KEY_SIZE * 8, sec_strength * 8);
+
+	state =3D kmalloc(sizeof(struct chacha20_state), GFP_KERNEL);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+	pr_debug("memory for ChaCha20 core allocated\n");
+
+	lrng_cc20_init_state(state);
+
+	return state;
+}
+
+static void lrng_cc20_drng_dealloc(void *drng)
+{
+	struct chacha20_state *chacha20_state =3D (struct chacha20_state *)drng;
+
+	if (drng =3D=3D &primary_chacha20 || drng =3D=3D &secondary_chacha20) {
+		memzero_explicit(chacha20_state, sizeof(*chacha20_state));
+		pr_debug("static ChaCha20 core zeroized\n");
+		return;
+	}
+
+	pr_debug("ChaCha20 core zeroized and freed\n");
+	kzfree(chacha20_state);
+}
+
+/******************************* Hash Operation **************************=
*****/
+
+static void *lrng_cc20_hash_alloc(const u8 *key, u32 keylen)
+{
+	pr_info("Hash SHA-1 allocated\n");
+	return NULL;
+}
+
+static void lrng_cc20_hash_dealloc(void *hash)
+{
+}
+
+static u32 lrng_cc20_hash_digestsize(void *hash)
+{
+	return (SHA_DIGEST_WORDS * sizeof(u32));
+}
+
+static int lrng_cc20_hash_buffer(void *hash, const u8 *inbuf, u32 inbuflen,
+				 u8 *digest)
+{
+	u32 i;
+	u32 workspace[SHA_WORKSPACE_WORDS];
+
+	WARN_ON(inbuflen % (SHA_WORKSPACE_WORDS * sizeof(u32)));
+
+	for (i =3D 0; i < inbuflen; i +=3D (SHA_WORKSPACE_WORDS * sizeof(u32)))
+		sha_transform((u32 *)digest, (inbuf + i), workspace);
+	memzero_explicit(workspace, sizeof(workspace));
+
+	return 0;
+}
+
+static const char *lrng_cc20_drng_name(void)
+{
+	const char *cc20_drng_name =3D "ChaCha20 DRNG";
+	return cc20_drng_name;
+}
+
+static const char *lrng_cc20_hash_name(void)
+{
+	const char *cc20_hash_name =3D "SHA-1";
+	return cc20_hash_name;
+}
+
+const struct lrng_crypto_cb lrng_cc20_crypto_cb =3D {
+	.lrng_drng_name			=3D lrng_cc20_drng_name,
+	.lrng_hash_name			=3D lrng_cc20_hash_name,
+	.lrng_drng_alloc		=3D lrng_cc20_drng_alloc,
+	.lrng_drng_dealloc		=3D lrng_cc20_drng_dealloc,
+	.lrng_drng_seed_helper		=3D lrng_cc20_drng_seed_helper,
+	.lrng_drng_generate_helper	=3D lrng_cc20_drng_generate_helper,
+	.lrng_drng_generate_helper_full	=3D lrng_cc20_drng_generate_helper_full,
+	.lrng_hash_alloc		=3D lrng_cc20_hash_alloc,
+	.lrng_hash_dealloc		=3D lrng_cc20_hash_dealloc,
+	.lrng_hash_digestsize		=3D lrng_cc20_hash_digestsize,
+	.lrng_hash_buffer		=3D lrng_cc20_hash_buffer,
+};
diff --git a/drivers/char/lrng/lrng_interfaces.c b/drivers/char/lrng/lrng_i=
nterfaces.c
new file mode 100644
index 000000000000..e652849a1bdb
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_interfaces.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG User and kernel space interfaces
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/freezer.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/kthread.h>
+#include <linux/poll.h>
+#include <linux/preempt.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/timex.h>
+
+#include "lrng_internal.h"
+
+/*
+ * The minimum number of bits of entropy before we wake up a read on
+ * /dev/random.
+ */
+u32 lrng_read_wakeup_bits =3D LRNG_MIN_SEED_ENTROPY_BITS +
+			    LRNG_CONDITIONING_ENTROPY_LOSS;
+
+/*
+ * If the entropy count falls under this number of bits, then we
+ * should wake up processes which are selecting or polling on write
+ * access to /dev/random.
+ */
+u32 lrng_write_wakeup_bits =3D LRNG_EMERG_ENTROPY +
+			     2 * LRNG_DRNG_SECURITY_STRENGTH_BITS;
+
+static LIST_HEAD(lrng_ready_list);
+static DEFINE_SPINLOCK(lrng_ready_list_lock);
+
+static DECLARE_WAIT_QUEUE_HEAD(lrng_read_wait);
+static DECLARE_WAIT_QUEUE_HEAD(lrng_write_wait);
+static DECLARE_WAIT_QUEUE_HEAD(lrng_init_wait);
+static struct fasync_struct *fasync;
+
+struct ctl_table random_table[];
+/********************************** Helper *******************************=
****/
+
+/* Is the primary DRNG seed level too low? */
+static inline bool lrng_need_entropy(void)
+{
+	return (lrng_avail_entropy() < lrng_write_wakeup_bits);
+}
+
+/* Is the entropy pool filled for /dev/random pull or DRNG fully seeded? */
+static inline bool lrng_have_entropy_full(void)
+{
+	return (lrng_avail_entropy() >=3D lrng_read_wakeup_bits);
+}
+
+void lrng_reader_wakeup(void)
+{
+	if (lrng_have_entropy_full() && wq_has_sleeper(&lrng_read_wait)) {
+		wake_up_interruptible(&lrng_read_wait);
+		kill_fasync(&fasync, SIGIO, POLL_IN);
+	}
+}
+
+void lrng_writer_wakeup(void)
+{
+	if (lrng_need_entropy() && wq_has_sleeper(&lrng_write_wait)) {
+		wake_up_interruptible(&lrng_write_wait);
+		kill_fasync(&fasync, SIGIO, POLL_OUT);
+	}
+}
+
+void lrng_init_wakeup(void)
+{
+	wake_up_all(&lrng_init_wait);
+}
+
+/**
+ * Ping all kernel internal callers waiting until the DRNG is fully
+ * seeded that the DRNG is now fully seeded.
+ *
+ * When the SP800-90B testing is enabled, the ping only happens if the SP8=
00-90B
+ * startup health tests are completed. This implies that kernel internal
+ * callers always have an SP800-90B compliant noise source when being
+ * pinged.
+ */
+void lrng_process_ready_list(void)
+{
+	unsigned long flags;
+	struct random_ready_callback *rdy, *tmp;
+
+	if (!lrng_sp80090b_startup_complete())
+		return;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	list_for_each_entry_safe(rdy, tmp, &lrng_ready_list, list) {
+		struct module *owner =3D rdy->owner;
+
+		list_del_init(&rdy->list);
+		rdy->func(rdy);
+		module_put(owner);
+	}
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+}
+
+void lrng_debug_report_seedlevel(const char *name)
+{
+#ifdef CONFIG_WARN_ALL_UNSEEDED_RANDOM
+	static void *previous =3D NULL;
+	void *caller =3D (void *) _RET_IP_;
+
+	if (READ_ONCE(previous) =3D=3D caller)
+		return;
+
+	if (!lrng_state_min_seeded())
+		pr_notice("%pS %s called without reaching mimimally seeded "
+			  "level (available entropy %u)\n", caller, name,
+			  lrng_avail_entropy());
+
+	WRITE_ONCE(previous, caller);
+#endif
+}
+
+/************************ LRNG kernel input interfaces *******************=
*****/
+
+/**
+ * Interface for in-kernel drivers of true hardware RNGs.
+ * Those devices may produce endless random bits and will be throttled
+ * when our pool is full.
+ *
+ * @buffer: buffer holding the entropic data from HW noise sources to be u=
sed to
+ *	    (re)seed the DRNG.
+ * @count: length of buffer
+ * @entropy_bits: amount of entropy in buffer (value is in bits)
+ */
+void add_hwgenerator_randomness(const char *buffer, size_t count,
+				size_t entropy_bits)
+{
+	/* DRNG is not yet online */
+	if (!lrng_get_available())
+		return;
+	/*
+	 * Suspend writing if we are fully loaded with entropy.
+	 * We'll be woken up again once below lrng_write_wakeup_thresh,
+	 * or when the calling thread is about to terminate.
+	 */
+	wait_event_interruptible(lrng_write_wait, lrng_need_entropy() ||
+						  kthread_should_stop() ||
+						  freezing(current));
+	lrng_pool_lfsr_nonaligned(buffer, count);
+	lrng_pool_add_entropy(entropy_bits);
+}
+EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
+
+/* Handle random seed passed by bootloader.
+ * If the seed is trustworthy, it would be regarded as hardware RNGs. Othe=
rwise
+ * it would be regarded as device data.
+ * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
+ */
+void add_bootloader_randomness(const void *buf, unsigned int size)
+{
+	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
+		add_hwgenerator_randomness(buf, size, size * 8);
+	else
+		add_device_randomness(buf, size);
+}
+EXPORT_SYMBOL_GPL(add_bootloader_randomness);
+
+/**
+ * Callback for HID layer -- use the HID event values to stir the entropy =
pool
+ */
+void add_input_randomness(unsigned int type, unsigned int code,
+			  unsigned int value)
+{
+	static unsigned char last_value;
+
+	/* ignore autorepeat and the like */
+	if (value =3D=3D last_value)
+		return;
+
+	last_value =3D value;
+
+	lrng_pool_lfsr_u32((type << 4) ^ code ^ (code >> 4) ^ value);
+}
+EXPORT_SYMBOL_GPL(add_input_randomness);
+
+/*
+ * Add device- or boot-specific data to the input pool to help
+ * initialize it.
+ *
+ * None of this adds any entropy; it is meant to avoid the problem of
+ * the entropy pool having similar initial state across largely
+ * identical devices.
+ */
+void add_device_randomness(const void *buf, unsigned int size)
+{
+	lrng_pool_lfsr_nonaligned((u8 *)buf, size);
+	lrng_pool_lfsr_u32(random_get_entropy());
+	lrng_pool_lfsr_u32(jiffies);
+}
+EXPORT_SYMBOL(add_device_randomness);
+
+#ifdef CONFIG_BLOCK
+void rand_initialize_disk(struct gendisk *disk) { }
+void add_disk_randomness(struct gendisk *disk) { }
+EXPORT_SYMBOL(add_disk_randomness);
+#endif
+
+/**
+ * Delete a previously registered readiness callback function.
+ */
+void del_random_ready_callback(struct random_ready_callback *rdy)
+{
+	unsigned long flags;
+	struct module *owner =3D NULL;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	if (!list_empty(&rdy->list)) {
+		list_del_init(&rdy->list);
+		owner =3D rdy->owner;
+	}
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+
+	module_put(owner);
+}
+EXPORT_SYMBOL(del_random_ready_callback);
+
+/**
+ * Add a callback function that will be invoked when the DRNG is fully see=
ded.
+ *
+ * @return: 0 if callback is successfully added
+ *          -EALREADY if pool is already initialised (callback not called)
+ *	    -ENOENT if module for callback is not alive
+ */
+int add_random_ready_callback(struct random_ready_callback *rdy)
+{
+	struct module *owner;
+	unsigned long flags;
+	int err =3D -EALREADY;
+
+	if (likely(lrng_state_min_seeded()))
+		return err;
+
+	owner =3D rdy->owner;
+	if (!try_module_get(owner))
+		return -ENOENT;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	if (lrng_state_min_seeded())
+		goto out;
+
+	owner =3D NULL;
+
+	list_add(&rdy->list, &lrng_ready_list);
+	err =3D 0;
+
+out:
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+
+	module_put(owner);
+
+	return err;
+}
+EXPORT_SYMBOL(add_random_ready_callback);
+
+/*********************** LRNG kernel output interfaces *******************=
*****/
+
+/**
+ * Provider of cryptographic strong random numbers for kernel-internal usa=
ge.
+ * This function is appropriate for all in-kernel use cases. However,
+ * it will always use the ChaCha20 DRNG.
+ *
+ * @buf: buffer to store the random bytes
+ * @nbytes: size of the buffer
+ */
+void get_random_bytes(void *buf, int nbytes)
+{
+	lrng_sdrng_get_atomic((u8 *)buf, (u32)nbytes);
+	lrng_debug_report_seedlevel("get_random_bytes");
+}
+EXPORT_SYMBOL(get_random_bytes);
+
+/**
+ * Provider of cryptographic strong random numbers for kernel-internal usa=
ge.
+ * This function is appropriate only for non-atomic use cases as this
+ * function may sleep. Though, it provides access to the full functionality
+ * of LRNG including the switchable DRNG support, that may support other
+ * DRNGs such as the SP800-90A DRBG.
+ *
+ * @buf: buffer to store the random bytes
+ * @nbytes: size of the buffer
+ */
+void get_random_bytes_full(void *buf, int nbytes)
+{
+	lrng_sdrng_get_sleep((u8 *)buf, (u32)nbytes);
+	lrng_debug_report_seedlevel("get_random_bytes_full");
+}
+EXPORT_SYMBOL(get_random_bytes_full);
+
+/**
+ * Wait for the LRNG to be seeded and thus guaranteed to supply
+ * cryptographically secure random numbers. This applies to: the /dev/uran=
dom
+ * device, the get_random_bytes function, and the get_random_{u32,u64,int,=
long}
+ * family of functions. Using any of these functions without first calling
+ * this function forfeits the guarantee of security.
+ *
+ * Returns: 0 if the LRNG has been seeded.
+ *          -ERESTARTSYS if the function was interrupted by a signal.
+ */
+int wait_for_random_bytes(void)
+{
+	if (likely(lrng_state_min_seeded()))
+		return 0;
+	return wait_event_interruptible(lrng_init_wait,
+					lrng_state_min_seeded());
+}
+EXPORT_SYMBOL(wait_for_random_bytes);
+
+/**
+ * This function will use the architecture-specific hardware random
+ * number generator if it is available.  The arch-specific hw RNG will
+ * almost certainly be faster than what we can do in software, but it
+ * is impossible to verify that it is implemented securely (as
+ * opposed, to, say, the AES encryption of a sequence number using a
+ * key known by the NSA).  So it's useful if we need the speed, but
+ * only if we're willing to trust the hardware manufacturer not to
+ * have put in a back door.
+ *
+ * @buf: buffer allocated by caller to store the random data in
+ * @nbytes: length of outbuf
+ *
+ * Return number of bytes filled in.
+ */
+int __must_check get_random_bytes_arch(void *buf, int nbytes)
+{
+	u8 *p =3D buf;
+
+	while (nbytes) {
+		unsigned long v;
+		int chunk =3D min_t(int, nbytes, sizeof(unsigned long));
+
+		if (!arch_get_random_long(&v))
+			break;
+
+		memcpy(p, &v, chunk);
+		p +=3D chunk;
+		nbytes -=3D chunk;
+	}
+
+	if (nbytes)
+		lrng_sdrng_get_atomic((u8 *)p, (u32)nbytes);
+
+	return nbytes;
+}
+EXPORT_SYMBOL(get_random_bytes_arch);
+
+/************************ LRNG user output interfaces ********************=
*****/
+
+static ssize_t lrng_read_common(char __user *buf, size_t nbytes,
+			int (*lrng_read_random)(u8 *outbuf, u32 outbuflen))
+{
+	ssize_t ret =3D 0;
+	u8 tmpbuf[LRNG_DRNG_BLOCKSIZE] __aligned(LRNG_KCAPI_ALIGN);
+	u8 *tmp_large =3D NULL, *tmp =3D tmpbuf;
+	u32 tmplen =3D sizeof(tmpbuf);
+
+	if (nbytes =3D=3D 0)
+		return 0;
+
+	/*
+	 * Satisfy large read requests -- as the common case are smaller
+	 * request sizes, such as 16 or 32 bytes, avoid a kmalloc overhead for
+	 * those by using the stack variable of tmpbuf.
+	 */
+	if (nbytes > sizeof(tmpbuf)) {
+		tmplen =3D min_t(u32, nbytes, LRNG_DRNG_MAX_REQSIZE);
+		tmp_large =3D kmalloc(tmplen + LRNG_KCAPI_ALIGN, GFP_KERNEL);
+		if (!tmp_large)
+			tmplen =3D sizeof(tmpbuf);
+		else
+			tmp =3D PTR_ALIGN(tmp_large, LRNG_KCAPI_ALIGN);
+	}
+
+	while (nbytes) {
+		u32 todo =3D min_t(u32, nbytes, tmplen);
+		int rc =3D 0;
+
+		/* Reschedule if we received a large request. */
+		if ((tmp_large) && need_resched()) {
+			if (signal_pending(current)) {
+				if (ret =3D=3D 0)
+					ret =3D -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+
+		rc =3D lrng_read_random(tmp, todo);
+		if (rc <=3D 0) {
+			if (rc < 0)
+				ret =3D rc;
+			break;
+		}
+		if (copy_to_user(buf, tmp, rc)) {
+			ret =3D -EFAULT;
+			break;
+		}
+
+		nbytes -=3D rc;
+		buf +=3D rc;
+		ret +=3D rc;
+	}
+
+	/* Wipe data just returned from memory */
+	if (tmp_large)
+		kzfree(tmp_large);
+	else
+		memzero_explicit(tmpbuf, sizeof(tmpbuf));
+
+	return ret;
+}
+
+static ssize_t
+lrng_trng_read_common(int nonblock, char __user *buf, size_t nbytes)
+{
+	if (nbytes =3D=3D 0)
+		return 0;
+
+	nbytes =3D min_t(u32, nbytes, LRNG_DRNG_BLOCKSIZE);
+	while (1) {
+		ssize_t n =3D lrng_read_common(buf, nbytes, lrng_trng_get);
+
+		if (n)
+			return n;
+
+		/* No entropy available.  Maybe wait and retry. */
+		if (nonblock)
+			return -EAGAIN;
+
+		wait_event_interruptible(lrng_read_wait,
+					 lrng_have_entropy_full());
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+	}
+}
+
+static ssize_t lrng_trng_read(struct file *file, char __user *buf,
+			      size_t nbytes, loff_t *ppos)
+{
+	return lrng_trng_read_common(file->f_flags & O_NONBLOCK, buf, nbytes);
+}
+
+static unsigned int lrng_trng_poll(struct file *file, poll_table *wait)
+{
+	__poll_t mask;
+
+	poll_wait(file, &lrng_read_wait, wait);
+	poll_wait(file, &lrng_write_wait, wait);
+	mask =3D 0;
+	if (lrng_have_entropy_full())
+		mask |=3D EPOLLIN | EPOLLRDNORM;
+	if (lrng_need_entropy())
+		mask |=3D EPOLLOUT | EPOLLWRNORM;
+	return mask;
+}
+
+static ssize_t lrng_drng_write_common(const char __user *buffer, size_t co=
unt,
+				      u32 entropy_bits)
+{
+	ssize_t ret =3D 0;
+	u8 buf[64] __aligned(LRNG_KCAPI_ALIGN);
+	const char __user *p =3D buffer;
+	u32 orig_entropy_bits =3D entropy_bits;
+
+	if (!lrng_get_available())
+		return -EAGAIN;
+
+	count =3D min_t(size_t, count, INT_MAX);
+	while (count > 0) {
+		size_t bytes =3D min_t(size_t, count, sizeof(buf));
+		u32 ent =3D min_t(u32, bytes<<3, entropy_bits);
+
+		if (copy_from_user(&buf, p, bytes))
+			return -EFAULT;
+		/* Inject data into entropy pool */
+		lrng_pool_lfsr(buf, bytes);
+		lrng_pool_add_entropy(ent);
+
+		count -=3D bytes;
+		p +=3D bytes;
+		ret +=3D bytes;
+		entropy_bits -=3D ent;
+
+		cond_resched();
+	}
+
+	/* Force reseed of secondary DRNG during next data request. */
+	if (!orig_entropy_bits)
+		lrng_sdrng_force_reseed();
+
+	return ret;
+}
+
+static ssize_t lrng_sdrng_read(struct file *file, char __user *buf,
+			       size_t nbytes, loff_t *ppos)
+{
+	if (!lrng_state_min_seeded())
+		pr_notice_ratelimited("%s - use of insufficiently seeded DRNG "
+				      "(%zu bytes read)\n", current->comm,
+				      nbytes);
+	else if (!lrng_state_operational())
+		pr_debug_ratelimited("%s - use of not fully seeded DRNG (%zu "
+				     "bytes read)\n", current->comm, nbytes);
+
+	return lrng_read_common(buf, nbytes, lrng_sdrng_get_sleep);
+}
+
+static ssize_t lrng_drng_write(struct file *file, const char __user *buffe=
r,
+			       size_t count, loff_t *ppos)
+{
+	return lrng_drng_write_common(buffer, count, 0);
+}
+
+static long lrng_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	int size, ent_count_bits;
+	int __user *p =3D (int __user *)arg;
+
+	switch (cmd) {
+	case RNDGETENTCNT:
+		ent_count_bits =3D lrng_avail_entropy();
+		if (put_user(ent_count_bits, p))
+			return -EFAULT;
+		return 0;
+	case RNDADDTOENTCNT:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(ent_count_bits, p))
+			return -EFAULT;
+		ent_count_bits =3D (int)lrng_avail_entropy() + ent_count_bits;
+		if (ent_count_bits < 0)
+			ent_count_bits =3D 0;
+		if (ent_count_bits > LRNG_POOL_SIZE_BITS)
+			ent_count_bits =3D LRNG_POOL_SIZE_BITS;
+		lrng_pool_set_entropy(ent_count_bits);
+		return 0;
+	case RNDADDENTROPY:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(ent_count_bits, p++))
+			return -EFAULT;
+		if (ent_count_bits < 0)
+			return -EINVAL;
+		if (get_user(size, p++))
+			return -EFAULT;
+		if (size < 0)
+			return -EINVAL;
+		/* there cannot be more entropy than data */
+		ent_count_bits =3D min(ent_count_bits, size<<3);
+		return lrng_drng_write_common((const char __user *)p, size,
+					      ent_count_bits);
+	case RNDZAPENTCNT:
+	case RNDCLEARPOOL:
+		/* Clear the entropy pool counter. */
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		lrng_pool_set_entropy(0);
+		return 0;
+	case RNDRESEEDCRNG:
+		/*
+		 * We leave the capability check here since it is present
+		 * in the upstream's RNG implementation. Yet, user space
+		 * can trigger a reseed as easy as writing into /dev/random
+		 * or /dev/urandom where no privilege is needed.
+		 */
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		/* Force a reseed of all secondary DRNGs */
+		lrng_sdrng_force_reseed();
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int lrng_fasync(int fd, struct file *filp, int on)
+{
+	return fasync_helper(fd, filp, on, &fasync);
+}
+
+const struct file_operations random_fops =3D {
+	.read  =3D lrng_trng_read,
+	.write =3D lrng_drng_write,
+	.poll  =3D lrng_trng_poll,
+	.unlocked_ioctl =3D lrng_ioctl,
+	.fasync =3D lrng_fasync,
+	.llseek =3D noop_llseek,
+};
+
+const struct file_operations urandom_fops =3D {
+	.read  =3D lrng_sdrng_read,
+	.write =3D lrng_drng_write,
+	.unlocked_ioctl =3D lrng_ioctl,
+	.fasync =3D lrng_fasync,
+	.llseek =3D noop_llseek,
+};
+
+SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
+		unsigned int, flags)
+{
+	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
+		return -EINVAL;
+
+	if (count > INT_MAX)
+		count =3D INT_MAX;
+
+	if (flags & GRND_RANDOM)
+		return lrng_trng_read_common(flags & GRND_NONBLOCK, buf, count);
+
+	if (unlikely(!lrng_state_operational())) {
+		int ret;
+
+		if (flags & GRND_NONBLOCK)
+			return -EAGAIN;
+		ret =3D wait_event_interruptible(lrng_init_wait,
+					       lrng_state_operational());
+		if (unlikely(ret))
+			return ret;
+	}
+
+	return lrng_sdrng_read(NULL, buf, count, NULL);
+}
diff --git a/drivers/char/lrng/lrng_internal.h b/drivers/char/lrng/lrng_int=
ernal.h
new file mode 100644
index 000000000000..242f9b5b4f3d
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_internal.h
@@ -0,0 +1,313 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2018 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#ifndef _LRNG_INTERNAL_H
+#define _LRNG_INTERNAL_H
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+
+/*************************** General LRNG parameter **********************=
*****/
+
+/* Security strength of LRNG -- this must match DRNG security strength */
+#define LRNG_DRNG_SECURITY_STRENGTH_BYTES 32
+#define LRNG_DRNG_SECURITY_STRENGTH_BITS (LRNG_DRNG_SECURITY_STRENGTH_BYTE=
S * 8)
+#define LRNG_DRNG_BLOCKSIZE 64		/* Maximum of DRNG block sizes */
+
+/*
+ * SP800-90A defines a maximum request size of 1<<16 bytes. The given valu=
e is
+ * considered a safer margin. This applies to the secondary DRNGs.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_DRNG_MAX_REQSIZE		(1<<12)
+
+/*
+ * SP800-90A defines a maximum number of requests between reseeds of 2^48.
+ * The given value is considered a much safer margin, balancing requests f=
or
+ * frequent reseeds with the need to conserve entropy. This value MUST NOT=
 be
+ * larger than INT_MAX because it is used in an atomic_t. This applies to =
the
+ * secondary DRNGs.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_DRNG_RESEED_THRESH		(1<<20)
+
+/*
+ * Number of interrupts to be recorded to assume that DRNG security streng=
th
+ * bits of entropy are received.
+ * Note: a value below the DRNG security strength should not be defined as=
 this
+ *	 may imply the DRNG can never be fully seeded in case other noise
+ *	 sources are unavailable.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_IRQ_ENTROPY_BITS		LRNG_DRNG_SECURITY_STRENGTH_BITS
+
+/*
+ * Leave given amount of entropy in bits entropy pool to serve /dev/random=
 while
+ * /dev/urandom is stressed.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_EMERG_ENTROPY		(LRNG_DRNG_SECURITY_STRENGTH_BITS * 2)
+
+/*
+ * Amount of entropy that is lost with the conditioning functions of LFSR =
and
+ * hash_df as shown with the entropy analysis compliant to SP800-90B.
+ */
+#define LRNG_CONDITIONING_ENTROPY_LOSS	1
+
+/*
+ * Min required seed entropy is 128 bits covering the minimum entropy
+ * requirement of SP800-131A and the German BSI's TR02102.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_FULL_SEED_ENTROPY_BITS	LRNG_DRNG_SECURITY_STRENGTH_BITS
+#define LRNG_MIN_SEED_ENTROPY_BITS	128
+#define LRNG_INIT_ENTROPY_BITS		32
+
+/*
+ * Oversampling factor of IRQ events to obtain
+ * LRNG_DRNG_SECURITY_STRENGTH_BYTES. This factor is used when a
+ * high-resolution time stamp is not available. In this case, jiffies and
+ * register contents are used to fill the entropy pool. These noise sources
+ * are much less entropic than the high-resolution timer. The entropy cont=
ent
+ * is the entropy content assumed with LRNG_IRQ_ENTROPY_BITS divided by
+ * LRNG_IRQ_OVERSAMPLING_FACTOR.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_IRQ_OVERSAMPLING_FACTOR	10
+
+/*
+ * Alignmask which should cover all cipher implementations
+ * WARNING: If this is changed to a value larger than 8, manual
+ * alignment is necessary as older versions of GCC may not be capable
+ * of aligning stack variables at boundaries greater than 8.
+ * In this case, PTR_ALIGN must be used.
+ */
+#define LRNG_KCAPI_ALIGN		8
+
+/************************ Default DRNG implementation ********************=
*****/
+
+extern struct chacha20_state primary_chacha20;
+extern struct chacha20_state secondary_chacha20;
+extern const struct lrng_crypto_cb lrng_cc20_crypto_cb;
+void lrng_cc20_init_state(struct chacha20_state *state);
+
+/********************************** /proc ********************************=
*****/
+
+static inline void lrng_pool_inc_numa_node(void) { }
+
+/****************************** LRNG interfaces **************************=
*****/
+
+extern u32 lrng_read_wakeup_bits;
+extern u32 lrng_write_wakeup_bits;
+extern int lrng_sdrng_reseed_max_time;
+
+void lrng_reader_wakeup(void);
+void lrng_writer_wakeup(void);
+void lrng_init_wakeup(void);
+void lrng_debug_report_seedlevel(const char *name);
+void lrng_process_ready_list(void);
+
+/************************** Entropy pool management **********************=
*****/
+
+#define LRNG_POOL_SIZE			(128 << CONFIG_LRNG_POOL_SIZE)
+#define LRNG_POOL_WORD_BYTES		(sizeof(atomic_t))
+#define LRNG_POOL_SIZE_BYTES		(LRNG_POOL_SIZE * LRNG_POOL_WORD_BYTES)
+#define LRNG_POOL_SIZE_BITS		(LRNG_POOL_SIZE_BYTES * 8)
+#define LRNG_POOL_WORD_BITS		(LRNG_POOL_WORD_BYTES * 8)
+
+void lrng_state_init_seed_work(void);
+u32 lrng_avail_entropy(void);
+void lrng_set_entropy_thresh(u32 new);
+int lrng_pool_trylock(void);
+void lrng_pool_unlock(void);
+void lrng_reset_state(void);
+void lrng_pool_all_numa_nodes_seeded(void);
+bool lrng_state_min_seeded(void);
+bool lrng_state_fully_seeded(void);
+bool lrng_state_operational(void);
+bool lrng_pool_highres_timer(void);
+void lrng_pool_set_entropy(u32 entropy_bits);
+void lrng_pool_configure(bool highres_timer, u32 irq_entropy_bits);
+void lrng_pool_lfsr(const u8 *buf, u32 buflen);
+void lrng_pool_lfsr_nonaligned(const u8 *buf, u32 buflen);
+void lrng_pool_lfsr_u32(u32 value);
+void lrng_pool_add_irq(u32 irq_num);
+void lrng_pool_add_entropy(u32 entropy_bits);
+
+struct entropy_buf {
+	u8 a[LRNG_DRNG_SECURITY_STRENGTH_BYTES];
+	u8 b[LRNG_DRNG_SECURITY_STRENGTH_BYTES];
+	u8 c[LRNG_DRNG_SECURITY_STRENGTH_BYTES];
+	u32 now;
+};
+
+int lrng_fill_seed_buffer(const struct lrng_crypto_cb *crypto_cb,
+			  void *hash, struct entropy_buf *entropy_buf,
+			  bool drain);
+void lrng_init_ops(u32 seed_bits);
+
+/************************** Jitter RNG Noise Source **********************=
*****/
+
+#ifdef CONFIG_LRNG_JENT
+u32 lrng_get_jent(u8 *outbuf, unsigned int outbuflen);
+u32 lrng_jent_entropylevel(void);
+#else /* CONFIG_CRYPTO_JITTERENTROPY */
+static inline u32 lrng_get_jent(u8 *outbuf, unsigned int outbuflen) {retur=
n 0; }
+static inline u32 lrng_jent_entropylevel(void) { return 0; }
+#endif /* CONFIG_CRYPTO_JITTERENTROPY */
+
+/*************************** CPU-based Noise Source **********************=
*****/
+
+u32 lrng_get_arch(u8 *outbuf);
+u32 lrng_slow_noise_req_entropy(u32 required_entropy_bits);
+
+/****************** True Random Number Generator processing **************=
*****/
+
+#ifdef CONFIG_LRNG_TRNG_SUPPORT
+
+void lrng_trng_reset(void);
+void lrng_trng_init(void);
+int lrng_trng_get(u8 *outbuf, u32 outbuflen);
+int lrng_trng_seed(u8 *outbuf, u32 outbuflen, bool fullentropy, bool drain=
);
+# ifdef CONFIG_LRNG_DRNG_SWITCH
+int lrng_trng_switch(const struct lrng_crypto_cb *cb);
+# endif
+
+#else	/* CONFIG_LRNG_TRNG_SUPPORT */
+
+static inline void lrng_trng_reset(void) {}
+static inline void lrng_trng_init(void) {}
+#define lrng_trng_get lrng_sdrng_get_sleep
+
+# ifdef CONFIG_LRNG_DRNG_SWITCH
+static inline int lrng_trng_switch(const struct lrng_crypto_cb *cb) {retur=
n 0; }
+# endif
+
+#endif	/* CONFIG_LRNG_TRNG_SUPPORT */
+
+/************************* secondary DRNG processing *********************=
*****/
+
+/* Secondary DRNG state handle */
+struct lrng_sdrng {
+	void *sdrng;				/* DRNG handle */
+	void *hash;				/* Hash handle */
+	const struct lrng_crypto_cb *crypto_cb;	/* Crypto callbacks */
+	atomic_t requests;			/* Number of DRNG requests */
+	unsigned long last_seeded;		/* Last time it was seeded */
+	bool fully_seeded;			/* Is DRNG fully seeded? */
+	bool force_reseed;			/* Force a reseed */
+	struct mutex lock;
+	spinlock_t spin_lock;
+};
+
+extern struct mutex lrng_crypto_cb_update;
+
+struct lrng_sdrng *lrng_sdrng_init_instance(void);
+struct lrng_sdrng *lrng_sdrng_atomic_instance(void);
+
+static __always_inline bool lrng_sdrng_is_atomic(struct lrng_sdrng *sdrng)
+{
+	return (sdrng->sdrng =3D=3D lrng_sdrng_atomic_instance()->sdrng);
+}
+
+/* Lock the secondary DRNG */
+static __always_inline void lrng_sdrng_lock(struct lrng_sdrng *sdrng,
+					    unsigned long *flags)
+{
+	/* Use spin lock in case the atomic DRNG context is used */
+	if (lrng_sdrng_is_atomic(sdrng))
+		spin_lock_irqsave(&sdrng->spin_lock, *flags);
+	else
+		mutex_lock(&sdrng->lock);
+}
+
+/* Unlock the secondary DRNG */
+static __always_inline void lrng_sdrng_unlock(struct lrng_sdrng *sdrng,
+					      unsigned long *flags)
+{
+	if (lrng_sdrng_is_atomic(sdrng))
+		spin_unlock_irqrestore(&sdrng->spin_lock, *flags);
+	else
+		mutex_unlock(&sdrng->lock);
+}
+
+bool lrng_get_available(void);
+void lrng_set_available(void);
+void lrng_drngs_init_cc20(void);
+void lrng_sdrng_reset(struct lrng_sdrng *sdrng);
+int lrng_sdrng_get_atomic(u8 *outbuf, u32 outbuflen);
+int lrng_sdrng_get_sleep(u8 *outbuf, u32 outbuflen);
+void lrng_sdrng_force_reseed(void);
+void lrng_sdrng_seed_work(struct work_struct *dummy);
+
+static inline struct lrng_sdrng **lrng_sdrng_instances(void) { return NULL=
; }
+static inline void lrng_drngs_numa_alloc(void) { return; }
+
+/************************** Health Test linking code *********************=
*****/
+
+enum lrng_health_res {
+	lrng_health_pass,		/* Health test passes on time stamp */
+	lrng_health_fail_use,		/* Time stamp unhealthy, but mix in */
+	lrng_health_fail_drop		/* Time stamp unhealthy, drop it */
+};
+
+#ifdef CONFIG_LRNG_HEALTH_TESTS
+bool lrng_sp80090b_startup_complete(void);
+bool lrng_sp80090b_compliant(void);
+
+enum lrng_health_res lrng_health_test(u32 now_time);
+void lrng_health_disable(void);
+
+void lrng_reset(void);
+#else	/* CONFIG_LRNG_HEALTH_TESTS */
+static inline bool lrng_sp80090b_startup_complete(void) { return true; }
+static inline bool lrng_sp80090b_compliant(void) { return false; }
+
+static inline enum lrng_health_res
+lrng_health_test(u32 now_time) { return lrng_health_pass; }
+static inline void lrng_health_disable(void) { }
+#endif	/* CONFIG_LRNG_HEALTH_TESTS */
+
+/****************************** Helper code ******************************=
*****/
+
+static inline u32 atomic_read_u32(atomic_t *v)
+{
+	return (u32)atomic_read(v);
+}
+
+/*************************** Auxiliary functions *************************=
*****/
+
+void invalidate_batched_entropy(void);
+
+/***************************** Testing code ******************************=
*****/
+
+#ifdef CONFIG_LRNG_TESTING
+bool lrng_raw_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_TESTING */
+static inline bool lrng_raw_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_TESTING */
+
+#endif /* _LRNG_INTERNAL_H */
diff --git a/drivers/char/lrng/lrng_pool.c b/drivers/char/lrng/lrng_pool.c
new file mode 100644
index 000000000000..61a03206cf67
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_pool.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Entropy pool management
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <asm/irq_regs.h>
+#include <linux/lrng.h>
+#include <linux/percpu.h>
+#include <linux/random.h>
+#include <linux/utsname.h>
+#include <linux/workqueue.h>
+
+#include "lrng_internal.h"
+
+struct lrng_state {
+	bool lrng_operational;			/* Is DRNG operational? */
+	bool lrng_fully_seeded;			/* Is DRNG fully seeded? */
+	bool lrng_min_seeded;			/* Is DRNG minimally seeded? */
+	struct work_struct lrng_seed_work;	/* (re)seed work queue */
+};
+
+/* Status information about IRQ noise source */
+struct lrng_irq_info {
+	atomic_t num_events;	/* Number of healthy IRQs since last read */
+	atomic_t num_events_thresh;	/* Reseed threshold */
+	atomic_t reseed_in_progress;	/* Flag for on executing reseed */
+	bool irq_highres_timer;	/* Is high-resolution timer available? */
+	u32 irq_entropy_bits;	/* LRNG_IRQ_ENTROPY_BITS? */
+};
+
+/*
+ * This is the entropy pool used by the slow noise source. Its size should
+ * be at least as large as LRNG_DRNG_SECURITY_STRENGTH_BITS.
+ *
+ * The pool array is aligned to 8 bytes to comfort the kernel crypto API c=
ipher
+ * implementations of the hash functions used to read the pool: for some
+ * accelerated implementations, we need an alignment to avoid a realignment
+ * which involves memcpy(). The alignment to 8 bytes should satisfy all cr=
ypto
+ * implementations.
+ *
+ * LRNG_POOL_SIZE is allowed to be changed only if the taps of the polynom=
ial
+ * used for the LFSR are changed as well. The size must be in powers of 2 =
due
+ * to the mask handling in lrng_pool_lfsr_u32 which uses AND instead of mo=
dulo.
+ */
+struct lrng_pool {
+	union {
+		struct {
+			/*
+			 * hash_df implementation: counter, requested_bits and
+			 * pool form a linear buffer that is used in the
+			 * hash_df function specified in SP800-90A section
+			 * 10.3.1
+			 */
+			unsigned char counter;
+			__be32 requested_bits;
+
+			/* Pool */
+			atomic_t pool[LRNG_POOL_SIZE];
+			/* Ptr into pool for next IRQ word injection */
+			atomic_t pool_ptr;
+			/* rotate for LFSR */
+			atomic_t input_rotate;
+			/* All NUMA DRNGs seeded? */
+			bool all_online_numa_node_seeded;
+			/* IRQ noise source status info */
+			struct lrng_irq_info irq_info;
+			/* Serialize read of entropy pool */
+			spinlock_t lock;
+		};
+		/*
+		 * Static SHA-1 implementation in lrng_cc20_hash_buffer
+		 * processes data 64-byte-wise. Hence, ensure proper size
+		 * of LRNG entropy pool data structure.
+		 */
+		u8 hash_input_buf[LRNG_POOL_SIZE_BYTES + 64];
+	};
+};
+
+static struct lrng_pool lrng_pool __aligned(LRNG_KCAPI_ALIGN) =3D {
+	.irq_info	=3D {
+		.irq_entropy_bits	=3D LRNG_IRQ_ENTROPY_BITS,
+		.num_events_thresh	=3D ATOMIC_INIT(LRNG_INIT_ENTROPY_BITS +
+						LRNG_CONDITIONING_ENTROPY_LOSS),
+		/* Sample IRQ pointer data at least during boot */
+		.irq_highres_timer	=3D false },
+	.lock		=3D __SPIN_LOCK_UNLOCKED(lrng_pool.lock)
+};
+
+static struct lrng_state lrng_state =3D { false, false, false, };
+
+/********************************** Helper *******************************=
****/
+
+void lrng_state_init_seed_work(void)
+{
+	INIT_WORK(&lrng_state.lrng_seed_work, lrng_sdrng_seed_work);
+}
+
+static inline u32 lrng_entropy_to_data(u32 entropy_bits)
+{
+	return ((entropy_bits * lrng_pool.irq_info.irq_entropy_bits) /
+		LRNG_DRNG_SECURITY_STRENGTH_BITS);
+}
+
+static inline u32 lrng_data_to_entropy(u32 irqnum)
+{
+	return ((irqnum * LRNG_DRNG_SECURITY_STRENGTH_BITS) /
+		lrng_pool.irq_info.irq_entropy_bits);
+}
+
+u32 lrng_avail_entropy(void)
+{
+	return min_t(u32, LRNG_POOL_SIZE_BITS, lrng_data_to_entropy(
+			atomic_read_u32(&lrng_pool.irq_info.num_events)));
+}
+
+void lrng_set_entropy_thresh(u32 new)
+{
+	atomic_set(&lrng_pool.irq_info.num_events_thresh,
+		   lrng_entropy_to_data(new));
+}
+
+/*
+ * Reading of the LRNG pool is only allowed by one caller. The reading is
+ * only performed to (re)seed the TRNG or SDRNGs. Thus, if this "lock" is
+ * already taken, the reseeding operation is in progress. The caller is not
+ * intended to wait but continue with its other operation.
+ */
+int lrng_pool_trylock(void)
+{
+	return atomic_cmpxchg(&lrng_pool.irq_info.reseed_in_progress, 0, 1);
+}
+
+void lrng_pool_unlock(void)
+{
+	atomic_set(&lrng_pool.irq_info.reseed_in_progress, 0);
+}
+
+void lrng_reset_state(void)
+{
+	struct lrng_irq_info *irq_info =3D &lrng_pool.irq_info;
+
+	atomic_set(&irq_info->num_events, 0);
+	lrng_state.lrng_operational =3D false;
+	lrng_state.lrng_fully_seeded =3D false;
+	lrng_state.lrng_min_seeded =3D false;
+	pr_debug("reset LRNG\n");
+}
+
+void lrng_pool_all_numa_nodes_seeded(void)
+{
+	lrng_pool.all_online_numa_node_seeded =3D true;
+}
+
+bool lrng_state_min_seeded(void)
+{
+	return lrng_state.lrng_min_seeded;
+}
+
+bool lrng_state_fully_seeded(void)
+{
+	return lrng_state.lrng_fully_seeded;
+}
+
+bool lrng_state_operational(void)
+{
+	return lrng_state.lrng_operational;
+}
+
+bool lrng_pool_highres_timer(void)
+{
+	return lrng_pool.irq_info.irq_highres_timer;
+}
+
+void lrng_pool_set_entropy(u32 entropy_bits)
+{
+	atomic_set(&lrng_pool.irq_info.num_events,
+		   lrng_entropy_to_data(entropy_bits));
+}
+
+void lrng_pool_configure(bool highres_timer, u32 irq_entropy_bits)
+{
+	struct lrng_irq_info *irq_info =3D &lrng_pool.irq_info;
+
+	irq_info->irq_highres_timer =3D highres_timer;
+	if (irq_info->irq_entropy_bits !=3D irq_entropy_bits) {
+		irq_info->irq_entropy_bits =3D irq_entropy_bits;
+		/* Reset the threshold based on new oversampling factor. */
+		lrng_set_entropy_thresh(atomic_read_u32(
+						&irq_info->num_events_thresh));
+	}
+}
+
+/* invoke function with buffer aligned to 4 bytes */
+void lrng_pool_lfsr(const u8 *buf, u32 buflen)
+{
+	u32 *p_buf =3D (u32 *)buf;
+
+	for (; buflen >=3D 4; buflen -=3D 4)
+		lrng_pool_lfsr_u32(*p_buf++);
+
+	buf =3D (u8 *)p_buf;
+	while (buflen--)
+		lrng_pool_lfsr_u32(*buf++);
+}
+
+void lrng_pool_lfsr_nonaligned(const u8 *buf, u32 buflen)
+{
+	while (buflen) {
+		if (!((unsigned long)buf & (sizeof(u32) - 1))) {
+			lrng_pool_lfsr(buf, buflen);
+			return;
+		}
+
+		lrng_pool_lfsr_u32(*buf++);
+		buflen--;
+	}
+}
+
+/**************************** Interrupt processing ***********************=
*****/
+
+/*
+ * Implement a (modified) twisted Generalized Feedback Shift Register. (Se=
e M.
+ * Matsumoto & Y. Kurita, 1992.  Twisted GFSR generators. ACM Transactions=
 on
+ * Modeling and Computer Simulation 2(3):179-194.  Also see M. Matsumoto &=
 Y.
+ * Kurita, 1994.  Twisted GFSR generators II.  ACM Transactions on Modelin=
g and
+ * Computer Simulation 4:254-266).
+ */
+static u32 const lrng_twist_table[8] =3D {
+	0x00000000, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
+	0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
+
+/*
+ * The polynomials for the LFSR are taken from the document "Table of Line=
ar
+ * Feedback Shift Registers" by Roy Ward, Tim Molteno, October 26, 2007.
+ * The first polynomial is from "Primitive Binary Polynomials" by Wayne
+ * Stahnke (1973) and is primitive as well as irreducible.
+ *
+ * Note, the tap values are smaller by one compared to the documentation b=
ecause
+ * they are used as an index into an array where the index starts by zero.
+ *
+ * All polynomials were also checked to be primitive and irreducible with =
magma
+ * which ensures that the key property of the LFSR providing a compression
+ * function for entropy is guaranteed.
+ */
+static u32 const lrng_lfsr_polynomial[][4] =3D {
+	{ 127, 28, 26, 1 },			/* 128 words by Stahnke */
+	{ 255, 253, 250, 245 },			/* 256 words */
+	{ 511, 509, 506, 503 },			/* 512 words */
+	{ 1023, 1014, 1001, 1000 },		/* 1024 words */
+	{ 2047, 2034, 2033, 2028 },		/* 2048 words */
+	{ 4095, 4094, 4080, 4068 },		/* 4096 words */
+};
+
+/**
+ * Hot code path - inject data into entropy pool using LFSR
+ */
+void lrng_pool_lfsr_u32(u32 value)
+{
+	/*
+	 * Process the LFSR by altering not adjacent words but rather
+	 * more spaced apart words. Using a prime number ensures that all words
+	 * are processed evenly. As some the LFSR polynomials taps are close
+	 * together, processing adjacent words with the LSFR taps may be
+	 * inappropriate as the data just mixed-in at these taps may be not
+	 * independent from the current data to be mixed in.
+	 */
+	u32 ptr =3D (u32)atomic_add_return_relaxed(67, &lrng_pool.pool_ptr) &
+							(LRNG_POOL_SIZE - 1);
+	/*
+	 * Add 7 bits of rotation to the pool. At the beginning of the
+	 * pool, add an extra 7 bits rotation, so that successive passes
+	 * spread the input bits across the pool evenly.
+	 *
+	 * Note, there is a race between getting ptr and calculating
+	 * input_rotate when ptr is is obtained on two or more CPUs at the
+	 * same time. This race is irrelevant as it may only come into effect
+	 * if 3 or more CPUs race at the same time which is very unlikely. If
+	 * the race happens, it applies to one event only. As this rolling
+	 * supports the LFSR without being strictly needed, we accept this
+	 * race.
+	 */
+	u32 input_rotate =3D (u32)atomic_add_return_relaxed((ptr ? 7 : 14),
+					&lrng_pool.input_rotate) & 31;
+	u32 word =3D rol32(value, input_rotate);
+
+	BUILD_BUG_ON(LRNG_POOL_SIZE - 1 !=3D
+		     lrng_lfsr_polynomial[CONFIG_LRNG_POOL_SIZE][0]);
+	word ^=3D atomic_read_u32(&lrng_pool.pool[ptr]);
+	word ^=3D atomic_read_u32(&lrng_pool.pool[
+		(ptr + lrng_lfsr_polynomial[CONFIG_LRNG_POOL_SIZE][0]) &
+		       (LRNG_POOL_SIZE - 1)]);
+	word ^=3D atomic_read_u32(&lrng_pool.pool[
+		(ptr + lrng_lfsr_polynomial[CONFIG_LRNG_POOL_SIZE][1]) &
+		       (LRNG_POOL_SIZE - 1)]);
+	word ^=3D atomic_read_u32(&lrng_pool.pool[
+		(ptr + lrng_lfsr_polynomial[CONFIG_LRNG_POOL_SIZE][2]) &
+		       (LRNG_POOL_SIZE - 1)]);
+	word ^=3D atomic_read_u32(&lrng_pool.pool[
+		(ptr + lrng_lfsr_polynomial[CONFIG_LRNG_POOL_SIZE][3]) &
+		       (LRNG_POOL_SIZE - 1)]);
+
+	word =3D (word >> 3) ^ lrng_twist_table[word & 7];
+	atomic_set(&lrng_pool.pool[ptr], word);
+}
+
+/**
+ * Hot code path - mix data into entropy pool
+ */
+void lrng_pool_add_irq(u32 irq_num)
+{
+	struct lrng_irq_info *irq_info =3D &lrng_pool.irq_info;
+
+	atomic_add(irq_num, &irq_info->num_events);
+
+	/* Wake sleeping readers */
+	lrng_reader_wakeup();
+
+	/*
+	 * Once all secondary DRNGs are fully seeded, the interrupt noise
+	 * sources will not trigger any reseeding any more.
+	 */
+	if (likely(lrng_pool.all_online_numa_node_seeded))
+		return;
+
+	/* Only try to reseed if the DRNG is alive. */
+	if (!lrng_get_available())
+		return;
+
+	/* Only trigger the DRNG reseed if we have collected enough IRQs. */
+	if (atomic_read_u32(&lrng_pool.irq_info.num_events) <
+	    atomic_read_u32(&lrng_pool.irq_info.num_events_thresh))
+		return;
+
+	/* Ensure that the seeding only occurs once at any given time. */
+	if (lrng_pool_trylock())
+		return;
+
+	/* Seed the DRNG with IRQ noise. */
+	schedule_work(&lrng_state.lrng_seed_work);
+}
+
+void lrng_pool_add_entropy(u32 entropy_bits)
+{
+	lrng_pool_add_irq(lrng_entropy_to_data(entropy_bits));
+}
+
+/**
+ * Generate a hashed output of pool using the SP800-90A section 10.3.1 has=
h_df
+ * function
+ */
+static inline u32 lrng_pool_hash_df(const struct lrng_crypto_cb *crypto_cb,
+				    void *hash, u8 *outbuf, u32 requested_bits)
+{
+	struct lrng_pool *pool =3D &lrng_pool;
+	u32 digestsize, requested_bytes =3D requested_bits >> 3,
+	    generated_bytes =3D 0;
+	u8 digest[64] __aligned(LRNG_KCAPI_ALIGN);
+
+	digestsize =3D crypto_cb->lrng_hash_digestsize(hash);
+	if (digestsize > sizeof(digest)) {
+		pr_err("Digest buffer too small\n");
+		return 0;
+	}
+
+	pool->counter =3D 1;
+	pool->requested_bits =3D cpu_to_be32(requested_bytes << 3);
+
+	while (requested_bytes) {
+		u32 tocopy =3D min_t(u32, requested_bytes, digestsize);
+
+		/* The counter must not wrap */
+		if (pool->counter =3D=3D 0)
+			goto out;
+
+		if (crypto_cb->lrng_hash_buffer(hash, (u8 *)pool,
+						LRNG_POOL_SIZE_BYTES + 64,
+						digest))
+			goto out;
+
+		/* Copy the data out to the caller */
+		memcpy(outbuf + generated_bytes, digest, tocopy);
+		requested_bytes -=3D tocopy;
+		generated_bytes +=3D tocopy;
+		pool->counter++;
+	}
+
+out:
+	/* Mix read data back into pool for backtracking resistance */
+	if (generated_bytes)
+		lrng_pool_lfsr(outbuf, generated_bytes);
+	memzero_explicit(digest, digestsize);
+	return (generated_bytes<<3);
+}
+
+/**
+ * Read the entropy pool out for use.
+ *
+ * This function handles the translation from the number of received inter=
rupts
+ * into an entropy statement. The conversion depends on LRNG_IRQ_ENTROPY_B=
ITS
+ * which defines how many interrupts must be received to obtain 256 bits of
+ * entropy. With this value, the function lrng_data_to_entropy converts a =
given
+ * data size (received interrupts, requested amount of data, etc.) into an
+ * entropy statement. lrng_entropy_to_data does the reverse.
+ *
+ * Both functions are agnostic about the type of data: when the number of
+ * interrupts is processed by these functions, the resulting entropy value=
 is in
+ * bits as we assume the entropy of interrupts is measured in bits. When d=
ata is
+ * processed, the entropy value is in bytes as the data is measured in byt=
es.
+ *
+ * @outbuf: buffer to store data in with size LRNG_DRNG_SECURITY_STRENGTH_=
BYTES
+ * @requested_entropy_bits: requested bits of entropy -- the function will
+ *			    return at least this amount of entropy if available
+ * @drain: boolean indicating that that all entropy of pool can be used
+ *	   (otherwise some emergency amount of entropy is left)
+ * @return: estimated entropy from the IRQs that was obtained
+ */
+static u32 lrng_get_pool(const struct lrng_crypto_cb *crypto_cb, void *has=
h,
+			 u8 *outbuf, u32 requested_entropy_bits, bool drain)
+{
+	struct lrng_pool *pool =3D &lrng_pool;
+	unsigned long flags;
+	u32 irq_num_events_used, irq_num_events, avail_entropy_bits;
+
+	/* This get_pool operation must only be called once at a given time! */
+	spin_lock_irqsave(&pool->lock, flags);
+
+	/* How many unused interrupts are in entropy pool? */
+	irq_num_events =3D atomic_read_u32(&lrng_pool.irq_info.num_events);
+	/* Convert available interrupts into entropy statement */
+	avail_entropy_bits =3D lrng_data_to_entropy(irq_num_events);
+
+	/* Cap available entropy to pool size */
+	avail_entropy_bits =3D
+			min_t(u32, avail_entropy_bits, LRNG_POOL_SIZE_BITS);
+
+	/* How much entropy we need to and can we use? */
+	if (drain) {
+		struct lrng_state *state =3D &lrng_state;
+
+		/* read for the TRNG or not fully seeded 2ndary DRNG */
+		if (!state->lrng_fully_seeded) {
+			/*
+			 * During boot time, we read 256 bits data with
+			 * avail_entropy_bits entropy. In case our conservative
+			 * entropy estimate underestimates the available entropy
+			 * we can transport as much available entropy as
+			 * possible. The primary DRNG is no TRNG yet.
+			 */
+			requested_entropy_bits =3D
+					LRNG_DRNG_SECURITY_STRENGTH_BITS;
+		} else {
+			requested_entropy_bits =3D min_t(u32, avail_entropy_bits,
+						       requested_entropy_bits);
+		}
+	} else {
+		/*
+		 * Read for 2ndary DRNG: leave the emergency fill level.
+		 *
+		 * Only obtain data if we have at least the requested entropy
+		 * available. The idea is to prevent the transfer of, say
+		 * one byte at a time, because one byte of entropic data
+		 * can be brute forced by an attacker.
+		 */
+		if ((requested_entropy_bits + LRNG_EMERG_ENTROPY) >
+		     avail_entropy_bits) {
+			requested_entropy_bits =3D 0;
+			goto out;
+		}
+	}
+
+	/* Hash is a compression function: we generate entropy amount of data */
+	requested_entropy_bits =3D round_down(requested_entropy_bits, 8);
+
+	requested_entropy_bits =3D lrng_pool_hash_df(crypto_cb, hash, outbuf,
+						   requested_entropy_bits);
+
+	/* Boot time: After getting the full buffer adjust the entropy value. */
+	requested_entropy_bits =3D min_t(u32, avail_entropy_bits,
+				       requested_entropy_bits);
+
+out:
+	/* Convert used entropy into interrupt number for subtraction */
+	irq_num_events_used =3D lrng_entropy_to_data(requested_entropy_bits);
+
+	/*
+	 * The hash_df operation entropy assessment shows that the output
+	 * entropy is one bit smaller than the input entropy. Therefore we
+	 * account for this one bit of entropy here: if we have sufficient
+	 * entropy in the LFSR, we say we used one bit of entropy more.
+	 * Otherwise we reduce the amount of entropy we say we generated with
+	 * the hash_df.
+	 */
+	if ((irq_num_events_used + LRNG_CONDITIONING_ENTROPY_LOSS) <=3D
+	    lrng_entropy_to_data(avail_entropy_bits)) {
+		irq_num_events_used +=3D LRNG_CONDITIONING_ENTROPY_LOSS;
+	} else {
+		if (unlikely(requested_entropy_bits <
+			     LRNG_CONDITIONING_ENTROPY_LOSS))
+			requested_entropy_bits =3D 0;
+		else
+			requested_entropy_bits -=3D
+						LRNG_CONDITIONING_ENTROPY_LOSS;
+	}
+
+	/*
+	 * New events might have arrived in the meanwhile and we don't
+	 * want to throw them away unconditionally. On the other hand,
+	 * these new events might have been mixed in before
+	 * lrng_hash_df_pool() had been able to draw any entropy
+	 * from the pool and thus, the pool capacity might have been
+	 * exceeded at some point. Note that in theory, some events
+	 * might get lost inbetween the atomic_read() and
+	 * atomic_set() below. But that's fine, because it's no real
+	 * concern while code preventing this would come at the cost of
+	 * additional complexity. Likewise, some events which arrived
+	 * after full or partial completion of the __lrng_hash_df_pool()
+	 * above might get unnecessarily thrown away by the min()
+	 * operation below; the same argument applies there.
+	 */
+	irq_num_events =3D atomic_read_u32(&lrng_pool.irq_info.num_events);
+	irq_num_events =3D min_t(u32, irq_num_events,
+			       lrng_entropy_to_data(LRNG_POOL_SIZE_BITS));
+	irq_num_events -=3D irq_num_events_used;
+	atomic_set(&lrng_pool.irq_info.num_events, irq_num_events);
+
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	/* Obtain entropy statement in bits from the used entropy */
+	pr_debug("obtained %u bits of entropy from %u newly collected "
+		 "interrupts - not using %u interrupts\n",
+		 requested_entropy_bits, irq_num_events_used,
+		 irq_num_events);
+
+	return requested_entropy_bits;
+}
+
+/* Fill the seed buffer with data from the noise sources */
+int lrng_fill_seed_buffer(const struct lrng_crypto_cb *crypto_cb, void *ha=
sh,
+			  struct entropy_buf *entropy_buf, bool drain)
+{
+	struct lrng_state *state =3D &lrng_state;
+	u32 total_entropy_bits =3D 0;
+
+	/* Require at least 128 bits of entropy for any reseed. */
+	if (state->lrng_fully_seeded &&
+	    lrng_avail_entropy() <
+	    lrng_slow_noise_req_entropy(lrng_read_wakeup_bits))
+		goto wakeup;
+
+	/* Drain the pool completely during init and when /dev/random calls. */
+	total_entropy_bits =3D lrng_get_pool(crypto_cb, hash, entropy_buf->a,
+					   LRNG_DRNG_SECURITY_STRENGTH_BITS,
+					   drain);
+
+	/*
+	 * Concatenate the output of the noise sources. This would be the
+	 * spot to add an entropy extractor logic if desired. Note, this
+	 * has the ability to collect entropy equal or larger than the DRNG
+	 * strength to be able to feed /dev/random.
+	 */
+	total_entropy_bits +=3D lrng_get_arch(entropy_buf->b);
+	total_entropy_bits +=3D lrng_get_jent(entropy_buf->c,
+					    LRNG_DRNG_SECURITY_STRENGTH_BYTES);
+
+	/* also reseed the DRNG with the current time stamp */
+	entropy_buf->now =3D random_get_entropy();
+
+wakeup:
+	/*
+	 * Shall we wake up user space writers? This location covers
+	 * /dev/urandom as well, but also ensures that the user space provider
+	 * does not dominate the internal noise sources since in case the
+	 * first call of this function finds sufficient entropy in the TRNG, it
+	 * will not trigger the wakeup. This implies that when the next
+	 * /dev/urandom read happens, the TRNG is drained and the internal
+	 * noise sources are asked to feed the TRNG.
+	 */
+	lrng_writer_wakeup();
+
+	return total_entropy_bits;
+}
+
+/**
+ * Set the slow noise source reseed trigger threshold. The initial thresho=
ld
+ * is set to the minimum data size that can be read from the pool: a word.=
 Upon
+ * reaching this value, the next seed threshold of 128 bits is set followed
+ * by 256 bits.
+ *
+ * @entropy_bits: size of entropy currently injected into DRNG
+ */
+void lrng_init_ops(u32 seed_bits)
+{
+	struct lrng_state *state =3D &lrng_state;
+
+	if (state->lrng_operational)
+		return;
+
+	/* DRNG is seeded with full security strength */
+	if (state->lrng_fully_seeded) {
+		state->lrng_operational =3D lrng_sp80090b_startup_complete();
+		lrng_init_wakeup();
+	} else if (seed_bits >=3D LRNG_FULL_SEED_ENTROPY_BITS) {
+		invalidate_batched_entropy();
+		state->lrng_fully_seeded =3D true;
+		state->lrng_operational =3D lrng_sp80090b_startup_complete();
+		state->lrng_min_seeded =3D true;
+		pr_info("LRNG fully seeded with %u bits of entropy\n",
+			seed_bits);
+		lrng_set_entropy_thresh(LRNG_FULL_SEED_ENTROPY_BITS +
+					LRNG_CONDITIONING_ENTROPY_LOSS);
+		lrng_process_ready_list();
+		lrng_init_wakeup();
+
+	} else if (!state->lrng_min_seeded) {
+
+		/* DRNG is seeded with at least 128 bits of entropy */
+		if (seed_bits >=3D LRNG_MIN_SEED_ENTROPY_BITS) {
+			invalidate_batched_entropy();
+			state->lrng_min_seeded =3D true;
+			pr_info("LRNG minimally seeded with %u bits of "
+				"entropy\n", seed_bits);
+			lrng_set_entropy_thresh(
+				lrng_slow_noise_req_entropy(
+					LRNG_FULL_SEED_ENTROPY_BITS +
+					LRNG_CONDITIONING_ENTROPY_LOSS));
+			lrng_process_ready_list();
+			lrng_init_wakeup();
+
+		/* DRNG is seeded with at least LRNG_INIT_ENTROPY_BITS bits */
+		} else if (seed_bits >=3D LRNG_INIT_ENTROPY_BITS) {
+			pr_info("LRNG initial entropy level %u bits of "
+				"entropy\n", seed_bits);
+			lrng_set_entropy_thresh(
+				lrng_slow_noise_req_entropy(
+					LRNG_MIN_SEED_ENTROPY_BITS +
+					LRNG_CONDITIONING_ENTROPY_LOSS));
+		}
+	}
+}
+
+int __init rand_initialize(void)
+{
+	ktime_t now_time =3D ktime_get_real();
+	unsigned int i, rand;
+
+	lrng_pool_lfsr_u32(now_time);
+	for (i =3D 0; i < LRNG_POOL_SIZE; i++) {
+		if (!arch_get_random_seed_int(&rand) &&
+		    !arch_get_random_int(&rand))
+			rand =3D random_get_entropy();
+		lrng_pool_lfsr_u32(rand);
+	}
+	lrng_pool_lfsr_nonaligned((u8 *)utsname(), sizeof(*(utsname())));
+
+	return 0;
+}
diff --git a/drivers/char/lrng/lrng_sdrng.c b/drivers/char/lrng/lrng_sdrng.c
new file mode 100644
index 000000000000..570e9b34ddfd
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_sdrng.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG secondary DRNG processing
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/lrng.h>
+
+#include "lrng_internal.h"
+
+/*
+ * Maximum number of seconds between DRNG reseed intervals of the secondary
+ * DRNG. Note, this is enforced with the next request of random numbers fr=
om
+ * the secondary DRNG. Setting this value to zero implies a reseeding atte=
mpt
+ * before every generated random number.
+ */
+int lrng_sdrng_reseed_max_time =3D 600;
+
+static atomic_t lrng_avail =3D ATOMIC_INIT(0);
+
+DEFINE_MUTEX(lrng_crypto_cb_update);
+
+/* Secondary DRNG for /dev/urandom, getrandom(2), get_random_bytes */
+static struct lrng_sdrng lrng_sdrng_init =3D {
+	.sdrng		=3D &secondary_chacha20,
+	.crypto_cb	=3D &lrng_cc20_crypto_cb,
+	.lock		=3D __MUTEX_INITIALIZER(lrng_sdrng_init.lock),
+	.spin_lock	=3D __SPIN_LOCK_UNLOCKED(lrng_sdrng_init.spin_lock)
+};
+
+/*
+ * Secondary DRNG for get_random_bytes when called in atomic context. This
+ * DRNG will always use the ChaCha20 DRNG. It will never benefit from a
+ * DRNG switch like the "regular" secondary DRNG. If there was no DRNG
+ * switch, the atomic secondary DRNG is identical to the "regular" seconda=
ry
+ * DRNG.
+ *
+ * The reason for having this is due to the fact that DRNGs other than
+ * the ChaCha20 DRNG may sleep.
+ */
+static struct lrng_sdrng lrng_sdrng_atomic =3D {
+	.sdrng		=3D &secondary_chacha20,
+	.crypto_cb	=3D &lrng_cc20_crypto_cb,
+	.spin_lock	=3D __SPIN_LOCK_UNLOCKED(lrng_sdrng_atomic.spin_lock)
+};
+
+/********************************** Helper *******************************=
*****/
+
+bool lrng_get_available(void)
+{
+	return likely(atomic_read(&lrng_avail));
+}
+
+void lrng_set_available(void)
+{
+	atomic_set(&lrng_avail, 1);
+}
+
+struct lrng_sdrng *lrng_sdrng_init_instance(void)
+{
+	return &lrng_sdrng_init;
+}
+
+struct lrng_sdrng *lrng_sdrng_atomic_instance(void)
+{
+	return &lrng_sdrng_atomic;
+}
+
+void lrng_sdrng_reset(struct lrng_sdrng *sdrng)
+{
+	atomic_set(&sdrng->requests, LRNG_DRNG_RESEED_THRESH);
+	sdrng->last_seeded =3D jiffies;
+	sdrng->fully_seeded =3D false;
+	sdrng->force_reseed =3D true;
+	pr_debug("reset secondary DRNG\n");
+}
+
+/************************* Random Number Generation **********************=
*****/
+
+/* Inject a data buffer into the secondary DRNG */
+static void lrng_sdrng_inject(struct lrng_sdrng *sdrng,
+			      const u8 *inbuf, u32 inbuflen)
+{
+	const char *drng_type =3D unlikely(sdrng =3D=3D &lrng_sdrng_atomic) ?
+				"atomic" : "secondary";
+	unsigned long flags =3D 0;
+
+	BUILD_BUG_ON(LRNG_DRNG_RESEED_THRESH > INT_MAX);
+	pr_debug("seeding %s DRNG with %u bytes\n", drng_type, inbuflen);
+	lrng_sdrng_lock(sdrng, &flags);
+	if (sdrng->crypto_cb->lrng_drng_seed_helper(sdrng->sdrng,
+						    inbuf, inbuflen) < 0) {
+		pr_warn("seeding of %s DRNG failed\n", drng_type);
+		atomic_set(&sdrng->requests, 1);
+	} else {
+		pr_debug("%s DRNG stats since last seeding: %lu secs; "
+			 "generate calls: %d\n", drng_type,
+			 (time_after(jiffies, sdrng->last_seeded) ?
+			  (jiffies - sdrng->last_seeded) : 0) / HZ,
+			 (LRNG_DRNG_RESEED_THRESH -
+			  atomic_read(&sdrng->requests)));
+		sdrng->last_seeded =3D jiffies;
+		atomic_set(&sdrng->requests, LRNG_DRNG_RESEED_THRESH);
+		sdrng->force_reseed =3D false;
+
+		if (sdrng->sdrng =3D=3D lrng_sdrng_atomic.sdrng) {
+			lrng_sdrng_atomic.last_seeded =3D jiffies;
+			atomic_set(&lrng_sdrng_atomic.requests,
+				   LRNG_DRNG_RESEED_THRESH);
+			lrng_sdrng_atomic.force_reseed =3D false;
+		}
+	}
+	lrng_sdrng_unlock(sdrng, &flags);
+}
+
+#ifdef CONFIG_LRNG_TRNG_SUPPORT
+static inline int _lrng_sdrng_seed(struct lrng_sdrng *sdrng)
+{
+	u8 seedbuf[LRNG_DRNG_SECURITY_STRENGTH_BYTES]
+						__aligned(LRNG_KCAPI_ALIGN);
+	int ret =3D lrng_trng_seed(seedbuf, sizeof(seedbuf), false,
+				 !sdrng->fully_seeded);
+
+	/* Update the DRNG state even though we received zero random data */
+	if (ret < 0) {
+		/*
+		 * Try to reseed at next round - note if EINPROGRESS is returned
+		 * the request counter may fall below zero in case of parallel
+		 * operations. We accept such "underflow" temporarily as the
+		 * counter will be set back to a positive number in the course
+		 * of the reseed. For these few generate operations under
+		 * heavy parallel strain of /dev/urandom we therefore exceed
+		 * the LRNG_DRNG_RESEED_THRESH threshold.
+		 */
+		if (ret !=3D -EINPROGRESS)
+			atomic_set(&sdrng->requests, 1);
+		return ret;
+	}
+
+	lrng_sdrng_inject(sdrng, seedbuf, sizeof(seedbuf));
+	memzero_explicit(seedbuf, sizeof(seedbuf));
+
+	return ret;
+}
+#else	/* CONFIG_LRNG_TRNG_SUPPORT */
+static inline int _lrng_sdrng_seed(struct lrng_sdrng *sdrng)
+{
+	struct entropy_buf seedbuf __aligned(LRNG_KCAPI_ALIGN);
+	unsigned long flags =3D 0;
+	u32 total_entropy_bits;
+	int ret;
+
+	lrng_sdrng_lock(sdrng, &flags);
+	total_entropy_bits =3D lrng_fill_seed_buffer(sdrng->crypto_cb,
+						   sdrng->hash, &seedbuf, true);
+	lrng_sdrng_unlock(sdrng, &flags);
+
+	/* Allow the seeding operation to be called again */
+	lrng_pool_unlock();
+	lrng_init_ops(total_entropy_bits);
+	ret =3D total_entropy_bits >> 3;
+
+	lrng_sdrng_inject(sdrng, (u8 *)&seedbuf, sizeof(seedbuf));
+	memzero_explicit(&seedbuf, sizeof(seedbuf));
+
+	return ret;
+}
+#endif	/* CONFIG_LRNG_TRNG_SUPPORT */
+
+static int lrng_sdrng_get(struct lrng_sdrng *sdrng, u8 *outbuf, u32 outbuf=
len);
+static void lrng_sdrng_seed(struct lrng_sdrng *sdrng)
+{
+	int ret =3D _lrng_sdrng_seed(sdrng);
+
+	if (ret >=3D LRNG_DRNG_SECURITY_STRENGTH_BYTES)
+		sdrng->fully_seeded =3D true;
+
+	BUILD_BUG_ON(LRNG_MIN_SEED_ENTROPY_BITS >
+		     LRNG_DRNG_SECURITY_STRENGTH_BITS);
+
+	/*
+	 * Reseed atomic DRNG from current secondary DRNG,
+	 *
+	 * We can obtain random numbers from secondary DRNG as the lock type
+	 * chosen by lrng_sdrng_get is usable with the current caller.
+	 */
+	if ((sdrng->sdrng !=3D lrng_sdrng_atomic.sdrng) &&
+	    (lrng_sdrng_atomic.force_reseed ||
+	     atomic_read(&lrng_sdrng_atomic.requests) <=3D 0 ||
+	     time_after(jiffies, lrng_sdrng_atomic.last_seeded +
+			lrng_sdrng_reseed_max_time * HZ))) {
+		u8 seedbuf[LRNG_DRNG_SECURITY_STRENGTH_BYTES]
+						__aligned(LRNG_KCAPI_ALIGN);
+
+		ret =3D lrng_sdrng_get(sdrng, seedbuf, sizeof(seedbuf));
+
+		if (ret < 0) {
+			pr_warn("Error generating random numbers for atomic "
+				"DRNG: %d\n", ret);
+		} else {
+			lrng_sdrng_inject(&lrng_sdrng_atomic, seedbuf, ret);
+		}
+		memzero_explicit(&seedbuf, sizeof(seedbuf));
+	}
+}
+
+static inline void _lrng_sdrng_seed_work(struct lrng_sdrng *sdrng, u32 nod=
e)
+{
+	pr_debug("reseed triggered by interrupt noise source "
+		 "for secondary DRNG on NUMA node %d\n", node);
+	lrng_sdrng_seed(sdrng);
+	if (sdrng->fully_seeded) {
+		/* Prevent reseed storm */
+		sdrng->last_seeded +=3D node * 100 * HZ;
+		/* Prevent draining of pool on idle systems */
+		lrng_sdrng_reseed_max_time +=3D 100;
+	}
+}
+
+/**
+ * DRNG reseed trigger: Kernel thread handler triggered by the schedule_wo=
rk()
+ */
+void lrng_sdrng_seed_work(struct work_struct *dummy)
+{
+	struct lrng_sdrng **lrng_sdrng =3D lrng_sdrng_instances();
+	u32 node;
+
+	if (lrng_sdrng) {
+		for_each_online_node(node) {
+			struct lrng_sdrng *sdrng =3D lrng_sdrng[node];
+
+			if (sdrng && !sdrng->fully_seeded) {
+				_lrng_sdrng_seed_work(sdrng, node);
+				goto out;
+			}
+		}
+		lrng_pool_all_numa_nodes_seeded();
+	} else {
+		if (!lrng_sdrng_init.fully_seeded)
+			_lrng_sdrng_seed_work(&lrng_sdrng_init, 0);
+	}
+
+out:
+	/* Allow the seeding operation to be called again */
+	lrng_pool_unlock();
+}
+
+/* Force all secondary DRNGs to reseed before next generation */
+void lrng_sdrng_force_reseed(void)
+{
+	struct lrng_sdrng **lrng_sdrng =3D lrng_sdrng_instances();
+	u32 node;
+
+	if (!lrng_sdrng) {
+		lrng_sdrng_init.force_reseed =3D true;
+		pr_debug("force reseed of initial secondary DRNG\n");
+		return;
+	}
+	for_each_online_node(node) {
+		struct lrng_sdrng *sdrng =3D lrng_sdrng[node];
+
+		if (!sdrng)
+			continue;
+
+		sdrng->force_reseed =3D true;
+		pr_debug("force reseed of secondary DRNG on node %u\n", node);
+	}
+	lrng_sdrng_atomic.force_reseed =3D true;
+}
+
+/**
+ * Get random data out of the secondary DRNG which is reseeded frequently.
+ *
+ * @outbuf: buffer for storing random data
+ * @outbuflen: length of outbuf
+ * @return: < 0 in error case (DRNG generation or update failed)
+ *	    >=3D0 returning the returned number of bytes
+ */
+static int lrng_sdrng_get(struct lrng_sdrng *sdrng, u8 *outbuf, u32 outbuf=
len)
+{
+	unsigned long flags =3D 0;
+	u32 processed =3D 0;
+
+	if (!outbuf || !outbuflen)
+		return 0;
+
+	outbuflen =3D min_t(size_t, outbuflen, INT_MAX);
+
+	lrng_drngs_init_cc20();
+
+	while (outbuflen) {
+		u32 todo =3D min_t(u32, outbuflen, LRNG_DRNG_MAX_REQSIZE);
+		int ret;
+
+		/* All but the atomic DRNG are seeded during generation */
+		if (atomic_dec_and_test(&sdrng->requests) ||
+		    sdrng->force_reseed ||
+		    time_after(jiffies, sdrng->last_seeded +
+			       lrng_sdrng_reseed_max_time * HZ)) {
+			if (likely(sdrng !=3D &lrng_sdrng_atomic)) {
+				if (lrng_pool_trylock())
+					atomic_set(&sdrng->requests, 1);
+				else
+					lrng_sdrng_seed(sdrng);
+			}
+		}
+
+		lrng_sdrng_lock(sdrng, &flags);
+		ret =3D sdrng->crypto_cb->lrng_drng_generate_helper(
+					sdrng->sdrng, outbuf + processed, todo);
+		lrng_sdrng_unlock(sdrng, &flags);
+		if (ret <=3D 0) {
+			pr_warn("getting random data from secondary DRNG "
+				"failed (%d)\n", ret);
+			return -EFAULT;
+		}
+		processed +=3D ret;
+		outbuflen -=3D ret;
+	}
+
+	return processed;
+}
+
+int lrng_sdrng_get_atomic(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_sdrng_get(&lrng_sdrng_atomic, outbuf, outbuflen);
+}
+
+int lrng_sdrng_get_sleep(u8 *outbuf, u32 outbuflen)
+{
+	struct lrng_sdrng **lrng_sdrng =3D lrng_sdrng_instances();
+	struct lrng_sdrng *sdrng =3D &lrng_sdrng_init;
+	int node =3D numa_node_id();
+
+	might_sleep();
+
+	if (lrng_sdrng && lrng_sdrng[node] && lrng_sdrng[node]->fully_seeded)
+		sdrng =3D lrng_sdrng[node];
+
+	return lrng_sdrng_get(sdrng, outbuf, outbuflen);
+}
+
+/* Initialize the default DRNG during boot */
+void lrng_drngs_init_cc20(void)
+{
+	unsigned long flags =3D 0;
+
+	if (lrng_get_available())
+		return;
+
+	lrng_sdrng_lock(&lrng_sdrng_init, &flags);
+	if (lrng_get_available()) {
+		lrng_sdrng_unlock(&lrng_sdrng_init, &flags);
+		return;
+	}
+
+	if (random_get_entropy() || random_get_entropy()) {
+		/*
+		 * As the highres timer is identified here, previous interrupts
+		 * obtained during boot time are treated like a lowres-timer
+		 * would have been present.
+		 */
+		lrng_pool_configure(true, LRNG_IRQ_ENTROPY_BITS);
+	} else {
+		lrng_health_disable();
+		lrng_pool_configure(false, LRNG_IRQ_ENTROPY_BITS *
+					   LRNG_IRQ_OVERSAMPLING_FACTOR);
+		pr_warn("operating without high-resolution timer and applying "
+			"IRQ oversampling factor %u\n",
+			LRNG_IRQ_OVERSAMPLING_FACTOR);
+	}
+
+	lrng_sdrng_reset(&lrng_sdrng_init);
+	lrng_cc20_init_state(&secondary_chacha20);
+	lrng_state_init_seed_work();
+	lrng_sdrng_unlock(&lrng_sdrng_init, &flags);
+
+	lrng_sdrng_lock(&lrng_sdrng_atomic, &flags);
+	lrng_sdrng_reset(&lrng_sdrng_atomic);
+	/*
+	 * We do not initialize the state of the atomic DRNG as it is identical
+	 * to the secondary DRNG at this point.
+	 */
+	lrng_sdrng_unlock(&lrng_sdrng_atomic, &flags);
+
+	lrng_trng_init();
+
+	lrng_set_available();
+}
+
+/* Reset LRNG such that all existing entropy is gone */
+static void _lrng_reset(struct work_struct *work)
+{
+	struct lrng_sdrng **lrng_sdrng =3D lrng_sdrng_instances();
+	unsigned long flags =3D 0;
+
+	lrng_reset_state();
+	lrng_trng_reset();
+
+	if (!lrng_sdrng) {
+		lrng_sdrng_lock(&lrng_sdrng_init, &flags);
+		lrng_sdrng_reset(&lrng_sdrng_init);
+		lrng_sdrng_unlock(&lrng_sdrng_init, &flags);
+	} else {
+		u32 node;
+
+		for_each_online_node(node) {
+			struct lrng_sdrng *sdrng =3D lrng_sdrng[node];
+
+			if (!sdrng)
+				continue;
+			lrng_sdrng_lock(sdrng, &flags);
+			lrng_sdrng_reset(sdrng);
+			lrng_sdrng_unlock(sdrng, &flags);
+		}
+	}
+	lrng_set_entropy_thresh(LRNG_INIT_ENTROPY_BITS +
+				LRNG_CONDITIONING_ENTROPY_LOSS);
+}
+
+static DECLARE_WORK(lrng_reset_work, _lrng_reset);
+
+void lrng_reset(void)
+{
+	schedule_work(&lrng_reset_work);
+}
+
+/***************************** Initialize LRNG ***************************=
****/
+
+static int __init lrng_init(void)
+{
+	lrng_drngs_init_cc20();
+
+	lrng_drngs_numa_alloc();
+	return 0;
+}
+
+late_initcall(lrng_init);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
+MODULE_DESCRIPTION("Linux Random Number Generator");
diff --git a/drivers/char/lrng/lrng_sw_noise.c b/drivers/char/lrng/lrng_sw_=
noise.c
new file mode 100644
index 000000000000..2d6e323e5f08
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_sw_noise.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Slow Noise Source: Interrupt data collection
+ *
+ * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#include <asm/irq_regs.h>
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+
+/*
+ * To limit the impact on the interrupt handling, the LRNG concatenates
+ * entropic LSB parts of the time stamps in a per-CPU array and only
+ * injects them into the entropy pool when the array is full.
+ */
+/* Number of time values to store in the array */
+#define LRNG_TIME_NUM_VALUES		(64)
+/* Mask of LSB of time stamp to store */
+#define LRNG_TIME_WORD_MASK		(LRNG_TIME_NUM_VALUES - 1)
+
+/* Store multiple integers in one u32 */
+#define LRNG_TIME_SLOTSIZE_BITS		(8)
+#define LRNG_TIME_SLOTSIZE_MASK		((1 << LRNG_TIME_SLOTSIZE_BITS) - 1)
+#define LRNG_TIME_ARRAY_MEMBER_BITS	(sizeof(u32) << 3)
+#define LRNG_TIME_SLOTS_PER_UINT	(LRNG_TIME_ARRAY_MEMBER_BITS / \
+					 LRNG_TIME_SLOTSIZE_BITS)
+#define LRNG_TIME_SLOTS_MASK		(LRNG_TIME_SLOTS_PER_UINT - 1)
+#define LRNG_TIME_ARRAY_SIZE		(LRNG_TIME_NUM_VALUES /	\
+					 LRNG_TIME_SLOTS_PER_UINT)
+
+/* Holder of time stamps before mixing them into the entropy pool */
+static DEFINE_PER_CPU(u32 [LRNG_TIME_ARRAY_SIZE], lrng_time);
+static DEFINE_PER_CPU(u32, lrng_time_ptr) =3D 0;
+static DEFINE_PER_CPU(u8, lrng_time_irqs) =3D 0;
+
+/* Starting bit index of slot */
+static inline unsigned int lrng_time_slot2bitindex(unsigned int slot)
+{
+	return (LRNG_TIME_SLOTSIZE_BITS * slot);
+}
+
+/* Convert index into the array index */
+static inline unsigned int lrng_time_idx2array(unsigned int idx)
+{
+	return idx / LRNG_TIME_SLOTS_PER_UINT;
+}
+
+/* Convert index into the slot of a given array index */
+static inline unsigned int lrng_time_idx2slot(unsigned int idx)
+{
+	return idx & LRNG_TIME_SLOTS_MASK;
+}
+
+/* Convert value into slot value */
+static inline unsigned int lrng_time_slot_val(unsigned int val,
+					      unsigned int slot)
+{
+	return val << lrng_time_slot2bitindex(slot);
+}
+
+/**
+ * Batching up of entropy in per-CPU array before injecting into entropy p=
ool.
+ */
+static inline void lrng_time_process(void)
+{
+	u32 i, ptr, now_time =3D random_get_entropy() &
+			       (likely(lrng_state_fully_seeded()) ?
+				LRNG_TIME_SLOTSIZE_MASK : (u32)-1);
+	enum lrng_health_res health_test;
+
+	/* Ensure sufficient space in lrng_time_irqs */
+	BUILD_BUG_ON(LRNG_TIME_NUM_VALUES >=3D (1 << (sizeof(u8) << 3)));
+	BUILD_BUG_ON(LRNG_TIME_ARRAY_MEMBER_BITS % LRNG_TIME_SLOTSIZE_BITS);
+
+	if (lrng_raw_entropy_store(now_time))
+		return;
+
+	health_test =3D lrng_health_test(now_time);
+	if (health_test > lrng_health_fail_use)
+		return;
+
+	/* During boot time, we mix the full time stamp directly into LFSR */
+	if (unlikely(!lrng_state_fully_seeded())) {
+		lrng_pool_lfsr_u32(now_time);
+		if (health_test =3D=3D lrng_health_pass)
+			lrng_pool_add_irq(1);
+		return;
+	}
+
+	ptr =3D this_cpu_inc_return(lrng_time_ptr) & LRNG_TIME_WORD_MASK;
+	this_cpu_or(lrng_time[lrng_time_idx2array(ptr)],
+		    lrng_time_slot_val(now_time & LRNG_TIME_SLOTSIZE_MASK,
+				       lrng_time_idx2slot(ptr)));
+
+	/* Interrupt delivers entropy if health test passes */
+	if (health_test =3D=3D lrng_health_pass)
+		this_cpu_inc(lrng_time_irqs);
+
+	/* Only mix the buffer of time stamps into LFSR when wrapping */
+	if (ptr < LRNG_TIME_WORD_MASK)
+		return;
+
+	for (i =3D 0; i < LRNG_TIME_ARRAY_SIZE; i++) {
+		lrng_pool_lfsr_u32(this_cpu_read(lrng_time[i]));
+		this_cpu_write(lrng_time[i], 0);
+	}
+	lrng_pool_add_irq(this_cpu_read(lrng_time_irqs));
+	this_cpu_write(lrng_time_irqs, 0);
+}
+
+/**
+ * Hot code path - Callback for interrupt handler
+ */
+void add_interrupt_randomness(int irq, int irq_flags)
+{
+	lrng_time_process();
+
+	if (!lrng_pool_highres_timer()) {
+		struct pt_regs *regs =3D get_irq_regs();
+		static atomic_t reg_idx =3D ATOMIC_INIT(0);
+		u64 ip;
+
+		lrng_pool_lfsr_u32(jiffies);
+		lrng_pool_lfsr_u32(irq);
+		lrng_pool_lfsr_u32(irq_flags);
+
+		if (regs) {
+			u32 *ptr =3D (u32 *)regs;
+			int reg_ptr =3D atomic_add_return_relaxed(1, &reg_idx);
+			size_t n =3D (sizeof(struct pt_regs) / sizeof(u32));
+
+			ip =3D instruction_pointer(regs);
+			lrng_pool_lfsr_u32(*(ptr + (reg_ptr % n)));
+		} else
+			ip =3D _RET_IP_;
+
+		lrng_pool_lfsr_u32(ip >> 32);
+		lrng_pool_lfsr_u32(ip);
+	}
+}
+EXPORT_SYMBOL(add_interrupt_randomness);
diff --git a/include/linux/lrng.h b/include/linux/lrng.h
new file mode 100644
index 000000000000..2ece3a66e0f5
=2D-- /dev/null
+++ b/include/linux/lrng.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2018 - 2019, Stephan Mueller <smueller@chronox.de>
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
+ * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
+ * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ */
+
+#ifndef _LRNG_H
+#define _LRNG_H
+
+#include <linux/types.h>
+
+/**
+ * struct lrng_crypto_cb - cryptographic callback functions
+ * @lrng_drng_name		Name of DRNG
+ * @lrng_hash_name		Name of Hash used for reading entropy pool
+ * @lrng_drng_alloc:		Allocate DRNG -- the provided integer should be
+ *				used for sanity checks.
+ *				return: allocated data structure or PTR_ERR on
+ *					error
+ * @lrng_drng_dealloc:		Deallocate DRNG
+ * @lrng_drng_seed_helper:	Seed the DRNG with data of arbitrary length
+ *				drng: is pointer to data structure allocated
+ *				      with lrng_drng_alloc
+ *				return: >=3D 0 on success, < 0 on error
+ * @lrng_drng_generate_helper:	Generate random numbers from the DRNG with
+ *				arbitrary length
+ * @lrng_drng_generate_helper_full: Generate random numbers from the DRNG =
with
+ *				    arbitrary length where the output is
+ *				    capable of providing 1 bit of entropy per
+ *				    data bit.
+ *				    return: generated number of bytes,
+ *					    < 0 on error
+ * @lrng_hash_alloc:		Allocate the hash for reading the entropy pool
+ *				return: allocated data structure (NULL is
+ *					success too) or ERR_PTR on error
+ * @lrng_hash_dealloc:		Deallocate Hash
+ * @lrng_hash_digestsize:	Return the digestsize for the used hash to read
+ *				out entropy pool
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: size of digest of hash in bytes
+ * @lrng_hash_buffer:		Generate hash
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: 0 on success, < 0 on error
+ */
+struct lrng_crypto_cb {
+	const char *(*lrng_drng_name)(void);
+	const char *(*lrng_hash_name)(void);
+	void *(*lrng_drng_alloc)(u32 sec_strength);
+	void (*lrng_drng_dealloc)(void *drng);
+	int (*lrng_drng_seed_helper)(void *drng, const u8 *inbuf, u32 inbuflen);
+	int (*lrng_drng_generate_helper)(void *drng, u8 *outbuf, u32 outbuflen);
+	int (*lrng_drng_generate_helper_full)(void *drng, u8 *outbuf,
+					      u32 outbuflen);
+	void *(*lrng_hash_alloc)(const u8 *key, u32 keylen);
+	void (*lrng_hash_dealloc)(void *hash);
+	u32 (*lrng_hash_digestsize)(void *hash);
+	int (*lrng_hash_buffer)(void *hash, const u8 *inbuf, u32 inbuflen,
+				u8 *digest);
+};
+
+/* Register cryptographic backend */
+#ifdef CONFIG_LRNG_DRNG_SWITCH
+int lrng_set_drng_cb(const struct lrng_crypto_cb *cb);
+#else	/* CONFIG_LRNG_DRNG_SWITCH */
+static inline int
+lrng_set_drng_cb(const struct lrng_crypto_cb *cb) { return -EOPNOTSUPP; }
+#endif	/* CONFIG_LRNG_DRNG_SWITCH */
+
+#endif /* _LRNG_H */
=2D-=20
2.23.0




