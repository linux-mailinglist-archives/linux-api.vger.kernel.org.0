Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A2A17BD7A
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 14:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCFNDJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 08:03:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21114 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726891AbgCFNDJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Mar 2020 08:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583499788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AeNZCzKp4mmhDEQbTbjcCIj/A6BgEDT9MrAVKVagARs=;
        b=HGbxSKDOJsKgfkbZV2frfF4pRwQuVPUu6c7t+cPgmTb4ozTpwyTTi3EHjeAqLbCCqaCADu
        fvsekQ5n8rOMFVBGO8aIPNF87E0YtLxxXxJ9vlmlX0937vEMf8jWy+w+oRYtdVCvnz09QB
        tSP0wYNfFbhhNI7H3NAc1jtsdJpfra8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-IvwVmUkSM46_yUVlGIYdew-1; Fri, 06 Mar 2020 08:03:07 -0500
X-MC-Unique: IvwVmUkSM46_yUVlGIYdew-1
Received: by mail-wr1-f69.google.com with SMTP id b12so975177wro.4
        for <linux-api@vger.kernel.org>; Fri, 06 Mar 2020 05:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AeNZCzKp4mmhDEQbTbjcCIj/A6BgEDT9MrAVKVagARs=;
        b=jIg9BcLT57mz+u1MnDrAoeVUglQXxU9VSZEF7VHM1agiGmG7v2fVI79WxN8g2X7XbV
         ybNnu8yyzECTBYpF4Ja08+e1kXYajo7hjX8T5Fe/Obm4rtqKDzHizLpiKeVmla1WFJZW
         qdofKoiM9lpB/9SkmzUlxdoCyRey2r5EqV8SnGogXFUmMNSmODbJHRL+MgllZOjawrNo
         09Ov6dK8sJR1UEUfueYQwHyEJKUu2eqFdtVcYqZlqbZLd4dxNF2Fa5f9pa007TWHziTp
         3Z7HFHFAIl03E8PaqDAGbHi1Ecqfm+iMFlsd9giU9Z/JnFGDHaiXv+lTYmMolqbR+jop
         NARQ==
X-Gm-Message-State: ANhLgQ2NMswlQXv/MggiSY1EkDu530L8wIFvLXVFr/0TEe3AXkwb6qOO
        RqKPBI612urbGTtuN+8EjNKHLNEG+cN/3vKKQlWQ25W25LEdvEY/t/LLuMUw8rihEvNqmsW/mOV
        HGocv1dnDs2y3a445YlNn
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr3898420wmc.139.1583499785757;
        Fri, 06 Mar 2020 05:03:05 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvEnwGXyafS3KsWnNfbGv3ywCKKxQujnkoCIP1TlH3Tk+PhNccmC+8J7KvT/3Xm1mYySmUIUA==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr3898394wmc.139.1583499785507;
        Fri, 06 Mar 2020 05:03:05 -0800 (PST)
Received: from localhost ([2001:470:5b39:28:1273:be38:bc73:5c36])
        by smtp.gmail.com with ESMTPSA id u8sm4029986wrn.69.2020.03.06.05.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:03:03 -0800 (PST)
Date:   Fri, 6 Mar 2020 14:03:03 +0100
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
Message-ID: <20200306130303.kztv64f52qknxb6k@butterfly.localdomain>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-7-minchan@kernel.org>
 <d21c85b2-2493-e538-5419-79cf049a469e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21c85b2-2493-e538-5419-79cf049a469e@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello.

On Fri, Mar 06, 2020 at 01:52:07PM +0100, Vlastimil Babka wrote:
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index e794367f681e..e77c6c1fad34 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >  	if (write) {
> >  		if (down_write_killable(&mm->mmap_sem))
> >  			return -EINTR;
> > +		if (current->mm != mm && !mmget_still_valid(mm))
> > +			goto skip_mm;
> 
> This will return 0, is that correct? Shoudln't there be a similar error e.g. as
> when finding the task by pid fails (-ESRCH ?), because IIUC the task here is
> going away and dumping the core?

Yeah.

Something like this then:

===
diff --git a/mm/madvise.c b/mm/madvise.c
index 48d1da08c160..7ed2f4d13924 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1122,6 +1122,10 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 	if (write) {
 		if (down_write_killable(&mm->mmap_sem))
 			return -EINTR;
+		if (current->mm != mm && !mmget_still_valid(mm)) {
+			error = -ESRCH;
+			goto skip_mm;
+		}
 	} else {
 		down_read(&mm->mmap_sem);
 	}
@@ -1173,6 +1177,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 	}
 out:
 	blk_finish_plug(&plug);
+skip_mm:
 	if (write)
 		up_write(&mm->mmap_sem);
 	else

===

?

> 
> >  	} else {
> >  		down_read(&mm->mmap_sem);
> >  	}
> > @@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >  	}
> >  out:
> >  	blk_finish_plug(&plug);
> > +skip_mm:
> >  	if (write)
> >  		up_write(&mm->mmap_sem);
> >  	else
> > 
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

