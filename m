Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED91C2B8A
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 03:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfJABLl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Sep 2019 21:11:41 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:36932 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfJABLk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Sep 2019 21:11:40 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 24BC8A2212;
        Tue,  1 Oct 2019 03:11:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id J7q4_S4uKmke; Tue,  1 Oct 2019 03:11:33 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] lib: introduce copy_struct_from_user() helper
Date:   Tue,  1 Oct 2019 11:10:51 +1000
Message-Id: <20191001011055.19283-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Patch changelog:
 v4:
  * __always_inline copy_struct_from_user(). [Kees Cook]
  * Rework test_user_copy.ko changes. [Kees Cook]
 v3: <https://lore.kernel.org/lkml/20190930182810.6090-1-cyphar@cyphar.com/>
     <https://lore.kernel.org/lkml/20190930191526.19544-1-asarai@suse.de/>
 v2: <https://lore.kernel.org/lkml/20190925230332.18690-1-cyphar@cyphar.com/>
 v1: <https://lore.kernel.org/lkml/20190925165915.8135-1-cyphar@cyphar.com/>

This series was split off from the openat2(2) syscall discussion[1].
However, the copy_struct_to_user() helper has been dropped, because
after some discussion it appears that there is no really obvious
semantics for how copy_struct_to_user() should work on mixed-vintages
(for instance, whether [2] is the correct semantics for all syscalls).

A common pattern for syscall extensions is increasing the size of a
struct passed from userspace, such that the zero-value of the new fields
result in the old kernel behaviour (allowing for a mix of userspace and
kernel vintages to operate on one another in most cases).

Previously there was no common lib/ function that implemented
the necessary extension-checking semantics (and different syscalls
implemented them slightly differently or incompletely[3]). This series
implements the helper and ports several syscalls to use it.

Some in-kernel selftests are included in this patch. More complete
self-tests for copy_struct_from_user() are included in the openat2()
patchset.

[1]: https://lore.kernel.org/lkml/20190904201933.10736-1-cyphar@cyphar.com/

[2]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
     robustify sched_read_attr() ABI logic and code")

[3]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
     similar checks to copy_struct_from_user() while rt_sigprocmask(2)
     always rejects differently-sized struct arguments.

Aleksa Sarai (4):
  lib: introduce copy_struct_from_user() helper
  clone3: switch to copy_struct_from_user()
  sched_setattr: switch to copy_struct_from_user()
  perf_event_open: switch to copy_struct_from_user()

 include/linux/bitops.h     |   7 ++
 include/linux/uaccess.h    |  70 +++++++++++++++++++
 include/uapi/linux/sched.h |   2 +
 kernel/events/core.c       |  47 +++----------
 kernel/fork.c              |  34 ++--------
 kernel/sched/core.c        |  43 ++----------
 lib/strnlen_user.c         |   8 +--
 lib/test_user_copy.c       | 136 +++++++++++++++++++++++++++++++++++--
 lib/usercopy.c             |  55 +++++++++++++++
 9 files changed, 288 insertions(+), 114 deletions(-)

-- 
2.23.0

