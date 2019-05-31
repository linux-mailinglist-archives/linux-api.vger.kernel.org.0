Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B595F3154D
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 21:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfEaTYB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 15:24:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46507 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfEaTXz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 15:23:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so6744103pfm.13
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 12:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=aiQIM6f9frALGlBHOVEXZviohTaEbE7nb+FTGwUVD4A=;
        b=mVljD/FD/E/7+o0zw9XBJ0E1drD8WZcdNQJ0WOgYdRusMoObDxgefewOriBb8UKnnz
         Sva5NIXKSyEhIWnLRWlINv2ySA55Epw203NNcm6wbQp/W8hviaY2ed+Xxbw7IO6YQp3n
         6KDkkGGdkUfsofDSIa+jQtLxgsVkFUycQST7I78Mmok4WPEt7ZMtKVMuV/o9JWX6+775
         4/sp5SRNejP4+FaNUJck0QITQi6JJP+sMGL5g9wugTfNZlMKQ2lI5lXws+Jw2BJMSO/s
         nsmv+9KPZI+O82R3rEs9rkdzl/msdr6Uyybr9+Bxf9TG4Xqn8uVLCHkJHxUFAHnir+0T
         WH5g==
X-Gm-Message-State: APjAAAX9aXK66wG7oBRHS3jg+g20MwnWyOpo87bRuneO72HR5CSuEX1i
        +Hk3sC+81US2KYrSVLRrussvSg==
X-Google-Smtp-Source: APXvYqxnHH048gsRvFfx6yXHqqmSGXwu8SiZWTfESkHE4QP5Ki/bYzl/4Onunf3wDQIsChfj3cuqqg==
X-Received: by 2002:a62:a511:: with SMTP id v17mr11832352pfm.129.1559330634068;
        Fri, 31 May 2019 12:23:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x16sm6569182pff.30.2019.05.31.12.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:53 -0700 (PDT)
Subject: [PATCH 4/5] x86: Add fchmodat4 to syscall_64.tbl
Date:   Fri, 31 May 2019 12:12:03 -0700
Message-Id: <20190531191204.4044-5-palmer@sifive.com>
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
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 92ee0b4378d4..998aa3eb09e2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -349,6 +349,7 @@
 425	common	io_uring_setup		__x64_sys_io_uring_setup
 426	common	io_uring_enter		__x64_sys_io_uring_enter
 427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	fchmodat4		__x64_sys_fchmodat4
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
2.21.0

