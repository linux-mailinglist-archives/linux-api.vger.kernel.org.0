Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D07142959
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2020 12:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgATL11 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jan 2020 06:27:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46503 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATL11 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jan 2020 06:27:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so29095572wrl.13;
        Mon, 20 Jan 2020 03:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n5bQ+OogGIDLA3P5SuqSCggZosT/rPX+E93SVPGqmAE=;
        b=N1m6OKatMouGwU4TvnPHYoQY0phCbmeBJ1SeTt1r5VKeNJQya/GiOvSz0cAhNkBDpG
         OUkLc4HZvZ9AAJ8uxHwJ+nNMxckhdL9INdpS0tcub3M5PR86bhrgfxZMC+hTIIBmNZCI
         ey8clz5PkSaTENpUePsvrZuO470vH2LT7aRFjROs6xivSJN8kN/1RyrFQiLpa9Ww5AFV
         Agu6w3p/7Sx00121ex2C8RjShF9Lvc0jNU0iERMY9fzSM8a3Ia6FA+NKeKps9ZDYNFmP
         /eOmANt5G40dkY+hBiDb5m0QgXv8n4dU+Ot4b/8y/Kw7zk9XVu37dj1M3VBVRGV019I3
         9VgA==
X-Gm-Message-State: APjAAAUs8FFTznUhb1sknfLjwn4jbJSWE649gTDyXK0pDxTFv+XLfqaL
        Iu2HkoW/pH5PLxUItuobFbg=
X-Google-Smtp-Source: APXvYqyX0RlQo2lpD3Kwf0u/gBQ/R0SPxmcmLOKoPxSoegA7XlW0ftXNaWv3H2dt8Jzl1CZ/z1FCnQ==
X-Received: by 2002:adf:ee45:: with SMTP id w5mr4615789wro.352.1579519644002;
        Mon, 20 Jan 2020 03:27:24 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z8sm46388142wrq.22.2020.01.20.03.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:27:23 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:27:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200120112722.GY18451@dhcp22.suse.cz>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <f57fb198-4070-d3b4-b6bd-43b29ff40a2c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f57fb198-4070-d3b4-b6bd-43b29ff40a2c@virtuozzo.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 20-01-20 13:24:35, Kirill Tkhai wrote:
> On 17.01.2020 14:52, Michal Hocko wrote:
> > On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> >> There is usecase that System Management Software(SMS) want to give
> >> a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> >> in the case of Android, it is the ActivityManagerService.
> >>
> >> It's similar in spirit to madvise(MADV_WONTNEED), but the information
> >> required to make the reclaim decision is not known to the app. Instead,
> >> it is known to the centralized userspace daemon(ActivityManagerService),
> >> and that daemon must be able to initiate reclaim on its own without
> >> any app involvement.
> >>
> >> To solve the issue, this patch introduces new syscall process_madvise(2).
> >> It uses pidfd of an external processs to give the hint.
> >>
> >>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> >> 			unsigned long flag);
> >>
> >> Since it could affect other process's address range, only privileged
> >> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> >> gives it the right to ptrace the process could use it successfully.
> >> The flag argument is reserved for future use if we need to extend the
> >> API.
> >>
> >> I think supporting all hints madvise has/will supported/support to
> >> process_madvise is rather risky. Because we are not sure all hints make
> >> sense from external process and implementation for the hint may rely on
> >> the caller being in the current context so it could be error-prone.
> >> Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> >>
> >> If someone want to add other hints, we could hear hear the usecase and
> >> review it for each hint. It's more safe for maintainace rather than
> >> introducing a buggy syscall but hard to fix it later.
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
> Really, any address space manipulation, where more than one process is
> involved, is racy.

They are, indeed. But that is not the point I wanted to make.

> Even two threads on common memory need a synchronization
> to manage mappings in a sane way. Managing memory from two processes
> is the same in principle, and the only difference is that another level
> of synchronization is required.

Well, not really. The operation might simply attempt to perform an
operation on a specific memory area and get a failure if it doesn't
reference the same object anymore. What I think we need is some form of
a handle to operate on. In the past we have discussed several
directions. I was proposing /proc/self/map_anon/ (analogous to
map_files) where you could inspect anonymous memory and get a file
handle for it. madvise would then operate on the fd and then there
shouldn't be a real problem to revalidate that the object is still
valid. But there was no general enthusiasm about that approach. There
are likely some land mines on the way.

There was another approach mentioned by Minchan in other email in this
thread.

What I want to say is that I believe a remove madvise can have a
sensible semantic even without a strong synchronization between the
monitor and the target task. We just have to make sure that the monitor
never operates on a different object then it believes it acts on.

On the other hand, there will never be any way to make this interface
reasonable for destructive operations though because the content of the
memory needs a strong synchronization IMHO.
-- 
Michal Hocko
SUSE Labs
