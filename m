Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FAA24CBE
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfEUKcb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 06:32:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46932 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUKcb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 06:32:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so8834642pfm.13;
        Tue, 21 May 2019 03:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iEpABD/nsZz33E7K8kq0g1PtAPqQkfDdFrRiuwAA8wE=;
        b=ra87JvwgK/Zau+lFTPoxO3sEsrDEs7bq3v+sP8khYi/R1y9BVFkLV0dtEgBCALl1RC
         BvmEvtF2rbLRX5/jiSCOP+edg7XsEcCiVRRFaSnESZebX/VPzbmKlp/+aunsJ/v8Parl
         zrcdnW3a1IXgZk6c//4kQeR8tFYRhFUXYriqNaXMoWw0cDaMocbQgQA6Pcp4kd7G6HQZ
         T7MzDB7FhNfA6dyV0HLfz9g77EKMvjmYfEfy+E8AK6V/3RY2BW+5nn/dAdXYqXCi5hNU
         GBnMuqUhUnCSndbZX3Cg8l2DiU5iNOqkoMiMEqqSEluqMbZtYAdXTUJe05W+pf9dG8o8
         xwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iEpABD/nsZz33E7K8kq0g1PtAPqQkfDdFrRiuwAA8wE=;
        b=M1qf4PnE59X4Ks0v+Ip4tNWXtKroOkGRkHepQPuqx7YH4hDdbq/f7lW570UgNggHvC
         7UXXRM4Gbz3hRptdfIksVdkBg7XjYt+TNMAZftBB0glvUDNfIQDrDfKRq4Bma23S8TPe
         4ZHC4+U4sAl81Cm7RZJrTcW4KrA+lxKNO8fY5ECbNJ8cCk++CkgW+/N436k7n8mwBCg+
         EBX0qgcBS26XrAxH6o06zbwkLjKD8UXNsoSOCHeOJmhNtJZCsHwurnYROCx9ilNwCald
         +2KsikznCdZveHhKM4NFdt2I5W2FSTy8vzyb6f9yyResyNvpVrkJ2WTITBvTa2GlEIEV
         j9JQ==
X-Gm-Message-State: APjAAAUst2pd93CFF0oQNHbC1yzCls9ihtCVLMnWzaOfLiuXmM7LLfSy
        A1kVPawk+HTVALX6v6Xcb1s=
X-Google-Smtp-Source: APXvYqwiCEhrh1gNZKYql1ciR0mfuAlQeUIx5uOvluMiBVcOnNC/dxSyCtOOCo7BXHPxdLEX8zMfmQ==
X-Received: by 2002:a63:1212:: with SMTP id h18mr31397904pgl.266.1558434750297;
        Tue, 21 May 2019 03:32:30 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id k6sm24835382pfi.86.2019.05.21.03.32.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 03:32:29 -0700 (PDT)
Date:   Tue, 21 May 2019 19:32:23 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 5/7] mm: introduce external memory hinting API
Message-ID: <20190521103223.GD219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-6-minchan@kernel.org>
 <20190520091829.GY6836@dhcp22.suse.cz>
 <20190521024107.GF10039@google.com>
 <20190521061743.GC32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521061743.GC32329@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 08:17:43AM +0200, Michal Hocko wrote:
> On Tue 21-05-19 11:41:07, Minchan Kim wrote:
> > On Mon, May 20, 2019 at 11:18:29AM +0200, Michal Hocko wrote:
> > > [Cc linux-api]
> > > 
> > > On Mon 20-05-19 12:52:52, Minchan Kim wrote:
> > > > There is some usecase that centralized userspace daemon want to give
> > > > a memory hint like MADV_[COOL|COLD] to other process. Android's
> > > > ActivityManagerService is one of them.
> > > > 
> > > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > > > required to make the reclaim decision is not known to the app. Instead,
> > > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > > and that daemon must be able to initiate reclaim on its own without
> > > > any app involvement.
> > > 
> > > Could you expand some more about how this all works? How does the
> > > centralized daemon track respective ranges? How does it synchronize
> > > against parallel modification of the address space etc.
> > 
> > Currently, we don't track each address ranges because we have two
> > policies at this moment:
> > 
> > 	deactive file pages and reclaim anonymous pages of the app.
> > 
> > Since the daemon has a ability to let background apps resume(IOW, process
> > will be run by the daemon) and both hints are non-disruptive stabilty point
> > of view, we are okay for the race.
> 
> Fair enough but the API should consider future usecases where this might
> be a problem. So we should really think about those potential scenarios
> now. If we are ok with that, fine, but then we should be explicit and
> document it that way. Essentially say that any sort of synchronization
> is supposed to be done by monitor. This will make the API less usable
> but maybe that is enough.

Okay, I will add more about that in the description.

>  
> > > > To solve the issue, this patch introduces new syscall process_madvise(2)
> > > > which works based on pidfd so it could give a hint to the exeternal
> > > > process.
> > > > 
> > > > int process_madvise(int pidfd, void *addr, size_t length, int advise);
> > > 
> > > OK, this makes some sense from the API point of view. When we have
> > > discussed that at LSFMM I was contemplating about something like that
> > > except the fd would be a VMA fd rather than the process. We could extend
> > > and reuse /proc/<pid>/map_files interface which doesn't support the
> > > anonymous memory right now. 
> > > 
> > > I am not saying this would be a better interface but I wanted to mention
> > > it here for a further discussion. One slight advantage would be that
> > > you know the exact object that you are operating on because you have a
> > > fd for the VMA and we would have a more straightforward way to reject
> > > operation if the underlying object has changed (e.g. unmapped and reused
> > > for a different mapping).
> > 
> > I agree your point. If I didn't miss something, such kinds of vma level
> > modify notification doesn't work even file mapped vma at this moment.
> > For anonymous vma, I think we could use userfaultfd, pontentially.
> > It would be great if someone want to do with disruptive hints like
> > MADV_DONTNEED.
> > 
> > I'd like to see it further enhancement after landing address range based
> > operation via limiting hints process_madvise supports to non-disruptive
> > only(e.g., MADV_[COOL|COLD]) so that we could catch up the usercase/workload
> > when someone want to extend the API.
> 
> So do you think we want both interfaces (process_madvise and madvisefd)?

What I have in mind is to extend process_madvise later like this

struct pr_madvise_param {
    int size;                       /* the size of this structure */
    union {
    	const struct iovec __user *vec; /* address range array */
	int fd;				/* supported from 6.0 */
    }
}

with introducing new hint Or-able PR_MADV_RANGE_FD, so that process_madvise
can go with fd instead of address range.
