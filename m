Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38F21FD5BF
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2020 22:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgFQUIq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Jun 2020 16:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUIq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Jun 2020 16:08:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A75C06174E;
        Wed, 17 Jun 2020 13:08:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s135so1822083pgs.2;
        Wed, 17 Jun 2020 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zChdCEJKv6aEFStDDFwxt0kTJoxbtwI8fZON9NJ6buc=;
        b=McUcgYUZOSHbrlp3uHO0l9GK/XPkxkx9CIUyd4Uycke60AIohloCETmah78QTyH1a3
         3iDi6lRDlwgyGoFh+OM8s8W0bzZ0cO+3/fbh36KOsxFaW8hfSLOYqJe6hROad0DGVcxd
         NpVbnkXS8/F7kPoj5NT7wa1mgYDzSHWBfc4pi79Sk5KgsOWwnKc5PkIYVEZpLHn53hHg
         r1ly1NSBfQk6zTSmHTWMbORtWto3byuazhZUdc8D60qpixOebJRAObKPC85uzyVrCltA
         qHItcCTrqTOy5tmo+NZ2MAMkPzfxaXz71lv7c9xKMTgUdj2lQFigOGfynIrK/0nHS9sA
         FVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zChdCEJKv6aEFStDDFwxt0kTJoxbtwI8fZON9NJ6buc=;
        b=fSx/jrDxMPIbOd4IjUdmtg4+ltNbitl8QyAPLjd5KP1ZzKH3b90W1hmYE9w276L+q+
         cjtf7++O6/Wm9Vjxfgj6G2tOhXWH0We+lD1Wxg+6Ailzua29milZ8fLKIkWNX8WHRkXW
         QaQfT+ymkN6BdAl8SeEZ800dE7vJfWnrXbs5YW5yV/HayKJqvJMpc2ivhp6qbOruBtmM
         gwcvx9YSZZneqg4vX27BD+P/e5yOIw4wmNYIqa4f9BbFIP8VX3UDOTyVX1ZSFeG9AbOI
         FCtxXsMnscjXPS0kPK+u48HNRDDo7oMk5zSb6J51sN4WUVzDCF4Rg1hjpUouCinSy7oT
         Sq3A==
X-Gm-Message-State: AOAM530rmpdDORPxIIgRAdAh8zJ6m7nEnnocQJSbfq2Zl6xwWRFbHVMU
        Ktlw9mbdmW3GPFdPwvoU5Ko=
X-Google-Smtp-Source: ABdhPJwLpzQsp/pBP/vdlMXJeVVYHPJTs7FBuEhlCyU+rQH1gretkBJPgRGGB7/5bAGYZsRENho5Pw==
X-Received: by 2002:a63:6d86:: with SMTP id i128mr426545pgc.432.1592424525811;
        Wed, 17 Jun 2020 13:08:45 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([89.46.114.144])
        by smtp.gmail.com with ESMTPSA id 130sm596937pfw.176.2020.06.17.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:08:45 -0700 (PDT)
Date:   Wed, 17 Jun 2020 13:08:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     containers@lists.linux-foundation.org, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com,
        cyphar@cyphar.com, jannh@google.com, jeffv@google.com,
        palmer@google.com, rsesek@google.com, tycho@tycho.ws,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH v3] seccomp: Add find_notification helper
Message-ID: <20200617200844.GA12976@Ryzen-9-3900X.localdomain>
References: <20200601112532.150158-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601112532.150158-1-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 01, 2020 at 04:25:32AM -0700, Sargun Dhillon wrote:
> This adds a helper which can iterate through a seccomp_filter to
> find a notification matching an ID. It removes several replicated
> chunks of code.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Kees Cook <keescook@google.com>,
> Cc: Jann Horn <jannh@google.com>,
> Cc: Robert Sesek <rsesek@google.com>,
> Cc: Chris Palmer <palmer@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Tycho Andersen <tycho@tycho.ws>
> ---
>  kernel/seccomp.c | 55 ++++++++++++++++++++++++------------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 55a6184f5990..cc6b47173a95 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -41,6 +41,7 @@
>  #include <linux/tracehook.h>
>  #include <linux/uaccess.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/lockdep.h>
>  
>  enum notify_state {
>  	SECCOMP_NOTIFY_INIT,
> @@ -1021,10 +1022,27 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +/* must be called with notif_lock held */
> +static inline struct seccomp_knotif *
> +find_notification(struct seccomp_filter *filter, u64 id)
> +{
> +	struct seccomp_knotif *cur;
> +
> +	lockdep_assert_held(&filter->notify_lock);
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
> @@ -1078,15 +1096,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
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
> -
> +		knotif = find_notification(filter, unotif.id);
>  		if (knotif) {
>  			knotif->state = SECCOMP_NOTIFY_INIT;
>  			up(&filter->notif->request);
> @@ -1101,7 +1112,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
>  				void __user *buf)
>  {
>  	struct seccomp_notif_resp resp = {};
> -	struct seccomp_knotif *knotif = NULL, *cur;
> +	struct seccomp_knotif *knotif;
>  	long ret;
>  
>  	if (copy_from_user(&resp, buf, sizeof(resp)))
> @@ -1118,13 +1129,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
>  	if (ret < 0)
>  		return ret;
>  
> -	list_for_each_entry(cur, &filter->notif->notifications, list) {
> -		if (cur->id == resp.id) {
> -			knotif = cur;
> -			break;
> -		}
> -	}
> -
> +	knotif = find_notification(filter, resp.id);
>  	if (!knotif) {
>  		ret = -ENOENT;
>  		goto out;
> @@ -1150,7 +1155,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
>  static long seccomp_notify_id_valid(struct seccomp_filter *filter,
>  				    void __user *buf)
>  {
> -	struct seccomp_knotif *knotif = NULL;

I don't know that this should have been removed, clang now warns:

kernel/seccomp.c:1063:2: warning: variable 'knotif' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
        list_for_each_entry(cur, &filter->notif->notifications, list) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/list.h:602:7: note: expanded from macro 'list_for_each_entry'
             &pos->member != (head);                                    \
             ^~~~~~~~~~~~~~~~~~~~~~
kernel/seccomp.c:1075:7: note: uninitialized use occurs here
        if (!knotif) {
             ^~~~~~
kernel/seccomp.c:1063:2: note: remove the condition if it is always true
        list_for_each_entry(cur, &filter->notif->notifications, list) {
        ^
include/linux/list.h:602:7: note: expanded from macro 'list_for_each_entry'
             &pos->member != (head);                                    \
             ^
kernel/seccomp.c:1045:31: note: initialize the variable 'knotif' to silence this warning
        struct seccomp_knotif *knotif, *cur;
                                     ^
                                      = NULL
1 warning generated.

> +	struct seccomp_knotif *knotif;
>  	u64 id;
>  	long ret;
>  
> @@ -1161,16 +1166,12 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = -ENOENT;
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
> +	else
> +		ret = -ENOENT;
>  
> -out:
>  	mutex_unlock(&filter->notify_lock);
>  	return ret;
>  }
> -- 
> 2.25.1
> 

Cheers,
Nathan
