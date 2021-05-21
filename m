Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB338BAA1
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 02:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhEUAFS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 20:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234498AbhEUAFQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 20:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621555433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yY5C4rKyGeidFpZPaRAHZm77aYdXwBLOJbXSDp6aeQo=;
        b=IrF0hc4kWrKQ0HfMBePMYtrv1LzTPUzpMXaTAaM9UgunaJOVidXYLwFdHiXsIbo2cnV5Zc
        4A7N6jrR0lN3sBpg66gThLjuicMSzrwCLIrMp2SMChKvKcH4CFMFi/nB0RXPNpoC6CB5cb
        4W/UKf+3RFix6/cU2dyGIFOASk9EFgI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-sge3RMFiMy-TKOgRSzwv9Q-1; Thu, 20 May 2021 20:03:52 -0400
X-MC-Unique: sge3RMFiMy-TKOgRSzwv9Q-1
Received: by mail-lf1-f72.google.com with SMTP id s30-20020a195e1e0000b029020e901fbe80so4536270lfb.22
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 17:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY5C4rKyGeidFpZPaRAHZm77aYdXwBLOJbXSDp6aeQo=;
        b=d6oGM7y+X3PQKQfICOdCn3AyYdD5p5Cce5H+T+3BddzYW2lYKBsi9JnO8vSHp2e0SB
         sJhmC/ARNOWxtNYgcZgXZGlZX2z/4qF+ixWAQ3/F6pkF9qUObo8zgPbzkO5eFG5NRWRK
         CD+RzkVpCgx1/nD+N9cEK56E+lxAUOLmEGa+IEZ7DzcnmXaxvoEqWHOoHP9+oEbcMenL
         09NTo5k0ww9L1b8TEABGUNewiHmh9AwfSnKKjDfl4o/eL68uZNDhOn44Da7E7xYYH7Rx
         sYHjiaoSWrQIkMfVKo/ztTyY57Q74BMtOireq7LJHbsbQr9BFy8TOs81N63H/kxpE/+f
         5Ejw==
X-Gm-Message-State: AOAM533/O8FhsJu+zkCEEzXWVyNwe/4LK5nnTdDWXWYhycAwSjVprbIM
        6xTa/6/40xXs7cCH+aZQ5OnorWTQRqwtkNyuGXRiOtnIM2UvWzsGBZToFfXGkmq7isyk61uRqkk
        YxQpGOhcDnbFv9iCReVA2IAZEAJkaxK1H87JM
X-Received: by 2002:a2e:1405:: with SMTP id u5mr4619186ljd.137.1621555430551;
        Thu, 20 May 2021 17:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPZc4H2Y4hAkVPTqEKOh1WdHXnKldKsyeMgCwEjITdNxHORoiwVToMhx6cyuK2hIWrTSLfeJEl7lCMqoeGy/c=
X-Received: by 2002:a2e:1405:: with SMTP id u5mr4619179ljd.137.1621555430294;
 Thu, 20 May 2021 17:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210504092340.00006c61@intel.com> <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de> <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
In-Reply-To: <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Thu, 20 May 2021 20:03:38 -0400
Message-ID: <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
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

On Thu, May 20, 2021 at 5:57 PM Nitesh Lal <nilal@redhat.com> wrote:
>
> On Mon, May 17, 2021 at 8:23 PM Nitesh Lal <nilal@redhat.com> wrote:
> >
> > On Mon, May 17, 2021 at 8:04 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Mon, May 17 2021 at 18:44, Nitesh Lal wrote:
> > > > On Mon, May 17, 2021 at 4:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >> The hint was added so that userspace has a better understanding where it
> > > >> should place the interrupt. So if irqbalanced ignores it anyway, then
> > > >> what's the point of the hint? IOW, why is it still used drivers?
> > > >>
> > > > Took a quick look at the irqbalance repo and saw the following commit:
> > > >
> > > > dcc411e7bf    remove affinity_hint infrastructure
> > > >
> > > > The commit message mentions that "PJ is redesiging how affinity hinting
> > > > works in the kernel, the future model will just tell us to ignore an IRQ,
> > > > and the kernel will handle placement for us.  As such we can remove the
> > > > affinity_hint recognition entirely".
> > >
> > > No idea who PJ is. I really love useful commit messages. Maybe Neil can
> > > shed some light on that.
> > >
> > > > This does indicate that apparently, irqbalance moved away from the usage of
> > > > affinity_hint. However, the next question is what was this future
> > > > model?
> > >
> > > I might have missed something in the last 5 years, but that's the first
> > > time I hear about someone trying to cleanup that thing.
> > >
> > > > I don't know but I can surely look into it if that helps or maybe someone
> > > > here already knows about it?
> > >
> > > I CC'ed Neil :)
> >
> > Thanks, I have added PJ Waskiewicz as well who I think was referred in
> > that commit message as PJ.
> >
> > >
> > > >> Now there is another aspect to that. What happens if irqbalanced does
> > > >> not run at all and a driver relies on the side effect of the hint
> > > >> setting the initial affinity. Bah...
> > > >>
> > > >
> > > > Right, but if they only rely on this API so that the IRQs are spread across
> > > > all the CPUs then that issue is already resolved and these other drivers
> > > > should not regress because of changing this behavior. Isn't it?
> > >
> > > Is that true for all architectures?
> >
> > Unfortunately, I don't know and that's probably why we have to be careful.
>
> I think here to ensure that we are not breaking any of the drivers we have
> to first analyze all the existing drivers and understand how they are using
> this API.
> AFAIK there are three possible scenarios:
>
> - A driver use this API to spread the IRQs
>   + For this case we should be safe considering the spreading is naturally
>     done from the IRQ subsystem itself.

Forgot to mention another thing in the above case is to determine whether
it is true for all architectures or not as Thomas mentioned.

>
> - A driver use this API to actually set the hint
>   + These drivers should have no functional impact because of this revert
>
> - Driver use this API to force a certain affinity mask
>   + In this case we have to replace the API with the irq_force_affinity()
>
> I can start looking into the individual drivers, however, testing them will
> be a challenge.
>
> Any thoughts?
>
> --
> Thanks
> Nitesh



-- 
Thanks
Nitesh

