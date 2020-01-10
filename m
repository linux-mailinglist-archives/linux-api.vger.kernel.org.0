Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64630137887
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 22:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgAJVej (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jan 2020 16:34:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44870 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgAJVej (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jan 2020 16:34:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so1569603pgl.11;
        Fri, 10 Jan 2020 13:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUxvkA/9wBEhfF4c0Ct5r0wRWCEBzV0f25SyUAAjvzQ=;
        b=Ysp3fcGZ5hTzZMkrpsarvwMsGJeWWUxqKFw0tO8sE+eOKLDBShkkvEo5ksv7WIJjfu
         U4DXzuq2MGcxaDZ1TWoEfIJx6xtxles0BkiWMEraZVR0iti5nYCd15SmFBPt5SBwKb3h
         EVNA+zdD8XN3KaHinsDhLVDT9DCPrcrXEbFc9uirjDf3851eDnp8874XUwC5m/CuOJ4d
         L/RV4hNQB5k/+DI7EZ69gRmZql6dFK43gDmTPbfbJWmQetNrGkIJJvbMHe55EdnYlCmT
         xSySiRihDqmJfiDkCbW1LxLed06ZW21aPe1FUANQyy3pcQoCHrNYPNd7wDqDRD6egZ0a
         ZShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kUxvkA/9wBEhfF4c0Ct5r0wRWCEBzV0f25SyUAAjvzQ=;
        b=g495Gt2a0LEBOoz0KY4xP7UPbrmpDfheX1AjNDGQCxtXMJXomFbun9p0uWylQYWh3C
         uQ4Hq+ilR+M5kAoEek7E+krKVrvEzJnX3FK7B4E7pw3SumwMhCB9T1WwhwGB8V0zrSUZ
         Z2v/lKiUvxZP/RjWdPqDnTRco9V/kTbUND5Wbm4+rSRpAnh/ppA8nBl7PE3+tRxqbqUk
         IpgV7YCfgqUhMn3BZRt/MW09h9DQIQCGLgA0h32gXuT51XEVWMk3QoG/nEEXScXMi/4m
         1hlN489rUbeXKnxy0+ku7bgusAQdtdcxyO+UArjhHfFeOvUuGSzG3ydL+b1npjUwUtAO
         FPSA==
X-Gm-Message-State: APjAAAXi255F/+TZ5hQbemWWeZU1uxhgvv9Gya3TbIg5k3Yyz7XMP3II
        vpsQHuoULQqk4Qn/fs+dGQCueJa2
X-Google-Smtp-Source: APXvYqxARsDrk+ixhGWJoPkKby6xFB+IlE0oFwuWc/PMGRgL/6mrQg84c+egjiIFNPaOAzor8ns0Pg==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr6465632pfa.176.1578692078184;
        Fri, 10 Jan 2020 13:34:38 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t137sm3692307pgb.40.2020.01.10.13.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:34:37 -0800 (PST)
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
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 0/4] introduce memory hinting API for external process
Date:   Fri, 10 Jan 2020 13:34:29 -0800
Message-Id: <20200110213433.94739-1-minchan@kernel.org>
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

Minchan Kim (2):
  mm: factor out madvise's core functionality
  mm: introduce external memory hinting API

Oleksandr Natalenko (2):
  mm/madvise: employ mmget_still_valid for write lock
  mm/madvise: allow KSM hints for remote API

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
 include/linux/syscalls.h                    |   2 +
 include/uapi/asm-generic/unistd.h           |   5 +-
 kernel/sys_ni.c                             |   1 +
 mm/madvise.c                                | 263 ++++++++++++++------
 21 files changed, 205 insertions(+), 85 deletions(-)

-- 
2.25.0.rc1.283.g88dfdc4193-goog

