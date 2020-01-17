Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5303B140FCE
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 18:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAQRZq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 12:25:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53040 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQRZq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 12:25:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so3441741pjh.2;
        Fri, 17 Jan 2020 09:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6GjsjLdF3u6QLI5q0dD+3l/bBEMHaJ5dAb8y6Mck+U=;
        b=JqwkgU9IxwECTSV0V3T1eXt0A2xbh+rnP7Fbo22LN6kPWiEFpaTxDwYq5XRSJlWIvf
         VQQUSrCz+yoEbltmBdC2DdDWfg72LGb+Hx4RMGoRwbSKp1hGTpdoteJI4DeV5EIRuNxf
         /WgI018GPWSngOvsGIvUa589LsuFmf3c8V5fpKBybBwo8JTy7IMoziZWDVp8jMf7DIE1
         kD8yQ0v/kqb2jg+KVXtjKJ1MQr2CZcitsGskuoyRkZyx2AL8JaW3H2EywqvRZ94mtNye
         /Y6JV6JvO4xlCyvPjzKrFcNonwOSGuV9i6O/U9z9J5n0EwLaS0NiHQvvxEhC+6sAaGcP
         KrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6GjsjLdF3u6QLI5q0dD+3l/bBEMHaJ5dAb8y6Mck+U=;
        b=ED8YAm4qsA5VpfNoReznQnnoGozCTfD/z1BxwaHtGXYLNf8Wmgcap1eIGIpDlgxyqd
         P3wRQoVqqjeHFklE0gDzhARpKBBR1ynwPHx0LsWzUM16a9gNEJJ6GhZQzVpadCn6nrGg
         HuICjj6E1kzg6/Ol2DtDYZMetISEs3ZReczekLRivcxW05bStHPyp/N/76vzDF0e5zrY
         PEvGtWaP+Jznos4IVlzvfIk/qZVAmS5OhDm8t87IMXLzUR5Ymk++qdhuCwva0OF/aKNP
         yw50fj/RGPqFlj4Ct3pqHI06sRQ61OIrv9z2yxoA9iRqEU9WIH34u8XcF7I7EleJg52M
         LbFA==
X-Gm-Message-State: APjAAAUuStU48oinZfVEagQufn3X5ctTpu/YPodqSOjkS3R25sNXbVGy
        6JLGOZ2btNkIrsDxJuAKVd0=
X-Google-Smtp-Source: APXvYqx8f0eQEgijs91XAtTYgArwFV8jFPXy58RBBXwOQamACGkVUyyFk2lDHsuVjxOAvcHTkqMjrQ==
X-Received: by 2002:a17:902:bd41:: with SMTP id b1mr135916plx.82.1579281945200;
        Fri, 17 Jan 2020 09:25:45 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k10sm8162500pjq.14.2020.01.17.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 09:25:44 -0800 (PST)
Date:   Fri, 17 Jan 2020 09:25:42 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200117172542.GA140922@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117115225.GV19428@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 17, 2020 at 12:52:25PM +0100, Michal Hocko wrote:
> On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> > There is usecase that System Management Software(SMS) want to give
> > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > in the case of Android, it is the ActivityManagerService.
> > 
> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > required to make the reclaim decision is not known to the app. Instead,
> > it is known to the centralized userspace daemon(ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without
> > any app involvement.
> > 
> > To solve the issue, this patch introduces new syscall process_madvise(2).
> > It uses pidfd of an external processs to give the hint.
> > 
> >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > 			unsigned long flag);
> > 
> > Since it could affect other process's address range, only privileged
> > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > gives it the right to ptrace the process could use it successfully.
> > The flag argument is reserved for future use if we need to extend the
> > API.
> > 
> > I think supporting all hints madvise has/will supported/support to
> > process_madvise is rather risky. Because we are not sure all hints make
> > sense from external process and implementation for the hint may rely on
> > the caller being in the current context so it could be error-prone.
> > Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> > 
> > If someone want to add other hints, we could hear hear the usecase and
> > review it for each hint. It's more safe for maintainace rather than
> > introducing a buggy syscall but hard to fix it later.
> 
> I have brought this up when we discussed this in the past but there is
> no reflection on that here so let me bring that up again. 
> 
> I believe that the interface has an inherent problem that it is racy.
> The external entity needs to know the address space layout of the target
> process to do anyhing useful on it. The address space is however under
> the full control of the target process though and the external entity
> has no means to find out that the layout has changed. So
> time-to-check-time-to-act is an inherent problem.
> 
> This is a serious design flaw and it should be explained why it doesn't
> matter or how to use the interface properly to prevent that problem.

Sorry for the missing that part.

It's not a particular problem of this API because other APIs already have
done with that(e.g., move_pages, process_vm_writev).

Point is userspace has several ways for the control of target process
like SIGSTOP, cgroup freezer or even no need to control since platform
is already aware of that the process will never run until he grant it
or it's resilient even though the race happens.

In future, if we want to support more fine-grained consistency model
like memory layout, we could provide some API to get cookie(e.g.,
seq count which is updated whenever vma of the process changes).  And then
we could feed the cookie to process_madvise's last argument so that
it can fail if founds it's not matched.
For that API, Daniel already posted RFC - process_getinfo[1].
https://lore.kernel.org/lkml/20190520035254.57579-1-minchan@kernel.org/T/#m7694416fd179b2066a2c62b5b139b14e3894e224

