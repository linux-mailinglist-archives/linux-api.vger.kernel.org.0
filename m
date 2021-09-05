Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBDE401108
	for <lists+linux-api@lfdr.de>; Sun,  5 Sep 2021 19:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhIERZP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 5 Sep 2021 13:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhIERZO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 5 Sep 2021 13:25:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FC7C061575
        for <linux-api@vger.kernel.org>; Sun,  5 Sep 2021 10:24:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j12so7122752ljg.10
        for <linux-api@vger.kernel.org>; Sun, 05 Sep 2021 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpxSclMyPpq3hjTkndeLX+vXWq2jAp6AUp9RJSFInpc=;
        b=gK/q/jXjhkCQnjJcvu9HTWv3Xy/cZUkhrGXV+w6Yieir7RJN0wnXBCgrW7qEaTLfMe
         oYo31t90pvfHuligx33j3D0RxXp6Y2ZbKY0rpcBN0DvbvSQ1EHWrcrgoKint1hxYzqDA
         HGx76j07IWwevhOJYViS08kEj6stJNiezUr3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpxSclMyPpq3hjTkndeLX+vXWq2jAp6AUp9RJSFInpc=;
        b=Qwhlmyf7SOgjftOFREZyjp9OoftZ4mzZ18yaMr1aeYgjSK7Xe5Gxkb8Wnz3Uast0ny
         UvAoU9ThOWBTeKWTblBEKX78vlxO5AqKl90UmGfV2Cxdi+6npXQb6JjVrujO5PY2DSgn
         Ov2NyRBUTUQ/vtJrUQ8FEB5L1HAkgSJxRml7g361V/tpS+OGnKufwFdXCHjtuAowy418
         npkKl65aIlRBocXR5V4HAi23Rjx56H+9zPkxf/Eih9fVDD2/YGpFbLpLQIQZ4k7LSEiN
         XeJw8RJ1N/SyAgAEK7o1RDZjfZpfXfjUVvW4SJyaVTDE/wRKwXMaXTTmTix+65MVBQAF
         oLYA==
X-Gm-Message-State: AOAM533mORGAWI3Ju+9DY2Nx0ptjX7tp42qsx12njVHhblT8aogwjKUf
        0muONIHOBYh1jiHHEiJc39F5Ee9RREZChEAGKdg=
X-Google-Smtp-Source: ABdhPJwz8IFQ1bSYrJMO+L7cl3XJU9HfMj8pQArgUkAzpKIhZqqrNP/Oh4/HeW3YkUMyBlfplJZt3w==
X-Received: by 2002:a05:651c:1683:: with SMTP id bd3mr7419010ljb.323.1630862649063;
        Sun, 05 Sep 2021 10:24:09 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c35sm531008lfv.137.2021.09.05.10.24.08
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 10:24:08 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id bq28so8652491lfb.7
        for <linux-api@vger.kernel.org>; Sun, 05 Sep 2021 10:24:08 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr7195539ljp.494.1630862262563;
 Sun, 05 Sep 2021 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210816194840.42769-1-david@redhat.com> <20210816194840.42769-2-david@redhat.com>
 <20210905153229.GA3019909@roeck-us.net>
In-Reply-To: <20210905153229.GA3019909@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Sep 2021 10:17:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO-dnNxz5H8yfnGsNxrDHu-TVQq-X-VwhoDyWu3Lgnyg@mail.gmail.com>
Message-ID: <CAHk-=whO-dnNxz5H8yfnGsNxrDHu-TVQq-X-VwhoDyWu3Lgnyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] binfmt: don't use MAP_DENYWRITE when loading
 shared libraries via uselib()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
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
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Sep 5, 2021 at 8:32 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Guess someone didn't care compile testing their code. This is now in
> mainline.

To be fair, a.out is disabled pretty much on all relevant platforms these days.

Only alpha and m68k left, I think.

I applied the obvious patch from Geert.

            Linus
