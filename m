Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779C3180B5D
	for <lists+linux-api@lfdr.de>; Tue, 10 Mar 2020 23:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgCJWUO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Mar 2020 18:20:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45394 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJWUO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Mar 2020 18:20:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id b22so76843pls.12;
        Tue, 10 Mar 2020 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlDN/MK7CrxZu9xb4dnw85pho74h/DS1WZaWMDoSgwE=;
        b=IaoscK++5rxK6qZ2/FHYQ6nlJ6PK373ITCG+4MIjR6b15wJKYDBiHrpkrvwKiIrzcy
         jd5i7Tv56A+3iwRKTMn7g4jblcSKBPJAYEjpnozxVOHgKcOKJx/DlXW9wYRd2TX+XL/o
         0BmjZ50iKsYDbGKlkUjW+mFNLLGW6XhVuroGLEdD8AcZeoPyL91qMUPU9wsCx2un4I6L
         GkT4zzZusm6zZNGr2OzV0wj5DP0+7TQA8mBCz5RyLzlCpax2XlXZ3uP7e6jad6JYwEtq
         njH+ZWG7B2AdxVjsWtt/FwvOS8HppVFclHmEo0912X0l1K1MDKr9Y6ho8dkyYIvxnX6d
         90Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlDN/MK7CrxZu9xb4dnw85pho74h/DS1WZaWMDoSgwE=;
        b=Qdp//UsjJKj4ypX2jdnBwK4K792cytA+D41F+Z7GXhpr7yzx2K3Cd/xje7rS2kEKcn
         Byp4RP1Jm/NeYHbQYITo6ZxLRvdYoVSJp7qu/qTO9Djoi5BwjpJewdUWBP4C+A2wXc6h
         ep23QgmuZv2yI6lJQvP7gQ0YdnCkLibpvlTmqO0HOv0Z0qKP2LiPm+xe01DdBPcHIBuA
         6oCH6ZhzCyYvJjk0DCqYOF2vbZQbjXHarsXz6YBz5K8CimO8mbjvW/DkLQNfiEride+K
         1VCJpfkFBXiSfNe4gfJNstMx/sI8IJlXVmC3jsRtlyhUaoRt0bw1Udr5elEwrENg6Gxs
         WdKg==
X-Gm-Message-State: ANhLgQ2FYdD0zi/1vLoEK7jWyuKDHJENINLIxq1XzbRJ53W3TIZ6yfGP
        kG9wQ88qPh/duv4yAnSJ/QQ=
X-Google-Smtp-Source: ADFU+vvk7+aqoNwobpRPQ+qRO3uj21tL5kgPUV7bKpFjuK4mVlX7rv3TJgflg2/ize2FmWV5IX7W0g==
X-Received: by 2002:a17:902:528:: with SMTP id 37mr123615plf.322.1583878811879;
        Tue, 10 Mar 2020 15:20:11 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id h24sm7528231pfn.49.2020.03.10.15.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 15:20:10 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:20:08 -0700
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
Message-ID: <20200310222008.GB72963@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-3-minchan@kernel.org>
 <bc3f6bd5-f032-bcf5-a09f-556ab785c587@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc3f6bd5-f032-bcf5-a09f-556ab785c587@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 05, 2020 at 07:15:10PM +0100, Vlastimil Babka wrote:
> On 3/2/20 8:36 PM, Minchan Kim wrote:
> > There is usecase that System Management Software(SMS) want to give
> > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > in the case of Android, it is the ActivityManagerService.
> > 
> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> 
> You mean MADV_DONTNEED?

Mean to DONT_NEED's future version.

> 
> > required to make the reclaim decision is not known to the app.
> 
> This seems to be mixing up the differences between MADV_DONTNEED and
> COLD/PAGEOUT and self-imposed vs external memory hints?

Sorry, I don't understand what you want here.

> 
> > Instead,
> > it is known to the centralized userspace daemon(ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without
> > any app involvement.
> > 
> > To solve the issue, this patch introduces a new syscall process_madvise(2).
> > It uses pidfd of an external process to give the hint.
> > 
> >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > 			unsigned long flag);
> 
> It's more common to call the argument 'flags' not 'flag'? The code seems to call
> it flags. Also in line with madvise(2), the 'advise' argument should rather be
> 'advice'. This is more important for the manpage, but let's be consistent.

Yub, I will send the patch along with your comment in previous patch.

> 
> ...
> 
> > 
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> For the core parts,
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks for the review!
