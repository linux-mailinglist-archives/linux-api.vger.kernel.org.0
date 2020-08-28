Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D4C255FDE
	for <lists+linux-api@lfdr.de>; Fri, 28 Aug 2020 19:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgH1Rka (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Aug 2020 13:40:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1Rk1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Aug 2020 13:40:27 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MOzfO-1jxNRN2pJ6-00PJer; Fri, 28 Aug 2020 19:40:25 +0200
Received: by mail-qk1-f169.google.com with SMTP id u3so185287qkd.9;
        Fri, 28 Aug 2020 10:40:25 -0700 (PDT)
X-Gm-Message-State: AOAM533XkDu9B412xJ3Rs+VCdAaoSP3JhLehzVWvWs3xowUAcHYtp2Pl
        W2nDLpXrUbuqAkKueaZ6+KbqS7fxN7JoT/YCQwI=
X-Google-Smtp-Source: ABdhPJzCBEo0V55un3Qk90Ymj8++lkumRxJxJL9N83eWCYBj8QoEBWG/1LB8a5CefOTbYjb1QZFqechgK54VbTulcbk=
X-Received: by 2002:ae9:f106:: with SMTP id k6mr220528qkg.3.1598636424271;
 Fri, 28 Aug 2020 10:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200622192900.22757-1-minchan@kernel.org> <20200622192900.22757-4-minchan@kernel.org>
In-Reply-To: <20200622192900.22757-4-minchan@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Aug 2020 19:40:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
Message-ID: <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sj38.park@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ePpQ0C5U7DhvQmZ31hdw0nqhHl1U7AbjczLbWIcGJDcp6QFAVdn
 BrcDyxUk3jxTcaZXcmqtmfW7rJ27TLausUQH9CqWm7kowFS4sAOm8grEvMR/1TP10LOXO+m
 +UY/bIvECmSs7RblNKXtqLmpMrRoOYHkW1GwlowkKaBno7Ku68yqwlzNQqG2rK2/z1QqRmN
 A/H0uAtfH/TUGWmZ/ft4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ECq869FnHk4=:l6LfDOCiFZFgK1KiBxX1yg
 zaDr6Ll+MNWcPhNMU0PHV3bGybj5IZd8fvfbU4FcsnBkm1Pf2E/VAamehLChVblpEqGI2Pvlz
 BIDR0fG7rqgnkoWBQABGYUYQvb+6n4tRzUPAEF5cEUOSMAddqwHytjAzECdA53d3G8rw7WD/K
 f8VB/JhIeWhsDyUngk34CRP3JPUs50ShWxaBp9S1ZoVcjY6sZNa/JcA9vfIN0Mz2VGqA+VsMJ
 H3vJM+JKHAQTNmrtxWjsShZ8Rxxbno/dCZZh+fJhcPWWFQFKirbjUVaqYaaW7qQpvjAyL5F+Z
 Yu7Cydd0gi21LB6pSclHima8I6x4WGPoUgmyrN51zCDggxsXiEPMCJ2dWWZUz5lel+LqiFnZU
 du9wyHg+Pgpod5PQJmNkprxl/Xm9PomluJdylnhGiks5hi0TLih/g7oq2D9a/Y2//bmKHiOfx
 ZKgXNSzZujpw9xhdcWFIHjCrDjQKvyAEtlXoMmNcCg0+VXZ7eoOEvZaNhemrIUz/460niHGQc
 Sd6n+J6vh/UJoW9DMQRipuGDRdT2Z4MCV2Z79uCODiwv5tp7ALmBof+Eo+T67K2eJ6kNIT2xh
 B/73kityIbDtZzgo22+qrd8UtgOdybY+rVScooPZU1qZGJVcq0YWDyjTvL8cn3c528bCWmeJ0
 yeHm7OhE2D+BrVNq+yga3bhweEVCJGpGtPlB4I3uM9eECqS4MgWHgzcqKdMxbRZhyminbwHMA
 X4gNJGXX1BYAcqkUQ59CxpAF+JFCfCfdfnjZw1PAKHqPyliXZxSYyRrGNj9cdNU0BAzLs/G5F
 JUSpaS/eJ+vzI4iUhjXIqN1FgAg0xX+WG7uBY0Af4pRMb/OFjQcI0PNEMselqKehcy6R6ArpN
 uvjQoTvzLooGNFTYS2u+BS5gsdb09U4IMdSHM/ejURIGytBvwSRCOaochnX2h5ghWsP2dHctn
 WZoACUoOk7zcA82oCqYZoSzNDUO3UBMfpaGKxB1EbVPeHPJP3EH/Q
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 22, 2020 at 9:29 PM Minchan Kim <minchan@kernel.org> wrote:
> So finally, the API is as follows,
>
>      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
>                unsigned long vlen, int advice, unsigned int flags);

I had not followed the discussion earlier and only now came across
the syscall in linux-next, sorry for stirring things up this late.

> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 94bf4958d114..8f959d90338a 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -364,6 +364,7 @@
>  440    common  watch_mount             sys_watch_mount
>  441    common  watch_sb                sys_watch_sb
>  442    common  fsinfo                  sys_fsinfo
> +443    64      process_madvise         sys_process_madvise
>
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> @@ -407,3 +408,4 @@
>  545    x32     execveat                compat_sys_execveat
>  546    x32     preadv2                 compat_sys_preadv64v2
>  547    x32     pwritev2                compat_sys_pwritev64v2
> +548    x32     process_madvise         compat_sys_process_madvise

I think we should not add any new x32-specific syscalls. Instead I think
the compat_sys_process_madvise/sys_process_madvise can be
merged into one.

> +       mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> +       if (IS_ERR_OR_NULL(mm)) {
> +               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +               goto release_task;
> +       }

Minor point: Having to use IS_ERR_OR_NULL() tends to be fragile,
and I would try to avoid that. Can mm_access() be changed to
itself return PTR_ERR(-ESRCH) instead of NULL to improve its
calling conventions? I see there are only three other callers.


> +       ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
> +       if (ret >= 0) {
> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
> +               kfree(iov);
> +       }
> +       return ret;
> +}
> +
> +#ifdef CONFIG_COMPAT
...
> +
> +       ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
> +                               &iov, &iter);
> +       if (ret >= 0) {
> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
> +               kfree(iov);
> +       }

Every syscall that passes an iovec seems to do this. If we make import_iovec()
handle both cases directly, this syscall and a number of others can
be simplified, and you avoid the x32 entry point I mentioned above

Something like (untested)

index dad8d0cfaaf7..0de4ddff24c1 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1683,8 +1683,13 @@ ssize_t import_iovec(int type, const struct
iovec __user * uvector,
 {
        ssize_t n;
        struct iovec *p;
-       n = rw_copy_check_uvector(type, uvector, nr_segs, fast_segs,
-                                 *iov, &p);
+
+       if (in_compat_syscall())
+               n = compat_rw_copy_check_uvector(type, uvector, nr_segs,
+                                                fast_segs, *iov, &p);
+       else
+               n = rw_copy_check_uvector(type, uvector, nr_segs,
+                                         fast_segs, *iov, &p);
        if (n < 0) {
                if (p != *iov)
                        kfree(p);


      Arnd
