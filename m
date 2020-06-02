Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F61EC420
	for <lists+linux-api@lfdr.de>; Tue,  2 Jun 2020 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgFBVD3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Jun 2020 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBVD3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Jun 2020 17:03:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E4C08C5C1
        for <linux-api@vger.kernel.org>; Tue,  2 Jun 2020 14:03:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so6103ljo.5
        for <linux-api@vger.kernel.org>; Tue, 02 Jun 2020 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bJlmus5XHXjv1rw00vbaJw33tmb8qsAo8E9SyQVB5o=;
        b=c3OO9Eib+9QFWyiyGkaP3OWFMYITgu0SqFYiihv1nDFfvPl5LG+QGROmQ0W2vvF9TH
         xFPPXbu1d1Ijk8yKx1L8kgzVX4/QMqVlDd/+mMyGn+W6nAmAlpRGjtWXYEvN82lx37MV
         fur6Zc96Tv4VAr6lx2n2EUxpsK34AWMPsgGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bJlmus5XHXjv1rw00vbaJw33tmb8qsAo8E9SyQVB5o=;
        b=KDXNJ2ZO7P+W+ZNkBrIj4h7JJD68QJhCpHxR5EiBFsZQMDjkLhrUFdEmK3fZim1TD7
         LrBEs8n9ABEpRla1ERNpjFE+NLhpz+H7B5F4Hp6VewbI0XhkPxF7+ZxI4tkgfP3ywI+l
         6edtLRQkpJ0aIiauoRwkemvx0vTmtXsmI7m0cieQh0G6GdwnEfwYp1KXsoeS2BJBCb7V
         37zj1dlhHXP4iIkyyoQc96Zf4hkv/rYLVZQyZUYyGd8KpWcJ4HT9iwE9NkD5lZP8HLHG
         yrbwkNrSGEwE5AaWY/ZD7dlQsCy1Z3yvzvqCu9ydWPeyaw4XYmddcFH+DhSEHQUudWHE
         AApg==
X-Gm-Message-State: AOAM5317PHB8rnLlenasXJf+hoxCuObJz7B4kPlvfC41DaBqnGghPvO3
        9wY6wLz3jHGybfZDY3DV6zXRgeMNIBM=
X-Google-Smtp-Source: ABdhPJzmR4j6+SscMmGaOi1hltHYedGTy85MdX7yA66xaU0RmvcsJj+b//AfNJMuxP94irRRGTfePw==
X-Received: by 2002:a2e:a0c8:: with SMTP id f8mr435674ljm.352.1591131806791;
        Tue, 02 Jun 2020 14:03:26 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id f18sm46056lfh.49.2020.06.02.14.03.25
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 9so12874432ljc.8
        for <linux-api@vger.kernel.org>; Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr460164ljc.314.1591131805045;
 Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200602204219.186620-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 14:03:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
Message-ID: <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 2, 2020 at 1:42 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This is a resend of the close_range() syscall, as discussed in [1]. There weren't any outstanding
> discussions anymore and this was in mergeable shape. I simply hadn't gotten around to moving this
> into my for-next the last few cycles and then forgot about it. Thanks to Kyle and the Python people,
> and others for consistenly reminding me before every merge window and mea culpa for not moving on
> this sooner. I plan on moving this into for-next after v5.8-rc1 has been released and targeting the
> v5.9 merge window.

Btw, I did have one reaction that I can't find in the original thread,
which probably means that it got lost.

If one of the designed uses for this is for dropping file descriptors
just before execve(), it's possible that we'd want to have the option
to say "unshare my fd array" as part of close_range().

Yes, yes, you can do

        unshare(CLONE_FILES);
        close_range(3,~0u);

to do it as two operations (and you had that as the example typical
use), but it would actually be better to be able to do

        close_range(3, ~0ul, CLOSE_RANGE_UNSHARE);

instead. Because otherwise we just waste time copying the file
descriptors first in the unshare, and then closing them after.. Double
the work..

And maybe this _did_ get mentioned last time, and I just don't find
it. I also don't see anything like that in the patches, although the
flags argument is there.

            Linus
