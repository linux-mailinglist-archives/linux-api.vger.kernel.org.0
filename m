Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6207722FF00
	for <lists+linux-api@lfdr.de>; Tue, 28 Jul 2020 03:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgG1Bjv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jul 2020 21:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgG1Bju (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jul 2020 21:39:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BDEC0619D2
        for <linux-api@vger.kernel.org>; Mon, 27 Jul 2020 18:39:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 3so9602949wmi.1
        for <linux-api@vger.kernel.org>; Mon, 27 Jul 2020 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwOY8YxgZ5QpwLDyDAZDf7H1P9wljCLWGMd+2npKJBM=;
        b=MOlNb8NoPIUUfR8CTs/ijaub4q4xeQjXKnkBHNwAa14H1Dd6e/nDvqfYG9o76lQVTE
         eAN0QcUHn/mXk3a71B+PWIt9/gyiGSnOU1mN2wYJE6kh+h2qjacUezbquyuNrABVzXGr
         2QLQ7KWLtjy25fICkWKA7l0pBVUCODm17o5Vp3lYiGfMzJqqNzf0DG14wxBfstEAmW4w
         ef45SGrtTuk/3ZQVdOje7MzvLNAcbx6trAY/fDCNNSL1jPk3GLbPjvMLt0+ZrMnVCHax
         IcGaQ9njibv6jtOsowO4CK5auxqop1215tyGOOckvqNwdSmb+hRtJlhMbNxuLczCHj0L
         K4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwOY8YxgZ5QpwLDyDAZDf7H1P9wljCLWGMd+2npKJBM=;
        b=ZM4/Vu2/uDAI+PNybAO63fV3XcJxoD+HdPdePakLGU3Gzh3+FJc1f3YYbdpUkGjF3l
         EGfjCnnomWHb2D8NabSXtSVtDhbClcsnPXrgekJqC1mIH/22J83mzeBIZuPE7ZzDEpUr
         sdHm7dBZq1xnWZy/yxoxOK2F5vL5h15uAV1NoIhzDWDpZe0Sw83wtdSccNASTppPEWMC
         gVw9mHo2XYczKnQuIlKsHmfGCY/Fk6o/7DnO0HL4JkxCWXOdLclvGaf1FduGzAx1h+F+
         zgcqDCD9IkIMtAp1BAQUJXwcU+m3ppSPSfIwB2KxoqeNt7IwSD61Iln1grD1UOji6E2H
         UTBg==
X-Gm-Message-State: AOAM531Lmz8lH38EcVWowazxKAf2C/y4sXSyDEN2SxuFvPvvToYwk35j
        s+WB9fa8OSL4UDEsWtuL2s1nT/wDD3knWvCW6BrAdg==
X-Google-Smtp-Source: ABdhPJyfsdGe7F0N2iM9sCVzuKHum+2IPBFDtR0asF99pcKFoFTZqL9MHOFO1v31etobWXHbS/fk+qTwgQt0rP17V80=
X-Received: by 2002:a7b:cd0d:: with SMTP id f13mr1606237wmj.40.1595900389021;
 Mon, 27 Jul 2020 18:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200725045921.2723-1-kalou@tfz.net> <20200725052236.4062-1-kalou@tfz.net>
 <20200727142140.GA116567@localhost.localdomain>
In-Reply-To: <20200727142140.GA116567@localhost.localdomain>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Mon, 27 Jul 2020 18:39:38 -0700
Message-ID: <CAGbU3_nkBfrJK55-ZiCc6ve1F+CZBeuSmm6Dike0kkKja-RmVg@mail.gmail.com>
Subject: Re: [PATCH v3] proc,fcntl: introduce F_SET_DESCRIPTION
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks for reviewing, I added some questions inline below

On Mon, Jul 27, 2020 at 7:21 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > +     d = strndup_user(desc, MAX_FILE_DESC_SIZE);
>
> This should be kmem accounted because allocation is persistent.
> To make things more entertaining, strndup_user() doesn't have gfp_t argument.

I had to look it up so I might be very far from it, but is that
__GFP_ACCOUNT and would it be correct to assume memdup_user() should
use it unconditionally?

Otherwise my simple option would be to implement the logic in the
set_description, but the benefit would be very local.

Please let me know what you think is best, happy to read more doc if
there's a more productive way to address that

>
> > +     if (IS_ERR(d))
> > +             return PTR_ERR(d);
> > +
> > +     spin_lock(&file->f_lock);
> > +     kfree(file->f_description);
> > +     file->f_description = d;
> > +     spin_unlock(&file->f_lock);
>
> Generally kfree under spinlock is not good idea.
> You can replace the pointer and free without spinlock.

Sorry I also need some pointers here - do you suggest I move the kfree
out of the locked section or that there is a safe way other than
spinlock?

> struct file is nicely aligned to 256 bytes on distro configs.
> Will this break everything?
>
>         $ cat /sys/kernel/slab/filp/object_size

Indeed on the config I'm using here this jumped to 264 bytes

Would it be better to move this to the inode struct? I don't know the
implications of this - any other option?

Thanks!
