Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA386140E6C
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAQP6k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 10:58:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34092 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgAQP6k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 10:58:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so26997686ljg.1
        for <linux-api@vger.kernel.org>; Fri, 17 Jan 2020 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+sOBVwPXHpl/jOGredPdQ/eMOPx1R53v2YKaybpo74=;
        b=A++MSgEDqeaqay+NQuCUGyeIN2kG3UsGiJA8e/G48HxQP8Bai+mCDaVLzeYStNnnDm
         OyvxPnQSMyas2dvhw+Ev+6t/pEUZAXksiKLHl+1AfZmB/wgG7IV+a0lbL4wum4G6josY
         AO6GhNHfbnpj4l3ztmzAa6Rk91MIiFzabf08PaVz/+GXjOHNdQ2EjEUOtxuJRRED7yjI
         9aW6ceb4+In7CtnXksxhGhzmTu50yp71ijp3ckj5puwmhwt5XYU8PEJmdjf0AB7UaZ2V
         yFMfdhKaeZQBSkydOifCuhn2wGgnSlIM20Md1n144gVX9DwAYQDUtbf8a7Oxgq5qbq57
         oMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+sOBVwPXHpl/jOGredPdQ/eMOPx1R53v2YKaybpo74=;
        b=S0Iifkv2g/rFNni94ulg3TrHPJx2WubTdzg0s7R7A0WrynkfRq5vJTG85hGl0DfwgK
         JKWwN6Dtb2R3ehdZMCDpjtE3V2q+wegdSch0ZkIjwpGLI/lOQjM7yy6dk+bX5ly0ktgU
         mCIzcWOGqIEY88SORocVIO9VJtqS/FYGRtsjmCgg4mOPjXMJO/f6GVpx5Dbt/j4NDxX+
         YMIMG7bGFEHR/pp6FpmRsMNdUWg7ugae7Y3h4eKMvo7r0QbLTIS8RWD3nRPxuX2LD8Jg
         LNzceaR7jzUBRZPY64L2YiDtQz5M9DlKs9hKHRlfw3Sls56MuXiFCsGVDbc0hTraTCMH
         Rr+w==
X-Gm-Message-State: APjAAAUc+kXq903bDJ3fjGtqUmx1n7PASoebdMON8irwgrdMTYK2/GfL
        9JLRvqLpvquQy2aykXqn6xZ9QA==
X-Google-Smtp-Source: APXvYqxrmQaVRsNtHHNzyFR0xx1ZpXxJ6+StbGbRoizxb9hy6Tpqd1hlRsR9BMFheoCQmtN8dCj4Uw==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr6084808lji.214.1579276718652;
        Fri, 17 Jan 2020 07:58:38 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q186sm12694326ljq.14.2020.01.17.07.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:58:37 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3729B100CFF; Fri, 17 Jan 2020 18:58:37 +0300 (+03)
Date:   Fri, 17 Jan 2020 18:58:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
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
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200117155837.bowyjpndfiym6cgs@box>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117115225.GV19428@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
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

I agree, it looks flawed.

Also I don't see what System Management Software can generically do on
sub-process level. I mean how can it decide which part of address space is
less important than other.

I see how a manager can indicate that this process (or a group of
processes) is less important than other, but on per-addres-range basis?

-- 
 Kirill A. Shutemov
