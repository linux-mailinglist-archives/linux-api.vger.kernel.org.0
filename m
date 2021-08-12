Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB053EA486
	for <lists+linux-api@lfdr.de>; Thu, 12 Aug 2021 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhHLMVf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Aug 2021 08:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236398AbhHLMVb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Aug 2021 08:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628770866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67VxuLoInCrL14SlTIDdgh0fWkak+9n8Xf3485B2J+A=;
        b=SU8pLbYU1tDBqkcqLnnUZK8aQiWsq5rqMgswzcvL6f4LSsai5tlXgQGIJq1eVV9VEBvB5c
        EEmwLqmNfJIDXmGbsc+D/6YodJx+8S7fBsvi+qUxzN9CeQ/5qI93txQPQ3XJ9HfQPk3TtZ
        Lb1YNiQL6nHqBN7IxP8MiHkeo8IWocU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-8nhzabGoPE6Cer6nrOhDfQ-1; Thu, 12 Aug 2021 08:21:04 -0400
X-MC-Unique: 8nhzabGoPE6Cer6nrOhDfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 078E81008062;
        Thu, 12 Aug 2021 12:20:59 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.194.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1D6A5D9C6;
        Thu, 12 Aug 2021 12:20:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
References: <20210812084348.6521-1-david@redhat.com>
Date:   Thu, 12 Aug 2021 14:20:37 +0200
In-Reply-To: <20210812084348.6521-1-david@redhat.com> (David Hildenbrand's
        message of "Thu, 12 Aug 2021 10:43:41 +0200")
Message-ID: <87r1eyg8h6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* David Hildenbrand:

> There are some (minor) user-visible changes with this series:
> 1. We no longer deny write access to shared libaries loaded via legacy
>    uselib(); this behavior matches modern user space e.g., via dlopen().
> 2. We no longer deny write access to the elf interpreter after exec
>    completed, treating it just like shared libraries (which it often is).

We have a persistent issue with people using cp (or similar tools) to
replace system libraries.  Since the file is truncated first, all
relocations and global data are replaced by file contents, result in
difficult-to-diagnose crashes.  It would be nice if we had a way to
prevent this mistake.  It doesn't have to be MAP_DENYWRITE or MAP_COPY.
It could be something completely new, like an option that turns every
future access beyond the truncation point into a signal (rather than
getting bad data or bad code and crashing much later).

I don't know how many invalid copy operations are currently thwarted by
the current program interpreter restriction.  I doubt that lifting the
restriction matters.

> 3. We always deny write access to the file linked via /proc/pid/exe:
>    sys_prctl(PR_SET_MM_EXE_FILE) will fail if write access to the file
>    cannot be denied, and write access to the file will remain denied
>    until the link is effectivel gone (exec, termination,
>    PR_SET_MM_EXE_FILE) -- just as if exec'ing the file.
>
> I was wondering if we really care about permanently disabling write access
> to the executable, or if it would be good enough to just disable write
> access while loading the new executable during exec; but I don't know
> the history of that -- and it somewhat makes sense to deny write access
> at least to the main executable. With modern user space -- dlopen() -- we
> can effectively modify the content of shared libraries while being used.

Is there a difference between ET_DYN and ET_EXEC executables?

Thanks,
Florian

