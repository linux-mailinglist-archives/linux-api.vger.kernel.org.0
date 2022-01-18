Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6D491E79
	for <lists+linux-api@lfdr.de>; Tue, 18 Jan 2022 05:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiAREYM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Jan 2022 23:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiAREYL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Jan 2022 23:24:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99564C061574
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 20:24:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so74145206edd.12
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 20:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zF5YGbP0nEkT+Uha6r3jtWZKXjZYuO+eTPXU/yYfOc=;
        b=XlkT9EJX4wkAEbbjts/SRs/Oca3s7hNnc/YxVUdn5XXezzzfWLPOgcdIg2Eih08gC6
         iyP5Xy26dc+EWHtnjXbLEbLbvuWerIEEl8qJ3kEwiW5OjDVPByTmajKydrPBjcTLLzF6
         EJIKzzZfM0pAGb4rz0nfHJ7VtKgcCae7zrXTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zF5YGbP0nEkT+Uha6r3jtWZKXjZYuO+eTPXU/yYfOc=;
        b=hNgu/Mw8XXdwqyNVsZ/B3wgbRibgFopVwyl8RwkhuamKIZbI5khi1HvUjlPbtTFhYb
         5yYtgFUWtEHtixkWFT+5HfkoYo7wihtriYUXJUI9bv95kqvOBimdNzsBaYV6HzOMjHM9
         2PTIk8XCkt/jLYtRPYtEX9vO+cIFaoJq2zYkmYE+gfPxzTRqyFS0q/lkxJnNHgRSjugX
         ZKN9CBY2kzuLdwzAicezCTHfaoa5KyIYqfc89kGxkidAWE8ynXlQftN4wpQayHPbJJu8
         EO8T/8huxZpXgEMTmh9u2yfgNseqtkSYrjJI7iPvtTV6JuQaOxsorDjZXM4gqgz+1Mn7
         MM7Q==
X-Gm-Message-State: AOAM531Embi558IZDKfhJ9X60B1EIK3n6NO3652ae+CGNiIuH/reZV5p
        CxwemSsG+53/7psAMXuArIxJT0jktHAZ/LxU
X-Google-Smtp-Source: ABdhPJxHglAfX38u6r01OEDq0U0ZSA5R1tabLXIb3icnx0RYWqrXb+gNGd9zpataejbJ/4G913LyHg==
X-Received: by 2002:a50:c04c:: with SMTP id u12mr23374859edd.107.1642479848966;
        Mon, 17 Jan 2022 20:24:08 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id v26sm3481517edd.41.2022.01.17.20.24.07
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 20:24:08 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso2901803wmj.0
        for <linux-api@vger.kernel.org>; Mon, 17 Jan 2022 20:24:07 -0800 (PST)
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr8150004wrg.281.1642479847518;
 Mon, 17 Jan 2022 20:24:07 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211213225350.27481-1-ebiederm@xmission.com> <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
 <87sfu3b7wm.fsf@email.froward.int.ebiederm.org> <YdniQob7w5hTwB1v@osiris>
 <87ilurwjju.fsf@email.froward.int.ebiederm.org> <87o84juwhg.fsf@email.froward.int.ebiederm.org>
 <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
 <87lezmrxlq.fsf@email.froward.int.ebiederm.org> <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
 <87h7a5kgan.fsf@email.froward.int.ebiederm.org> <991211d94c6dc0ad3501cd9f830cdee916b982b3.camel@trillion01.com>
 <87ee56e43r.fsf@email.froward.int.ebiederm.org> <87v8yi8ajr.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87v8yi8ajr.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Jan 2022 06:23:51 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjCs7XPtNHwzVHK=0D=tZgtdyMGLtoomZB5JeUm7D3JEg@mail.gmail.com>
Message-ID: <CAHk-=wjCs7XPtNHwzVHK=0D=tZgtdyMGLtoomZB5JeUm7D3JEg@mail.gmail.com>
Subject: Re: io_uring truncating coredumps
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Olivier Langlois <olivier@trillion01.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 17, 2022 at 8:47 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Thinking about it from the perspective of not delivering the wake-ups
> fixing io_uring and coredumps in a non-hacky way looks comparatively
> simple.  The function task_work_add just needs to not wake anything up
> after a process has started dying.
>
> Something like the patch below.

Hmm. Yes, I think this is the right direction.

That said, I think it should not add the work at all, and return
-ESRCH, the exact same way that it does for that work_exited
condition.

Because it's basically the same thing: the task is dead and shouldn't
do more work. In fact, task_work_run() is the thing that sets it to
&work_exited as it sees PF_EXITING, so it feels to me that THAT is
actually the issue here - we react to PF_EXITING too late. We react to
it *after* we've already added the work, and then we do that "no more
work" logic only after we've accepted those late work entries?

So my gut feel is that task_work_add() should just also test PF_EXITING.

And in fact, my gut feel is that PF_EXITING is too late anyway (it
happens after core-dumping, no?)

But I guess that thing may be on purpose, and maybe the act of dumping
core itself wants to do more work, and so that isn't an option?

So I don't think your patch is "right" as-is, and it all worries me,
but yes, I think this area is very much the questionable one.

I think that work stopping and the io_uring shutdown should probably
move earlier in the exit queue, but as mentioned above, maybe the work
addition boundary in particular really wants to be late because the
exit process itself still uses task works? ;(

              Linus
