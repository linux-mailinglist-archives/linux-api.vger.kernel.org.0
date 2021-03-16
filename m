Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79E833DDA2
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhCPTfF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 15:35:05 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47809 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhCPTe3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Mar 2021 15:34:29 -0400
X-Originating-IP: 2.7.49.219
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 021611C0004;
        Tue, 16 Mar 2021 19:34:21 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-api@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
Date:   Tue, 16 Mar 2021 15:34:20 -0400
Message-Id: <20210316193420.904-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Increase COMMAND_LINE_SIZE as the current default value is too low
for syzbot kernel command line.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/include/uapi/asm/setup.h | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 arch/riscv/include/uapi/asm/setup.h

diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/asm/setup.h
new file mode 100644
index 000000000000..66b13a522880
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/setup.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+
+#ifndef _UAPI_ASM_RISCV_SETUP_H
+#define _UAPI_ASM_RISCV_SETUP_H
+
+#define COMMAND_LINE_SIZE	1024
+
+#endif /* _UAPI_ASM_RISCV_SETUP_H */
-- 
2.20.1

