Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2944A3EAA14
	for <lists+linux-api@lfdr.de>; Thu, 12 Aug 2021 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhHLSSb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Aug 2021 14:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhHLSSa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Aug 2021 14:18:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E65C061756
        for <linux-api@vger.kernel.org>; Thu, 12 Aug 2021 11:18:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d4so14993415lfk.9
        for <linux-api@vger.kernel.org>; Thu, 12 Aug 2021 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMjoLlvtmb7mlrSdQknNJvuiNoe+cD5cNxWCgcmURzw=;
        b=fAel4ZlqluiDbK7XT2TN285OpKL/k74SaHM+ukhLXBOh8aUgDoAGzVcLvAOBNcLwL7
         LW/VCMiZKL3GYhssOvLPpOPnx2NT/Qr4lb/26QY9QP4lDZrSUO3zX9NqiJlhGgoC6/lS
         /Ep9k9BaQCUABA+deLmcEAO5Iol8v4ErYRRpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMjoLlvtmb7mlrSdQknNJvuiNoe+cD5cNxWCgcmURzw=;
        b=Fi19L+jI4M8u/QoHiu/NdyPzvz5CDkqZr0JkudHyzKGGg/0fO1aOccjoWs0E6H8+q8
         A9fNqcT6wfVctoFjVB+Br7Szj6K0tQoLz/tecMXE2FDoIpVePy1MLCN2FbWNBLW2JoBX
         MgAvekk+cs78RbdFJc5C0cVUPcWX9YiK5+wyPVosnaE73bkJhcImiNyAMOptNRqQowOi
         AmVAuBMVU2FVvhunoxMJYpsq5htR2WKn6JaDN9QJFOccV9LFn/SrOrcHrWhy0uk4Lxs+
         E7N+y1UPgViJpZ1xp/3lO2m0BTFDdHu8zrxZDrjTjImbER2hS5jHGiz0mRnikuLbm4QV
         el1Q==
X-Gm-Message-State: AOAM533KDIneN07bnbHR2Y9VJ+76IJ4q39slSPrz2BpPjj+vFpqh0dx0
        5Wb0uMPe+f3nY576KCRq8EZY8OxltNX1ZRKOtGs=
X-Google-Smtp-Source: ABdhPJwYkEo8pk9OSkEkq4FGA/7T7N10CM6x0wMhIiB2PC4EUx1UM7g6+SR4IDMjMS795XXOtFMeXA==
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr3448665lfl.306.1628792283131;
        Thu, 12 Aug 2021 11:18:03 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id c10sm390439ljr.134.2021.08.12.11.18.02
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 11:18:02 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x7so11803158ljn.10
        for <linux-api@vger.kernel.org>; Thu, 12 Aug 2021 11:18:02 -0700 (PDT)
X-Received: by 2002:a05:6512:2091:: with SMTP id t17mr3426901lfr.253.1628791844375;
 Thu, 12 Aug 2021 11:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
In-Reply-To: <87lf56bllc.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 08:10:28 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
Message-ID: <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 12, 2021 at 7:48 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Given that MAP_PRIVATE for shared libraries is our strategy for handling
> writes to shared libraries perhaps we just need to use MAP_POPULATE or a
> new related flag (perhaps MAP_PRIVATE_NOW)

No. That would be horrible for the usual bloated GUI libraries. It
might help some (dynamic page faults are not cheap either), but it
would hurt a lot.

This is definitely a "if you overwrite a system library while it's
being used, you get to keep both pieces" situation.

The kernel ETXTBUSY thing is purely a courtesy feature, and as people
have noticed it only really works for the main executable because of
various reasons. It's not something user space should even rely on,
it's more of a "ok, you're doing something incredibly stupid, and
we'll help you avoid shooting yourself in the foot when we notice".

Any distro should make sure their upgrade tools don't just
truncate/write to random libraries executables.

And if they do, it's really not a kernel issue.

This patch series basically takes this very historical error return,
and simplifies and clarifies the implementation, and in the process
might change some very subtle corner case (unmapping the original
executable entirely?). I hope (and think) it wouldn't matter exactly
because this is a "courtesy error" rather than anything that a sane
setup would _depend_ on, but hey, insane setups clearly exist.

               Linus
