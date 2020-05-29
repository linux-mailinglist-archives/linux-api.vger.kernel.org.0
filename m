Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E11E7EC7
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 15:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgE2NcG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 09:32:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44137 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2NcG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 09:32:06 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jef75-0002iN-Ki; Fri, 29 May 2020 13:31:55 +0000
Date:   Fri, 29 May 2020 15:31:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     keescook@chromium.org, containers@lists.linux-foundation.org,
        cyphar@cyphar.com, jannh@google.com, jeffv@google.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        palmer@google.com, rsesek@google.com, tycho@tycho.ws,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200529133154.gn2xg6lr7xmkp34p@wittgenstein>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <20200529103253.jepm6dzsqzhwtlpj@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529103253.jepm6dzsqzhwtlpj@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 29, 2020 at 12:32:55PM +0200, Christian Brauner wrote:
> On Thu, May 28, 2020 at 04:08:57AM -0700, Sargun Dhillon wrote:
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
> >  include/uapi/linux/seccomp.h |  25 +++++
> >  kernel/seccomp.c             | 182 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 206 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index c1735455bc53..c7bfe898e7a0 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -113,6 +113,27 @@ struct seccomp_notif_resp {
> >  	__u32 flags;
> >  };
> >  
> > +/* valid flags for seccomp_notif_addfd */
> > +#define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
> > +
> > +/**
> > + * struct seccomp_notif_addfd
> > + * @size: The size of the seccomp_notif_addfd datastructure
> > + * @id: The ID of the seccomp notification
> > + * @flags: SECCOMP_ADDFD_FLAG_*
> > + * @srcfd: The local fd number
> > + * @newfd: Optional remote FD number if SETFD option is set, otherwise 0.
> > + * @newfd_flags: Flags the remote FD should be allocated under
> > + */
> > +struct seccomp_notif_addfd {
> > +	__u64 size;
> > +	__u64 id;
> > +	__u64 flags;
> > +	__u32 srcfd;
> > +	__u32 newfd;
> > +	__u32 newfd_flags;
> > +};
> 
> This doesn't correspond to how we usually pad structs, I think:
> 
> struct seccomp_notif_addfd {
>         __u64                      size;                 /*     0     8 */
>         __u64                      id;                   /*     8     8 */
>         __u64                      flags;                /*    16     8 */
>         __u32                      srcfd;                /*    24     4 */
>         __u32                      newfd;                /*    28     4 */
>         __u32                      newfd_flags;          /*    32     4 */
> 
>         /* size: 40, cachelines: 1, members: 6 */
>         /* padding: 4 */
>         /* last cacheline: 40 bytes */
> };
> 
> You can either use the packed attribute or change the flags member from
> u64 to u32:
> 
> struct seccomp_notif_addfd {
> 	__u64 size;
> 	__u64 id;
> 	__u32 flags;
> 	__u32 srcfd;
> 	__u32 newfd;
> 	__u32 newfd_flags;
> }
> 
> ^^ This seems nicer to me and gets rid of the 4 byte padding. If we run
> out of 32 flags we'll just add a second flag argument to the struct.
> 
> > +
> >  #define SECCOMP_IOC_MAGIC		'!'
> >  #define SECCOMP_IO(nr)			_IO(SECCOMP_IOC_MAGIC, nr)
> >  #define SECCOMP_IOR(nr, type)		_IOR(SECCOMP_IOC_MAGIC, nr, type)
> > @@ -124,4 +145,8 @@ struct seccomp_notif_resp {
> >  #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
> >  						struct seccomp_notif_resp)
> >  #define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
> > +/* On success, the return value is the remote process's added fd number */
> > +#define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOR(3,	\
> > +						struct seccomp_notif_addfd)
> > +
> >  #endif /* _UAPI_LINUX_SECCOMP_H */
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 94ae4c7502cc..02b9ba1fbee0 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -41,6 +41,9 @@
> >  #include <linux/tracehook.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/anon_inodes.h>
> > +#include <net/netprio_cgroup.h>
> > +#include <net/sock.h>
> > +#include <net/cls_cgroup.h>
> >  
> >  enum notify_state {
> >  	SECCOMP_NOTIFY_INIT,
> > @@ -77,10 +80,42 @@ struct seccomp_knotif {
> >  	long val;
> >  	u32 flags;
> >  
> > -	/* Signals when this has entered SECCOMP_NOTIFY_REPLIED */
> > +	/*
> > +	 * Signals when this has changed states, such as the listener
> > +	 * dying, a new seccomp addfd message, or changing to REPLIED
> > +	 */
> >  	struct completion ready;
> >  
> >  	struct list_head list;
> > +
> > +	/* outstanding addfd requests */
> > +	struct list_head addfd;
> > +};
> > +
> > +/**
> > + * struct seccomp_kaddfd - container for seccomp_addfd ioctl messages
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
> > +	struct file *file;
> > +	int fd;
> > +	unsigned int flags;
> > +
> > +	/* To only be set on reply */
> > +	int ret;
> > +	struct completion completion;
> > +	struct list_head list;
> >  };
> >  
> >  /**
> > @@ -735,6 +770,41 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
> >  	return filter->notif->next_id++;
> >  }
> >  
> > +static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> > +{
> > +	struct socket *sock;
> > +	int ret, err;
> > +
> > +	/*
> > +	 * Remove the notification, and reset the list pointers, indicating
> > +	 * that it has been handled.
> > +	 */
> > +	list_del_init(&addfd->list);
> > +
> > +	ret = security_file_receive(addfd->file);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (addfd->fd == -1) {
> > +		ret = get_unused_fd_flags(addfd->flags);
> > +		if (ret >= 0)
> > +			fd_install(ret, get_file(addfd->file));
> > +	} else {
> > +		ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
> > +	}
> > +
> > +	/* These are the semantics from copying FDs via SCM_RIGHTS */
> > +	sock = sock_from_file(addfd->file, &err);
> 
> Iiuc, if this is indeed a socket and the replace_fd() or fd_install()
> has failed, you're now still transferring netprioidx and classid to the
> task's cgroup. Should probably be something like:
> 
> if (sock && ret >= 0) {
> 	sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> 	sock_update_classid(&sock->sk->sk_cgrp_data);
> }
> 
> > +
> > +out:
> > +	addfd->ret = ret;
> > +	complete(&addfd->completion);
> > +}
> > +
> >  static int seccomp_do_user_notification(int this_syscall,
> >  					struct seccomp_filter *match,
> >  					const struct seccomp_data *sd)
> > @@ -743,6 +813,7 @@ static int seccomp_do_user_notification(int this_syscall,
> >  	u32 flags = 0;
> >  	long ret = 0;
> >  	struct seccomp_knotif n = {};
> > +	struct seccomp_kaddfd *addfd, *tmp;
> >  
> >  	mutex_lock(&match->notify_lock);
> >  	err = -ENOSYS;
> > @@ -755,6 +826,7 @@ static int seccomp_do_user_notification(int this_syscall,
> >  	n.id = seccomp_next_notify_id(match);
> >  	init_completion(&n.ready);
> >  	list_add(&n.list, &match->notif->notifications);
> > +	INIT_LIST_HEAD(&n.addfd);
> >  
> >  	up(&match->notif->request);
> >  	wake_up_poll(&match->notif->wqh, EPOLLIN | EPOLLRDNORM);
> > @@ -763,14 +835,31 @@ static int seccomp_do_user_notification(int this_syscall,
> >  	/*
> >  	 * This is where we wait for a reply from userspace.
> >  	 */
> > +wait:
> >  	err = wait_for_completion_interruptible(&n.ready);
> >  	mutex_lock(&match->notify_lock);
> >  	if (err == 0) {
> > +		/* Check if we were woken up by a addfd message */
> > +		addfd = list_first_entry_or_null(&n.addfd,
> > +						 struct seccomp_kaddfd, list);
> > +		if (addfd && n.state != SECCOMP_NOTIFY_REPLIED) {
> > +			seccomp_handle_addfd(addfd);
> > +			mutex_unlock(&match->notify_lock);
> > +			goto wait;
> > +		}
> >  		ret = n.val;
> >  		err = n.error;
> >  		flags = n.flags;
> >  	}
> >  
> > +	/* If there were any pending addfd calls, clear them out */
> > +	list_for_each_entry_safe(addfd, tmp, &n.addfd, list) {
> > +		/* The process went away before we got a chance to handle it */
> > +		addfd->ret = -ESRCH;
> > +		list_del_init(&addfd->list);
> > +		complete(&addfd->completion);
> > +	}

I forgot to ask this in my first review before, don't you need a
complete(&addfd->completion) call in seccomp_notify_release() before
freeing it?

> > +
> >  	/*
> >  	 * Note that it's possible the listener died in between the time when
> >  	 * we were notified of a respons (or a signal) and when we were able to
> > @@ -1174,6 +1263,95 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
> >  	return ret;
> >  }
> >  
> > +static long seccomp_notify_addfd(struct seccomp_filter *filter,
> > +				 struct seccomp_notif_addfd __user *uaddfd)
> > +{
> > +	struct seccomp_notif_addfd addfd;
> > +	struct seccomp_knotif *knotif;
> > +	struct seccomp_kaddfd kaddfd;
> > +	u64 size;
> > +	int ret;
> > +
> > +	ret = get_user(size, &uaddfd->size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = copy_struct_from_user(&addfd, sizeof(addfd), uaddfd, size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (addfd.newfd_flags & ~O_CLOEXEC)
> > +		return -EINVAL;
> > +
> > +	if (addfd.flags & ~SECCOMP_ADDFD_FLAG_SETFD)
> > +		return -EINVAL;
> > +
> > +	if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
> > +		return -EINVAL;
> > +
> > +	kaddfd.file = fget(addfd.srcfd);
> > +	if (!kaddfd.file)
> > +		return -EBADF;
> > +
> > +	kaddfd.flags = addfd.newfd_flags;
> > +	kaddfd.fd = (addfd.flags & SECCOMP_ADDFD_FLAG_SETFD) ?
> > +		    addfd.newfd : -1;
> > +	init_completion(&kaddfd.completion);
> > +
> > +	ret = mutex_lock_interruptible(&filter->notify_lock);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	knotif = find_notification(filter, addfd.id);
> > +	/*
> > +	 * We do not want to allow for FD injection to occur before the
> > +	 * notification has been picked up by a userspace handler, or after
> > +	 * the notification has been replied to.
> > +	 */
> 
> That comment ^^ should probably go above...
> 
> > +	if (!knotif) {
> > +		ret = -ENOENT;
> > +		goto out_unlock;
> > +	}
> 
> ... this vv check, no?
> 
> > +
> > +	if (knotif->state != SECCOMP_NOTIFY_SENT) {
> > +		ret = -EINPROGRESS;
> > +		goto out_unlock;
> > +	}
> > +
> > +	list_add(&kaddfd.list, &knotif->addfd);
> > +	complete(&knotif->ready);
> > +	mutex_unlock(&filter->notify_lock);
> > +
> > +	/* Now we wait for it to be processed */
> > +	ret = wait_for_completion_interruptible(&kaddfd.completion);
> > +	if (ret == 0) {
> > +		/*
> > +		 * We had a successful completion. The other side has already
> > +		 * removed us from the addfd queue, and
> > +		 * wait_for_completion_interruptible has a memory barrier.
> > +		 */
> > +		ret = kaddfd.ret;
> > +		goto out;
> > +	}
> > +
> > +	mutex_lock(&filter->notify_lock);
> > +	/*
> > +	 * Even though we were woken up by a signal, and not a successful
> > +	 * completion, a completion may have happened in the mean time.
> > +	 */
> > +	if (list_empty(&kaddfd.list))
> > +		ret = kaddfd.ret;
> > +	else
> > +		list_del(&kaddfd.list);
> > +
> > +out_unlock:
> > +	mutex_unlock(&filter->notify_lock);
> > +out:
> > +	fput(kaddfd.file);
> > +
> > +	return ret;
> > +}
> > +
> >  static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
> >  				 unsigned long arg)
> >  {
> > @@ -1187,6 +1365,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
> >  		return seccomp_notify_send(filter, buf);
> >  	case SECCOMP_IOCTL_NOTIF_ID_VALID:
> >  		return seccomp_notify_id_valid(filter, buf);
> > +	case SECCOMP_IOCTL_NOTIF_ADDFD:
> > +		return seccomp_notify_addfd(filter, buf);
> >  	default:
> >  		return -EINVAL;
> >  	}
> > -- 
> > 2.25.1
> > 
