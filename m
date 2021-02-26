Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5B326173
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 11:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhBZKjV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 05:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhBZKin (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 26 Feb 2021 05:38:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD9D264F03;
        Fri, 26 Feb 2021 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614335881;
        bh=H8HVbdFoLD9aL64l9aoJCNHX5FsjhZMjzGatuz4+oiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QEzn1ldtP7wH67ppM8NvuV87amu0rHg0D1u+B6QZ4lIV9oBTg9NOC69He8bmIrbgS
         Ta8J7QUW0GfXDGsMZ7ciWvECtNClh5Dg2jBjYL/6Yh4pZ0zn+U/jcpcIxgoR1Xn0lk
         4f0vn/+0UnOn0RwvPZQwdYRCUOgPDOcFbmEIT6YFeRKJl8RvpQcfQcY8mRoZiCvf9N
         AeNzuoZM+b5gSAbI9XGj6n0ieGaiCQ27ZgyqmKRtWaA7T6B1Ffj/dUqokb1f5i3gA2
         /UyJWwzH1+MLZ2fcJ5BNgEeI0jQNiJckpREvUIWdVlSJ9+wDXyYpUwr80mMyt//9Ez
         YHPc7A9WJ3VYg==
Received: by mail-oi1-f179.google.com with SMTP id i21so6989252oii.2;
        Fri, 26 Feb 2021 02:38:01 -0800 (PST)
X-Gm-Message-State: AOAM530Scdj2hnrMWz+Uo3CMkSO9pSg17VwA4c6AIwAh9M2NJNmlOdR3
        zuu6rIUdVnS/52dPhAcm1lpTuL9cFte1bWnpw/c=
X-Google-Smtp-Source: ABdhPJzDtvRb8oB8ob5YmR+oTzoRhnFpIQ/IS1/6V4Sn7sFm6upNUoFcX/x93JkRdU7mvaQexwcbcZSVhYYJLhBQiaU=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr1476692oia.67.1614335880815;
 Fri, 26 Feb 2021 02:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com> <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 11:37:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
Message-ID: <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
Subject: Re: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car devices
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Dirk Behme <Dirk.Behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 25, 2021 at 11:51 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
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
> ---
>  MAINTAINERS                      |   7 ++
>  drivers/misc/Kconfig             |   1 +
>  drivers/misc/Makefile            |   1 +
>  drivers/misc/rcar_dab/Kconfig    |  11 ++
>  drivers/misc/rcar_dab/Makefile   |   8 ++
>  drivers/misc/rcar_dab/rcar_dev.c | 176 +++++++++++++++++++++++++++++++
>  drivers/misc/rcar_dab/rcar_dev.h | 116 ++++++++++++++++++++
>  drivers/misc/rcar_dab/rcar_fft.c | 160 ++++++++++++++++++++++++++++
>  include/uapi/linux/rcar_dab.h    |  35 ++++++

Can you explain why this is not in drivers/media/?

I don't think we want a custom ioctl interface for a device that implements
a generic specification. My first feeling would be that this should not
have a user-level API but instead get called by the DAB radio driver.

What is the intended usage model here? I assume the idea is to
use it in an application that receives audio or metadata from DAB.
What driver do you use for that?

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
> +};

There should be a '.compat_ioctl = compat_ptr_ioctl'
entry, provided that the arguments are compatible between
32-bit and 64-bit user space.

> +
> +static int rcar_dab_fft_init(struct rcar_dab *dab, struct rcar_dab_fft_req *fft)
> +{
> +       u32 mode;
> +
> +       for (mode = 0; mode < ARRAY_SIZE(rcar_dab_fft_size_lut); mode++)
> +               if (rcar_dab_fft_size_lut[mode] == fft->points)
> +                       break;
> +       if (mode == ARRAY_SIZE(rcar_dab_fft_size_lut))
> +               return -EINVAL;
> +       if (fft->ofdm_number == 0)
> +               return -EINVAL;
> +
> +       rcar_dab_write(dab, RCAR_DAB_FFTSSR, mode);
> +       rcar_dab_write(dab, RCAR_DAB_FFTNUMOFDMR, fft->ofdm_number);
> +       rcar_dab_write(dab, RCAR_DAB_FFTINADDR, (u32)dab->fft.dma_input_buf);
> +       rcar_dab_write(dab, RCAR_DAB_FFTOUTADDR, (u32)dab->fft.dma_output_buf);

Maybe use lower_32_bits() instead of the (u32) cast.

For clarity, you may also want to specifically ask for a 32-bit DMA mask
in the probe function, with a comment that describes what the hardware
limitation is.

> +
> +       if (copy_from_user(dab->fft.input_buffer, fft_req->input_address,
> +                          buffer_size)) {
> +               mutex_unlock(&dab->fft.lock);
> +               return -EFAULT;
> +       }
> +
> +       dab->fft.done = false;
> +       ret = rcar_dab_fft_init(dab, fft_req);
> +       if (ret) {
> +               mutex_unlock(&dab->fft.lock);
> +               return ret;
> +       }
> +
> +       rcar_dab_fft_enable(dab);
> +       wait_event_interruptible_timeout(dab->fft.wait, dab->fft.done, HZ);
> +       if (!dab->fft.done) {
> +               rcar_dab_fft_disable(dab);
> +               ret = -EFAULT;

-EFAULT doesn't look like the right error for timeout or signal
handling. Better check the return code from wait_event_interruptible_timeout()
instead.

> +
> +struct rcar_dab_fft_req {
> +       int points;                     /*
> +                                        * The number of points to use.
> +                                        * Legal values are 256, 512, 1024, and
> +                                        * 2048.
> +                                        */
> +       unsigned char ofdm_number;      /*
> +                                        * Orthogonal Frequency Division
> +                                        * Multiplexing (OFDM).
> +                                        * Minimum value is 1, maximum value is
> +                                        * 255.
> +                                        */
> +       void __user *input_address;     /*
> +                                        * User space address for the input
> +                                        * buffer.
> +                                        */
> +       void __user *output_address;    /*
> +                                        * User space address for the output
> +                                        * buffer.
> +                                        */
> +};

Please read Documentation/driver-api/ioctl.rst and make this a portable
data structure.

      Arnd
