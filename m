Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC821440DE
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2020 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUPu0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Jan 2020 10:50:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39888 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAUPu0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Jan 2020 10:50:26 -0500
Received: from [154.119.55.246] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1itvnM-0004D0-5C; Tue, 21 Jan 2020 15:50:24 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v5 0/6] clone3 & cgroups: allow spawning processes into cgroups
Date:   Tue, 21 Jan 2020 16:48:38 +0100
Message-Id: <20200121154844.411-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Tejun,

This is v5 of the promised series to enable spawning processes into a
target cgroup different from the parent's cgroup.

/* v1 */
Link: https://lore.kernel.org/r/20191218173516.7875-1-christian.brauner@ubuntu.com

/* v2 */
Link: https://lore.kernel.org/r/20191223061504.28716-1-christian.brauner@ubuntu.com
Rework locking and remove unneeded helper functions. Please see
individual patch changelogs for details.
With this I've been able to run the cgroup selftests and stress tests in
loops for a long time without any regressions or deadlocks; lockdep and
kasan did not complain either.

/* v3 */
Link: https://lore.kernel.org/r/20200117002143.15559-1-christian.brauner@ubuntu.com
Split preliminary work into separate patches.
See changelog of individual commits.

/* v4 */
Link: https://lore.kernel.org/r/20200117181219.14542-1-christian.brauner@ubuntu.com
Verify that we have write access to the target cgroup. This is usually
done by the vfs but since we aren't going through the vfs with
CLONE_INTO_CGROUP we need to do it ourselves.

/* v5 */
Don't pass down the parent task_struct as argument, just use current
directly. Put kargs->cset on error.

With this cgroup migration will be a lot easier, and accounting will be
more exact. It also allows for nice features such as creating a frozen
process by spawning it into a frozen cgroup.
The code simplifies container creation and exec logic quite a bit as
well.

I've tried to contain all core changes for this features in
kernel/cgroup/* to avoid exposing cgroup internals. This has mostly
worked.
When a new process is supposed to be spawned in a cgroup different from
the parent's then we briefly acquire the cgroup mutex right before
fork()'s point of no return and drop it once the child process has been
attached to the tasklist and to its css_set. This is done to ensure that
the cgroup isn't removed behind our back. The cgroup mutex is _only_
held in this case; the usual case, where the child is created in the
same cgroup as the parent does not acquire it since the cgroup can't be
removed.

The series already comes with proper testing. Once we've decided that
this approach is good I'll expand the test-suite even more.

The branch can be found in the following locations:
[1]: kernel.org: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=clone_into_cgroup
[2]: github.com: https://github.com/brauner/linux/tree/clone_into_cgroup
[3]: gitlab.com: https://gitlab.com/brauner/linux/commits/clone_into_cgroup

Thanks!
Christian

Christian Brauner (6):
  cgroup: unify attach permission checking
  cgroup: add cgroup_get_from_file() helper
  cgroup: refactor fork helpers
  cgroup: add cgroup_may_write() helper
  clone3: allow spawning processes into cgroups
  selftests/cgroup: add tests for cloning into cgroups

 include/linux/cgroup-defs.h                   |   6 +-
 include/linux/cgroup.h                        |  20 +-
 include/linux/sched/task.h                    |   4 +
 include/uapi/linux/sched.h                    |   5 +
 kernel/cgroup/cgroup.c                        | 297 ++++++++++++++----
 kernel/cgroup/pids.c                          |  15 +-
 kernel/fork.c                                 |  19 +-
 tools/testing/selftests/cgroup/Makefile       |   6 +-
 tools/testing/selftests/cgroup/cgroup_util.c  | 126 ++++++++
 tools/testing/selftests/cgroup/cgroup_util.h  |   4 +
 tools/testing/selftests/cgroup/test_core.c    |  64 ++++
 .../selftests/clone3/clone3_selftests.h       |  19 +-
 12 files changed, 501 insertions(+), 84 deletions(-)


base-commit: b3a987b0264d3ddbb24293ebff10eddfc472f653
-- 
2.25.0

