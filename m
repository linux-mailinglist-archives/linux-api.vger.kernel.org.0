Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEB51E1BA2
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2020 08:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgEZG75 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 May 2020 02:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgEZG74 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 May 2020 02:59:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB49C061A0E
        for <linux-api@vger.kernel.org>; Mon, 25 May 2020 23:59:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id se13so22579839ejb.9
        for <linux-api@vger.kernel.org>; Mon, 25 May 2020 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jwUwNbR5CqkZfKXp34MLLr2FdLANCXsmldjRmcZbcAY=;
        b=IMtvqyNCddHdr+Dg+hG8KQcXr84JmNxxVimpszlEfUHrcjBDVoDh3Gvy9ORJbxEgV0
         vZea+oDkn72s0xoPFO4YOowXE9LgGhrgQ3WpNcxKR/0ui1LiB/AQUz74OPqDFogZYq8J
         0hihwxkFMa3ny3Gt0tpDDjn2bRZAeYr4bxIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jwUwNbR5CqkZfKXp34MLLr2FdLANCXsmldjRmcZbcAY=;
        b=etvTIYvjGlndWSnF4+R+o2DHUjkSMWkMjzW5T1NGhSHKyp88RuYZYu5lNvKGBUw+Ig
         yEUZPNQwBvnIHg8jtWfqAHRNPESh5jV8YClsMKYCa1OE1QBpUGCw4pfVCKxGYVpA7BpR
         +9egnj6/MPceVCFcptyNGye9MPhJQDHGBQ9VEOfvz5JYCi3MmpGyvuqZFH+2JzMyt58J
         1Csl5BthWqQ+YPdgCyL1xom+J0KgNmgc8XiaQpTGo1u5G9hcnd7DJVXJ9bqeFlfKhU3L
         DoxW/10wZR+q9JlhORxTXZF9yP/SUI5qlf291CkkHjubvc7PFn4Lubp9Q2ikK9hDE307
         Kx0Q==
X-Gm-Message-State: AOAM530DC1BDDRGcXc5flRt8+l5NTc+xu9klk+A65ppm2bhyb0Zhxr3m
        O/GNQ2bofwhZrTIErSSLpPURo/VrmvbePCYyWHbxSQ==
X-Google-Smtp-Source: ABdhPJwxwYXyVJmHG/mBlM95egzgq1256tHggH/W1/HazYAUXo1fUH/qtznxqLmrJKAy22W9wsdBT9FmIbAjY9XPzaI=
X-Received: by 2002:a17:907:1002:: with SMTP id ox2mr20982901ejb.189.1590476394778;
 Mon, 25 May 2020 23:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200524233942.8702-1-sargun@sargun.me> <20200524233942.8702-3-sargun@sargun.me>
 <20200525135036.vp2nmmx42y7dfznf@wittgenstein>
In-Reply-To: <20200525135036.vp2nmmx42y7dfznf@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 25 May 2020 23:59:18 -0700
Message-ID: <CAMp4zn9b_o+LS3U9KcNvvJS5hroPS=3oRMSVuN=VgbwbXB=mKg@mail.gmail.com>
Subject: Re: [PATCH 2/5] seccomp: Introduce addfd ioctl to seccomp user notifier
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Jann Horn <jannh@google.com>, Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 25, 2020 at 6:50 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sun, May 24, 2020 at 04:39:39PM -0700, Sargun Dhillon wrote:
> > This adds a seccomp notifier ioctl which allows for the listener to "add"
> > file descriptors to a process which originated a seccomp user
> > notification. This allows calls like mount, and mknod to be "implemented",
> > as the return value, and the arguments are data in memory. On the other
> > hand, calls like connect can be "implemented" using pidfd_getfd.
> >
> > Unfortunately, there are calls which return file descriptors, like
> > open, which are vulnerable to TOC-TOU attacks, and require that the
> > more privileged supervisor can inspect the argument, and perform the
> > syscall on behalf of the process generating the notifiation. This
> > allows the file descriptor generated from that open call to be
> > returned to the calling process.
> >
> > In addition, there is funcitonality to allow for replacement of
> > specific file descriptors, following dup2-like semantics.
> >
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Suggested-by: Matt Denton <mpdenton@google.com>
> > Cc: Kees Cook <keescook@google.com>,
> > Cc: Jann Horn <jannh@google.com>,
> > Cc: Robert Sesek <rsesek@google.com>,
> > Cc: Chris Palmer <palmer@google.com>
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Tycho Andersen <tycho@tycho.ws>
> > ---
> >  include/uapi/linux/seccomp.h |  25 ++++++
> >  kernel/seccomp.c             | 169 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 193 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index c1735455bc53..7d450a9e4c29 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -113,6 +113,27 @@ struct seccomp_notif_resp {
> >       __u32 flags;
> >  };
> >
> > +/* valid flags for seccomp_notif_addfd */
> > +#define SECCOMP_ADDFD_FLAG_SETFD     (1UL << 0) /* Specify remote fd */
> > +
> > +/**
> > + * struct seccomp_notif_addfd
> > + * @size: The size of the seccomp_notif_addfd datastructure
> > + * @fd: The local fd number
> > + * @id: The ID of the seccomp notification
> > + * @fd_flags: Flags the remote FD should be allocated under
> > + * @remote_fd: Optional remote FD number if SETFD option is set, otherwise 0.
> > + * @flags: SECCOMP_ADDFD_FLAG_*
> > + */
> > +struct seccomp_notif_addfd {
> > +     __u32 size;
> > +     __u32 fd;
> > +     __u64 id;
> > +     __u32 fd_flags;
> > +     __u32 remote_fd;
> > +     __u64 flags;
> > +};
>
> This was a little confusing to me at first. So fd is the fd from which
> we take the struct file and remote_fd is either -1 at which point we
> just allocate the next free fd number and if it is not we
> allocate/replace a specific one. Maybe it would be clearer if we did:
>
> struct seccomp_notif_addfd {
>         __u32 size;
>         __u64 id;
>         __u64 flags;
>         __u32 srcfd;
>         __u32 newfd;
>         __u32 newfd_flags;
> };
>
> No need to hide in the name that this is remote_dup2().
>
> > +
> >  #define SECCOMP_IOC_MAGIC            '!'
> >  #define SECCOMP_IO(nr)                       _IO(SECCOMP_IOC_MAGIC, nr)
> >  #define SECCOMP_IOR(nr, type)                _IOR(SECCOMP_IOC_MAGIC, nr, type)
> > @@ -124,4 +145,8 @@ struct seccomp_notif_resp {
> >  #define SECCOMP_IOCTL_NOTIF_SEND     SECCOMP_IOWR(1, \
> >                                               struct seccomp_notif_resp)
> >  #define SECCOMP_IOCTL_NOTIF_ID_VALID SECCOMP_IOR(2, __u64)
> > +/* On success, the return value is the remote process's added fd number */
> > +#define SECCOMP_IOCTL_NOTIF_ADDFD    SECCOMP_IOR(3,  \
> > +                                             struct seccomp_notif_addfd)
> > +
> >  #endif /* _UAPI_LINUX_SECCOMP_H */
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index f6ce94b7a167..88940eeabaee 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -77,10 +77,42 @@ struct seccomp_knotif {
> >       long val;
> >       u32 flags;
> >
> > -     /* Signals when this has entered SECCOMP_NOTIFY_REPLIED */
> > +     /*
> > +      * Signals when this has changed states, such as the listener
> > +      * dying, a new seccomp addfd message, or changing to REPLIED
> > +      */
> >       struct completion ready;
> >
> >       struct list_head list;
> > +
> > +     /* outstanding addfd requests */
> > +     struct list_head addfd;
> > +};
> > +
> > +/**
> > + * struct seccomp_kaddfd - contianer for seccomp_addfd ioctl messages
>
>                               ^^^ typo
>
> > + *
> > + * @file: A reference to the file to install in the other task
> > + * @fd: The fd number to install it at. If the fd number is -1, it means the
> > + *      installing process should allocate the fd as normal.
> > + * @flags: The flags for the new file descriptor. At the moment, only O_CLOEXEC
> > + *         is allowed.
> > + * @ret: The return value of the installing process. It is set to the fd num
> > + *       upon success (>= 0).
> > + * @completion: Indicates that the installing process has completed fd
> > + *              installation, or gone away (either due to successful
> > + *              reply, or signal)
> > + *
> > + */
> > +struct seccomp_kaddfd {
> > +     struct file *file;
> > +     int fd;
> > +     unsigned int flags;
> > +
> > +     /* To only be set on reply */
> > +     int ret;
> > +     struct completion completion;
> > +     struct list_head list;
> >  };
> >
> >  /**
> > @@ -735,6 +767,35 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
> >       return filter->notif->next_id++;
> >  }
> >
> > +static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> > +{
> > +     int ret;
> > +
> > +     /*
> > +      * Remove the notification, and reset the list pointers, indicating
> > +      * that it has been handled.
> > +      */
> > +     list_del_init(&addfd->list);
> > +
> > +     ret = security_file_receive(addfd->file);
> > +     if (ret)
> > +             goto out;
> > +
> > +     if (addfd->fd >= 0) {
> > +             ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
> > +             if (ret >= 0)
> > +                     fput(addfd->file);
> > +     } else {
> > +             ret = get_unused_fd_flags(addfd->flags);
> > +             if (ret >= 0)
> > +                     fd_install(ret, addfd->file);
> > +     }
> > +
> > +out:
> > +     addfd->ret = ret;
> > +     complete(&addfd->completion);
> > +}
> > +
> >  static int seccomp_do_user_notification(int this_syscall,
> >                                       struct seccomp_filter *match,
> >                                       const struct seccomp_data *sd)
> > @@ -743,6 +804,7 @@ static int seccomp_do_user_notification(int this_syscall,
> >       u32 flags = 0;
> >       long ret = 0;
> >       struct seccomp_knotif n = {};
> > +     struct seccomp_kaddfd *addfd, *tmp;
> >
> >       mutex_lock(&match->notify_lock);
> >       err = -ENOSYS;
> > @@ -755,6 +817,7 @@ static int seccomp_do_user_notification(int this_syscall,
> >       n.id = seccomp_next_notify_id(match);
> >       init_completion(&n.ready);
> >       list_add(&n.list, &match->notif->notifications);
> > +     INIT_LIST_HEAD(&n.addfd);
> >
> >       up(&match->notif->request);
> >       wake_up_poll(&match->notif->wqh, EPOLLIN | EPOLLRDNORM);
> > @@ -763,14 +826,31 @@ static int seccomp_do_user_notification(int this_syscall,
> >       /*
> >        * This is where we wait for a reply from userspace.
> >        */
> > +wait:
> >       err = wait_for_completion_interruptible(&n.ready);
> >       mutex_lock(&match->notify_lock);
> >       if (err == 0) {
> > +             /* Check if we were woken up by a addfd message */
> > +             addfd = list_first_entry_or_null(&n.addfd,
> > +                                              struct seccomp_kaddfd, list);
> > +             if (addfd && n.state != SECCOMP_NOTIFY_REPLIED) {
> > +                     seccomp_handle_addfd(addfd);
> > +                     mutex_unlock(&match->notify_lock);
> > +                     goto wait;
> > +             }
> >               ret = n.val;
> >               err = n.error;
> >               flags = n.flags;
> >       }
> >
> > +     /* If there were any pending addfd calls, clear them out */
> > +     list_for_each_entry_safe(addfd, tmp, &n.addfd, list) {
> > +             /* The process went away before we got a chance to handle it */
> > +             addfd->ret = -ENOENT;
>
> Looks like it should be -ESRCH?
>
I'm a little confused on where we use ESRCH vs. ENOENT. It looks like
in the cookie
check (SECCOMP_IOCTL_NOTIF_ID_VALID), we return ENOENT on both error paths
-- whether the notification is missing, or whether the notification
was already replied to.

I originally had this as ESRCH, but switched to ENOENT to be
consistent with that API.
Do we want the API to disclose information about half-done /
incomplete notifications?
