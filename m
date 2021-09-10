Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA3E4071C1
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 21:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhIJTNq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhIJTNp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 15:13:45 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E41C061756
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 12:12:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a4so6050550lfg.8
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=srYMDe++QnliOuROCsgFjptM040iRN2INrvA4QIwYuM=;
        b=IpbKSMqWqJJtigxNgiA4UVTS8XpTsHs4gor/CaqvuHvr9Cg4VHviz9gtV3CUEYxF7K
         QxrZ/sa8LU9zyJSvHDUdk4ZD7icQB899a9GSkjrRmwVoV/3u7NXhNH0+lszZyqo2vdfO
         Fzco6tGp6+FJQgxdIVE/c7xanSzRNd0Qvq2HQHccRiJbF7PgqKYBw+JUMsPFEBmk+yXB
         juc4TyfMmWiTTA4P65fiiVEZ1YTDHQzHyzLOYZS5dLkPV+PdQEX7auBBNaiEqf7azlA0
         ew+DeuPLe8l+6UtPJ1gC3ahtI4iQdAngZWEW5fJ3s4cVpls4zy6pRn4/YnFYuKjwzwF6
         VIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=srYMDe++QnliOuROCsgFjptM040iRN2INrvA4QIwYuM=;
        b=BdijqwMKRQzRDtHvZs+AoGS7gYQdDVAlED4InFO10AH1O2qPquMBTQFQrU4w/nhuFw
         W4KN2krk5/bXU4r8QzLD3G0eafoK7Z1kpGgsku/FMlSLC3mBpVy6E4Yquk6FOsRc+3Rj
         uNoPi+fVyD4kyTnJ+96vC5hQdyXqCn4EkVk0rb7GUJWdSuHvRwmFbiARJyccQOUZy5RZ
         jbGlpi5txbPyGC1Zy6CyGGmrPF+LajJd+ykn3VmsIuYXp+CEae6Jla6kzNI85LwW0tFZ
         S6wowNQOU/HSBeTpCU6+r9h8BpdvQMLAHkg1Gu/lqI62E3wx6cUZoUncWMRc555IZ/gY
         crdw==
X-Gm-Message-State: AOAM532npnHy7IZpZLOdzoKrIJhOCrDh74Ot0KhP5fcqaWKkGJEGX1Ud
        9KYG520cn0tzLHKFlySwzuaSjGy6xzQfBLG3xZk0XQ==
X-Google-Smtp-Source: ABdhPJxomRF3jPI/9nKBaS/IozcrefKP3f+T2rmbFNzaQwdwbfB1J4Oc0cUByzTbTiWsNSogRZHcvEny+YujoYXQevk=
X-Received: by 2002:a05:6512:ac4:: with SMTP id n4mr4929225lfu.237.1631301151579;
 Fri, 10 Sep 2021 12:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
 <3591AC6D-45D2-476A-80B1-46BFA1742602@oracle.com> <CAPNVh5fMUQCa37iprcAykgkHzY5Rj8DSiwtZBU6FbnzjOv8ciw@mail.gmail.com>
In-Reply-To: <CAPNVh5fMUQCa37iprcAykgkHzY5Rj8DSiwtZBU6FbnzjOv8ciw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 10 Sep 2021 21:12:05 +0200
Message-ID: <CAG48ez1sPjPYePmXTgtFbaj6_0yY0Z_bGw+apwO_zTV-qwftSA@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
To:     Peter Oskolkov <posk@google.com>
Cc:     Prakash Sangappa <prakash.sangappa@oracle.com>,
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

On Fri, Sep 10, 2021 at 6:28 PM Peter Oskolkov <posk@google.com> wrote:
> On Fri, Sep 10, 2021 at 9:13 AM Prakash Sangappa
> <prakash.sangappa@oracle.com> wrote:
> > > Do you think your sys_task_getshared can be tweaked to return an
> > > arbitrarily-sized block of memory (subject to overall constraints)
> > > rather than a fixed number of "options"?
> >
> > I suppose it could. How big of a size? We don=E2=80=99t want to hold on=
 to
> > arbitrarily large  amount of pinned memory. The preference would
> > be for the kernel to decide what is going to be shared based on
> > what functionality/data sharing is supported. In that sense the size
> > is pre defined not something the userspace/application can ask.
>
> There could be a sysctl or some other mechanism that limits the amount
> of memory pinned per mm (or per task). Having "options" hardcoded for
> such a generally useful feature seems limiting...

That seems like it'll just create trouble a few years down the line
when the arbitrarily-chosen limit that nobody is monitoring blows up
in someone's production environment.

If this area is used for specific per-thread items, then the kernel
should be able to enforce that you only allocate as much space as is
needed for all threads of the process (based on the maximum number
that have ever been running in parallel in the process), right? Which
would probably work best if the kernel managed those allocations.
