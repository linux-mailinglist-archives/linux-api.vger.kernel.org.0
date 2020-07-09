Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB52219890
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgGIGW0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 02:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgGIGWZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 02:22:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C1C08C5DC
        for <linux-api@vger.kernel.org>; Wed,  8 Jul 2020 23:22:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so575276pfm.4
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2020 23:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwK6pLYPrPUs5yveGhJkt3hTcCJVlVwdvkUrxWZwIrA=;
        b=XK6g9oF5rVK8h2Ktpldva1AUJKn84SAYAySai+xmUGvYvLNfuStAl3CGnSkTzle9kE
         7VfZjjgOHVQO5f4asjNLbpIlpjrXh2afqX7pW1lVNHuAiZwtZ8j91gkuboRqoZXLSgNo
         j2+BkK7ndUpEYcXEO0B+pNhTWmGC6yn4K/kuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwK6pLYPrPUs5yveGhJkt3hTcCJVlVwdvkUrxWZwIrA=;
        b=GWyPq2BgGRyzccgl/xfRa3bZ/37BghjgmeiwDC7ZCk2AEwsOPjC2Yn+D4GoEmFWwDC
         jYd9BBiuq/NWNtcRUO9Bhmz7AJY7M5WuF9fBNKz4+1VlTpTM1gPGUymXC/2J2m8blDFF
         cpKUC9bSZuDhhRkmI/vKz3EX7r24A3zF0crufS5X/FjrY7OWhyjqjqV7B1rGOuQhj+I4
         WCXXTWiwOwU2ArbqyLoGTWFWUybT0LYY5RM/b6eup3H88gVPFv1NOIbsI7XE0d6hTfNH
         CEut522b7onWHiYDjPvjWhgwbd11GVW7KWrwi2WS3KsX+QK2uKmUqHiIigq/fVUUydyy
         /lbw==
X-Gm-Message-State: AOAM531TnDIUAJsCs55lEWyrmuA+2BoPJW8tsMuSCanUA5OTkH948P0x
        DxWxRuaUSC+DlEEGaFLx97/AqA==
X-Google-Smtp-Source: ABdhPJz6DzZ+MCgRaZ50Qj9ZS596r7B+aOgFDLQmqElZxP3SuvzOKNttykPpyoMSmZAOXe0ubfyoaA==
X-Received: by 2002:a05:6a00:15c7:: with SMTP id o7mr55029056pfu.51.1594275745079;
        Wed, 08 Jul 2020 23:22:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a19sm1549192pfn.136.2020.07.08.23.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 23:22:24 -0700 (PDT)
Date:   Wed, 8 Jul 2020 23:22:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Sargun Dhillon <sargun@sargun.me>, Will Drewry <wad@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Matt Denton <mpdenton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6.1 6/7] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202007082321.1C295A9F5@keescook>
References: <20200707133049.nfxc6vz6vcs26m3b@wittgenstein>
 <202007082314.A661DC3DD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007082314.A661DC3DD@keescook>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 08, 2020 at 11:17:27PM -0700, Kees Cook wrote:
> +static long seccomp_notify_addfd(struct seccomp_filter *filter,
> +				 struct seccomp_notif_addfd __user *uaddfd,
> +				 unsigned int size)
> +{
> +	struct seccomp_notif_addfd addfd;
> +	struct seccomp_knotif *knotif;
> +	struct seccomp_kaddfd kaddfd;
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct seccomp_notify_addfd) < SECCOMP_NOTIFY_ADDFD_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct seccomp_notify_addfd) != SECCOMP_NOTIFY_ADDFD_SIZE_LATEST);

*brown paper bag* I built the wrong tree! This is a typo:
seccomp_notify_addfd should be seccomp_notif_addfd (no "y").

-- 
Kees Cook
