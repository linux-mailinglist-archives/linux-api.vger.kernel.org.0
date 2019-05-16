Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C442095E
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfEPOUR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 10:20:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43528 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfEPOUR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 10:20:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so3592785wro.10
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 07:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ctvVQmdp/+3DlTEoEjBJpR8lgxdRXW/8ilCZfl4pfR8=;
        b=a5SoWclJAp2V6GYH2DfnjDz4nJ8XiTIbWUm/Efp/nkg+bddXiGl4EfRtjIqmqYjACj
         97tkYPAir305NuDR/bbwV5PvR2DUDjkoV+GHe6CH116J1HNvvMc2/5P+NXRgd9OZYe9z
         KyZ1K6S2INABG8nBI7ghZ1S6K5Cc399j9RsoUgUh+Zx5hIyjvtR1/UA7YvyRhBdNDanP
         A4mW4Rf5cUAiHMgWRL7DXMCJp4mQPeOqLLUQrpapDRlXhpiTUDjHPpMLjl1ZRTb6ZgRH
         sJL+OL+/QYScFdscmyv7XYvfcvAeyaAHwpLRuv9xe6u1Z+tUAk97ZyBA8R9A2vVRheUo
         TVoQ==
X-Gm-Message-State: APjAAAUbTTXNfuasln/g1lDRgyD0n9178lIb7AwI3TmFBzK1Y78Ax7sS
        kcjnRzWqA5dHX2MWLBXWC12GEA==
X-Google-Smtp-Source: APXvYqy0dFWLfD16rJATaEZWOpkMhoKfQ9XY0KhSeaf4XlwLXJ5jVr6Y8jqArL2niVKWl9/+M+mu1Q==
X-Received: by 2002:a5d:434c:: with SMTP id u12mr5534937wrr.92.1558016415071;
        Thu, 16 May 2019 07:20:15 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w13sm9370113wmk.0.2019.05.16.07.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 07:20:13 -0700 (PDT)
Date:   Thu, 16 May 2019 16:20:13 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
Message-ID: <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain>
References: <20190516094234.9116-1-oleksandr@redhat.com>
 <20190516094234.9116-5-oleksandr@redhat.com>
 <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi.

On Thu, May 16, 2019 at 12:00:24PM +0200, Jann Horn wrote:
> On Thu, May 16, 2019 at 11:43 AM Oleksandr Natalenko
> <oleksandr@redhat.com> wrote:
> > Use previously introduced remote madvise knob to mark task's
> > anonymous memory as mergeable.
> >
> > To force merging task's VMAs, "merge" hint is used:
> >
> >    # echo merge > /proc/<pid>/madvise
> >
> > Force unmerging is done similarly:
> >
> >    # echo unmerge > /proc/<pid>/madvise
> >
> > To achieve this, previously introduced ksm_madvise_*() helpers
> > are used.
> 
> Why does this not require PTRACE_MODE_ATTACH_FSCREDS to the target
> process? Enabling KSM on another process is hazardous because it
> significantly increases the attack surface for side channels.
> 
> (Note that if you change this to require PTRACE_MODE_ATTACH_FSCREDS,
> you'll want to use mm_access() in the ->open handler and drop the mm
> in ->release. mm_access() from a ->write handler is not permitted.)

Sounds reasonable. So, something similar to what mem_open() & friends do
now:

static int madvise_open(...)
...
	struct task_struct *task = get_proc_task(inode);
...
	if (task) {
		mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
		put_task_struct(task);
		if (!IS_ERR_OR_NULL(mm)) {
			mmgrab(mm);
			mmput(mm);
...

Then:

static ssize_t madvise_write(...)
...
	if (!mmget_not_zero(mm))
		goto out;

	down_write(&mm->mmap_sem);
	if (!mmget_still_valid(mm))
		goto skip_mm;
...
skip_mm:
	up_write(&mm->mmap_sem);

	mmput(mm);
out:
	return ...;

And, finally:

static int madvise_release(...)
...
		mmdrop(mm);
...

Right?

> [...]
> > @@ -2960,15 +2962,63 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
> >  static ssize_t madvise_write(struct file *file, const char __user *buf,
> >                 size_t count, loff_t *ppos)
> >  {
> > +       /* For now, only KSM hints are implemented */
> > +#ifdef CONFIG_KSM
> > +       char buffer[PROC_NUMBUF];
> > +       int behaviour;
> >         struct task_struct *task;
> > +       struct mm_struct *mm;
> > +       int err = 0;
> > +       struct vm_area_struct *vma;
> > +
> > +       memset(buffer, 0, sizeof(buffer));
> > +       if (count > sizeof(buffer) - 1)
> > +               count = sizeof(buffer) - 1;
> > +       if (copy_from_user(buffer, buf, count))
> > +               return -EFAULT;
> > +
> > +       if (!memcmp("merge", buffer, min(sizeof("merge")-1, count)))
> 
> This means that you also match on something like "mergeblah". Just use strcmp().

I agree. Just to make it more interesting I must say that

   /sys/kernel/mm/transparent_hugepage/enabled

uses memcmp in the very same way, and thus echoing "alwaysssss" or
"madviseeee" works perfectly there, and it was like that from the very
beginning, it seems. Should we fix it, or it became (zomg) a public API?

> > +               behaviour = MADV_MERGEABLE;
> > +       else if (!memcmp("unmerge", buffer, min(sizeof("unmerge")-1, count)))
> > +               behaviour = MADV_UNMERGEABLE;
> > +       else
> > +               return -EINVAL;
> >
> >         task = get_proc_task(file_inode(file));
> >         if (!task)
> >                 return -ESRCH;
> >
> > +       mm = get_task_mm(task);
> > +       if (!mm) {
> > +               err = -EINVAL;
> > +               goto out_put_task_struct;
> > +       }
> > +
> > +       down_write(&mm->mmap_sem);
> 
> Should a check for mmget_still_valid(mm) be inserted here? See commit
> 04f5866e41fb70690e28397487d8bd8eea7d712a.

Yeah, it seems so :/. Thanks for the pointer. I've put it into the
madvise_write snippet above.

> > +       switch (behaviour) {
> > +       case MADV_MERGEABLE:
> > +       case MADV_UNMERGEABLE:
> 
> This switch isn't actually necessary at this point, right?

Yup, but it is there to highlight a possibility of adding other, non-KSM
options. So, let it be, and I'll just re-arrange CONFIG_KSM ifdef
instead.

Thank you.

> > +               vma = mm->mmap;
> > +               while (vma) {
> > +                       if (behaviour == MADV_MERGEABLE)
> > +                               ksm_madvise_merge(vma->vm_mm, vma, &vma->vm_flags);
> > +                       else
> > +                               ksm_madvise_unmerge(vma, vma->vm_start, vma->vm_end, &vma->vm_flags);
> > +                       vma = vma->vm_next;
> > +               }
> > +               break;
> > +       }
> > +       up_write(&mm->mmap_sem);
> > +
> > +       mmput(mm);
> > +
> > +out_put_task_struct:
> >         put_task_struct(task);
> >
> > -       return count;
> > +       return err ? err : count;
> > +#else
> > +       return -EINVAL;
> > +#endif /* CONFIG_KSM */
> >  }

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
