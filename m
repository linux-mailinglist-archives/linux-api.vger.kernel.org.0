Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDC30EBB
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEaNTM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 09:19:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38854 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaNTL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 09:19:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id a186so5509979pfa.5;
        Fri, 31 May 2019 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NGbXt3/IQA1b49aRJS6BBAi0DW9ybOJRqUfZBPY09dA=;
        b=A3WPnRqnTUdG3crEHGBb/NpBr+tWmhd8IyhewWKj1R4bjxJzKPyXLzw5G3U9Lnteyl
         S36wH0W0+2k1njFZy2Ds2f/9kFql5X0DZRwamUx250rLJpRwx19xr3wuHqAOJBBYxLq9
         D5yvDqjjRPT9mniegqhTMI69xTfamzNzmqGuYDQC27qaWbbK2U1nrf6NWOVP/AQgAVed
         27HAfAIiBEc/pMFVtc2MGWrATM8vpC7OKdA/xorvzdMTJRgsu4MAyOAQ07qRReLzaC1m
         vS3W5pSSEa4XJdth4E3PvyqmD9aT/s5qNUBsNMohsGUqNgFntqIxkqkXVq7VroDVR9nb
         xcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NGbXt3/IQA1b49aRJS6BBAi0DW9ybOJRqUfZBPY09dA=;
        b=Bf794g/fKtpcOFKaBaI/yDB3dac5tTlWFL3ZHSFogPoiv8uwpOEEY03gu7hIToEd9e
         WjxKA1QlEzavJoiZ8Wy6V/LBpvru82RbwVVl5i3jj+NaoAs2embXRTRdc09MgLpD/K+8
         FYCzXpFuMQie9CpNi3fn+d/s5KBRvHKHhkt4yaIaGYzcRKknQhCyG0/SrMfRUz8bLcIG
         Kh3zY94gPdaLsP+zmPEH4NYLqWuSC9qE3L4Qlq9Mtedw7zOvunO9xuAPhau2wjpOjhSx
         J0zeNp+8idW3IWdUN9JQyLLwR8j9EJ4Vlmw/ygM8kyLOpDTUkIZNruTSxqiY24GI0/ZK
         Mpbg==
X-Gm-Message-State: APjAAAUtqyDWQyAwfE+yw551v7ULeQM0KV2GulZJ7MytN/pKNCBZaCn6
        jZYNyps3Ory4xxJtvFDPYq8=
X-Google-Smtp-Source: APXvYqwfmPTYrU4YNg70+w+fekZWbolWXYkyOovH8OK5qnvs6Xh/v3zPDoIKALH3CJn/NV3nmmscEA==
X-Received: by 2002:a63:6884:: with SMTP id d126mr9237347pgc.154.1559308750486;
        Fri, 31 May 2019 06:19:10 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id d186sm5485008pgc.58.2019.05.31.06.19.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 06:19:09 -0700 (PDT)
Date:   Fri, 31 May 2019 22:19:00 +0900
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
Message-ID: <20190531131859.GB195463@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-6-minchan@kernel.org>
 <20190531083757.GH6896@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531083757.GH6896@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 31, 2019 at 10:37:57AM +0200, Michal Hocko wrote:
> On Fri 31-05-19 15:43:12, Minchan Kim wrote:
> > There is some usecase that centralized userspace daemon want to give
> > a memory hint like MADV_[COLD|PAGEEOUT] to other process. Android's
> > ActivityManagerService is one of them.
> > 
> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > required to make the reclaim decision is not known to the app. Instead,
> > it is known to the centralized userspace daemon(ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without
> > any app involvement.
> > 
> > To solve the issue, this patch introduces new syscall process_madvise(2).
> > It could give a hint to the exeternal process of pidfd.
> > 
> >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > 			unsigned long cookie, unsigned long flag);
> > 
> > Since it could affect other process's address range, only privileged
> > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > gives it the right to ptrace the process could use it successfully.
> > 
> > The syscall has a cookie argument to privode atomicity(i.e., detect
> > target process's address space change since monitor process has parsed
> > the address range of target process so the operaion could fail in case
> > of happening race). Although there is no interface to get a cookie
> > at this moment, it could be useful to consider it as argument to avoid
> > introducing another new syscall in future. It could support *atomicity*
> > for disruptive hint(e.g., MADV_DONTNEED|FREE).
> > flag argument is reserved for future use if we need to extend the API.
> 
> Providing an API that is incomplete will not fly. Really. As this really
> begs for much more discussion and it would be good to move on with the
> core idea of the pro active memory memory management from userspace
> usecase. Could you split out the core change so that we can move on and
> leave the external for a later discussion. I believe this would lead to
> a smoother integration.

No problem but I need to understand what you want a little bit more because
I thought this patchset is already step by step so if we reach the agreement
of part of them like [1-5/6], it could be merged first.

Could you say how you want to split the patchset for forward progress?

Thanks.
