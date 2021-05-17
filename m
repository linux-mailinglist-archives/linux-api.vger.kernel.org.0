Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF6383C26
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhEQSXU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 14:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234389AbhEQSXT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 May 2021 14:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621275722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Ohvz0veaN5YV4OnEyJTkyNbce7kLNQOfav9z5UAAmk=;
        b=DJ/fNjnO4+bRJXuyaTn10Ml8NJvlql17Xr0kijfoiKNmGtQmqXFUq/TMwy6dsbfQzqx0us
        0HDmQVrzOLzJ6UXkCHpmQgwjZc55u6MkwEF864GVIxb3EI2ZVw4RP6TA7n5uasPBivQY/n
        lH7RY6uSxIyxDORHevneLUsviY+S8aI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-4_1nsF5xOx-Q6cGN7nzw9A-1; Mon, 17 May 2021 14:22:00 -0400
X-MC-Unique: 4_1nsF5xOx-Q6cGN7nzw9A-1
Received: by mail-lj1-f199.google.com with SMTP id v4-20020a2e96040000b02900ce9d1504b5so3446498ljh.16
        for <linux-api@vger.kernel.org>; Mon, 17 May 2021 11:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ohvz0veaN5YV4OnEyJTkyNbce7kLNQOfav9z5UAAmk=;
        b=DEoEYbCg2W+xffXUyhOBvTE8hBhgYEPV8wxa6lPrrG2yOkSbIonhWxQnDFPX56+vgN
         EZ3smNH72cZtqVfFseTosqjKGjCJl8wh4RbVWHPRoj8mpf1hXV+Y/WPl4Jhrq5l2ejGe
         9ne+iYrRHWzKBnCmixxeCDSnpdef+LqC1wjWgg3cakPcCEtdxVVxwrV7fv/BV5aujaZI
         VIW7U0l+jUGx2+YKm/nrjC9hL2gWYgxmT4srNdHz5FGI/79sudFG80S2r1XcOfET6NfB
         yGIsTLqBgBtbhjmJx7J8U/4qh6xo1FWLK5pI1ct0Wk9QEfokc5m8zojYiiJbCJAsCvtW
         nSHQ==
X-Gm-Message-State: AOAM533KkJP86aChayQp5OONCnCL1Qj+tHd6VD18a+iRPXUGYrmX4BDF
        1b/KycThMUwQT7GMEkxfbFjo6YJ/JaZOCzOjdLQlO40zCe/7Gos6Xb9iUlMXy3vo1IAbz0A0X7q
        Jsp2NYoxkTQ+4ppX05AzM6eENZFjhDBLFcmrq
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr773405lfu.647.1621275719244;
        Mon, 17 May 2021 11:21:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrzOCPhmlYUdV7MidYS7zax5+JMdj0yOGQTWafj9uEJx26idggzqb+1uILAInTM0kZZW7u6CfEAVSGwFUPCng=
X-Received: by 2002:a05:6512:2302:: with SMTP id o2mr773377lfu.647.1621275718883;
 Mon, 17 May 2021 11:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com> <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com> <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
In-Reply-To: <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 17 May 2021 14:21:47 -0400
Message-ID: <CAFki+L=LDizBJmFUieMDg9J=U6mn6XxTPPkAaWiyppTouTzaqw@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
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

On Mon, May 17, 2021 at 1:26 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-05-17 17:57, Nitesh Lal wrote:
> > On Tue, May 4, 2021 at 12:25 PM Jesse Brandeburg
> > <jesse.brandeburg@intel.com> wrote:
> >>
> >> Robin Murphy wrote:
> >>
> >>> On 2021-05-01 03:18, Jesse Brandeburg wrote:
> >>>> It was pointed out by Nitesh that the original work I did in 2014
> >>>> to automatically set the interrupt affinity when requesting a
> >>>> mask is no longer necessary. The kernel has moved on and no
> >>>> longer has the original problem, BUT the original patch
> >>>> introduced a subtle bug when booting a system with reserved or
> >>>> excluded CPUs. Drivers calling this function with a mask value
> >>>> that included a CPU that was currently or in the future
> >>>> unavailable would generally not update the hint.
> >>>>
> >>>> I'm sure there are a million ways to solve this, but the simplest
> >>>> one is to just remove a little code that tries to force the
> >>>> affinity, as Nitesh has shown it fixes the bug and doesn't seem
> >>>> to introduce immediate side effects.
> >>>
> >>> Unfortunately, I think there are quite a few other drivers now relying
> >>> on this behaviour, since they are really using irq_set_affinity_hint()
> >>> as a proxy for irq_set_affinity(). Partly since the latter isn't
> >>> exported to modules, but also I have a vague memory of it being said
> >>> that it's nice to update the user-visible hint to match when the
> >>> affinity does have to be forced to something specific.
> >>>
> >>> Robin.
> >>
> >> Thanks for your feedback Robin, but there is definitely a bug here that
> >> is being exposed by this code. The fact that people are using this
> >> function means they're all exposed to this bug.
> >>
> >> Not sure if you saw, but this analysis from Nitesh explains what
> >> happened chronologically to the kernel w.r.t this code, it's a useful
> >> analysis! [1]
> >>
> >> I'd add in addition that irqbalance daemon *stopped* paying attention
> >> to hints quite a while ago, so I'm not quite sure what purpose they
> >> serve.
> >>
> >> [1]
> >> https://lore.kernel.org/lkml/CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA@mail.gmail.com/
> >>
> >
> > Wanted to follow up to see if there are any more objections or even
> > suggestions to take this forward?
>
> Oops, sorry, seems I got distracted before getting round to actually
> typing up my response :)

No worries.

>
> I'm not implying that there isn't a bug, or that this code ever made
> sense in the first place, just that fixing it will unfortunately be a
> bit more involved than a simple revert.

Fair point.

> This patch as-is *will* subtly
> break at least the system PMU drivers currently using
> irq_set_affinity_hint() - those I know require the IRQ affinity to
> follow whichever CPU the PMU context is bound to, in order to meet perf
> core's assumptions about mutual exclusion.

Thanks for bringing this up.
Please correct me if I am wrong, so the PMU driver(s) is/are written
in a way that
it uses the hint API to overwrite the previously set affinity mask with a
CPU to which the PMU context is bound to?

Is this context information exposed in the userspace and can we modify the
IRQ affinity mask from the userspace based on that?
I do understand that this is a behavior change from the PMU drivers
perspective.

>
> As far as the consistency argument goes, maybe that's just backwards and
> it should be irq_set_affinity() that also sets the hint, to indicate to
> userspace that the affinity has been forced by the kernel? Either way
> we'll need to do a little more diligence to figure out which callers
> actually care about more than just the hint, and sort them out first.
>

We can use irq_set_affinity() to set the hint mask as well, however, maybe
there is a specific reason behind separating those two in the
first place (maybe not?).
But even in this case, we have to either modify the PMU drivers' IRQs
affinity from the userspace or we will have to make changes in the existing
request_irq code path.
I am not sure about the latter because we already have the required controls
to adjust the device IRQ mask (by using default_smp_affinity or by modifying
them manually).

-- 
Thanks
Nitesh

