Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61CFB14108D
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 19:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgAQSOR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jan 2020 13:14:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38190 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgAQSOR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jan 2020 13:14:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id f20so10167216plj.5;
        Fri, 17 Jan 2020 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OuIr4in3xQOppX19rgOiPKIAzj+c67E+lzKRExjohkE=;
        b=H9GYcGT+teNfRyQemXjNBoyJGnAgppTIFqqr5DOXOHcSk/mqSRWGSAbY3Kkwt6JPMD
         sBA52lPqTpYFefuq/jyG0UD8XMNcIrKAxN/dc0CH/NPq8taoMvM13lXPE+nKD6HEQ3kc
         gJP3iZkpcWy9UGL4BKC/CSOSkf9b7DWOEPK2b+p+SQnMoOkFAHL0rUHK6dOVWPc2jpCT
         XR/M57QxX+yWPHj89WUtr+kdB8JFZnbVou5ulWam50+fkpq+vGJoSD3XHV5bgg4HjKFd
         wesHGXh2eOBpnxSSFpaKB/93HeNiaRgMvtMUJgBn+vN/+6Mgr8R3t7gJCehe2JNCb/dk
         Ue+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuIr4in3xQOppX19rgOiPKIAzj+c67E+lzKRExjohkE=;
        b=uYhQIZwh1zQnM5BF0rlQrVG2yMaHRjC4vomIsSwHsFCgtPB/HXAYnJSgfSv49hJFMq
         Svle9Ug4DCWAapweKrhAIhXiGGa4XP6sNhHqxntI8NHBkFWhd06rRkvoEwfj6/yTb/GV
         OremEUSRQ8BExQQvN6CxdhhprucvztS+Brn5Q+WLj7fHnFLnICekGMYSKiHPk3TpMTBM
         +SRWtNUgiYfGIa2a0VhNJAov1IuV4vFmQdu1Wlt0VTUC6HWrYE2vi45jp6TIURJuIvf/
         kjS9Z2kKJzVL9R8Tz7zHVRjb99O9QGc5v8nkz23sVBM2wg8Ml02NL9RNP0+WtX+NKJyK
         onBQ==
X-Gm-Message-State: APjAAAU/8EhtFt5RGkfolZpi/6BOpfqa6bVG6uyW9vTV0atfsPki+Pg9
        +nQl2QszLsbbxPzs0Z7lmZs=
X-Google-Smtp-Source: APXvYqz9vooRnPoitrbY06oL/qUgFJb2pY/g292RcHh+az+iF16LMIahqGZVogDDr2fPfyNT9TyqjQ==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr336588pld.250.1579284856593;
        Fri, 17 Jan 2020 10:14:16 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b65sm30185503pgc.18.2020.01.17.10.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 10:14:15 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:14:13 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
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
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de, "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 1/5] mm: factor out madvise's core functionality
Message-ID: <20200117181413.GC140922@google.com>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-2-minchan@kernel.org>
 <d3b8431d-fa3d-6a16-8af1-a68b3ac8ca58@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3b8431d-fa3d-6a16-8af1-a68b3ac8ca58@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 17, 2020 at 01:02:34PM +0300, Kirill Tkhai wrote:
> On 17.01.2020 02:59, Minchan Kim wrote:
> > This patch factor out madvise's core functionality so that upcoming
> > patch can reuse it without duplication. It shouldn't change any behavior.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/madvise.c | 194 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 111 insertions(+), 83 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index bcdb6a042787..0c901de531e4 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -35,6 +35,7 @@
> >  struct madvise_walk_private {
> >  	struct mmu_gather *tlb;
> >  	bool pageout;
> > +	struct task_struct *task;
> >  };
> >  
> >  /*
> > @@ -306,12 +307,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >  	bool pageout = private->pageout;
> >  	struct mm_struct *mm = tlb->mm;
> >  	struct vm_area_struct *vma = walk->vma;
> > +	struct task_struct *task = private->task;
> >  	pte_t *orig_pte, *pte, ptent;
> >  	spinlock_t *ptl;
> >  	struct page *page = NULL;
> >  	LIST_HEAD(page_list);
> >  
> > -	if (fatal_signal_pending(current))
> > +	if (fatal_signal_pending(task))
> >  		return -EINTR;
> 
> This EINTR may confuse userspace. Users will think the syscall was interrupted,
> and it may be restarted, but this is not true.

madvise_[pageout|cold] doesn't propagate the error to userspace.

> 
> What we care here? Current task received fatal signal, while walk_page_range(..&cold_walk_ops..)
> is a long cycle. So, this check allows to break the cycle faster.
> 
> Iteration over remote task's mm may also be long, and we still may need to break
> it if current received a signal.
> 
> So, we'd better left fatal_signal_pending(current) here.
> 
> Maybe we need both tasks fatal_signal_pending() checks and different retvals here,
> but it's up to you.

Yub, let's check both processes here to bail out.

Thanks for the review!
