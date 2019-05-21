Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839B524621
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 04:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEUCzm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 22:55:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39181 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfEUCzl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 May 2019 22:55:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so7657119plm.6;
        Mon, 20 May 2019 19:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZunHuUt7tyDrtFDeA5ZZ4ZwMnBTbuylcZfIETnEBPY=;
        b=EOkHN4OYXvIcl19VnDzQjUPREoQsG7FBD4IBtQZtxzWPHk38JIQSjSWEvQMNxOJ+dp
         0ygx7a3pBalvb/lz54klCwYUBBz7oL514HFPEuZmiyXOowZHoDmICshvgmGDNSJ/+t3M
         tvx6A4ge8kP+b7x+SV623eINdLfOZTTHTkLVv3NTXLPIHjrsKkZoufRQiC6qjodZ4D7l
         rGmiMG5iVRZP4e6noFyPH5Ou6AAb6YjBieeln98a0UTh834R1hHzohKoXbP0RmQ7fDvQ
         yu1HklXowvWr0APRyqramMkyyUKsLteDgM3RTpYFiSlnJ1Lg7L4n2Zf+B77ypVToW8bA
         E7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZunHuUt7tyDrtFDeA5ZZ4ZwMnBTbuylcZfIETnEBPY=;
        b=Zw9d1Z7r9zK+riyeN1kplyzo3oZ1jxEg6CjvjkjVD9hSad2jg3NOnJQbRlK+lRD3Zb
         uM8XgnGIsHu+mTtAaB9M6EN6Ksa4XP6LU9mW+1uJ9LgaVe02RaQogkRROa9DCp2TKzXp
         Fmh/sPldvPZeucoO/nBgMUNQ2X/tGGtU647nMj+rb2nv/NXZGodUlFwOXl+zLn6a3lQr
         njpFhR+EaxQ6adQHPis+i1s9995kNZTfssqPLqjj4iWSs70KfMXrxqFNPRAFxKeNkQWQ
         /2T0V9oq/5h6uwQ2U3+uX04qawQHVt0vtQ1aPBmLKWL2BIuBXZaz3jfAVypeHGBLMTR5
         iXgg==
X-Gm-Message-State: APjAAAW4KKld3z0vb7Gl+wWZ3OsWrXeSOqhla/sXHYlTODC4sPmd5hwD
        rh/+KXqTfAlalXlIB1wr+xk=
X-Google-Smtp-Source: APXvYqzexWksuHBaFUEP7NSQz3gDQbJO+ELyIYn0MhPdSdkSdsBy0GUOBt75NltTcpChWbSJjMxU0g==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr81923421plb.280.1558407340615;
        Mon, 20 May 2019 19:55:40 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id a69sm49600003pfa.81.2019.05.20.19.55.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 19:55:38 -0700 (PDT)
Date:   Tue, 21 May 2019 11:55:33 +0900
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
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190521025533.GH10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520092801.GA6836@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 20, 2019 at 11:28:01AM +0200, Michal Hocko wrote:
> [cc linux-api]
> 
> On Mon 20-05-19 12:52:54, Minchan Kim wrote:
> > System could have much faster swap device like zRAM. In that case, swapping
> > is extremely cheaper than file-IO on the low-end storage.
> > In this configuration, userspace could handle different strategy for each
> > kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
> > while it keeps file-backed pages in inactive LRU by MADV_COOL because
> > file IO is more expensive in this case so want to keep them in memory
> > until memory pressure happens.
> > 
> > To support such strategy easier, this patch introduces
> > MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
> > that /proc/<pid>/clear_refs already has supported same filters.
> > They are filters could be Ored with other existing hints using top two bits
> > of (int behavior).
> 
> madvise operates on top of ranges and it is quite trivial to do the
> filtering from the userspace so why do we need any additional filtering?
> 
> > Once either of them is set, the hint could affect only the interested vma
> > either anonymous or file-backed.
> > 
> > With that, user could call a process_madvise syscall simply with a entire
> > range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> > MADV_FILE_FILTER so there is no need to call the syscall range by range.
> 
> OK, so here is the reason you want that. The immediate question is why
> cannot the monitor do the filtering from the userspace. Slightly more
> work, all right, but less of an API to expose and that itself is a
> strong argument against.

What I should do if we don't have such filter option is to enumerate all of
vma via /proc/<pid>/maps and then parse every ranges and inode from string,
which would be painful for 2000+ vmas.

> 
> > * from v1r2
> >   * use consistent check with clear_refs to identify anon/file vma - surenb
> > 
> > * from v1r1
> >   * use naming "filter" for new madvise option - dancol
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  include/uapi/asm-generic/mman-common.h |  5 +++++
> >  mm/madvise.c                           | 14 ++++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> > index b8e230de84a6..be59a1b90284 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -66,6 +66,11 @@
> >  #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
> >  #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
> >  
> > +#define MADV_BEHAVIOR_MASK (~(MADV_ANONYMOUS_FILTER|MADV_FILE_FILTER))
> > +
> > +#define MADV_ANONYMOUS_FILTER	(1<<31)	/* works for only anonymous vma */
> > +#define MADV_FILE_FILTER	(1<<30)	/* works for only file-backed vma */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE	0
> >  
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index f4f569dac2bd..116131243540 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1002,7 +1002,15 @@ static int madvise_core(struct task_struct *tsk, unsigned long start,
> >  	int write;
> >  	size_t len;
> >  	struct blk_plug plug;
> > +	bool anon_only, file_only;
> >  
> > +	anon_only = behavior & MADV_ANONYMOUS_FILTER;
> > +	file_only = behavior & MADV_FILE_FILTER;
> > +
> > +	if (anon_only && file_only)
> > +		return error;
> > +
> > +	behavior = behavior & MADV_BEHAVIOR_MASK;
> >  	if (!madvise_behavior_valid(behavior))
> >  		return error;
> >  
> > @@ -1067,12 +1075,18 @@ static int madvise_core(struct task_struct *tsk, unsigned long start,
> >  		if (end < tmp)
> >  			tmp = end;
> >  
> > +		if (anon_only && vma->vm_file)
> > +			goto next;
> > +		if (file_only && !vma->vm_file)
> > +			goto next;
> > +
> >  		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> >  		error = madvise_vma(tsk, vma, &prev, start, tmp,
> >  					behavior, &pages);
> >  		if (error)
> >  			goto out;
> >  		*nr_pages += pages;
> > +next:
> >  		start = tmp;
> >  		if (prev && start < prev->vm_end)
> >  			start = prev->vm_end;
> > -- 
> > 2.21.0.1020.gf2820cf01a-goog
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
