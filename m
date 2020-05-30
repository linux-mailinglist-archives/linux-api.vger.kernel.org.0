Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D291E8D91
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 05:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgE3D6W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 23:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgE3D6W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 23:58:22 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBECC08C5C9
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 20:58:20 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c8so1513886iob.6
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 20:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4hjG9hz3EH+3drDgKCvmYmzuw/OQvSsB0LXZfpCBTlU=;
        b=Kv2etjcoo7zuA1LfGWyV3Eb9+nadY2RNQ8JjdQ6A0NpvSsZQ/98XpCWAkjYjc6bZFH
         tef0ccBNVBYDBlVDfXqeQbgqFSVYW5+Bt0f7lzShARHkrKoFA+bO5WTrnhmN3Ux46iDw
         qysLrJg/8nTV15VlwTmEqbzIW3709dZ5/A8F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4hjG9hz3EH+3drDgKCvmYmzuw/OQvSsB0LXZfpCBTlU=;
        b=Zk8hSy7Ko/EWMyBp7esOVEhc9WkoL9fL8fYN8RaRD2iINo//hV9bYsCHmzlkdREQNx
         kz7GJ6xtNP0910RXmhjxjcUUM8sQ5fOdp169AfklI/pj+7PchXx2lUssqd5kXXAqYZo5
         WuNOITJdar1HZlr2bRZnWtnv7eA4y6dV2/Yg7Spd8twscFQW3+/E94mHCynrkoUK7Ij0
         Ghtx9U897fLpcCfM/cH4bxRG6MNUFHAgcNVp0naiM/7mg3DWF3Dy52ecRqkY9sMvJp6n
         GsJOE+A3vwlDoSVxCBfk5OSNyAFCka0U43Gt5Ssks55GwkZvjV1I5o+q7o3A62vl7GD6
         pl3g==
X-Gm-Message-State: AOAM533unecQRWZvhzULKJ4iXHfvLeslPIBHdtWZ3ojnLZNfaVyIaT+h
        B/ty+X33gl67uqh+RulKP12JTg==
X-Google-Smtp-Source: ABdhPJzfW/10nlqkn5AV6zAftx9VV/VAydmvY8NYwB1rUgYovWpe52iFU/W+9JwJ1uTBWXqXvyQdMw==
X-Received: by 2002:a02:a805:: with SMTP id f5mr10863154jaj.130.1590811100116;
        Fri, 29 May 2020 20:58:20 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id a13sm5954875ill.51.2020.05.29.20.58.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 20:58:19 -0700 (PDT)
Date:   Sat, 30 May 2020 03:58:18 +0000
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
Message-ID: <20200530035817.GA20457@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005291926.E9004B4@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> 
> I mean, yes, that's certainly better, but it just seems a shame that
> everyone has to do the get_unused/put_unused dance just because of how
> SCM_RIGHTS does this weird put_user() in the middle.
> 
> Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> move the put_user() after instead? I think cleanup would just be:
> replace_fd(fd, NULL, 0)
> 
> So:
> 
> (updated to skip sock updates on failure; thank you Christian!)
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
> 	/* Bump the sock usage counts. */
> 	if (ret >= 0) {
> 		sock = sock_from_file(addfd->file, &err);
> 		if (sock) {
> 			sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> 			sock_update_classid(&sock->sk->sk_cgrp_data);
> 		}
> 	}
> 
> 	return ret;
> }
> 
> scm_detach_fds()
> 	...
> 	for (i=0, cmfptr=(__force int __user *)CMSG_DATA(cm); i<fdmax;
>              i++, cmfptr++)
> 	{
> 		int new_fd;
> 
> 		err = file_receive(-1, MSG_CMSG_CLOEXEC & msg->msg_flags
>                                           ? O_CLOEXEC : 0, fp[i]);
> 		if (err < 0)
> 			break;
> 		new_fd = err;
> 
Isn't the "right" way to do this to allocate a bunch of file descriptors,
and fill up the user buffer with them, and then install the files? This
seems to like half-install the file descriptors and then error out.

I know that's the current behaviour, but that seems like a bad idea. Do
we really want to perpetuate this half-broken state? I guess that some
userspace programs could be depending on this -- and their recovery
semantics could rely on this. I mean this is 10+ year old code.

> 		err = put_user(err, cmfptr);
> 		if (err) {
> 			/*
> 			 * If we can't notify userspace that it got the
> 			 * fd, we need to unwind and remove it again.
> 			 */
> 			replace_fd(new_fd, NULL, 0);
> 			break;
> 		}
> 	}
> 	...
> 
> 
> 
> -- 
> Kees Cook
