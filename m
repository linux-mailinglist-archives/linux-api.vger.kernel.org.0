Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC41E8CC5
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 03:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgE3BK7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 21:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgE3BK6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 21:10:58 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B288C08C5C9
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 18:10:58 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j3so4243061ilk.11
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5LkxLyIFNOjTzw4l6jSMLlIHd5WcMEBHimCoH8pYOMM=;
        b=Pk7NZkOHzexVvgfTOQnmsrWNkjAD5QsFiURmyevTP54bmRREJ6RQzwrg5+od7u3TCI
         CG7k+DbkdB9Z9cUgHTmlTElezezQjtXMDKw42Jf6Z98PMy/Xi+w8jsdlgG4BP54G2tSR
         RYhMOjSdHOI8EDwY/gCRHZN+4MFhnt/R3l148=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LkxLyIFNOjTzw4l6jSMLlIHd5WcMEBHimCoH8pYOMM=;
        b=Op518dpgyQ8hYtgK8Plahgx9uuc5PV1/7ukomcYd7oeYCf18UrYF6B1hgfZZeQnnk8
         NpcjWatgthgGffJF/1P5ttwCkcQB937D+6Z9P1lzECFxJEKjxERTIltG7FuJjYKqMVrQ
         tkKpPiy1EgTxPvjeMwaOyPEiOG++sv5ZRqBDYXX6gxWrYiLFV7OXcqw0qmwY5WsfixK9
         SKkRJwnbSQOV4WHEpPhnni5uVcFJC3roDDJ8HlqyeYl/NKldtkLBhtKdcGAo8xFih2l0
         Fv5iW8w4NYbadFLocSIyll0l3uixkIdYr4XarDqWegx/PmS0yrPqgs9XvEI05KqYfWHs
         lSjQ==
X-Gm-Message-State: AOAM5316KuWR/gN8VvUrG9XmKhGM/oDwSF1ErvWx0kyWzzOXHtliZO3J
        Nqu95XitrMSF1N8YwIpaA1ESrw==
X-Google-Smtp-Source: ABdhPJzxGUyY4i7q0KeNwWdLGPRw+s7Wc47QVL6i9AaM6gNLZCRgzzXvrqfs5BLPKzoU7ZhxSctiHw==
X-Received: by 2002:a92:cc4d:: with SMTP id t13mr9623510ilq.213.1590801057670;
        Fri, 29 May 2020 18:10:57 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id x22sm5696191ill.9.2020.05.29.18.10.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 18:10:57 -0700 (PDT)
Date:   Sat, 30 May 2020 01:10:55 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005282345.573B917@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 29, 2020 at 12:31:37AM -0700, Kees Cook wrote:
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
> 
> This looks mostly really clean. When I've got more brain tomorrow I want to
> double-check the locking, but I think the use of notify_lock and being
> in the ioctl fully protects everything from any use-after-free-like
> issues.
> 
> Notes below...
> 
> > +/* valid flags for seccomp_notif_addfd */
> > +#define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
> 
> Nit: please use BIT()
> 
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
> > +	if (sock) {
> > +		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> > +		sock_update_classid(&sock->sk->sk_cgrp_data);
> > +	}
> 
> This made my eye twitch. ;) I see this is borrowed from
> scm_detach_fds()... this really feels like the kind of thing that will
> quickly go out of sync. I think this "receive an fd" logic needs to be
> lifted out of scm_detach_fds() so it and seccomp can share it. I'm not
> sure how to parameterize it quite right, though. Perhaps:
> 
> int file_receive(int fd, unsigned long flags, struct file *file)
> {
> 	struct socket *sock;
> 	int ret;
> 
> 	ret = security_file_receive(file);
> 	if (ret)
> 		return ret;
> 
> 	/* Install the file. */
> 	if (fd == -1) {
> 		ret = get_unused_fd_flags(flags);
> 		if (ret >= 0)
> 			fd_install(ret, get_file(file));
> 	} else {
> 		ret = replace_fd(fd, file, flags);
> 	}
> 
> 	/* Bump the usage count. */
> 	sock = sock_from_file(addfd->file, &err);
> 	if (sock) {
> 		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> 		sock_update_classid(&sock->sk->sk_cgrp_data);
> 	}
> 
> 	return ret;
> }
> 
> 
> static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> {
> 	/*
> 	 * Remove the notification, and reset the list pointers, indicating
> 	 * that it has been handled.
> 	 */
> 	list_del_init(&addfd->list);
> 	addfd->ret = file_receive(addfd->fd, addfd->flags, addfd->file);
> 	complete(&addfd->completion);
> }
> 
> scm_detach_fds()
> 	...
> 	for (i=0, cmfptr=(__force int __user *)CMSG_DATA(cm); i<fdmax;
>              i++, cmfptr++)
> 	{
> 
> 		err = file_receive(-1, MSG_CMSG_CLOEXEC & msg->msg_flags
>                                           ? O_CLOEXEC : 0, fp[i]);
> 		if (err < 0)
> 			break;
> 		err = put_user(err, cmfptr);
> 		if (err)
> 			/* wat */
> 	}
> 	...
> 
> I'm not sure on the put_user() failure, though. We could check early
> for faults with a put_user(0, cmfptr) before the file_receive() call, or
> we could just ignore it? I'm not sure what SCM does here. I guess
> worst-case:
> 
> int file_receive(int fd, unsigned long flags, struct file *file,
> 		 int __user *fdptr)
> {
> 		...
> 		ret = get_unused_fd_flags(flags);
> 		if (ret >= 0) {
> 			if (cmfptr) {
> 				int err;
> 
> 	                	err = put_user(ret, cmfptr);
> 				if (err) {
> 					put_unused_fd(ret);
> 					return err;
> 				}
> 			}
> 			fd_install(ret, get_file(file));
> 		}
> 		...
> }
> 
What about:

/*
 * File Receive - Retrieve a file from another process
 *
 * It can either replace an existing fd, or use a newly allocated fd. If you
 * intend on using an existing fd, replace should be false, and flags will
 * be ignored. The fd should be allocated using get_unused_fd_flags with the
 * flags that you want. It does not consume the reference to file.
 *
 * Returns 0 upon success
 */
static int __file_receive(int fd, unsigned int flags, struct file *file,
			  bool replace)
{
	struct socket *sock;
	int err;

	err = security_file_receive(file);
	if (err)
		return err;

	/* Is this an existing FD? */
	if (replace) {
		err = replace_fd(fd, file, flags);
		if (err)
			return err;
	} else {
		fd_install(fd, get_file(file));
	}

	sock = sock_from_file(file, &err);
	if (sock) {
		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
		sock_update_classid(&sock->sk->sk_cgrp_data);
	}

	return 0;
}

int file_receive_replace(int fd, unsigned int flags, struct file *file)
{
	return __file_receive(fd, flags, file, true);
}

int file_receive(int fd, struct file *file)
{
	return __file_receive(fd, 0, file, false);
}


// And then SCM reads:
	for (i=0, cmfptr=(__force int __user *)CMSG_DATA(cm); i<fdmax;
	     i++, cmfptr++)
	{
		int new_fd;
		err = get_unused_fd_flags(MSG_CMSG_CLOEXEC & msg->msg_flags
					  ? O_CLOEXEC : 0);
		if (err < 0)
			break;
		new_fd = err;
		err = put_user(new_fd, cmfptr);
		if (err) {
			put_unused_fd(new_fd);
			break;
		}

		err = file_receive(new_fd, fp[i]);
		if (err) {
			put_unused_fd(new_fd);
			break;
		}
	}

And our code reads:


static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
{
	int ret, err;

	/*
	 * Remove the notification, and reset the list pointers, indicating
	 * that it has been handled.
	 */
	list_del_init(&addfd->list);

	if (addfd->fd == -1) {
		ret = get_unused_fd_flags(addfd->flags);
		if (ret < 0)
			goto err;

		err = file_receive(ret, addfd->file);
		if (err) {
			put_unused_fd(ret);
			ret = err;
		}
	} else {
		ret = file_receive_replace(addfd->fd, addfd->flags,
					   addfd->file);
	}

err:
	addfd->ret = ret;
	complete(&addfd->completion);
}


And the pidfd getfd code reads:

static int pidfd_getfd(struct pid *pid, int fd)
{
	struct task_struct *task;
	struct file *file;
	int ret, err;

	task = get_pid_task(pid, PIDTYPE_PID);
	if (!task)
		return -ESRCH;

	file = __pidfd_fget(task, fd);
	put_task_struct(task);
	if (IS_ERR(file))
		return PTR_ERR(file);

	ret = get_unused_fd_flags(O_CLOEXEC);
	if (ret >= 0) {
		err = file_receive(ret, file);
		if (err) {
			put_unused_fd(ret);
			ret = err;
		}
	}

	fput(file);
	return ret;
}

