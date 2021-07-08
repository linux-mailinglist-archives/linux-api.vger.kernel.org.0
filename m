Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355FF3C19C4
	for <lists+linux-api@lfdr.de>; Thu,  8 Jul 2021 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhGHT1W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Jul 2021 15:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230191AbhGHT1V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Jul 2021 15:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625772278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsxTuAclxTu8qb1R0DxQBwzpTyBlfCOBxIQ3/Pgcr6Y=;
        b=BVW/pk11yTP4cqx/ImKDz55zKFFE+OP+OgCd5bIVMpe/3HkBrQPt4uAd8pbk+e6HJ2zEn4
        Y5LGT8orY3D72lpgVov0qQrOCceZ1nQLLo1FidmQhWvCbogwMkL1Ro9qLiPfbhqwfx8g3W
        V7iwT33OlF+rnIA85lq3ot5GCLzLrSw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-e1rOOO4RNXeHv7FUKNitwQ-1; Thu, 08 Jul 2021 15:24:37 -0400
X-MC-Unique: e1rOOO4RNXeHv7FUKNitwQ-1
Received: by mail-lj1-f197.google.com with SMTP id 1-20020a2e0d010000b029015d8fce4f1bso902194ljn.17
        for <linux-api@vger.kernel.org>; Thu, 08 Jul 2021 12:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nsxTuAclxTu8qb1R0DxQBwzpTyBlfCOBxIQ3/Pgcr6Y=;
        b=IsdBQ9xgt5sX6hNcXO2+lhEh0Ez+YQLZnnl3KHOpv6Q38XjdCObwQXcklktzKjZuW5
         xwIMlMekqd3lLOXfahcbnJW0F/GErxqek3EX1NQJVPl1VGWnGuiizLxLQT0Ri6arnK1/
         4lphfXWO8B3RIwAxPpLZxuZbPk+oBfKoKyraof6OaDxumYH9eih76sZc8R7JRI0OSiji
         AniAY7CCL3080CVSYwdyCpEsuEPwaRQtdS9vP6YBtOoWt7QKXlXxEPaZbufdOpFvjDRL
         hK1s37LxfGXacOcUGF6IGJ5uit902vdbuyn6vEFk5PqeSFBP6QkRpu93TMiPrYcX+UXH
         hk1w==
X-Gm-Message-State: AOAM532paVhhb/jY6uK2Xq4kJPzKXY0rq7ZfUbhAWWfbeM0wqXdZSBgF
        JLcgfuK5ulfQ9azAtxjg6QkuFGJKZh48inQk4MzFujwxMoe3idq/7FVtxp1K5B5kGtIBdjkGRtq
        xrelLDdp9d2voM5oBZotwpTU+Ghgl5sd9tFdS
X-Received: by 2002:a2e:9483:: with SMTP id c3mr25334460ljh.273.1625772273889;
        Thu, 08 Jul 2021 12:24:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDYtxeUSUFc1n8l1e9BpuRNR1vxtYML+PXp2N9a0XSSCaX+U6fdwcSN7qnV1r+ETm2kmWVrTe90n1T6sIwCC8=
X-Received: by 2002:a2e:9483:: with SMTP id c3mr25334431ljh.273.1625772273639;
 Thu, 08 Jul 2021 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210629152746.2953364-1-nitesh@redhat.com>
In-Reply-To: <20210629152746.2953364-1-nitesh@redhat.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Thu, 8 Jul 2021 15:24:20 -0400
Message-ID: <CAFki+LnUGiEE-7Uf-x8-TQZYZ+3Migrr=81gGLYszxaK-6A9WQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] genirq: Cleanup the usage of irq_set_affinity_hint
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
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
        Al Stone <ahs3@redhat.com>, leonro@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 29, 2021 at 11:28 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> The drivers currently rely on irq_set_affinity_hint() to either set the
> affinity_hint that is consumed by the userspace and/or to enforce a custom
> affinity.
>
> irq_set_affinity_hint() as the name suggests is originally introduced to
> only set the affinity_hint to help the userspace in guiding the interrupts
> and not the affinity itself. However, since the commit
>
>         e2e64a932556 "genirq: Set initial affinity in irq_set_affinity_hint()"
>
> irq_set_affinity_hint() also started applying the provided cpumask (if not
> NULL) as the affinity for the interrupts. The issue that this commit was
> trying to solve is to allow the drivers to enforce their affinity mask to
> distribute the interrupts across the CPUs such that they don't always end
> up on CPU0. This issue has been resolved within the irq subsystem since the
> commit
>
>         a0c9259dc4e1 "irq/matrix: Spread interrupts on allocation"
>
> Hence, there is no need for the drivers to overwrite the affinity to spread
> as it is dynamically performed at the time of allocation.
>
> Also, irq_set_affinity_hint() setting affinity unconditionally introduces
> issues for the drivers that only want to set their affinity_hint and not the
> affinity itself as for these driver interrupts the default_smp_affinity_mask
> is completely ignored (for detailed investigation please refer to [1]).
>
> Unfortunately reverting the commit e2e64a932556 is not an option at this
> point for two reasons [2]:
>
> - Several drivers for a valid reason (performance) rely on this API to
>   enforce their affinity mask
>
> - Until very recently this was the only exported interface that was
>   available
>
> To clear this out Thomas has come up with the following interfaces:
>
> - irq_set_affinity(): only sets affinity of an IRQ [3]
> - irq_update_affinity_hint(): Only sets the hint [4]
> - irq_set_affinity_and_hint(): Sets both affinity and the hint mask [4]
>
> The first API is already merged in the linux-next tree and the patch
> that introduces the other two interfaces are included with this patch-set.
>
> To move to the stage where we can safely get rid of the
> irq_set_affinity_hint(), which has been marked deprecated, we have to
> move all its consumers to these new interfaces. In this patch-set, I have
> done that for a few drivers and will hopefully try to move the remaining of
> them in the coming days.
>
> Testing
> -------
> In terms of testing, I have performed some basic testing on x86 to verify
> things such as the interrupts are evenly spread on all CPUs, hint mask is
> correctly set etc. for the drivers - i40e, iavf, mlx5, mlx4, ixgbe, i40iw
> and enic on top of:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>
> So more testing is probably required for these and the drivers that I didn't
> test and any help will be much appreciated.
>
>
> Notes
> -----
> - I was told that i40iw driver is going to be replaced by irdma, however,
>   the new driver didn't land in Linus's tree yet. Once it does I will send
>   a follow up patch for that as well.
>
> - For the mpt3sas driver I decided to go with the usage of
>   irq_set_affinity_and_hint over irq_set_affinity based on my little
>   analysis of it and the megaraid driver. However, if we are sure that it
>   is not required then I can replace it with just irq_set_affinity as one
>   of its comment suggests.
>
>
> Change from v1 [5]
> ------------------
> - Fixed compilation error by adding the new interface definitions for cases
>   where CONFIG_SMP is not defined
>
> - Fixed function usage in megaraid_sas and removed unnecessary variable
>   (Robin Murphy)
>
> - Removed unwanted #if/endif from mlx4 (Leon Romanovsky)
>
> - Other indentation related fixes
>
>
> [1] https://lore.kernel.org/lkml/1a044a14-0884-eedb-5d30-28b4bec24b23@redhat.com/
> [2] https://lore.kernel.org/linux-pci/d1d5e797-49ee-4968-88c6-c07119343492@arm.com/
> [3] https://lore.kernel.org/linux-arm-kernel/20210518091725.046774792@linutronix.de/
> [4] https://lore.kernel.org/patchwork/patch/1434326/
> [5] https://lore.kernel.org/linux-scsi/20210617182242.8637-1-nitesh@redhat.com/
>
>
> Nitesh Narayan Lal (13):
>   iavf: Use irq_update_affinity_hint
>   i40e: Use irq_update_affinity_hint
>   scsi: megaraid_sas: Use irq_set_affinity_and_hint
>   scsi: mpt3sas: Use irq_set_affinity_and_hint
>   RDMA/i40iw: Use irq_update_affinity_hint
>   enic: Use irq_update_affinity_hint
>   be2net: Use irq_update_affinity_hint
>   ixgbe: Use irq_update_affinity_hint
>   mailbox: Use irq_update_affinity_hint
>   scsi: lpfc: Use irq_set_affinity
>   hinic: Use irq_set_affinity_and_hint
>   net/mlx5: Use irq_update_affinity_hint
>   net/mlx4: Use irq_update_affinity_hint
>
> Thomas Gleixner (1):
>   genirq: Provide new interfaces for affinity hints
>
>  drivers/infiniband/hw/i40iw/i40iw_main.c      |  4 +-
>  drivers/mailbox/bcm-flexrm-mailbox.c          |  4 +-
>  drivers/net/ethernet/cisco/enic/enic_main.c   |  8 +--
>  drivers/net/ethernet/emulex/benet/be_main.c   |  4 +-
>  drivers/net/ethernet/huawei/hinic/hinic_rx.c  |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 +--
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++--
>  drivers/net/ethernet/mellanox/mlx4/eq.c       |  8 ++-
>  .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  6 +--
>  drivers/scsi/lpfc/lpfc_init.c                 |  4 +-
>  drivers/scsi/megaraid/megaraid_sas_base.c     | 27 +++++-----
>  drivers/scsi/mpt3sas/mpt3sas_base.c           | 21 ++++----
>  include/linux/interrupt.h                     | 53 ++++++++++++++++++-
>  kernel/irq/manage.c                           |  8 +--
>  15 files changed, 113 insertions(+), 64 deletions(-)
>
> --
>
>

Gentle ping.
Any comments or suggestions on any of the patches included in this series?

-- 
Thanks
Nitesh

