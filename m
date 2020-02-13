Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2915C764
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgBMQKN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 11:10:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38248 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgBMQKM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 11:10:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id d6so3342105pgn.5;
        Thu, 13 Feb 2020 08:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pq11CdZh/9XaCS2yx9ETIUzoQiiQH3AvcCT4xTpvaUA=;
        b=sWRi8JkG3eqgk7nYzzCq3g4geT4pLP2PJ9omUKVGOIaunOMZt8UIBIhdTR5L1TI1ZO
         x52gdvaEIg8jbdYjBvdi/RVpVA2EQ76hJayBSsLcALFp/EX5JipRePqVn+Hj6kj2sEgv
         SoqU4Lnwyx5bpOjvhLKr5XB1+pWrCD5CAzUpOaZc138RIdsX/RxO0YTaAJaC9GuNLlnC
         Eb6FMeQDDW+DidWlsfjBT/poNEma7IMO4wjPxFXR822xU+Y/hPU6ghlCa4XjjoXhwXat
         LpDjWTQxeAKpj2c1Zz8/t+UNsZluPqlGBwrRxDbaZtlHOKWm6iXZoUOMm5BVU+zuYTnQ
         wddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pq11CdZh/9XaCS2yx9ETIUzoQiiQH3AvcCT4xTpvaUA=;
        b=oZ369WJI59w9b5leY7BLMS0Ml6DKMlnYeqLMPLyUd0897DHR6jwBLX7JQEYqlrkTyH
         pFR55pvrNNSyt3AgJSdETkXyKKvr5qQl6Sy/GsMuqtVrw7TLU9vs1CxvrvqteCJphc2o
         txS28Ys4Tb5HKeY2//RM0pFXitGf2Wn5gTgogZESLoG5g3lRB9Fxm83p16Ybyon4cTn6
         KGtV7Uid55INPRg70SdlKQ9NHKSshEujMzSTH4MuQXkxW4QmR07hQhIktDGHqH8Z9g0p
         xigF9zmJ2Mc9Dlnqxy4z3Re39opaqADWpRoFrbgr2hKty9XVUn4Zlg5/wVDs/3F8GNZK
         oQYg==
X-Gm-Message-State: APjAAAUAja5tiqwfMQHy6cMqlaNJU9gxnuvpyZUMeYM7wUIw91ckizl0
        qmuC4TL+4GxIKhJ6CEjatko=
X-Google-Smtp-Source: APXvYqzI8Oi7TMhvonZcBalSovnuh/KcHK3T3FsCigFd9iMjc8lbR8SSmiARPrOMJIbUzzMyLep+UQ==
X-Received: by 2002:a63:7152:: with SMTP id b18mr19069004pgn.232.1581610211399;
        Thu, 13 Feb 2020 08:10:11 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id q12sm3404444pfh.158.2020.02.13.08.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:10:10 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:10:07 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
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
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v4 2/8] mm: introduce external memory hinting API
Message-ID: <20200213161007.GA24649@google.com>
References: <20200212233946.246210-1-minchan@kernel.org>
 <20200212233946.246210-3-minchan@kernel.org>
 <CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Jann,

On Thu, Feb 13, 2020 at 03:08:59PM +0100, Jann Horn wrote:
> On Thu, Feb 13, 2020 at 12:40 AM Minchan Kim <minchan@kernel.org> wrote:
> > To solve the issue, this patch introduces a new syscall process_madvise(2).
> > It uses pidfd of an external process to give the hint.
> [...]
> > +       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > +       if (IS_ERR_OR_NULL(mm)) {
> > +               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > +               goto release_task;
> > +       }
> > +
> > +       ret = do_madvise(task, start, len_in, behavior);
> 
> When you're accessing another task, you should ensure that the other
> task doesn't gain new privileges by executing a setuid binary in the
> middle of being accessed. mm_access() does that for you; it holds the
> ->cred_guard_mutex while it is looking up the task's ->mm and doing
> the security check. mm_access() then returns you an mm pointer that
> you're allowed to access without worrying about such things; an
> mm_struct never gains privileges, since a setuid execution creates a
> fresh mm_struct. However, the task may still execute setuid binaries
> and such things.
> 
> This means that after you've looked up the mm with mm_access(), you
> have to actually *use* that pointer. You're not allowed to simply read
> task->mm yourself.
> 
> Therefore, I think you should:
> 
>  - change patch 1/8 ("mm: pass task to do_madvise") to also pass an
> mm_struct* to do_madvise (but keep the task_struct* for patch 4/8)
>  - in this patch, pass the mm_struct* from mm_access() into do_madvise()
>  - drop patch 3/8 ("mm: validate mm in do_madvise"); it just papers
> over a symptom without addressing the underlying problem

Actually, it was what this patch series was doing until last version
but I changed it to reduce just *a parameter* to do_madvise.
And then, this time, I got a good advise I was not familiar.
I will fix it again.
Thanks for the review!
