Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B513E1A94
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhHERl6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 13:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhHERl6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 13:41:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD200C061765
        for <linux-api@vger.kernel.org>; Thu,  5 Aug 2021 10:41:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g30so8390806lfv.4
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wLBGjAGYdbfgo2Z8OZ3loqXJqEwCws0dhJPDNyGfdvc=;
        b=LlyqKDTzU91dVzuBzjKzze9w6NZKpTVSZie2qpcdCcKXU4FK/ONoA7OanBuzsE8a1M
         DL/iaIq53EHJCIaYMXrsDgNiXDE4vNbRSDIsyMH8lvTomE/QZjsK8VyBDK9Dk93smC6q
         btHDlyWBEu3pZ9AyhBJ3n2f0JSd96MQj6AOIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLBGjAGYdbfgo2Z8OZ3loqXJqEwCws0dhJPDNyGfdvc=;
        b=JzDsrUSkn1HP5lbqTvG/yGPce9b5dJgzvz7LnjaoKZfxAwFV4Gll5rODoROroqKtRV
         PkWkhT83CBRahqBiEo+nI5w2oXf1YJ24jLIeEWrr0nT9brtLpzpThaniZFifM4l52h/D
         YjS4Zt5vKsfT+7t+AZJ4zGdTNBJysymQF9zBrA56z8NNuJ/eMrl3s94I6RtVdns4NwdE
         77qXNdHHuRcJCQHxQ8cgmh5er4xOgj1/z47WKaherQKJu83GNVUnR9wj6AiuWB5Md7Sm
         Li2gT0cYsbor93QPoAPY7JjhDd+b+W7mVpWwJ8XN2cgSPpYjtg1/o7mgvLQT4UtgF521
         5iGQ==
X-Gm-Message-State: AOAM532aZYhp7+4IPwZ0NSlhmtje8GVZ8BpMFpMAHEGQOWfvmjt5rsNi
        S6gYXdu/D0Oq+nfvoh4DALpmh55NbT7W6jlxqXA=
X-Google-Smtp-Source: ABdhPJx9Y6e31u3YYkjlCpRicY0a9CwiBpSrYMRoIHHznIsvCnJZ1CKCcJHeFz+lj0MJQZ2Oygx3zA==
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr4475504lfs.533.1628185300896;
        Thu, 05 Aug 2021 10:41:40 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 13sm575870lft.194.2021.08.05.10.41.39
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:41:40 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id h9so8161196ljq.8
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 10:41:39 -0700 (PDT)
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr3750528ljg.251.1628185299608;
 Thu, 05 Aug 2021 10:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210805000435.10833-1-alex_y_xu.ref@yahoo.ca>
 <20210805000435.10833-1-alex_y_xu@yahoo.ca> <YQuixFfztw0RaDFi@kroah.com> <1628172774.4en5vcorw2.none@localhost>
In-Reply-To: <1628172774.4en5vcorw2.none@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Aug 2021 10:41:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE4XwB2E0=CYB8eqss6WB1+FXgVWZRsUUSWTOeq-kh8w@mail.gmail.com>
Message-ID: <CAHk-=wgE4XwB2E0=CYB8eqss6WB1+FXgVWZRsUUSWTOeq-kh8w@mail.gmail.com>
Subject: Re: [PATCH] pipe: increase minimum default pipe size to 2 pages
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.or>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 5, 2021 at 7:18 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> I tested 5.4 and it exhibits the same problem as master using this
> non-racy program. I think the problem goes back to v4.5, the first
> release with 759c01142a ("pipe: limit the per-user amount of pages
> allocated in pipes").

Yeah, our pipe buffer allocation strategy has been fairly consistent,
although the exact locking details etc have certainly changed over
time.

I do think the behavior goes back all the way to that "limit to one
single buffer if you hit the pipe size soft limit" commit, because the
thing that example program tests has been true for the whole time,
afaik: first fill up the first pipe buffer completely, then (a) read
everything but one byte, and then (b) try to write another byte.

Doing (a) will leave the pipe buffer still allocated and in use, and
then (b) will fundamentally want to allocate a new buffer for the new
write.  Which will obviously not then be allowed if we have said "one
pipe buffer only".

So a lot of the code around pipe buffers has changed over the years,
and the exact patterns and timing and wakeups has been completely
rewritten, but that buffer allocation pattern is pretty fundamental
and I don't think that has changed at all.

(A long LONG time ago, we had only one pipe buffer, and it was a
single circular queue, and you never had this kind of "used up one
buffer, need to allocate a new one" issue, so it's not like this goes
back to Linux 0.01, but the pipe buffers go back a _loong_ time).

Allowing two buffers obviously doesn't change the basic pattern at all
- but it means that we will always allow having at least PIPE_BUF
bytes in the pipe. So you can obviously still trigger that "cannot
write any more, will block any future writes", but at that point it's
a clear user bug in thinking that pipes have some infinite buffer
size.

In contrast, expecting pipes to be able to hold 2 bytes at a time is
quite reasonable, with POSIX guaranteeing PIPE_BUF of at least 512
bytes.

I've applied Alex's patch.

                 Linus
