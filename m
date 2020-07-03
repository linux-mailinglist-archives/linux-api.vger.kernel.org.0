Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007342130E6
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2020 03:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgGCBUL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Jul 2020 21:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGCBUL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Jul 2020 21:20:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B87C08C5C1;
        Thu,  2 Jul 2020 18:20:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so3952919pgv.9;
        Thu, 02 Jul 2020 18:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/bbf0lUkrxiWX+PZ82pZ/eXhfvbz8TXVOafo3xC3F0=;
        b=HkoezpR3Rsole2z2xQyFjnqIZB96rn8qursrHwJyGGYjCnRvK0CdUvFnNkVo/a3oxj
         tZiHoW4EOwjWjrKuT2Fm0bHj61Tn91It9qgnjPgpDfdHlzL2Rlc61PP2G4uxcEZQcv0y
         w6XzjQRr0TwzY4uc++FK4kSVBTQBG+RodfVT1VXSveDOiIlzGe3a76zuRl1MDiD9AlX2
         +xkRcvI6Lm+n9CV6fcCl/0wJ6EDqI0+ggDPF5JcvZa/PqxcGUsPy/bYxa4mg881CjKEp
         CnafRjr0co53AqXKYi9sZr1G8CzaLd9T4cVFMb+x/IRXsfr3HT7FKDjoe7W1Gvpdr8R1
         iVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/bbf0lUkrxiWX+PZ82pZ/eXhfvbz8TXVOafo3xC3F0=;
        b=pmdQeVu1C3odlaq5yLup3kZ/F6Hc8JQ7qnA94jlaWMebxzsI1MqSGAbfwfL70Y3EM1
         4BFju6ZGNhRLyQgd68offDv6iCXhYnl7uMryc6y5Sj/sH9+EcqV7DqDjjxIL9UTiUERM
         eOK3FBY8vo18kpuldXBo59DqfcU1EtCbmYGY9p/xOqshTey4771PvUsXmH4lssHcOD8x
         51S2u9CwBRKFGJ21YInYVCUOQLRSx2WQlrvrwcvDf6x4IVrdN0md9gZOlKL+ShZPhh0V
         juJ/LYt2NeAf5qToI6gV+j800mFmtsWeUUffwgC9IPwG4S9KtQU3nEElgtsS7sy1yVzD
         mQRQ==
X-Gm-Message-State: AOAM533SAJQMKJKNHaN2pRHSbN5Wi2tjLmqMSIYoO7U8uK07mUmDWBiJ
        Kk5BahGzh+uf2VQbM6dlAsc=
X-Google-Smtp-Source: ABdhPJxTT4D2raEsHiMfFaMgNHqSE7CiS0TXVGXWZARc5uCHcybm0Uq1+PwOqMoXtrME3PxEG4EBvA==
X-Received: by 2002:a63:e00c:: with SMTP id e12mr26903209pgh.413.1593739210833;
        Thu, 02 Jul 2020 18:20:10 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id v186sm10094222pfv.141.2020.07.02.18.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 18:20:10 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: [PATCH v2 0/3] remove PROT_SAO support and disable
Date:   Fri,  3 Jul 2020 11:19:55 +1000
Message-Id: <20200703011958.1166620-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It was suggested that I post this to a wider audience on account of
the change to supported userspace features in patch 2 particularly.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc: remove stale calc_vm_prot_bits comment
  powerpc/64s: remove PROT_SAO support
  powerpc/64s/hash: disable subpage_prot syscall by default

 arch/powerpc/Kconfig                          |  7 +++-
 arch/powerpc/configs/powernv_defconfig        |  1 -
 arch/powerpc/configs/pseries_defconfig        |  1 -
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  8 ++--
 arch/powerpc/include/asm/cputable.h           | 10 ++---
 arch/powerpc/include/asm/kvm_book3s_64.h      |  5 ++-
 arch/powerpc/include/asm/mman.h               | 30 ++-----------
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  2 -
 arch/powerpc/include/uapi/asm/mman.h          |  2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c             |  2 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  2 -
 include/linux/mm.h                            |  2 -
 include/trace/events/mmflags.h                |  2 -
 mm/ksm.c                                      |  4 --
 tools/testing/selftests/powerpc/mm/.gitignore |  1 -
 tools/testing/selftests/powerpc/mm/Makefile   |  4 +-
 tools/testing/selftests/powerpc/mm/prot_sao.c | 42 -------------------
 17 files changed, 25 insertions(+), 100 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/mm/prot_sao.c

-- 
2.23.0

