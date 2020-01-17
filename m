Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B641412E4
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAQV05 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 16:26:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34007 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAQV04 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 16:26:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so27914975ljg.1
        for <linux-api@vger.kernel.org>; Fri, 17 Jan 2020 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W6siwc0FStFfnqdBB2TxheHsdwzPw5y4W0hPqqZQpK4=;
        b=pR1NmzKPduRCZASkyWClKLFLk3TcfksLK06bzIvz7uTDuVlfqRe8ch5eEomo63Qlqk
         7+taAUoX0okfDTlTMHrnsn9ho0MhaYHh0qbH4MHQyxYPycWi3K5DDak0IGNXPDZHTyFB
         RTYeEMK9WaZiSXl4P+sqwJdkb1DWgaN+XZCcscU+Uso+hgQDdY7al4ExZKTVJNPRCEzb
         cA/OIucRdm9vgIfPUC/ByoNYuK0D2AIseleGcA/XyX7s5XX/owi91tRdKx74PVPvGxIC
         4mwuDFCzD3ulU381UdCbu7DMnGQPMJpVpmqtfk/E1i3RkpREnnRAPIezAHTkTPiAaSnr
         EszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W6siwc0FStFfnqdBB2TxheHsdwzPw5y4W0hPqqZQpK4=;
        b=VOhSslU+0XBVUcem1r6V3noNTwL+/aEfqWt5wgEpUtnP9AnAUhGo1PAMYqVAIoZHkR
         ZsuMHTZJDPxjZVbSipJxaLIcxJf8bzYO7FHKcSl/6t0BEZSg+Qh8/H7W3pAprA3j/BkD
         57cJ576fmFLyIjEoveJMHl4xxQDTdNJvL0q0M1N1lLYZOFv4xY1xxVl9q3/+f7K7BgKL
         3W7bnQK9Sxlsz+99ZXkK6ZNST9QuwMwuZis6gTiw77viQHCotMGMV9ra3MjioAFn6y3o
         zEBJ18Ixy8aaoos57C2EN+RC6ek32V4aQAsEwHB3OufDpdbGvYAZgZksFOtLXDgrhCjp
         Bc/w==
X-Gm-Message-State: APjAAAW1VBDEK/d6sY1np+OxW6pzW7E8eujm9OwRvq3CB17sWjK//Knq
        WwuhzDbxOdyEN+zZJn5dKHpbpw==
X-Google-Smtp-Source: APXvYqw1vhlglCZnPzTr4Qm/U6ysrH4X0sb3NAZgbTDH/2/oM3XZjN5MkJITOTzdpcS522vKje1rfw==
X-Received: by 2002:a2e:7d01:: with SMTP id y1mr6909097ljc.100.1579296414828;
        Fri, 17 Jan 2020 13:26:54 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i197sm12745941lfi.56.2020.01.17.13.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:54 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8BCF6100D6C; Sat, 18 Jan 2020 00:26:53 +0300 (+03)
Date:   Sat, 18 Jan 2020 00:26:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20200117212653.7uftw3lk35oykkmb@box>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117173239.GB140922@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 17, 2020 at 09:32:39AM -0800, Minchan Kim wrote:
> On Fri, Jan 17, 2020 at 06:58:37PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Jan 17, 2020 at 12:52:25PM +0100, Michal Hocko wrote:
> > > On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> > > > There is usecase that System Management Software(SMS) want to give
> > > > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > > > in the case of Android, it is the ActivityManagerService.
> > > > 
> > > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > > required to make the reclaim decision is not known to the app. Instead,
> > > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > > and that daemon must be able to initiate reclaim on its own without
> > > > any app involvement.
> > > > 
> > > > To solve the issue, this patch introduces new syscall process_madvise(2).
> > > > It uses pidfd of an external processs to give the hint.
> > > > 
> > > >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > > > 			unsigned long flag);
> > > > 
> > > > Since it could affect other process's address range, only privileged
> > > > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > > > gives it the right to ptrace the process could use it successfully.
> > > > The flag argument is reserved for future use if we need to extend the
> > > > API.
> > > > 
> > > > I think supporting all hints madvise has/will supported/support to
> > > > process_madvise is rather risky. Because we are not sure all hints make
> > > > sense from external process and implementation for the hint may rely on
> > > > the caller being in the current context so it could be error-prone.
> > > > Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> > > > 
> > > > If someone want to add other hints, we could hear hear the usecase and
> > > > review it for each hint. It's more safe for maintainace rather than
> > > > introducing a buggy syscall but hard to fix it later.
> > > 
> > > I have brought this up when we discussed this in the past but there is
> > > no reflection on that here so let me bring that up again. 
> > > 
> > > I believe that the interface has an inherent problem that it is racy.
> > > The external entity needs to know the address space layout of the target
> > > process to do anyhing useful on it. The address space is however under
> > > the full control of the target process though and the external entity
> > > has no means to find out that the layout has changed. So
> > > time-to-check-time-to-act is an inherent problem.
> > > 
> > > This is a serious design flaw and it should be explained why it doesn't
> > > matter or how to use the interface properly to prevent that problem.
> > 
> > I agree, it looks flawed.
> > 
> > Also I don't see what System Management Software can generically do on
> > sub-process level. I mean how can it decide which part of address space is
> > less important than other.
> > 
> > I see how a manager can indicate that this process (or a group of
> > processes) is less important than other, but on per-addres-range basis?
> 
> For example, memory ranges shared by several processes or critical for the
> latency, we could avoid those ranges to be cold/pageout to prevent
> unncecessary CPU burning/paging.

Hmm.. I still don't see why any external entity has a better (or any)
knowledge about the matter. The process has to do this, no?

> I also think people don't want to give an KSM hint to non-mergeable area.

And how the manager knows which data is mergable?

If you are intimate enough with the process' internal state feel free to
inject syscall into the process with ptrace. Why bother with half-measures?

-- 
 Kirill A. Shutemov
