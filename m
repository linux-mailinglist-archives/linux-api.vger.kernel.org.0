Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF721E0412
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 02:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgEYAFs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 20:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbgEYAFs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 20:05:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9876C061A0E;
        Sun, 24 May 2020 17:05:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jd0cb-00Euph-HX; Mon, 25 May 2020 00:05:37 +0000
Date:   Mon, 25 May 2020 01:05:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        christian.brauner@ubuntu.com, tycho@tycho.ws,
        keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH 2/5] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <20200525000537.GB23230@ZenIV.linux.org.uk>
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

Bad refcounting rules.  *IF* we go with anything of that sort (and I'm not
convinced that the entire series makes sense), it's better to have more
uniform rules re reference consumption/disposal.

Make the destructor of addfd *ALWAYS* drop its reference.  And have this
function go

	if (addfd->fd >= 0) {
		ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
	} else {
		ret = get_unused_fd_flags(addfd->flags);
		if (ret >= 0)
			fd_install(ret, get_file(addfd->file));
	}

