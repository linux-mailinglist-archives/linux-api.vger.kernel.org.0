Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6018A1C3D58
	for <lists+linux-api@lfdr.de>; Mon,  4 May 2020 16:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgEDOlu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 May 2020 10:41:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40353 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgEDOlu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 May 2020 10:41:50 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jVcHz-0008Gv-2J; Mon, 04 May 2020 14:41:47 +0000
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
Subject: [PATCH v3 0/3] nsproxy: attach to multiple namespaces
Date:   Mon,  4 May 2020 16:41:38 +0200
Message-Id: <20200504144141.3605533-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is v3.
The permission bits have already seen some vetting which has been
helpful and allowed us to drop the ns_capable_cred() patch. That's the
only major change.

All selftests pass. People interested in playing with this can get it
from three locations as usual (it's not yet in my for-next of course):
https://github.com/brauner/linux/tree/setns_pidfd
https://gitlab.com/brauner/linux/-/commits/setns_pidfd
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=setns_pidfd
                                                                  
May the Fourth be with you.
Christian

Christian Brauner (3):
  nsproxy: add struct nsset
  nsproxy: attach to namespaces via pidfds
  selftests/pidfd: add pidfd setns tests

 fs/namespace.c                                |  15 +-
 fs/nsfs.c                                     |   7 +-
 include/linux/mnt_namespace.h                 |   2 +
 include/linux/nsproxy.h                       |  24 +
 include/linux/proc_fs.h                       |   6 +
 include/linux/proc_ns.h                       |   4 +-
 ipc/namespace.c                               |   7 +-
 kernel/cgroup/namespace.c                     |   5 +-
 kernel/nsproxy.c                              | 306 ++++++++++-
 kernel/pid_namespace.c                        |   5 +-
 kernel/time/namespace.c                       |   5 +-
 kernel/user_namespace.c                       |   8 +-
 kernel/utsname.c                              |   5 +-
 net/core/net_namespace.c                      |   5 +-
 tools/testing/selftests/pidfd/.gitignore      |   1 +
 tools/testing/selftests/pidfd/Makefile        |   3 +-
 tools/testing/selftests/pidfd/config          |   6 +
 .../selftests/pidfd/pidfd_setns_test.c        | 473 ++++++++++++++++++
 18 files changed, 839 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/config
 create mode 100644 tools/testing/selftests/pidfd/pidfd_setns_test.c


base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
-- 
2.26.2

