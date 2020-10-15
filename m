Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3832828F9E3
	for <lists+linux-api@lfdr.de>; Thu, 15 Oct 2020 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgJOUGY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Oct 2020 16:06:24 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34434 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbgJOUGY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Oct 2020 16:06:24 -0400
Date:   Thu, 15 Oct 2020 16:06:23 -0400
From:   Rich Felker <dalias@aerifal.cx>
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, musl@lists.openwall.com,
        Peter Korsgaard <peter@korsgaard.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: Re: [musl] [PATCH v3 1/1] uapi: Move constants from <linux/kernel.h>
 to <linux/const.h>
Message-ID: <20201015200622.GY17637@brightrain.aerifal.cx>
References: <20201015190013.8901-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201015190013.8901-1-petr.vorel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 15, 2020 at 09:00:13PM +0200, Petr Vorel wrote:
> and include <linux/const.h> in UAPI headers instead of <linux/kernel.h>.
> 
> The reason is to avoid indirect <linux/sysinfo.h> include when using
> some network headers: <linux/netlink.h> or others -> <linux/kernel.h>
> -> <linux/sysinfo.h>.
> 
> This indirect include causes on MUSL redefinition of struct sysinfo when
> included both <sys/sysinfo.h> and some of UAPI headers:
> 
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
> 
> Suggested-by: Rich Felker <dalias@aerifal.cx>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Changes v2->v3:
> * Move things to <linux/const.h> instead of creating new header
> <linux/align.h>.
> 
> Kind regards,
> Petr
> 
>  include/uapi/linux/const.h              | 5 +++++
>  include/uapi/linux/ethtool.h            | 2 +-
>  include/uapi/linux/kernel.h             | 9 +--------
>  include/uapi/linux/lightnvm.h           | 2 +-
>  include/uapi/linux/mroute6.h            | 2 +-
>  include/uapi/linux/netfilter/x_tables.h | 2 +-
>  include/uapi/linux/netlink.h            | 2 +-
>  include/uapi/linux/sysctl.h             | 2 +-
>  8 files changed, 12 insertions(+), 14 deletions(-)

Acked-by: Rich Felker <dalias@libc.org>
