Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C2F12BCF1
	for <lists+linux-api@lfdr.de>; Sat, 28 Dec 2019 08:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfL1HJP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Dec 2019 02:09:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37585 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1HJP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Dec 2019 02:09:15 -0500
Received: from p5b12df56.dip0.t-ipconnect.de ([91.18.223.86] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1il6Do-0001Ct-Fn; Sat, 28 Dec 2019 07:09:12 +0000
Date:   Sat, 28 Dec 2019 08:09:11 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        tycho@tycho.ws, jannh@google.com, keescook@chromium.org,
        cyphar@cyphar.com
Subject: Re: [PATCH v2 2/2] seccomp: Check that seccomp_notif is zeroed out
 by the user
Message-ID: <20191228070910.qo7ahodfs2mzqw5t@wittgenstein>
References: <20191228014849.GA31783@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191228014849.GA31783@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 01:48:51AM +0000, Sargun Dhillon wrote:
> This patch is a small change in enforcement of the uapi for
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Specifically, the datastructure which
> is passed (seccomp_notif) must be zeroed out. Previously any of its
> members could be set to nonsense values, and we would ignore it.
> 
> This ensures all fields are set to their zero value.

The upper part is correct and useful.

> 
> This relies on the seccomp_notif datastructure to not have
> any unnamed padding, as it is valid to initialize the datastructure
> as:
> 
>   struct seccomp_notif notif = {};

The interesting part here is accidently leaking kernel addresses to
userspace. For this to be an issue we'd need to do
struct seccomp_notif unotif = {};
copy_to_user(<user-buffer>, &unotif, sizeof(unotif))
_and_ seccomp_notif would need to contain unintentional padding. Even if
the latter were true we still use memset() anwyay and will likely never
remove it. So the code here sure doesn't rely or depends on correct
padding at all. 

> 
> This only initializes named members to their 0-value [1].
> 
> [1]: https://lore.kernel.org/lkml/20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com/

That link isn't useful and also incorrectly claims that there is
non-intentional padding in the struct which there isn't.

Just drop that whole paragraph. The expectation is that all of our ABIs
are correctly padded anyway and this really just confuses more than it
helps.
Please resend, otherwise:

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

But see a small comment below.

> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  kernel/seccomp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 12d2227e5786..4fd73cbdd01e 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1026,6 +1026,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  	struct seccomp_notif unotif;
>  	ssize_t ret;
>  
> +	ret = check_zeroed_user(buf, sizeof(unotif));

It wouldn't hurt to place a small comment here so the reader can easily
spot we've ensured that this struct can be extended. But up to you...

/* Verify that we're not given garbage to keep struct extensible. */

> +	if (ret < 0)
> +		return ret;
> +	if (!ret)
> +		return -EINVAL;
> +
>  	memset(&unotif, 0, sizeof(unotif));
>  
>  	ret = down_interruptible(&filter->notif->request);
> -- 
> 2.20.1
> 
