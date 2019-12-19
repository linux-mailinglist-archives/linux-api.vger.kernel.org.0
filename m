Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F4112667B
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2019 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSQQH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Dec 2019 11:16:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41635 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfLSQQH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Dec 2019 11:16:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so5414400eds.8
        for <linux-api@vger.kernel.org>; Thu, 19 Dec 2019 08:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgC42fe1N8wsAY2Zpi//y6cU+ssloLAYZDPn1Fg0a/Q=;
        b=CRdleZru1BN0IO10qM3c/+ShZhD9u54Ow/x+ihrZrMg1kMI/Uhc5n0Kz0jBVzovz2A
         7wBAnnk2QTrZykncxgmLNoo9u1auLtLGveneGj6/nZ4QhSB4vBB1zMz+ft2e03lT8zXY
         vxB5O8DU6BJacQeiY76F3DU2JM0AgLJ/hqGtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgC42fe1N8wsAY2Zpi//y6cU+ssloLAYZDPn1Fg0a/Q=;
        b=EQe3+GSdNbXOIk2DSl3aWt3NgehLpNTy3Sa1qiR21PAcg1bsKMIk9WYuSZLdRTQ3H0
         IqPwsL/0Ers6Bq8BfOje5PX2RtJZc7MjAcb8IbZo5fqPQevawW7raTbbb+Dydpc/z2cv
         h9cbbR1jIcijNjMy7bHdlMi+j2j219BkdiA54zBoZ894lFH9G0CJMKmzlVMzDaHCxKUo
         a+CAhTTqRR2cBg/jjYThZWZPzzVX2lgpp5/mxVxJngKPriiM6DvT8v7cAwc4Wp4N7ISb
         /DG0feuC7h+L9dBAlErLwaT5/r+3BkRknvGBVy5aSHKq0/MQIu1+CFQ1RHisORLOeRaI
         UQyA==
X-Gm-Message-State: APjAAAXEdoNWp2oKNhBIQ4eUl60opVqkckX9SKyN6zKmjAoUO7Yu0A7Z
        0gwPXZhlGeD3tFoRur8d9HMjmIZbZkSV1b3X6dkGQg==
X-Google-Smtp-Source: APXvYqzO/uAhMSfNB8MjlZnPiJ5czTYp4nAlpcNumi04dxRBB+6KCzUzjEJgBeMvk27GNs+8F2b3SaBxP/hJE8qwgB4=
X-Received: by 2002:a17:906:5358:: with SMTP id j24mr10598276ejo.44.1576772164912;
 Thu, 19 Dec 2019 08:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20191218235459.GA17271@ircssh-2.c.rugged-nimbus-611.internal>
 <CAK8P3a2eT=bHkUamyp-P3Y2adNq1KBk7UknCYBY5_aR4zJmYaQ@mail.gmail.com> <20191219103525.yqb5f4pbd2dvztkb@wittgenstein>
In-Reply-To: <20191219103525.yqb5f4pbd2dvztkb@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 19 Dec 2019 08:15:29 -0800
Message-ID: <CAMp4zn_z-CCQYMpT=GjZeGVLobjHBCSbmfha1rtWdmptOQ8JtA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Jed Davis <jld@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 19, 2019 at 2:35 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> I guess this is the remaining question we should settle, i.e. what do we
> prefer.
> I still think that adding a new syscall for this seems a bit rich. On
> the other hand it seems that a lot more people agree that using a
> dedicated syscall instead of an ioctl is the correct way; especially
> when it touches core kernel functionality. I mean that was one of the
> takeaways from the pidfd API ioctl-vs-syscall discussion.
>
> A syscall is nicer especially for core-kernel code like this.
> So I guess the only way to find out is to try the syscall approach and
> either get yelled and switch to an ioctl() or have it accepted.
>
> What does everyone else think? Arnd, still in favor of a syscall I take
> it. Oleg, you had suggested a syscall too, right? Florian, any
> thoughts/worries on/about this from the glibc side?
>
> Christian

My feelings towards this are that syscalls might pose a problem if we
ever want to extend this API. Of course we can have a reserved
"flags" field, and populate it later, but what if we turn out to need
a proper struct? I already know we're going to want to add one
around cgroup metadata (net_cls), and likely we'll want to add
a "steal" flag as well. As Arnd mentioned earlier, this is trivial to
fix in a traditional ioctl environment, as ioctls are "cheap". How
do we feel about potentially adding a pidfd_getfd2? Or are we
confident that reserved flags will save us?
