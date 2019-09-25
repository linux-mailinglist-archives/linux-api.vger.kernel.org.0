Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A21BE8B1
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2019 01:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfIYXEQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 19:04:16 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:26388 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfIYXEQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Sep 2019 19:04:16 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 690E0A2271;
        Thu, 26 Sep 2019 01:04:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id dnEiLNSDRYRu; Thu, 26 Sep 2019 01:04:10 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] lib: introduce copy_struct_from_user() helper
Date:   Thu, 26 Sep 2019 01:03:28 +0200
Message-Id: <20190925230332.18690-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Patch changelog:
 v2:
  * Switch to less buggy handling of alignment. [Linus Torvalds, Al Viro]
  * Move is_zeroed_user() to lib/usercopy.c. [kbuild test robot]
  * Move copy_struct_to_user() to lib/usercopy.c. [Christian Brauner]
  * Add self-tests for is_zeroed_user() to lib/test_user_copy.c.
    [Christian Brauner]
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

 include/linux/bitops.h     |   7 +++
 include/linux/uaccess.h    |   4 ++
 include/uapi/linux/sched.h |   2 +
 kernel/events/core.c       |  47 +++------------
 kernel/fork.c              |  34 +++--------
 kernel/sched/core.c        |  43 +++-----------
 lib/strnlen_user.c         |   8 +--
 lib/test_user_copy.c       |  59 +++++++++++++++++--
 lib/usercopy.c             | 115 +++++++++++++++++++++++++++++++++++++
 9 files changed, 205 insertions(+), 114 deletions(-)

-- 
2.23.0

