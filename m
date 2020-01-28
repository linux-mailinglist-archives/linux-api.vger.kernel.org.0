Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FCF14AD06
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2020 01:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA1AQ4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jan 2020 19:16:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45833 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA1AQ4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jan 2020 19:16:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so5682532pfg.12;
        Mon, 27 Jan 2020 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/jjSPUmaGsjBw20OY6mWcuutvPTH8KThjAPA0mtHm0=;
        b=Cm22HlzGzxed4P0fYED+h/l3pX9ev8n9WlonJDZu+Q7a1oE88f85oqmD+g0YAhlCOf
         YtojffbsND2zff0tbZppj0oysT6WYjOih5tiXry1iF/lhycSUPCKO4jS4Aja6zdrbY4o
         mnwd4QSoN9u89cDwkVjR7G1++sAm+LByYQW18wCWAaWAk6wihiHvgCtUDMU7oBoZHN7s
         hQaXMP4iyjUhz9iwIYR8iwvbdJEBZyC4R3wd1/oLXkabCcSUYcug7akOmXD5BAo4Bh6A
         2HVwdFA0VIKirJSeQdI3JsBkrrzi50rc9k6yewJbDyyPhMhcifARsbIvYbuS/gegK8Jp
         Lt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Q/jjSPUmaGsjBw20OY6mWcuutvPTH8KThjAPA0mtHm0=;
        b=uEA0b0ZckESHxTE2wLjsqDuWkY6WbDmS28Oexe14A42p1TK/PKEahXXVThTdYuf5C9
         W7mVz2a7hmbYjwrlmeOrhUGwGLY4udJU9ls2T0JsPhv3neogrRjNRUwS1p1cDQbfGDwD
         zokbWggDaXW9IvjQ82Az5TCBdsoYPx27nDEK4RqWVFRTJgimzDTX4EZ/3HBZ+Q+Fwi0W
         GnGaUGPRvT+iPaVym/nlsqj1VrFQMRak0J1/NeUd5fc7MMXSVQPzqh2wYNB+EOO5zfkF
         LFuh3ZhHGy2AAmacEMOSBeWq+5asCx81YvmO5xhX9gr3mXmTjwqWr7xhKYdzO19apUP2
         +roA==
X-Gm-Message-State: APjAAAU37fkTuyWvpwRW8buVIiC+MOwX2YGG6QkyWt2tjUg4MDWJCnZ9
        F/zxz5jW79Ut7S5R/6DYanQ=
X-Google-Smtp-Source: APXvYqwyqf8vB8GPhJHuK5cNfPp/zfDxvmYskudrPq/FRD83dQ6KmRUpgUdaFiG+Y+JR8z6f0C2gRQ==
X-Received: by 2002:a63:5456:: with SMTP id e22mr21609620pgm.177.1580170615827;
        Mon, 27 Jan 2020 16:16:55 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id q28sm11301461pfl.153.2020.01.27.16.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 16:16:54 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 0/5] introduce memory hinting API for external process
Date:   Mon, 27 Jan 2020 16:16:36 -0800
Message-Id: <20200128001641.5086-1-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
application could give hints to kernel what memory range are preferred to be
reclaimed. However, in some platform(e.g., Android), the information
required to make the hinting decision is not known to the app.
Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
and that daemon must be able to initiate reclaim on its own without any app
involvement.

To solve the concern, this patch introduces new syscall - process_madvise(2).
Bascially, it's same with madvise(2) syscall but it has some differences.

1. It needs pidfd of target process to provide the hint
2. It supports only MADV_{COLD|PAGEOUT|MERGEABLE|UNMEREABLE} at this moment.
   Other hints in madvise will be opened when there are explicit requests from
   community to prevent unexpected bugs we couldn't support.
3. Only privileged processes can do something for other process's address
   space.

For more detail of the new API, please see "mm: introduce external memory hinting API"
description in this patchset.

Minchan Kim (3):
  mm: factor out madvise's core functionality
  mm: introduce external memory hinting API
  mm: support both pid and pidfd for process_madvise

Oleksandr Natalenko (2):
  mm/madvise: employ mmget_still_valid for write lock
  mm/madvise: allow KSM hints for remote API

* from v2 - https://lore.kernel.org/linux-mm/20200116235953.163318-1-minchan@kernel.org/
  * check signal callee and caller to bail out - Kirill Tkhai
  * put more clarification for justification of new API

* from v1 - https://lore.kernel.org/linux-mm/20200110213433.94739-1-minchan@kernel.org/
  * fix syscall number - SeongJae
  * use get_pid_task - Kirill Tkhai
  * extend API to support pid as well as pidfd - Kirill Tkhai

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 include/linux/pid.h                         |   1 +
 include/linux/syscalls.h                    |   3 +
 include/uapi/asm-generic/unistd.h           |   5 +-
 kernel/exit.c                               |  17 --
 kernel/pid.c                                |  17 ++
 kernel/sys_ni.c                             |   1 +
 mm/madvise.c                                | 277 ++++++++++++++------
 24 files changed, 238 insertions(+), 102 deletions(-)

-- 
2.25.0.341.g760bfbb309-goog

