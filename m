Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F9C39C168
	for <lists+linux-api@lfdr.de>; Fri,  4 Jun 2021 22:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhFDUhs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Jun 2021 16:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhFDUhr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Jun 2021 16:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622838960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y6Thexy0S9yAdfMWlPeLLADSbYeQgKUJsnhXYbRk/4M=;
        b=XhS0Br0O+o0blnT7o3ulVnwPwfgJD7netfTE2epzrL41F0gAsKz+nepOOSeHokqc+boWY8
        yjmv57YuZbcm3X7MJz6rJjcZIDpVkQpKSSWOZqbrgmQY8Ay5s09gruRE4T1T1UsmxwxCt7
        n37bbkGUNX6bB2noViH5nSqIHOV1NzI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-qzex1CCMMyq1DdQuYy3irg-1; Fri, 04 Jun 2021 16:35:59 -0400
X-MC-Unique: qzex1CCMMyq1DdQuYy3irg-1
Received: by mail-lj1-f197.google.com with SMTP id y10-20020a05651c154ab02901337d2c58f3so4701678ljp.9
        for <linux-api@vger.kernel.org>; Fri, 04 Jun 2021 13:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6Thexy0S9yAdfMWlPeLLADSbYeQgKUJsnhXYbRk/4M=;
        b=XVPR7yZPY+1Us5guyCpvafSZrqpQ2a4dyid8dix72kmwSKzYWChuNXf77KuW4Ci6HX
         DpbU2dIzTKUHzWu31JpIExSjOW5wzJ9NhRkWr2wTVR71/jK2Umg39fAhN/BLSMsB2qjE
         YsAcyI2Mkn75MWo9G2jkvH/5L7OncPAUZqUfeiyA09FLV61DnrVLBqjFQEep/Z0MI7zN
         ZZTtwr0JdnQQdd2+1lDqLDWCSYLXbVoxst7UVx3GujO5aKvtufh4xlRVVTGvlEUeQVff
         ENTQCDt8cllQxuFGVFeqkTku5WoQam8q47rK8aRONYf/oRIDrruvtA2I1agpXoCUKgR4
         BnmA==
X-Gm-Message-State: AOAM530/bf4Y6sniFawe3tl8bjdRUuv6KLtBdIasfzJVKEfM8Z3Ic4Rw
        N5CV2HMf2QFk4VLff/Wkp7tD18ug/G0qwROki9VGo12s1YTSHsKPJQ0IhR6aascJPFoGdNBBbOk
        Vz1YkXaz0i8Nwh1fkOXX8/2qns2no0UWIG9t2
X-Received: by 2002:a2e:83ce:: with SMTP id s14mr4802990ljh.30.1622838957716;
        Fri, 04 Jun 2021 13:35:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA8sfpDISd7W3a8IsW6/YiM57Zw+/p+NaHoiuAPg8X6bW9cLXRUw/b5biIXrpjtTnIR6xsL3IgHzsQtEI3hbs=
X-Received: by 2002:a2e:83ce:: with SMTP id s14mr4802957ljh.30.1622838957476;
 Fri, 04 Jun 2021 13:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210504092340.00006c61@intel.com> <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de> <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
 <87zgwo9u79.ffs@nanos.tec.linutronix.de> <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
 <CAFki+LkqBHnVYB5VBx_8Ch0u8RfXrJsRzxyuDfHhbR-dCeN3Lg@mail.gmail.com> <87bl93ahc4.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87bl93ahc4.ffs@nanos.tec.linutronix.de>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 4 Jun 2021 16:35:45 -0400
Message-ID: <CAFki+LmW1d1f-mdFq8ovGERDRMkM7o=urmmQZi9cwXoR+Ydm=w@mail.gmail.com>
Subject: Re: [PATCH] genirq: Provide new interfaces for affinity hints
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
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

On Fri, May 21, 2021 at 5:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, May 21 2021 at 12:13, Nitesh Lal wrote:
> > On Fri, May 21, 2021 at 8:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Provide new interfaces:
> >>
> >>   irq_update_affinity_hint() - Only sets the affinity hint pointer
> >>   irq_apply_affinity_hint()  - Set the pointer and apply the affinity to
> >>                                the interrupt
> >>
> >
> > Any reason why you ruled out the usage of irq_set_affinity_and_hint()?
> > IMHO the latter makes it very clear what the function is meant to do.
>
> You're right. I was trying to phase the existing hint setter out, but
> that's probably pointless overengineering for no real value. Let me redo
> that.
>

Thomas, are you planning to send a v2 for this soon or did I somehow miss
it?

Since your other patch "genirq: Export affinity setter for modules" is
already in linux-next, I have started looking into the drivers where
we can use that.

On thinking about this whole chunk a little more, I do wonder about the
reason why we are still sticking with the hints.

The two reasons that I could come up with are:
- We are not entirely sure if irqbalance still consumes this or not
- For future use by some other userspace daemon  (?)

Does that sound right?

-- 
Thanks
Nitesh

