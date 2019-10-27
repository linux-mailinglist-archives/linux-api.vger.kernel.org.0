Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670ACE6201
	for <lists+linux-api@lfdr.de>; Sun, 27 Oct 2019 11:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfJ0KRl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 27 Oct 2019 06:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfJ0KRl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 27 Oct 2019 06:17:41 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55B66205C9;
        Sun, 27 Oct 2019 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572171460;
        bh=1/GtICbB1QJ08IPcfmlm4myAOcU2vLpne1WtR9Iw6ts=;
        h=From:To:Cc:Subject:Date:From;
        b=FMnlGwZWVBSvgfAhsWpuI8j3qxhrKgdjEWUTs1k5EeL2bX14jcHRCvErRcZ4gOE2T
         JKokAHe/xHMocxAfjtJhRmfXAQ4wAAAZY3Y94aR8kXojAUt2RLgCJn8DVf7lNwBOKq
         EfXLKG6WtLcMz1d40S+JguVm/LO4yAu3xTsJ0raU=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
Date:   Sun, 27 Oct 2019 12:17:31 +0200
Message-Id: <1572171452-7958-1-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

The patch below aims to allow applications to create mappins that have
pages visible only to the owning process. Such mappings could be used to
store secrets so that these secrets are not visible neither to other
processes nor to the kernel.

I've only tested the basic functionality, the changes should be verified
against THP/migration/compaction. Yet, I'd appreciate early feedback.

Mike Rapoport (1):
  mm: add MAP_EXCLUSIVE to create exclusive user mappings

 arch/x86/mm/fault.c                    | 14 ++++++++++
 fs/proc/task_mmu.c                     |  1 +
 include/linux/mm.h                     |  9 +++++++
 include/linux/page-flags.h             |  7 +++++
 include/linux/page_excl.h              | 49 ++++++++++++++++++++++++++++++++++
 include/trace/events/mmflags.h         |  9 ++++++-
 include/uapi/asm-generic/mman-common.h |  1 +
 kernel/fork.c                          |  3 ++-
 mm/Kconfig                             |  3 +++
 mm/gup.c                               |  8 ++++++
 mm/memory.c                            |  3 +++
 mm/mmap.c                              | 16 +++++++++++
 mm/page_alloc.c                        |  5 ++++
 13 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/page_excl.h

-- 
2.7.4

