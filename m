Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C858C30FAF
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEaOLy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 10:11:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46528 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfEaOLy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 10:11:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so2327859pls.13;
        Fri, 31 May 2019 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0xhb1pyImBa/JbJpYpXNh4R8mvOJIMPwfstX4vjxQNI=;
        b=QiARnrE80tnvvBre/mbPmuOKYNVVU8yYQMl/Ex2SrVLL+VfRNrYAD61HNOf0R3SPAb
         j44k0B09Ni2Ex/RblGlTkMnGKdwiyC9sqSZtLlKZX/BWZLzkFKSoJlgHv065+qA9jiTD
         9MK2MRBipL+7zBbywzPB1bZaN4VP/WKmThTlnUztCsxMTnHjgQVhjJSkIaNaOYhBKK0c
         Q2A5ZFUiVoEzwLBqY2pO9Mgb4Bn8SAGzxoRx/cvzf9q58xcFW+bks2xKeh8iCk6BZL91
         wDHdZ40z6OJh/aa9BdJXdimdyuf1zFwcCv82PyPaEiJmQYRq4vijRYwNx9iLgsCaQoeh
         JwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0xhb1pyImBa/JbJpYpXNh4R8mvOJIMPwfstX4vjxQNI=;
        b=k+4sdMkGZlycRlEfSsWgjYI2y6cq6z9JS5DjN/pQ/59tivWnJ4KYdAcFtdbtxBHKbe
         KqEzPg20eesy/dfhK49a8PLIppmYUchh0XOne10dCutp2ZGdXnxs7zCUdCty5M780zrx
         b+vM0Bsj6iF6sFC4MUGvxSvg08o2Yxlsr7y7HqaK5rJvPZqcq0HwUXtKOKgdx0a/C10u
         bMvVcNNFKDXs1mb34DAm/4SRcFl/8tY5X0ijrYqb3dfSsxZme+Bt2sam3hP326ARKXma
         JXaeL9CL4Qz22F5bLSKcv08SIRi16AMFelENN+JIqCjwx7ejxfkk8Y+l8xiPdEmmTLqs
         YrbA==
X-Gm-Message-State: APjAAAX5cp6jZot2klHlqwA+Apalo/uVf3bDuhgljWHG+vOUhix/XB1s
        /S/VQ/71/Fne7ABloi71nE0=
X-Google-Smtp-Source: APXvYqxRT6KrKzfpF6xMTycahrhhwULrJhijSmTAOdDfaQnfB69oVdK0PWFLHL8zxsiMQ2ZRQW2XIA==
X-Received: by 2002:a17:902:e311:: with SMTP id cg17mr9750155plb.202.1559311913113;
        Fri, 31 May 2019 07:11:53 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id m1sm5501839pjv.22.2019.05.31.07.11.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 07:11:51 -0700 (PDT)
Date:   Fri, 31 May 2019 23:11:43 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [RFCv2 5/6] mm: introduce external memory hinting API
Message-ID: <20190531141142.GA216592@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-6-minchan@kernel.org>
 <20190531083757.GH6896@dhcp22.suse.cz>
 <20190531131859.GB195463@google.com>
 <20190531140050.GS6896@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531140050.GS6896@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 31, 2019 at 04:00:50PM +0200, Michal Hocko wrote:
> On Fri 31-05-19 22:19:00, Minchan Kim wrote:
> > On Fri, May 31, 2019 at 10:37:57AM +0200, Michal Hocko wrote:
> > > On Fri 31-05-19 15:43:12, Minchan Kim wrote:
> > > > There is some usecase that centralized userspace daemon want to give
> > > > a memory hint like MADV_[COLD|PAGEEOUT] to other process. Android's
> > > > ActivityManagerService is one of them.
> > > > 
> > > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > > required to make the reclaim decision is not known to the app. Instead,
> > > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > > and that daemon must be able to initiate reclaim on its own without
> > > > any app involvement.
> > > > 
> > > > To solve the issue, this patch introduces new syscall process_madvise(2).
> > > > It could give a hint to the exeternal process of pidfd.
> > > > 
> > > >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > > > 			unsigned long cookie, unsigned long flag);
> > > > 
> > > > Since it could affect other process's address range, only privileged
> > > > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > > > gives it the right to ptrace the process could use it successfully.
> > > > 
> > > > The syscall has a cookie argument to privode atomicity(i.e., detect
> > > > target process's address space change since monitor process has parsed
> > > > the address range of target process so the operaion could fail in case
> > > > of happening race). Although there is no interface to get a cookie
> > > > at this moment, it could be useful to consider it as argument to avoid
> > > > introducing another new syscall in future. It could support *atomicity*
> > > > for disruptive hint(e.g., MADV_DONTNEED|FREE).
> > > > flag argument is reserved for future use if we need to extend the API.
> > > 
> > > Providing an API that is incomplete will not fly. Really. As this really
> > > begs for much more discussion and it would be good to move on with the
> > > core idea of the pro active memory memory management from userspace
> > > usecase. Could you split out the core change so that we can move on and
> > > leave the external for a later discussion. I believe this would lead to
> > > a smoother integration.
> > 
> > No problem but I need to understand what you want a little bit more because
> > I thought this patchset is already step by step so if we reach the agreement
> > of part of them like [1-5/6], it could be merged first.
> > 
> > Could you say how you want to split the patchset for forward progress?
> 
> I would start with new madvise modes and once they are in a shape to be
> merged then we can start the remote madvise API. I believe that even
> local process reclaim modes are interesting and useful. I haven't heard
> anybody objecting to them without having a remote API so far.

Okay, let's focus on [1-3/6] at this moment.

> -- 
> Michal Hocko
> SUSE Labs
