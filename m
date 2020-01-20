Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A250142492
	for <lists+linux-api@lfdr.de>; Mon, 20 Jan 2020 08:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgATH6b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Jan 2020 02:58:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37141 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATH6b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Jan 2020 02:58:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so13650303wmf.2;
        Sun, 19 Jan 2020 23:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ft1ppkkfH4raCeZxme+a2Wu4lfTixTdm+rB0YxpNt7A=;
        b=L39Ed5BEaITLmKOhFtaw5Wva89RuPLqr+0jGoFsKopKNbZlO5eb6ykmvNC+rfwQ4fm
         Q0iycmL5dCz5bUHABW9V4FhUXgi7KOKnlwLPdZY84UtOupDDdqHLUsbHC65gUquSPK2/
         MDOD32Q+0+x/O8dVJHHWetfXlSO7v8353RDJbeQ4sUSKUkzfYwpNG4tOJYkVZLPK4Gqv
         sRABppsp2SFWllmU32oa3H1Pcym1Q4J9f3JTwJY7vO1/D6XxHOGrjTJcgSvLKQiBZxk5
         USyJjvxsKDrtuE/inHeJQ3OyIOcFdpbk1v4IvnsJ04FSrGNdFeXZbEYIMOhi3xKO82Aj
         RbDQ==
X-Gm-Message-State: APjAAAX9oBnGda4z8yxMQhoJ+UrVwDl7FIAuxH5I8NGgO4fjXRcEEQXd
        JKyQPWTABotmuz2s4czcUBs=
X-Google-Smtp-Source: APXvYqwC6Bg1AKZ6q+JZzdOdWI3t9Bdf0NOozf9LisD6pjmZiGnRVPu5F+IzqyzFKeAbourkQkAobA==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr18340346wmk.52.1579507108009;
        Sun, 19 Jan 2020 23:58:28 -0800 (PST)
Received: from localhost (ip-37-188-138-155.eurotel.cz. [37.188.138.155])
        by smtp.gmail.com with ESMTPSA id z83sm8741410wmg.2.2020.01.19.23.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:58:27 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:58:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     sspatil@google.com
Cc:     kirill@shutemov.name, minchan@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        oleksandr@redhat.com, surenb@google.com, timmurray@google.com,
        dancol@google.com, sonnyrao@google.com, bgeffon@google.com,
        hannes@cmpxchg.org, shakeelb@google.com, joaodias@google.com,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200120075825.GH18451@dhcp22.suse.cz>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200119161431.GA94410@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119161431.GA94410@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun 19-01-20 08:14:31, sspatil@google.com wrote:
> On Sat, Jan 18, 2020 at 12:26:53AM +0300, Kirill A. Shutemov wrote:
> > On Fri, Jan 17, 2020 at 09:32:39AM -0800, Minchan Kim wrote:
> > > On Fri, Jan 17, 2020 at 06:58:37PM +0300, Kirill A. Shutemov wrote:
> > > > On Fri, Jan 17, 2020 at 12:52:25PM +0100, Michal Hocko wrote:
> > > > > On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> > > > > > There is usecase that System Management Software(SMS) want to give
> > > > > > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > > > > > in the case of Android, it is the ActivityManagerService.
> > > > > > 
> > > > > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > > > > required to make the reclaim decision is not known to the app. Instead,
> > > > > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > > > > and that daemon must be able to initiate reclaim on its own without
> > > > > > any app involvement.
> > > > > > 
> > > > > > To solve the issue, this patch introduces new syscall process_madvise(2).
> > > > > > It uses pidfd of an external processs to give the hint.
> > > > > > 
> > > > > >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > > > > > 			unsigned long flag);
> > > > > > 
> > > > > > Since it could affect other process's address range, only privileged
> > > > > > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > > > > > gives it the right to ptrace the process could use it successfully.
> > > > > > The flag argument is reserved for future use if we need to extend the
> > > > > > API.
> > > > > > 
> > > > > > I think supporting all hints madvise has/will supported/support to
> > > > > > process_madvise is rather risky. Because we are not sure all hints make
> > > > > > sense from external process and implementation for the hint may rely on
> > > > > > the caller being in the current context so it could be error-prone.
> > > > > > Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> > > > > > 
> > > > > > If someone want to add other hints, we could hear hear the usecase and
> > > > > > review it for each hint. It's more safe for maintainace rather than
> > > > > > introducing a buggy syscall but hard to fix it later.
> > > > > 
> > > > > I have brought this up when we discussed this in the past but there is
> > > > > no reflection on that here so let me bring that up again. 
> > > > > 
> > > > > I believe that the interface has an inherent problem that it is racy.
> > > > > The external entity needs to know the address space layout of the target
> > > > > process to do anyhing useful on it. The address space is however under
> > > > > the full control of the target process though and the external entity
> > > > > has no means to find out that the layout has changed. So
> > > > > time-to-check-time-to-act is an inherent problem.
> > > > > 
> > > > > This is a serious design flaw and it should be explained why it doesn't
> > > > > matter or how to use the interface properly to prevent that problem.
> > > > 
> > > > I agree, it looks flawed.
> > > > 
> > > > Also I don't see what System Management Software can generically do on
> > > > sub-process level. I mean how can it decide which part of address space is
> > > > less important than other.
> > > > 
> > > > I see how a manager can indicate that this process (or a group of
> > > > processes) is less important than other, but on per-addres-range basis?
> > > 
> > > For example, memory ranges shared by several processes or critical for the
> > > latency, we could avoid those ranges to be cold/pageout to prevent
> > > unncecessary CPU burning/paging.
> > 
> > Hmm.. I still don't see why any external entity has a better (or any)
> > knowledge about the matter. The process has to do this, no?
> 
> FWIW, I totally agree with the time-to-check-time-to-react problem. However,
> I'd like to clarify the ActivityManager/SystemServer case (I'll call it
> SystemServer from now on)
> 
> For Android, every application (including the special SystemServer) are forked
> from Zygote. The reason ofcourse is to share as many libraries and classes between
> the two as possible to benefit from the preloading during boot.
> 
> After applications start, (almost) all of the APIs  end up calling into this
> SystemServer process over IPC (binder) and back to the application.
> 
> In a fully running system, the SystemServer monitors every single process
> periodically to calculate their PSS / RSS and also decides which process is
> "important" to the user for interactivity.
> 
> So, because of how these processes start _and_ the fact that the SystemServer
> is looping to monitor each process, it does tend to *know* which address
> range of the application is not used / useful.
> 
> Besides, we can never rely on applications to clean things up themselves.
> We've had the "hey app1, the system is low on memory, please trim your
> memory usage down" notifications for a long time[1]. They rely on
> applications honoring the broadcasts and very few do.
> 
> So, if we want to avoid the inevitable killing of the application and
> restarting it, some way to be able to tell the OS about unimportant memory in
> these applications will be useful.

This is a useful information that should be a part of the changelog. I
do see how the current form of the API might fit into Android model
without many problems. But we are not designing an API for a single
usecase, right? In a highly cooperative environments you can use ptrace
code injection as mentioned by Kirill. Or is there any fundamental
problem about that?

The interface really has to be robust to future potential usecases.
-- 
Michal Hocko
SUSE Labs
