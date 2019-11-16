Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2067AFF411
	for <lists+linux-api@lfdr.de>; Sat, 16 Nov 2019 17:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfKPQv1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 16 Nov 2019 11:51:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36474 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfKPQv1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 16 Nov 2019 11:51:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so8175028pfd.3
        for <linux-api@vger.kernel.org>; Sat, 16 Nov 2019 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=K9dzo1Lpl/E8eQcOkXHQEfmmSekoCsu3mvK4T8VA6ms=;
        b=xDDrhd9i3eXCIiOH+UeBc69E1x6O7SGIiFaTPPLESKjLU0oHdgKQ94YJ+kT8wGoMXN
         Utdc9qKlJAAgohJFN5oLJ2u199xvO3OLZwC+EMK0WTdDpBuIuPi63NM5wn/tra14vpB9
         yrMyb/pk/JYyDv4QMdqXsH+MSYIrrRP8AsUA+T8uthmlZPf3spg6kVxJXQZ4JR2zUSvF
         qZjIWAPilJ3R9C+7/FDMB0iW6ktBs5K6mCMEJHKtPRGuFP+RcoY1QfouxPfJmWIKxDSA
         XqiP42hO7w14RTPtCwY9JIsLaDBhlb/FH1Arov8LKYqGjZYNn9lzy2wlBW0gtDAXwldV
         AtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=K9dzo1Lpl/E8eQcOkXHQEfmmSekoCsu3mvK4T8VA6ms=;
        b=qYokZGsnWvSR3kSgz4si7tQSpNXkXfX6jqW9qfxf6MljzgTxIsClKTyPNFhAEeaIcd
         zK/traQ3kOv0uw9DD2sXzhomvb7/ff3VZc62TUMcTKCg0apf/pRrUWiShTRaPBG3oqYm
         jHqyjaN925brjCVKdbeRuNZYlOVLsqtQVCaYKtnj7Zltxj43xr86y0wrM0f7jQhxCBz3
         2QvaiFBhp0zvi+xlDDsfGsVSHhdM/2CkFmdezZL5GvTBVZzMhNuD+eBCnLEualUKKUwz
         JDmw1lNG2hTTW/N+8Z5SDljmkQrRM0pyjB4o20LloV0mwVMCMyBMxbqcBexPXE+aa4q8
         BqPw==
X-Gm-Message-State: APjAAAXvVIuZOwFst00zz9GXj+BUqKgmfNCSGrNSh1e5/pezVpKgrU9I
        MugexyNHmHZUPmP6C80BzA/jGQ==
X-Google-Smtp-Source: APXvYqx8wTqCWL2tU92aJbfsbqGbhCVdt7/4hFudVU8+sRtBBXE/y1Lpgg2RunR5AdNC5aFfrOSqLQ==
X-Received: by 2002:a63:77c3:: with SMTP id s186mr23095280pgc.370.1573923086271;
        Sat, 16 Nov 2019 08:51:26 -0800 (PST)
Received: from ?IPv6:2600:1010:b01b:e50d:6d7c:21:d243:910c? ([2600:1010:b01b:e50d:6d7c:21:d243:910c])
        by smtp.gmail.com with ESMTPSA id d139sm18147514pfd.162.2019.11.16.08.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2019 08:51:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v25 12/12] LRNG - add interface for gathering of raw entropy
Date:   Sat, 16 Nov 2019 08:51:24 -0800
Message-Id: <6950B235-6231-4DFF-A375-54A70C548B2E@amacapital.net>
References: <3610406.x8mDjznOIz@positron.chronox.de>
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
In-Reply-To: <3610406.x8mDjznOIz@positron.chronox.de>
To:     =?utf-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.de> wro=
te:
>=20
> =EF=BB=BFThe test interface allows a privileged process to capture the raw=

> unconditioned noise that is collected by the LRNG for statistical
> analysis. Extracted noise data is not used to seed the LRNG. This
> is a test interface and not appropriate for production systems.
> Yet, the interface is considered to be sufficiently secured for
> production systems.
>=20
> Access to the data is given through the lrng_raw debugfs file. The
> data buffer should be multiples of sizeof(u32) to fill the entire
> buffer. Using the option lrng_testing.boot_test=3D1 the raw noise of
> the first 1000 entropy events since boot can be sampled.
>=20
> This test interface allows generating the data required for
> analysis whether the LRNG is in compliance with SP800-90B
> sections 3.1.3 and 3.1.4.
>=20
> CC: "Eric W. Biederman" <ebiederm@xmission.com>
> CC: "Alexander E. Patrakov" <patrakov@gmail.com>
> CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
> CC: "Theodore Y. Ts'o" <tytso@mit.edu>
> CC: Willy Tarreau <w@1wt.eu>
> CC: Matthew Garrett <mjg59@srcf.ucam.org>
> CC: Vito Caputo <vcaputo@pengaru.com>
> CC: Andreas Dilger <adilger.kernel@dilger.ca>
> CC: Jan Kara <jack@suse.cz>
> CC: Ray Strode <rstrode@redhat.com>
> CC: William Jon McCann <mccann@jhu.edu>
> CC: zhangjs <zachary@baishancloud.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Florian Weimer <fweimer@redhat.com>
> CC: Lennart Poettering <mzxreary@0pointer.de>
> CC: Nicolai Stange <nstange@suse.de>
> Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> Tested-by: Roman Drahtm=C3=BCller <draht@schaltsekun.de>
> Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Tested-by: Neil Horman <nhorman@redhat.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
> drivers/char/lrng/Kconfig        |  16 ++
> drivers/char/lrng/Makefile       |   1 +
> drivers/char/lrng/lrng_testing.c | 324 +++++++++++++++++++++++++++++++
> 3 files changed, 341 insertions(+)
> create mode 100644 drivers/char/lrng/lrng_testing.c
>=20
> diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> index e6ca3acc1e48..4ccc710832ef 100644
> --- a/drivers/char/lrng/Kconfig
> +++ b/drivers/char/lrng/Kconfig
> @@ -169,4 +169,20 @@ config LRNG_APT_CUTOFF
>    default 325 if !LRNG_APT_BROKEN
>    default 32 if LRNG_APT_BROKEN
>=20
> +config LRNG_TESTING
> +    bool "Enable entropy test interface to LRNG noise source"
> +    select CONFIG_DEBUG_FS
> +    help
> +      The test interface allows a privileged process to capture
> +      the raw unconditioned noise that is collected by the LRNG
> +      for statistical analysis. Extracted noise data is not used
> +      to seed the LRNG.
> +
> +      The raw noise data can be obtained using the lrng_raw
> +      debugfs file. Using the option lrng_testing.boot_test=3D1
> +      the raw noise of the first 1000 entropy events since boot
> +      can be sampled.
> +
> +      If unsure, say N.
> +
> endif # LRNG
> diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
> index 0713e9c0aa6e..c0b6cc4301fe 100644
> --- a/drivers/char/lrng/Makefile
> +++ b/drivers/char/lrng/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_LRNG_KCAPI)    +=3D lrng_kcapi.o
> obj-$(CONFIG_LRNG_JENT)        +=3D lrng_jent.o
> obj-$(CONFIG_LRNG_TRNG_SUPPORT)    +=3D lrng_trng.o
> obj-$(CONFIG_LRNG_HEALTH_TESTS)    +=3D lrng_health.o
> +obj-$(CONFIG_LRNG_TESTING)    +=3D lrng_testing.o
> diff --git a/drivers/char/lrng/lrng_testing.c b/drivers/char/lrng/lrng_tes=
ting.c
> new file mode 100644
> index 000000000000..5c33d3bd2172
> --- /dev/null
> +++ b/drivers/char/lrng/lrng_testing.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * Linux Random Number Generator (LRNG) Raw entropy collection tool
> + *
> + * Copyright (C) 2019, Stephan Mueller <smueller@chronox.de>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/atomic.h>
> +#include <linux/bug.h>
> +#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +#include <linux/workqueue.h>
> +#include <asm/errno.h>
> +
> +#include "lrng_internal.h"
> +
> +#define LRNG_TESTING_RINGBUFFER_SIZE    1024
> +#define LRNG_TESTING_RINGBUFFER_MASK    (LRNG_TESTING_RINGBUFFER_SIZE - 1=
)
> +
> +static u32 lrng_testing_rb[LRNG_TESTING_RINGBUFFER_SIZE];
> +static atomic_t lrng_rb_reader =3D ATOMIC_INIT(0);
> +static atomic_t lrng_rb_writer =3D ATOMIC_INIT(0);
> +static atomic_t lrng_rb_first_in =3D ATOMIC_INIT(0);
> +static atomic_t lrng_testing_enabled =3D ATOMIC_INIT(0);
> +
> +static DECLARE_WAIT_QUEUE_HEAD(lrng_raw_read_wait);
> +
> +static u32 boot_test =3D 0;
> +module_param(boot_test, uint, 0644);
> +MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of the fi=
rst"
> +                " entropy events");
> +
> +static inline void lrng_raw_entropy_reset(void)
> +{
> +    atomic_set(&lrng_rb_reader, 0);
> +    atomic_set(&lrng_rb_writer, 0);
> +    atomic_set(&lrng_rb_first_in, 0);
> +}
> +
> +static void lrng_raw_entropy_init(void)
> +{
> +    /*
> +     * The boot time testing implies we have a running test. If the
> +     * caller wants to clear it, he has to unset the boot_test flag
> +     * at runtime via sysfs to enable regular runtime testing
> +     */
> +    if (boot_test)
> +        return;
> +
> +    lrng_raw_entropy_reset();
> +    atomic_set(&lrng_testing_enabled, 1);
> +    pr_warn("Enabling raw entropy collection\n");
> +}
> +
> +static void lrng_raw_entropy_fini(void)
> +{
> +    if (boot_test)
> +        return;
> +
> +    lrng_raw_entropy_reset();
> +    atomic_set(&lrng_testing_enabled, 0);
> +    pr_warn("Disabling raw entropy collection\n");
> +}
> +
> +bool lrng_raw_entropy_store(u32 value)
> +{
> +    unsigned int write_ptr;
> +    unsigned int read_ptr;
> +
> +    if (!atomic_read(&lrng_testing_enabled) && !boot_test)
> +        return false;
> +
> +    write_ptr =3D (unsigned int)atomic_add_return_relaxed(1, &lrng_rb_wri=
ter);
> +    read_ptr =3D (unsigned int)atomic_read(&lrng_rb_reader);

Am I correct in assuming that this function can be called concurrently in di=
fferent threads or CPUs?

> +
> +    /*
> +     * Disable entropy testing for boot time testing after ring buffer
> +     * is filled.
> +     */
> +    if (boot_test && write_ptr > LRNG_TESTING_RINGBUFFER_SIZE) {
> +        pr_warn_once("Boot time entropy collection test disabled\n");
> +        return false;
> +    }
> +
> +    if (boot_test && !atomic_read(&lrng_rb_first_in))
> +        pr_warn("Boot time entropy collection test enabled\n");
> +
> +    lrng_testing_rb[write_ptr & LRNG_TESTING_RINGBUFFER_MASK] =3D value;

You=E2=80=99re writing *somewhere*, but not necessarily to the first open sl=
ot.

> +
> +    /* We got at least one event, enable the reader now. */
> +    atomic_set(&lrng_rb_first_in, 1);

But not necessarily in position 0.

> +
> +    if (wq_has_sleeper(&lrng_raw_read_wait))
> +        wake_up_interruptible(&lrng_raw_read_wait);
> +
> +    /*
> +     * Our writer is taking over the reader - this means the reader
> +     * one full ring buffer available. Thus we "push" the reader ahead
> +     * to guarantee that he will be able to consume the full ring.
> +     */
> +    if (!boot_test &&
> +        ((write_ptr & LRNG_TESTING_RINGBUFFER_MASK) =3D=3D
> +        (read_ptr & LRNG_TESTING_RINGBUFFER_MASK)))
> +        atomic_inc_return_relaxed(&lrng_rb_reader);

Because you did a relaxed increment above, you don=E2=80=99t actually know t=
his. Maybe it=E2=80=99s okay, but this is way too subtle.

I think you should have a mutex for the read side and put all the complicate=
d accounting inside the mutex.  If the reader can=E2=80=99t figure out that t=
he read pointer is too far behind the write pointer, then fix the reader.

I also don=E2=80=99t see how the reader is supposed to know how much data ha=
s actually been written.  You don=E2=80=99t have any variable that says =E2=80=
=9Call words up to X have been written=E2=80=9D.

I think you should stop trying to make the write side wait free. Instead, co=
nsider either using a lock or making it unreliable.  For the former, just sk=
ip taking the lock if testing is off. For the latter, read write_ptr, write (=
using WRITE_ONCE) your data, then cmpxchg the write ptr from the value you r=
ead to that value plus one.  And make sure that the reader never tries to re=
ad the first unwritten slot, i.e. never let the reader catch all the way up.=


I=E2=80=99m also curious why you need entirely different infrastructure for t=
esting as for normal operation.

> +
> +    return true;
> +}
> +
> +static inline bool lrng_raw_have_data(void)
> +{
> +    unsigned int read_ptr =3D (unsigned int)atomic_read(&lrng_rb_reader);=

> +    unsigned int write_ptr =3D (unsigned int)atomic_read(&lrng_rb_writer)=
;
> +
> +    return (atomic_read(&lrng_rb_first_in) &&
> +        (write_ptr & LRNG_TESTING_RINGBUFFER_MASK) !=3D
> +         (read_ptr & LRNG_TESTING_RINGBUFFER_MASK));
> +}
> +
> +static int lrng_raw_entropy_reader(u8 *outbuf, u32 outbuflen)
> +{
> +    int collected_data =3D 0;
> +
> +    if (!atomic_read(&lrng_testing_enabled) && !boot_test)
> +        return -EAGAIN;
> +
> +    if (!atomic_read(&lrng_rb_first_in)) {
> +        wait_event_interruptible(lrng_raw_read_wait,
> +                     lrng_raw_have_data());
> +        if (signal_pending(current))
> +            return -ERESTARTSYS;
> +    }
> +
> +    while (outbuflen) {
> +        unsigned int read_ptr =3D
> +            (unsigned int)atomic_add_return_relaxed(
> +                            1, &lrng_rb_reader);
> +        unsigned int write_ptr =3D
> +            (unsigned int)atomic_read(&lrng_rb_writer);
> +
> +        /*
> +         * For boot time testing, only output one round of ring buffer.
> +         */
> +        if (boot_test && read_ptr > LRNG_TESTING_RINGBUFFER_SIZE) {
> +            collected_data =3D -ENOMSG;
> +            goto out;
> +        }
> +
> +        /* We reached the writer */
> +        if (!boot_test && ((write_ptr & LRNG_TESTING_RINGBUFFER_MASK) =3D=
=3D
> +            (read_ptr & LRNG_TESTING_RINGBUFFER_MASK))) {
> +         =20

This is wrong. The fact that you haven=E2=80=99t reached the writer does not=
 imply that you=E2=80=99re about to read valid data.

