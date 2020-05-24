Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE81E0409
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgEXX6f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 19:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbgEXX6f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 19:58:35 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C774BC061A0E
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:58:33 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f18so12620566otq.11
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ujgmu6qsF8KjwF0asTJwlN/jtHorDxcj3S3k6D7sfR4=;
        b=jV5abBUXtxyNey4FdgLuz5aknabD6HeVYSYsWWwVfhdAice2CVc4CA1W3B8auInwQE
         gnOuh9u7VPvwRnOLAx237unvR/r7zl/5Kg7025KjFSFCaS8HVAh71QRYqSlZX7UXNjQw
         77qmB+EB6hxMeAUPgbtrBZUHtGeWEAn+tQdTkU8cbUc71pT8kG8Gd2pCSXYvqOy1tXMh
         5MUMduFTA7+8GH/fZdRiZe5vl8bQKE+8p1ppqmDfc1llEvjph0KccZ6dx9AQPJN7GUco
         itgSd4SND67rD4CZXVhq5tZeI3YHToadTvsEjq+7QezEaPQ4yYBLEZzGe6jIlDOz1pbJ
         bQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ujgmu6qsF8KjwF0asTJwlN/jtHorDxcj3S3k6D7sfR4=;
        b=FuShQu837Sltll0GJdD6tcn2uI3M5gMjwtUgeFqQMm226sJeH546kCeYc2F+c+Lwrr
         TF8M5qR/f8hT/34q+IuiTBHKoJOdx1Wu5uXj0SfXFJKL/0bmyKfVHQcR4oGSIO5TNaeg
         ZySD+MbpuxVK+BXIZ4vXZfLSB1ipJ00A4u+VOLBKYdeymHcrJ8DaXsp/TYBP4jTOKWL9
         TpTAh7VRqodDbEr6iUO/KMhkNGbLFzLYk0r2fJmv69rYtODiDrZQgPh9V6h9xsKUvW9j
         aBxJ6vPgZq1wY2tP0g+eqnRG5xGpRJDURwOvxh0KkeYHjRUg/VkmZMDgXeEBF6/AmMDt
         pLsg==
X-Gm-Message-State: AOAM5306CPdpWKJrGE6igFoXALgq31/mg9CkGsXf1u5/9zEMBcRgQseM
        ad1Ynm1oJd2W7ufUdycrM1gB5g==
X-Google-Smtp-Source: ABdhPJx+fCXqTvAG+9ISY3kf3Llc7o0fLy7/xyCQNcjszyp+Ny99EH8k+j6pXMd/J4mglh/dYopq7A==
X-Received: by 2002:a9d:785a:: with SMTP id c26mr18109817otm.39.1590364713095;
        Sun, 24 May 2020 16:58:33 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:e9d7:5ec6:88ea:b4a1])
        by smtp.gmail.com with ESMTPSA id c184sm4808180oif.3.2020.05.24.16.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:58:32 -0700 (PDT)
Date:   Sun, 24 May 2020 17:58:34 -0600
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
Message-ID: <20200524235834.GJ2605652@cisco>
References: <20200524233942.8702-1-sargun@sargun.me>
 <20200524233942.8702-3-sargun@sargun.me>
 <20200524235732.GI2605652@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524235732.GI2605652@cisco>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 24, 2020 at 05:57:32PM -0600, Tycho Andersen wrote:
> On Sun, May 24, 2020 at 04:39:39PM -0700, Sargun Dhillon wrote:
> > +static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * Remove the notification, and reset the list pointers, indicating
> > +	 * that it has been handled.
> > +	 */
> > +	list_del_init(&addfd->list);
> > +
> > +	ret = security_file_receive(addfd->file);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (addfd->fd >= 0) {
> > +		ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
> > +		if (ret >= 0)
> > +			fput(addfd->file);
> > +	} else {
> > +		ret = get_unused_fd_flags(addfd->flags);
> > +		if (ret >= 0)
> > +			fd_install(ret, addfd->file);
> > +	}
> > +
> > +out:
> > +	addfd->ret = ret;
> > +	complete(&addfd->completion);
> > +}
> 
> My previous comment about SCM_RIGHTS still applies, right? That is, we
> should do,
> 
> 		sock = sock_from_file(fp[i], &err);
> 		if (sock) {
> 				sock_update_netprioidx(&sock->sk->sk_cgrp_data);
> 				sock_update_classid(&sock->sk->sk_cgrp_data);
> 		}
> 
> and perhaps lift that into a helper.

Oh, and now I see the later patch. But is there a reason to separate
these? I can't think of one.

Tycho
