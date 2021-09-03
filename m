Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE435400341
	for <lists+linux-api@lfdr.de>; Fri,  3 Sep 2021 18:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349968AbhICQ1y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Sep 2021 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349977AbhICQ1q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Sep 2021 12:27:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ECAC061760
        for <linux-api@vger.kernel.org>; Fri,  3 Sep 2021 09:26:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z19so8668181edi.9
        for <linux-api@vger.kernel.org>; Fri, 03 Sep 2021 09:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGwJPrU2ymA9P5fTXacx3Qx7nyhlT5Ql+hJVxARh6kE=;
        b=K1rpsMJtFquFY0qt0aI/UI9kou+zwJyr90hh+Vza9DcECr82hORBsg2aFd3wZYBMyW
         mxSJGjFZE1t/C6jfyYk7elauPxHWpv1yEHosEvvwTsPovx6P/GaYLx1qmSOFYXAnwgSc
         ifABx5ircSoY9atjYL5bS6LS1nIcyTGaPGEEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGwJPrU2ymA9P5fTXacx3Qx7nyhlT5Ql+hJVxARh6kE=;
        b=OTLbNwZZ7z2p4cgMhyesWxN1GNNhoG4EZ5273llgfloYeyppF7M8fVcunkUHlJ+w/x
         Sy9cmSCz2SIHpx9xWnXH+JI65BYo7SxGmtlq+9VeKJkVLurDH6ozkKf0klkNidP4UidL
         GovcyZ9YjZSyX0THxprp2nt5jthTB3NCnyq9+Ud5zuj/qrkLO11Rw4Dns/SvJOIgkZy8
         nGKJO5NRbMu0f3X2sTM4pmgytIyJVKKoNVjihJPfgeDom14/dW5OIf/qNK8ecJSHy4N8
         ATTpDLl6NufqLe7esHOQWcGNB2M7wxM6u94u9eS5Y7hp3IbmFFejngL2FVGRP0xYqlPs
         zeFA==
X-Gm-Message-State: AOAM5331D+EFfAyG72knOEJr1OyhGIl2dqrFhH1D8wGl19ZILQ6tZtwY
        dugDR3bsc28QAMVng+zgKjypbUQfanvDFiVxzXg=
X-Google-Smtp-Source: ABdhPJzkck5zr8fhgh6r10Mz/gBI0qYBTl0Rgwqp4nLwtdh+tOJqCgNFunuOdV89gjkVk8iqQXlHjA==
X-Received: by 2002:aa7:dd57:: with SMTP id o23mr4866998edw.385.1630686404673;
        Fri, 03 Sep 2021 09:26:44 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id z15sm3172196edr.80.2021.09.03.09.26.42
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 09:26:43 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id u19so8696051edb.3
        for <linux-api@vger.kernel.org>; Fri, 03 Sep 2021 09:26:42 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr3678393ljg.68.1630686392088;
 Fri, 03 Sep 2021 09:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210816194840.42769-1-david@redhat.com> <7c57a16b-8184-36a3-fcdc-5e751184827b@redhat.com>
In-Reply-To: <7c57a16b-8184-36a3-fcdc-5e751184827b@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 09:26:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whghWSYo498cKaK9VLwBKKW0uMynwPT3zpnEG73MfKqUA@mail.gmail.com>
Message-ID: <CAHk-=whghWSYo498cKaK9VLwBKKW0uMynwPT3zpnEG73MfKqUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Sep 3, 2021 at 2:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> So, how do we want to continue with this? Pick it up for v5.15? Have it
> in -next for a while and eventually pick it up for v5.16?

I'm ok with the series. If you have a git tree, do the normal pull
request, and we can do it for 5.15 and see if anybody notices.

As you say, any final removal of ETXTBSY should be a separate and
later patch on top.

            Linus
