Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336D51E105F
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390938AbgEYOUr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 10:20:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38130 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388714AbgEYOUr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 10:20:47 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jdDy9-0007LK-5u; Mon, 25 May 2020 14:20:45 +0000
Date:   Mon, 25 May 2020 16:20:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH 4/5] seccomp: Add SECCOMP_ADDFD_FLAG_MOVE flag to add fd
 ioctl
Message-ID: <20200525142043.jkdsfabntqusizxz@wittgenstein>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-5-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200524233942.8702-5-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 24, 2020 at 04:39:41PM -0700, Sargun Dhillon wrote:
> Certain files, when moved to another process have metadata changed, such
> as netprioidx, and classid. This is the default behaviour in sending
> sockets with SCM_RIGHTS over unix sockets. Depending on the usecase,
> this may or may not be desirable with the addfd ioctl. This allows
> the user to opt-in.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Tycho Andersen <tycho@tycho.ws>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Kees Cook <keescook@google.com>,
> Cc: Jann Horn <jannh@google.com>,
> Cc: Robert Sesek <rsesek@google.com>,
> Cc: Chris Palmer <palmer@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/uapi/linux/seccomp.h |  8 ++++++++
>  kernel/seccomp.c             | 31 +++++++++++++++++++++++++++----
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 7d450a9e4c29..ccd1c960372a 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -115,6 +115,14 @@ struct seccomp_notif_resp {
>  
>  /* valid flags for seccomp_notif_addfd */
>  #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
> +/*
> + * Certain file descriptors are behave differently depending on the process

"do behave"?

> + * they are created in. Specifcally, sockets, and their interactions with the
> + * net_cls and net_prio cgroup v1 controllers. This "moves" the file descriptor
> + * so that it takes on the cgroup controller's configuration in the process
> + * that the file descriptor is being added to.
> + */
> +#define SECCOMP_ADDFD_FLAG_MOVE		(1UL << 1)

I'm not happy about the name because "moving" has much more to do with
transferring ownership than what we are doing here. After a "move" the
fd shouldn't be valid anymore. But that might just be my thinking.

But why make this opt-in and not do it exactly like when you send around
fds and make this mandatory?
