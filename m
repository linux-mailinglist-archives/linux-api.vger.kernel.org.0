Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5538236FB3B
	for <lists+linux-api@lfdr.de>; Fri, 30 Apr 2021 15:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhD3NLu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Apr 2021 09:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231696AbhD3NLt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Apr 2021 09:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619788260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFmN7GXhyvWoD/0hmIYm1FOaJDGHK8SDles6jaDUx50=;
        b=Roz6MQuvSjtJ36aHxa5jdtoHbhw6nn5qVcVsCPlEyP6roT8dQZ49pax45RBdhX7MnalPg+
        x9nV9r49LzNY1dg6iKKHIW62n6VTxPd5exLgjDZODvt3soKc3qSZQ3a6afSqrPddENUzBG
        kearsYv13LoUgNiJlsZ7Oi9efvQgmL0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-PzdFpoL1PIK7X1NukTJT_g-1; Fri, 30 Apr 2021 09:10:56 -0400
X-MC-Unique: PzdFpoL1PIK7X1NukTJT_g-1
Received: by mail-lj1-f198.google.com with SMTP id a18-20020a2eb5520000b02900beebb1aa69so17195764ljn.12
        for <linux-api@vger.kernel.org>; Fri, 30 Apr 2021 06:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFmN7GXhyvWoD/0hmIYm1FOaJDGHK8SDles6jaDUx50=;
        b=QifV4yhESNfJimWQIlA/Ui+X4oAP93D8JZl2V/0BtLeqvx3W2PBBwBBAJvgBj3iaip
         32NEIhOnWkUCEurshAEe8o4YcQ8X7+jFSv+yL6n2ylp1wq6QQ75MPqowY23fFUiySfyb
         TdLCysvH/sWK8YWjQ3JFzJ37YVfyVhPZjdo6OGTtXX7Iez3+8MK4++iueYXOvR3g0DL3
         JbI/nppb6PmUUYYfnHLa1P8phbPxUU1XrX8wh4KeDz+fFTOw5vkDe9H5yAfv3jrrfVhv
         aQe85yLmeUGjcmNynerd8l05btLiVHMsi5gIsVLnsT0o8fcCWEgCy0IQvvFcOprdsp3F
         8DIA==
X-Gm-Message-State: AOAM530gwTx+XAkpCrE9HP9/SojkZ6yaTfCElSkU+nrD3HtJ77NNE92I
        cFnFhsyUmvXcyJth5tlEVKabM6qvBbiXvn1AgANeNE5K67q+Pz4kVJC+uqfxtkJCKY5vyJc1kY5
        shTAjd6K/K63UZX1nl/Myv/eXHNGU1Rsacmwb
X-Received: by 2002:a2e:a71e:: with SMTP id s30mr3619813lje.137.1619788255165;
        Fri, 30 Apr 2021 06:10:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJqc1hlP2rkr8JKdzvyVvOdVHZomdQvDwhT1frYVIrIzVVBNex0m3GwjpZjhRo3TTecIKglydEAUtmkI34+Ic=
X-Received: by 2002:a2e:a71e:: with SMTP id s30mr3619779lje.137.1619788254917;
 Fri, 30 Apr 2021 06:10:54 -0700 (PDT)
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
 <54ecc470-b205-ea86-1fc3-849c5b144b3b@redhat.com> <CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA@mail.gmail.com>
 <20210429184802.0000641e@intel.com>
In-Reply-To: <20210429184802.0000641e@intel.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 30 Apr 2021 09:10:40 -0400
Message-ID: <CAFki+LnbX6bJPh18iowxSsC=W8A3D5PXSN4xBab0Qbxm-JjBew@mail.gmail.com>
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, abelits@marvell.com,
        Robin Murphy <robin.murphy@arm.com>,
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
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 29, 2021 at 9:48 PM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> Nitesh Lal wrote:
>
> > @Jesse do you think the Part-1 findings explain the behavior that you have
> > observed in the past?
> >
> > Also, let me know if there are any suggestions or experiments to try here.
>
> Wow Nitesh, nice work! That's quite a bit of spelunking you had to do
> there!
>
> Your results that show the older kernels with ranged affinity issues is
> consistent with what I remember from that time, and the original
> problem.

That's nice.

>
> I'm glad to see that a) Thomas fixed the kernel to even do better than
> ranged affinity masks, and that b) if you revert my patch, the new
> behavior is better and still maintains the fix from a).

Right, the interrupts are naturally spread now.

>
> For me this explains the whole picture and makes me feel comfortable
> with the patch that reverts the initial affinity mask (that also
> introduces a subtle bug with the reserved CPUs that I believe you've
> noted already).
>

Thank you for confirming!

--
Nitesh

