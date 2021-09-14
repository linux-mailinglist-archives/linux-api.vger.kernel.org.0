Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9608E40B54B
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 18:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhINQw7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 12:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhINQw7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 12:52:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F98AC061762
        for <linux-api@vger.kernel.org>; Tue, 14 Sep 2021 09:51:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k13so30218853lfv.2
        for <linux-api@vger.kernel.org>; Tue, 14 Sep 2021 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjSQE15uKcrKRnQuwXqswKvc6fyo2MaxbsLWDKYQ4RY=;
        b=DO2pmRkTjsKJiTLCol77A0gNdGwgoMm2ep17W0C9mucS7ff/YCFdWbSHs2ErU6fhPu
         YUzTMjtCt8PLZc31uy2O+m8HW0pswP6pDCYl1qQiX9gB0CrYRIo9fUGPJbMM1HH3oalL
         HrPPpKM1rd1RoAq3HwZSYyx1VeRlEHHMYTGmLqu3hR00cj54+41Zv283qlza8SvPKvAZ
         tanO7zyNiVbf6CE/ZEjUZBkJjLVMDxd2b13weLL0PMmqUaggV+EuLDXmU/dD1sz0bLCz
         uSjKQVgCiuuPHwY7GioyHiEl0/b3gCsHQ4b6BfK75gOdCzG7324Z83iVL+FENUbnD4e/
         a5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjSQE15uKcrKRnQuwXqswKvc6fyo2MaxbsLWDKYQ4RY=;
        b=E4FkIZnvrt63+iXrOCLZZFb990Emg0975AaPV/VYCjA3K8YopxF3eYK2zcmkrbgdue
         ZTzyqv9h2aly9PACq4YVyN601kXuMqjQVNuLN0nN/mxiOkp44sKkWguH1w4wSAWv4u33
         M5jd+AiygaEDxMb9PjRd3/UqHYsibWvLegfke8mdzXrEw5zrmRaSMaV9UpH/z65U1Ps+
         GE4Mpy39Y9yTXghJ8vGfrJovs8/h2C2Op6ukydUo6r9W3LozcBwwZr0if8Lj/+MR/YlL
         eRERZcpZU982faGV/uvzFFsnb8um3/64LpWJSxbWoS/Evugz9jCIR6p4W6yssjQssbBF
         p+wQ==
X-Gm-Message-State: AOAM533ZGXaz2JYo0BLGUh74gJ8NW45XRzXeqRxL09VDxePaoOi2FIYV
        vjV5GD8hPjJnwAUC7bskGpekg4j5VX/4gqGVyduEqA==
X-Google-Smtp-Source: ABdhPJw8kEH9jiZmIM3Ry3MTSBK9jdpUAOYp3qY4qOZ2T79bacMn9Mr8HKuTARFGh+rP4G9Wpd+ptyNvmJGYAEKk6BQ=
X-Received: by 2002:ac2:4e98:: with SMTP id o24mr13877402lfr.295.1631638299813;
 Tue, 14 Sep 2021 09:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-4-posk@google.com>
 <CAG48ez3Kd0sfKBi9CUSYDSd+ydkQ6H=zm2-iSB3jXHCyFvuWHw@mail.gmail.com>
In-Reply-To: <CAG48ez3Kd0sfKBi9CUSYDSd+ydkQ6H=zm2-iSB3jXHCyFvuWHw@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 14 Sep 2021 09:51:28 -0700
Message-ID: <CAPNVh5f6iaiYP8E2jKioirjJdwJDoJT-KHQLKjtgbr68H8-HxQ@mail.gmail.com>
Subject: Re: [PATCH 3/4 v0.5] sched/umcg: RFC: implement UMCG syscalls
To:     Jann Horn <jannh@google.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 8, 2021 at 6:40 PM Jann Horn <jannh@google.com> wrote:

[...]

> I think umcg_idle_loop() should never be called from scheduler
> callbacks (meaning umcg_wq_worker_running()), only from UMCG syscalls.

I'm moving umcg_wq_worker_running() out of
core.c/sched_update_worker() and into
/kernel/entry/common.c/exit_to_user_mode_loop()
(and will rename the function appropriately).
It seems rescheduling/sleeping there is fine.

I'm not yet sure if this is all that is needed to deal with
UMCG_TF_PREEMPTED flag; but I don't expect to see
any locks held when the task truly returns to the userspace.

Maybe I'll need to set TIF_NOTIFY_RESUME in sched_update_worker()...

[...]
