Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568F6342F8D
	for <lists+linux-api@lfdr.de>; Sat, 20 Mar 2021 21:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCTUju (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 20 Mar 2021 16:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCTUj2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 20 Mar 2021 16:39:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B62C061763
        for <linux-api@vger.kernel.org>; Sat, 20 Mar 2021 13:39:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so6545774pjb.2
        for <linux-api@vger.kernel.org>; Sat, 20 Mar 2021 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZHBC6QZXpxmNvS4AKrcv1feZzlh3YLdyfSboLcCgalw=;
        b=LV5XunF4WpyNMtdfOBeJWjNaaCWuoSliYkz4GyOXgJevN9hca8vbBFNa5xbJRZQZoE
         KoRYrdHdn6xNinPJ19tA7nD0qwyhhP+YRRDsFlMNOwfMoz5VFNBqteQcOKzfQYD0IHkN
         VS7m9Zu9hff+u0USfPPMQ7VHVtDIhlkGhfqXUXs89XuHX5WXHd4s8qFDmc85hkI2LoiH
         2cy4buwUJUiIojM8J6njI6wPPDr8eNwWYVvTcPC1pR04ew7gqtk69HEjTGDaUQI0mlKN
         AxvbFfFmAF/Zs0PnO36Jh4+FF1C5xwt150M52+3JE2HnojGHQHoysX2u5pI6b8P+f+bQ
         eaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHBC6QZXpxmNvS4AKrcv1feZzlh3YLdyfSboLcCgalw=;
        b=V000EMZb9TOK77JWok5YyieRCgw9HOtWlkKnvyI3H+0y3VShfB0yMOqcNoGbV06Nvx
         UDkXVIu1Fgc+5FITNZ/nxPgQQjXt8e9FNwwJarVLPQtG4vIu0Yb2g/Uu6iRzxMzlcQZf
         vAYujZjgmvNKOlg+k7SozmeLGmaBhtn4pMdG1hszvbwyfQSSs1JsFY/CoLfb3TV3b+SH
         DTO1duLoL+bftiwTTb8e2Pg29J17UjR1DzGvMIpb+u66BKoKTMzgsESWfShvi4esnVIV
         WcL41hUds/rUP7aABm4UgtpQBLNo47xkTdbbzyWS3aN6oMZ3LJvedFKtl4PsTvxmQcaA
         cSew==
X-Gm-Message-State: AOAM530zUpfWN/u4eKZYaQabv/7sBrzW41BrKvtaaJhtuGNjfu4VZlBr
        sSGSVl+RORAMfXyLuyD3nEgCnQ==
X-Google-Smtp-Source: ABdhPJy1nXvWpOwSg8k85m3SSWUhsCzgDXO/rPo5cViY3+eCGtXw6dpISBhCCp/vC0s8wgOIUanX7Q==
X-Received: by 2002:a17:90a:e646:: with SMTP id ep6mr5134775pjb.101.1616272767462;
        Sat, 20 Mar 2021 13:39:27 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::9e01])
        by smtp.gmail.com with ESMTPSA id v13sm8425303pfu.54.2021.03.20.13.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 13:39:26 -0700 (PDT)
Date:   Sat, 20 Mar 2021 13:39:22 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
Message-ID: <YFZdemoHyMcrEGQm@relinquished.localdomain>
References: <cover.1615922644.git.osandov@fb.com>
 <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain>
 <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
 <YFUTnDaCdjWHHht5@relinquished.localdomain>
 <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
 <YFUpvFyXD0WoUHFu@relinquished.localdomain>
 <CAHk-=whrT6C-fsUex1csb4OSi06LwaCNGVJYnnitaA80w9Ua7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whrT6C-fsUex1csb4OSi06LwaCNGVJYnnitaA80w9Ua7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 19, 2021 at 05:31:18PM -0700, Linus Torvalds wrote:
> On Fri, Mar 19, 2021 at 3:46 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > Not much shorter, but it is easier to follow.
> 
> Yeah, that looks about right to me.
> 
> You should probably use kmap_local_page() rather than kmap_atomic()
> these days, but other than that this looks fairly straightforward, and
> I much prefer the model where we very much force that "must be the
> first iovec entry".

To be exact, this code only enforces that the iov_iter is at the
beginning of the current entry. As far as I can tell, iov_iter doesn't
track its position overall, so there's no way to tell whether the
current entry is the first one.

> As you say, maybe not shorter, but a lot more straightforward.
> 
> That said, looking through the patch series, I see at least one other
> issue. Look at parisc:
> 
>     +#define O_ALLOW_ENCODED 100000000
> 
> yeah, that's completely wrong. I see how it happened, but that's _really_ wrong.

Ugh, that's embarrassing. It also happens to add exactly one new bit to
VALID_OPEN_FLAGS, so the BUILD_BUG_ON() in fcntl_init() didn't catch it.

> I would want others to take a look in case there's something else. I'm
> not qualified to comment about (nor do I deeply care) about the btrfs
> parts, but the generic interface parts should most definitely get more
> attention.
> 
> By Al, if possible, but other fs people too..

That's all I ask. I'll fix your comments and wait a few days to get some
more feedback on the fs side before I resend the patch bomb.

Thanks,
Omar
