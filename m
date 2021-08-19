Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A53F2322
	for <lists+linux-api@lfdr.de>; Fri, 20 Aug 2021 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhHSWdi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Aug 2021 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhHSWdh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Aug 2021 18:33:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D4BC061756
        for <linux-api@vger.kernel.org>; Thu, 19 Aug 2021 15:33:00 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n6so13968979ljp.9
        for <linux-api@vger.kernel.org>; Thu, 19 Aug 2021 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d7xFbb+3EvqQGpxyml4JHHWLdIJirfcFBHOQItDEp7E=;
        b=WJcRZ5ECnMTu5Q30pfx/0sVzarr1xcPILRNADM84n9O0Z5vxSCIEUyI67jzVtA2erg
         2u4KECFy2YAYP9QfFCE1KRjE+0ldOJD2qybITXQz3MnjYBy7U8BGR/S3O2zpZU3ODREn
         vt5dXowvmoFxXKfn8qNFotVfe953q+8cvuBsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d7xFbb+3EvqQGpxyml4JHHWLdIJirfcFBHOQItDEp7E=;
        b=Ur0qvDODHOv1F5yraPtcI3oLV5xsFKGwGvL0xyH0B76vFbFHPeoKJdLs5bOOuGmTRU
         vqMoDE6slLFUewWCj/KTeMYcAMf+B+vqDROkrB/uy/mVuYEu1nUprmP356VAeqo2kJ4t
         +ovM/W6y4aEenzV/AZ4OgUA6r9NI5Clh8FcYBQe8UNtp3VL2BJv0aJtwa6k/FxMqgm6z
         Aa5BAXfnEUV3NxF/TNJkmZ8x33xUCaJTaQfKwXy/OT1FETXVkmK/niXkAFoHNgndR4lg
         lyyP03Y9vlDLM98lKXPZjHXC8X7TMYh6nLBVPWL4jbCqx2FNDGDKemJ9Rx9x2+f8hPCZ
         tFXQ==
X-Gm-Message-State: AOAM531e8gwM+9qeiMazwcHe3IofQXgtgHiO7x2fqVdgF+ykpUy7Ry+H
        JSRQao4rN5N/BY6FKdOXL7y6kiAjliF6nRyttoM=
X-Google-Smtp-Source: ABdhPJz2qJDCNWMjRcLbCcqzlX2k0mUgaoW+wmhagCzgXek6/9XD5RrILaHQSBaoRReCtkBK5rmavA==
X-Received: by 2002:a2e:b52c:: with SMTP id z12mr13657470ljm.271.1629412379082;
        Thu, 19 Aug 2021 15:32:59 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x14sm478371lfg.220.2021.08.19.15.32.58
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 15:32:58 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id w4so12501092ljh.13
        for <linux-api@vger.kernel.org>; Thu, 19 Aug 2021 15:32:58 -0700 (PDT)
X-Received: by 2002:a2e:557:: with SMTP id 84mr13704523ljf.507.1629412367774;
 Thu, 19 Aug 2021 15:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133> <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com> <YRcyqbpVqwwq3P6n@casper.infradead.org>
 <87k0kkxbjn.fsf_-_@disp2133> <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
 <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
 <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
 <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com> <639d90212662cf5cdf80c71bbfec95907c70114a.camel@kernel.org>
In-Reply-To: <639d90212662cf5cdf80c71bbfec95907c70114a.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 15:32:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHbYmUZvFkthGJ6zZx+ofTiiTRxPai5mPkmbtE=6JbaQ@mail.gmail.com>
Message-ID: <CAHk-=wgHbYmUZvFkthGJ6zZx+ofTiiTRxPai5mPkmbtE=6JbaQ@mail.gmail.com>
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

On Thu, Aug 19, 2021 at 2:43 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> What sort of big, ugly warning did you have in mind?

I originally thought WARN_ON_ONCE() just to get the distro automatic
error handling involved, but it would probably be a big problem for
the people who end up having panic-on-warn or something.

So probably just a "make it a big box" thing that stands out, kind of
what lockdep etc does with

        pr_warn("======...====\n");

around the messages..

I don't know if distros have some pattern we could use that would end
up being something that gets reported to the user?

              Linus
