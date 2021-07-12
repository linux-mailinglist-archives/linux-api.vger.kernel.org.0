Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6546D3C657E
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 23:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhGLVfc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhGLVfc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 17:35:32 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC3C0613E5
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 14:32:43 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e2so4540822ilu.5
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0UbOU0vjiqc719wOG0oZB7U04BfmrswCV40XldGFR0=;
        b=YqAFiVSy2G1zBJfGO843I1ZiXvfaN9nxExGEz/h3bVNireLhXXg2m6/9qeSswhiRhE
         lhzVRSRwgUVs6N7/VeOkw6PODsHmssoGDB+FgddHKZU+fKTC+AwQRhxO5+ERQCvIngg4
         TVkXhlejoVbx4vliSkFmDszzwPHtef0K8odyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0UbOU0vjiqc719wOG0oZB7U04BfmrswCV40XldGFR0=;
        b=Gtgb2ksTSSHIjDWDrECbsTn4TPXz66ikrh1JVMhLsqXFGY54yLBFvp4VKtbzZoKkCK
         DN8xjdrSLXujgUHRNQFbl3+cg0rDGLs36CF4LwXZMHLMbyRFlxdezzGv6uc+5AkwXHNK
         0ohi13kyDxX4zc3A2rtkEZI6dbCeoov10o5fN2X4kOCOG7SdZA9pNI2qEEhGiaNYBVfq
         qJaitB84rlSKs9rtzAALkzKXdjkmb/WOokCRFg7CM7uJV2NTQloqC1wB1R7PF3rdtkmq
         hm+ja3DiD1/UXsfj6gTlE6bYISUPuIc05u5bgYg+ZRHN16DZKTRMwOM6IO6k1ErEFnx1
         70MQ==
X-Gm-Message-State: AOAM532hafqmqeB8sy0WC64XiKEWp8sYI7Aa8KusSUnuqJ3QNggbI7SK
        x0LPk3Yz7ljKoIwSPEa3baBpQUs9e+XcJw==
X-Google-Smtp-Source: ABdhPJwsV5aS/oFjdxSPZdN9MxyFANYSf+Hlan6etXYc7mULDvvEcuGCb2nJSDB9UQyRtHVKjA0Tpg==
X-Received: by 2002:a92:d946:: with SMTP id l6mr598104ilq.162.1626125563178;
        Mon, 12 Jul 2021 14:32:43 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id e1sm8090481ioe.24.2021.07.12.14.32.41
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 14:32:42 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id h6so24555660iok.6
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 14:32:41 -0700 (PDT)
X-Received: by 2002:a6b:7719:: with SMTP id n25mr683754iom.37.1626125561291;
 Mon, 12 Jul 2021 14:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
In-Reply-To: <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 12 Jul 2021 14:32:05 -0700
X-Gmail-Original-Message-ID: <CAE=gft7Qd3NSnoFYaXv=FkP0=Je85mNOKojuW5rhg6HkS=usLA@mail.gmail.com>
Message-ID: <CAE=gft7Qd3NSnoFYaXv=FkP0=Je85mNOKojuW5rhg6HkS=usLA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 12, 2021 at 12:03 AM Michal Hocko <mhocko@suse.com> wrote:
>
> [Cc linux-api]
>
> On Fri 09-07-21 10:50:48, Evan Green wrote:
> > Currently it's not possible to enable hibernation without also enabling
> > generic swap for a given swap area. These two use cases are not the
> > same. For example there may be users who want to enable hibernation,
> > but whose drives don't have the write endurance for generic swap
> > activities.
> >
> > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > generic swapping to it. This region can still be wired up for use in
> > suspend-to-disk activities, but will never have regular pages swapped to
> > it.
>
> Could you expand some more on why a strict exclusion is really
> necessary? I do understand that one might not want to have swap storage
> available all the time but considering that swapon is really a light
> operation so something like the following should be a reasonable
> workaround, no?
>         swapon storage/file
>         s2disk
>         swapoff storage

Broadly, it seemed like a reasonable thing for the kernel to be able
to do. The workaround you suggest does work for some use cases, but it
seems like a gap the kernel could more naturally fill.

Without getting too off into the weeds, there a handful of factors
that make this change particularly useful to me:

 * Slicing off part of your SSD to be SLC (single level cell) is
expensive. From what I understand you gain endurance and speed at the
cost of 3-4x capacity. In other words for every 1GB of SLC space you
need for swap, it costs you 3-4GB of storage space out of the primary
namespace. So I'm incentivized to size this region as small as
possible. Hibernate's speed/endurance requirements are not quite as
harsh as regular swap. Steering them separately gives me the ability
to put the hibernate image in regular storage, and not be forced to
oversize expensive/fast swap space.

 * Even with the workaround, swap can end up in the hibernate region.
Hibernate starts by allocating its giant 50%-of-memory region, which
is often the forcing function for pushing things into swap. With the
workaround, even if my hibernate region is in last priority, there's
still a reasonable chance I'll end up swapping into it. If I have
different security designs for swap space and hibernate, then even a
chance of some swap leaking into this region is a problem.

 * I also want to limit the online attack surface that swap presents.
I can make headway here by disallowing open() calls on active swap
regions (via an LSM), and permanently disabling swapon/swapoff system
calls after early init. The workaround isn't great for me because I
want to set everything up at early init time and then not touch it. By
suspend time, on my system I no longer have the ability to make
swapon/swapoff calls.

-Evan
