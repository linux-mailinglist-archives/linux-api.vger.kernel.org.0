Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD951E8D38
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 04:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgE3CnO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 22:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgE3CnN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 22:43:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16279C03E969
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 19:43:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so1930401plo.7
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 19:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oDYQmVPOibs4z3Bqe4WQyN6ZoKMzb3qd/HP7vLURjZU=;
        b=FLEvSuReL5H6hsXVKHoXO8isNCsg+p4fYK7Y90FENXhZQDsrmnLwiS7rRtjySYUzPw
         42MDTFgWSby4XuFD3/rL5UWXp8f4xvZEkGnsD4lnvApIoaPjZqPEG/wkx4SebJEyiRcJ
         Arr+LH+BgVy+XxpSa/mXl4LVHmbgyhWrEzu6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oDYQmVPOibs4z3Bqe4WQyN6ZoKMzb3qd/HP7vLURjZU=;
        b=D37S/XkheFbY/l6o/00DSISJg8e1SOSCyieWm8eLjCp94MdsfifCStJfiElUCpZ3Fx
         /8ykyOzjpqt+P9Xn5Hwto0pblMO1CIV8jun+qyzAVPQYQr26EdKGSLdM8rQ5TOKIGRuB
         W9qKCCuKPAusFx2YCqbV0YB7tdEwbAo606FjO3iK/ZUX7riBQKVTdMr7s9JhWZy9dYYr
         vaLTyWtyS/bI/GCto2dZtY8JCYMZ9U68pPSphSyocT64aTjS6l614NQ94ROuq0XUmzci
         Os9PDobxPVsQn2V5rUdXHwoZV/ePKRjEpNszKj3xe6SiUw38+PpFwFj8WrSk5NqMKyOf
         t2nQ==
X-Gm-Message-State: AOAM530AxJomubWdruPWFm962VKD3+APH31H3rsyOGkQEKC2/lLHPSH5
        bDNGFJvXmyo+Q7rP/E2i8IMEow==
X-Google-Smtp-Source: ABdhPJx3uboEkCfbVCRgzQ7DtNoMGZDjHeLBbzlvyi9l271ek0+f6hTDsfPuBdbeiSHvobG8qR1rBA==
X-Received: by 2002:a17:90b:3d7:: with SMTP id go23mr12372080pjb.9.1590806592564;
        Fri, 29 May 2020 19:43:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o27sm8105034pgd.18.2020.05.29.19.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 19:43:11 -0700 (PDT)
Date:   Fri, 29 May 2020 19:43:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202005291926.E9004B4@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 30, 2020 at 01:10:55AM +0000, Sargun Dhillon wrote:
> // And then SCM reads:
> 	for (i=0, cmfptr=(__force int __user *)CMSG_DATA(cm); i<fdmax;
> 	     i++, cmfptr++)
> 	{
> 		int new_fd;
> 		err = get_unused_fd_flags(MSG_CMSG_CLOEXEC & msg->msg_flags
> 					  ? O_CLOEXEC : 0);
> 		if (err < 0)
> 			break;
> 		new_fd = err;
> 		err = put_user(new_fd, cmfptr);
> 		if (err) {
> 			put_unused_fd(new_fd);
> 			break;
> 		}
> 
> 		err = file_receive(new_fd, fp[i]);
> 		if (err) {
> 			put_unused_fd(new_fd);
> 			break;
> 		}
> 	}
> 
> And our code reads:
> 
> 
> static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> {
> 	int ret, err;
> 
> 	/*
> 	 * Remove the notification, and reset the list pointers, indicating
> 	 * that it has been handled.
> 	 */
> 	list_del_init(&addfd->list);
> 
> 	if (addfd->fd == -1) {
> 		ret = get_unused_fd_flags(addfd->flags);
> 		if (ret < 0)
> 			goto err;
> 
> 		err = file_receive(ret, addfd->file);
> 		if (err) {
> 			put_unused_fd(ret);
> 			ret = err;
> 		}
> 	} else {
> 		ret = file_receive_replace(addfd->fd, addfd->flags,
> 					   addfd->file);
> 	}
> 
> err:
> 	addfd->ret = ret;
> 	complete(&addfd->completion);
> }
> 
> 
> And the pidfd getfd code reads:
> 
> static int pidfd_getfd(struct pid *pid, int fd)
> {
> 	struct task_struct *task;
> 	struct file *file;
> 	int ret, err;
> 
> 	task = get_pid_task(pid, PIDTYPE_PID);
> 	if (!task)
> 		return -ESRCH;
> 
> 	file = __pidfd_fget(task, fd);
> 	put_task_struct(task);
> 	if (IS_ERR(file))
> 		return PTR_ERR(file);
> 
> 	ret = get_unused_fd_flags(O_CLOEXEC);
> 	if (ret >= 0) {
> 		err = file_receive(ret, file);
> 		if (err) {
> 			put_unused_fd(ret);
> 			ret = err;
> 		}
> 	}
> 
> 	fput(file);
> 	return ret;
> }

I mean, yes, that's certainly better, but it just seems a shame that
everyone has to do the get_unused/put_unused dance just because of how
SCM_RIGHTS does this weird put_user() in the middle.

Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
move the put_user() after instead? I think cleanup would just be:
replace_fd(fd, NULL, 0)

So:

(updated to skip sock updates on failure; thank you Christian!)

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

	/* Bump the sock usage counts. */
	if (ret >= 0) {
		sock = sock_from_file(addfd->file, &err);
		if (sock) {
			sock_update_netprioidx(&sock->sk->sk_cgrp_data);
			sock_update_classid(&sock->sk->sk_cgrp_data);
		}
	}

	return ret;
}

scm_detach_fds()
	...
	for (i=0, cmfptr=(__force int __user *)CMSG_DATA(cm); i<fdmax;
             i++, cmfptr++)
	{
		int new_fd;

		err = file_receive(-1, MSG_CMSG_CLOEXEC & msg->msg_flags
                                          ? O_CLOEXEC : 0, fp[i]);
		if (err < 0)
			break;
		new_fd = err;

		err = put_user(err, cmfptr);
		if (err) {
			/*
			 * If we can't notify userspace that it got the
			 * fd, we need to unwind and remove it again.
			 */
			replace_fd(new_fd, NULL, 0);
			break;
		}
	}
	...



-- 
Kees Cook
