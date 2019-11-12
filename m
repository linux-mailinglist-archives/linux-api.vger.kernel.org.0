Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB12F9DAB
	for <lists+linux-api@lfdr.de>; Wed, 13 Nov 2019 00:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKLXDa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 18:03:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42899 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLXDa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Nov 2019 18:03:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id s5so149829pfh.9
        for <linux-api@vger.kernel.org>; Tue, 12 Nov 2019 15:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=soAK6mR7/nlH57wscE6Anu+LxHtbszZd20gXy3dqtds=;
        b=bNxjrx04Kt52AdGurWf++izr0TcUWE+iYJy7xJCbvM+w+E/MiddxwrF5h3mu5PeZKw
         DHa4bg/tfGyMpe1pGUgEUT8A6iMzek4x5HopvI+08asWwi2Rb65z1gdA8Q9/z6PVbQaq
         iRhFfpwdXXcp981sv9EZnSPA4rEl9wDxUloj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=soAK6mR7/nlH57wscE6Anu+LxHtbszZd20gXy3dqtds=;
        b=ebfNr1I51cDA6CTltCHuquvMkRfp8BBl/0YzBCgIe36SusuVQZQxlO3hvUnN0uTrvv
         bgXImC/gHV8T/b6ZxIDcnGqszwo1pBQHe76MrEPcD+/iYLpYutx5bhnikbgQKHuBmmdi
         qCK0JWUoRn58UIcLnPP/kkbBnf98yDgpHtrkCQJy2PKCEA5Vbr97ulZAz6pM+oip8YaH
         I9P1Dr5zGByu8Fkd+Zi5cXGkF06MR69phgTlIhKEwaEEA2TPhvo9XJh3iJ4t1e4dxnKO
         NhbynVblCVEAWvnpXNgtb7Jt9ryTpVWCOaVdfZUlgh3GPI9RMod2EOq1huYWpyj7YPRn
         uDtQ==
X-Gm-Message-State: APjAAAWlbmx0bljWDyI0fPjCxerg5VfUOvBoZI8lzE8XG0Tz0lxyTMBk
        XS7LQlG4tzVCe5L0xtTzqwWvOQ==
X-Google-Smtp-Source: APXvYqyTTxwcPuc1qZNwB4971E9nj9vEsULrk0Nc2D0CgwZfZ4ItP+YMjk1mY+/0xAfOV9FfqS32+A==
X-Received: by 2002:a63:3cd:: with SMTP id 196mr31871pgd.150.1573599809214;
        Tue, 12 Nov 2019 15:03:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r22sm33477pfg.54.2019.11.12.15.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:03:28 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:03:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: For review: documentation of clone3() system call
Message-ID: <201911121502.3CADFBE3@keescook>
References: <CAKgNAkjo2WHq+zESU1iuCHJJ0x-fTNrakS9-d1+BjzUuV2uf2Q@mail.gmail.com>
 <20191107151941.dw4gtul5lrtax4se@wittgenstein>
 <2eb2ab4c-b177-29aa-cdc4-420b24cfd7b3@gmail.com>
 <CAG48ez2of684J6suPZpko7JFV6hg5KQsrP0KAn8B8-C3PM9OfQ@mail.gmail.com>
 <20191111165800.GD7017@mit.edu>
 <CAG48ez3K6g7NSFmeuw-4paqPQTDYmNkZ-nVvufk25EB+Us850w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3K6g7NSFmeuw-4paqPQTDYmNkZ-nVvufk25EB+Us850w@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 11, 2019 at 09:24:33PM +0100, Jann Horn wrote:
> On Mon, Nov 11, 2019 at 5:58 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > On Mon, Nov 11, 2019 at 03:55:35PM +0100, Jann Horn wrote:
> > > Not on Linux, but on OpenBSD, they do use MAP_STACK now AFAIK; this
> > > was announced here:
> > > <http://openbsd-archive.7691.n7.nabble.com/stack-register-checking-td338238.html>.
> > > Basically they periodically check whether the userspace stack pointer
> > > points into a MAP_STACK region, and if not, they kill the process. So
> > > even if it's a no-op on Linux...
> >
> > Hmm, is that something we should do in Linux?  Even if we only check
> > on syscall entry, which should be pretty inexpensive, it seems like it
> > would be very effective in protecting various ROP techniques.
> 
> I'm not a big fan, especially if that would only happen on syscall
> entry; at the point where you have enough control to perform syscalls,
> it probably isn't too difficult to move your ROP stack over to a
> legitimate stack.

It does have "your process is doing something unexpected" checking,
though, if we want to declare (and enforce) the expected behavior of
userspace stack usage. (i.e. not strictly as a ROP defense.)

-- 
Kees Cook
