Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381961424C1
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2020 09:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgATIDd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jan 2020 03:03:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgATIDd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jan 2020 03:03:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so28429953wre.10;
        Mon, 20 Jan 2020 00:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDmezBsJvvXTKgPzl7Xvo58o6+oumRfpkAIXFK+J8DU=;
        b=SPQwoc6nrZpw4pSUqZfB7ptf7WFMx6MpIaUm1UgqLErbCylB9sJ2UuSBQkDvo01dYH
         uAU2q7FOZhhWogeMKKp3feHlGGuGegyYmIZPBWWphkFtfXwPgMqw6DaEsl6Gyi0etPg/
         /jleXbpvMgY3fHQGTw9+06dcNUJPmXF5C5yfyQ3+9gDWOOeQrOd1B5BFWn7YdJBLwgPN
         DTsW8uDUkwNPNgV93pS+kNnBLpYbnSXt2svcqiZfJ02T0he6BWRH+f37Tb6suZ3iYcL8
         bdptRijVkoPstlVLW8QKksLGVD0Buh5zw9GoXnbUzrq30WhkySpQ4WfmP2E2FdPafldm
         qv3w==
X-Gm-Message-State: APjAAAWu2GSy3AHmNPuzbEYt00wRDaVCtm4ZLAKZDhoX47Mrxei1W+tR
        sbCMEwnfEzhmM6sp2sbruD0=
X-Google-Smtp-Source: APXvYqw9SSSto7+XdEORAAN2GaIZ7SGXrUkE5SOTrMmMO40hITkY79xhN1nH/PfkvbFscm8Z/vIAcQ==
X-Received: by 2002:adf:e290:: with SMTP id v16mr17398000wri.16.1579507410211;
        Mon, 20 Jan 2020 00:03:30 -0800 (PST)
Received: from localhost (ip-37-188-138-155.eurotel.cz. [37.188.138.155])
        by smtp.gmail.com with ESMTPSA id t5sm45407177wrr.35.2020.01.20.00.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:03:29 -0800 (PST)
Date:   Mon, 20 Jan 2020 09:03:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20200120080326.GI18451@dhcp22.suse.cz>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117172542.GA140922@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117172542.GA140922@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 17-01-20 09:25:42, Minchan Kim wrote:
> On Fri, Jan 17, 2020 at 12:52:25PM +0100, Michal Hocko wrote:
> > On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> > > There is usecase that System Management Software(SMS) want to give
> > > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > > in the case of Android, it is the ActivityManagerService.
> > > 
> > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > required to make the reclaim decision is not known to the app. Instead,
> > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > and that daemon must be able to initiate reclaim on its own without
> > > any app involvement.
> > > 
> > > To solve the issue, this patch introduces new syscall process_madvise(2).
> > > It uses pidfd of an external processs to give the hint.
> > > 
> > >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > > 			unsigned long flag);
> > > 
> > > Since it could affect other process's address range, only privileged
> > > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > > gives it the right to ptrace the process could use it successfully.
> > > The flag argument is reserved for future use if we need to extend the
> > > API.
> > > 
> > > I think supporting all hints madvise has/will supported/support to
> > > process_madvise is rather risky. Because we are not sure all hints make
> > > sense from external process and implementation for the hint may rely on
> > > the caller being in the current context so it could be error-prone.
> > > Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> > > 
> > > If someone want to add other hints, we could hear hear the usecase and
> > > review it for each hint. It's more safe for maintainace rather than
> > > introducing a buggy syscall but hard to fix it later.
> > 
> > I have brought this up when we discussed this in the past but there is
> > no reflection on that here so let me bring that up again. 
> > 
> > I believe that the interface has an inherent problem that it is racy.
> > The external entity needs to know the address space layout of the target
> > process to do anyhing useful on it. The address space is however under
> > the full control of the target process though and the external entity
> > has no means to find out that the layout has changed. So
> > time-to-check-time-to-act is an inherent problem.
> > 
> > This is a serious design flaw and it should be explained why it doesn't
> > matter or how to use the interface properly to prevent that problem.
> 
> Sorry for the missing that part.
> 
> It's not a particular problem of this API because other APIs already have
> done with that(e.g., move_pages, process_vm_writev).

I am sorry but this is not really an argument.

> Point is userspace has several ways for the control of target process
> like SIGSTOP, cgroup freezer or even no need to control since platform
> is already aware of that the process will never run until he grant it
> or it's resilient even though the race happens.

If you have that level of control then you can simply inject the code
via ptrace and you do not need a new syscall in the first place.

> In future, if we want to support more fine-grained consistency model
> like memory layout, we could provide some API to get cookie(e.g.,
> seq count which is updated whenever vma of the process changes).  And then
> we could feed the cookie to process_madvise's last argument so that
> it can fail if founds it's not matched.
> For that API, Daniel already posted RFC - process_getinfo[1].
> https://lore.kernel.org/lkml/20190520035254.57579-1-minchan@kernel.org/T/#m7694416fd179b2066a2c62b5b139b14e3894e224

So why do not we start with a clean API since the beginning? I do agree
that a remote madvise is an interesting feature and it opens gates to
all sorts of userspace memory management which is not possible this
days. But the syscall has to have a reasonable semantic to allow that.
We cannot simply start with a half proken symantic first based on an
Android usecase and then hit the wall as soon as others with a different
user space model want to use it as well.
-- 
Michal Hocko
SUSE Labs
