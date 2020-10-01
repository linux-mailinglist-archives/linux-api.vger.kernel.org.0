Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E977C280A32
	for <lists+linux-api@lfdr.de>; Fri,  2 Oct 2020 00:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgJAWaA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Oct 2020 18:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbgJAW3q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Oct 2020 18:29:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50271C0613D0;
        Thu,  1 Oct 2020 15:29:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k10so426161wru.6;
        Thu, 01 Oct 2020 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AAKj3dJf1aYEpRZkFDQ7jwadjHV40sERxEArpZqpOcg=;
        b=CN24H7pOdz3Q3mQvWNa4iqQadizzygHHrOkrWrsGEUSO9Nfm2a40Gwb3KHXKxfjrYT
         pxkdia8xJpT2OLOnE8n4p9TV9E7FmljmpA4PnRITHQDlE52+6WUnozf9piRtQMrjQb/k
         Ry9kJmG1nD6qBh5LCmelYbcWW5kpKbXwPDJ8R39pgL8Bb8oRKh5iDkZmRlgsLoF1C9VX
         b6cuxQbIUMvrrY7Gv1nf15AMurYEtJOlCZuLXZdOtOvUwXLL45BHEcUsamzEcOJc3gxy
         Z4rsU43AYoRQh11E6gqQ+otWprMYvxM/HC5nS6ExGdHGZGg/LNwGLV8essAKPZJpVTGP
         PP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=AAKj3dJf1aYEpRZkFDQ7jwadjHV40sERxEArpZqpOcg=;
        b=kbKE3WxpwvbBh2ysb5ppF1C3FHE96WWMkjnHO4z7u8Gc0bzYqG/oCPbSKx4dhX1YW9
         gquJAEOhnwvI/uMXwxbvOlQM32jiLZu8oY2rRR9rTHpRbqrzDGKfYm9DiS6nAzjLBXzA
         vB9roKNg2+eO7xCM14kPrqucrBt/B6DumGduUbl8EpE5BuJEVh+i98Qk5iY6rp6MKbOQ
         QBSRgzv2cQ8nIHs6jldLDHdAxvqMPMcV60lKpjv4UnScS2CfNGOpYD6+ffY/sr4u1HiR
         CiuP2DuA2LjfBe5abulj9NFjKF3OkpNVhmR5XBkC2YNu1o2Js7LIW7cxv7bkLJ2vk959
         DU1w==
X-Gm-Message-State: AOAM530ADh9HxPrNYhYIs6GdDolbaKxzdT97VjY1CRR6TPjBdNMYJwjZ
        CKD5qoYiLWz4t9JGhmBEYVVUn8r0nR4WxA==
X-Google-Smtp-Source: ABdhPJyIexnUrKpzze/MmHSmfkLrDe5RCjgIxFaT1WXqPQAIckz3fnKCiU/u9V7v7xK3OsedNy/1tA==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr11370102wrp.396.1601591384928;
        Thu, 01 Oct 2020 15:29:44 -0700 (PDT)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id t203sm1883249wmg.43.2020.10.01.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 15:29:44 -0700 (PDT)
Date:   Fri, 2 Oct 2020 00:29:42 +0200
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
Message-ID: <20201001222942.GE24195@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20201001195231.17226-1-petr.vorel@gmail.com>
 <20201001201108.GR17637@brightrain.aerifal.cx>
 <20201001202703.GD24195@dell5510>
 <20201001215212.GS17637@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001215212.GS17637@brightrain.aerifal.cx>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

> On Thu, Oct 01, 2020 at 10:27:03PM +0200, Petr Vorel wrote:
> > Hi Rich,

> > > On Thu, Oct 01, 2020 at 09:52:31PM +0200, Petr Vorel wrote:
> > > > + update code where needed (include <linux/sysinfo.h> in code which
> > > > included <linux/kernel.h> only to get struct sysinfo or SI_LOAD_SHIFT).

> > > > The reason is to avoid indirect <linux/sysinfo.h> include when using
> > > > some network headers: <linux/netlink.h> or others [1] ->
> > > > <linux/kernel.h> -> <linux/sysinfo.h>.

> > > > This indirect include causes redefinition of struct sysinfo when
> > > > included both <sys/sysinfo.h> and some of network headers:

> > > > In file included from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/kernel.h:5,
> > > >                  from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/netlink.h:5,
> > > >                  from ../include/tst_netlink.h:14,
> > > >                  from tst_crypto.c:13:
> > > > x86_64-buildroot-linux-musl/sysroot/usr/include/linux/sysinfo.h:8:8: error: redefinition of ‘struct sysinfo’
> > > >  struct sysinfo {
> > > >         ^~~~~~~
> > > > In file included from ../include/tst_safe_macros.h:15,
> > > >                  from ../include/tst_test.h:93,
> > > >                  from tst_crypto.c:11:
> > > > x86_64-buildroot-linux-musl/sysroot/usr/include/sys/sysinfo.h:10:8: note: originally defined here

> > > > [1] or <linux/sysctl.h>, <linux/ethtool.h>, <linux/mroute6.h>, <linux/ethtool.h>

> > > > Suggested-by: Rich Felker <dalias@aerifal.cx>
> > > > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> > > > ---
> > > > Hi,

> > > > this looks to be long standing problem: python-psutil [2], iproute2 [3],
> > > > even for glibc in the past [4] and it tried to be solved before [5].

> > > > This will require glibc fix after:

> > > You can't do this; it breaks the existing contract with glibc. New
> > > kernel headers can't force a glibc upgrade.
> > Right, got that.

> > > You just have to get rid
> > > of use of <linux/kernel.h> elsewhere in the uapi headers. It was a
> > > mistake that <linux/sysinfo.h> was ever separated out of
> > > <linux/kernel.h> since it didn't (and couldn't) fix the contract that
> > > <linux/kernel.h> exposes struct sysinfo (and that it's misnamed). But
> > > it's no big deal. This can all be fixed without any breakage anywhere
> > > just by not using it.
> > Back to your original suggestion to move the alignment macros to a separate
> > header. I was trying to avoid it not sure if introducing new header is
> > acceptable, but we'll see.

> Isn't there already another similar header with that type of macro
> that they belong in?
The only one I've found is const.h. Not sure it'd be better to move things
there.

Kind regards,
Petr

> Rich
