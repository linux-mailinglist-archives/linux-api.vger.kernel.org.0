Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798E9409B9C
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 20:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbhIMSBg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbhIMSBg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 14:01:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7C3C061760
        for <linux-api@vger.kernel.org>; Mon, 13 Sep 2021 11:00:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n2so22933334lfk.0
        for <linux-api@vger.kernel.org>; Mon, 13 Sep 2021 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPLu6FRs6PsytvQa213g6Z9ikwL4Ay1Rx6H9mdVXAQY=;
        b=OdpG3PcsFCgf1/KlZhYOeLEsAkkVqhp725gZbfyKUJvZImP2NoJQ4oPWzRjmms5RQY
         AH7+AjdIFkt9sJkrDf0/3R09oGRkzogfJogqEmzUqsADzty/9i9KztZnqzXDWA1zfOdD
         K+303eXak0Xe0qNmGBE5lelHCy3CyndWlbSMC3Mma3S7W3ntT0vGwOskKsb/I0hpaV1w
         QF7xT+iopj/Fez7AtArDtnl5AMnwSGv3GYSzj8CpbxmHtWhAuPaafPVEnCp8LGxpQxxx
         2nQ3i/ngFXiX5YLRTyoQznYMwWyqEdwX5jeYcYw2ymD/5W7DkrhUpH0bXEt3Y1VyrC40
         cVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPLu6FRs6PsytvQa213g6Z9ikwL4Ay1Rx6H9mdVXAQY=;
        b=1GkUQPPsSv56mwM6ifQz8zBcH/6O+Ng/GiftqizjWbCzOvzQROUHIZRF+b5jkE+QCl
         mwE7SONCLTOXNbJOBkcrVMB8ed9yoPa+ELWaxQL2qO5MzKuiDfseKc5XSeYID9nmM/Rq
         imvUOW2azoqsYSNx2UFitSuWxZ7MofQB8HXz4iP86conzsa3yoT7izLdEcW0xocprcrB
         n1Jro/rtl1iiMhGoSnXGnQ4AirE1VCK3SM9nA4LWeAljtzNocfuR0RsF9mbW5OXSYmgK
         JXrAja8BqGV76/ZCvgEygVlfezvp+sfm68wAWdsXQ5hO2l39/zomG2jts8sIv2I9f8u9
         YzSg==
X-Gm-Message-State: AOAM532nljOMhFqJk7zxf74TsmvSNbBSgawQRf9mwCSlBAQvl7IeyHbb
        XK6ardzHwus+YSFCQDd44J9nhLYDeoWFCh+QhqvifA==
X-Google-Smtp-Source: ABdhPJxmlvL8Pu8Cfn88+EIMxRUFWE+OT0JcP7bgKkdMfQrSFJxtO49I0aN+VgiS10qsVBM3yfQA4xXTMyGQHttomYc=
X-Received: by 2002:ac2:4e98:: with SMTP id o24mr9884811lfr.295.1631556017864;
 Mon, 13 Sep 2021 11:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
 <3591AC6D-45D2-476A-80B1-46BFA1742602@oracle.com> <CAPNVh5fMUQCa37iprcAykgkHzY5Rj8DSiwtZBU6FbnzjOv8ciw@mail.gmail.com>
 <CAG48ez1sPjPYePmXTgtFbaj6_0yY0Z_bGw+apwO_zTV-qwftSA@mail.gmail.com>
 <CAPNVh5fP-QnziX7NpYqKv+0Ha8-prhvTHiCbUB0jx+_P36QUGg@mail.gmail.com> <6A88B271-EC5E-46B7-8D60-A7543635FDC5@oracle.com>
In-Reply-To: <6A88B271-EC5E-46B7-8D60-A7543635FDC5@oracle.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 13 Sep 2021 11:00:06 -0700
Message-ID: <CAPNVh5fQXB7tLi=tKyabmScZge53PwzQ3kqP2ASE+3DD+eTdGg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 13, 2021 at 10:36 AM Prakash Sangappa
<prakash.sangappa@oracle.com> wrote:

[...]

> > This sounds, again, as if the kernel should be aware of the kind of
> > items being allocated; having a more generic mechanism of allocating
> > pinned memory for the userspace to use at its discretion would be more
> > generally useful, I think. But how then the kernel/system should be
> > protected from a buggy or malicious process trying to grab too much?
> >
> > One option would be to have a generic in-kernel mechanism for this,
> > but expose it to the userspace via domain-specific syscalls that do
> > the accounting you hint at. This sounds a bit like an over-engineered
> > solution, though=E2=80=A6
>
>
> What will this pinned memory be used for in your use case,
> can you explain?

For userspace scheduling, to share thread/task state information
between the kernel and the userspace. This memory will be allocated
per task/thread; both the kernel and the userspace will write to the
shared memory, and these reads/writes will happen not only in the
memory regions belonging to the "current" task/thread, but also to
remote tasks/threads.

Somewhat detailed doc/rst is here:
https://lore.kernel.org/lkml/20210908184905.163787-5-posk@google.com/
