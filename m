Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8550C17E049
	for <lists+linux-api@lfdr.de>; Mon,  9 Mar 2020 13:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCIMav (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Mar 2020 08:30:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21176 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726391AbgCIMau (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Mar 2020 08:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583757049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uzsPQ+ZsiFXUNzM64RYqffPOnfhsKcEvaN4HId4EK8=;
        b=ei/vdRMA/XJIWkZk3OORtBaT4F0mxQC2IzcxjxGW7T7nri+8Bb6OvwfGO9cxyt2z7ikbF6
        kqwPt3Lz59OnJpO9R8EWI6xProRl0FF5F4EbXwyszoZ1rYwmEnRCfsqWLRQ4Z5XOgZn1cj
        dbE9IAa50ArvrngvI3jxCKuLa5Zcjgs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-6fUrCzp1O0uikiq73T9giw-1; Mon, 09 Mar 2020 08:30:48 -0400
X-MC-Unique: 6fUrCzp1O0uikiq73T9giw-1
Received: by mail-wm1-f70.google.com with SMTP id v21so2401560wml.5
        for <linux-api@vger.kernel.org>; Mon, 09 Mar 2020 05:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uzsPQ+ZsiFXUNzM64RYqffPOnfhsKcEvaN4HId4EK8=;
        b=bbZSuTdqjdhS7/qoDmYYSIXqTTrJPpA5v1+vm93US4MO5IYM7p4WIh52W8L4PIpO5d
         9kfEar3n/9JS7xK7sPYvpjJHKurakV/Tt7RWtztoIELqSx5UiWnoyUhcqYj9VX/FuJ7/
         Zqg90bf9RdOkZlyyu0SUsLAaCQ88E3NUM5/0fZZFQaieK04EmfSNgkwrVPeiPhlRPe0i
         zmhB9ztfzNgwHMmazGtPRwM5CbQ2/R4BsEUm3Eo/0elArSKw+xDh/6hHWs7HdO9kyIZI
         Xo00WwUt2ix+PsmpuwhXk5qaZLhLxMtUaAnVe+t9PM4mGau0XFRsKK2akNwh/xTF2NS/
         i35A==
X-Gm-Message-State: ANhLgQ28Z0/gKnYuSPKH8NTgd0RI+a6sA1sdd8i6rpPjLb/HJZ+yufSN
        w7xTbwjkg4Q1NUaNOrWVXBRVnXv/0vhIFUp7O6MEfS32EoqScZFkxmfe6APz0k6r+T5UJ2WwqtF
        +OOo7V8rBjxfJPaFjlEJJ
X-Received: by 2002:adf:ef92:: with SMTP id d18mr20470461wro.193.1583757046852;
        Mon, 09 Mar 2020 05:30:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vujV46ctESl/MRhsNnLuJc5z1YddqftLU07svKg9hSa4UYTEJYDybn2Z8AShVV5pT5Snx8WxA==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr20470437wro.193.1583757046644;
        Mon, 09 Mar 2020 05:30:46 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c5sm9841274wma.3.2020.03.09.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 05:30:45 -0700 (PDT)
Date:   Mon, 9 Mar 2020 13:30:45 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
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
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
Subject: Re: [PATCH v7 6/7] mm/madvise: employ mmget_still_valid for write
 lock
Message-ID: <20200309123045.o4cwni3ra6zq6ha2@butterfly.localdomain>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-7-minchan@kernel.org>
 <d21c85b2-2493-e538-5419-79cf049a469e@suse.cz>
 <20200306130303.kztv64f52qknxb6k@butterfly.localdomain>
 <86fc8d7b-ad6b-1691-b022-025d01e9e8e3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fc8d7b-ad6b-1691-b022-025d01e9e8e3@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 06, 2020 at 05:03:50PM +0100, Vlastimil Babka wrote:
> On 3/6/20 2:03 PM, Oleksandr Natalenko wrote:
> > Hello.
> > 
> > On Fri, Mar 06, 2020 at 01:52:07PM +0100, Vlastimil Babka wrote:
> >> > diff --git a/mm/madvise.c b/mm/madvise.c
> >> > index e794367f681e..e77c6c1fad34 100644
> >> > --- a/mm/madvise.c
> >> > +++ b/mm/madvise.c
> >> > @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >> >  	if (write) {
> >> >  		if (down_write_killable(&mm->mmap_sem))
> >> >  			return -EINTR;
> >> > +		if (current->mm != mm && !mmget_still_valid(mm))
> >> > +			goto skip_mm;
> >> 
> >> This will return 0, is that correct? Shoudln't there be a similar error e.g. as
> >> when finding the task by pid fails (-ESRCH ?), because IIUC the task here is
> >> going away and dumping the core?
> > 
> > Yeah.
> > 
> > Something like this then:
> > 
> > ===
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 48d1da08c160..7ed2f4d13924 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1122,6 +1122,10 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >  	if (write) {
> >  		if (down_write_killable(&mm->mmap_sem))
> >  			return -EINTR;
> > +		if (current->mm != mm && !mmget_still_valid(mm)) {
> > +			error = -ESRCH;
> > +			goto skip_mm;
> > +		}
> >  	} else {
> >  		down_read(&mm->mmap_sem);
> >  	}
> > @@ -1173,6 +1177,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >  	}
> >  out:
> >  	blk_finish_plug(&plug);
> > +skip_mm:
> >  	if (write)
> >  		up_write(&mm->mmap_sem);
> >  	else
> > 
> > ===
> > 
> > ?
> 
> Yep, thanks.
> 

Minchan, shall you take this change into the next submission, or you'd
prefer me sending it to you as a new patch?

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

