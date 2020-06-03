Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D514B1ECF0C
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2020 13:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFCLvO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Jun 2020 07:51:14 -0400
Received: from port70.net ([81.7.13.123]:51454 "EHLO port70.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgFCLvO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 3 Jun 2020 07:51:14 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 07:51:13 EDT
Received: by port70.net (Postfix, from userid 1002)
        id 3A60FABEC0C2; Wed,  3 Jun 2020 13:45:46 +0200 (CEST)
Date:   Wed, 3 Jun 2020 13:45:46 +0200
From:   Szabolcs Nagy <nsz@port70.net>
To:     Rich Felker <dalias@libc.org>
Cc:     musl@lists.openwall.com, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: sys/sysinfo.h clash with linux/kernel.h
Message-ID: <20200603114546.GA125404@port70.net>
Mail-Followup-To: Rich Felker <dalias@libc.org>, musl@lists.openwall.com,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20200602213704.GF1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602213704.GF1079@brightrain.aerifal.cx>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


i think the linux-api list is the right place for this
so adding it on cc.

* Rich Felker <dalias@libc.org> [2020-06-02 17:37:05 -0400]:
> linux/kernel.h is a uapi header that does almost nothing but define
> some internal-use alignment macros and -- oddly -- include
> linux/sysinfo.h to provide a definition of struct sysinfo. It's
> included only from 6 places in the kernel uapi headers:
> 
> include/uapi/linux/lightnvm.h
> include/uapi/linux/ethtool.h
> include/uapi/linux/sysctl.h
> include/uapi/linux/netlink.h
> include/uapi/linux/netfilter/x_tables.h
> include/uapi/linux/mroute6.h
> 
> However, it's also included from glibc's sys/sysinfo.h to provide
> struct sysinfo (glibc depends on the kernel for the definition). On
> musl, this produces a conflicting definition if both sys/sysinfo.h and
> any of the above 6 headers are included in the same file.
> 
> I think the underlying problem here is that the same header is used
> for two very disjoint purposes: by glibc as the provider of struct
> sysinfo, and by other kernel headers as provider of the alignment
> macros.
> 
> The glibc use is effectively a permanent contract that can't be
> changed, so what I'd like to do is move the macros out to a separate
> header (maybe linux/something_macros.h?) and have linux/kernel.h and
> the above 6 uapi headers all include that. Then nothing but
> linux/kernel.h would pull in linux/sysinfo.h.

i think providing a patch would make this happen faster.

ideally uapi would be reorganized such that it's clear
what headers are supposed to be compatible with inclusion
together with libc headers and what headers may conflict.

> 
> Note that in practice this is a rather hard issue to hit since almost
> nothing needs sysinfo() at the same time as the above uapi interfaces.
> However it did come up in toybox, which is how I first (just today)
> learned about the conflict, so it seems like something that should be
> fixed.
> 
> Rich
