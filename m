Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34612ABFF
	for <lists+linux-api@lfdr.de>; Thu, 26 Dec 2019 12:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfLZLwt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Dec 2019 06:52:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52130 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfLZLwt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Dec 2019 06:52:49 -0500
Received: from p5b2a6c31.dip0.t-ipconnect.de ([91.42.108.49] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ikRh8-0004SH-SR; Thu, 26 Dec 2019 11:52:47 +0000
Date:   Thu, 26 Dec 2019 12:52:45 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        tycho@tycho.ws, jannh@google.com, keescook@chromium.org
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
Message-ID: <20191226115245.usf7z5dkui7ndp4w@wittgenstein>
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 25, 2019 at 09:45:33PM +0000, Sargun Dhillon wrote:
> This patch is a small change in enforcement of the uapi for
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Specificaly, the datastructure which is
> passed (seccomp_notif), has a flags member. Previously that could be
> set to a nonsense value, and we would ignore it. This ensures that
> no flags are set.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Kees Cook <keescook@chromium.org>

I'm fine with this since we soon want to make use of the flag argument
when we add a flag to get a pidfd from the seccomp notifier on receive.
The major users I could identify already pass in seccomp_notif with all
fields set to 0. If we really break users we can always revert; this
seems very unlikely to me though.

One more question below, otherwise:

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

> ---
>  kernel/seccomp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 12d2227e5786..455925557490 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1026,6 +1026,13 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  	struct seccomp_notif unotif;
>  	ssize_t ret;
>  
> +	if (copy_from_user(&unotif, buf, sizeof(unotif)))
> +		return -EFAULT;
> +
> +	/* flags is reserved right now, make sure it's unset */
> +	if (unotif.flags)
> +		return -EINVAL;
> +

Might it make sense to use

	err = copy_struct_from_user(&unotif, sizeof(unotif), buf, sizeof(unotif));
	if (err)
		return err;

This way we check that the whole struct is 0 and report an error as soon
as one of the members is non-zero. That's more drastic but it'd ensure
that other fields can be used in the future for whatever purposes.
It would also let us get rid of the memset() below. 

>  	memset(&unotif, 0, sizeof(unotif));
>  
>  	ret = down_interruptible(&filter->notif->request);
> -- 
> 2.20.1
> 
