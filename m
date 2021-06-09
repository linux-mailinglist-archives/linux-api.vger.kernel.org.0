Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB33A1722
	for <lists+linux-api@lfdr.de>; Wed,  9 Jun 2021 16:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhFIO0F (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Jun 2021 10:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbhFIOZ7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Jun 2021 10:25:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3471AC06175F;
        Wed,  9 Jun 2021 07:23:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ho18so27803857ejc.8;
        Wed, 09 Jun 2021 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jtL1+5VQHHT8bzDFTG2ayogpB519w3lSL+Ow8WttPMA=;
        b=bmayfmCa0b8f9xI0EN93lA+4Gr8gdpDsGMUtuuHdKOBRuNHiElMrY97YuAXFpkVpgl
         1H+aeXWXejLcxhKStK8Iei4Mc8+Q+Y8abAmOGxF3/Wub3CTT6IpzeDljPidc3GF3mb1+
         ekWE3VxjK6/3QOye90lKkdGejbfI+Kei0nDjmTYaL39jK0hcjrKrYSbjvNWOCUB/PLEQ
         UQTOn/OADOX5FdqH8vEpDQrsTammsbdJghutnEujOC91yNzdbyWkkzMT5Vms5McQlSHm
         MD3/bxryn7X5hfCb/LIwtkBnhMGXrLgA9iRcE+vDGQwc/5Qou3awCa4MbnajTJDYjjDL
         9dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtL1+5VQHHT8bzDFTG2ayogpB519w3lSL+Ow8WttPMA=;
        b=izJisYHEhDZc7wYeqIjV2y9rMmrIpznMKKEL/wwIsmhqexAdO1Y1vTFQk2qN6us60V
         xlXzWrByrBHdtWwGXsZLufYNflt3d1r65o3wnzFRHZv8qloHArTNDmdwe0aIxk9bopuy
         n7K8uV1df66dyZy9bAmSEHc4985J6E6+Ml3hYe4RYtlDsrjSfwUgooGy3jX8a9Xes8Nx
         GYIYGgzfiZbG1ezWCX8kj/vue4p1we8iVYgAtfhPT4+7Nl4dUjr8sVPFfa9lzvrt3w/V
         MU2Ry/LDZOBX2XlDAUEdSFufzuB84fbRjj4mQtWf76aEAgkVQScTGoU22cDaUHw5B8wX
         dVKg==
X-Gm-Message-State: AOAM530cSpvjk5M4OwxgXcGdmSGZjNyqvHVqBF3LQjCzEi7tJo5mLhDa
        nJa4wW+U085OAgh7j90u1OfMAhT6wtG4MkLTi/c=
X-Google-Smtp-Source: ABdhPJxup4vdQ3fDE/7P6t/FNZhoFn65HkkE9BnRji/N8/MGMInqiSMlbelQzof1+ZT715dm1myxEI3Bv7rwTDgIckU=
X-Received: by 2002:a17:906:cc14:: with SMTP id ml20mr91751ejb.515.1623248629776;
 Wed, 09 Jun 2021 07:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <1623080354-21453-1-git-send-email-yongw.pur@gmail.com> <YL84boGKozWE+n23@kroah.com>
In-Reply-To: <YL84boGKozWE+n23@kroah.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Wed, 9 Jun 2021 22:23:36 +0800
Message-ID: <CAOH5QeBV5zq=SpMSxZHJqgmfKegdgc7ehpots6AKjjgEYq5rGg@mail.gmail.com>
Subject: Re: [RFC PATCH V3] zram:calculate available memory when zram is used
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, linux-api@vger.kernel.org,
        lu.zhongjun@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.wenya1@zte.com.cn, wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:29=E5=86=99=E9=81=93=EF=BC=9A

>
> On Mon, Jun 07, 2021 at 08:39:14AM -0700, yongw.pur@gmail.com wrote:
> > From: wangyong <wang.yong12@zte.com.cn>
> >
> > When zram is used, available+Swap free memory is obviously bigger than =
we
> > actually can use, because zram can compress memory by compression
> > algorithm and zram compressed data will occupy memory too.
> >
> > So, we can count the compression ratio of zram in the kernel. The space
> > will be saved by zram and other swap device are calculated as follows:
> > zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
> > We can evaluate the available memory of the whole system as:
> > MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfre=
e]
>
> Why is this needed to be exported by userspace?  Who is going to use
> this information and why can't they just calculate it from the exported
> information already?

In embedded devices, it is necessary to assess how much memory is available=
.
If the memory allocation is based on available+swapfree, it may cause oom a=
nd
affect the normal use of the devices. And it is more accurate and safe
to calculate
the swap available memory through minimum compression ratio.

Although mm_stat interface provides compressed information=EF=BC=8Cbut it i=
s not easy to
get the minimum compression ratio during swaping out. Kernel provides a com=
mon
interface, which makes it easier to use and judge the state of system memor=
y

> What tool requires this new information and what is it going to be used
> for?

It can be used in embedded devices to evaluate the memory condition
and avoid causing oom; Also If we wants to know more accurate available
memory information when zram is used.

> And why add a block driver's information to a core proc file?  Shouldn't
> the information only be in the block driver's sysfs directory only?
>
> thanks,
>
> greg k-h

I thought it would be better to put it there.
In the first patch, MemAvailable returned with swap available memory, and
David recommended a separate interface.

thanks
