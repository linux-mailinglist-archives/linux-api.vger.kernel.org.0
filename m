Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C463127B1
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 22:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBGVwH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 16:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBGVwG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 7 Feb 2021 16:52:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A4BC64E49;
        Sun,  7 Feb 2021 21:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612734685;
        bh=P4hDyuNTuefulj1FdkzvYzEyjfTpJGAPCBgeIztJKCM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aiqhgWBzXV4AzmQQ3FOIpJ+8g22/cdhbfgt1J5rc7iv8CNDMRsCNdIqJRBxuy++pF
         vSSeAM9wvJXq06Lww0xXRz1OLXhX1d59B76C8CcYQE/A8LT/GkDc7YlnUeYuyyArp9
         JNonboHjp/shpuCLJEFFcApxk/KOYx9m/eOm6biB7qgn5L9hMxMclfByBeRuLj9oms
         8zgWmgGkApMFjwpVPd7aZVjxqkhdul+WojsaSgdVwq4Anx2uZj79jxc8DMEIDQstXy
         g/Z9l8JumCrd3vhC+XaZbjK6hu5J5lspVB0tIM2OLMyS54aUxsyYEmUWPjnkDN10/3
         aG0/H10rqpiDg==
Received: by mail-oi1-f170.google.com with SMTP id i3so2870678oif.1;
        Sun, 07 Feb 2021 13:51:25 -0800 (PST)
X-Gm-Message-State: AOAM531trnum047DwCEETmPw/qWzSiQd1LMHdivFwvoQMv/8uqG2NThR
        R/9IjVqYj0QtN/8LGsxf1RbJ6I+prTzOdbW3DVE=
X-Google-Smtp-Source: ABdhPJztcgMCwC5vEH2C09j7j+GkAttNY0a5GTpilwvVIo0NrUu5XPRToZOgdItl3JcOdDFgY9DlSYVlj5gq9JEHorc=
X-Received: by 2002:aca:2117:: with SMTP id 23mr318015oiz.4.1612734684591;
 Sun, 07 Feb 2021 13:51:24 -0800 (PST)
MIME-Version: 1.0
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com> <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
In-Reply-To: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 7 Feb 2021 22:51:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a13aGbqvTxL+5OQxu-wPa6RDHQJkJ_n8O6YeOibbJQ2yg@mail.gmail.com>
Message-ID: <CAK8P3a13aGbqvTxL+5OQxu-wPa6RDHQJkJ_n8O6YeOibbJQ2yg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        gregkh <gregkh@linuxfoundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Sihang Chen <chensihang1@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Feb 7, 2021 at 9:18 AM Zhou Wang <wangzhou1@hisilicon.com> wrote:

> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index cccfbbe..3f49529 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
>  __SYSCALL(__NR_process_madvise, sys_process_madvise)
>  #define __NR_epoll_pwait2 441
>  __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
> +#define __NR_mempinfd 442
> +__SYSCALL(__NR_mempinfd, sys_mempinfd)

This adds a compat syscall for 32-bit tasks running on arm64 without adding
the same for the native arch/arm syscall table. Those two need to always
stay synchronized. In fact, new system call should ideally get assigned
on all architectures at the same time, with the same number (or +110
on arch/alpha).

         Arnd
