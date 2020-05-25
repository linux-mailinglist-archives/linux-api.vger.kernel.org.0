Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F81E0F74
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgEYN0R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 09:26:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37096 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388794AbgEYN0Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 09:26:16 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jdD7M-0001k3-Eu; Mon, 25 May 2020 13:26:12 +0000
Date:   Mon, 25 May 2020 15:26:11 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH 1/5] seccomp: Add find_notification helper
Message-ID: <20200525132611.ltpkbe6ditxkag2r@wittgenstein>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200524233942.8702-2-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 24, 2020 at 04:39:38PM -0700, Sargun Dhillon wrote:
> This adds a helper which can iterate through a seccomp_filter to
> find a notification matching an ID. It removes several replicated
> chunks of code.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Kees Cook <keescook@google.com>,
> Cc: Jann Horn <jannh@google.com>,
> Cc: Robert Sesek <rsesek@google.com>,
> Cc: Chris Palmer <palmer@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Tycho Andersen <tycho@tycho.ws>
> ---
>  kernel/seccomp.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 55a6184f5990..f6ce94b7a167 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1021,10 +1021,25 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +/* must be called with notif_lock held */
> +static inline struct seccomp_knotif *
> +find_notification(struct seccomp_filter *filter, u64 id)
> +{
> +	struct seccomp_knotif *cur;
> +
> +	list_for_each_entry(cur, &filter->notif->notifications, list) {
> +		if (cur->id == id)
> +			return cur;
> +	}
> +
> +	return NULL;
> +}
> +
> +
>  static long seccomp_notify_recv(struct seccomp_filter *filter,
>  				void __user *buf)
>  {
> -	struct seccomp_knotif *knotif = NULL, *cur;
> +	struct seccomp_knotif *knotif, *cur;
>  	struct seccomp_notif unotif;
>  	ssize_t ret;
>  
> @@ -1078,14 +1093,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
>  		 * may have died when we released the lock, so we need to make
>  		 * sure it's still around.
>  		 */
> -		knotif = NULL;
>  		mutex_lock(&filter->notify_lock);
> -		list_for_each_entry(cur, &filter->notif->notifications, list) {
> -			if (cur->id == unotif.id) {
> -				knotif = cur;
> -				break;
> -			}
> -		}
> +		knotif = find_notification(filter, unotif.id);
>  
>  		if (knotif) {
>  			knotif->state = SECCOMP_NOTIFY_INIT;
> @@ -1150,7 +1159,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
>  static long seccomp_notify_id_valid(struct seccomp_filter *filter,
>  				    void __user *buf)
>  {
> -	struct seccomp_knotif *knotif = NULL;
> +	struct seccomp_knotif *knotif;
>  	u64 id;
>  	long ret;
>  
> @@ -1162,15 +1171,10 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
>  		return ret;
>  
>  	ret = -ENOENT;
> -	list_for_each_entry(knotif, &filter->notif->notifications, list) {
> -		if (knotif->id == id) {
> -			if (knotif->state == SECCOMP_NOTIFY_SENT)
> -				ret = 0;
> -			goto out;
> -		}
> -	}
> +	knotif = find_notification(filter, id);
> +	if (knotif && knotif->state == SECCOMP_NOTIFY_SENT)
> +		ret = 0;

Coul be a little nicer to have this be:

if (knotif && knotif->state == SECCOMP_NOTIFY_SENT)
	ret = 0;
else
	ret = -ENOENT;

or, if you want to keep the assignment out of the lock:

ret = -ENOENT;
ret = mutex_lock_interruptible(&filter->notify_lock);
if (ret < 0)
	return ret;

knotif = find_notification(filter, id);
if (knotif && knotif->state == SECCOMP_NOTIFY_SENT)
	ret = 0;

otherwise looks like a good cleanup to me.
