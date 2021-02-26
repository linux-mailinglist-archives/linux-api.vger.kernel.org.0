Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE843326028
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 10:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBZJf0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 04:35:26 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42208 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhBZJfK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 04:35:10 -0500
Received: by mail-ot1-f52.google.com with SMTP id e45so8491122ote.9;
        Fri, 26 Feb 2021 01:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZ43B2HFhv4tlOIOBxKLAeccyFA+MgCrLZMNO9bkBtY=;
        b=RyOW7CHBaV3cqmEGuJEgCZqIbW7r596XP04qkpfzFS/TZoxE47XQ5PQXJXiFlbEpUV
         nujJX0JUqnsud3cvbaefbLutd3cO1VELw8xs11cRtYRxxL5eibTUVGLJaKmxWkQFa1wv
         ZaNAwHkmlwiCILyGIyHsAiXMXQV+PFpj70mGCVDJZTcBNEFJ1UFaBTXDqz1djm55pM6c
         kXu+n3SZ+oY5pf01UA1meJiuPwuYwFTNPENQuZDiqi2WWNKmZ1+PvEuYRYp97EoGw7sK
         N3xsiQlqY31URrre0w0f9PbwXBCzgEuxVe9I4o6ZjZI6nPXt21RXTi+JsvkqDiHaYDbo
         7z0w==
X-Gm-Message-State: AOAM530Q6oGqCvAkTnVsKOQmj8rPtDlIwfTNWF+SIqSv81DwP//C5di/
        FjM9anVb3tDIpoj7iAfPb1nxQgI7cWCiBnNzMAI=
X-Google-Smtp-Source: ABdhPJxJulx5RDzxT58wPu3qYNtvQTi9qUqNw/ixFem6J5L7umQbMAPA5OISKzk6DsnolUxAUJhf+a4+C8nrPYZPKpM=
X-Received: by 2002:a9d:7196:: with SMTP id o22mr1577563otj.107.1614332067793;
 Fri, 26 Feb 2021 01:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com> <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Feb 2021 10:34:16 +0100
Message-ID: <CAMuHMdU1uTy_smaZGDcpRnDEUgKn-EYdpqEwP1qTN1=P5M073w@mail.gmail.com>
Subject: Re: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car devices
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Dirk Behme <Dirk.Behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

On Thu, Feb 25, 2021 at 11:53 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The DAB hardware accelerator found on R-Car E3 and R-Car M3-N devices is
> a hardware accelerator for software DAB demodulators.
> It consists of one FFT (Fast Fourier Transform) module and one decoder
> module, compatible with DAB specification (ETSI EN 300 401 and
> ETSI TS 102 563).
> The decoder module can perform FIC decoding and MSC decoding processing
> from de-puncture to final decoded result.
>
> This patch adds a device driver to support the FFT module only.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -461,4 +461,5 @@ source "drivers/misc/bcm-vk/Kconfig"
>  source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/habanalabs/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
> +source "drivers/misc/rcar_dab/Kconfig"

rcar-dab?


> --- /dev/null
> +++ b/drivers/misc/rcar_dab/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# R-Car DAB Hardware Accelerator
> +#
> +
> +config RCAR_DAB

DAB_RCAR?

> +       tristate "DAB accelerator for Renesas R-Car devices"
> +       depends on ARCH_R8A77990 || ARCH_R8A77965

|| COMPILE_TEST

> +       help
> +         Some R-Car devices come with an IP to accelerate DAB decoding.
> +         Enable this option to add driver support.

> --- /dev/null
> +++ b/drivers/misc/rcar_dab/rcar_dev.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * R-Car Gen3 DAB hardware accelerator driver
> + *
> + * Copyright (C) 2021 Renesas Electronics Corporation
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/uaccess.h>
> +
> +#include <uapi/linux/rcar_dab.h>
> +#include "rcar_dev.h"
> +
> +irqreturn_t rcar_dab_irq(int irq, void *devid)

static, as discovered by the robot.

> +{
> +       struct rcar_dab *dab = devid;
> +       u32 intsr, intcr1;
> +
> +       spin_lock(&dab->shared_regs_lock);
> +
> +       intcr1 = rcar_dab_read(dab, RCAR_DAB_INTCR1);
> +       rcar_dab_write(dab, RCAR_DAB_INTCR1, 0x000003FF);

Magic value (setting undocumented bits?), please use a define.

> +
> +       intsr = rcar_dab_read(dab, RCAR_DAB_INTSR);
> +       if (!intsr) {
> +               rcar_dab_write(dab, RCAR_DAB_INTCR1, intcr1);
> +               spin_unlock(&dab->shared_regs_lock);
> +               return IRQ_NONE;
> +       }
> +
> +       /* Re-enable interrupts that haven't fired */
> +       rcar_dab_write(dab, RCAR_DAB_INTCR1, 0x3FF & (intsr | intcr1));
> +       /* Clear interrupts */
> +       rcar_dab_write(dab, RCAR_DAB_INTSR, 0x7 & ~intsr);

More magic values.

> +
> +       spin_unlock(&dab->shared_regs_lock);
> +
> +       if (intsr & RCAR_DAB_INTSR_FFT_DONE)
> +               rcar_dab_fft_irq(dab);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static long rcar_dab_unlocked_ioctl(struct file *file, unsigned int cmd,
> +                                   unsigned long arg)
> +{
> +       void __user *argp = (void __user *)arg;
> +       struct rcar_dab *dab;
> +       int ret;
> +
> +       dab = container_of(file->private_data, struct rcar_dab, misc);
> +
> +       switch (cmd) {
> +       case RCAR_DAB_IOC_FFT:
> +               if (!access_ok(argp, sizeof(struct rcar_dab_fft_req)))
> +                       return -EFAULT;
> +               ret = rcar_dab_fft(dab, argp);

Do you envision ever using the FFT operation from kernel space?
Might be easier if you handle the copy_{from,to}_user() here.

> +               break;
> +       default:
> +               ret = -ENOTTY;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct file_operations rcar_dab_fops = {
> +       .owner          = THIS_MODULE,
> +       .unlocked_ioctl = rcar_dab_unlocked_ioctl,

Does this need compat_ioctl handling?

> +};
> +
> +static int rcar_dab_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct rcar_dab *dab;
> +       int ret, irq;
> +
> +       dab = devm_kzalloc(dev, sizeof(*dab), GFP_KERNEL);
> +       if (!dab)
> +               return -ENOMEM;
> +       dab->pdev = pdev;
> +
> +       dab->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(dab->base))
> +               return PTR_ERR(dab->base);
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(dev, "Can't get the irq.\n");
> +               return -EINVAL;
> +       }
> +
> +       dab->clk = devm_clk_get(&pdev->dev, "dab");
> +       if (IS_ERR(dab->clk)) {
> +               ret = PTR_ERR(dab->clk);
> +               dev_err(dev, "Can't get the clock (%d).\n", ret);
> +               return ret;
> +       }
> +
> +       spin_lock_init(&dab->shared_regs_lock);
> +
> +       ret = clk_prepare_enable(dab->clk);

Does the module clock need to be enabled all the time?
What about using Runtime PM instead of explicit clock handling, so your
driver will keep on working on future SoCs where the DAB block is part of
a power domain?

> +       if (ret)
> +               return ret;
> +
> +       ret = rcar_dab_fft_probe(dab);
> +       if (ret)
> +               goto error_clock_disable;
> +
> +       ret = devm_request_irq(dev, irq, rcar_dab_irq, 0, dev_name(dev), dab);
> +       if (ret) {
> +               dev_err(dev, "Can't request the irq (%d).\n", ret);
> +               goto error_remove;
> +       }
> +
> +       platform_set_drvdata(pdev, dab);
> +
> +       dab->misc.minor = MISC_DYNAMIC_MINOR;
> +       dab->misc.name = RCAR_DAB_DRV_NAME;
> +       dab->misc.fops = &rcar_dab_fops;
> +       ret = misc_register(&dab->misc);
> +       if (ret) {
> +               dev_err(dev, "Can't register misc device (%d).\n", ret);
> +               goto error_remove;
> +       }
> +
> +       dev_info(dev, "R-Car Gen3 DAB misc driver ready.\n");
> +
> +       return 0;
> +
> +error_remove:
> +       rcar_dab_fft_remove(dab);
> +
> +error_clock_disable:
> +       clk_disable_unprepare(dab->clk);
> +
> +       return ret;
> +}

> --- /dev/null
> +++ b/drivers/misc/rcar_dab/rcar_dev.h

> +/* Register DAB_FFTCR */
> +#define RCAR_DAB_FFTCR_FFT_EN_DISABLED         0
> +#define RCAR_DAB_FFTCR_FFT_EN_ENABLED          1

Do you need both?

#define RCAR_DAB_FFTCR_FFT_EN        BIT(0)

> +
> +/* Register DAB_FFTREQCR */
> +#define RCAR_DAB_FFTREQCR_FFT_REQ_INACTIVE     0
> +#define RCAR_DAB_FFTREQCR_FFT_REQ_ACTIVE       1

Do you need both?

> +
> +/* Register DAB_INTSR */
> +#define RCAR_DAB_INTSR_FFT_DONE                        0x1

BIT(0) (there are more bits for FIC and MSC)

> +
> +/* Register DAB_INTCR1 */
> +#define RCAR_DAB_INTCR1_FFT_DONE_MASK          0x1

BIT(0) (there are more bits for FIC and MSC)

> +#define RCAR_DAB_INTCR1_FFT_DONE_INT_ENABLED   0
> +#define RCAR_DAB_INTCR1_FFT_DONE_INT_DISABLED  1

Do you need these?
I'd just retain RCAR_DAB_INTCR1_FFT_DONE.

For enabling interrupts:

    rcar_dab_update_bits_locked(dab, RCAR_DAB_INTCR1,
                                RCAR_DAB_INTCR1_FFT_DONE,
                                RCAR_DAB_INTCR1_FFT_DONE);

and for disabling:

    rcar_dab_update_bits_locked(dab, RCAR_DAB_INTCR1,
                                CAR_DAB_INTCR1_FFT_DONE, 0);

> +
> +struct rcar_dab_fft {
> +       bool done;                      /*
> +                                        * Condition for waking up the process
> +                                        * sleeping while FFT is in progress.
> +                                        */

Please use kerneldoc for documenting structures.

> +       wait_queue_head_t wait;         /* Wait queue for FFT. */
> +       struct mutex lock;              /* Mutex for FFT. */
> +       dma_addr_t dma_input_buf;       /*
> +                                        * Input buffer seen by the FFT
> +                                        * module.
> +                                        */
> +       dma_addr_t dma_output_buf;      /*
> +                                        * Output buffer seen by the FFT
> +                                        * module.
> +                                        */
> +       void *input_buffer;             /* Input buffer seen by the CPU */
> +       void *output_buffer;            /* Output buffer seen by the CPU */

Please use consistent naming (buf vs buffer).

> +};

> --- /dev/null
> +++ b/drivers/misc/rcar_dab/rcar_fft.c

> +int rcar_dab_fft(struct rcar_dab *dab, struct rcar_dab_fft_req __user *fft_req)
> +{
> +       int buffer_size, ret;
> +
> +       buffer_size = fft_req->points * 4;

Missing validation of buffer_size?

> +
> +       mutex_lock(&dab->fft.lock);
> +
> +       if (copy_from_user(dab->fft.input_buffer, fft_req->input_address,
> +                          buffer_size)) {
> +               mutex_unlock(&dab->fft.lock);
> +               return -EFAULT;
> +       }
> +
> +       dab->fft.done = false;

You can init done in rcar_dab_fft_init(), too.

> +       ret = rcar_dab_fft_init(dab, fft_req);
> +       if (ret) {
> +               mutex_unlock(&dab->fft.lock);
> +               return ret;
> +       }
> +
> +       rcar_dab_fft_enable(dab);
> +       wait_event_interruptible_timeout(dab->fft.wait, dab->fft.done, HZ);
> +       if (!dab->fft.done) {

You can just check the return value of wait_event_interruptible_timeout().

> +               rcar_dab_fft_disable(dab);
> +               ret = -EFAULT;

-ETIMEOUT?

> +       } else if (copy_to_user(fft_req->output_address, dab->fft.output_buffer,
> +                               buffer_size)) {
> +               ret = -EFAULT;
> +       }
> +
> +       mutex_unlock(&dab->fft.lock);
> +
> +       return ret;
> +}

> --- /dev/null
> +++ b/include/uapi/linux/rcar_dab.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * R-Car Gen3 DAB user space interface data structures
> + *
> + * Copyright (C) 2021 Renesas Electronics Corporation
> + *
> + */
> +#ifndef _RCAR_DAB_H_
> +#define _RCAR_DAB_H_
> +
> +struct rcar_dab_fft_req {
> +       int points;                     /*

unsigned int

> +                                        * The number of points to use.
> +                                        * Legal values are 256, 512, 1024, and
> +                                        * 2048.
> +                                        */

Please use kerneldoc to document struct members.

> +       unsigned char ofdm_number;      /*
> +                                        * Orthogonal Frequency Division
> +                                        * Multiplexing (OFDM).
> +                                        * Minimum value is 1, maximum value is
> +                                        * 255.
> +                                        */

Please make padding explicit.
I'd also sort the members by decreasing size, i.e. pointers first.

> +       void __user *input_address;     /*

input_buf?

> +                                        * User space address for the input
> +                                        * buffer.
> +                                        */
> +       void __user *output_address;    /*

output_buf?

> +                                        * User space address for the output
> +                                        * buffer.
> +                                        */
> +};
> +
> +#define        RCAR_DAB_IOC_FFT                _IOWR(0x90, 1, struct rcar_dab_fft_req *)
> +
> +#endif /* _RCAR_DAB_H_ */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
