Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4A31E265
	for <lists+linux-api@lfdr.de>; Wed, 17 Feb 2021 23:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhBQWfC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Feb 2021 17:35:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:15550 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233935AbhBQWc3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 17 Feb 2021 17:32:29 -0500
IronPort-SDR: c6cLwFIv7Kh4e1t/3HafvF1CUOtAoEsjXp+mlDQpB9nc0eN0AP9i1yily9xGXVlO9yjCvgXc67
 aMQsbPWlTZng==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183408999"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="183408999"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:31:45 -0800
IronPort-SDR: Lx1J4MPTKVtIOVaO9O+FGhFiogAn1Ae6Zwg9iidmqao5eDMpjO1TQ/CIJf6fJfnADJ060PfSG2
 Q6woQk53gXOw==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="362200450"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:31:44 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v21 0/7] Control-flow Enforcement: Indirect Branch Tracking
Date:   Wed, 17 Feb 2021 14:31:28 -0800
Message-Id: <20210217223135.16790-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Control-flow Enforcement (CET) is a new Intel processor feature that blocks
return/jump-oriented programming attacks.  Details are in "Intel 64 and
IA-32 Architectures Software Developer's Manual" [1].

This is the second part of CET and enables Indirect Branch Tracking (IBT).
It is built on top of the shadow stack series.

Changes in v21:
- Rebase to Linus tree v5.11.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Indirect Branch Tracking patches v20:

    https://lkml.kernel.org/r/20210210180245.13770-1-yu-cheng.yu@intel.com/

H.J. Lu (3):
  x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
  x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point
  x86/vdso: Insert endbr32/endbr64 to vDSO

Yu-cheng Yu (4):
  x86/cet/ibt: Update Kconfig for user-mode Indirect Branch Tracking
  x86/cet/ibt: User-mode Indirect Branch Tracking support
  x86/cet/ibt: Handle signals for Indirect Branch Tracking
  x86/cet/ibt: Update ELF header parsing for Indirect Branch Tracking

 arch/x86/Kconfig                         |  1 +
 arch/x86/entry/vdso/Makefile             |  4 ++
 arch/x86/entry/vdso/vdso32/system_call.S |  3 ++
 arch/x86/include/asm/cet.h               |  3 ++
 arch/x86/kernel/cet.c                    | 59 +++++++++++++++++++++++-
 arch/x86/kernel/cet_prctl.c              |  5 ++
 arch/x86/kernel/fpu/signal.c             |  8 ++--
 arch/x86/kernel/process_64.c             |  8 ++++
 8 files changed, 86 insertions(+), 5 deletions(-)

-- 
2.21.0

