Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA0FE1416DF
	for <lists+linux-api@lfdr.de>; Sat, 18 Jan 2020 10:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgARJku (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 18 Jan 2020 04:40:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40367 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgARJkt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 18 Jan 2020 04:40:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so24868130wrn.7;
        Sat, 18 Jan 2020 01:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=uecpYHIlA8EXuE0WlfcP8oL9kLAa1BwGMQHRzItHdQI=;
        b=cOPyeCdiesvnDtg9QJvwJUPdfpmXUvhjsWG8NAqroLXL+mTRADvlQ9k/k4be0zHSyA
         iOd4wfzdh5tGfxhEOPc7YQxQ27c3Hm1JbGi2l5EgkXTBIC4M+YDpPfAjgpaN93N+8L02
         qCtyyNU0Io4nyp0SMgmE/Ny6nrhyUGoh0f+yc6tl7wdjWhBeojSvjAdHq90KXjZ6Koj+
         j2sujyKO0NUEWOXa7nc+PZStuHkMMEtUsgZvQQ2Jb4k9xvMFtGsXLF2xXmxzJhcHSOJ7
         g7tE3vxHUzLXUYIXxYem0ZyvnOnLya0T+N8hlPGyus2twVnZTU8RBpW+8HbA4Mln9QAg
         pyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=uecpYHIlA8EXuE0WlfcP8oL9kLAa1BwGMQHRzItHdQI=;
        b=lJdvbuzjjzhkLQB+M+1+MU7Ekf0xVv1NV1dBbLalSnu7XD/7B8EuxX+ce1QaEDeixm
         tvwKSo6LZrVk7MsJEW+SFoc1V1X5/Af45NVN/Q8pP41s+il2aHNWrOK0b7Q7rqRgRhkl
         KO/MaAUCuc8fc9JZi3UNMNEv/ixXU5ThXDHtKGFJDDMF6+ASfq2fx8Qj3BnLFvpX+T+U
         avZeYqa7rn3Lm1tbEgPjKPCKic+B/gyJLb4yTtLB9us9H87IyVihR0uzks/d+aijobwX
         bv7Dpw2rVIp56chDoOuVi8ZVSoC1VKI0SnCdHFiIWzExjUjHKgpKn72VVb378phonPFy
         L+ZQ==
X-Gm-Message-State: APjAAAW4tS+Rqy/TWDdhA9RxcnSpXlT24sovlKY72VuqvVRaUtSJrvm1
        VU3vyw77dR27fvZOEpyfTPM=
X-Google-Smtp-Source: APXvYqwLBqSwG1yBxDMw1A5PEKxZ4fjGJDsR3X4P36SMAVjfbbU0cf6OTOIejp6kPjaKdivMlscJVA==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr7586856wrn.404.1579340447732;
        Sat, 18 Jan 2020 01:40:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:71c1:e5a:f945:a5c3])
        by smtp.gmail.com with ESMTPSA id j12sm38374188wrt.55.2020.01.18.01.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 01:40:47 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@kernel.org>,
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
Subject: Re: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Date:   Sat, 18 Jan 2020 10:40:38 +0100
Message-Id: <20200118094038.10507-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117212653.7uftw3lk35oykkmb@box> (raw)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, 18 Jan 2020 00:26:53 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:

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
> 
> > I also think people don't want to give an KSM hint to non-mergeable area.
> 
> And how the manager knows which data is mergable?

Couldn't 'idle_page_tracking' like features could be used by the external
manager processes to know that?


Thanks,
SeongJae Park

> 
> If you are intimate enough with the process' internal state feel free to
> inject syscall into the process with ptrace. Why bother with half-measures?
> 
> -- 
>  Kirill A. Shutemov
> 
> 
