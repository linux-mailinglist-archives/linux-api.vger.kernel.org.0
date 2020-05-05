Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D694E1C580B
	for <lists+linux-api@lfdr.de>; Tue,  5 May 2020 16:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgEEOEv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 May 2020 10:04:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55460 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEEOEv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 May 2020 10:04:51 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jVyBj-0000y6-Mk; Tue, 05 May 2020 14:04:47 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 0/3] nsproxy: attach to multiple namespaces
Date:   Tue,  5 May 2020 16:04:29 +0200
Message-Id: <20200505140432.181565-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is v4.

/* v4 */
There are no major changes. There's a fix for the nstype == 0 case Eric
spotted when porting setns() to struct nsset in the first patch.
I've also added a few lines to the second patch that we want the ability
to attach to subsets of namespaces with pidfds. I also mentioned the
possible future extension that Eric pointed at which amounts to assuming
even more of the callers context. But let's wait for users with that
one.

/* v3 */
The permission bits have already seen some vetting which has been
helpful and allowed us to drop the ns_capable_cred() patch. That's the
only major change.

All selftests pass. People interested in playing with this can get it
from three locations as usual (it's not yet in my for-next):
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=setns_pidfd
https://gitlab.com/brauner/linux/-/commits/setns_pidfd
https://github.com/brauner/linux/tree/setns_pidfd
                                                                  
Thanks!
Christian

Christian Brauner (3):
  nsproxy: add struct nsset
  nsproxy: attach to namespaces via pidfds
  selftests/pidfd: add pidfd setns tests

 fs/namespace.c                                |  15 +-
 fs/nsfs.c                                     |   5 +
 include/linux/mnt_namespace.h                 |   2 +
 include/linux/nsproxy.h                       |  24 +
 include/linux/proc_fs.h                       |   6 +
 include/linux/proc_ns.h                       |   4 +-
 ipc/namespace.c                               |   7 +-
 kernel/cgroup/namespace.c                     |   5 +-
 kernel/nsproxy.c                              | 305 ++++++++++-
 kernel/pid_namespace.c                        |   5 +-
 kernel/time/namespace.c                       |   5 +-
 kernel/user_namespace.c                       |   8 +-
 kernel/utsname.c                              |   5 +-
 net/core/net_namespace.c                      |   5 +-
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/config          |   6 +
 .../selftests/pidfd/pidfd_setns_test.c        | 473 ++++++++++++++++++
 18 files changed, 837 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/config
 create mode 100644 tools/testing/selftests/pidfd/pidfd_setns_test.c


base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.26.2

