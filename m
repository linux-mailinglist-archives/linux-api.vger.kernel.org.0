Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA04EA438
	for <lists+linux-api@lfdr.de>; Tue, 29 Mar 2022 02:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiC2Af4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Mar 2022 20:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiC2Afz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Mar 2022 20:35:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4865AB
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 17:34:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a30so13971056ljq.13
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 17:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wzITtVUuCvI8Oo42sPuBnKQHkhCnDzbGSoON7VBw0KM=;
        b=HYWiFCEPLWxHXRhANOxuGs9R2lQZvuqR1eYtoU7OmZUbUQot12YsZPmm231HTXWtBu
         6VF636GgWE5UBvWIRt8TdRIuq1GyRNoBD+LYW49lzqkNxbaot4N1xomAVX06C6mlH4+M
         +JaX9MvoO3zTKpym9gdvWQIf9VEqFsb4IAiPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wzITtVUuCvI8Oo42sPuBnKQHkhCnDzbGSoON7VBw0KM=;
        b=UpwCESgp8Xi86CSgGC26noKJ7th8Z7pN/9SVkES2wJgPMw2hMP4FNs7W92+VZgCnQ4
         F46KQfd2JUN2q7n5jEjwMCMCx7SXujkHfS/L2DRX7hERkTQmlXhh2fEDkKE3C452Maw4
         EA7j06/8PYl87QrQFZX229EWwhSdd+ofyGoKjp5NXFD0gonVAgp0BzOdFcVKkEQHhfo5
         2uONLVMz/rexynPtKQAGXwFflCnBRdLy/SVPpmL2iJNJbVsHPGt/3VBY5PpeTWDW4Jn1
         17I139MnJKA4Cm2Rg8B8vIJ0MeMyMXWl1IFr+k1e84ntGT9QMYaAQRK4sGHFZhCb2iH0
         HEEA==
X-Gm-Message-State: AOAM532E7mytAt3msaL7J6ojrX2NoQOGmRUtY2nWmv4zOsrJyjQlsZmz
        wnWasv1WyeT4IU6U4hFXoAhvOu7sa1aawJqUA1c=
X-Google-Smtp-Source: ABdhPJw/jVLzAFKKP537WBx6WvaEIyvTDjtao4uZatI6lUFPMYeyYOClQOZbKGWPYuLrx/jnl23ihQ==
X-Received: by 2002:a2e:b746:0:b0:249:6f44:16c0 with SMTP id k6-20020a2eb746000000b002496f4416c0mr126894ljo.133.1648514050473;
        Mon, 28 Mar 2022 17:34:10 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f11-20020a0565123b0b00b0044a2809c621sm1798580lfv.29.2022.03.28.17.34.08
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 17:34:08 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id bt26so27606654lfb.3
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 17:34:08 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr146658lfs.27.1648514048121; Mon, 28 Mar
 2022 17:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org> <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org> <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Mar 2022 17:33:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
Message-ID: <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>, Kyle Huey <me@kylehuey.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 28, 2022 at 4:56 PM Eric W. Biederman <ebiederm@xmission.com> w=
rote:
>
> The removal of tracehook.h is quite significant as it has been a major
> source of confusion in recent years.  Much of that confusion was
> around task_work and TIF_NOTIFY_SIGNAL (which I have now decoupled
> making the semantics clearer).

Hmm. I love removing tracehook.c, but this looks like it hasn't been
in linux-next.

The header file changes messes with other changes, and we have

  kernel/sched/fair.c:2884:9: error: implicit declaration of function
=E2=80=98init_task_work=E2=80=99; did you mean =E2=80=98init_irq_work=E2=80=
=99?
[-Werror=3Dimplicit-function-declaration]
   2884 |         init_task_work(&p->numa_work, task_numa_work);
        |         ^~~~~~~~~~~~~~

as a result (also a few other things in that same file).

Now, this is trivial to fix - just add an include for
<linux/task_work.h> from that file - and that's the right thing to do
anyway.

But I'm a bit unhappy that this was either not tested in linux-next,
or if it was, I wasn't notified about the semantic in the pull
request.

So I've pulled this, and fixed up things in my merge, but I'm a bit
worried that there might be other situations like this where some
header file is no longer included and it was included implicitly
before through that disgusting tracehook.h header..

I *hope* it was just the scheduler header file updates that ended up
having this effect, and nothing else is affected.

Let's see if the test robots start complaining about non-x86
architecture-specific stuff that I don't build test.

              Linus
