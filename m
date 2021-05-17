Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36DB386C11
	for <lists+linux-api@lfdr.de>; Mon, 17 May 2021 23:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhEQVOv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 May 2021 17:14:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237595AbhEQVOu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 May 2021 17:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621286013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMVyazJ1DXkMnUs3j/wPGjHkILobShDj4cNdkiPTOO8=;
        b=KFWsQtZHOxaDYVZg7ozn9PfqPfwhgPu6C8LrQrdGdSQ43IjncUsgGxBFZK8TpXjf817WrA
        n4tt3JKw+vritcNPfcULBeRijhW5UrSeUF3HzyaUaXJtl87zDJdV6t/KwfVxtc1GQ3TYnK
        asd5i0cZWMlFaLFR/n5rNBGk0/FVC64=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-ce0wFICbPnWfg6Q3HNslyA-1; Mon, 17 May 2021 17:13:31 -0400
X-MC-Unique: ce0wFICbPnWfg6Q3HNslyA-1
Received: by mail-lj1-f199.google.com with SMTP id a23-20020a05651c2117b02900e9751e7410so3653177ljq.6
        for <linux-api@vger.kernel.org>; Mon, 17 May 2021 14:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMVyazJ1DXkMnUs3j/wPGjHkILobShDj4cNdkiPTOO8=;
        b=HD/KZizzsrO9AZ5N+UtO0WO9o/EEDF7U+JO+3zPQljZ4kfMQksPrNzZ15BltUZj8Gr
         JMi3Vmdrk6CuL9Xi50xnFGsTfoNN65jGi96KJHnamAwjIqqu6pNhAM1Ya541TZHSqXUM
         2IAB5EFdi5QqOG/QOIrPK9ifYZmT2xw8YUBFy+1UtSvLlBpzD50DONZlVaiISLhL5ymA
         qNV7PhcNUXDV6YG1aGKirk6H3ubnl1cOHZ9ySEGv35qRei1Nm4yGSxZi3o3g7r7KMEIo
         WKj2TPFv6oV0uXJ+rV3rwmJX1P93WpRatWaBqOPrBMtFIKtCiMBxsZj6aa2H76l1Vpv5
         6HPw==
X-Gm-Message-State: AOAM532anshLk16QthPc6nZU5PAPyvnIsKWLPSkRHGUFWJiNgFigB9Pw
        VnfJ3w41Om/y61QqqV4iut90BnV9XNEBAoky0rI3lZmXcHkW7YmmzAfQyh0x5OVMG0Y4CArTWzq
        V0At+h0zzJ0+GqzzP2n05GlMaVZ8slzdQfvqi
X-Received: by 2002:a05:6512:3b0f:: with SMTP id f15mr1283920lfv.384.1621286010057;
        Mon, 17 May 2021 14:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqIbTFw79dJ0F4QTNj1vmQA/K7J9iPzeYKZygGXoFgqrcehoZoCiXVL8VcdElnx9bU093vnbhjyUBh7vmtE5k=
X-Received: by 2002:a05:6512:3b0f:: with SMTP id f15mr1283890lfv.384.1621286009804;
 Mon, 17 May 2021 14:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210501021832.743094-1-jesse.brandeburg@intel.com>
 <16d8ca67-30c6-bb4b-8946-79de8629156e@arm.com> <20210504092340.00006c61@intel.com>
 <CAFki+LmR-o+Fng21ggy48FUX7RhjjpjO87dn3Ld+L4BK2pSRZg@mail.gmail.com>
 <bf1d4892-0639-0bbf-443e-ba284a8ed457@arm.com> <CAFki+L=LDizBJmFUieMDg9J=U6mn6XxTPPkAaWiyppTouTzaqw@mail.gmail.com>
 <87y2cddtxb.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87y2cddtxb.ffs@nanos.tec.linutronix.de>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 17 May 2021 17:13:18 -0400
Message-ID: <CAFki+L=RaSZXASAaAxBf=RJqXWju+pkSj3ftMkmoqCLPfg0v=g@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
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

On Mon, May 17, 2021 at 3:47 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nitesh,
>
> On Mon, May 17 2021 at 14:21, Nitesh Lal wrote:
> > On Mon, May 17, 2021 at 1:26 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > We can use irq_set_affinity() to set the hint mask as well, however, maybe
> > there is a specific reason behind separating those two in the
> > first place (maybe not?).
>
> Yes, because kernel side settings might overwrite the hint.
>
> > But even in this case, we have to either modify the PMU drivers' IRQs
> > affinity from the userspace or we will have to make changes in the existing
> > request_irq code path.
>
> Adjusting them from user space does not work for various reasons,
> especially CPU hotplug.
>
> > I am not sure about the latter because we already have the required controls
> > to adjust the device IRQ mask (by using default_smp_affinity or by modifying
> > them manually).
>
> default_smp_affinity does not help at all and there is nothing a module
> can modify manually.

Right, it will not help a module.

>
> I'll send out a patch series which cleans that up soon.

Ack, thanks.

>
> Thanks,
>
>         tglx
>
>


--
Nitesh

