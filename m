Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E91E76AB
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 09:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE2Hbk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgE2Hbj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 03:31:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A3C08C5C6
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 00:31:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a45so1472989pje.1
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 00:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BjbMn1qsMKGkms9jIt20RbtbWfCwTzSPf+vBlJtu9fk=;
        b=QE2utAsVr32GMy/yIP0cyPH+hog9b1a1KXF06H3IlVoWiDEhRnKmCEEUu7xU1f7BUU
         OQPcxUGGUFlOIWXrWh+3PM0Qektjxc36DEhkwkGU/KnpoeKHIcMHBhSfZ6LkBKZPKdR/
         xLKEa5F15aCNokCDl6G2RSxcPVmBOZ4ek30VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjbMn1qsMKGkms9jIt20RbtbWfCwTzSPf+vBlJtu9fk=;
        b=KDjMf2KULqJfJQjN2Q4fnfa1V+zgKw6RoLj2TkhiT7z9zCVAGduuz07XuxXxa3IxmR
         syTMUkx7QpYnquGKFWV3aNGg7BJS/Wk2plOjJhT58swllJ+VVQV8XZoWdfE/v2U88yjo
         UJdvVK2urpbg+rffNw61m3Hh4au4eIxE2jcTBT4B9+15GR8U+blKSxQLKplFtQi7+LYz
         utlzW33Ojgdk0vJVoKXD+TXMQrQ7wvOJrjoZ6N9hhVgmoTXGhKhq3YK5jiZS/qSxJn96
         rwdwYinnqdX4Vjx3X5L5y4pYF8oj4uMoOUWNWjzNGnzHIctftKnSqU46h48hqu+n/m0R
         eGQA==
X-Gm-Message-State: AOAM533IONGRYKkqzcGgKjCO655Hof2kEyMiXW2KJBJ90EaRIarVwUma
        pGmSw10e9tdvWX895wkYjl5C6g==
X-Google-Smtp-Source: ABdhPJzPt2oIqT1VHd6wy1mcnrg2Hbhb+ZPcgw91NdWgS0uiOKQbBwpDO8lOTNu1brMjCaZdmBU+ZQ==
X-Received: by 2002:a17:90a:de8b:: with SMTP id n11mr8413293pjv.87.1590737499128;
        Fri, 29 May 2020 00:31:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l3sm7097802pjb.39.2020.05.29.00.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:31:38 -0700 (PDT)
Date:   Fri, 29 May 2020 00:31:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202005282345.573B917@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528110858.3265-3-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 28, 2020 at 04:08:57AM -0700, Sargun Dhillon wrote:
> This adds a seccomp notifier ioctl which allows for the listener to "add"
> file descriptors to a process which originated a seccomp user
> notification. This allows calls like mount, and mknod to be "implemented",
> as the return value, and the arguments are data in memory. On the other
> hand, calls like connect can be "implemented" using pidfd_getfd.
> 
> Unfortunately, there are calls which return file descriptors, like
> open, which are vulnerable to TOC-TOU attacks, and require that the
> more privileged supervisor can inspect the argument, and perform the
> syscall on behalf of the process generating the notifiation. This
> allows the file descriptor generated from that open call to be
> returned to the calling process.
> 
> In addition, there is funcitonality to allow for replacement of
> specific file descriptors, following dup2-like semantics.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Matt Denton <mpdenton@google.com>

This looks mostly really clean. When I've got more brain tomorrow I want to
double-check the locking, but I think the use of notify_lock and being
in the ioctl fully protects everything from any use-after-free-like
issues.

Notes below...

> +/* valid flags for seccomp_notif_addfd */
> +#define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */

Nit: please use BIT()

> @@ -735,6 +770,41 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
>  	return filter->notif->next_id++;
>  }
>  
> +static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> +{
> +	struct socket *sock;
> +	int ret, err;
> +
> +	/*
> +	 * Remove the notification, and reset the list pointers, indicating
> +	 * that it has been handled.
> +	 */
> +	list_del_init(&addfd->list);
> +
> +	ret = security_file_receive(addfd->file);
> +	if (ret)
> +		goto out;
> +
> +	if (addfd->fd == -1) {
> +		ret = get_unused_fd_flags(addfd->flags);
> +		if (ret >= 0)
> +			fd_install(ret, get_file(addfd->file));
> +	} else {
> +		ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
> +	}
> +
> +	/* These are the semantics from copying FDs via SCM_RIGHTS */
> +	sock = sock_from_file(addfd->file, &err);
> +	if (sock) {
> +		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> +		sock_update_classid(&sock->sk->sk_cgrp_data);
> +	}

This made my eye twitch. ;) I see this is borrowed from
scm_detach_fds()... this really feels like the kind of thing that will
quickly go out of sync. I think this "receive an fd" logic needs to be
lifted out of scm_detach_fds() so it and seccomp can share it. I'm not
sure how to parameterize it quite right, though. Perhaps:

int file_receive(int fd, unsigned long flags, struct file *file)
{
	struct socket *sock;
	int ret;

	ret = security_file_receive(file);
	if (ret)
		return ret;

	/* Install the file. */
	if (fd == -1) {
		ret = get_unused_fd_flags(flags);
		if (ret >= 0)
			fd_install(ret, get_file(file));
	} else {
		ret = replace_fd(fd, file, flags);
	}

	/* Bump the usage count. */
	sock = sock_from_file(addfd->file, &err);
	if (sock) {
		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
		sock_update_classid(&sock->sk->sk_cgrp_data);
	}

	return ret;
}


static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
{
	/*
	 * Remove the notification, and reset the list pointers, indicating
	 * that it has been handled.
	 */
	list_del_init(&addfd->list);
	addfd->ret = file_receive(addfd->fd, addfd->flags, addfd->file);
	complete(&addfd->completion);
}

scm_detach_fds()
	...
	for (i=0, cmfptr=(__force int __user *)CMSG_DATA(cm); i<fdmax;
             i++, cmfptr++)
	{

		err = file_receive(-1, MSG_CMSG_CLOEXEC & msg->msg_flags
                                          ? O_CLOEXEC : 0, fp[i]);
		if (err < 0)
			break;
		err = put_user(err, cmfptr);
		if (err)
			/* wat */
	}
	...

I'm not sure on the put_user() failure, though. We could check early
for faults with a put_user(0, cmfptr) before the file_receive() call, or
we could just ignore it? I'm not sure what SCM does here. I guess
worst-case:

int file_receive(int fd, unsigned long flags, struct file *file,
		 int __user *fdptr)
{
		...
		ret = get_unused_fd_flags(flags);
		if (ret >= 0) {
			if (cmfptr) {
				int err;

	                	err = put_user(ret, cmfptr);
				if (err) {
					put_unused_fd(ret);
					return err;
				}
			}
			fd_install(ret, get_file(file));
		}
		...
}

> @@ -763,14 +835,31 @@ static int seccomp_do_user_notification(int this_syscall,
>  	/*
>  	 * This is where we wait for a reply from userspace.
>  	 */
> +wait:
>  	err = wait_for_completion_interruptible(&n.ready);
>  	mutex_lock(&match->notify_lock);
>  	if (err == 0) {
> +		/* Check if we were woken up by a addfd message */
> +		addfd = list_first_entry_or_null(&n.addfd,
> +						 struct seccomp_kaddfd, list);
> +		if (addfd && n.state != SECCOMP_NOTIFY_REPLIED) {
> +			seccomp_handle_addfd(addfd);
> +			mutex_unlock(&match->notify_lock);
> +			goto wait;
> +		}
>  		ret = n.val;
>  		err = n.error;
>  		flags = n.flags;
>  	}

This feels like it needs to be done differently, but when I tried to
make it "proper" loop, I think it got more ugly:

	for (;;) {
	  	err = wait_for_completion_interruptible(&n.ready);
	  	mutex_lock(&match->notify_lock);
	  	if (err == 0) {
			/* Check if we were woken up by a addfd message */
			addfd = list_first_entry_or_null(&n.addfd,
							 struct seccomp_kaddfd, list);
			if (addfd && n.state != SECCOMP_NOTIFY_REPLIED) {
				seccomp_handle_addfd(addfd);
				mutex_unlock(&match->notify_lock);
				continue;
			}
	 		ret = n.val;
	 		err = n.error;
	 		flags = n.flags;
		}
		break;
	}

So, I guess it's fine how you have it. :)

>  
> +	/* If there were any pending addfd calls, clear them out */
> +	list_for_each_entry_safe(addfd, tmp, &n.addfd, list) {
> +		/* The process went away before we got a chance to handle it */
> +		addfd->ret = -ESRCH;
> +		list_del_init(&addfd->list);
> +		complete(&addfd->completion);
> +	}
> +
>  	/*
>  	 * Note that it's possible the listener died in between the time when
>  	 * we were notified of a respons (or a signal) and when we were able to
> @@ -1174,6 +1263,95 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
>  	return ret;
>  }
>  
> +static long seccomp_notify_addfd(struct seccomp_filter *filter,
> +				 struct seccomp_notif_addfd __user *uaddfd)
> +{
> +	struct seccomp_notif_addfd addfd;
> +	struct seccomp_knotif *knotif;
> +	struct seccomp_kaddfd kaddfd;
> +	u64 size;
> +	int ret;
> +
> +	ret = get_user(size, &uaddfd->size);
> +	if (ret)
> +		return ret;
> +
> +	ret = copy_struct_from_user(&addfd, sizeof(addfd), uaddfd, size);
> +	if (ret)
> +		return ret;
> +
> +	if (addfd.newfd_flags & ~O_CLOEXEC)
> +		return -EINVAL;
> +
> +	if (addfd.flags & ~SECCOMP_ADDFD_FLAG_SETFD)
> +		return -EINVAL;
> +
> +	if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
> +		return -EINVAL;
> +
> +	kaddfd.file = fget(addfd.srcfd);
> +	if (!kaddfd.file)
> +		return -EBADF;
> +
> +	kaddfd.flags = addfd.newfd_flags;
> +	kaddfd.fd = (addfd.flags & SECCOMP_ADDFD_FLAG_SETFD) ?
> +		    addfd.newfd : -1;

Given that -1 is already illegal, do we need SECCOMP_ADDFD_FLAG_SETFD?
Could a -1 for newfd just be used instead?

> +	init_completion(&kaddfd.completion);
> +
> +	ret = mutex_lock_interruptible(&filter->notify_lock);
> +	if (ret < 0)
> +		goto out;
> +
> +	knotif = find_notification(filter, addfd.id);
> +	/*
> +	 * We do not want to allow for FD injection to occur before the
> +	 * notification has been picked up by a userspace handler, or after
> +	 * the notification has been replied to.
> +	 */
> +	if (!knotif) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	if (knotif->state != SECCOMP_NOTIFY_SENT) {
> +		ret = -EINPROGRESS;
> +		goto out_unlock;
> +	}
> +
> +	list_add(&kaddfd.list, &knotif->addfd);
> +	complete(&knotif->ready);
> +	mutex_unlock(&filter->notify_lock);
> +
> +	/* Now we wait for it to be processed */
> +	ret = wait_for_completion_interruptible(&kaddfd.completion);
> +	if (ret == 0) {
> +		/*
> +		 * We had a successful completion. The other side has already
> +		 * removed us from the addfd queue, and
> +		 * wait_for_completion_interruptible has a memory barrier.
> +		 */
> +		ret = kaddfd.ret;
> +		goto out;
> +	}
> +
> +	mutex_lock(&filter->notify_lock);
> +	/*
> +	 * Even though we were woken up by a signal, and not a successful
> +	 * completion, a completion may have happened in the mean time.
> +	 */
> +	if (list_empty(&kaddfd.list))
> +		ret = kaddfd.ret;
> +	else
> +		list_del(&kaddfd.list);
> +
> +out_unlock:
> +	mutex_unlock(&filter->notify_lock);
> +out:
> +	fput(kaddfd.file);
> +
> +	return ret;
> +}
> +
>  static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
>  				 unsigned long arg)
>  {
> @@ -1187,6 +1365,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
>  		return seccomp_notify_send(filter, buf);
>  	case SECCOMP_IOCTL_NOTIF_ID_VALID:
>  		return seccomp_notify_id_valid(filter, buf);
> +	case SECCOMP_IOCTL_NOTIF_ADDFD:
> +		return seccomp_notify_addfd(filter, buf);
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.25.1
> 

Whee! :)

-- 
Kees Cook
