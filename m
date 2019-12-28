Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 480B212BE3B
	for <lists+linux-api@lfdr.de>; Sat, 28 Dec 2019 19:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfL1SS3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Dec 2019 13:18:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39067 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfL1SS3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Dec 2019 13:18:29 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so26893502ioh.6
        for <linux-api@vger.kernel.org>; Sat, 28 Dec 2019 10:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MZG5qGB/Ymv7HA+XNiXGukSQ3TbbXrFPeer637cNn9g=;
        b=IA0yXAVG+abRw4Z4X+DWQ8DtbjRWfpIwTBQuZOJLyCBLiiU1ppIZkHaIqkD8EH6FlS
         sMao0bFQR70l2D0pyb/KJi+9+ENhHK3q4zdEBHgiTBKfY5AEsjyxd2XtPYc+FV5GJtjA
         4T1cy7yhbN3p0tUte/1Bsjt+5WVPMEs7EnzUPjqIez08ZbTfgNtu5w7N6UJIlsY0J7iP
         4hio5sUQnLIPc1W4csYsKWqNYTq79flh96weviiNZQ97PoMDT+lgIaRa6dNBP8yf7eP0
         amKNd0zdTzBMc1qqk2RZonPmVmQ7zzlHAjOJD3kNnyT8oLw2b220qaVNUFrO5cKo+oTP
         Mslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MZG5qGB/Ymv7HA+XNiXGukSQ3TbbXrFPeer637cNn9g=;
        b=VOnbbmHDaPJMbM6jzYlEpo51Blamy76JEJWtVBJ5bO6xioK1D0Y4XfBL9WKfjZs+t6
         pTE2dE2cR7zN7kyHVYvdtlDwsanYY2gvxHvgprXjLAQZkmlYK82JBXyjXBQaG0+F7qiL
         r0KSpsr7wQUEjd4/Nnuo/+H34YIUHBrLYvYt37qFxdXoDG7iX89S0I4xWr9jnOIJy+te
         AZvlKdTAhe7hUq52FQX5fNdTIZ/OE5A2pLkwM4lVDGlIAAm4JZA/GcGGiyGhVjrvhe5n
         AUXorjQqE2bM2NJhy0JCi53HE9m92Pd/eLw//DYkv/Qr/aDGKID7o3qPkCY2pw71faVW
         Fw5Q==
X-Gm-Message-State: APjAAAUOPnMszPXTPRVrmi47KgtULBFFP7A8FpcJMA6ybYlqjAqCmyIr
        gOayn6Dx/Xh6Ss3EgkKEsSFswA==
X-Google-Smtp-Source: APXvYqwcq2aKETvc20VuwagdVmJO2wF0zZodmKrImSVplTSvllxYHvj7yXMVVu8vWpmwSW6cbEI3lQ==
X-Received: by 2002:a6b:731a:: with SMTP id e26mr38013162ioh.254.1577557108304;
        Sat, 28 Dec 2019 10:18:28 -0800 (PST)
Received: from cisco ([2601:282:902:b340:f166:b50c:bba2:408])
        by smtp.gmail.com with ESMTPSA id w21sm10299560ioc.34.2019.12.28.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 10:18:27 -0800 (PST)
Date:   Sat, 28 Dec 2019 11:18:25 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        jannh@google.com, christian.brauner@ubuntu.com,
        keescook@chromium.org, cyphar@cyphar.com
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <20191228181825.GB6746@cisco>
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 01:48:39AM +0000, Sargun Dhillon wrote:
> The seccomp_notif structure should be zeroed out prior to calling the
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
> whether these structures were zeroed out or not, so these worked.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  samples/seccomp/user-trap.c                   | 2 +-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> index 6d0125ca8af7..0ca8fb37cd79 100644
> --- a/samples/seccomp/user-trap.c
> +++ b/samples/seccomp/user-trap.c
> @@ -298,7 +298,6 @@ int main(void)
>  		req = malloc(sizes.seccomp_notif);
>  		if (!req)
>  			goto out_close;
> -		memset(req, 0, sizeof(*req));
>  
>  		resp = malloc(sizes.seccomp_notif_resp);
>  		if (!resp)
> @@ -306,6 +305,7 @@ int main(void)
>  		memset(resp, 0, sizeof(*resp));

I know it's unrelated, but it's probably worth sending a patch to fix
this to be sizes.seccomp_notif_resp instead of sizeof(*resp), since if
the kernel is older this will over-zero things. I can do that, or you
can add the patch to this series, just let me know which.

But in any case, this patch is:

Reviewed-by: Tycho Andersen <tycho@tycho.ws>

Cheers,

Tycho
