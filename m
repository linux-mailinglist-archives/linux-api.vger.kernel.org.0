Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37583308D7
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfEaGnZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 02:43:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42240 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGnZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 02:43:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id r22so5559878pfh.9;
        Thu, 30 May 2019 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X7IbAcoHGWYGQ57zOMOEvvD9mku0/MrUv17pm9iB4pE=;
        b=DVON77u/Op3f3Ha4EBQzger0I2CQVfRpexpQtW2NWRzWtbgmWA4GKKiEVQx63cXwdp
         jRo0VDOHX3hi4SVV0pwgcmtaFw0YJM9hNCgbdcYm4fQlSXu5nq2szVh4Gq1cJqwUGOFC
         lSy/dBo7pDr9dh/gw5TkDzAmV5z/YiSEQ+yLW9ihqNfBYl1HWewKESXfAcC8bw3lRfOf
         PTGxbYwxKo81kbaqvrUB7GjMmyDLWbR1KNe6vbdsoUKXNhJvqmTGokFq180QzQvxHioH
         andbW59juggQgCAVB91g1JpCY+WhelabPj+InfBAEJpG9Ep2+LOSbOsisHtoiiWKvLTD
         xZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=X7IbAcoHGWYGQ57zOMOEvvD9mku0/MrUv17pm9iB4pE=;
        b=MEfhRK3357WY8zaM7UqwuR6naitNZ4DGK8rT76jeJBGtH4ITb6pLUO15Hup59PQuIz
         L9Tl9UmroO2hGuVBfiyRcb2kZOFCxJPgoIrLKZ7cA+KGcyclcZRaFjKPtipsX81G5e1v
         WO0O8bATsiwlILOo3DdZPCY2GeL/j9KUyFrn2kekhb13+SZ31AampcA8vMnAqV+e/tFc
         ZQg8WffZ1IbuzNNenodtiuiNWcSy8Z01fYJeyf7gzNfFQfFqBQODK30FqXBpljFeYwS+
         Q1bnWYaTB0/T//IVTcqx/3iOFMRlZNjqryBaKz5x2Qo8GR+fRqoY7R87Yqsb+klmegVS
         CMwQ==
X-Gm-Message-State: APjAAAVHQnskD8HaxJg8bVdR2R2VfvOPV7N4n/aVR2ulr50wkfpA4iV/
        qrA/H7II/0ApTZLz4VyOvvU=
X-Google-Smtp-Source: APXvYqxzssuMTmlb42uQpbL/n4zs/GPcDTvVWTrwYoz7E2O5oogSOexK7xbdTbEWYAaItAo/CjBPnw==
X-Received: by 2002:a17:90a:800b:: with SMTP id b11mr6572985pjn.4.1559285004237;
        Thu, 30 May 2019 23:43:24 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f30sm4243340pjg.13.2019.05.30.23.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:43:22 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, Minchan Kim <minchan@kernel.org>
Subject: [RFCv2 0/6] introduce memory hinting API for external process
Date:   Fri, 31 May 2019 15:43:07 +0900
Message-Id: <20190531064313.193437-1-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

- Background

The Android terminology used for forking a new process and starting an app
from scratch is a cold start, while resuming an existing app is a hot start.
While we continually try to improve the performance of cold starts, hot
starts will always be significantly less power hungry as well as faster so
we are trying to make hot start more likely than cold start.

To increase hot start, Android userspace manages the order that apps should
be killed in a process called ActivityManagerService. ActivityManagerService
tracks every Android app or service that the user could be interacting with
at any time and translates that into a ranked list for lmkd(low memory
killer daemon). They are likely to be killed by lmkd if the system has to
reclaim memory. In that sense they are similar to entries in any other cache.
Those apps are kept alive for opportunistic performance improvements but
those performance improvements will vary based on the memory requirements of
individual workloads.

- Problem

Naturally, cached apps were dominant consumers of memory on the system.
However, they were not significant consumers of swap even though they are
good candidate for swap. Under investigation, swapping out only begins
once the low zone watermark is hit and kswapd wakes up, but the overall
allocation rate in the system might trip lmkd thresholds and cause a cached
process to be killed(we measured performance swapping out vs. zapping the
memory by killing a process. Unsurprisingly, zapping is 10x times faster
even though we use zram which is much faster than real storage) so kill
from lmkd will often satisfy the high zone watermark, resulting in very
few pages actually being moved to swap.

- Approach

The approach we chose was to use a new interface to allow userspace to
proactively reclaim entire processes by leveraging platform information.
This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
that are known to be cold from userspace and to avoid races with lmkd
by reclaiming apps as soon as they entered the cached state. Additionally,
it could provide many chances for platform to use much information to
optimize memory efficiency.

To achieve the goal, the patchset introduce two new options for madvise.
One is MADV_COLD which will deactivate activated pages and the other is
MADV_PAGEOUT which will reclaim private pages instantly. These new options
complement MADV_DONTNEED and MADV_FREE by adding non-destructive ways to
gain some free memory space. MADV_PAGEOUT is similar to MADV_DONTNEED in a way
that it hints the kernel that memory region is not currently needed and
should be reclaimed immediately; MADV_COLD is similar to MADV_FREE in a way
that it hints the kernel that memory region is not currently needed and
should be reclaimed when memory pressure rises.

This approach is similar in spirit to madvise(MADV_WONTNEED), but the
information required to make the reclaim decision is not known to the app.
Instead, it is known to a centralized userspace daemon, and that daemon
must be able to initiate reclaim on its own without any app involvement.
To solve the concern, this patch introduces new syscall -

    struct pr_madvise_param {
            int size;               /* the size of this structure */
            int cookie;             /* reserved to support atomicity */
            int nr_elem;            /* count of below arrary fields */
            int __user *hints;      /* hints for each range */
            /* to store result of each operation */
            const struct iovec __user *results;
            /* input address ranges */
            const struct iovec __user *ranges;
    };
    
    int process_madvise(int pidfd, struct pr_madvise_param *u_param,
                            unsigned long flags);

The syscall get pidfd to give hints to external process and provides
pair of result/ranges vector arguments so that it could give several
hints to each address range all at once. It also has cookie variable
to support atomicity of the API for address ranges operations. IOW, if
target process changes address space since monitor process has parsed
address ranges via map_files or maps, the API can detect the race so
could cancel entire address space operation. It's not implemented yet.
Daniel Colascione suggested a idea(Please read description in patch[6/6])
and this patchset adds cookie a variable for the future.

- Experiment

We did bunch of testing with several hundreds of real users, not artificial
benchmark on android. We saw about 17% cold start decreasement without any
significant battery/app startup latency issues. And with artificial benchmark
which launches and switching apps, we saw average 7% app launching improvement,
18% less lmkd kill and good stat from vmstat.

A is vanilla and B is process_madvise.

                                       A          B      delta   ratio(%)
               allocstall_dma          0          0          0       0.00
           allocstall_movable       1464        457      -1007     -69.00
            allocstall_normal     263210     190763     -72447     -28.00
             allocstall_total     264674     191220     -73454     -28.00
          compact_daemon_wake      26912      25294      -1618      -7.00
                 compact_fail      17885      14151      -3734     -21.00
         compact_free_scanned 4204766409 3835994922 -368771487      -9.00
             compact_isolated    3446484    2967618    -478866     -14.00
      compact_migrate_scanned 1621336411 1324695710 -296640701     -19.00
                compact_stall      19387      15343      -4044     -21.00
              compact_success       1502       1192       -310     -21.00
kswapd_high_wmark_hit_quickly        234        184        -50     -22.00
            kswapd_inodesteal     221635     233093      11458       5.00
 kswapd_low_wmark_hit_quickly      66065      54009     -12056     -19.00
                   nr_dirtied     259934     296476      36542      14.00
  nr_vmscan_immediate_reclaim       2587       2356       -231      -9.00
              nr_vmscan_write    1274232    2661733    1387501     108.00
                   nr_written    1514060    2937560    1423500      94.00
                   pageoutrun      67561      55133     -12428     -19.00
                   pgactivate    2335060    1984882    -350178     -15.00
                  pgalloc_dma   13743011   14096463     353452       2.00
              pgalloc_movable          0          0          0       0.00
               pgalloc_normal   18742440   16802065   -1940375     -11.00
                pgalloc_total   32485451   30898528   -1586923      -5.00
                 pgdeactivate    4262210    2930670   -1331540     -32.00
                      pgfault   30812334   31085065     272731       0.00
                       pgfree   33553970   31765164   -1788806      -6.00
                 pginodesteal      33411      15084     -18327     -55.00
                  pglazyfreed          0          0          0       0.00
                   pgmajfault     551312    1508299     956987     173.00
               pgmigrate_fail      43927      29330     -14597     -34.00
            pgmigrate_success    1399851    1203922    -195929     -14.00
                       pgpgin   24141776   19032156   -5109620     -22.00
                      pgpgout     959344    1103316     143972      15.00
                 pgpgoutclean    4639732    3765868    -873864     -19.00
                     pgrefill    4884560    3006938   -1877622     -39.00
                    pgrotated      37828      25897     -11931     -32.00
                pgscan_direct    1456037     957567    -498470     -35.00
       pgscan_direct_throttle          0          0          0       0.00
                pgscan_kswapd    6667767    5047360   -1620407     -25.00
                 pgscan_total    8123804    6004927   -2118877     -27.00
                   pgskip_dma          0          0          0       0.00
               pgskip_movable          0          0          0       0.00
                pgskip_normal      14907      25382      10475      70.00
                 pgskip_total      14907      25382      10475      70.00
               pgsteal_direct    1118986     690215    -428771     -39.00
               pgsteal_kswapd    4750223    3657107   -1093116     -24.00
                pgsteal_total    5869209    4347322   -1521887     -26.00
                       pswpin     417613    1392647     975034     233.00
                      pswpout    1274224    2661731    1387507     108.00
                slabs_scanned   13686905   10807200   -2879705     -22.00
          workingset_activate     668966     569444     -99522     -15.00
       workingset_nodereclaim      38957      32621      -6336     -17.00
           workingset_refault    2816795    2179782    -637013     -23.00
           workingset_restore     294320     168601    -125719     -43.00

pgmajfault is increased by 173% because swapin is increased by 200% by
process_madvise hint. However, swap read based on zram is much cheaper
than file IO in performance point of view and app hot start by swapin is
also cheaper than cold start from the beginning of app which needs many IO
from storage and initialization steps.

Brian Geffon in ChromeOS team had an experiment with process_madvise(2)
Quote form him:
"What I found is that by using process_madvise after a tab has been back
grounded for more than 45 seconds reduced the average tab switch times by
25%! This is a huge result and very obvious validation that process_madvise
hints works well for the ChromeOS use case."

This patchset is against on next-20190530.

Minchan Kim (6):
  [1/6] mm: introduce MADV_COLD
  [2/6] mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
  [3/6] mm: introduce MADV_PAGEOUT
  [4/6] mm: factor out madvise's core functionality
  [5/6] mm: introduce external memory hinting API
  [6/6] mm: extend process_madvise syscall to support vector arrary

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/page-flags.h             |   1 +
 include/linux/page_idle.h              |  15 +
 include/linux/pid.h                    |   4 +
 include/linux/swap.h                   |   2 +
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/mman-common.h |  13 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 kernel/fork.c                          |   8 +
 kernel/signal.c                        |   7 +-
 kernel/sys_ni.c                        |   1 +
 mm/madvise.c                           | 586 +++++++++++++++++++++----
 mm/swap.c                              |  43 ++
 mm/vmscan.c                            |  83 +++-
 15 files changed, 691 insertions(+), 81 deletions(-)

* from RFCv1
 * Dropped MADV_[ANONYMOUS|FILE]_FILTER option. The option gave several
   hundered millisecond improvement via removing address range parsing
   overhead. However, there is other suggestion to create general API
   to provide processs information(process_getinfo(2)) which would be
   very fast via binary form and get only necessary information.

 * There was lots of discussion how to provide *consistency*,*atomicity*
   against on target process's address space change. It needs more
   discussion. Let's do that in [6/6] if you have still a argument.

 * There was a concern about the vector support because it didn't show
   great performance benefit. However, I still included it because
   it could make us address space range operation's atomicity easier
   in future without introducing other new syscall.

 * Naming of process_madvise - there was request to change naming from
   process_madvise to pidfd_madvise for the consistency of existing
   pidfd syscall but some of people including me still want to have
   syscall name focus on what it's doing rather than how it does.

 * I limited hints new syscall supports as MADV_COLD|PAGEOUT at this
   moment because I'm not sure all hints makes sense for external
   processs and would be some lurked bugs which relies on the caller
   context. Please see description in [5/6].
-- 
2.22.0.rc1.257.g3120a18244-goog

