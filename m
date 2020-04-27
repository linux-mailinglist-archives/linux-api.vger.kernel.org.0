Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A291BABEF
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 20:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgD0SEw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 14:04:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:54612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgD0SEv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 14:04:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDA14ACC4;
        Mon, 27 Apr 2020 18:04:47 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 0/5] support setting sysctl parameters from kernel command line
Date:   Mon, 27 Apr 2020 20:04:28 +0200
Message-Id: <20200427180433.7029-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This series adds support for something that seems like many people always
wanted but nobody added it yet, so here's the ability to set sysctl parameters
via kernel command line options in the form of sysctl.vm.something=1

The important part is Patch 1. The second, not so important part is an attempt
to clean up legacy one-off parameters that do the same thing as a sysctl.
I don't want to remove them completely for compatibility reasons, but with
generic sysctl support the idea is to remove the one-off param handlers and
treat the parameters as aliases for the sysctl variants.

I have identified several parameters that mention sysctl counterparts in
Documentation/admin-guide/kernel-parameters.txt but there might be more. The
conversion also has varying level of success:

- numa_zonelist_order is converted in Patch 2 together with adding the
  necessary infrastructure. It's easy as it doesn't really do anything but warn
  on deprecated value these days.
- hung_task_panic is converted in Patch 3, but there's a downside that now it
  only accepts 0 and 1, while previously it was any integer value
- nmi_watchdog maps to two sysctls nmi_watchdog and hardlockup_panic, so
  there's no straighforward conversion possible
- traceoff_on_warning is a flag without value and it would be required to
  handle that somehow in the conversion infractructure, which seems pointless
  for a single flag

Vlastimil Babka (3):
  kernel/sysctl: support setting sysctl parameters from kernel command
    line
  kernel/sysctl: support handling command line aliases
  kernel/hung_task convert hung_task_panic boot parameter to sysctl

Changes since v2:
- rebase to 5.7-rc3
- add acks
- add a testcase to tools/testing/selftests/sysctl/sysctl.sh - this adds a new
  sysctl parameter ../boot_int in lib/test_sysctl and expects the tester to
  pass the respective boot parameter in any feasible way (including bootconfig)
  the testcase checks /proc/cmdline to distinguish real failure from the lack of
  parameter. That allows us to test this without introducing further new
  functionality (patches 4+5).

Vlastimil Babka (5):
  kernel/sysctl: support setting sysctl parameters from kernel command
    line
  kernel/sysctl: support handling command line aliases
  kernel/hung_task convert hung_task_panic boot parameter to sysctl
  tools/testing/selftests/sysctl/sysctl.sh: support CONFIG_TEST_SYSCTL=y
  lib/test_sysctl: support testing of sysctl. boot parameter

 .../admin-guide/kernel-parameters.txt         |  11 +-
 fs/proc/proc_sysctl.c                         | 142 ++++++++++++++++++
 include/linux/sysctl.h                        |   4 +
 init/main.c                                   |   2 +
 kernel/hung_task.c                            |  10 --
 lib/test_sysctl.c                             |  13 ++
 mm/page_alloc.c                               |   9 --
 tools/testing/selftests/sysctl/sysctl.sh      |  42 +++++-
 8 files changed, 210 insertions(+), 23 deletions(-)

-- 
2.26.0

