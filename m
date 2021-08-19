Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6B83F21A8
	for <lists+linux-api@lfdr.de>; Thu, 19 Aug 2021 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhHSUcl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Aug 2021 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhHSUcl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Aug 2021 16:32:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2FC061756
        for <linux-api@vger.kernel.org>; Thu, 19 Aug 2021 13:32:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bt14so15428163ejb.3
        for <linux-api@vger.kernel.org>; Thu, 19 Aug 2021 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSRl6XnmOGLdmR851bn1ceo0KMOXukfn1cvOdweS6EE=;
        b=YxSNY3tcB7ZEMZu0Z0uGdi8ar5s5xZlqAXYmvuLSL5Espa/B5SBqCqsJ9cmkN+bmLP
         rOw4J3P4KUQ5iMNyYm1z9LDNJp2brMQ3m6OAtitK1DaqnVDYf13di4+NSRR4Wkr/ONNL
         +zWGKJJrYWx1bmFzoHq6hrhbUfPi4rkOHip8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSRl6XnmOGLdmR851bn1ceo0KMOXukfn1cvOdweS6EE=;
        b=ZS3b3NRvN/y5FwVVQ/j2hfmA7hW4SbPXjc0Ztk3ocVrW2+B4igsW+fZld65KLKWZt1
         uB3m5WRD7VZJ5j/NjXK03tGZ3g1dOHm1eHV4fUu6egVM5i2Hl5qfIDluY61m26sE24M+
         xvLds3LV34/LF3yVOeIDKSl/CSbGssbSO/iaQS4xEDS+aFnAHlVyH0h+PhDsSCJGArt3
         D4K0w81cUim04WAlY+LrcgxFT2bG7c/OhDQa2ZEbIMgpBb8Hb5RUXmzwg5FZ4o/ucXLv
         t5zcgmszN48w411Qqxz8V8HwpwMcGQP+SGn+NCemgvLxpAnofjmFQU6NrnLlSEcUQybw
         RK2Q==
X-Gm-Message-State: AOAM533hSAVfpYa69Ith+wnQSp/qeBEsRgAeIYnnaoXkSORAR64VduLz
        gRmrYNZUkJjhfkpH5gvvfRoJZSBmWWPf0rOuMgA=
X-Google-Smtp-Source: ABdhPJxuX7ybMdJJFn7xwm/HO1vGJdYZj5cLOT8xM1iKtcti3Yr2ug2Pm5dCa1CWNUGLhkt8hHU+PA==
X-Received: by 2002:a17:907:1b29:: with SMTP id mp41mr17821175ejc.459.1629405123008;
        Thu, 19 Aug 2021 13:32:03 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id ay3sm1769027ejb.0.2021.08.19.13.32.01
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 13:32:01 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id v4so10836488wro.12
        for <linux-api@vger.kernel.org>; Thu, 19 Aug 2021 13:32:01 -0700 (PDT)
X-Received: by 2002:a2e:3004:: with SMTP id w4mr11952338ljw.465.1629405111331;
 Thu, 19 Aug 2021 13:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133> <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com> <YRcyqbpVqwwq3P6n@casper.infradead.org>
 <87k0kkxbjn.fsf_-_@disp2133> <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
 <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com> <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
In-Reply-To: <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 13:31:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com>
Message-ID: <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com>
Subject: Re: Removing Mandatory Locks
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
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
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 19, 2021 at 1:18 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> Now that I think about it a little more, I actually did get one
> complaint a few years ago:
>
> Someone had upgraded from an earlier distro that supported the -o mand
> mount option to a later one that had disabled it, and they had an (old)
> fstab entry that specified it.

Hmm. We might be able to turn the "return -EINVAL" into just a warning.

Yes, yes, currently if you turn off CONFIG_MANDATORY_FILE_LOCKING, we
already do that

        VFS: "mand" mount option not supported

warning print, but then we fail the mount.

If CONFIG_MANDATORY_FILE_LOCKING goes away entirely, it might make
sense to turn that warning into something bigger, but then let the
mount continue - since now that "mand" flag would be purely a legacy
thing.

And yes, if we do that, we'd want the warning to be a big ugly thing,
just to make people very aware of it happening. Right now it's a
one-liner that is easy to miss, and the "oh, the mount failed" is the
thing that hopefully informs people about the fact that they need to
enable CONFIG_MANDATORY_FILE_LOCKING.

The logic being that if you can no longer enable mandatory locking in
the kernel, the current hard failure seems overly aggressive (and
might cause boot failures and inability to fix/report things when it
possibly keeps you from using the system at all).

              Linus
