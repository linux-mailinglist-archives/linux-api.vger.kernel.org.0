Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8348B739
	for <lists+linux-api@lfdr.de>; Tue, 11 Jan 2022 20:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbiAKTUP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Jan 2022 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350555AbiAKTUD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Jan 2022 14:20:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84340C06175B
        for <linux-api@vger.kernel.org>; Tue, 11 Jan 2022 11:19:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b13so532005edn.0
        for <linux-api@vger.kernel.org>; Tue, 11 Jan 2022 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPEufsiWRxBxFa3x05EyMO915zm/zBjp5MyFqHNhJt0=;
        b=ERiX4Sa6hmrEflDwpKLYWFdH4eDxBQb8cmI+yn5DTykZAfrSCNR3ZM+K/1r1Hyz4WG
         c9CpxvgXHLNO0t9dA5xzgQl2mgLMUDOCQlkAPquuslr7eILu6G/mtCEOgGFNw2k5h/eH
         3cCRKxlYIYK2pE4hpJRpHpPUb0I91BhUci27U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPEufsiWRxBxFa3x05EyMO915zm/zBjp5MyFqHNhJt0=;
        b=CdiMFx+i/xbSN4EPSOsNvXgR9MRPaP6M0x7emwxEAjZJuPs2BcQN7TNJP1d6CEdTpX
         rBytqkSBWLoajHPz3fImbTFrK0APfkgjQe4nHv6kraQkIy9UOZiVt5KTOMUscjdIZIS9
         5eGlfIkPBlxHt5ZKSl1U/LC3lMaIMAPtsgqp5nq0E9vnCcfJci+6NDQYmS6F4/YlFawt
         uOz3PD3sOm24XZ4SYyTseFI+gY8RHFG17i+5tIajouoklmwpw8hWTYnXVjDbv19meunS
         fi7Hol5Kg+KsQzhVRXaphOsAUK2piLSrKbHa0wqOFH1PLHEk68bS44CPfgEMZsQrzcOK
         nOUw==
X-Gm-Message-State: AOAM531O/6GenVTAPS87KTjrjYXsFXARPNWqFUZ95ps8vUjjV+46eswJ
        SnJnFHYm1VSSuV7OkwZO26BOtLzVsPHswuP31YY=
X-Google-Smtp-Source: ABdhPJzlBUlpWr7QZmN8fQJxgxXNaZekYg9Ex9H4XRCEkQfSy8wRAWGekSo1biFP61Yqt+OKxZOywA==
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr5623074edd.113.1641928783161;
        Tue, 11 Jan 2022 11:19:43 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id i9sm3196031ejw.88.2022.01.11.11.19.41
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:19:42 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id p18so14449wmg.4
        for <linux-api@vger.kernel.org>; Tue, 11 Jan 2022 11:19:41 -0800 (PST)
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr3682702wmq.8.1641928781521;
 Tue, 11 Jan 2022 11:19:41 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211213225350.27481-1-ebiederm@xmission.com> <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
 <87sfu3b7wm.fsf@email.froward.int.ebiederm.org> <YdniQob7w5hTwB1v@osiris>
 <87ilurwjju.fsf@email.froward.int.ebiederm.org> <87o84juwhg.fsf@email.froward.int.ebiederm.org>
 <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
 <87lezmrxlq.fsf@email.froward.int.ebiederm.org> <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 11:19:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
Message-ID: <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
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

On Tue, Jan 11, 2022 at 10:51 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> +       while ((n == -ERESTARTSYS) && test_thread_flag(TIF_NOTIFY_SIGNAL)) {
> +               tracehook_notify_signal();
> +               n = __kernel_write(file, addr, nr, &pos);
> +       }

This reads horribly wrongly to me.

That "tracehook_notify_signal()" thing *has* to be renamed before we
have anything like this that otherwise looks like "this will just loop
forever".

I'm pretty sure we've discussed that "tracehook" thing before - the
whole header file is misnamed, and most of the functions in theer are
too.

As an ugly alternative, open-code it, so that it's clear that "yup,
that clears the TIF_NOTIFY_SIGNAL flag".

             Linus
