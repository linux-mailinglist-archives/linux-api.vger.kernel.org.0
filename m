Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E434DCAC
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 01:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhC2XzR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Mar 2021 19:55:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42900 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhC2Xyy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Mar 2021 19:54:54 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4057772C8C5;
        Tue, 30 Mar 2021 02:54:52 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 262387CC8A3; Tue, 30 Mar 2021 02:54:52 +0300 (MSK)
Date:   Tue, 30 Mar 2021 02:54:52 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        musl@lists.openwall.com, carlos@redhat.com, davem@davemloft.net
Subject: Re: Linux include/uapi/linux/libc-compat.h and Musl
 include/netinet/in.h incompatibility for __UAPI_DEF_IN6_ADDR_ALT
Message-ID: <20210329235451.GA20210@altlinux.org>
References: <CAFOYHZCoqSW3BDywr+u-pHTdupGQjqatD8hR_P1zCdjBWjy8aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFOYHZCoqSW3BDywr+u-pHTdupGQjqatD8hR_P1zCdjBWjy8aQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On Tue, Mar 30, 2021 at 12:30:52PM +1300, Chris Packham wrote:
> Hi,
> 
> I've come over from https://github.com/strace/strace/issues/177
> there's a bit of context there.
> 
> Crosstool-ng has hit a problem when building a recent enough version
> of strace in a configuration that uses musl libc.
> 
> The error is
> 
> [ALL  ]    In file included from
> /home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/bundled/linux/include/uapi/linux/in6.h:26,
> [ALL  ]                     from
> /home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/bundled/linux/include/uapi/linux/if_bridge.h:19,
> [ALL  ]                     from
> /home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/src/rtnl_mdb.c:16:
> [ERROR]    /home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/bundled/linux/include/uapi/linux/libc-compat.h:109:
> error: "__UAPI_DEF_IN6_ADDR_ALT" redefined [-Werror]
> [ALL  ]      109 | #define __UAPI_DEF_IN6_ADDR_ALT  1
> [ALL  ]          |
> [ALL  ]    In file included from
> /home/x-tool/.build/arm-unknown-linux-musleabi/src/strace/src/rtnl_mdb.c:15:
> [ALL  ]    /home/x-tool/x-tools/arm-unknown-linux-musleabi/arm-unknown-linux-musleabi/sysroot/usr/include/netinet/in.h:401:
> note: this is the location of the previous definition
> [ALL  ]      401 | #define __UAPI_DEF_IN6_ADDR_ALT 0
> [ALL  ]          |
> [ALL  ]    cc1: all warnings being treated as errors
> [ERROR]    make[4]: *** [Makefile:6660: libstrace_a-rtnl_mdb.o] Error 1
> [ALL  ]    make[4]: Leaving directory
> '/home/x-tool/.build/arm-unknown-linux-musleabi/build/build-strace/src'
> [ERROR]    make[3]: *** [Makefile:2404: all] Error 2
> [ALL  ]    rm ioctlsort0.o ioctls_all0.h ioctlsort0
> [ALL  ]    make[3]: Leaving directory
> '/home/x-tool/.build/arm-unknown-linux-musleabi/build/build-strace/src'
> [ERROR]    make[2]: *** [Makefile:601: all-recursive] Error 1
> [ALL  ]    make[2]: Leaving directory
> '/home/x-tool/.build/arm-unknown-linux-musleabi/build/build-strace'
> [ERROR]    make[1]: *** [Makefile:506: all] Error 2
> [ALL  ]    make[1]: Leaving directory
> '/home/x-tool/.build/arm-unknown-linux-musleabi/build/build-strace'
> 
> It appears that the bundled uapi headers definition of
> __UAPI_DEF_IN6_ADDR_ALT conflicts with the musl libc definition. It
> looks like libc-compat.h tries to co-exists with GNU libc but this
> isn't working for musl.

This essentially means that such basic things as
#include <netinet/in.h>
#include <linux/in6.h>
are broken in your setup.


-- 
ldv
