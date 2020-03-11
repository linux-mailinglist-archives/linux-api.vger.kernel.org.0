Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1BF180CE2
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2020 01:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgCKAgv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Mar 2020 20:36:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40479 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgCKAgu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Mar 2020 20:36:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so200696pgj.7;
        Tue, 10 Mar 2020 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vd8wwy++z15II2/dBTfgFL0hl+Hgv4lR23h2vNOMvr8=;
        b=gxytofn9W2QC+J7wiTxoPyNReGrF4fQbxnTPT7y1SfofqH/tO7P9KaK/AxJ7YDULR2
         llXuUYi3KZ30I/0U78DBzoH9KwNNhT0pI6h8BrLZWEl3sOtXyQNTOPVDB7Y7h+ZtXUgD
         8YqZ2meiORv/1U7kCKZLyOKflDgrGkFPbJGeneIvb0sJfYQhG2E3yWOQ21Xmt6q/Xv0N
         Ejxkv4cx2XagjdiNXWYwaWUN7m2Wkqff4SFMyFb3NBn8ZzbEk1lN07bcJ7xzpT70UST3
         BDbPtAAvqOCVIbTQRBZ1lM3JSa5f3a2Vn3/ygxh5TWRBuhJcE4x2BmKwcVtEzA6rVCBw
         dEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vd8wwy++z15II2/dBTfgFL0hl+Hgv4lR23h2vNOMvr8=;
        b=PxhGNO5IEcAj8y0DwUpNhwGcKSpI/voYTRMGs6ikuXYFIOpg1urYff7H55yXoiSWVg
         ivfFXDOaWZUAvg6N1CoPpiU/minHXbZBREd5fVjK8FnnIjoUbuoO3jFcxg4yXPJUDxy3
         J1lFxl7oM2FnYJ3MTrOnnTCuE1rorkK472cx7zMOURkdrGmr3GXbPx2MvFkcxsUQjBzX
         NVQGvRsZpGiWVLXhnOAJNI5vziMET79lmi+ntbtNU3B8RYXQBcD2beacfjMe3de2PdSx
         kW7xXE3zo4X4W2A3CNF4fwdEyT0oNhG+K+H+2sAu0zs/9OwOPv+W1DsRZ2/P5MxkoLGi
         b5Cg==
X-Gm-Message-State: ANhLgQ3Emf/sEevdCgN3jXNSuj2MpaKuses0d5eHg3s92iP9dKsRbfIJ
        o1L3p1aaF2GPVm464H8ykMc=
X-Google-Smtp-Source: ADFU+vswEpqqcw4XX2RthZfi5bdsShhNz14MpEtyAQ7rosc6C1e6e/ydxWEzoYFqo+CzmwWPJVNYHQ==
X-Received: by 2002:a65:685a:: with SMTP id q26mr284721pgt.29.1583887009162;
        Tue, 10 Mar 2020 17:36:49 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id m26sm2440274pgc.77.2020.03.10.17.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 17:36:48 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:36:46 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
Subject: Re: [PATCH v7 2/7] mm: introduce external memory hinting API
Message-ID: <20200311003646.GA87930@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-3-minchan@kernel.org>
 <bc3f6bd5-f032-bcf5-a09f-556ab785c587@suse.cz>
 <20200310222008.GB72963@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310222008.GB72963@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 10, 2020 at 03:20:08PM -0700, Minchan Kim wrote:
> On Thu, Mar 05, 2020 at 07:15:10PM +0100, Vlastimil Babka wrote:
> > On 3/2/20 8:36 PM, Minchan Kim wrote:
> > > There is usecase that System Management Software(SMS) want to give
> > > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > > in the case of Android, it is the ActivityManagerService.
> > > 
> > > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > 
> > You mean MADV_DONTNEED?
> 
> Mean to DONT_NEED's future version.
> 
> > 
> > > required to make the reclaim decision is not known to the app.
> > 
> > This seems to be mixing up the differences between MADV_DONTNEED and
> > COLD/PAGEOUT and self-imposed vs external memory hints?
> 
> Sorry, I don't understand what you want here.
> 
> > 
> > > Instead,
> > > it is known to the centralized userspace daemon(ActivityManagerService),
> > > and that daemon must be able to initiate reclaim on its own without
> > > any app involvement.
> > > 
> > > To solve the issue, this patch introduces a new syscall process_madvise(2).
> > > It uses pidfd of an external process to give the hint.
> > > 
> > >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > > 			unsigned long flag);
> > 
> > It's more common to call the argument 'flags' not 'flag'? The code seems to call
> > it flags. Also in line with madvise(2), the 'advise' argument should rather be
> > 'advice'. This is more important for the manpage, but let's be consistent.
> 
> Yub, I will send the patch along with your comment in previous patch.

Only place to use *advice* in kernel is comment in madvise_willneed.
Al other places use advise in kernel so I wanted to be more consistent
with other kernel sources. For man page, we could use the term "advice",
no problem.
