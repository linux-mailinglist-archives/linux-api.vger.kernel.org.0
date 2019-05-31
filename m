Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F0931543
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 21:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfEaTYA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 15:24:00 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:34650 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfEaTX4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 15:23:56 -0400
Received: by mail-pf1-f180.google.com with SMTP id c14so4367783pfi.1
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 12:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=iIsIHJ/E9sb9iivYOWYTrHBdX9wvV0BVSK9WYc+2hhY=;
        b=JEbiNV2TUsFfs4QgYgw7uzeGLn0ky67gO6ve4Ygkk9Csxi8PbC9UewpXQBJ7HN1c0B
         OEK5BwYgaD5VA0eFUpsPtUiSXs2zbUgJ/urTW79FXqadSAS2d8N3nukvnqj7jNWPPOZ2
         6VXSgNe3qYQ8oyPRLzplC8lh9MCONN5l8HLj0LzK/fYZNhAvTNC9zRly8s0s2cz9BDhf
         43xLp9XUSs2sOvT3jI2q0Mvk55uordbnwkgFw3USV5DAV0CSoGNOmhs2ltlEPye8kMEu
         dZpxr7XEXaww/A8oehMPg8gVn4WVlfsEw6oBG+yAXCc1NjbYOkHhXzaepDfEAMV8+f+K
         cjWA==
X-Gm-Message-State: APjAAAWa+bK10ov+00uhqNBjKLXb67GhkmolKToKHZ24urCVWBAMggjf
        n2Gqp6aa3fWa4Yz6VKrBQI5LLA==
X-Google-Smtp-Source: APXvYqwqjBeSRHkNhprVnlAw/2N8AmL71UGiONuyr+S2FzywQVEi5ye6pcOigbDzCrp3j+bmycDwJw==
X-Received: by 2002:a62:d410:: with SMTP id a16mr4454667pfh.167.1559330635344;
        Fri, 31 May 2019 12:23:55 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m1sm6059048pjv.22.2019.05.31.12.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:54 -0700 (PDT)
Subject: [PATCH 5/5] x86: Add fchmod4 to syscall_32.tbl
Date:   Fri, 31 May 2019 12:12:04 -0700
Message-Id: <20190531191204.4044-6-palmer@sifive.com>
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
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 1f9607ed087c..319c7a6d3f02 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -433,3 +433,4 @@
 425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
 426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
 427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	fchmodat4		sys_fchmodat4			__ia32_sys_fchmodat4
-- 
2.21.0

