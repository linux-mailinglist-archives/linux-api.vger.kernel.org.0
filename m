Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1757405C50
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 19:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbhIIRoN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Sep 2021 13:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237230AbhIIRoI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 9 Sep 2021 13:44:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E0460F4A
        for <linux-api@vger.kernel.org>; Thu,  9 Sep 2021 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631209378;
        bh=IDTb4rA4Iui5aRziLg9MwZ0JPlkvhlzJK5j6CG2YU+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pxs7yYPjI2FiogSgf75+K6JNUwG88sxc4d2EJyEAvBGzZnDI+PHGAw8avRptP4WEQ
         jFfZ1lcR2jvT4Tvo/idJXSCf1HfYKMT3ktsQQ0MysMm9b82cYmontz4So5K9Erw4Vv
         ypziB/SfDt1DhcM4Iq2mTMXsOh55kPipZp8g7tkKUePG8PfH4jrq7LCl3ACRGoNkT8
         S0qmWsKZkD4mT3Jjmsc2N06bySrJo96fJ0VijW8OZmlIf4D29ZBAd9dcFaRzF8hImP
         M4bKgjKvQ0DLwvUYDPtz9N1XjxWswq76yR69fvZo5oYb3PRblKAqCin472/8z+nFDl
         yVXI312YGUzYQ==
Received: by mail-ej1-f51.google.com with SMTP id kt8so5180263ejb.13
        for <linux-api@vger.kernel.org>; Thu, 09 Sep 2021 10:42:58 -0700 (PDT)
X-Gm-Message-State: AOAM5311Wn/yu4vqbBkdUB9BwMEZcXAhBJJR/RYuJQdRWwaHBDZujjLN
        WCmktlmKD9PBHbWHlgq9+f2lI6Q4vbp/ZcQS9r1BVw==
X-Google-Smtp-Source: ABdhPJyn7JVomP+013foZ3fe1Rj++6cVmuLQ0a6uE4cjyzNeSOquhtWZVmaI59hReMQtP+DBXtUTKzqoR1GxIR10EhY=
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr4773787ejr.435.1631209377027;
 Thu, 09 Sep 2021 10:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
In-Reply-To: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 9 Sep 2021 10:42:43 -0700
X-Gmail-Original-Message-ID: <CALCETrVHf90pWD6YnE3DCOo2bw1StKGPvZMgFz9a08eWPK2pFg@mail.gmail.com>
Message-ID: <CALCETrVHf90pWD6YnE3DCOo2bw1StKGPvZMgFz9a08eWPK2pFg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 8, 2021 at 5:02 PM Prakash Sangappa
<prakash.sangappa@oracle.com> wrote:
>
> Resending RFC. This patchset is not final. I am looking for feedback on
> this proposal to share thread specific data for us in latency sensitive
> codepath.
>
> (patchset based on v5.14-rc7)
>
> Cover letter previously sent:
> ----------------------------
>
> Some applications, like a Databases require reading thread specific stats
> frequently from the kernel in latency sensitive codepath. The overhead of
> reading stats from kernel using system call affects performance.
> One use case is reading thread's scheduler stats from /proc schedstat file
> (/proc/pid/schedstat) to collect time spent by a thread executing on the
> cpu(sum_exec_runtime), time blocked waiting on runq(run_delay). These
> scheduler stats, read several times per transaction in latency-sensitive
> codepath, are used to measure time taken by DB operations.
>
> This patch proposes to introduce a mechanism for kernel to share thread
> stats thru a per thread shared structure shared between userspace and
> kernel. The per thread shared structure is allocated on a page shared
> mapped between user space and kernel, which will provide a way for fast
> communication between user and kernel. Kernel publishes stats in this
> shared structure. Application thread can read from it in user space
> without requiring system calls.


Can these use cases be addressed by creating a perf event
(perf_event_open) and mmapping it?
