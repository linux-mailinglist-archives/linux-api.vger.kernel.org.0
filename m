Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323583EA8E6
	for <lists+linux-api@lfdr.de>; Thu, 12 Aug 2021 18:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhHLQ7P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Aug 2021 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhHLQ7O (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Aug 2021 12:59:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B620C061756
        for <linux-api@vger.kernel.org>; Thu, 12 Aug 2021 09:58:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lo4so12762895ejb.7
        for <linux-api@vger.kernel.org>; Thu, 12 Aug 2021 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMdbm1Duu6T2o7Pmii6aGZ5IPzKeI0bawgd87K5hISA=;
        b=XKB75bis9tKuNhHX3eDTMKeSxlvftJ15dFdW/PqjC89Ur4xgXcznCXav012keKDr9q
         uVwQApi3YeYfIStj4+gOxYXeF8i11qPieLQ1yiCkx373DM+kh0ueZlzSltpcrquT6StP
         3ucAz74g4LfHvAL2yjncpx8WOYjTgEkJKVJzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMdbm1Duu6T2o7Pmii6aGZ5IPzKeI0bawgd87K5hISA=;
        b=W1PuU6GtoZh5FBwtStyrgZtudt0xufsJzWYNCfpl1QJ2P220QwoxTQ94+SSrFDFjEE
         JHDc4VTZDbSzI5TO0N5R83pi1la+JJ4PYoxPhCTc1q1ez2SmE/QS3sMXPJAx9Xeap9Nj
         E2fXf6nbzyZjpzKeEmnhJ71jijnKyJu1ebMI+UgfY1wi6GTrzS39rtAEkEOj6Mllxh/X
         ueed0i5T4IbwhhZ9jLQcA6EI3SEDGbxicpijt3M8MbZHWdFMk3QgrfatlpFNLHOsz8Pe
         S5Vztcy+3ZGBM5t31XfzeSp1z0htC7f3XUzA53zPTetEXvzBvH8/MoLASENbPGrE/Fsc
         /hrA==
X-Gm-Message-State: AOAM532+9wq02jCt9um6RvLerOR+3ldECuMTHBkC0zkwubtrZJb8U/vC
        iPdkhFgAuJlAwU1EZbTxfTylOhJsEuL+/HRG7/M=
X-Google-Smtp-Source: ABdhPJyaX4cGHviTb/Ipx/+0+YefFDTjIlstHKGBuRsHaBGQKAoMyPV4b+mpgjs0bDICvLS2sFmG5g==
X-Received: by 2002:a17:906:5045:: with SMTP id e5mr4623449ejk.239.1628787526666;
        Thu, 12 Aug 2021 09:58:46 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a22sm1050972ejk.35.2021.08.12.09.58.46
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:58:46 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id z20so12888321ejf.5
        for <linux-api@vger.kernel.org>; Thu, 12 Aug 2021 09:58:46 -0700 (PDT)
X-Received: by 2002:a05:6512:1290:: with SMTP id u16mr3010715lfs.487.1628787137615;
 Thu, 12 Aug 2021 09:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <20210812084348.6521-4-david@redhat.com>
In-Reply-To: <20210812084348.6521-4-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 06:51:59 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjWgFbEaE9T0smQu8WKkhrcNZZrghBUQ9441OdMsDg1-w@mail.gmail.com>
Message-ID: <CAHk-=wjWgFbEaE9T0smQu8WKkhrcNZZrghBUQ9441OdMsDg1-w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] kernel/fork: always deny write access to current
 MM exe_file
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

On Wed, Aug 11, 2021 at 10:45 PM David Hildenbrand <david@redhat.com> wrote:
>
>         /* No ordering required: file already has been exposed. */
> -       RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
> +       exe_file = get_mm_exe_file(oldmm);
> +       RCU_INIT_POINTER(mm->exe_file, exe_file);
> +       if (exe_file)
> +               deny_write_access(exe_file);

Can we make a helper function for this, since it's done in two different places?

> -       if (new_exe_file)
> +       if (new_exe_file) {
>                 get_file(new_exe_file);
> +               /*
> +                * exec code is required to deny_write_access() successfully,
> +                * so this cannot fail
> +                */
> +               deny_write_access(new_exe_file);
> +       }
>         rcu_assign_pointer(mm->exe_file, new_exe_file);

And the above looks positively wrong. The comment is also nonsensical,
in that it basically says "we thought this cannot fail, so we'll just
rely on it".

If it truly cannot fail, then the comment should give the reason, not
the "we depend on this not failing".

And honestly, I don't see why it couldn't fail. And if it *does* fail,
we cannot then RCU-assign the exe_file pointer with this, because
you'll get a counter imbalance when you do the allow_write_access()
later.

Anyway, do_open_execat() does do deny_write_access() with proper error
checking. I think that is the existing reference that you depend on -
so that it doesn't fail. So the comment could possibly say that the
only caller has done this, but can we not just use the reference
deny_write_access() directly, and not do a new one here?

IOW, maybe there's an extraneous 'allow_write_access()' somewhere that
should be dropped when we do the whole binprm dance in execve()?

             Linus
