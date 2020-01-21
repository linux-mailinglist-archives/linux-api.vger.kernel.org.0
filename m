Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048BF144411
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2020 19:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAUSLS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Jan 2020 13:11:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35510 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSLS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Jan 2020 13:11:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so1903852pfo.2;
        Tue, 21 Jan 2020 10:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RZ+UzF1ke9VKh6CSTY/ooI3vzWKiS8jZf7sDVSihHD4=;
        b=NEFX/ezysY8snsP6VwgBPghhixLPcadjK8oX5390jYlUyypNu5b/NtrWPgM8jPKgKo
         ZYNjJeCNesZwyzi2bx96bBjOqUOTTlWhBT6lp/fEDzrlq0ifFrL0gfRriLISXIeWkeea
         PhqMc7Mgk3CT+qm/hbcBoj9YoaFtuOyw26szMr5QS8vSDIROS8D76NvrU2TjDOWbmqWn
         0g0CzOvdPkkJlFf29WjCfuofnqqaN0pmSRFeD+8T9Pg2VG0rKrpqmRu/wV5IzMT7+F9U
         MjcOhkH5b9amo2LQdXTP4KU6jirr+/CWk0FFQAqDuqPvwYGY4LH1aRTPGv0jDDerymb9
         2eRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZ+UzF1ke9VKh6CSTY/ooI3vzWKiS8jZf7sDVSihHD4=;
        b=B58Ai3h3GggtlqVAO23HabMO7L/FacK+HJ7I/wyg/0qR2z9flU1y2e1Q7dh2Dj+grW
         QrNsosw2IVOI15JvB8jBUbGmOgvQMDkYN0JptCNxPB2pEzWEe2ckxpEglg2iY8HfBvRD
         cyNy4PeaJ77D/MGCK3S7ypIRmuPfE12tUZtLkuYI/RumtLrRQUKMwWV1b+m2jurj0vLe
         f/0gb5y+hOudlRodfAbt7YrNzpRhprYzLYnKY1xS2X1kKAFJVpfpR8Sr+RwcT9bXZZbT
         Tzqez/hoDPTrkp3h33HNDMZwQSQtNt70JG6aJEuhXF3mzlhqeZX0MU/8Z8tcEtnMp1Ni
         EdUA==
X-Gm-Message-State: APjAAAUDFOonu/MH7HRlG4BolhpXHWFWQZn+JafVtytZUnBx2LGwV8S8
        Vpfxiw29BA+m8XEs77YH/os=
X-Google-Smtp-Source: APXvYqwjymOoEv8Ry2p1p8dCMolpdzxYn1+qfp4noIIgwqrM4twhYUXGvrTZzkbYodH1/ny+0fD11g==
X-Received: by 2002:aa7:9111:: with SMTP id 17mr5827628pfh.163.1579630277160;
        Tue, 21 Jan 2020 10:11:17 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id i11sm122167pjg.0.2020.01.21.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:11:15 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:11:13 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200121181113.GE140922@google.com>
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

I think Sandeep already gave enough information in other thread.

> 
> > I also think people don't want to give an KSM hint to non-mergeable area.
> 
> And how the manager knows which data is mergable?

Oleksandr, could you say your thought why you need address range based
API?

> 
> If you are intimate enough with the process' internal state feel free to
> inject syscall into the process with ptrace. Why bother with half-measures?

Concern is we want to act the hint in caller's context, not calle because
calle is usually very limited in cpuset/cgroups or even freezed state so
they couldn't act by themselves quick enough, which makes many problems.
One of efforts to solve the issue was "Expedited memory reclaim"

	https://lwn.net/Articles/785709/

That could be also a good candidate for process_madvise API.
