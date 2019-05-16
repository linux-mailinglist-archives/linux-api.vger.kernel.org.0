Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DA520C98
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEPQKM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 12:10:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45637 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEPQKL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 12:10:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id t24so3904448otl.12
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 09:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bMHMBrMd0YNkJT0fsHTTWNRBFmrV68S4uDG6Stq2kXM=;
        b=oQIJnd3cJFOTGWU+mhqQw5xZ/48tAUVBLW2xsdnHW75CFgSaesak+3DGKJkRVnnlf5
         f7vp8/QSuZL0RRyYca0jxJkcPCNSvi7RRnbKm5rO4uvFQinoZkfWxKegO3545xUKi6Tm
         yDlWfRiGkBs9X7KKIzePsKsJBYU4Mhp9dgLaLpepquR4TXbJgz+SyjP4Cb13IfAyCjJc
         yGAprbbVJ9x317dpUPRsbFj1RHmcJ2iqPoNfYLSKY45Sx4cye8fqfTTAzGmIRMznduug
         6Zyh7c9l0qYmroDn3xiUT/EZlGqq0eanNec/JAobiVm74MfwZM1Br1PUonCZzlOV+vwq
         1QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bMHMBrMd0YNkJT0fsHTTWNRBFmrV68S4uDG6Stq2kXM=;
        b=hXHNXrSZf52l0iilvnlDmHvvQzwxpPfs75cW3yb0JZP490V9fcVTIGdmo1c+FdL7u1
         4WRySN0TgELxB7l/1C5AOO+rMRtxTSxuYt8dquLD/SNXQce4T7I1J99nsQp/ryevNk0G
         qBPkR395MyrI6NBnkPPtnlpA7vUGRGhkYd8mQ8I/LW3B4H0kOigLtD04dQAnkZJoZ9HT
         eDW3VuCkBUw+XoY+DbRkvulsoKhufqBxqnWFz7e9k37Kfvx/QgTT3Sq409wLfFr0fJF3
         6dbF1xomJL3I17MLQCrZLc7Flk2aFYz88Y3CUyCmPwuoPYL8ShfbGR/1mZu7sV0L4dXP
         MExA==
X-Gm-Message-State: APjAAAV3wEk/RA5lGmfELUSfiaz8HK6Y9pphn/w/p02KIiq5+57YN5Jt
        2ycF7fv4j2BWtTSmIfFZKQVG3Le7rR8Qw45XmLE3OA==
X-Google-Smtp-Source: APXvYqxWTgXDP+q+BEeyCjiZ3kodMX94OZctQK+ZcHZRSQLNXJRMtNIbRJ4iu9fxZKt8FJF85O7xJzJohWCE0aKFlNM=
X-Received: by 2002:a9d:7347:: with SMTP id l7mr6367258otk.183.1558023010974;
 Thu, 16 May 2019 09:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190516094234.9116-1-oleksandr@redhat.com> <20190516094234.9116-5-oleksandr@redhat.com>
 <CAG48ez2yXw_PJXO-mS=Qw5rkLpG6zDPd0saMhhGk09-du2bpaA@mail.gmail.com>
 <20190516142013.sf2vitmksvbkb33f@butterfly.localdomain> <20190516144323.pzkvs6hapf3czorz@butterfly.localdomain>
In-Reply-To: <20190516144323.pzkvs6hapf3czorz@butterfly.localdomain>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 May 2019 18:09:44 +0200
Message-ID: <CAG48ez0-ytaDNVa7TiMaa4nR-nMEh_ZgND-sXjiw+RzZFmMqhw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/5] mm/ksm, proc: introduce remote merge
To:     Oleksandr Natalenko <oleksandr@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 16, 2019 at 4:43 PM Oleksandr Natalenko
<oleksandr@redhat.com> wrote:
> On Thu, May 16, 2019 at 04:20:13PM +0200, Oleksandr Natalenko wrote:
> > > [...]
> > > > @@ -2960,15 +2962,63 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
> > > >  static ssize_t madvise_write(struct file *file, const char __user *buf,
> > > >                 size_t count, loff_t *ppos)
> > > >  {
> > > > +       /* For now, only KSM hints are implemented */
> > > > +#ifdef CONFIG_KSM
> > > > +       char buffer[PROC_NUMBUF];
> > > > +       int behaviour;
> > > >         struct task_struct *task;
> > > > +       struct mm_struct *mm;
> > > > +       int err = 0;
> > > > +       struct vm_area_struct *vma;
> > > > +
> > > > +       memset(buffer, 0, sizeof(buffer));
> > > > +       if (count > sizeof(buffer) - 1)
> > > > +               count = sizeof(buffer) - 1;
> > > > +       if (copy_from_user(buffer, buf, count))
> > > > +               return -EFAULT;
> > > > +
> > > > +       if (!memcmp("merge", buffer, min(sizeof("merge")-1, count)))
> > >
> > > This means that you also match on something like "mergeblah". Just use strcmp().
> >
> > I agree. Just to make it more interesting I must say that
> >
> >    /sys/kernel/mm/transparent_hugepage/enabled
> >
> > uses memcmp in the very same way, and thus echoing "alwaysssss" or
> > "madviseeee" works perfectly there, and it was like that from the very
> > beginning, it seems. Should we fix it, or it became (zomg) a public API?
>
> Actually, maybe, the reason for using memcmp is to handle "echo"
> properly: by default it puts a newline character at the end, so if we use
> just strcmp, echo should be called with -n, otherwise strcmp won't match
> the string.
>
> Huh?

Ah, yes, other code like e.g. proc_setgroups_write() uses strncmp()
and then has an extra check to make sure everything trailing is
whitespace.
