Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB98159AF8
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 22:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgBKVLx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 16:11:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38686 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgBKVLx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 16:11:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so1796360pjz.3;
        Tue, 11 Feb 2020 13:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WxhnkY2cxQZj5jxzVikeFYowagiLDwBLR0VascuWbEM=;
        b=PncgprB0dgOZuy/V2ewP9FCKKY2DVqV8yYPqQy8TZPLgR6euCeeY3iEG2c41hmrpa0
         +17IrLVrON6RpCIbe6FQ7wRNBIwnAvh0lY1pW51T6WlSi/+LIiuiJxXU7TIB6MuQOlRp
         HH8T/3hWzhT+JzV3iMtFFtdEa51l74lDo1rR5WuOwIxR97jYhLYgITRKi6WRJGer53T3
         U2Xa5CCEFW+lEpfhCWBEaUGWFlaI6xkFj6mTtzEJVskDV9svQeNgJ/bVt9Bu6RIzJ2ay
         qWSpaI+SwG+7Hht/nfcV+jzi/MyQ31elch2YXLi2e5sRfY4QKlpzHh5/uNyOxA3QxUKZ
         fcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WxhnkY2cxQZj5jxzVikeFYowagiLDwBLR0VascuWbEM=;
        b=CzNB0UAV0yH6Wf4dAg3GHVbxVfD5Q96jEpRHtyJW5lRXhpKNobVWFNZnrpVrrJLa5F
         gTZpIU94WvZPH8QmFkGMtlVjoh0/RFsjRLzAp9sMC0bC/a02YH8ykyW8bnb9MNxZoXM0
         gDVTsDO6r07L2H2p93Ja02neSiv5z7OZ8qsY+krkjzptb3v+Ukrs3SzhbDqWyzeY72JS
         qQ31B6hbgWv2w0cCH6vBL0tfGhdZg662K9KqqxNRhl7Qhen0GBwsIXIthdoufGdFnE0H
         7ku61LsVlUSQCOgqhYaRunx8y0M5NJxbYYrdrVnDjCA3Vw1szjfuGzNJ6v1mY6z1yeLd
         L3rg==
X-Gm-Message-State: APjAAAU3q87JUa3Gsa/DlEBR8CA5sBoayrRbOgzzeafLClR0DhDPlLpJ
        KqV4HVuZ+rH6JEHlyK/MvYo=
X-Google-Smtp-Source: APXvYqx+Gl5TVxWLKV0U/vZkdyFvrWcSzDlyEjHaJ6KkOWlDhX8PBfkfPLw+6IOV5nTbFe4GwSpiDg==
X-Received: by 2002:a17:90a:fa94:: with SMTP id cu20mr5983429pjb.114.1581455512792;
        Tue, 11 Feb 2020 13:11:52 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id x4sm5278060pff.143.2020.02.11.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 13:11:51 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:11:49 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v3 5/5] mm: support both pid and pidfd for process_madvise
Message-ID: <20200211211149.GC185752@google.com>
References: <20200128001641.5086-1-minchan@kernel.org>
 <20200128001641.5086-6-minchan@kernel.org>
 <CAKgT0Ue9y=CL-f8xNXLo70nSk1wR_tG6TYXQUYpfk42PkHWeug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue9y=CL-f8xNXLo70nSk1wR_tG6TYXQUYpfk42PkHWeug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 10, 2020 at 03:12:52PM -0800, Alexander Duyck wrote:
> On Mon, Jan 27, 2020 at 4:17 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > There is a demand[1] to support pid as well pidfd for process_madvise
> > to reduce unncessary syscall to get pidfd if the user has control of
> > the targer process(ie, they could gaurantee the process is not gone
> > or pid is not reused. Or, it might be okay to give a hint to wrong
> > process).
> 
> It looks like you misspelled several items in here including
> "unnecessary", "target", and "guarantee".

Thanks, will fix it.

> 
> > This patch aims for supporting both options like waitid(2). So, the
> > syscall is currently,
> >
> >         int process_madvise(int which, pid_t pid, void *addr,
> >                 size_t length, int advise, unsigned long flag);
> >
> > @which is actually idtype_t for userspace libray and currently,
> > it supports P_PID and P_PIDFD.
> >
> > [1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  include/linux/pid.h      |  1 +
> >  include/linux/syscalls.h |  3 ++-
> >  kernel/exit.c            | 17 -----------------
> >  kernel/pid.c             | 17 +++++++++++++++++
> >  mm/madvise.c             | 34 ++++++++++++++++++++++------------
> >  5 files changed, 42 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > index 998ae7d24450..023d9c3a8edc 100644
> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
> >  struct file;
> >
> >  extern struct pid *pidfd_pid(const struct file *file);
> > +extern struct pid *pidfd_get_pid(unsigned int fd);
> >
> >  static inline struct pid *get_pid(struct pid *pid)
> >  {
> 
> So really this is two patches interleaved. You have the moving of the
> pidfd_get_pid function and the update of the syscall. Personally I
> would make the function move a separate patch and place it before you
> define the syscall and fold the syscall changes into your original
> patch.
> 
> Doing that you wouldn't have to worry about the syscall changing in
> behavior midway through a bisect. It would either be there or it
> wouldn't.

Will try it.
Thanks!
