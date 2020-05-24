Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1FA1E0406
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 01:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgEXX5d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 19:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbgEXX5d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 19:57:33 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305C3C05BD43
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:57:32 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id i9so3293741ool.5
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BpvyLok9gg59rHQ96tPQz62O5JGQHpn3e1cNrN9rySg=;
        b=0SR5MhSCS0DP1pS/LdoJS5PhxrVO5tydztNhtW1omJkuFiGIB8aeravFNiBE6xijry
         1HtjaI0/u0oI7KAJWjEhC0M5XCy0XwhDOQ9xg17+UWM2CX7aY0FpE3Oup4s/IpWwiOtu
         Vmj1xyliJcXjkFD1R+cKGIfTjsMuN2ozaqpLNWg2FlKFZ8ct5fOHIOTU1iZ3hfQYD1gS
         g1kzeEmR2wIoi3NULMOX6Cy/PwX54npQ79yQuIvjZCGydwl2C31ouBLA8ZpZ2rjC+C+p
         j7EEjj9t4u+c75SgGTOoynDuyEtyP/kgDSh8y5iJrJ6Xdf+KTkVIzMM7RTrVz/+HQnpF
         cCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BpvyLok9gg59rHQ96tPQz62O5JGQHpn3e1cNrN9rySg=;
        b=UUo6+zyD8e1+vubTHKA+a4uyUkjwq9b2ujXGQSCWRQg9v54eXI+8GyO6RC1DlPhqUr
         qQarH+jG8GRB1jIfY+bW+HNlBfJQaSV9UVqZxGZP9KNpKGWkmlRCYO89M/rffd4qLSZS
         b7sGH0s2+HHajxdNzoLWUgdsrFpXcebcH81DrtZ92eooxRy9ztf5odGJK79kK1wTI3Go
         Wc751IKS/J6n0GgBr7y0f9QX79tkb8B7CyCppzFcZirSWChIO4ugxrPNCuYI7oHFnjNI
         HUvqMoqp5tpYsK2xHANUzXkaTfIhRUBzCI7OIrpdTu079ycaQ6GeT/eA5dkHbHTck43p
         PmJw==
X-Gm-Message-State: AOAM531JDDUS4M+YTpugKRDZthmgho0zkakwmc8VjbPwDVwUfyE3G9Ye
        XgfTBgtVWCQc5f32mmOiy1zL/A==
X-Google-Smtp-Source: ABdhPJwQsux1cordCUHJU+KfO5uaHmoIhE9Ty2bxegSzcdfkYw0V11jRjHORSFEwM9j6vlzjYtJrGw==
X-Received: by 2002:a4a:6c5:: with SMTP id 188mr3218734ooj.32.1590364651352;
        Sun, 24 May 2020 16:57:31 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:e9d7:5ec6:88ea:b4a1])
        by smtp.gmail.com with ESMTPSA id l8sm4617586otr.7.2020.05.24.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:57:30 -0700 (PDT)
Date:   Sun, 24 May 2020 17:57:32 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        christian.brauner@ubuntu.com, keescook@chromium.org,
        cyphar@cyphar.com, Jeffrey Vander Stoep <jeffv@google.com>,
        jannh@google.com, rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH 2/5] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200524235732.GI2605652@cisco>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-3-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524233942.8702-3-sargun@sargun.me>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 24, 2020 at 04:39:39PM -0700, Sargun Dhillon wrote:
> +static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> +{
> +	int ret;
> +
> +	/*
> +	 * Remove the notification, and reset the list pointers, indicating
> +	 * that it has been handled.
> +	 */
> +	list_del_init(&addfd->list);
> +
> +	ret = security_file_receive(addfd->file);
> +	if (ret)
> +		goto out;
> +
> +	if (addfd->fd >= 0) {
> +		ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
> +		if (ret >= 0)
> +			fput(addfd->file);
> +	} else {
> +		ret = get_unused_fd_flags(addfd->flags);
> +		if (ret >= 0)
> +			fd_install(ret, addfd->file);
> +	}
> +
> +out:
> +	addfd->ret = ret;
> +	complete(&addfd->completion);
> +}

My previous comment about SCM_RIGHTS still applies, right? That is, we
should do,

		sock = sock_from_file(fp[i], &err);
		if (sock) {
				sock_update_netprioidx(&sock->sk->sk_cgrp_data);
				sock_update_classid(&sock->sk->sk_cgrp_data);
		}

and perhaps lift that into a helper.

Tycho
