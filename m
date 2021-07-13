Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB953C7137
	for <lists+linux-api@lfdr.de>; Tue, 13 Jul 2021 15:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhGMNcl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Jul 2021 09:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236484AbhGMNcl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Jul 2021 09:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626182990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdeapieNS3PVuhbaSMCjhCNHL9ow03NjgZ6/hSsB7Qg=;
        b=UJNBB8XSU4fz6BYgn1iK9Bymu58POh24RLgF1wiH2nMRiYzzCDWY80t+kpbW/e02WnpntE
        KFrqcKmbpHzuKQUix9LLO6alRyeEKqqZbdsVze2SaM5OIwd0XMmeGQPfkO0cADaiUyWj/e
        Hh8A0TFZLvR2r/V33SN466cinKFUad4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-mdWRDubrPBm70_HGevJuAQ-1; Tue, 13 Jul 2021 09:29:49 -0400
X-MC-Unique: mdWRDubrPBm70_HGevJuAQ-1
Received: by mail-ed1-f71.google.com with SMTP id w15-20020a05640234cfb02903951279f8f3so11920258edc.11
        for <linux-api@vger.kernel.org>; Tue, 13 Jul 2021 06:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdeapieNS3PVuhbaSMCjhCNHL9ow03NjgZ6/hSsB7Qg=;
        b=VjGqGyTrSioTarYCViL2BUvS0rsY611Mk/f04yx6cZtA7UjpR3232bOBYCSzKFr81c
         cBp8CCbdLxOrvQDyJ/UivH9ohKI8Q4XF9EEHTP5IM011d0K1Hw+Zb27eU+VdtZP8/6Rc
         D7xOUoTF0CtTHJABeuA9Q7l/7WZ2FQJ2UgQ8qBBurI1KwkS10HcjsZSXTNyLDkTGIYQf
         Lk7fHWGQw/QBuR0W8Z5vtq0uzgHGBkHHc6qx8WTmcWWhyPVIpDqum+tEuCz1rOFPOOpw
         tsSA/nn4Xi4pxhgXPU5AGr3v7/vNOf2m7oWkVUXQHw0JScDACDxqO5xYSWfaiS4B90vN
         kA4w==
X-Gm-Message-State: AOAM530uRM1EADLT12I6icLig+oqquG3Au61+H/2MPusqWF22Y3/sKd9
        LKNsIosoHyvblcTDXRhjJeLQShaNRJzRQshY5CMTjU8c3AzQS4HtmolTA95HCjP6Nwrp7ddZrYU
        /LnhHQcVypalGk7W0DJehaCoapA0oKL1Q3ThG
X-Received: by 2002:aa7:dcd2:: with SMTP id w18mr5825641edu.145.1626182988592;
        Tue, 13 Jul 2021 06:29:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5wxQUQPgyLKUdlRZ2gZvYByjQxwh5vHfj9Zl/5/TUt6KM+BkoCgzKzFw3XseQAusiiqmnSZ0tdUwu4kYrB74=
X-Received: by 2002:aa7:dcd2:: with SMTP id w18mr5825614edu.145.1626182988415;
 Tue, 13 Jul 2021 06:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210629152746.2953364-1-nitesh@redhat.com> <CAFki+LnUGiEE-7Uf-x8-TQZYZ+3Migrr=81gGLYszxaK-6A9WQ@mail.gmail.com>
 <YOrWqPYPkZp6nRLS@unreal> <CAFki+L=FYOTQ1+-MHWmTuA6ZxTUcZA9t41HRL2URYgv03oFbDg@mail.gmail.com>
 <YO0eKv2GJcADQTHH@unreal>
In-Reply-To: <YO0eKv2GJcADQTHH@unreal>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Tue, 13 Jul 2021 09:29:37 -0400
Message-ID: <CAFki+L=LtHFvL5+h2JtWhKMDdR5=ABzOFnvdXCDcPfGisDb-9A@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] genirq: Cleanup the usage of irq_set_affinity_hint
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, jbrandeb@kernel.org,
        frederic@kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>, rostedt@goodmis.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com,
        Stefan Assmann <sassmann@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, kashyap.desai@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        suganath-prabu.subramani@broadcom.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, Ken Cox <jkc@redhat.com>,
        faisal.latif@intel.com, shiraz.saleem@intel.com, tariqt@nvidia.com,
        Alaa Hleihel <ahleihel@redhat.com>,
        Kamal Heib <kheib@redhat.com>, borisp@nvidia.com,
        saeedm@nvidia.com, benve@cisco.com, govind@gmx.com,
        jassisinghbrar@gmail.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Al Stone <ahs3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 13, 2021 at 1:01 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Jul 12, 2021 at 05:27:05PM -0400, Nitesh Lal wrote:
> > Hi Leon,
> >

<snip>

> > > >
> > > > Gentle ping.
> > > > Any comments or suggestions on any of the patches included in this series?
> > >
> > > Please wait for -rc1, rebase and resend.
> > > At least i40iw was deleted during merge window.
> > >
> >
> > In -rc1 some non-trivial mlx5 changes also went in.  I was going through
> > these changes and it seems after your patch
> >
> > e4e3f24b822f: ("net/mlx5: Provide cpumask at EQ creation phase")
> >
> > we do want to control the affinity for the mlx5 interrupts from the driver.
> > Is that correct?
>
> We would like to create devices with correct affinity from the
> beginning. For this, we will introduce extension to devlink to control
> affinity that will be used prior initialization sequence.
>
> Currently, netdev users who don't want irqbalance are digging into
> their procfs, reconfigure affinity on already existing devices and
> hope for the best.
>
> This is even more cumbersome for the SIOV use case, where every physical
> NIC PCI device will/can create thousands of lightweights netdevs that will
> be forwarded to the containers later. These containers are limited to known
> CPU cores, so no reason do not limit netdev device too.
>
> The same goes for other sub-functions of that PCI device, like RDMA,
> vdpa e.t.c.
>
> > This would mean that we should use irq_set_affinity_and_hint() instead
> > of irq_update_affinity_hint().
>
> I think so.
>

Thanks, will make that change in the patch and re-send.
I will also drop your reviewed-by for the mlx5 patch so that you can
have a look at it again, please let me know if you have any
objections.

-- 
Thanks
Nitesh

