Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0D5383A97
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbhEQQ7A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 12:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238603AbhEQQ67 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 May 2021 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621270662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWn0ER8ktL8CjGxRv5Ynu626ORHTDXR+dt3CTUoFfXU=;
        b=VvMX1LiTbpVHFM7EN0DZDlmpmmJV/omkhuGhec5WZxv4rDMS2Y2c1oVCvbwa34VFoJIYRf
        pmlxiDdIZOV+P34z/eWlV+iiC3wwJdr6NOBbakwXxHG9s5vGSDySUc5pnWq5x6HIv7kO34
        jdyOmKPUuLF3vwEKnwM9g/EM1rZHrz0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Kn-pR_ZIMgybs4Xd8LrTQQ-1; Mon, 17 May 2021 12:57:40 -0400
X-MC-Unique: Kn-pR_ZIMgybs4Xd8LrTQQ-1
Received: by mail-lf1-f72.google.com with SMTP id u23-20020a1979170000b02901d2e8dd801dso1171741lfc.6
        for <linux-api@vger.kernel.org>; Mon, 17 May 2021 09:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWn0ER8ktL8CjGxRv5Ynu626ORHTDXR+dt3CTUoFfXU=;
        b=X4yektr+iHO5CbfO4o2KgoXCxfE26m94rlALDvtqvPorD9jZLrvURwTUIxcqhu1vYk
         bs3vmXw39ETYC0s0q7wzp1nCuc1ZMHoSyr+5+pw7CgrAw4llidVqFG3tuhtMwLI8MDeZ
         l8n5fjJQgOkQVL92+OY1gq6BTasNU/YsrTwkYEEU69I+qCpW5o/K3S9DDpyxLc8lH44d
         kdwLvvjyr8vf5zAW/T5S8n5LNhw+N3HGNj1T917GOZnXAQfyi4uwHxV5DRdsOsqTVaPs
         k6udbkRhYPTdsE+EdSs/txOz8X1Nx+Q7Upuz9C6ssLdAaHGeKAvHEPJ66FiPWwITR2Ax
         iKng==
X-Gm-Message-State: AOAM533gEdSzbRmNdsn9zMt1Ikcw6JsUoIxi6XrM4ameE30E7g1Uoyvf
        HxToUjgCQ5+ZIruh1+Ttci4uccXuVrT3O4uhUTvoEiCQnNpI+9zMGJPp8Cwq8+AeoCLSp5z3anB
        kiwW3iDUr86eEi/4Rl2nEsld2dVtVVs2rNEig
X-Received: by 2002:ac2:51ce:: with SMTP id u14mr93665lfm.252.1621270658862;
        Mon, 17 May 2021 09:57:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyffO4JpeGGpWTWQd6pBCcoqe0gRG4gxJB9gvjMRQo0SkkR936sREfwD/ThH7qQxY0d+BxlHTLIVDrxnuu2xs=
X-Received: by 2002:ac2:51ce:: with SMTP id u14mr93653lfm.252.1621270658676;
 Mon, 17 May 2021 09:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com> <20210504092340.00006c61@intel.com>
In-Reply-To: <20210504092340.00006c61@intel.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 17 May 2021 12:57:26 -0400
Message-ID: <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
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
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 4, 2021 at 12:25 PM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> Robin Murphy wrote:
>
> > On 2021-05-01 03:18, Jesse Brandeburg wrote:
> > > It was pointed out by Nitesh that the original work I did in 2014
> > > to automatically set the interrupt affinity when requesting a
> > > mask is no longer necessary. The kernel has moved on and no
> > > longer has the original problem, BUT the original patch
> > > introduced a subtle bug when booting a system with reserved or
> > > excluded CPUs. Drivers calling this function with a mask value
> > > that included a CPU that was currently or in the future
> > > unavailable would generally not update the hint.
> > >
> > > I'm sure there are a million ways to solve this, but the simplest
> > > one is to just remove a little code that tries to force the
> > > affinity, as Nitesh has shown it fixes the bug and doesn't seem
> > > to introduce immediate side effects.
> >
> > Unfortunately, I think there are quite a few other drivers now relying
> > on this behaviour, since they are really using irq_set_affinity_hint()
> > as a proxy for irq_set_affinity(). Partly since the latter isn't
> > exported to modules, but also I have a vague memory of it being said
> > that it's nice to update the user-visible hint to match when the
> > affinity does have to be forced to something specific.
> >
> > Robin.
>
> Thanks for your feedback Robin, but there is definitely a bug here that
> is being exposed by this code. The fact that people are using this
> function means they're all exposed to this bug.
>
> Not sure if you saw, but this analysis from Nitesh explains what
> happened chronologically to the kernel w.r.t this code, it's a useful
> analysis! [1]
>
> I'd add in addition that irqbalance daemon *stopped* paying attention
> to hints quite a while ago, so I'm not quite sure what purpose they
> serve.
>
> [1]
> https://lore.kernel.org/lkml/CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA@mail.gmail.com/
>

Wanted to follow up to see if there are any more objections or even
suggestions to take this forward?

-- 
Thanks
Nitesh

