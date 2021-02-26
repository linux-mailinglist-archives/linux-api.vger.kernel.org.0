Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05280326317
	for <lists+linux-api@lfdr.de>; Fri, 26 Feb 2021 14:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhBZNG2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Feb 2021 08:06:28 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:49382 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZNG0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Feb 2021 08:06:26 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 438F6580;
        Fri, 26 Feb 2021 14:05:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614344743;
        bh=Pn1GXf496O59uPaYl6Kxb/FwBF+ERmIgv38ha8Jcl/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuZRBC/3EctvpMjBlzYhC9ZycLOxegiRu95vr8qxIHUUXBzx5yO2qx/pfpw+UKJtB
         bS3EAh05N6xfEXLinLLFdtXaHlFYsY26hGX/O4BYtbyRtVMReCYidGaiEsb/qDhsvU
         H8f0zXkYoNggy4PuccawOn9rEasjD2PM3QsVowYc=
Date:   Fri, 26 Feb 2021 15:05:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car
 devices
Message-ID: <YDjyDB/l6dVoodKZ@pendragon.ideasonboard.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
 <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

Thank you for the patch.

On Fri, Feb 26, 2021 at 11:37:44AM +0100, Arnd Bergmann wrote:
> On Thu, Feb 25, 2021 at 11:51 PM Fabrizio Castro wrote:
> >
> > The DAB hardware accelerator found on R-Car E3 and R-Car M3-N devices is
> > a hardware accelerator for software DAB demodulators.
> > It consists of one FFT (Fast Fourier Transform) module and one decoder
> > module, compatible with DAB specification (ETSI EN 300 401 and
> > ETSI TS 102 563).
> > The decoder module can perform FIC decoding and MSC decoding processing
> > from de-puncture to final decoded result.
> >
> > This patch adds a device driver to support the FFT module only.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  MAINTAINERS                      |   7 ++
> >  drivers/misc/Kconfig             |   1 +
> >  drivers/misc/Makefile            |   1 +
> >  drivers/misc/rcar_dab/Kconfig    |  11 ++
> >  drivers/misc/rcar_dab/Makefile   |   8 ++
> >  drivers/misc/rcar_dab/rcar_dev.c | 176 +++++++++++++++++++++++++++++++
> >  drivers/misc/rcar_dab/rcar_dev.h | 116 ++++++++++++++++++++
> >  drivers/misc/rcar_dab/rcar_fft.c | 160 ++++++++++++++++++++++++++++
> >  include/uapi/linux/rcar_dab.h    |  35 ++++++
> 
> Can you explain why this is not in drivers/media/?
> 
> I don't think we want a custom ioctl interface for a device that implements
> a generic specification. My first feeling would be that this should not
> have a user-level API but instead get called by the DAB radio driver.
> 
> What is the intended usage model here? I assume the idea is to
> use it in an application that receives audio or metadata from DAB.
> What driver do you use for that?

I second Arnd here, a standard API would be best.

> > +static long rcar_dab_unlocked_ioctl(struct file *file, unsigned int cmd,
> > +                                   unsigned long arg)
> > +{
> > +       void __user *argp = (void __user *)arg;
> > +       struct rcar_dab *dab;
> > +       int ret;
> > +
> > +       dab = container_of(file->private_data, struct rcar_dab, misc);
> > +
> > +       switch (cmd) {
> > +       case RCAR_DAB_IOC_FFT:
> > +               if (!access_ok(argp, sizeof(struct rcar_dab_fft_req)))
> > +                       return -EFAULT;
> > +               ret = rcar_dab_fft(dab, argp);
> > +               break;
> > +       default:
> > +               ret = -ENOTTY;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct file_operations rcar_dab_fops = {
> > +       .owner          = THIS_MODULE,
> > +       .unlocked_ioctl = rcar_dab_unlocked_ioctl,
> > +};
> 
> There should be a '.compat_ioctl = compat_ptr_ioctl'
> entry, provided that the arguments are compatible between
> 32-bit and 64-bit user space.
> 
> > +
> > +static int rcar_dab_fft_init(struct rcar_dab *dab, struct rcar_dab_fft_req *fft)
> > +{
> > +       u32 mode;
> > +
> > +       for (mode = 0; mode < ARRAY_SIZE(rcar_dab_fft_size_lut); mode++)
> > +               if (rcar_dab_fft_size_lut[mode] == fft->points)
> > +                       break;
> > +       if (mode == ARRAY_SIZE(rcar_dab_fft_size_lut))
> > +               return -EINVAL;
> > +       if (fft->ofdm_number == 0)
> > +               return -EINVAL;
> > +
> > +       rcar_dab_write(dab, RCAR_DAB_FFTSSR, mode);
> > +       rcar_dab_write(dab, RCAR_DAB_FFTNUMOFDMR, fft->ofdm_number);
> > +       rcar_dab_write(dab, RCAR_DAB_FFTINADDR, (u32)dab->fft.dma_input_buf);
> > +       rcar_dab_write(dab, RCAR_DAB_FFTOUTADDR, (u32)dab->fft.dma_output_buf);
> 
> Maybe use lower_32_bits() instead of the (u32) cast.
> 
> For clarity, you may also want to specifically ask for a 32-bit DMA mask
> in the probe function, with a comment that describes what the hardware
> limitation is.
> 
> > +
> > +       if (copy_from_user(dab->fft.input_buffer, fft_req->input_address,
> > +                          buffer_size)) {
> > +               mutex_unlock(&dab->fft.lock);
> > +               return -EFAULT;
> > +       }
> > +
> > +       dab->fft.done = false;
> > +       ret = rcar_dab_fft_init(dab, fft_req);
> > +       if (ret) {
> > +               mutex_unlock(&dab->fft.lock);
> > +               return ret;
> > +       }
> > +
> > +       rcar_dab_fft_enable(dab);
> > +       wait_event_interruptible_timeout(dab->fft.wait, dab->fft.done, HZ);
> > +       if (!dab->fft.done) {
> > +               rcar_dab_fft_disable(dab);
> > +               ret = -EFAULT;
> 
> -EFAULT doesn't look like the right error for timeout or signal
> handling. Better check the return code from wait_event_interruptible_timeout()
> instead.
> 
> > +
> > +struct rcar_dab_fft_req {
> > +       int points;                     /*
> > +                                        * The number of points to use.
> > +                                        * Legal values are 256, 512, 1024, and
> > +                                        * 2048.
> > +                                        */
> > +       unsigned char ofdm_number;      /*
> > +                                        * Orthogonal Frequency Division
> > +                                        * Multiplexing (OFDM).
> > +                                        * Minimum value is 1, maximum value is
> > +                                        * 255.
> > +                                        */
> > +       void __user *input_address;     /*
> > +                                        * User space address for the input
> > +                                        * buffer.
> > +                                        */
> > +       void __user *output_address;    /*
> > +                                        * User space address for the output
> > +                                        * buffer.
> > +                                        */
> > +};
> 
> Please read Documentation/driver-api/ioctl.rst and make this a portable
> data structure.

We've suffered enough with DMA to user pointers. Let's use dmabuf
instead.

-- 
Regards,

Laurent Pinchart
