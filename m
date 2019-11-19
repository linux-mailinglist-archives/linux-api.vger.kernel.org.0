Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C77102190
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 11:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfKSKE5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Nov 2019 05:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKSKE5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 19 Nov 2019 05:04:57 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D3EC22319
        for <linux-api@vger.kernel.org>; Tue, 19 Nov 2019 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574157895;
        bh=wHtJN6m0FXQ7Vf3uIFOJiCgvjU8ySXVU+hkR7YZhOWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CsMtXII6353diyt2GdQhQLFYi982mMgUgiA9L15pToIa65leCtJ+q/y3BeAA0frRY
         2Yd0uwa4eM3e+ezoR+UTyJq6xw7FdsPA0IoELS9Q2gsI701uG3NsASNdmoc2oe6Hbh
         9uemrT2c1BRVylgSeM1d/MAZhnawEfrlema14I9g=
Received: by mail-wr1-f45.google.com with SMTP id e6so23097696wrw.1
        for <linux-api@vger.kernel.org>; Tue, 19 Nov 2019 02:04:55 -0800 (PST)
X-Gm-Message-State: APjAAAVqmVuCVAd9NUJbHulXH3iPWIGnp33y+5R12HcO8f1a2Eb0YOns
        /rCf6pAbVth2s3GuFvB9CWGhdF5E/Vvv7gw5KUXOaw==
X-Google-Smtp-Source: APXvYqye+Nrwjpzp5byCG+wRiVkt8Ind+MoMfDhuD02XN4s5Xzo0okRwuk8/4h1wgr8OVSACJTxTNJbEtVpNh+vvG5o=
X-Received: by 2002:a5d:640b:: with SMTP id z11mr34809965wru.195.1574157893770;
 Tue, 19 Nov 2019 02:04:53 -0800 (PST)
MIME-Version: 1.0
References: <3610406.x8mDjznOIz@positron.chronox.de> <6950B235-6231-4DFF-A375-54A70C548B2E@amacapital.net>
 <15745039.MlzBmBdvSy@positron.chronox.de>
In-Reply-To: <15745039.MlzBmBdvSy@positron.chronox.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 Nov 2019 02:04:42 -0800
X-Gmail-Original-Message-ID: <CALCETrUm5gM9s6vqvXWeT5phwRnh-CgLhYY=_eNZ2FDVjBAxSw@mail.gmail.com>
Message-ID: <CALCETrUm5gM9s6vqvXWeT5phwRnh-CgLhYY=_eNZ2FDVjBAxSw@mail.gmail.com>
Subject: Re: [PATCH v25 12/12] LRNG - add interface for gathering of raw entropy
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Nov 17, 2019 at 2:55 PM Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
>
> Am Samstag, 16. November 2019, 17:51:24 CET schrieb Andy Lutomirski:
>
> Hi Andy,
>
> > > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.de=
> wrote:
> > >
> > > =EF=BB=BFThe test interface allows a privileged process to capture th=
e raw
> > > unconditioned noise that is collected by the LRNG for statistical
> > > analysis. Extracted noise data is not used to seed the LRNG. This
> > > is a test interface and not appropriate for production systems.
> > > Yet, the interface is considered to be sufficiently secured for
> > > production systems.
> > >
> > > Access to the data is given through the lrng_raw debugfs file. The
> > > data buffer should be multiples of sizeof(u32) to fill the entire
> > > buffer. Using the option lrng_testing.boot_test=3D1 the raw noise of
> > > the first 1000 entropy events since boot can be sampled.
> > >
> > > This test interface allows generating the data required for
> > > analysis whether the LRNG is in compliance with SP800-90B
> > > sections 3.1.3 and 3.1.4.
> > >
> > > CC: "Eric W. Biederman" <ebiederm@xmission.com>
> > > CC: "Alexander E. Patrakov" <patrakov@gmail.com>
> > > CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
> > > CC: "Theodore Y. Ts'o" <tytso@mit.edu>
> > > CC: Willy Tarreau <w@1wt.eu>
> > > CC: Matthew Garrett <mjg59@srcf.ucam.org>
> > > CC: Vito Caputo <vcaputo@pengaru.com>
> > > CC: Andreas Dilger <adilger.kernel@dilger.ca>
> > > CC: Jan Kara <jack@suse.cz>
> > > CC: Ray Strode <rstrode@redhat.com>
> > > CC: William Jon McCann <mccann@jhu.edu>
> > > CC: zhangjs <zachary@baishancloud.com>
> > > CC: Andy Lutomirski <luto@kernel.org>
> > > CC: Florian Weimer <fweimer@redhat.com>
> > > CC: Lennart Poettering <mzxreary@0pointer.de>
> > > CC: Nicolai Stange <nstange@suse.de>
> > > Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> > > Tested-by: Roman Drahtm=C3=BCller <draht@schaltsekun.de>
> > > Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > > Tested-by: Neil Horman <nhorman@redhat.com>
> > > Signed-off-by: Stephan Mueller <smueller@chronox.de>
> > > ---
> > > drivers/char/lrng/Kconfig        |  16 ++
> > > drivers/char/lrng/Makefile       |   1 +
> > > drivers/char/lrng/lrng_testing.c | 324 ++++++++++++++++++++++++++++++=
+
> > > 3 files changed, 341 insertions(+)
> > > create mode 100644 drivers/char/lrng/lrng_testing.c
> > >
> > > diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> > > index e6ca3acc1e48..4ccc710832ef 100644
> > > --- a/drivers/char/lrng/Kconfig
> > > +++ b/drivers/char/lrng/Kconfig
> > > @@ -169,4 +169,20 @@ config LRNG_APT_CUTOFF
> > >
> > >    default 325 if !LRNG_APT_BROKEN
> > >    default 32 if LRNG_APT_BROKEN
> > >
> > > +config LRNG_TESTING
> > > +    bool "Enable entropy test interface to LRNG noise source"
> > > +    select CONFIG_DEBUG_FS
> > > +    help
> > > +      The test interface allows a privileged process to capture
> > > +      the raw unconditioned noise that is collected by the LRNG
> > > +      for statistical analysis. Extracted noise data is not used
> > > +      to seed the LRNG.
> > > +
> > > +      The raw noise data can be obtained using the lrng_raw
> > > +      debugfs file. Using the option lrng_testing.boot_test=3D1
> > > +      the raw noise of the first 1000 entropy events since boot
> > > +      can be sampled.
> > > +
> > > +      If unsure, say N.
> > > +
> > > endif # LRNG
> > > diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
> > > index 0713e9c0aa6e..c0b6cc4301fe 100644
> > > --- a/drivers/char/lrng/Makefile
> > > +++ b/drivers/char/lrng/Makefile
> > > @@ -16,3 +16,4 @@ obj-$(CONFIG_LRNG_KCAPI)    +=3D lrng_kcapi.o
> > > obj-$(CONFIG_LRNG_JENT)        +=3D lrng_jent.o
> > > obj-$(CONFIG_LRNG_TRNG_SUPPORT)    +=3D lrng_trng.o
> > > obj-$(CONFIG_LRNG_HEALTH_TESTS)    +=3D lrng_health.o
> > > +obj-$(CONFIG_LRNG_TESTING)    +=3D lrng_testing.o
> > > diff --git a/drivers/char/lrng/lrng_testing.c
> > > b/drivers/char/lrng/lrng_testing.c new file mode 100644
> > > index 000000000000..5c33d3bd2172
> > > --- /dev/null
> > > +++ b/drivers/char/lrng/lrng_testing.c
> > > @@ -0,0 +1,324 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > > +/*
> > > + * Linux Random Number Generator (LRNG) Raw entropy collection tool
> > > + *
> > > + * Copyright (C) 2019, Stephan Mueller <smueller@chronox.de>
> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/atomic.h>
> > > +#include <linux/bug.h>
> > > +#include <linux/debugfs.h>
> > > +#include <linux/module.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/sched/signal.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +#include <linux/types.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/workqueue.h>
> > > +#include <asm/errno.h>
> > > +
> > > +#include "lrng_internal.h"
> > > +
> > > +#define LRNG_TESTING_RINGBUFFER_SIZE    1024
> > > +#define LRNG_TESTING_RINGBUFFER_MASK    (LRNG_TESTING_RINGBUFFER_SIZ=
E -
> > > 1)
> > > +
> > > +static u32 lrng_testing_rb[LRNG_TESTING_RINGBUFFER_SIZE];
> > > +static atomic_t lrng_rb_reader =3D ATOMIC_INIT(0);
> > > +static atomic_t lrng_rb_writer =3D ATOMIC_INIT(0);
> > > +static atomic_t lrng_rb_first_in =3D ATOMIC_INIT(0);
> > > +static atomic_t lrng_testing_enabled =3D ATOMIC_INIT(0);
> > > +
> > > +static DECLARE_WAIT_QUEUE_HEAD(lrng_raw_read_wait);
> > > +
> > > +static u32 boot_test =3D 0;
> > > +module_param(boot_test, uint, 0644);
> > > +MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of t=
he
> > > first" +                " entropy events");
> > > +
> > > +static inline void lrng_raw_entropy_reset(void)
> > > +{
> > > +    atomic_set(&lrng_rb_reader, 0);
> > > +    atomic_set(&lrng_rb_writer, 0);
> > > +    atomic_set(&lrng_rb_first_in, 0);
> > > +}
> > > +
> > > +static void lrng_raw_entropy_init(void)
> > > +{
> > > +    /*
> > > +     * The boot time testing implies we have a running test. If the
> > > +     * caller wants to clear it, he has to unset the boot_test flag
> > > +     * at runtime via sysfs to enable regular runtime testing
> > > +     */
> > > +    if (boot_test)
> > > +        return;
> > > +
> > > +    lrng_raw_entropy_reset();
> > > +    atomic_set(&lrng_testing_enabled, 1);
> > > +    pr_warn("Enabling raw entropy collection\n");
> > > +}
> > > +
> > > +static void lrng_raw_entropy_fini(void)
> > > +{
> > > +    if (boot_test)
> > > +        return;
> > > +
> > > +    lrng_raw_entropy_reset();
> > > +    atomic_set(&lrng_testing_enabled, 0);
> > > +    pr_warn("Disabling raw entropy collection\n");
> > > +}
> > > +
> > > +bool lrng_raw_entropy_store(u32 value)
> > > +{
> > > +    unsigned int write_ptr;
> > > +    unsigned int read_ptr;
> > > +
> > > +    if (!atomic_read(&lrng_testing_enabled) && !boot_test)
> > > +        return false;
> > > +
> > > +    write_ptr =3D (unsigned int)atomic_add_return_relaxed(1,
> > > &lrng_rb_writer); +    read_ptr =3D (unsigned
> > > int)atomic_read(&lrng_rb_reader);
>
> Before answering your comments, please allow me to clarify the following:
>
> This entire code is intended to obtain take raw unconditioned noise data =
that
> needs to be extracted from the kernel to user space to allow it to be fur=
ther
> analyzed. This is also why it is mentioned in the Kconfig selection that =
in
> doubt one should select N and that this code is not intended for producti=
on
> kernels although this code should be secure enough to be present in produ=
ction
> kernels.
>
> For example, raw unconditioned noise data needs to be processed by the
> complicated math outlined in chapter 6 of [1]. For that, there is a tool
> available, see [2]. For that tool, data is needed that is obtained with t=
he
> getrawentropy tool available with [3] where this tool obtains the data fr=
om
> the SysFS file that is implemented with this C file.
>
> In addition, [1] even needs the data from the very first 1000 interrupts =
after
> boot. Hence, the LRNG needs to be able to store that data until user spac=
e can
> pick it up (see the boot_test variable).
>
> The assessment resulting from this can be reviewed at [4] section 3.2 In
> particular, the numbers provided at the end of sections 3.2.3 and 3.2.4 a=
re
> obtained with this interface.
>
> Other examples where such raw unconditioned noise data is needed for furt=
her
> analysis is [5], especially chapter 6.
>
> This testing has nothing to do with the runtime testing provided with the
> patch set 11. All data that ends up here is not available to the LRNG and=
 will
> not contribute to any entropy collection.
>
> See the following:
>
>


>         if (this_cpu_read(cpu_tlbstate.loaded_mm) =3D=3D &init_mm)
>                 return;
>
> --
> 2.17.1
static inline void lrng_time_process(void)
> {
> ...
>         if (lrng_raw_entropy_store(now_time))
>                 return;
>
>
> bool lrng_raw_entropy_store(u32 value)
> {
> ...
>         if (!atomic_read(&lrng_testing_enabled) && !boot_test)
>                 return false;
> ...
>         return true;
>
> >
> > Am I correct in assuming that this function can be called concurrently =
in
> > different threads or CPUs?
>
> Yes, because it is called indirectly by add_interrupt_randomness.
> > > +
> > > +    /*
> > > +     * Disable entropy testing for boot time testing after ring buff=
er
> > > +     * is filled.
> > > +     */
> > > +    if (boot_test && write_ptr > LRNG_TESTING_RINGBUFFER_SIZE) {
> > > +        pr_warn_once("Boot time entropy collection test disabled\n")=
;
> > > +        return false;
> > > +    }
> > > +
> > > +    if (boot_test && !atomic_read(&lrng_rb_first_in))
> > > +        pr_warn("Boot time entropy collection test enabled\n");
> > > +
> > > +    lrng_testing_rb[write_ptr & LRNG_TESTING_RINGBUFFER_MASK] =3D va=
lue;
> >
> > You=E2=80=99re writing *somewhere*, but not necessarily to the first op=
en slot.
>
> The idea is that there is a reader pointer and a writer pointer where the
> reader always must be smaller or equal to the writer (modulo the size of =
the
> ring buffer). So, I do not care where the writer ptr is.
>
> All I need is that:
>
> 1. reader and writer ptr must start with the same value at boot time (e.g=
. 0)
>
> 2. reader ptr is always <=3D writer ptr in order for data to be read.

You're making an implicit assumption, though: that the writer has
actually written the data indicated by the writer ptr.  But you're
updating the writer ptr *before* you write, so that assumption is
false.

> But I simplified the code now, the code now only copies the data out if t=
he
> reader <=3D writer modulo the ring buffer size. In this case, if the writ=
er is
> much faster, then we loose some values.

I'll look at the new code.  I'm not sure what you mean by a <=3D b
modulo N -- in a cyclic group (e.g. the integers 0 .. N-1), there
isn't really a well-defined concept of <=3D.
