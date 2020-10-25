Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE02984B5
	for <lists+linux-api@lfdr.de>; Sun, 25 Oct 2020 23:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1419451AbgJYW3U (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 25 Oct 2020 18:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419360AbgJYW3U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 25 Oct 2020 18:29:20 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE9CC061755;
        Sun, 25 Oct 2020 15:29:19 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id h24so10730526ejg.9;
        Sun, 25 Oct 2020 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lh2oS0OcdW/8/KVlxidM+IVHUHZT9Oaa9CWag9blTrU=;
        b=lvfMgB6F7HQZQ8d7WfSI56Pd+ImLiyWdCjGsgXPLcOU0JXd5UAwHudJhDI8Lz2w74u
         uxk0v//O3brXwOBywx3aAPK8m57ZPw3VndRZSPuuyA/JqsJWTrv7IKBNlWQFVj56e/LI
         /jmxfgMnNhEwzmGPUW4lLCtosElcIhzYf9J+7vCVbsqUVu5nCcWR4dtP8wC5T+U31QFu
         whRsQU9g0j76ztPh+AdeBWYMlztpIdsrGO+QS5cz4shhXRvZivTrZ6RJl3RCTNQZCwm8
         OF1+Tu8uY5U5Y5a38Z3HaW3R5PInIMoe6QaIXnd3ssj5xFJ3mHpXtMz1x0eKPNUng01+
         kGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=lh2oS0OcdW/8/KVlxidM+IVHUHZT9Oaa9CWag9blTrU=;
        b=f8A7M+aqm/xCvWoxQpq+NI8sR1xVe1NVWhoa/yZoZV8rrgM8GQX7fx1UIvLchlGZE1
         XVJkM+7AG4nrjsV+Y1+QiHV1n76ZR+oEaxakJR8rTECLfHn7PgqJniNOs2F7Cr4UPS/z
         Eqwfs0RPiy0DZO35ooq/yBow+CDzUqD5/slc2MQIYSHespWHe0YmLNn3pR+x2PvJmCKA
         IlZEGTb8nu1Qgd5F1FDtJKYSKjJOwciskg+6L1ohHEafQg0Vfuw99TFoFqGy8Clh4g3t
         ZlS5hv7eGxeYHvj7bRaqBnRpiNDRxeF97TuhZ1FbSHWxxoYbQUi9AQcuWLOKXMGjIvjP
         oBBw==
X-Gm-Message-State: AOAM532k4XesH5D2ZgnPkF9R++cKTq7oYDCqkiHJmGpiA1X2E9ypLzQ7
        Q1qdJ8193W1OxnUy/SZTtXf/ZLqQPbuJ2g==
X-Google-Smtp-Source: ABdhPJybTN4d3NEuEwszBwb9KG4Fifsz/c2RociVCzidJ7soLTC19SpC6VfDoIDLLfhfkMWJD1vyTw==
X-Received: by 2002:a17:906:3488:: with SMTP id g8mr12379738ejb.296.1603664958123;
        Sun, 25 Oct 2020 15:29:18 -0700 (PDT)
Received: from x230 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id t15sm4144110edr.27.2020.10.25.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:29:17 -0700 (PDT)
Date:   Sun, 25 Oct 2020 23:29:15 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Rich Felker <dalias@aerifal.cx>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] uapi: Move constants from <linux/kernel.h> to
 <linux/const.h>
Message-ID: <20201025222915.GA40443@x230>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20201015190013.8901-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201015190013.8901-1-petr.vorel@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Pablo, Jozsef, Florian,

Cc you as the patch touched also netlink UAPI headers.

Kind regards,
Petr

> and include <linux/const.h> in UAPI headers instead of <linux/kernel.h>.

> The reason is to avoid indirect <linux/sysinfo.h> include when using
> some network headers: <linux/netlink.h> or others -> <linux/kernel.h>
> -> <linux/sysinfo.h>.

> This indirect include causes on MUSL redefinition of struct sysinfo when
> included both <sys/sysinfo.h> and some of UAPI headers:

> In file included from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/kernel.h:5,
>                  from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/netlink.h:5,
>                  from ../include/tst_netlink.h:14,
>                  from tst_crypto.c:13:
> x86_64-buildroot-linux-musl/sysroot/usr/include/linux/sysinfo.h:8:8: error: redefinition of ‘struct sysinfo’
>  struct sysinfo {
>         ^~~~~~~
> In file included from ../include/tst_safe_macros.h:15,
>                  from ../include/tst_test.h:93,
>                  from tst_crypto.c:11:
> x86_64-buildroot-linux-musl/sysroot/usr/include/sys/sysinfo.h:10:8: note: originally defined here

> Suggested-by: Rich Felker <dalias@aerifal.cx>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Changes v2->v3:
> * Move things to <linux/const.h> instead of creating new header
> <linux/align.h>.

> Kind regards,
> Petr

>  include/uapi/linux/const.h              | 5 +++++
>  include/uapi/linux/ethtool.h            | 2 +-
>  include/uapi/linux/kernel.h             | 9 +--------
>  include/uapi/linux/lightnvm.h           | 2 +-
>  include/uapi/linux/mroute6.h            | 2 +-
>  include/uapi/linux/netfilter/x_tables.h | 2 +-
>  include/uapi/linux/netlink.h            | 2 +-
>  include/uapi/linux/sysctl.h             | 2 +-
>  8 files changed, 12 insertions(+), 14 deletions(-)

> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> index 5ed721ad5b19..af2a44c08683 100644
> --- a/include/uapi/linux/const.h
> +++ b/include/uapi/linux/const.h
> @@ -28,4 +28,9 @@
>  #define _BITUL(x)	(_UL(1) << (x))
>  #define _BITULL(x)	(_ULL(1) << (x))

> +#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> +#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
> +
> +#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> +
>  #endif /* _UAPI_LINUX_CONST_H */
> diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> index b4f2d134e713..0a9cced74e6d 100644
> --- a/include/uapi/linux/ethtool.h
> +++ b/include/uapi/linux/ethtool.h
> @@ -14,7 +14,7 @@
>  #ifndef _UAPI_LINUX_ETHTOOL_H
>  #define _UAPI_LINUX_ETHTOOL_H

> -#include <linux/kernel.h>
> +#include <linux/const.h>
>  #include <linux/types.h>
>  #include <linux/if_ether.h>

> diff --git a/include/uapi/linux/kernel.h b/include/uapi/linux/kernel.h
> index 0ff8f7477847..fadf2db71fe8 100644
> --- a/include/uapi/linux/kernel.h
> +++ b/include/uapi/linux/kernel.h
> @@ -3,13 +3,6 @@
>  #define _UAPI_LINUX_KERNEL_H

>  #include <linux/sysinfo.h>
> -
> -/*
> - * 'kernel.h' contains some often-used function prototypes etc
> - */
> -#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
> -#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
> -
> -#define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> +#include <linux/const.h>

>  #endif /* _UAPI_LINUX_KERNEL_H */
> diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
> index f9a1be7fc696..ead2e72e5c88 100644
> --- a/include/uapi/linux/lightnvm.h
> +++ b/include/uapi/linux/lightnvm.h
> @@ -21,7 +21,7 @@
>  #define _UAPI_LINUX_LIGHTNVM_H

>  #ifdef __KERNEL__
> -#include <linux/kernel.h>
> +#include <linux/const.h>
>  #include <linux/ioctl.h>
>  #else /* __KERNEL__ */
>  #include <stdio.h>
> diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
> index c36177a86516..a1fd6173e2db 100644
> --- a/include/uapi/linux/mroute6.h
> +++ b/include/uapi/linux/mroute6.h
> @@ -2,7 +2,7 @@
>  #ifndef _UAPI__LINUX_MROUTE6_H
>  #define _UAPI__LINUX_MROUTE6_H

> -#include <linux/kernel.h>
> +#include <linux/const.h>
>  #include <linux/types.h>
>  #include <linux/sockios.h>
>  #include <linux/in6.h>		/* For struct sockaddr_in6. */
> diff --git a/include/uapi/linux/netfilter/x_tables.h b/include/uapi/linux/netfilter/x_tables.h
> index a8283f7dbc51..b8c6bb233ac1 100644
> --- a/include/uapi/linux/netfilter/x_tables.h
> +++ b/include/uapi/linux/netfilter/x_tables.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>  #ifndef _UAPI_X_TABLES_H
>  #define _UAPI_X_TABLES_H
> -#include <linux/kernel.h>
> +#include <linux/const.h>
>  #include <linux/types.h>

>  #define XT_FUNCTION_MAXNAMELEN 30
> diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> index eac8a6a648ea..7ba6d3b9cdec 100644
> --- a/include/uapi/linux/netlink.h
> +++ b/include/uapi/linux/netlink.h
> @@ -2,7 +2,7 @@
>  #ifndef _UAPI__LINUX_NETLINK_H
>  #define _UAPI__LINUX_NETLINK_H

> -#include <linux/kernel.h>
> +#include <linux/const.h>
>  #include <linux/socket.h> /* for __kernel_sa_family_t */
>  #include <linux/types.h>

> diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
> index 27c1ed2822e6..458179df9b27 100644
> --- a/include/uapi/linux/sysctl.h
> +++ b/include/uapi/linux/sysctl.h
> @@ -23,7 +23,7 @@
>  #ifndef _UAPI_LINUX_SYSCTL_H
>  #define _UAPI_LINUX_SYSCTL_H

> -#include <linux/kernel.h>
> +#include <linux/const.h>
>  #include <linux/types.h>
>  #include <linux/compiler.h>
