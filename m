Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6176141EFE
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2020 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgASQOi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Jan 2020 11:14:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46267 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASQOi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 19 Jan 2020 11:14:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id n9so14502256pff.13
        for <linux-api@vger.kernel.org>; Sun, 19 Jan 2020 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eTPL0qIft+PAJRKYhuZgerS2zPZNoYqzBPJ/hUNnofk=;
        b=fkp3ivs9BWu7f2qbRlFnK1Y2IKQewczE/s6Nfs50yHayGYxq851zFjxTBFbFGJj2FR
         HQf8ve2IM3luGjDGZ7DGUsaP+sfYmRPeA8hiMaYvmcqQgJlCoSKhlZg1ZJEweK1DAQJ8
         GAhIyx1FSlk9i4tBIFVrzqgOEJ1JSD+nmRsY2XoValMX5zOQQNyeM7yGEZM/kuLFrNgN
         VGpnUbaZItCAwZ/jGuXfRx/upOAn30vaA3v2PQWnxCVCKMQjWMzFnW92uQajW/Gv/0cV
         NyrmZp63Ui5u6X5xAGiSw1qkUbhIABQQd5nqWOjgpNs6xMHwm7ntBfQ4fxfz0SOEjT1i
         alhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eTPL0qIft+PAJRKYhuZgerS2zPZNoYqzBPJ/hUNnofk=;
        b=ROWgOa4iATf/foA2p+H0N0TnI1xcOER6pCzwlPUtC82tts1NnxjSkPgsWRF8qRXLfg
         DudwPdQDL+Vj6h16dewjLmFv9k7WOjcfx2qs0LVjEBMOahDep7ZOGRf/Toh7Mt9b7JaF
         jB2nVhXq26L/sn3UTpFT/bFeirb0tUdeEG7ys4xyTM7SvN03oHVqCPo6uuIVbeJ6iCj1
         rHSdnwxFj7J2LJhq9AI8J51GMqdYAJfKLC+TKAUzofUI2Lfs+Sf+uftWU0oh5LqghaYp
         4vSwrbTWbvJqDX+r+LGHexWFHgs/2MapLf3OSMRFxqwKsY/AVAl0YN94VAqZIULNXVRH
         +WSg==
X-Gm-Message-State: APjAAAXvogHR0i3WTj2WW3QDauPLBNfjF64uZb6oM7/h4I8IcEsGQtQx
        LBaCqu6vPKOL0Zye0VHZlguZ5w==
X-Google-Smtp-Source: APXvYqxiqCVKAw7n8mlcVT4SM73UEmqS8HKyvw+g+QV8PPCiNbHAECRa+6baAKip0NfyEPz+wJGTrw==
X-Received: by 2002:a63:4d4c:: with SMTP id n12mr57301291pgl.212.1579450476748;
        Sun, 19 Jan 2020 08:14:36 -0800 (PST)
Received: from sspatil-glaptop2.roam.corp.google.com ([66.167.121.235])
        by smtp.gmail.com with ESMTPSA id l2sm14371111pjt.31.2020.01.19.08.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 08:14:35 -0800 (PST)
Date:   Sun, 19 Jan 2020 08:14:31 -0800
From:   sspatil@google.com
To:     kirill@shutemov.name, minchan@kernel.org, mhocko@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        oleksandr@redhat.com, surenb@google.com, timmurray@google.com,
        dancol@google.com, sonnyrao@google.com, bgeffon@google.com,
        hannes@cmpxchg.org, shakeelb@google.com, joaodias@google.com,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Cc:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200119161431.GA94410@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117212653.7uftw3lk35oykkmb@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jan 18, 2020 at 12:26:53AM +0300, Kirill A. Shutemov wrote:
> On Fri, Jan 17, 2020 at 09:32:39AM -0800, Minchan Kim wrote:
> > On Fri, Jan 17, 2020 at 06:58:37PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Jan 17, 2020 at 12:52:25PM +0100, Michal Hocko wrote:
> > > > On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> > > > > There is usecase that System Management Software(SMS) want to give
> > > > > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > > > > in the case of Android, it is the ActivityManagerService.
> > > > > 
> > > > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > > > required to make the reclaim decision is not known to the app. Instead,
> > > > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > > > and that daemon must be able to initiate reclaim on its own without
> > > > > any app involvement.
> > > > > 
> > > > > To solve the issue, this patch introduces new syscall process_madvise(2).
> > > > > It uses pidfd of an external processs to give the hint.
> > > > > 
> > > > >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > > > > 			unsigned long flag);
> > > > > 
> > > > > Since it could affect other process's address range, only privileged
> > > > > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > > > > gives it the right to ptrace the process could use it successfully.
> > > > > The flag argument is reserved for future use if we need to extend the
> > > > > API.
> > > > > 
> > > > > I think supporting all hints madvise has/will supported/support to
> > > > > process_madvise is rather risky. Because we are not sure all hints make
> > > > > sense from external process and implementation for the hint may rely on
> > > > > the caller being in the current context so it could be error-prone.
> > > > > Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> > > > > 
> > > > > If someone want to add other hints, we could hear hear the usecase and
> > > > > review it for each hint. It's more safe for maintainace rather than
> > > > > introducing a buggy syscall but hard to fix it later.
> > > > 
> > > > I have brought this up when we discussed this in the past but there is
> > > > no reflection on that here so let me bring that up again. 
> > > > 
> > > > I believe that the interface has an inherent problem that it is racy.
> > > > The external entity needs to know the address space layout of the target
> > > > process to do anyhing useful on it. The address space is however under
> > > > the full control of the target process though and the external entity
> > > > has no means to find out that the layout has changed. So
> > > > time-to-check-time-to-act is an inherent problem.
> > > > 
> > > > This is a serious design flaw and it should be explained why it doesn't
> > > > matter or how to use the interface properly to prevent that problem.
> > > 
> > > I agree, it looks flawed.
> > > 
> > > Also I don't see what System Management Software can generically do on
> > > sub-process level. I mean how can it decide which part of address space is
> > > less important than other.
> > > 
> > > I see how a manager can indicate that this process (or a group of
> > > processes) is less important than other, but on per-addres-range basis?
> > 
> > For example, memory ranges shared by several processes or critical for the
> > latency, we could avoid those ranges to be cold/pageout to prevent
> > unncecessary CPU burning/paging.
> 
> Hmm.. I still don't see why any external entity has a better (or any)
> knowledge about the matter. The process has to do this, no?

FWIW, I totally agree with the time-to-check-time-to-react problem. However,
I'd like to clarify the ActivityManager/SystemServer case (I'll call it
SystemServer from now on)

For Android, every application (including the special SystemServer) are forked
from Zygote. The reason ofcourse is to share as many libraries and classes between
the two as possible to benefit from the preloading during boot.

After applications start, (almost) all of the APIs  end up calling into this
SystemServer process over IPC (binder) and back to the application.

In a fully running system, the SystemServer monitors every single process
periodically to calculate their PSS / RSS and also decides which process is
"important" to the user for interactivity.

So, because of how these processes start _and_ the fact that the SystemServer
is looping to monitor each process, it does tend to *know* which address
range of the application is not used / useful.

Besides, we can never rely on applications to clean things up themselves.
We've had the "hey app1, the system is low on memory, please trim your
memory usage down" notifications for a long time[1]. They rely on
applications honoring the broadcasts and very few do.

So, if we want to avoid the inevitable killing of the application and
restarting it, some way to be able to tell the OS about unimportant memory in
these applications will be useful.


- ssp

1. https://developer.android.com/topic/performance/memory


> 
> > I also think people don't want to give an KSM hint to non-mergeable area.
> 
> And how the manager knows which data is mergable?
> 
> If you are intimate enough with the process' internal state feel free to
> inject syscall into the process with ptrace. Why bother with half-measures?
> 
> -- 
>  Kirill A. Shutemov
