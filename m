Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDAD3CC0CB
	for <lists+linux-api@lfdr.de>; Sat, 17 Jul 2021 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhGQDBq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Jul 2021 23:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhGQDBp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Jul 2021 23:01:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA59C061760
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 19:58:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r18so1819813iot.4
        for <linux-api@vger.kernel.org>; Fri, 16 Jul 2021 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+JKIv6hqPelr3xZyX4AN/xjnr9/KSPz21ndUrNdfWk=;
        b=gZB3XFs4YctFWRQcr3AIXjtExL95BV7PdCJGicm2Gr6SgUuXoZQWDPEzcXJDzhcENt
         BRFsO0Z9jJ7EOrIHBxA3wrRXn6ggBhqRvnQ0CVxDuWIGyGXzW534e581qFbDd2mo6kMM
         PoZF73m02ZKgaYSYk71151mbUwxR1WPCjP0ZdcPmsbYa2dMwBOkKy7mybG3Zu6/lRktW
         miAiWCRQyiAQQDhBvtGD1LWToxcC11v0WWvGN9fS7iS3mkJpXxpEC/wc7NouIJ4ZC/pz
         o+gCE4YveOiuhTwWz3WLFJC8KMbZasTHafFrYjNKaXknstxN+axL4ofpbNY8p2dfvUP0
         sVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+JKIv6hqPelr3xZyX4AN/xjnr9/KSPz21ndUrNdfWk=;
        b=Kln3YTI/P6hXi5NxRppIJu2j7/M2T5Ksm38B6iYKngz4C90FrIXVadCBw3ysLX+cao
         KF50XpkUV9s3J/n+nkqYaU+q+yud3PugfU3nvisVifohfNvV6DT4+f3b/OiY0jciaQ4D
         QUVn0Xs61LadjEGQwUoYn1waODqwiPZUAD7wy7OPMLtaCb6dtW30LAF6rxknM8Qb+ToQ
         KVnwUgOyDX85SEdThndeqh063iQ8TpeYYszY+2TwJGTWjf181XsMpGQRlVSuqvkD/XtT
         HySt+HLp+6QxwC9hg4bfdHHpztiBplzImSsHEII+sdSF4b5Gclq+1FwFtBQB65AmeJ9w
         kTAA==
X-Gm-Message-State: AOAM530Z0CbFxaNAipree+VSj4p0NkdK8sBzv+Vyum2bgdiyBezLQiTR
        KK7PhEK7PtIGvZ5iqcGe3yU6d9AOoqaMC3NvbEeSXg==
X-Google-Smtp-Source: ABdhPJxDKnBkegYHanD7zJwcvdIx+ZQrUXzneHtsWj+SRasMpccY2hK3i9cO2t/21SQnvSisrpoUY8PjATBolBy1zmE=
X-Received: by 2002:a5d:8888:: with SMTP id d8mr9778897ioo.170.1626490728818;
 Fri, 16 Jul 2021 19:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210619092002.1791322-1-pcc@google.com> <YNnKSkcAM05tmPta@casper.infradead.org>
In-Reply-To: <YNnKSkcAM05tmPta@casper.infradead.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 16 Jul 2021 19:58:37 -0700
Message-ID: <CAMn1gO5GiMwanh2pHk7-BNo0UoSbyxkjAjjdK6URMESR6MCY=Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm: introduce reference pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 28, 2021 at 6:11 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Jun 19, 2021 at 02:20:02AM -0700, Peter Collingbourne wrote:
> > +++ b/include/linux/mm.h
> > @@ -32,6 +32,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/pgtable.h>
> >  #include <linux/kasan.h>
> > +#include <linux/fs.h>
>
> No.

This was because is_refpage_vma needed to access vm_file->f_op to
check whether the mapping is a reference page. In v5 I've moved that
part of the check into mm/refpage.c.

> > +++ b/include/linux/mman.h
> > @@ -2,6 +2,7 @@
> >  #ifndef _LINUX_MMAN_H
> >  #define _LINUX_MMAN_H
> >
> > +#include <linux/fs.h>
>
> No.

Okay, this one was entirely unused; removed.

Peter
