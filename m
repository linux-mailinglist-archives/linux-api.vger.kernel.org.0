Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EF32B2E2
	for <lists+linux-api@lfdr.de>; Wed,  3 Mar 2021 04:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhCCDAv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Mar 2021 22:00:51 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35760 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444086AbhCBMdi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Mar 2021 07:33:38 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1ED545D;
        Tue,  2 Mar 2021 13:32:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1614688374;
        bh=e/Y0M8qv9vPeCW6Q3y5Ln2XAzlf3D5bfRcvSEsOp8cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAmf/VxgFHsvT8vo5KLK5ZX+6pnTiQGE15b3PWyqR/lt9H5u+7BfsujtgZQCWuu2G
         HMqOAL1DCcZJHDO3oClsWWjtw53u88Srm+2ohD9QghK4rc427HD9riXYtNMJxG98mW
         XdGKPmQU613uCCrEy+eTuVPg3teyv2XYVoxdq8kU=
Date:   Tue, 2 Mar 2021 14:32:25 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Arnd Bergmann <arnd@kernel.org>,
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
        "REE dirk.behme@de.bosch.com" <dirk.behme@de.bosch.com>,
        Peter Erben <Peter.Erben@de.bosch.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH 4/7] misc: Add driver for DAB IP found on Renesas R-Car
 devices
Message-ID: <YD4wWYc7/pDucm3s@pendragon.ideasonboard.com>
References: <20210225225147.29920-1-fabrizio.castro.jz@renesas.com>
 <20210225225147.29920-5-fabrizio.castro.jz@renesas.com>
 <CAK8P3a1+CZTAcR5T=gN565Q8=CdZnu5KYsAijKXLY8taofEpGg@mail.gmail.com>
 <OSAPR01MB2737666F47174B68A8EC8DD8C29A9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
 <CAAEAJfDDhN4btecUzu=3ZYxP=amnOD=vq0bhhetx7voKdeMZ9Q@mail.gmail.com>
 <OSAPR01MB2737169C686080958657D65AC2999@OSAPR01MB2737.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OSAPR01MB2737169C686080958657D65AC2999@OSAPR01MB2737.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Fabrizio,

On Tue, Mar 02, 2021 at 12:20:17PM +0000, Fabrizio Castro wrote:
> On 02 March 2021 11:17, Ezequiel Garcia wrote:
> > On Mon, 1 Mar 2021 at 14:36, Fabrizio Castro wrote:
> > > On 26 February 2021 10:38, Arnd Bergmann wrote:
> > > > On Thu, Feb 25, 2021 at 11:51 PM Fabrizio Castro wrote:
> > > > >
> > > > > The DAB hardware accelerator found on R-Car E3 and R-Car M3-N devices is
> > > > > a hardware accelerator for software DAB demodulators.
> > > > > It consists of one FFT (Fast Fourier Transform) module and one decoder
> > > > > module, compatible with DAB specification (ETSI EN 300 401 and
> > > > > ETSI TS 102 563).
> > > > > The decoder module can perform FIC decoding and MSC decoding processing
> > > > > from de-puncture to final decoded result.
> > > > >
> > > > > This patch adds a device driver to support the FFT module only.
> > > > >
> > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > > > ---
> > > > >  MAINTAINERS                      |   7 ++
> > > > >  drivers/misc/Kconfig             |   1 +
> > > > >  drivers/misc/Makefile            |   1 +
> > > > >  drivers/misc/rcar_dab/Kconfig    |  11 ++
> > > > >  drivers/misc/rcar_dab/Makefile   |   8 ++
> > > > >  drivers/misc/rcar_dab/rcar_dev.c | 176 +++++++++++++++++++++++++++++++
> > > > >  drivers/misc/rcar_dab/rcar_dev.h | 116 ++++++++++++++++++++
> > > > >  drivers/misc/rcar_dab/rcar_fft.c | 160 ++++++++++++++++++++++++++++
> > > > >  include/uapi/linux/rcar_dab.h    |  35 ++++++
> > > >
> > > > Can you explain why this is not in drivers/media/?
> > >
> > > I wasn't entirely sure were to put it to be honest as I couldn't find
> > > anything similar, that's why "misc" for v1, to mainly get a feedback
> > > and advice.
> > >
> > > > I don't think we want a custom ioctl interface for a device that
> > > > implements
> > > > a generic specification. My first feeling would be that this should not
> > > > have a user-level API but instead get called by the DAB radio driver.
> > >
> > > I hear you, the trouble is that the modules of this IP should be seen
> > > as part of a SW and HW processing pipeline.
> > > Some of the SW components of the pipeline can be proprietary, and
> > > unfortunately we don't have access (yet) to a framework that allows us to
> > > test and demonstrate the whole pipeline, for the moment we can only test
> > > things in isolation. It'll take us a while to come up with a full solution
> > > (or to have access to one), and in the meantime our SoCs come with an IP
> > > that can't be used because there is no driver for it (yet).
> > >
> > > After discussing things further with Geert and Laurent, I think they
> > > are right in saying that the best path for this is probably to add this
> > > driver under "drivers/staging" as an interim solution, so that the IP will
> > > be accessible by developers, and when we have everything we need (a fully
> > > fledged processing framework), we will able to integrate it better with
> > > the other components (if possible).
> > >
> > > > What is the intended usage model here? I assume the idea is to
> > > > use it in an application that receives audio or metadata from DAB.
> > > > What driver do you use for that?
> > >
> > > This IP is similar to a DMA to some extent, in the sense that it takes
> > > input data from a buffer in memory and it writes output data onto a buffer
> > > in memory, and of course it does some processing in between.
> > 
> > That sounds like something that can fit V4L2 MEM2MEM driver.
> > You queue two buffers and an operation, and then run a job.
> 
> V4L2 MEM2MEM seems good for this in general, however the DAB IP is going
> to be shared by multiple processing pipelines (as usually we have several
> DRIF interfaces, and only 1 DAB IP), and for what concerns FFT specifically
> there is only 1 FFT module inside the DAB IP.
> My understanding is that the capabilities of V4L2 MEM2MEM devices are
> configured for the specific pipeline, but in the this context user space
> would have to continuously switch the capabilities of the DAB IP (at the
> right moment) to allow processing for data streams requiring different
> capabilities.
> 
> Am I wrong?

V4L2 M2M devices can be opened multiple times, but different processes,
which can configure the device in different ways, and submit jobs that
are then scheduled by the V4L2 M2M framework.

> > > It's not directly connected to any other Radio related IP.
> > > The user space application can read DAB IQ samples from the R-Car DRIF
> > > interface (via driver drivers/media/platform/rcar_drif.c, or from other
> > > sources since this IP is decoupled from DRIF), and then when it's time
> > > to accelerate FFT, FIC, or MSC, it can request services to the DAB IP, so
> > > that the app can go on and use the processor to do some work, while the DAB
> > > IP processes things.
> > > A framework to connect and exchange processing blocks (either SW or HW) and
> > > interfaces is therefore vital to properly place a kernel implementation
> > > in the great scheme of things, in its absence a simple driver can help
> > 
> > I'm not entirely sure we are missing a framework. What's missing in
> > V4L2 MEM2MEM?
> 
> I was referring to a user space framework (I should have been more specific
> with my previous email).
> 
> > Before considering drivers/staging, it would be interesting to figure
> > out if V4L2 can do it as-is, and if not, discuss what's missing.
> 
> I think an interim solution would allow us and users to evaluate things a
> little bit better, so that we can integrate this IP with V4L2 later on.

-- 
Regards,

Laurent Pinchart
