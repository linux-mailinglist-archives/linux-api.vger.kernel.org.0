Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77699280872
	for <lists+linux-api@lfdr.de>; Thu,  1 Oct 2020 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgJAU1I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Oct 2020 16:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAU1H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Oct 2020 16:27:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99979C0613D0;
        Thu,  1 Oct 2020 13:27:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k18so4485606wmj.5;
        Thu, 01 Oct 2020 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EyAWOpM2Pk1ZBrqrrdSu1rvJL+knSPmewqYJM3X+YZM=;
        b=F/S72vRwMmvTJ8PZszfC8/s9iZSqKMIp6JFsHp/36W7P7WL0kTOBZl0wLTfDfoL/wi
         8WD7usifl3QPwN4x5b/SV0VnWj9SY5ac7BhI++csXd8RMaXHTxRF9JIq/MWsDpiNCnN5
         9Gf6dpGxpQCixE0zna1HpZ8uRyk0ztae+mSIFEmaqiafuJuvV4FA2Q68PbwDf9Qi9O/c
         gctjBXDPm2/SyD7NBPid3xT9mnjxpeDE+FQPHlINiy0HcSKPnsYzrbBxx13xdw3U97m3
         N5b2HUh3OFxpOX9VSvp4c/E4kn+rpH1V/TNU62j+tfCK8O0UIDCrIyZKSSnRsAHR/N+n
         Tn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=EyAWOpM2Pk1ZBrqrrdSu1rvJL+knSPmewqYJM3X+YZM=;
        b=GvNH1WXGMtpbuqjWxGn2iLFBeVxreaDNMHKuTr1oQnRsrbs90zUWch8LjZJNdsqiWz
         m/Vsrm1YXFB6wXpRfz57tgClfhOd4aD/BIHb27xcKnzRvys+BQVVbGuBbDNazycg9mBG
         rXAHkv3sHiwVSp9tciXyzW2vUAnRsx5LLZzdzzSkVLwV5AJDDObDMe8nEJhOilKU7bAu
         DY5WzSYKgBtHW8Asq4WAwoEtgFcs1850nqskr0maylVvYcsEUaFxa8+znV1HbRMrb8da
         mY18U3gknZGUW1HM4TnaBK8k08Xv0UR7DdXPJPeUqXN19M5kLD8YoVDBVj6NLDjKSLOh
         McgQ==
X-Gm-Message-State: AOAM531+Vm6V9c4pUkJit+18E7Eg0F8px4Tfn/Yr9GXtMzWBAl5zZUsx
        4G3RT94uR5R4zd8/lX+d7YI=
X-Google-Smtp-Source: ABdhPJxr5dY8ODx0EjH/xdbyXabo34Q9MVQw09XwyWKsxYblozqkXLVpvYyaSpB+6I9MEDSt2HvZhA==
X-Received: by 2002:a1c:9ad0:: with SMTP id c199mr1800943wme.54.1601584026233;
        Thu, 01 Oct 2020 13:27:06 -0700 (PDT)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id w15sm10273988wro.46.2020.10.01.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 13:27:05 -0700 (PDT)
Date:   Thu, 1 Oct 2020 22:27:03 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Rich Felker <dalias@aerifal.cx>
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
Message-ID: <20201001202703.GD24195@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20201001195231.17226-1-petr.vorel@gmail.com>
 <20201001201108.GR17637@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001201108.GR17637@brightrain.aerifal.cx>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Rich,

> On Thu, Oct 01, 2020 at 09:52:31PM +0200, Petr Vorel wrote:
> > + update code where needed (include <linux/sysinfo.h> in code which
> > included <linux/kernel.h> only to get struct sysinfo or SI_LOAD_SHIFT).

> > The reason is to avoid indirect <linux/sysinfo.h> include when using
> > some network headers: <linux/netlink.h> or others [1] ->
> > <linux/kernel.h> -> <linux/sysinfo.h>.

> > This indirect include causes redefinition of struct sysinfo when
> > included both <sys/sysinfo.h> and some of network headers:

> > In file included from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/kernel.h:5,
> >                  from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/netlink.h:5,
> >                  from ../include/tst_netlink.h:14,
> >                  from tst_crypto.c:13:
> > x86_64-buildroot-linux-musl/sysroot/usr/include/linux/sysinfo.h:8:8: error: redefinition of ‘struct sysinfo’
> >  struct sysinfo {
> >         ^~~~~~~
> > In file included from ../include/tst_safe_macros.h:15,
> >                  from ../include/tst_test.h:93,
> >                  from tst_crypto.c:11:
> > x86_64-buildroot-linux-musl/sysroot/usr/include/sys/sysinfo.h:10:8: note: originally defined here

> > [1] or <linux/sysctl.h>, <linux/ethtool.h>, <linux/mroute6.h>, <linux/ethtool.h>

> > Suggested-by: Rich Felker <dalias@aerifal.cx>
> > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> > ---
> > Hi,

> > this looks to be long standing problem: python-psutil [2], iproute2 [3],
> > even for glibc in the past [4] and it tried to be solved before [5].

> > This will require glibc fix after:

> You can't do this; it breaks the existing contract with glibc. New
> kernel headers can't force a glibc upgrade.
Right, got that.

> You just have to get rid
> of use of <linux/kernel.h> elsewhere in the uapi headers. It was a
> mistake that <linux/sysinfo.h> was ever separated out of
> <linux/kernel.h> since it didn't (and couldn't) fix the contract that
> <linux/kernel.h> exposes struct sysinfo (and that it's misnamed). But
> it's no big deal. This can all be fixed without any breakage anywhere
> just by not using it.
Back to your original suggestion to move the alignment macros to a separate
header. I was trying to avoid it not sure if introducing new header is
acceptable, but we'll see.

> Rich

Kind regards,
Petr
