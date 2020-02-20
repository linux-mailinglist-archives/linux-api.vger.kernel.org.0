Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB016666A
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgBTShK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 13:37:10 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38331 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBTShI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 13:37:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id p23so34891531edr.5
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 10:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YLO2bhUMXaHjjPXShp3huY7KpBtYfU38ziSj3KJtuA=;
        b=GesQ7lYk8wtZKtmYXQL7fOf8FPAcNkpaXnz+pGMSsJ6UFBQf3mabWlZGElbQsvjQYq
         Czb00gxji/FQzvdSbj/gzPxrmrly/B/H73V5+iih6bnYg1dlzlo2pBrDFFLm9co9oYOI
         0k+O0x/3t3FF8+8tFiUTS8CsL/Q+nQGCL6gD4XLjMLQ2My+WEQdk2vqSNuPmRSu6yvoH
         P+k5oO3SwR+9M5xefJGB1ysLKencdBayMGWZT+Wzf0A6+T27omS+WvK2GhxURkJEGybm
         Yvps14ZPdFJdVa7Qfnn2znyx/CoTXsSlLYgIWP35JipzWdYdy5lRg6t3TJ1tMm5BEGhB
         +pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YLO2bhUMXaHjjPXShp3huY7KpBtYfU38ziSj3KJtuA=;
        b=hVpYVPhEXc3EV/qJFDWEXWHR5vV+6DS5HSBeLHWB0vNMR2fyYxE6S69G/wCHitHbfI
         BGmQQn1duUWCSa++OtzGWijUpyxBtbtHFdACfZOBXcA4/o1UTyqcjNGDjzbz8ro830t6
         nTMkWsczjr2NH6Svoaj2WX9rKpEv91PTZsNXkTYRAL7DG96TS3Uz2l2twRkU8N7xvtIC
         WGRaRyafDpz9xXtohw/lbYc51s1aFsGBihN8/GVfLRkJMddHfzBE9D9s+bLNGdgLP8WT
         k65frNLn9mZYSpQr0iE6r6UAFO2Gu2xAqzO2sdbBoFI3rkWbUdcZr8tebWah6trvw6ix
         uUVQ==
X-Gm-Message-State: APjAAAUD7y/9BEmESjXi+/KCaMkcC56ljz06pFBcbODVGhh5TWGm2cYm
        M++9riZHGtoHFz/Oub9bLrF1ci9WqOdLKWWDHYZ6xw==
X-Google-Smtp-Source: APXvYqxrghlu/JDWCN4t4BnUKHd0MsnmE1Vp+aqUdtfvoWzihkUYU4fRwdrUP4RI6V9L0uALG2Pft6Zxunx7cJsOx0c=
X-Received: by 2002:a17:906:4e01:: with SMTP id z1mr31260697eju.46.1582223824847;
 Thu, 20 Feb 2020 10:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20200218173221.237674-1-bgeffon@google.com> <20200220171554.GA44866@google.com>
In-Reply-To: <20200220171554.GA44866@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 20 Feb 2020 10:36:38 -0800
Message-ID: <CADyq12zUEq9kcyuR_Qm9MrU1ii-+9n8T2hK6QNzj=kH5zn0VrA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Minchan,

> And here we got error if the addr is in non-anonymous-private vma so the
> syscall will fail but old vma is gone? I guess it's not your intention?

This is exactly what happens today in several situations, because
vma_to_resize is called unconditionally. For example if the old vma
has VM_HUGETLB and old_len < new_len it would have unmapped a portion
and then in vma_to_resize returned -EINVAL, similarly when old_len = 0
with a non-sharable mapping it will have called do_munmap only to fail
in vma_to_resize, if the vma has VM_DONTEXPAND set and you shrink the
size with old_len < new_len it would return -EFAULT after having done
the unmap on the decreased portion. So I followed the pattern to keep
the change simple and maintain consistency with existing behavior.

But with that being said, Kirill made the point that resizing a VMA
while also using MREMAP_DONTUNMAP doesn't have any clear use case and
I agree with that, I'm unable to think of a situation where you'd want
to resize a VMA and use MREMAP_DONTUNMAP. So I'm tempted to mail a new
version which returns -EINVAL if old_len != new_len that would resolve
this concern here as nothing would be unmapped ever at the old
position add it would clean up the change to very few lines of code.

What do you think?

Thank you for taking the time to review.

Brian
