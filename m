Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09E1406E10
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhIJPTh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 11:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbhIJPTf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 11:19:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDAC061756
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 08:18:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t19so4692623lfe.13
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ckt49B6tK0rw1yJxpThlirv/UAOT77FwhKYK/1mwjPg=;
        b=XdYI209XBy0+GKPBUGJ37t/7vUL1qRZ9si2d9yu+Tu2W0BbPevophZciN8rmBlZgqT
         fuPSmosN8js9aJuEje1Q/jAUQlb9DKgunBM1DMkbb3OTXMA74zw5ltmbK5mzNgzASpAY
         gdI3+sv1sIGnU+RWZytjycVaERkGrWQrgw6XHEWHROO4S9h/gm14fN/77tFBVueOwb5h
         rxv1scg+ihAuEDNZzKOYguu2gPet4CxA28iBUwJda0QakLaW/w65Zy4dCXW6iWR8glhL
         IjxTLoJpqq5xXeu0hIR01kQOb1iI9Eh01tO3Weo2Ogu2kvybMtte8MZHmVnLV0ywpFJ1
         z3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ckt49B6tK0rw1yJxpThlirv/UAOT77FwhKYK/1mwjPg=;
        b=T21O103ssVAbuw1ijM/fOYCAR4vDSRan1JCxonb0qQ7ia1p2J1WVnRyp7EXod8uRJl
         jiz1DDEr3wjFsTFbY/wq7LSPhh+o9n5JbD4wBfo+tm5pfTvdF1O8yRp2n3A+mV8c1YvQ
         Aj162pMe7XmyueyJksyIHSVP074xc6531s9hc70ff+AOtTbkGcPY1tEz/fCdaEJb41cu
         nvmgLj1gAxClcsFSwv/KCaxLPTrFJvbSUk3k0p+XvHCnUh8IUMuXM+8QqE57Z8GO6ida
         JFoZPP867Nq5ntXPiI6Y7FIoZAT8BLg/qE7mBnvb90Qxs/vl6LZ1xyI8H7pl5eX4qos1
         zS1w==
X-Gm-Message-State: AOAM530PwxeaNejXzepNOMQdnRdsBCbD3F48f8dQ31vPFPb90hyHwK6j
        0ZOOPa/v4hSIPE9DHB/PKZHXVs4bXat69ocGus7HTJBfQhQYxQ==
X-Google-Smtp-Source: ABdhPJyxdvV65u6hxWSjktlmfeL/eVcata0Nfqb8P1uN5wI2ckUhekJFrpu6N2EGQh8m92qx16oFqQF95cGAXqeGytw=
X-Received: by 2002:ac2:57ce:: with SMTP id k14mr4439584lfo.316.1631287101655;
 Fri, 10 Sep 2021 08:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com> <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
In-Reply-To: <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 10 Sep 2021 08:18:10 -0700
Message-ID: <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
Subject: Fwd: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
To:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 8, 2021 at 5:16 PM Prakash Sangappa
<prakash.sangappa@oracle.com> wrote:
>
> Including liunx-kernel..
>
> Resending RFC. This patchset is not final. I am looking for feedback on
> this proposal to share thread specific data for us in latency sensitive
> codepath.

Hi Prakash,

I'd like to add here that Jann and I have been discussing a similar
feature for my UMCG patchset:

https://lore.kernel.org/lkml/CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com/

In short, due to the need to read/write to the userspace from
non-sleepable contexts in the kernel it seems that we need to have some
form of per task/thread kernel/userspace shared memory that is pinned,
similar to what your sys_task_getshared does.

Do you think your sys_task_getshared can be tweaked to return an
arbitrarily-sized block of memory (subject to overall constraints)
rather than a fixed number of "options"?

On a more general note, we have a kernel extension internally at
Google, named "kuchannel", that is similar to what you propose here:
per task/thread shared memory with counters and other stat fields that
the kernel populates and the userspace reads (and some additional
functionality that is not too relevant to the discussion).

Thanks,
Peter

[...]
