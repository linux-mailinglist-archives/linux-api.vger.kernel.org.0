Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED03153E
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 21:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfEaTXy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 15:23:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34665 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfEaTXy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 15:23:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id h2so1321875pgg.1
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 12:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=09OzKsWEH6pa0xbQSX5bdUX7ramAnBw1m5XpBBMtl8s=;
        b=V/C9Q62eYDojNjHKax3UL5A69Gvq2bE4i5dqf/ThRPONDysC1InWV2GZipZIxeeyqW
         SpaP+HzJy0YMQiSyvWrNcg7iV88gdyO+dospVszNdl5m0WfvdcLNUUd6xQympWmbGaR5
         lkpbihfGHBgFEirR7oV/vhXkuQi5OV34YRxJnfILgMCVIlsENyzWQnpGrwLAOjtij3cV
         Oqx8R662YYfzbEbvZNOoivAOBSoUtzv4sSUNPu6VsPgBSydSUeY7Ra1DaecMF3KQsqfq
         XV+u80lEsQRNjC7p6ntUWFDWq5X3rJtas6rEyqZK7LPlYx/svFaBG027idD3pI1bX4vJ
         P6tA==
X-Gm-Message-State: APjAAAVHWP+R1XHP9jEG3dFy49ndhDDCYTU3kVDYDX8CG43yqvFqdfHv
        kdHlWX3NY+oGqkD4le2pkjrWpw==
X-Google-Smtp-Source: APXvYqxvwP9LM12Xj44vBpACJtjdlNkpDxKvsKPHlpq7EZ6IL5RMgGPU0jVOgflGjcQSa2MLBHPa4g==
X-Received: by 2002:a17:90a:204a:: with SMTP id n68mr11635594pjc.31.1559330632786;
        Fri, 31 May 2019 12:23:52 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e6sm2346642pfi.42.2019.05.31.12.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:52 -0700 (PDT)
Subject: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
Date:   Fri, 31 May 2019 12:12:02 -0700
Message-Id: <20190531191204.4044-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/uapi/asm-generic/unistd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index dee7292e1df6..f0f4cad4c416 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -833,8 +833,11 @@ __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
 #define __NR_io_uring_register 427
 __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
 
+#define __NR_fchmodat4 428
+__SYSCALL(__NR_fchmodat4, sys_fchmodat4)
+
 #undef __NR_syscalls
-#define __NR_syscalls 428
+#define __NR_syscalls 429
 
 /*
  * 32 bit systems traditionally used different
-- 
2.21.0

