Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A131638
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 22:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfEaUiu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 16:38:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34517 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfEaUiu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 16:38:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id v18so8977725lfi.1
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJg5QUCA0uPT2F+o9Dh7JaPgMKMdBBZHboAZ09rcF54=;
        b=HfKC+uYBIngRJFypqrkOc0/UKsvYuqY5793NSQ4XY5ZlXJ+nUBECGXpPw/5aGC59wy
         JFNPgtG+Ghy8dk7PmRHD9Jb6iiamQbvnEB3o/mJLZs5MdHJjv1mMjI0sDXPSMAIL9FZE
         M+O9r4iy3Y5UUwrhzyC/sNO6wPFFFmD2vNTz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJg5QUCA0uPT2F+o9Dh7JaPgMKMdBBZHboAZ09rcF54=;
        b=ZJbUWkKwqsyK4/TFCIjjIjFM+VTRx3tHkmgqQTjuoj3qmUWYEd+EZfkaBsIyC/dIRN
         nIK+1lBCZY5pIp4Jq7jG9Omy6SAMP8DyeVYK29aQyfUgsJIhpUU3M1ZOs3eQm+U+NBjW
         fhRFyyKl/Ql3BwCebib6agagJPOeXuLVRzoUpRiPqU/er3v0DiZ5od2EN9C7Q8WTH1nt
         oNsMS0r/Av45jhR9GVoB3Tq9sZMmmP1Qceu0qibo5Lz8vKMaPhGS7kEgQGX6GFU2SApY
         Q8jeBJynpOGt+icORYlrPHMiq9Wd//FutkkC9komluhhbY869+cRMdqs1UHvmT2OxfJ0
         XwUQ==
X-Gm-Message-State: APjAAAXdzQQuK6A49CRYhuFBJWo7TXyS8Bbl0BlJSi4M44gBTxOh5Nef
        Pad24Uy1d1ESpYSO1V2aZjJKp90XJ0w=
X-Google-Smtp-Source: APXvYqysNzjRJ9hSIuxtWeZxHREAlorSW01ynSPqS94mmaHHThytbMZe4pCPwd0QU5HipDGtUuvdnQ==
X-Received: by 2002:ac2:41c4:: with SMTP id d4mr3100857lfi.17.1559335127152;
        Fri, 31 May 2019 13:38:47 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t2sm1593822ljd.36.2019.05.31.13.38.45
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 13:38:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id z5so10822416lji.10
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 13:38:45 -0700 (PDT)
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr6980173ljj.52.1559335125640;
 Fri, 31 May 2019 13:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190529152237.10719-1-christian@brauner.io> <20190529222414.GA6492@gmail.com>
In-Reply-To: <20190529222414.GA6492@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 May 2019 13:38:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQP-Ykxi=zSYaV9iXsHsENa+2fdj-zYKwyeyed63Lsfw@mail.gmail.com>
Message-ID: <CAHk-=whQP-Ykxi=zSYaV9iXsHsENa+2fdj-zYKwyeyed63Lsfw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fork: add clone3
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 29, 2019 at 3:24 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> Thank you for thinking about time namespaces. I looked at this patch
> quickly and I would suggest to move a termination signal out of flags. I
> think we can add a separate field (exit_signal) into clone_args. Does it
> make sense? For me, exit_signal in flags always looked weird...

I agree - the child signal in flags was always just a "it fits" kind
of thing, and that was obviously true back then, but is not true now.

In fact, if we move it out of flags, we'd open up new flag values for
the new interface, in that now the low 8 bits are freed up for more
useful things.

In fact, even for the old ones, we might just say that instead of the
full 8-bit CSIGNAL field, nobody ever *used* more than 6 bits, because
_NSIG is 64, and we've never actually had named signals > 31.

(Yeah, yeah, somebody could use signal 64, and yes, mips has _NSIG
128, but realistically we could get two new clone signals in the old
interface and I think nobody would even notice).

In fact, all of the CSIGNAL bits are ignored if CLONE_THREAD or
CLONE_PARENT is set.

                   Linus
