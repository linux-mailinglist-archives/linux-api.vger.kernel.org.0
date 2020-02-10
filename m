Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28091584C9
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 22:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgBJV3K (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 16:29:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33972 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJV3K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 16:29:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so4348334pfc.1;
        Mon, 10 Feb 2020 13:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QvVz9922RfF2M1+1YzT1xJSqO9QWTEbfw1OgBUiAzxg=;
        b=f3iXybZCwiAqO2xW8Tlb/FVBLhA2rSaY3BL76+rAIN7wdcnN70ILBegXv6zg7wVlq8
         KRqsWAiLrExj+v58hd8V8oW92Q+9ADGIUBDGAJVjb2q3j+pRHat33sfxB6rYExr3M/sR
         ze0T9hXxw9sOqBztAP2sv/DOEWuu61CDUdPFczSlD8TopoH20D6pEPTK7OX05IcOGpNg
         hPEP4E6u0xbBUNjKA1hTzuXWdknRKSiNTcc+JWze1DmRbkCpDdLnkbXTuWItGBsGMWRW
         dd2I7lA55DW8qQKlsZai/QfrMYhliQljcd2x2XGBHRfStEaG3iNONUBrwHSX4vWrA7W2
         x5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QvVz9922RfF2M1+1YzT1xJSqO9QWTEbfw1OgBUiAzxg=;
        b=dd28X+ypNSQ/OS6NoSKnZVD5c23vvh3fm5Y5kL92wT+EVI3BGjHrBZ91lV0ZAw38qk
         oFZZNXZTk1l2TssgGK2HYBzBiJ2J/fN7mYhGx5Kx4JmVtRKf/tctHS29EPoixOdXBGcb
         kEmUVR29nn7+je3I8EB5djLN0gAu7z46n13fjYGCoQ63zYNFAMAkCIGypuxiGF1ckPuv
         BFr/yrjXtWYeb4oWFoxlteqO0XPuLa6vhKjcLErA1kYg0mwRNiaRLsHNDYT8qFQSLAxH
         fzUo4jjmgYRsSw8NHxsFvnh1oZyYVQJ0nkNIDGA6iWF+AbecamPrSmsvU0aYD4EwKeBW
         z5Mw==
X-Gm-Message-State: APjAAAWD09X6ELusz5B3B6BLAgzcmOZCpuwKqu1JREBhihGsdmwmvNje
        25m7puWOO0JHmJrQMXa5Odg=
X-Google-Smtp-Source: APXvYqxvk99N91MDZTtsbJVoIIwFDq9wyGpNlqr7sX1WQCjiL8xuRUBqCIaB3ZV7nYedOYds0c9s5w==
X-Received: by 2002:a62:e91a:: with SMTP id j26mr3057541pfh.189.1581370149447;
        Mon, 10 Feb 2020 13:29:09 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id w8sm1437320pfj.20.2020.02.10.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 13:29:08 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:29:06 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v3 0/5] introduce memory hinting API for external process
Message-ID: <20200210212906.GB48790@google.com>
References: <20200128001641.5086-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128001641.5086-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Folks,


Can I get review further since I resolved most of concerns(especially,
description stuff) I got from previous iteration?

On Mon, Jan 27, 2020 at 04:16:36PM -0800, Minchan Kim wrote:
> Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> application could give hints to kernel what memory range are preferred to be
> reclaimed. However, in some platform(e.g., Android), the information
> required to make the hinting decision is not known to the app.
> Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> and that daemon must be able to initiate reclaim on its own without any app
> involvement.
> 
> To solve the concern, this patch introduces new syscall - process_madvise(2).
> Bascially, it's same with madvise(2) syscall but it has some differences.
> 
> 1. It needs pidfd of target process to provide the hint
> 2. It supports only MADV_{COLD|PAGEOUT|MERGEABLE|UNMEREABLE} at this moment.
>    Other hints in madvise will be opened when there are explicit requests from
>    community to prevent unexpected bugs we couldn't support.
> 3. Only privileged processes can do something for other process's address
>    space.
> 
> For more detail of the new API, please see "mm: introduce external memory hinting API"
> description in this patchset.
> 
> Minchan Kim (3):
>   mm: factor out madvise's core functionality
>   mm: introduce external memory hinting API
>   mm: support both pid and pidfd for process_madvise
> 
> Oleksandr Natalenko (2):
>   mm/madvise: employ mmget_still_valid for write lock
>   mm/madvise: allow KSM hints for remote API
> 
> * from v2 - https://lore.kernel.org/linux-mm/20200116235953.163318-1-minchan@kernel.org/
>   * check signal callee and caller to bail out - Kirill Tkhai
>   * put more clarification for justification of new API
> 
> * from v1 - https://lore.kernel.org/linux-mm/20200110213433.94739-1-minchan@kernel.org/
>   * fix syscall number - SeongJae
>   * use get_pid_task - Kirill Tkhai
>   * extend API to support pid as well as pidfd - Kirill Tkhai
> 
>  arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
>  arch/arm/tools/syscall.tbl                  |   1 +
>  arch/arm64/include/asm/unistd.h             |   2 +-
>  arch/arm64/include/asm/unistd32.h           |   2 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
>  include/linux/pid.h                         |   1 +
>  include/linux/syscalls.h                    |   3 +
>  include/uapi/asm-generic/unistd.h           |   5 +-
>  kernel/exit.c                               |  17 --
>  kernel/pid.c                                |  17 ++
>  kernel/sys_ni.c                             |   1 +
>  mm/madvise.c                                | 277 ++++++++++++++------
>  24 files changed, 238 insertions(+), 102 deletions(-)
> 
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
