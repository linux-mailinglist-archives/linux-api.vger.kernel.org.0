Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561A93122AE
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 09:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBGI3T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 03:29:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12474 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBGI1H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 03:27:07 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYMf66cr2zjKdl;
        Sun,  7 Feb 2021 16:25:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 16:26:15 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     <gregkh@linuxfoundation.org>, <song.bao.hua@hisilicon.com>,
        <jgg@ziepe.ca>, <kevin.tian@intel.com>, <jean-philippe@linaro.org>,
        <eric.auger@redhat.com>, <liguozhu@hisilicon.com>,
        <zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [RFC PATCH v3 0/2] mempinfd: Add new syscall to provide memory pin
Date:   Sun, 7 Feb 2021 16:18:02 +0800
Message-ID: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This series adds a new mempinfd syscall to offer a common way to pin/unpin
memory.

Patch 1/2 is about mempinfd codes.
Patch 2/2 adds a simple test tool about mempinfd.

Change logs:
------------
v2 -> v3:
 - Follow suggestions from Greg and Kevin, add a new syscall.
 - Add input check.
 - Use xa_insert to replace xa_store.
 - Add lock to pretect pin and xa_insert.
v1 -> v2:
 - Some tiny fixes.
 - Follow Greg's suggestion to get mm-list and iommu-list involved.

Links:
------
 - v2: https://www.spinics.net/lists/kernel/msg3808926.html
 - v1: https://www.spinics.net/lists/kernel/msg3805205.html

Zhou Wang (2):
  mempinfd: Add new syscall to provide memory pin
  selftests/vm: add mempinfd test

 arch/arm64/include/asm/unistd.h       |   2 +-
 arch/arm64/include/asm/unistd32.h     |   2 +
 fs/Makefile                           |   1 +
 fs/mempinfd.c                         | 199 ++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h              |   1 +
 include/uapi/asm-generic/unistd.h     |   4 +-
 include/uapi/linux/mempinfd.h         |  23 ++++
 init/Kconfig                          |   6 +
 tools/testing/selftests/vm/Makefile   |   1 +
 tools/testing/selftests/vm/mempinfd.c | 131 ++++++++++++++++++++++
 10 files changed, 368 insertions(+), 2 deletions(-)
 create mode 100644 fs/mempinfd.c
 create mode 100644 include/uapi/linux/mempinfd.h
 create mode 100644 tools/testing/selftests/vm/mempinfd.c

-- 
2.8.1

