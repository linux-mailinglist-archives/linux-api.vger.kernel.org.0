Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E657C39C7
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfJAQCF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Oct 2019 12:02:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43234 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfJAQCE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Oct 2019 12:02:04 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iFKaw-0000Ns-A7; Tue, 01 Oct 2019 16:01:46 +0000
Date:   Tue, 1 Oct 2019 18:01:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>, Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20191001160144.z4y7gz4yla76apq4@wittgenstein>
References: <20191001011055.19283-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001011055.19283-1-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 11:10:51AM +1000, Aleksa Sarai wrote:
> Patch changelog:
>  v4:
>   * __always_inline copy_struct_from_user(). [Kees Cook]
>   * Rework test_user_copy.ko changes. [Kees Cook]
>  v3: <https://lore.kernel.org/lkml/20190930182810.6090-1-cyphar@cyphar.com/>
>      <https://lore.kernel.org/lkml/20190930191526.19544-1-asarai@suse.de/>
>  v2: <https://lore.kernel.org/lkml/20190925230332.18690-1-cyphar@cyphar.com/>
>  v1: <https://lore.kernel.org/lkml/20190925165915.8135-1-cyphar@cyphar.com/>
> 
> This series was split off from the openat2(2) syscall discussion[1].
> However, the copy_struct_to_user() helper has been dropped, because
> after some discussion it appears that there is no really obvious
> semantics for how copy_struct_to_user() should work on mixed-vintages
> (for instance, whether [2] is the correct semantics for all syscalls).
> 
> A common pattern for syscall extensions is increasing the size of a
> struct passed from userspace, such that the zero-value of the new fields
> result in the old kernel behaviour (allowing for a mix of userspace and
> kernel vintages to operate on one another in most cases).
> 
> Previously there was no common lib/ function that implemented
> the necessary extension-checking semantics (and different syscalls
> implemented them slightly differently or incompletely[3]). This series
> implements the helper and ports several syscalls to use it.
> 
> Some in-kernel selftests are included in this patch. More complete
> self-tests for copy_struct_from_user() are included in the openat2()
> patchset.
> 
> [1]: https://lore.kernel.org/lkml/20190904201933.10736-1-cyphar@cyphar.com/
> 
> [2]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
>      robustify sched_read_attr() ABI logic and code")
> 
> [3]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
>      similar checks to copy_struct_from_user() while rt_sigprocmask(2)
>      always rejects differently-sized struct arguments.
> 
> Aleksa Sarai (4):
>   lib: introduce copy_struct_from_user() helper
>   clone3: switch to copy_struct_from_user()
>   sched_setattr: switch to copy_struct_from_user()
>   perf_event_open: switch to copy_struct_from_user()
> 
>  include/linux/bitops.h     |   7 ++
>  include/linux/uaccess.h    |  70 +++++++++++++++++++
>  include/uapi/linux/sched.h |   2 +
>  kernel/events/core.c       |  47 +++----------
>  kernel/fork.c              |  34 ++--------
>  kernel/sched/core.c        |  43 ++----------
>  lib/strnlen_user.c         |   8 +--
>  lib/test_user_copy.c       | 136 +++++++++++++++++++++++++++++++++++--
>  lib/usercopy.c             |  55 +++++++++++++++
>  9 files changed, 288 insertions(+), 114 deletions(-)

I've picked this up now and it's sitting in
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=copy_struct_from_user

It should show up in linux-next tomorrow. I will let this sit there for
a few days but overall this seems good to have in rc2.
If someone objects and prefers to take it through their tree I can drop
it.

Christian
