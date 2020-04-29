Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD31BDDB9
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 15:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgD2NfV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Apr 2020 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgD2NfU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Apr 2020 09:35:20 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E3C03C1AD;
        Wed, 29 Apr 2020 06:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3tROvqtlLIi2o+RSP+jyp7tId3DmJ3ljzBXYvMBHEjM=; b=SW+FIFOIi/vh1yH3OFKw1kBfR
        NKALhZ7C9TqBNc3CWk0ERY4iQy2NDkI2kFaA+LhitjqWi4dUnO+PCFCwo3ifoXWISbr5r69aqYKRy
        RxesRtxTQZXegALW99+h/RsjReo1dYPoVAvONHckrDyASsXFf99FGkdepjGLOYVlBkHCAqGfRByX5
        Fs/NUZ1exmVJM+9WSH09rqtZRskoSpJhuQmO5ZlwImJ0k/cq+cWMOVBkUhDjJRYlCLLLHdFRn88FK
        eOAepy8KTmbWahz1wdjv9j22GBxlVokvUDbR9gRm5zLkukYB71vZ5tJoRMWbtDsymaZ6dsBGTzVs5
        PND73RCGw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:33798)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jTmrp-0007rI-8F; Wed, 29 Apr 2020 14:35:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jTmro-00016y-Bm; Wed, 29 Apr 2020 14:35:12 +0100
Date:   Wed, 29 Apr 2020 14:35:12 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] [v2] ARM: oabi-compat: fix epoll_ctl build failure
Message-ID: <20200429133512.GE1551@shell.armlinux.org.uk>
References: <20200429132349.1294904-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429132349.1294904-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 29, 2020 at 03:23:24PM +0200, Arnd Bergmann wrote:
> Two functions are not declared or defined when CONFIG_EPOLL is
> disabled:
> 
> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_ctl':
> arch/arm/kernel/sys_oabi-compat.c:258:6: error: implicit declaration of function 'ep_op_has_event' [-Werror=implicit-function-declaration]
>   258 |  if (ep_op_has_event(op) &&
>       |      ^~~~~~~~~~~~~~~
> arch/arm/kernel/sys_oabi-compat.c:265:9: error: implicit declaration of function 'do_epoll_ctl'; did you mean 'sys_epoll_ctl'? [-Werror=implicit-function-declaration]
>   265 |  return do_epoll_ctl(epfd, op, fd, &kernel, false);
>       |         ^~~~~~~~~~~~
>       |         sys_epoll_ctl
> 
> Replace the function with the sys_ni_syscall stub in this case.
> 
> Fixes: c281634c8652 ("ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use sys_ni_syscall() instead of removing the function body
> ---
>  arch/arm/kernel/sys_oabi-compat.c | 2 ++
>  kernel/sys_ni.c                   | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
> index 85a1e95341d8..2488c69242cf 100644
> --- a/arch/arm/kernel/sys_oabi-compat.c
> +++ b/arch/arm/kernel/sys_oabi-compat.c
> @@ -249,6 +249,7 @@ struct oabi_epoll_event {
>  	__u64 data;
>  } __attribute__ ((packed,aligned(4)));
>  
> +#ifdef CONFIG_EPOLL
>  asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
>  				   struct oabi_epoll_event __user *event)
>  {
> @@ -264,6 +265,7 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
>  
>  	return do_epoll_ctl(epfd, op, fd, &kernel, false);
>  }
> +#endif
>  
>  asmlinkage long sys_oabi_epoll_wait(int epfd,
>  				    struct oabi_epoll_event __user *events,
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 42ce28c460f6..9ee6a46b1795 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -68,6 +68,7 @@ COND_SYSCALL(epoll_create1);
>  COND_SYSCALL(epoll_ctl);
>  COND_SYSCALL(epoll_pwait);
>  COND_SYSCALL_COMPAT(epoll_pwait);
> +COND_SYSCALL(oabi_epoll_ctl); /* ARM OABI specific */
>  
>  /* fs/fcntl.c */
>  

I know what Chris said, but do we really want to be polluting generic
kernel files with arch specific stuff like this?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
