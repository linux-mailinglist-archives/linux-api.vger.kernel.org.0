Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C47140052
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 01:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgAPX77 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 18:59:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53260 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPX77 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jan 2020 18:59:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so2327350pjc.3;
        Thu, 16 Jan 2020 15:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CzG/+enlCQzh2PEldVrxjNnE7U+SNtVgOSzvdsBcADU=;
        b=F2v3toNYnfFqQUyw6x3N7//SMHYRN13v+ZPOldYSLqV8UY6+AqK4DbYydfN+CoN8IG
         qLLk8Hvd5Bc1SJRAPeCEUhrx7S4kBmD07wkCZmf823GUc29l2mclHI74aRm3A9goTScp
         cAM6sOkPe0No97IBxVY5eQRXuIBBS9DJs9Jy7+DwILntGzBKiXorrJ//oXbz1EdESaEZ
         Zte5orRtIvXG0nF64FI9Zbbg9ue+7spGSQBOl10VarQFuM6pIV5YUpZQ/0n5xW15GUCS
         SO96RLVB1fQuVVVnnmIzaubOo/K1TS65Yn/qYqx6qmGzqD1swf8G/MQNGlbaXJV5Jaoi
         Ajuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CzG/+enlCQzh2PEldVrxjNnE7U+SNtVgOSzvdsBcADU=;
        b=P+0tdjpET+/I7oEBWFO8AkUJK2AUToxKZjrWGCTB3satD1xdC2HcJqdba7acmnxxEQ
         /MH73L2N2IOpwAy84TpIIPTHhiLxynUHZ8bShnvYxht22JF/SBVUzq3n4teJudzPFleg
         OHtpADXHc3hFEnXe5WgYpxPfC5JnJW8/7Vpsm1t7k8QomQhkpn9BnQwcqTbT7nBNfmr/
         LklafIjcDN+ZRM3cSPUSTFnWGZOlvP5391YY2u66zeJBlXlm3kfjPumdEFB/ZZ9i7OHs
         lCd5CYQSuSLfgNjkntVl2ehdJYUovjjHioisyZV8cdwG2Q94CnGRCMZr52Xf4IMSsUPx
         R40g==
X-Gm-Message-State: APjAAAWLXPOx8RV7xc50pVDM2ht+Xb1kMFlj66K4NfOgqLkS9aRW7vOq
        ae4r5TMUPAGUQdaD/siaeZk=
X-Google-Smtp-Source: APXvYqwlhvXUMP4R0TTP6WlHVKFM1ZuAfuosRyTmmZybSE+cUdmVz7aTgL+1O3XlksiaTb8C3G0UWA==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr2231520pjv.140.1579219198676;
        Thu, 16 Jan 2020 15:59:58 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z4sm26584885pfn.42.2020.01.16.15.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 15:59:57 -0800 (PST)
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
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 0/5] introduce memory hinting API for external process
Date:   Thu, 16 Jan 2020 15:59:48 -0800
Message-Id: <20200116235953.163318-1-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
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

Minchan Kim (3):
  mm: factor out madvise's core functionality
  mm: introduce external memory hinting API
  mm: support both pid and pidfd for process_madvise

Oleksandr Natalenko (2):
  mm/madvise: employ mmget_still_valid for write lock
  mm/madvise: allow KSM hints for remote API

* from v1 - https://lore.kernel.org/linux-mm/20200110213433.94739-1-minchan@kernel.org/
  * fix syscall number - SeongJae
  * use get_pid_task - Kirill
  * extend API to support pid as well as pidfd - Kirill

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
 mm/madvise.c                                | 272 ++++++++++++++------
 24 files changed, 233 insertions(+), 102 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

