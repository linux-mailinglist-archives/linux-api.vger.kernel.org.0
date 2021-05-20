Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3329438B946
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 23:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhETV7Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 17:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhETV7Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 17:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621547883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkTVO6S3XAPMr10XOopEA4GoA4JfOcUYU8NEFBnvEmw=;
        b=X3QnwKOjsSFLCL8ZOzIZpb8v8gn52yzvkZ7Fu0N8FRieaXTR9WVjEeJbGoaki8EIcH6bkn
        JHE+CgCDvyWOvax+sW6NXPCtssChyYWmj0AMWidx8PXqJQQnCTK8Pql8EFpPaOyG/D8WkN
        WTlq9+UyX0nLMcScaO48hPT3v0DjBdQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-2HcsHzaZMaa4WzB6SHfVUQ-1; Thu, 20 May 2021 17:58:01 -0400
X-MC-Unique: 2HcsHzaZMaa4WzB6SHfVUQ-1
Received: by mail-lf1-f70.google.com with SMTP id q7-20020a196e470000b029022ff5d290c5so4149004lfk.13
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 14:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkTVO6S3XAPMr10XOopEA4GoA4JfOcUYU8NEFBnvEmw=;
        b=jUoM0k9xUc9uCQfQudxcxP2/1QV/MVwZPbN4pgt3KdZkmDN98vNDmU9ol6Cb2Mfn9i
         blKv/dWqmOhMll7aQ+qGEW+rlVWWJ+d6nO33BdVpXQJKyt4f2/CQcMiBW763WcyrjHWW
         7WGtSyjxRd+2U/FFIB8qIgpzy/Pj4K6ArkS2X8aBquqwbqEmvvN+O80CpDkV1mWdLhxy
         Ir8lCYkS6rBBedeIXeIqZDLxMdnGCwrMNgyrGlwtApWw4jzq+UP0O7/fx2XfhzVU2dmb
         Nzla99TeTSmKClBy97M/UKbG7phdiz3nIc0kxI9CldLrmr0iqATQlCmXI5YJOY7IqUSp
         Jz4A==
X-Gm-Message-State: AOAM5319qgnVTcrEELA6aO2fXXA+tUMWVOqUbWopwzmT7HxXHS2aMlKC
        LCgBp5H8WO9Z5qlTUtgrUPAyBp3gUgzUP2HX+d580ZYzBQyQnJGyP767lCrpSy0Nr+p3ahe0SVU
        QpgNXjiq/ka5DhPVlnIa7u5AodpiNVeOKfcCB
X-Received: by 2002:a05:6512:3b93:: with SMTP id g19mr4668373lfv.548.1621547879544;
        Thu, 20 May 2021 14:57:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycNBHNApdEMPPfyR1CFYsoWikWJFtl6kPpEuS6x/SuQ79H+NxWtvmFXVfNLuDCxOYam0+CaH+Jtui15wxD2Gc=
X-Received: by 2002:a05:6512:3b93:: with SMTP id g19mr4668344lfv.548.1621547879329;
 Thu, 20 May 2021 14:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210504092340.00006c61@intel.com> <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de> <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
In-Reply-To: <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Thu, 20 May 2021 17:57:47 -0400
Message-ID: <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com,
        Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 17, 2021 at 8:23 PM Nitesh Lal <nilal@redhat.com> wrote:
>
> On Mon, May 17, 2021 at 8:04 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, May 17 2021 at 18:44, Nitesh Lal wrote:
> > > On Mon, May 17, 2021 at 4:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> The hint was added so that userspace has a better understanding where it
> > >> should place the interrupt. So if irqbalanced ignores it anyway, then
> > >> what's the point of the hint? IOW, why is it still used drivers?
> > >>
> > > Took a quick look at the irqbalance repo and saw the following commit:
> > >
> > > dcc411e7bf    remove affinity_hint infrastructure
> > >
> > > The commit message mentions that "PJ is redesiging how affinity hinting
> > > works in the kernel, the future model will just tell us to ignore an IRQ,
> > > and the kernel will handle placement for us.  As such we can remove the
> > > affinity_hint recognition entirely".
> >
> > No idea who PJ is. I really love useful commit messages. Maybe Neil can
> > shed some light on that.
> >
> > > This does indicate that apparently, irqbalance moved away from the usage of
> > > affinity_hint. However, the next question is what was this future
> > > model?
> >
> > I might have missed something in the last 5 years, but that's the first
> > time I hear about someone trying to cleanup that thing.
> >
> > > I don't know but I can surely look into it if that helps or maybe someone
> > > here already knows about it?
> >
> > I CC'ed Neil :)
>
> Thanks, I have added PJ Waskiewicz as well who I think was referred in
> that commit message as PJ.
>
> >
> > >> Now there is another aspect to that. What happens if irqbalanced does
> > >> not run at all and a driver relies on the side effect of the hint
> > >> setting the initial affinity. Bah...
> > >>
> > >
> > > Right, but if they only rely on this API so that the IRQs are spread across
> > > all the CPUs then that issue is already resolved and these other drivers
> > > should not regress because of changing this behavior. Isn't it?
> >
> > Is that true for all architectures?
>
> Unfortunately, I don't know and that's probably why we have to be careful.

I think here to ensure that we are not breaking any of the drivers we have
to first analyze all the existing drivers and understand how they are using
this API.
AFAIK there are three possible scenarios:

- A driver use this API to spread the IRQs
  + For this case we should be safe considering the spreading is naturally
    done from the IRQ subsystem itself.

- A driver use this API to actually set the hint
  + These drivers should have no functional impact because of this revert

- Driver use this API to force a certain affinity mask
  + In this case we have to replace the API with the irq_force_affinity()

I can start looking into the individual drivers, however, testing them will
be a challenge.

Any thoughts?

--
Thanks
Nitesh

