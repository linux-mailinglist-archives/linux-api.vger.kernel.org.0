Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9936F23F
	for <lists+linux-api@lfdr.de>; Thu, 29 Apr 2021 23:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhD2Vpx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Apr 2021 17:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237191AbhD2Vpv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Apr 2021 17:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619732703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juBq8jG0IfhjhmycH0bcejt+prDDhvyOJbkP2ywOwNE=;
        b=D0nNNUnv5A60U0Zr1jsl4cXx41cyl57a5nMoQnEr8AI2FTpPX+Dqo4Z7/CYe+ehNerTsmF
        MWwuMQn/Nfy21E9jM/s8h9FD2uHbLOV6ZxjgrV82ATOYZXsEgB2jKyK0pqphcDMgYgqHB7
        Z56PIWHPV5TWZCeKaLUbHmVSqJc6WlA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-ZNdFZbD_M9OXx2bcS1ZVIg-1; Thu, 29 Apr 2021 17:44:59 -0400
X-MC-Unique: ZNdFZbD_M9OXx2bcS1ZVIg-1
Received: by mail-lj1-f197.google.com with SMTP id v26-20020a2e481a0000b02900bf48f13296so11462065lja.1
        for <linux-api@vger.kernel.org>; Thu, 29 Apr 2021 14:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=juBq8jG0IfhjhmycH0bcejt+prDDhvyOJbkP2ywOwNE=;
        b=UNqJ/nexq53+xEA2y2T3lWaGDPZkwZg0LNIfNA0dWQmy68F3igMzKB1ZVYut4i14Ho
         QRtquboNT5WDJAU3oxUt+r72w9PTUTUZDgbbJshuqgumOmYlb1Ir0wx7YSeQwr3Bpiub
         +XVLv5kUKJnWmJZcbB34m2J+VNVR+mMmBfTZ1dn7NlcAmrdZSc1FoK1rYbFVp6rb+aYO
         NleV1RbnvKM/PUYrR5obhv5VTq0CPmhT7eTA4kxtMxX47aanyQ+YQ8g6Yu7rPiH6N0/U
         eJCZdXOWVA+8+9eeQHuVhqwXYITUuBG+UaTM+MTthKUy8Sx2JjW0t9cvEoTok/Vpf1s3
         W3XQ==
X-Gm-Message-State: AOAM533fBvtko/TJoQf4qAF/eDgFCXVu26A+IDOJM652y1OgWXg4mEfO
        JHBFvGfInwP9z4ze5O6MDo914tinbiAJHvRDQpN9Es5AriojmjFlYg7Oj4G3V6CL+QPk6ys/oCO
        i8+vN34jgjv0VQWm8dffQmAlpPJnow52+V1wv
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr1134843lfi.114.1619732697205;
        Thu, 29 Apr 2021 14:44:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq2yRpSe5jOEVMGxxLBllv8qHMqPFdT3eYasEEC3DgxW5MevAa194Ne1yMWKmZJkT52IuNqeA3rQotfpiob2s=
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr1134820lfi.114.1619732696953;
 Thu, 29 Apr 2021 14:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200625223443.2684-1-nitesh@redhat.com> <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com> <20210127121939.GA54725@fuller.cnet>
 <87r1m5can2.fsf@nanos.tec.linutronix.de> <20210128165903.GB38339@fuller.cnet>
 <87h7n0de5a.fsf@nanos.tec.linutronix.de> <20210204181546.GA30113@fuller.cnet>
 <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com> <20210204190647.GA32868@fuller.cnet>
 <d8884413-84b4-b204-85c5-810342807d21@redhat.com> <87y2g26tnt.fsf@nanos.tec.linutronix.de>
 <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com> <7780ae60-efbd-2902-caaa-0249a1f277d9@redhat.com>
 <07c04bc7-27f0-9c07-9f9e-2d1a450714ef@redhat.com> <20210406102207.0000485c@intel.com>
 <1a044a14-0884-eedb-5d30-28b4bec24b23@redhat.com> <20210414091100.000033cf@intel.com>
 <54ecc470-b205-ea86-1fc3-849c5b144b3b@redhat.com>
In-Reply-To: <54ecc470-b205-ea86-1fc3-849c5b144b3b@redhat.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Thu, 29 Apr 2021 17:44:45 -0400
Message-ID: <CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA@mail.gmail.com>
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, abelits@marvell.com
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 15, 2021, at 6:11 PM Nitesh Narayan Lal <nitesh@redhat.com> wro=
te:
>
>
> On 4/14/21 12:11 PM, Jesse Brandeburg wrote:
> > Nitesh Narayan Lal wrote:
> >
> >>> The original issue as seen, was that if you rmmod/insmod a driver
> >>> *without* irqbalance running, the default irq mask is -1, which means
> >>> any CPU. The older kernels (this issue was patched in 2014) used to u=
se
> >>> that affinity mask, but the value programmed into all the interrupt
> >>> registers "actual affinity" would end up delivering all interrupts to
> >>> CPU0,
> >> So does that mean the affinity mask for the IRQs was different wrt whe=
re
> >> the IRQs were actually delivered?
> >> Or, the affinity mask itself for the IRQs after rmmod, insmod was chan=
ged
> >> to 0 instead of -1?
> > The smp_affinity was 0xfff, and the kernel chooses which interrupt to
> > place the interrupt on, among any of the bits set.
>
>

<snip>

> >
> > Your description of the problem makes it obvious there is an issue. It
> > appears as if cpumask_local_spread() is the wrong function to use here.
> > If you have any suggestions please let me know.
> >
> > We had one other report of this problem as well (I'm not sure if it's
> > the same as your report)
> > https://lkml.org/lkml/2021/3/28/206
> > https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20210125=
/023120.html
>
>

So to understand further what the problem was with the older kernel based
on Jesse's description and whether it is still there I did some more
digging. Following are some of the findings (kindly correct me if
there is a gap in my understanding):

Part-1: Why there was a problem with the older kernel?
------
With a kernel built on top of the tag v4.0.0 (with Jesse's patch reverted
and irqbalance disabled), if we observe the/proc/irq for ixgbe device IRQs
then there are two things to note:

# No separate effective affinity (Since it has been introduced as a part of
  the 2017 IRQ re-work)
  $ ls /proc/irq/86/
    affinity_hint  node  p2p1  smp_affinity  smp_affinity_list  spurious

# Multiple CPUs are set in the smp_affinity_list and the first CPU is CPU0:

  $ proc/irq/60/p2p1-TxRx-0
    0,2,4,6,8,10,12,14,16,18,20,22

  $ /proc/irq/61/p2p1-TxRx-1
    0,2,4,6,8,10,12,14,16,18,20,22

  $ /proc/irq/62/p2p1-TxRx-2
    0,2,4,6,8,10,12,14,16,18,20,22
     ...


Now,  if we read the commit message from Thomas's patch that was part of
this IRQ re-work:
fdba46ff:  x86/apic: Get rid of multi CPU affinity
"
..
2) Experiments have shown that the benefit of multi CPU affinity is close
   to zero and in some tests even worse than setting the affinity to a sing=
le
   CPU.

The reason for this is that the delivery targets the APIC with the lowest
ID first and only if that APIC is busy (servicing an interrupt, i.e. ISR is
not empty) it hands it over to the next APIC. In the conducted tests the
vast majority of interrupts ends up on the APIC with the lowest ID anyway,
so there is no natural spreading of the interrupts possible.=E2=80=9D
"

I think this explains why even if we have multiple CPUs in the SMP affinity
mask the interrupts may only land on CPU0.

With Jesse's patch in the kernel initial affinity mask that included
multiple CPUs is overwritten with a single CPU. This CPU was previously
selected based on vector_index, later on, this has been replaced with a log=
ic
where the CPU was fetched from cpumask_local_spread. Hence, in this
case, the interrupts will be spread across to different CPUs.

# listing the IRQ smp_affinity_list on the v4.0.0 kernel with Jesse's patch
  $ /proc/irq/60/p2p1-TxRx-0
    0
  $ /proc/irq/61/p2p1-TxRx-1
    1
  $ /proc/irq/62/p2p1-TxRx-2
    2
    ...
  $ /proc/irq/65/p2p1-TxRx-5
    5
  $ /proc/irq/66/p2p1-TxRx-6
    6
   ...



Part-2: Why this may not be a problem anymore?
------
With the latest kernel, if we check the effective_affinity_list for i40e
IRQs without irqblance and with Jesse's patch reverted, it is already set
to a single CPU that is not always 0. This CPU is retrieved based on vector
allocation count i.e., we get a CPU that has the lowest vector
allocation count.

  $ /proc/irq/100/i40e-eno1-TxRx-5
    28
  $ /proc/irq/101/i40e-eno1-TxRx-6
    30
  $ /proc/irq/102/i40e-eno1-TxRx-7
    32
    =E2=80=A6
  $ /proc/irq/121/i40e-eno1-TxRx-18
    16
  $ /proc/irq/122/i40e-eno1-TxRx-19
    18
    ..

@Jesse do you think the Part-1 findings explain the behavior that you have
observed in the past?

Also, let me know if there are any suggestions or experiments to try here.


--
Thanks
Nitesh

