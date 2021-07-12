Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F793C5AC0
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhGLKU6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGLKU4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 06:20:56 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DBDC0613E9;
        Mon, 12 Jul 2021 03:18:03 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h3so18809061ilc.9;
        Mon, 12 Jul 2021 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCCESK6Bc1wwnfg5+EzFKimyzbdn7k622CCYhv007tQ=;
        b=mNyl0Rh5ytiAYrqLqGBa6bx66uG0GZb2TA/Pb8M3DNT/fOVQn6k0MzIIEwKFT+2YMU
         b6YYT4Vh+bbvJyN18e5ro3hdfDedq2cI6BiazPPTfcCnQLqp45krYGFYO8KDqYpICvXB
         rBn5dXvKCZ+SpVMfKZ5NV7TGb5tAGitDT84m0FYEuK1WjczCbrH1oxhjCD2nr6UWLCrS
         cU5bjr7dhW0qUDjetshh1ah0WCsZ6+CwgWpvucMz3+LqE4djhUT1Wee2wOzbpelI95yz
         GLLkSTBCSL/X/FikRAmf71ygp6oKx3omrTR2AM8h6BYwaYqsOBbfegr4SfXworU2hGc1
         +GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCCESK6Bc1wwnfg5+EzFKimyzbdn7k622CCYhv007tQ=;
        b=uEsKoHFPwT20DNNA/7783Sq+nhzQISElwAnnx9P5pqTbBSQtczxeFGlK7dXyqHGdNK
         2OaYxCESLte1SXX7H8kQcE4GQ/rqRVojWnV8hNGV0lvUw89Uv/pABlW717Gkqf50ZPxc
         zISiZHwabD1/IugjCZZGCwbmdq2h8y7r0FoYTWvQgv3YI7KRDxyNBomcAl4D7aIfB1MN
         urBQotBlSyjzGV5mGumSYORIU2LKZeQdHJaYoiE9mnuDac1qW7z1d7OSUBVmWOJ5fDLC
         NAU0Sk0bRcAbnSnPSWa/ingwdzRK+C2Eh2tAOAN5yp9pMN6rVnca8/Qg93nsRIv3O8EZ
         1oWA==
X-Gm-Message-State: AOAM531qwUZtlz7Dba/MZLnRU4oOiYVbcjWubutSzFy9Jih3Xt6iF7pY
        X6W9dK8EHwmjxSjTEV7FgNusCupuHlk91DmkUlQ=
X-Google-Smtp-Source: ABdhPJzkczPjG/Xa9gJdDwwffQX6ykoawYLibXHgJcYo2Kz1/4jR5f8beUvN5/WlvhmPQFv1N6OCb1vgXYbeeJH6StM=
X-Received: by 2002:a05:6e02:1529:: with SMTP id i9mr2832886ilu.163.1626085083176;
 Mon, 12 Jul 2021 03:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210712083917.16361-1-david@redhat.com> <CAM9Jb+g7a5kY4DHzDzJTfs-mVEm_CFRcCeY2zdjo6sZWxkjnLA@mail.gmail.com>
 <406695f0-13c8-a052-92d4-44e884eb44af@redhat.com>
In-Reply-To: <406695f0-13c8-a052-92d4-44e884eb44af@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 12 Jul 2021 12:17:52 +0200
Message-ID: <CAM9Jb+gmCTdbVYX3+Y9F_KRNnYkGNGQvGRJRCBkJX6wjyzmpQQ@mail.gmail.com>
Subject: Re: [PATCH v1] madvise.2: Document MADV_POPULATE_READ and MADV_POPULATE_WRITE
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> >> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)
> >> +Populate (prefault) page tables writable for the whole range without actually
> >> +writing. Depending on the underlying mapping, preallocate memory or read the
> >
> > Is this read or write?
> > just reading and trying to understand :)
>
> It's reading. Assume you have a file with existing content mapped into a
> process. Once you touch a page (read/write/execute) that maps to blocks
> with existing content, you'll have to load these blocks from disk first.

Got it. Thanks for explaining!

Best regards,
Pankaj
