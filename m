Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC89144451
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2020 19:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAUScQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Jan 2020 13:32:16 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37225 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUScQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Jan 2020 13:32:16 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so1997125pjb.2;
        Tue, 21 Jan 2020 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvndSpP/NSgHluqgcBzNQ8DcumhrYSHKGx7ZpL0Xkkg=;
        b=feBsVhrFKavcTHSNyEl6RKC+Qz5Xajkr2H4ffG+vzQ6fEayv/3W+yePz1Vbv2WsB7z
         1AJ1GBB/Ya81kCybByEtAINJOR21f+gkBsnUo1Jfv7ZMUJEVZZcrNmd1oKoXM4iZu3lB
         Ho3mb+wD3PvaTy5ODQb/mMxEPC1hViwBVJpNmbAJ2/JXheUaC7kFzMxsV6kYtMGDDXhc
         29KZ+LmmUsSyC4lHmmML685aQadzq/V/wed/bOFJg0fvs26/cE9utfiVmwJ/Mh/jfE5/
         Jy5tMqx+TVsp4NNldlrtXi2VyGSoxkX4H9e4vgyDaVXnh5rWwapDEiWv93dHwnLcpHBU
         pT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvndSpP/NSgHluqgcBzNQ8DcumhrYSHKGx7ZpL0Xkkg=;
        b=AIMpdIGuYOkr/Zc1D5WLzEj5KdEkHJIBhGwoaZewce4C29xoKL/hd/7sJOm4Tlzkhb
         JmhHROJJBeVi8fhLSCQET7GOVFSqwFGXhV7UCqtYldGAktCtmJ7OUVKECHRBFqhTsCyt
         DR3KOZ08p72pt1hBi6hYrEoLqgonIga5VsI6A/U2bcHbg5ZKYXD82sEUlZPawiD+0mpo
         Q/78NGTW7IdNbeoDZbz5Xi2lRkzGaPxJ9VSLGmGaxZVvRrbHlzXvczv1e4Ky9LYkpEvD
         bEvvzdmRGDAIAWW5MlOCZnOhT9drNkUSP2f5kTFwUUaCyZKizigG1QHSezUAWtTT6rcE
         jICA==
X-Gm-Message-State: APjAAAV3KB0V7F5MqCP0FaTIDvegGpz5X1RS9IZLtY49aimY/OGnUI6B
        91m0akB5MqPh76R/1ceblUs=
X-Google-Smtp-Source: APXvYqxYREi5pdtkVxLeB5fMNn8UAXj1H1VBRUK+T8tIL7ytUYbmXrBEmvU32LPQNTui8UDjhIAOLA==
X-Received: by 2002:a17:902:a40c:: with SMTP id p12mr6739925plq.292.1579631535551;
        Tue, 21 Jan 2020 10:32:15 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id e1sm44395865pfl.98.2020.01.21.10.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:32:14 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:32:12 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     sspatil@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        oleksandr@redhat.com, surenb@google.com, timmurray@google.com,
        dancol@google.com, sonnyrao@google.com, bgeffon@google.com,
        hannes@cmpxchg.org, shakeelb@google.com, joaodias@google.com,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200121183212.GF140922@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200119161431.GA94410@google.com>
 <20200120075825.GH18451@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120075825.GH18451@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 20, 2020 at 08:58:25AM +0100, Michal Hocko wrote:
> On Sun 19-01-20 08:14:31, sspatil@google.com wrote:
> > On Sat, Jan 18, 2020 at 12:26:53AM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Jan 17, 2020 at 09:32:39AM -0800, Minchan Kim wrote:
> > > > On Fri, Jan 17, 2020 at 06:58:37PM +0300, Kirill A. Shutemov wrote:
> > > > > On Fri, Jan 17, 2020 at 12:52:25PM +0100, Michal Hocko wrote:
> > > > > > On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> > > > > > > There is usecase that System Management Software(SMS) want to give
> > > > > > > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > > > > > > in the case of Android, it is the ActivityManagerService.
> > > > > > > 
> > > > > > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > > > > > required to make the reclaim decision is not known to the app. Instead,
> > > > > > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > > > > > and that daemon must be able to initiate reclaim on its own without
> > > > > > > any app involvement.
> > > > > > > 
> > > > > > > To solve the issue, this patch introduces new syscall process_madvise(2).
> > > > > > > It uses pidfd of an external processs to give the hint.
> > > > > > > 
> > > > > > >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > > > > > > 			unsigned long flag);
> > > > > > > 
> > > > > > > Since it could affect other process's address range, only privileged
> > > > > > > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > > > > > > gives it the right to ptrace the process could use it successfully.
> > > > > > > The flag argument is reserved for future use if we need to extend the
> > > > > > > API.
> > > > > > > 
> > > > > > > I think supporting all hints madvise has/will supported/support to
> > > > > > > process_madvise is rather risky. Because we are not sure all hints make
> > > > > > > sense from external process and implementation for the hint may rely on
> > > > > > > the caller being in the current context so it could be error-prone.
> > > > > > > Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> > > > > > > 
> > > > > > > If someone want to add other hints, we could hear hear the usecase and
> > > > > > > review it for each hint. It's more safe for maintainace rather than
> > > > > > > introducing a buggy syscall but hard to fix it later.
> > > > > > 
> > > > > > I have brought this up when we discussed this in the past but there is
> > > > > > no reflection on that here so let me bring that up again. 
> > > > > > 
> > > > > > I believe that the interface has an inherent problem that it is racy.
> > > > > > The external entity needs to know the address space layout of the target
> > > > > > process to do anyhing useful on it. The address space is however under
> > > > > > the full control of the target process though and the external entity
> > > > > > has no means to find out that the layout has changed. So
> > > > > > time-to-check-time-to-act is an inherent problem.
> > > > > > 
> > > > > > This is a serious design flaw and it should be explained why it doesn't
> > > > > > matter or how to use the interface properly to prevent that problem.
> > > > > 
> > > > > I agree, it looks flawed.
> > > > > 
> > > > > Also I don't see what System Management Software can generically do on
> > > > > sub-process level. I mean how can it decide which part of address space is
> > > > > less important than other.
> > > > > 
> > > > > I see how a manager can indicate that this process (or a group of
> > > > > processes) is less important than other, but on per-addres-range basis?
> > > > 
> > > > For example, memory ranges shared by several processes or critical for the
> > > > latency, we could avoid those ranges to be cold/pageout to prevent
> > > > unncecessary CPU burning/paging.
> > > 
> > > Hmm.. I still don't see why any external entity has a better (or any)
> > > knowledge about the matter. The process has to do this, no?
> > 
> > FWIW, I totally agree with the time-to-check-time-to-react problem. However,
> > I'd like to clarify the ActivityManager/SystemServer case (I'll call it
> > SystemServer from now on)
> > 
> > For Android, every application (including the special SystemServer) are forked
> > from Zygote. The reason ofcourse is to share as many libraries and classes between
> > the two as possible to benefit from the preloading during boot.
> > 
> > After applications start, (almost) all of the APIs  end up calling into this
> > SystemServer process over IPC (binder) and back to the application.
> > 
> > In a fully running system, the SystemServer monitors every single process
> > periodically to calculate their PSS / RSS and also decides which process is
> > "important" to the user for interactivity.
> > 
> > So, because of how these processes start _and_ the fact that the SystemServer
> > is looping to monitor each process, it does tend to *know* which address
> > range of the application is not used / useful.
> > 
> > Besides, we can never rely on applications to clean things up themselves.
> > We've had the "hey app1, the system is low on memory, please trim your
> > memory usage down" notifications for a long time[1]. They rely on
> > applications honoring the broadcasts and very few do.
> > 
> > So, if we want to avoid the inevitable killing of the application and
> > restarting it, some way to be able to tell the OS about unimportant memory in
> > these applications will be useful.

Thanks for adding more useful description, Sandeep.

> 
> This is a useful information that should be a part of the changelog. I

I will incldue it in next respin.

> do see how the current form of the API might fit into Android model
> without many problems. But we are not designing an API for a single
> usecase, right? In a highly cooperative environments you can use ptrace
> code injection as mentioned by Kirill. Or is there any fundamental
> problem about that?

I replied it at Kirill's thread so let's discuss there.

> 
> The interface really has to be robust to future potential usecases.

I do understand your concern but for me, it's chicken and egg problem.
We usually do best effort to make something perfect as far as possible
but we also don't do over-engineering without real usecase from the
beginning.

I already told you how we could synchronize among processes and potential
way to be extended Daniel suggested(That's why current API has extra field
for the cookie) even though we don't need it right now.

If you want to suggest the other way, please explain why your idea is
better and why we need it at this moment. I don't think that is a
blocker for the progress of this API since we already have several ways
to synchronize processes.
