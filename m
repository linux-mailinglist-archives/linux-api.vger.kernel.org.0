Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21416FFC16
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 23:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfKQW5A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 17:57:00 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:18320 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfKQW5A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 17:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574031413;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=RJV7cd/Szuxs/oa+C4TAe/JvDzuzXmyEiAbfupJ04zA=;
        b=rtiesrQ91Ba6J/RWX5GD1mTnXXNgZcgyT6hPQExKIaUVRFog5BwvUnGzkaftc3iN16
        xQZl8j3YQa1TbXNuj+/dL49y8bu8A/LTHcu4pX3g0JFaS8n/8b5loDJkosstAJPmgeHd
        LlKmsj3yV085JoUidmkHSoXunMs2sa+g4+YGyfEHJnqf11jCdVSBG6c8PPejQcg2Y5Wa
        U8BT/0R43WYKEhcGQlWLOzg2pTuoipu8GSeo28L0qdzhGNpuEwo90QoRrbp46KCwuCrv
        4RDFm/5IoqmHuUzf/JYTVBmsZpI8gaZgg42OqSVjzdr9Ldv2SzPw/BzfSsdi583tfJk8
        QMAg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbIvSfb0y2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAHMtPWpN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 23:55:25 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Andy Lutomirski <luto@amacapital.net>
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
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 12/12] LRNG - add interface for gathering of raw entropy
Date:   Sun, 17 Nov 2019 23:55:24 +0100
Message-ID: <15745039.MlzBmBdvSy@positron.chronox.de>
In-Reply-To: <6950B235-6231-4DFF-A375-54A70C548B2E@amacapital.net>
References: <3610406.x8mDjznOIz@positron.chronox.de> <6950B235-6231-4DFF-A375-54A70C548B2E@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Samstag, 16. November 2019, 17:51:24 CET schrieb Andy Lutomirski:

Hi Andy,

> > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.de> =
wrote:
> >=20
> > =EF=BB=BFThe test interface allows a privileged process to capture the =
raw
> > unconditioned noise that is collected by the LRNG for statistical
> > analysis. Extracted noise data is not used to seed the LRNG. This
> > is a test interface and not appropriate for production systems.
> > Yet, the interface is considered to be sufficiently secured for
> > production systems.
> >=20
> > Access to the data is given through the lrng_raw debugfs file. The
> > data buffer should be multiples of sizeof(u32) to fill the entire
> > buffer. Using the option lrng_testing.boot_test=3D1 the raw noise of
> > the first 1000 entropy events since boot can be sampled.
> >=20
> > This test interface allows generating the data required for
> > analysis whether the LRNG is in compliance with SP800-90B
> > sections 3.1.3 and 3.1.4.
> >=20
> > CC: "Eric W. Biederman" <ebiederm@xmission.com>
> > CC: "Alexander E. Patrakov" <patrakov@gmail.com>
> > CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
> > CC: "Theodore Y. Ts'o" <tytso@mit.edu>
> > CC: Willy Tarreau <w@1wt.eu>
> > CC: Matthew Garrett <mjg59@srcf.ucam.org>
> > CC: Vito Caputo <vcaputo@pengaru.com>
> > CC: Andreas Dilger <adilger.kernel@dilger.ca>
> > CC: Jan Kara <jack@suse.cz>
> > CC: Ray Strode <rstrode@redhat.com>
> > CC: William Jon McCann <mccann@jhu.edu>
> > CC: zhangjs <zachary@baishancloud.com>
> > CC: Andy Lutomirski <luto@kernel.org>
> > CC: Florian Weimer <fweimer@redhat.com>
> > CC: Lennart Poettering <mzxreary@0pointer.de>
> > CC: Nicolai Stange <nstange@suse.de>
> > Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> > Tested-by: Roman Drahtm=C3=BCller <draht@schaltsekun.de>
> > Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > Tested-by: Neil Horman <nhorman@redhat.com>
> > Signed-off-by: Stephan Mueller <smueller@chronox.de>
> > ---
> > drivers/char/lrng/Kconfig        |  16 ++
> > drivers/char/lrng/Makefile       |   1 +
> > drivers/char/lrng/lrng_testing.c | 324 +++++++++++++++++++++++++++++++
> > 3 files changed, 341 insertions(+)
> > create mode 100644 drivers/char/lrng/lrng_testing.c
> >=20
> > diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> > index e6ca3acc1e48..4ccc710832ef 100644
> > --- a/drivers/char/lrng/Kconfig
> > +++ b/drivers/char/lrng/Kconfig
> > @@ -169,4 +169,20 @@ config LRNG_APT_CUTOFF
> >=20
> >    default 325 if !LRNG_APT_BROKEN
> >    default 32 if LRNG_APT_BROKEN
> >=20
> > +config LRNG_TESTING
> > +    bool "Enable entropy test interface to LRNG noise source"
> > +    select CONFIG_DEBUG_FS
> > +    help
> > +      The test interface allows a privileged process to capture
> > +      the raw unconditioned noise that is collected by the LRNG
> > +      for statistical analysis. Extracted noise data is not used
> > +      to seed the LRNG.
> > +
> > +      The raw noise data can be obtained using the lrng_raw
> > +      debugfs file. Using the option lrng_testing.boot_test=3D1
> > +      the raw noise of the first 1000 entropy events since boot
> > +      can be sampled.
> > +
> > +      If unsure, say N.
> > +
> > endif # LRNG
> > diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
> > index 0713e9c0aa6e..c0b6cc4301fe 100644
> > --- a/drivers/char/lrng/Makefile
> > +++ b/drivers/char/lrng/Makefile
> > @@ -16,3 +16,4 @@ obj-$(CONFIG_LRNG_KCAPI)    +=3D lrng_kcapi.o
> > obj-$(CONFIG_LRNG_JENT)        +=3D lrng_jent.o
> > obj-$(CONFIG_LRNG_TRNG_SUPPORT)    +=3D lrng_trng.o
> > obj-$(CONFIG_LRNG_HEALTH_TESTS)    +=3D lrng_health.o
> > +obj-$(CONFIG_LRNG_TESTING)    +=3D lrng_testing.o
> > diff --git a/drivers/char/lrng/lrng_testing.c
> > b/drivers/char/lrng/lrng_testing.c new file mode 100644
> > index 000000000000..5c33d3bd2172
> > --- /dev/null
> > +++ b/drivers/char/lrng/lrng_testing.c
> > @@ -0,0 +1,324 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +/*
> > + * Linux Random Number Generator (LRNG) Raw entropy collection tool
> > + *
> > + * Copyright (C) 2019, Stephan Mueller <smueller@chronox.de>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/bug.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/workqueue.h>
> > +#include <asm/errno.h>
> > +
> > +#include "lrng_internal.h"
> > +
> > +#define LRNG_TESTING_RINGBUFFER_SIZE    1024
> > +#define LRNG_TESTING_RINGBUFFER_MASK    (LRNG_TESTING_RINGBUFFER_SIZE -
> > 1)
> > +
> > +static u32 lrng_testing_rb[LRNG_TESTING_RINGBUFFER_SIZE];
> > +static atomic_t lrng_rb_reader =3D ATOMIC_INIT(0);
> > +static atomic_t lrng_rb_writer =3D ATOMIC_INIT(0);
> > +static atomic_t lrng_rb_first_in =3D ATOMIC_INIT(0);
> > +static atomic_t lrng_testing_enabled =3D ATOMIC_INIT(0);
> > +
> > +static DECLARE_WAIT_QUEUE_HEAD(lrng_raw_read_wait);
> > +
> > +static u32 boot_test =3D 0;
> > +module_param(boot_test, uint, 0644);
> > +MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of the
> > first" +                " entropy events");
> > +
> > +static inline void lrng_raw_entropy_reset(void)
> > +{
> > +    atomic_set(&lrng_rb_reader, 0);
> > +    atomic_set(&lrng_rb_writer, 0);
> > +    atomic_set(&lrng_rb_first_in, 0);
> > +}
> > +
> > +static void lrng_raw_entropy_init(void)
> > +{
> > +    /*
> > +     * The boot time testing implies we have a running test. If the
> > +     * caller wants to clear it, he has to unset the boot_test flag
> > +     * at runtime via sysfs to enable regular runtime testing
> > +     */
> > +    if (boot_test)
> > +        return;
> > +
> > +    lrng_raw_entropy_reset();
> > +    atomic_set(&lrng_testing_enabled, 1);
> > +    pr_warn("Enabling raw entropy collection\n");
> > +}
> > +
> > +static void lrng_raw_entropy_fini(void)
> > +{
> > +    if (boot_test)
> > +        return;
> > +
> > +    lrng_raw_entropy_reset();
> > +    atomic_set(&lrng_testing_enabled, 0);
> > +    pr_warn("Disabling raw entropy collection\n");
> > +}
> > +
> > +bool lrng_raw_entropy_store(u32 value)
> > +{
> > +    unsigned int write_ptr;
> > +    unsigned int read_ptr;
> > +
> > +    if (!atomic_read(&lrng_testing_enabled) && !boot_test)
> > +        return false;
> > +
> > +    write_ptr =3D (unsigned int)atomic_add_return_relaxed(1,
> > &lrng_rb_writer); +    read_ptr =3D (unsigned
> > int)atomic_read(&lrng_rb_reader);

Before answering your comments, please allow me to clarify the following:

This entire code is intended to obtain take raw unconditioned noise data th=
at=20
needs to be extracted from the kernel to user space to allow it to be furth=
er=20
analyzed. This is also why it is mentioned in the Kconfig selection that in=
=20
doubt one should select N and that this code is not intended for production=
=20
kernels although this code should be secure enough to be present in product=
ion=20
kernels.

=46or example, raw unconditioned noise data needs to be processed by the=20
complicated math outlined in chapter 6 of [1]. For that, there is a tool=20
available, see [2]. For that tool, data is needed that is obtained with the=
=20
getrawentropy tool available with [3] where this tool obtains the data from=
=20
the SysFS file that is implemented with this C file.

In addition, [1] even needs the data from the very first 1000 interrupts af=
ter=20
boot. Hence, the LRNG needs to be able to store that data until user space =
can=20
pick it up (see the boot_test variable).

The assessment resulting from this can be reviewed at [4] section 3.2 In=20
particular, the numbers provided at the end of sections 3.2.3 and 3.2.4 are=
=20
obtained with this interface.=20

Other examples where such raw unconditioned noise data is needed for furthe=
r=20
analysis is [5], especially chapter 6.

This testing has nothing to do with the runtime testing provided with the=20
patch set 11. All data that ends up here is not available to the LRNG and w=
ill=20
not contribute to any entropy collection.

See the following:

static inline void lrng_time_process(void)
{
=2E..
	if (lrng_raw_entropy_store(now_time))
		return;


bool lrng_raw_entropy_store(u32 value)
{
=2E..
	if (!atomic_read(&lrng_testing_enabled) && !boot_test)
		return false;
=2E..
	return true;

>=20
> Am I correct in assuming that this function can be called concurrently in
> different threads or CPUs?

Yes, because it is called indirectly by add_interrupt_randomness.
> > +
> > +    /*
> > +     * Disable entropy testing for boot time testing after ring buffer
> > +     * is filled.
> > +     */
> > +    if (boot_test && write_ptr > LRNG_TESTING_RINGBUFFER_SIZE) {
> > +        pr_warn_once("Boot time entropy collection test disabled\n");
> > +        return false;
> > +    }
> > +
> > +    if (boot_test && !atomic_read(&lrng_rb_first_in))
> > +        pr_warn("Boot time entropy collection test enabled\n");
> > +
> > +    lrng_testing_rb[write_ptr & LRNG_TESTING_RINGBUFFER_MASK] =3D valu=
e;
>=20
> You=E2=80=99re writing *somewhere*, but not necessarily to the first open=
 slot.

The idea is that there is a reader pointer and a writer pointer where the=20
reader always must be smaller or equal to the writer (modulo the size of th=
e=20
ring buffer). So, I do not care where the writer ptr is.

All I need is that:

1. reader and writer ptr must start with the same value at boot time (e.g. =
0)

2. reader ptr is always <=3D writer ptr in order for data to be read.

With these two conditions, when pulling data from the buffer, I need to pul=
l=20
always the data from the reader ptr until the reader ptr reaches the writer=
=20
pointer.

Note, the reader/writer pointers are always set to 0 at the beginning of a =
new=20
read request from user space.

>=20
> > +
> > +    /* We got at least one event, enable the reader now. */
> > +    atomic_set(&lrng_rb_first_in, 1);
>=20
> But not necessarily in position 0.

Yes, this is perfectly ok.
>=20
> > +
> > +    if (wq_has_sleeper(&lrng_raw_read_wait))
> > +        wake_up_interruptible(&lrng_raw_read_wait);
> > +
> > +    /*
> > +     * Our writer is taking over the reader - this means the reader
> > +     * one full ring buffer available. Thus we "push" the reader ahead
> > +     * to guarantee that he will be able to consume the full ring.
> > +     */
> > +    if (!boot_test &&
> > +        ((write_ptr & LRNG_TESTING_RINGBUFFER_MASK) =3D=3D
> > +        (read_ptr & LRNG_TESTING_RINGBUFFER_MASK)))
> > +        atomic_inc_return_relaxed(&lrng_rb_reader);
>=20
> Because you did a relaxed increment above, you don=E2=80=99t actually kno=
w this.
> Maybe it=E2=80=99s okay, but this is way too subtle.

You are absolutely correct, there should be no relaxed atomic operation. We=
=20
should take the atomic_inc above and here.

I fixed this.
>=20
> I think you should have a mutex for the read side and put all the
> complicated accounting inside the mutex.  If the reader can=E2=80=99t fig=
ure out
> that the read pointer is too far behind the write pointer, then fix the
> reader.

Done - the writer now only writes the data and generates the boot log if th=
e=20
boot time raw entropy gathering is enabled.
>=20
> I also don=E2=80=99t see how the reader is supposed to know how much data=
 has
> actually been written.  You don=E2=80=99t have any variable that says =E2=
=80=9Call words up
> to X have been written=E2=80=9D.

With the two rules above, I think the reader knows that: all data between t=
he=20
reader ptr and the writer ptr modulo the size of the ring buffer.

But I simplified the code now, the code now only copies the data out if the=
=20
reader <=3D writer modulo the ring buffer size. In this case, if the writer=
 is=20
much faster, then we loose some values.

With the old code, we simply would have lost it too, but just a bit later.
>=20
> I think you should stop trying to make the write side wait free.
> Instead,
> consider either using a lock or making it unreliable.  For the former, ju=
st
> skip taking the lock if testing is off. For the latter, read write_ptr,
> write (using WRITE_ONCE) your data, then cmpxchg the write ptr from the
> value you read to that value plus one.  And make sure that the reader nev=
er
> tries to read the first unwritten slot, i.e. never let the reader catch a=
ll
> the way up.

I have followed the locking approach as we need to get correct data.
>=20
> I=E2=80=99m also curious why you need entirely different infrastructure f=
or testing
> as for normal operation.

I hope with the explanation above, the question is answered.


> > +
> > +    return true;
> > +}
> > +
> > +static inline bool lrng_raw_have_data(void)
> > +{
> > +    unsigned int read_ptr =3D (unsigned int)atomic_read(&lrng_rb_reade=
r);
> > +    unsigned int write_ptr =3D (unsigned int)atomic_read(&lrng_rb_writ=
er);
> > +
> > +    return (atomic_read(&lrng_rb_first_in) &&
> > +        (write_ptr & LRNG_TESTING_RINGBUFFER_MASK) !=3D
> > +         (read_ptr & LRNG_TESTING_RINGBUFFER_MASK));
> > +}
> > +
> > +static int lrng_raw_entropy_reader(u8 *outbuf, u32 outbuflen)
> > +{
> > +    int collected_data =3D 0;
> > +
> > +    if (!atomic_read(&lrng_testing_enabled) && !boot_test)
> > +        return -EAGAIN;
> > +
> > +    if (!atomic_read(&lrng_rb_first_in)) {
> > +        wait_event_interruptible(lrng_raw_read_wait,
> > +                     lrng_raw_have_data());
> > +        if (signal_pending(current))
> > +            return -ERESTARTSYS;
> > +    }
> > +
> > +    while (outbuflen) {
> > +        unsigned int read_ptr =3D
> > +            (unsigned int)atomic_add_return_relaxed(
> > +                            1, &lrng_rb_reader);
> > +        unsigned int write_ptr =3D
> > +            (unsigned int)atomic_read(&lrng_rb_writer);
> > +
> > +        /*
> > +         * For boot time testing, only output one round of ring buffer.
> > +         */
> > +        if (boot_test && read_ptr > LRNG_TESTING_RINGBUFFER_SIZE) {
> > +            collected_data =3D -ENOMSG;
> > +            goto out;
> > +        }
> > +
> > +        /* We reached the writer */
> > +        if (!boot_test && ((write_ptr & LRNG_TESTING_RINGBUFFER_MASK) =
=3D=3D
> > +            (read_ptr & LRNG_TESTING_RINGBUFFER_MASK))) {
> > +
>=20
> This is wrong. The fact that you haven=E2=80=99t reached the writer does =
not imply
> that you=E2=80=99re about to read valid data.

As I changed the code by using your locking suggestion. With that I think t=
he=20
code should now always read correct data. I will send an updated patch set=
=20
tomorrow.

Thank you for your review.


[1] https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-90B.p=
df

[2] https://github.com/usnistgov/SP800-90B_EntropyAssessment

[3] http://www.chronox.de/lrng/lrng-tests-20191116.tar.xz - see the sp80090=
b=20
directory for details

[4] http://www.chronox.de/lrng/doc/lrng.pdf

[5] https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studie=
s/
LinuxRNG/LinuxRNG_EN.pdf


Ciao
Stephan


