Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B7332B2D9
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhCCC7b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 21:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442196AbhCBLSA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 06:18:00 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F924C06178C
        for <linux-api@vger.kernel.org>; Tue,  2 Mar 2021 03:16:43 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mm21so34197893ejb.12
        for <linux-api@vger.kernel.org>; Tue, 02 Mar 2021 03:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF8o3G0Xz1ovVmyTz0LE8nmr/a9IOJBCZQzOLkdGz5M=;
        b=1M2npcI4L13+kb2WpBZyNmExW6Ysb2w1U5IU1t0e7n/59wjk+NVisOO0ZPmc+X+DRm
         oRfkUSPQlL3XSV9HLg7IaSLcRZwvOXi51tiW/MQZtsnKbzKQqZyTV1DhASNJxfyDrnUM
         /+XPe4D58LpQ0a5pqraIkIaicJx4USEK8SwMyu5unSPersA+EbDezjNlZWApb8gSh7ru
         F+WPtdZ4W1C88AQQ6BdAy+cWxXhoG3Qa3nDShlxi7ESnSg23jCduGgpV3FVzvcS6YJcm
         89dS8EekzRj6jNRTIuhV0AQySic9bPbuB2PRnB7OL9mYAN24TJFgfmnpIPR/qkAb54Yt
         3Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF8o3G0Xz1ovVmyTz0LE8nmr/a9IOJBCZQzOLkdGz5M=;
        b=l8RyG+ngJFnR2GfoCZZY8szdC1KgtqA8ApsEAUP4K2cdC0Jfh2B1JD3OBKLiBYgUa7
         mkujRSggYsQwb4e+s3CZfXRdtfAEGtJreVzKH3xp+Ur7xx1A3K6sHUwgMnlbU6G/fq4H
         H5iGCoVnAfUW/ZrX/nZeQcuXNeE+lMXVWAQr3u2pSQsiLM40H6imGYMgemZgDZoICHX5
         O+Krb2dKYKJZbfg2pvo8zqf18Y7IHGL8fQQntlU4RyNVq7hvR1+dkDsB2zYLBz0v/OBA
         9QQosgAQcHCnl7sUKqC+RB2nJkiFSp6wBenFzrpOo5kuGuvXy2hVCb6s7cUkTt5LiQ1d
         qL/w==
X-Gm-Message-State: AOAM531GYOCS55L99InMRQvO0dIXa3Rpy6vuE8Sj2TGzKF86MkxbeT8H
        YBhu1NhT7JnXOGPBecxhNCr2UTdgxo5I+cgEdWxeLw==
X-Google-Smtp-Source: ABdhPJz8/7tNah6b/MgRZScB2hUyILC3MI06tBMODCACw2hr59BzB0LAv71ny8kEnaP0SW9ATHxlZ92zkxlbY0Vp5cQ=
X-Received: by 2002:a17:906:29c3:: with SMTP id y3mr19539341eje.430.1614683801754;
 Tue, 02 Mar 2021 03:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-5-fabrizio.castro.jz@renesas.com> <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
 <OSAPR01MB2737666F47174B68A8EC8DD8C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB2737666F47174B68A8EC8DD8C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 2 Mar 2021 08:16:30 -0300
Message-ID: <CAAEAJfDDhN4btecUzu=3ZYxP=amnOD=vq0bhhetx7voKdeMZ9Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car devices
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello everyone,

On Mon, 1 Mar 2021 at 14:36, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Hi Arnd,
>
> Thanks for your feedback!
>
> > From: Arnd Bergmann <arnd@kernel.org>
> > Sent: 26 February 2021 10:38
> > Subject: Re: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-
> > Car devices
> >
> > On Thu, Feb 25, 2021 at 11:51 PM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > >
> > > The DAB hardware accelerator found on R-Car E3 and R-Car M3-N devices is
> > > a hardware accelerator for software DAB demodulators.
> > > It consists of one FFT (Fast Fourier Transform) module and one decoder
> > > module, compatible with DAB specification (ETSI EN 300 401 and
> > > ETSI TS 102 563).
> > > The decoder module can perform FIC decoding and MSC decoding processing
> > > from de-puncture to final decoded result.
> > >
> > > This patch adds a device driver to support the FFT module only.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > ---
> > >  MAINTAINERS                      |   7 ++
> > >  drivers/misc/Kconfig             |   1 +
> > >  drivers/misc/Makefile            |   1 +
> > >  drivers/misc/rcar_dab/Kconfig    |  11 ++
> > >  drivers/misc/rcar_dab/Makefile   |   8 ++
> > >  drivers/misc/rcar_dab/rcar_dev.c | 176 +++++++++++++++++++++++++++++++
> > >  drivers/misc/rcar_dab/rcar_dev.h | 116 ++++++++++++++++++++
> > >  drivers/misc/rcar_dab/rcar_fft.c | 160 ++++++++++++++++++++++++++++
> > >  include/uapi/linux/rcar_dab.h    |  35 ++++++
> >
> > Can you explain why this is not in drivers/media/?
>
> I wasn't entirely sure were to put it to be honest as I couldn't find
> anything similar, that's why "misc" for v1, to mainly get a feedback
> and advice.
>
> >
> > I don't think we want a custom ioctl interface for a device that
> > implements
> > a generic specification. My first feeling would be that this should not
> > have a user-level API but instead get called by the DAB radio driver.
>
> I hear you, the trouble is that the modules of this IP should be seen
> as part of a SW and HW processing pipeline.
> Some of the SW components of the pipeline can be proprietary, and
> unfortunately we don't have access (yet) to a framework that allows us to
> test and demonstrate the whole pipeline, for the moment we can only test
> things in isolation. It'll take us a while to come up with a full solution
> (or to have access to one), and in the meantime our SoCs come with an IP
> that can't be used because there is no driver for it (yet).
>
> After discussing things further with Geert and Laurent, I think they
> are right in saying that the best path for this is probably to add this
> driver under "drivers/staging" as an interim solution, so that the IP will
> be accessible by developers, and when we have everything we need (a fully
> fledged processing framework), we will able to integrate it better with
> the other components (if possible).
>
> >
> > What is the intended usage model here? I assume the idea is to
> > use it in an application that receives audio or metadata from DAB.
> > What driver do you use for that?
>
> This IP is similar to a DMA to some extent, in the sense that it takes
> input data from a buffer in memory and it writes output data onto a buffer
> in memory, and of course it does some processing in between.

That sounds like something that can fit V4L2 MEM2MEM driver.
You queue two buffers and an operation, and then run a job.

> It's not directly connected to any other Radio related IP.
> The user space application can read DAB IQ samples from the R-Car DRIF
> interface (via driver drivers/media/platform/rcar_drif.c, or from other
> sources since this IP is decoupled from DRIF), and then when it's time
> to accelerate FFT, FIC, or MSC, it can request services to the DAB IP, so
> that the app can go on and use the processor to do some work, while the DAB
> IP processes things.
> A framework to connect and exchange processing blocks (either SW or HW) and
> interfaces is therefore vital to properly place a kernel implementation
> in the great scheme of things, in its absence a simple driver can help

I'm not entirely sure we are missing a framework. What's missing in
V4L2 MEM2MEM?

Before considering drivers/staging, it would be interesting to figure
out if V4L2 can do it as-is, and if not, discuss what's missing.

Thanks,
Ezequiel
