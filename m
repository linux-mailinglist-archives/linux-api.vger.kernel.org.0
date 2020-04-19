Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648781AFCED
	for <lists+linux-api@lfdr.de>; Sun, 19 Apr 2020 20:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgDSSAV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 19 Apr 2020 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgDSSAV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 19 Apr 2020 14:00:21 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154FC061A0C
        for <linux-api@vger.kernel.org>; Sun, 19 Apr 2020 11:00:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w145so5986527lff.3
        for <linux-api@vger.kernel.org>; Sun, 19 Apr 2020 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KquQ7eqJ5WxLr4ruGXMoT/FQZYgAagIrOw4D8jrNTS4=;
        b=b5UUF65TFhoiwY6dQWiWGe/vGQW+FgBnonYQnlUUCMjWlRU22RHod2dAIgJ3iz6fXV
         iHPKFSUyF0y9t9WsYQQ9kcB4/DxZHIV6ObTaC9u1rZW5FgGVn0mO6KxSqN3rfAPJuw14
         TD6cuXjvI56ndC599LrGWOU/QkG+aROAcxZTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KquQ7eqJ5WxLr4ruGXMoT/FQZYgAagIrOw4D8jrNTS4=;
        b=M74kX+XhAhSi51cGEXDZ3Y/nVRtg8k1Xj8TisfbMtqNvbofOUxkV2eXkhPXfA7MOUD
         r5v/FfJj77J9Ow3QFPqh8dUhEuMriF00oV0e4ULeUHWMU4X6AHnP7J8QnzCqU9KiEYj1
         5wO+wnMXTS1Xjolc8J5ki/wOeyB1HNVNbiASQNx3iodq48itWRa+RDnV70lCjKLj9MQ4
         5KrKr4t2gzs9mRHvC3zcX+4D7NScjfpfgtC7YvTyzyv7+LL7/9KoNy65PTMqztAgZyp2
         6C8vvlMN6Q7Lohn0fVSpNN6dSggzicAhC+ARyNoUOUnqZjF0aFehBBzRUcyP1E4Ie9Ko
         S0uQ==
X-Gm-Message-State: AGi0PuY8itEWS6QLjVEDpM6BP4Zlt1qgDUiA2qT9mC9evNTEw/5n450I
        A8/fTSYcyzwpna4wKCtQZJk2M8S/Aug=
X-Google-Smtp-Source: APiQypKxXWxw6s/AAqn8JGxTYoIT0iC4LVtadjwNQeTFSUeMhAKWSTP4JdnTE1fOKmP90rk68fvX1g==
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr7812599lfl.112.1587319217239;
        Sun, 19 Apr 2020 11:00:17 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e16sm25154122ljh.18.2020.04.19.11.00.15
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 11:00:15 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id k21so7450301ljh.2
        for <linux-api@vger.kernel.org>; Sun, 19 Apr 2020 11:00:15 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr3316865lji.201.1587319215104;
 Sun, 19 Apr 2020 11:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200417172556.217480-1-bgeffon@google.com>
In-Reply-To: <20200417172556.217480-1-bgeffon@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Apr 2020 10:59:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOYDi2pqECSGnxnBijemqWoLPWDh1LSKV5UrSivUUoRA@mail.gmail.com>
Message-ID: <CAHk-=wgOYDi2pqECSGnxnBijemqWoLPWDh1LSKV5UrSivUUoRA@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix MREMAP_DONTUNMAP accounting on VMA merge
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Sonny Rao <sonnyrao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 17, 2020 at 10:26 AM Brian Geffon <bgeffon@google.com> wrote:
>
> However, MREMAP_DONTUNMAP leaves that original portion in place which
> means that the VMA which was split and then remerged is not actually
> split at the end of the mremap.

I was waiting to hear others comment on this, but it's been very quiet.

The patch looks correct to me, and the explanation is great. I'm
inclined to just apply it.

HOWEVER.

I started looking at copy_vma(), and noticed that we seem to have
exactly one caller: move_vma().

So I do have a query: would it perhaps not be a good idea to simply
remove the "vma_merge()" call from copy_vma(), and do at the end of
move_vma() instead?

I don't hate this patch either, and I'll happily apply it if people
prefer this one, but before doing that I thought I'd ask whether maybe
instead of fixing up the mess made by vma_merge() that people didn't
think about, maybe we should fix it at the underlying source of the
problem?

Are there any advantages to merging early? Shouldn't the basic
principle be that we'd strive to always do the vma_merge() at the end
of an operation that might have generated a mergable sequence of
vma's?

               Linus
