Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB01E2809B0
	for <lists+linux-api@lfdr.de>; Thu,  1 Oct 2020 23:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbgJAVwP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Oct 2020 17:52:15 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:59122 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgJAVwP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Oct 2020 17:52:15 -0400
Date:   Thu, 1 Oct 2020 17:52:13 -0400
From:   Rich Felker <dalias@aerifal.cx>
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, musl@lists.openwall.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        Peter Korsgaard <peter@korsgaard.com>,
        Florian Weimer <fweimer@redhat.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "David S . Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [musl] [PATCH 1/1] uapi: Don't include <linux/sysinfo.h> in
 <linux/kernel.h>
Message-ID: <20201001215212.GS17637@brightrain.aerifal.cx>
References: <20201001195231.17226-1-petr.vorel@gmail.com>
 <20201001201108.GR17637@brightrain.aerifal.cx>
 <20201001202703.GD24195@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001202703.GD24195@dell5510>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 01, 2020 at 10:27:03PM +0200, Petr Vorel wrote:
> Hi Rich,
> 
> > On Thu, Oct 01, 2020 at 09:52:31PM +0200, Petr Vorel wrote:
> > > + update code where needed (include <linux/sysinfo.h> in code which
> > > included <linux/kernel.h> only to get struct sysinfo or SI_LOAD_SHIFT).
> 
> > > The reason is to avoid indirect <linux/sysinfo.h> include when using
> > > some network headers: <linux/netlink.h> or others [1] ->
> > > <linux/kernel.h> -> <linux/sysinfo.h>.
> 
> > > This indirect include causes redefinition of struct sysinfo when
> > > included both <sys/sysinfo.h> and some of network headers:
> 
> > > In file included from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/kernel.h:5,
> > >                  from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/netlink.h:5,
> > >                  from ../include/tst_netlink.h:14,
> > >                  from tst_crypto.c:13:
> > > x86_64-buildroot-linux-musl/sysroot/usr/include/linux/sysinfo.h:8:8: error: redefinition of ‘struct sysinfo’
> > >  struct sysinfo {
> > >         ^~~~~~~
> > > In file included from ../include/tst_safe_macros.h:15,
> > >                  from ../include/tst_test.h:93,
> > >                  from tst_crypto.c:11:
> > > x86_64-buildroot-linux-musl/sysroot/usr/include/sys/sysinfo.h:10:8: note: originally defined here
> 
> > > [1] or <linux/sysctl.h>, <linux/ethtool.h>, <linux/mroute6.h>, <linux/ethtool.h>
> 
> > > Suggested-by: Rich Felker <dalias@aerifal.cx>
> > > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> > > ---
> > > Hi,
> 
> > > this looks to be long standing problem: python-psutil [2], iproute2 [3],
> > > even for glibc in the past [4] and it tried to be solved before [5].
> 
> > > This will require glibc fix after:
> 
> > You can't do this; it breaks the existing contract with glibc. New
> > kernel headers can't force a glibc upgrade.
> Right, got that.
> 
> > You just have to get rid
> > of use of <linux/kernel.h> elsewhere in the uapi headers. It was a
> > mistake that <linux/sysinfo.h> was ever separated out of
> > <linux/kernel.h> since it didn't (and couldn't) fix the contract that
> > <linux/kernel.h> exposes struct sysinfo (and that it's misnamed). But
> > it's no big deal. This can all be fixed without any breakage anywhere
> > just by not using it.
> Back to your original suggestion to move the alignment macros to a separate
> header. I was trying to avoid it not sure if introducing new header is
> acceptable, but we'll see.

Isn't there already another similar header with that type of macro
that they belong in?

Rich
