Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6D1E79F1
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 11:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgE2J6I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 05:58:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38449 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2J6E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 05:58:04 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jebm0-00055Y-M2; Fri, 29 May 2020 09:57:56 +0000
Date:   Fri, 29 May 2020 11:57:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     keescook@chromium.org, containers@lists.linux-foundation.org,
        cyphar@cyphar.com, jannh@google.com, jeffv@google.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        palmer@google.com, rsesek@google.com, tycho@tycho.ws,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH v2 1/3] seccomp: Add find_notification helper
Message-ID: <20200529095755.jv77m4qwtzr63do6@wittgenstein>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528110858.3265-2-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 28, 2020 at 04:08:56AM -0700, Sargun Dhillon wrote:
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

A single nit below otherwise:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  kernel/seccomp.c | 51 ++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 55a6184f5990..94ae4c7502cc 100644
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

Nit: additional \n which isn't present before any of the other new
find_notification() invocations.
