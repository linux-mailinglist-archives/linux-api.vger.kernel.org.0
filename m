Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A358140FEF
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 18:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgAQRco (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 12:32:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45438 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQRco (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 12:32:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so12248704pfg.12;
        Fri, 17 Jan 2020 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L1FnToWeHqvhSoE41np9grETbwm16N+C6QkV8Y6+tYA=;
        b=J37IIajyj/GJK910YEMfp9mjT5s00/3JWfCMQKsW2uZdvXDv3LjJ6tSfBo5ceewJO8
         yEQdNNl0xJ1EhXUuYUIIXvlW7D1Zu7BBZppGQWty7V7CnSn5hE1RE5JE5j9Ft2WKDBgp
         evAQcReD2A2hvYYJYZMSGbL1ukRlGVg/k76mKhQiYblEXsFYLzkso1oCigvFVowWHoxl
         blafvATXth6R7qWkMjDTkqPDNh4fi2pfn+XBBdD9hgXQa35z8UT/JG8PIx9hqJti/eLp
         QJbH/UGvSqrIf2hUmddW8eQ4VmdAAQZm2uKNr1SM/I/UXsfvIrxzq4GI3ecgMuXV5o8n
         HpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L1FnToWeHqvhSoE41np9grETbwm16N+C6QkV8Y6+tYA=;
        b=VW7/LV5AkRoe5RQUgjz8GoAVy0pyfWdssIWlAI4hs7Qa5+DukYDeSxxIxhgW7YTGFf
         mbcvjpZdYAiZyZC0iGSFO+Y714Li+PKcWrIELeyAJFFCxqM1lJNHzQiTNm3vQFWl6eae
         Ir6lMMNLXp5OHF9QHDl6kIgXwtS+mWA6oQF+d6Mo4fIfkdzVqbH2ID21jm0JrTZ72d4v
         nwlshRq1HRlorB13WJENpwc1RTgMBGOReaLpQudVL6qIVUyZCXOfhYg2quGmv5pHBf6t
         OZOdmvt39L6PG7iohq27clTernX5mJE+0MSl1xJROV5R7gPEIVThDB0SRTPjEMyj89pC
         dvLw==
X-Gm-Message-State: APjAAAVx/P8NYkBgmmRWmnQkrM1k6gI+aoupWX1a1ykHg2wYeCT3CdLe
        YJNM+sjyS5emE3JDBNhOm6+xdqVX
X-Google-Smtp-Source: APXvYqz1qo6FCV8Wg355A/Twy2ilZk2KiHAH7WI1ZkwmJt+/oIuo9JtJ3jtxlslxKLgYhf344hCEpw==
X-Received: by 2002:a63:8f51:: with SMTP id r17mr45732434pgn.157.1579282362919;
        Fri, 17 Jan 2020 09:32:42 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id m101sm8113002pje.13.2020.01.17.09.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 09:32:41 -0800 (PST)
Date:   Fri, 17 Jan 2020 09:32:39 -0800
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
Message-ID: <20200117173239.GB140922@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117155837.bowyjpndfiym6cgs@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 17, 2020 at 06:58:37PM +0300, Kirill A. Shutemov wrote:
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
> I agree, it looks flawed.
> 
> Also I don't see what System Management Software can generically do on
> sub-process level. I mean how can it decide which part of address space is
> less important than other.
> 
> I see how a manager can indicate that this process (or a group of
> processes) is less important than other, but on per-addres-range basis?

For example, memory ranges shared by several processes or critical for the
latency, we could avoid those ranges to be cold/pageout to prevent
unncecessary CPU burning/paging.

I also think people don't want to give an KSM hint to non-mergeable area.
