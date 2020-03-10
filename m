Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A80180B8A
	for <lists+linux-api@lfdr.de>; Tue, 10 Mar 2020 23:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJW2U (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Mar 2020 18:28:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45835 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgCJW2U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Mar 2020 18:28:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id m15so52471pgv.12;
        Tue, 10 Mar 2020 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VFg3q0grHf1UJPJBnQv+kbuTClZa3VwGIYfaQUbxb0M=;
        b=RwSdSfQXspQhwN8CTBXVxGFwOeubmgD36ZRj+zPgQ5bDLNVgBhJn0KKdKUubjIr/4z
         WWnYDKwHju68X14pD0oqQD0ZThVwXSlA2ITsaotTEfuUi6wxYEtOKV6z5Tl1Dqy9PRXA
         5s143nTEfkJln7Jy6/OrTGAg7ecTOBOGBGSnsXiyNOI7b6z1Gc922x7Bj4onH4f5CFuT
         +u5JYJbv7Fvl7HlRDGabTULLfxxiQ+t/jbgFv9PojrfZONVgPuz+k/rY1sjguzbn8W12
         KKaH26PRG0TbZSKYDkCvoYqu9jaA0ZjKvhgjvPXUoTIcN3H4Q8l1rqqIFc17w5RK/qKF
         4v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VFg3q0grHf1UJPJBnQv+kbuTClZa3VwGIYfaQUbxb0M=;
        b=fQjoCaqoSuA+265eZ2SIzyEb3wVyuvNGTiXYMSU5LvOUR/1VPEJqjL36/orXymYHWn
         4tj4g8PMIkiF4BTZVySTCleA4zC5gJT0bNpoIVHPinWpEyDfya4+GvQb60+lWmtNchAg
         sKZTf55sNT9+VDZz33LWGDOccdbAtmEIXvVVPvk7WkgcqbJ7ezkQE4fAIq4whGm0wpqn
         oeyyRcF+AVtfeVnKzjX90hfoqJWs600i4MaY1SIwrjXGuZ058ojLPUhQsT98GwzZFV+E
         d8tvd9XdIcje1GDM4gZ30kLzQrIsYoHd1y77Ky+U1Dfs/0bhe3Bn6Fuap/WsoVbRbPBF
         uhjg==
X-Gm-Message-State: ANhLgQ2ZaLpjPFW3dc4BYBk3h6/JjfLCbKOFaj8sHurI95nH0fRdYgB0
        vxUfFSrMm999zqcrp46GlvA=
X-Google-Smtp-Source: ADFU+vsH6xyex3g3JYae9c8u5H/eF0+Q/hnTxWXi2RQIsrRas5S/3RLdKPogUdLuQvtAajmbzJqVPA==
X-Received: by 2002:a63:2e49:: with SMTP id u70mr22485024pgu.202.1583879297724;
        Tue, 10 Mar 2020 15:28:17 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id q15sm12160875pgn.68.2020.03.10.15.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 15:28:16 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:28:15 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
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
Message-ID: <20200310222815.GD72963@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-7-minchan@kernel.org>
 <d21c85b2-2493-e538-5419-79cf049a469e@suse.cz>
 <20200306130303.kztv64f52qknxb6k@butterfly.localdomain>
 <86fc8d7b-ad6b-1691-b022-025d01e9e8e3@suse.cz>
 <20200309123045.o4cwni3ra6zq6ha2@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309123045.o4cwni3ra6zq6ha2@butterfly.localdomain>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 09, 2020 at 01:30:45PM +0100, Oleksandr Natalenko wrote:
> On Fri, Mar 06, 2020 at 05:03:50PM +0100, Vlastimil Babka wrote:
> > On 3/6/20 2:03 PM, Oleksandr Natalenko wrote:
> > > Hello.
> > > 
> > > On Fri, Mar 06, 2020 at 01:52:07PM +0100, Vlastimil Babka wrote:
> > >> > diff --git a/mm/madvise.c b/mm/madvise.c
> > >> > index e794367f681e..e77c6c1fad34 100644
> > >> > --- a/mm/madvise.c
> > >> > +++ b/mm/madvise.c
> > >> > @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> > >> >  	if (write) {
> > >> >  		if (down_write_killable(&mm->mmap_sem))
> > >> >  			return -EINTR;
> > >> > +		if (current->mm != mm && !mmget_still_valid(mm))
> > >> > +			goto skip_mm;
> > >> 
> > >> This will return 0, is that correct? Shoudln't there be a similar error e.g. as
> > >> when finding the task by pid fails (-ESRCH ?), because IIUC the task here is
> > >> going away and dumping the core?
> > > 
> > > Yeah.
> > > 
> > > Something like this then:
> > > 
> > > ===
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 48d1da08c160..7ed2f4d13924 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1122,6 +1122,10 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> > >  	if (write) {
> > >  		if (down_write_killable(&mm->mmap_sem))
> > >  			return -EINTR;
> > > +		if (current->mm != mm && !mmget_still_valid(mm)) {
> > > +			error = -ESRCH;
> > > +			goto skip_mm;
> > > +		}
> > >  	} else {
> > >  		down_read(&mm->mmap_sem);
> > >  	}
> > > @@ -1173,6 +1177,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> > >  	}
> > >  out:
> > >  	blk_finish_plug(&plug);
> > > +skip_mm:
> > >  	if (write)
> > >  		up_write(&mm->mmap_sem);
> > >  	else
> > > 
> > > ===
> > > 
> > > ?
> > 
> > Yep, thanks.
> > 
> 
> Minchan, shall you take this change into the next submission, or you'd
> prefer me sending it to you as a new patch?

I should send patchset again so I will take it.
Thanks!
