Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C901E0403
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 01:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbgEXXz0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 19:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388288AbgEXXzZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 19:55:25 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB566C05BD43
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:55:25 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v17so12698898ote.0
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8MyH6nzIQlYiHdNnVdBythLxUHVp7f9RRgFEbcuoxFU=;
        b=P2vHa+peapcgr3/0nquOLdtPXs2xHl3E9BUXZfbBpN0vJc0S9TsHiKdDK7Ji2fGNfe
         5WsNc6p5054tND/KkIB3Rx+dCI+mjwytZv2u+bel7HjKFgH8Yq5tXDNC4lX0iuyVP/8p
         JcFi488CmAKxohubrNAty48AFmrcXvEw5AZ43eu5RZeM9akjUAkPjiBxtHedRIdIHNgX
         EfyELME4YGM307rEqIk5rk9TaV+gF2XDHgdZCgo2aPKFa/ofh1v/gF8DMx4XmuYme5og
         qFhR5qc7O/bUpptKzPwmGfqNYkoBotWZCKCV0K++HdQQFoU5PPRWpRakH+pllH+moYg6
         nQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MyH6nzIQlYiHdNnVdBythLxUHVp7f9RRgFEbcuoxFU=;
        b=XWyGEQoOBYDL05zwc761lQWoSqkktWmqX/IEeKcpKwiZIXQjCvA2PXQtGU1Whz9R4y
         vYi+hIxPrGWhfrq4WIWoxCGO6vjiWnbyLcCq3KYMUEThWEbuVpPlbkljgA83L5p1zCtL
         PGgXdy/mQoBm5Yo7jIDzgUqpXyXvEWLydbg3cDgjtF1rmh9FBDrxqoy2wPumUy8AArZt
         RAMYwRzEunaXfzBL2+TDXz49SkMxzKsk3MoIKNHzMHFynB1DMIzSVTRnja02kQRcO3zo
         wrrV+sh9mRP4E/a3rwtxgJGzcshQYAwmBaAskVKGL1g//2sbxvG0OhIro+IETPlbfPMx
         rc9g==
X-Gm-Message-State: AOAM531yDgQCx4TqGyiNbcDlnhEzMLyXAB7fW0IJiZVcbMtjHa/BlcwG
        kTtdhOUj/Rv+OaKFk2oS/A7u9A==
X-Google-Smtp-Source: ABdhPJxD1Z1rx73XoSeCiDK+gRfaLVQ7JbSgF4B7fwPmv+QDjYFBVv64rOZxyTLCxxAQKsi8d4TUBQ==
X-Received: by 2002:a9d:6c56:: with SMTP id g22mr20019187otq.311.1590364524067;
        Sun, 24 May 2020 16:55:24 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:e9d7:5ec6:88ea:b4a1])
        by smtp.gmail.com with ESMTPSA id l26sm4622765oos.43.2020.05.24.16.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:55:23 -0700 (PDT)
Date:   Sun, 24 May 2020 17:55:25 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        christian.brauner@ubuntu.com, keescook@chromium.org,
        cyphar@cyphar.com, Jeffrey Vander Stoep <jeffv@google.com>,
        jannh@google.com, rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH 1/5] seccomp: Add find_notification helper
Message-ID: <20200524235525.GH2605652@cisco>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I think there's also an instance of this in _send() that we can change
to use find_notification() as well.

Tycho
