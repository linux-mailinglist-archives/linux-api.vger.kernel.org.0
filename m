Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63137116B8F
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2019 11:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfLIK4T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Dec 2019 05:56:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38545 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLIK4T (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Dec 2019 05:56:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id i6so11135805edr.5
        for <linux-api@vger.kernel.org>; Mon, 09 Dec 2019 02:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHKMufWvY5eAKbkb+0diiYTKS0sDzXUNzkurR6gVDP4=;
        b=aLm5E/Yxb7RY4JHfv7D3m98UJpUq3pip3jCtUOdlCIQgbW0Xi7Ze8RF0V+oo8i09Mf
         0kCiFQ0zVuIOhFsbDD6o4VSM0LpxGxNiCSsQWDFUFLIYvCi4hWa0i392B48SCQNnOg+V
         EeyGTxO/9wUhJ2wBmEgCtTppuKiNA8VgVrTD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHKMufWvY5eAKbkb+0diiYTKS0sDzXUNzkurR6gVDP4=;
        b=PRltOspRiw/8uF9AhPtVsMV747II3RTHOI7W+4lcCR9A7yWQ0OnD0rpCNrwRHZiLrk
         QM6L7CVv2yleC07el2tSUblkT94IrxdypYZI+5C/gzBhNU/bJY4cqi8ZIrJCOc+39lju
         cAkSAB04KwrzWxOS1o8r3ud4JxkC5NBRGxsJyIUu6T3TEcV+QzVSUOBo46H6ES2EAM6q
         BXz0SXDCboM87Qevp5uxm0TPkHysAuBk4rPAOabmJ8He7QR7bw/H4NPXke49e0sVN6O9
         3JZQeVon9IgaF9hGUmSJrnC/0/7k+T1zKljZsa1Hy04fPPjXpfqRfxxMvqOEesvluchr
         Opvw==
X-Gm-Message-State: APjAAAULG5qVltuVJ156ziv56yTBupAYhqQ0MF+2Kfgp6Utz8qrZtw7w
        AJJcVnwKiiE3KDAdFeI5nLyDASFbqy/iUde5f6x4Mg==
X-Google-Smtp-Source: APXvYqwSdXcunMMadjOGmGaKyoo3V5GkFwyQEM1uxe20T8+vKT63bX1KLQoVBY5gwATVW0OULppj3w1PJhjYjcq4ooA=
X-Received: by 2002:a17:906:4943:: with SMTP id f3mr2524643ejt.122.1575888976218;
 Mon, 09 Dec 2019 02:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20191209070621.GA32450@ircssh-2.c.rugged-nimbus-611.internal> <20191209093944.g6lgt2cqkec7eaym@wittgenstein>
In-Reply-To: <20191209093944.g6lgt2cqkec7eaym@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 9 Dec 2019 02:55:40 -0800
Message-ID: <CAMp4zn8_CxB6C=4Myw7DrmWg5w3Qm+FwYVTQLnbCEBJXL4UKzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ptrace: add PTRACE_GETFD request to fetch file
 descriptors from tracees
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Jann Horn <jannh@google.com>, cyphar@cyphar.com,
        oleg@redhat.com, Andy Lutomirski <luto@amacapital.net>,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Dec 9, 2019 at 1:39 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Hey Sargun,
>
> Thanks for the patch!
Thanks for your review.

>
> Why not simply accept O_CLOEXEC as flag? If that's not possible for some
> reason I'd say
>
I did this initially. My plan is to use this options field for other
(future) things as well, like
clearing (cgroup) metadata on sockets (assuming we figure out a safe
way to do it).
If we use O_CLOEXEC, it takes up an arbitrary bit which is different
on different
platforms, and working around that seems messy

Another way around this would be to have two members. One member which
is something
like fdflags, that just takes the fd flags, like O_CLOEXEC, and then
later on, we can add
an options member to enable these future use cases.

What do you think?
> #define PTRACE_GETFD_O_CLOEXEC  O_CLOEXEC       /* open the fd with cloexec */
>
> is the right thing to do. This is fairly common:
>
> include/uapi/linux/timerfd.h:#define TFD_CLOEXEC O_CLOEXEC
> include/uapi/drm/drm.h:#define DRM_CLOEXEC O_CLOEXEC
> include/linux/userfaultfd_k.h:#define UFFD_CLOEXEC O_CLOEXEC
> include/linux/eventfd.h:#define EFD_CLOEXEC O_CLOEXEC
> include/uapi/linux/eventpoll.h:#define EPOLL_CLOEXEC O_CLOEXEC
> include/uapi/linux/inotify.h:/* For O_CLOEXEC and O_NONBLOCK */
> include/uapi/linux/inotify.h:#define IN_CLOEXEC O_CLOEXEC
> include/uapi/linux/mount.h:#define OPEN_TREE_CLOEXEC    O_CLOEXEC       /* Close the file on execve() */
>
> You can also add a compile-time assert to ptrace like we did for
> fs/namespace.c's OPEN_TREE_CLOEXEC:
>         BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
>
> And I'd remove the  _O if you go with a separate flag, i.e.:
>
> #define PTRACE_GETFD_CLOEXEC    O_CLOEXEC       /* open the fd with cloexec */
>
> > +
> > +struct ptrace_getfd_args {
> > +     __u32 fd;       /* the tracee's file descriptor to get */
> > +     __u32 options;
>
> Nit and I'm not set on it at all but "flags" might just be better.
>
> > +} __attribute__((packed));
>
> What's the benefit in using __attribute__((packed)) here? Seems to me that:
>
1) Are we always to assume that the compiler will give us 4-byte
alignment (paranoia)
2) If we're to add new non-4-byte aligned members later on, is it
kosher to add packed
later on?

> +struct ptrace_getfd_args {
> +       __u32 fd;       /* the tracee's file descriptor to get */
> +       __u32 options;
> +};
>
> would just work fine.
>
> > +
> >  /*
> >   * These values are stored in task->ptrace_message
> >   * by tracehook_report_syscall_* to describe the current syscall-stop.
> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index cb9ddcc08119..8f619dceac6f 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/cn_proc.h>
> >  #include <linux/compat.h>
> >  #include <linux/sched/signal.h>
> > +#include <linux/fdtable.h>
> >
> >  #include <asm/syscall.h>     /* for syscall_get_* */
> >
> > @@ -994,6 +995,33 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
> >  }
> >  #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
> >
> > +static int ptrace_getfd(struct task_struct *child, unsigned long user_size,
> > +                     void __user *datavp)
> > +{
> > +     struct ptrace_getfd_args args;
> > +     unsigned int fd_flags = 0;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     ret = copy_struct_from_user(&args, sizeof(args), datavp, user_size);
> > +     if (ret)
> > +             goto out;
>
> Why is this goto out and not just return ret?
>
> > +     if ((args.options & ~(PTRACE_GETFD_O_CLOEXEC)) != 0)
> > +             return -EINVAL;
> > +     if (args.options & PTRACE_GETFD_O_CLOEXEC)
> > +             fd_flags &= O_CLOEXEC;
> > +     file = get_task_file(child, args.fd);
> > +     if (!file)
> > +             return -EBADF;
> > +     ret = get_unused_fd_flags(fd_flags);
>
> Why isn't that whole thing just:
>
> ret = get_unused_fd_flags(fd_flags & {PTRACE_GETFD_}O_CLOEXEC);
>
> > +     if (ret >= 0)
> > +             fd_install(ret, file);
> > +     else
> > +             fput(file);
> > +out:
> > +     return ret;
> > +}
>
> So sm like:
>
> static int ptrace_getfd(struct task_struct *child, unsigned long user_size,
>                         void __user *datavp)
> {
>         struct ptrace_getfd_args args;
>         unsigned int fd_flags = 0;
>         struct file *file;
>         int ret;
>
>         ret = copy_struct_from_user(&args, sizeof(args), datavp, user_size);
>         if (ret)
>                 return ret;
>
>         if ((args.options & ~(PTRACE_GETFD_O_CLOEXEC)) != 0)
>                 return -EINVAL;
>
>         file = get_task_file(child, args.fd);
>         if (!file)
>                 return -EBADF;
>
>         /* PTRACE_GETFD_CLOEXEC == O_CLOEXEC */
>         ret = get_unused_fd_flags(fd_flags & PTRACE_GETFD_O_CLOEXEC);
Wouldn't this always be 0, since fd_flags is always 0?
>         if (ret >= 0)
>                 fd_install(ret, file);
>         else
>                 fput(file);
>
>         return ret;
> }
