Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD743007
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfFLT1x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:27:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39692 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfFLT07 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so15487992wrt.6
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=TmXrcETEyy3+sK8LfNnwGn++cLYf6PFNLYfj4yjREecckdlrBc5m2D9MfwSBeDdNPm
         g3NbKAsf9zd2oTcqD9rCnusrjSai0HTstUsoPUXx6LpuvYueOJemP7gcraNhCFQNYIae
         Ep9h0tZMg+MCsukd4UdvHhC4+E+Phg2YCnXqwMMUI+dMz3qEkNfBo90SVCIPBNPpKPpH
         A7A7G3+aGn5g/lRQBzOnLuED2x2u9GZwnBhmXVv/df+9dORL/IUwVRhs/TMW8NPeEmQT
         DVeCd+zSMeYkycSgeqYWVHQvm0RkEZtWF+/6iM9/e+EIylpnEqnIdurhFNXwzhrijjfY
         8xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=hMBv7XovEKdWee3IET8r951EVFpQBvPz56K+N/Atb1Sb28Nlskds970g/yzR+DXIhA
         Pde5gGWaGVCepyaKEH/oW53bJDtxWK/CvPzJ9pMY+5fMB4cH2smh1ocu1Py0/GSvFnYx
         rLK/1nBlNG12CIN7YphIbgvaHKzSa7j4y6DEv31eu9kmrjiOiLjuDhctAN4Py/lwgP2S
         FOuBhYyJLULLRGCl3UhWhFzJlynhmtqxEhx5siFOfyttI9MHKdrzzD3Fg+NNDr/e67xM
         KqoczZMbtFtxZPOwIfTjFpvuCPKNYr5mjcz3jlh7+yUaUKD4a+W1rZ1by8BRem/hUtRG
         sEdg==
X-Gm-Message-State: APjAAAW8amxydmM6eEhf1ykwappN/nDiBlz/FGIiENxVDbWI+5EwhJoL
        p/q5NmwXCQ5hbNjTkZzIcKDkQw==
X-Google-Smtp-Source: APXvYqzk4aReSDfZmvcmlI8KjUcC/U+TRc5q/ppSGl3W/BAdcrzIhmwuQ/hZAWWU16yh+WUQZ7yXDA==
X-Received: by 2002:adf:e54b:: with SMTP id z11mr41279169wrm.198.1560367617451;
        Wed, 12 Jun 2019 12:26:57 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:56 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 19/28] timens: Add align for timens_offsets
Date:   Wed, 12 Jun 2019 20:26:18 +0100
Message-Id: <20190612192628.23797-20-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Align offsets so that time namespace will work for ia32 applications on
x86_64 host.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index e93aabaa5e45..05da1b0563ce 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -2,9 +2,17 @@
 #ifndef _LINUX_TIME_OFFSETS_H
 #define _LINUX_TIME_OFFSETS_H
 
+/*
+ * Time offsets need align as they're placed on VVAR page,
+ * which is used by x86_64 and ia32 VDSO code.
+ * On ia32 offset::tv_sec (u64) has align(4), so re-align offsets
+ * to the same positions as 64-bit offsets.
+ * On 64-bit big-endian systems VDSO should convert to timespec64
+ * to timespec because of a padding occurring between the fields.
+ */
 struct timens_offsets {
-	struct timespec64 monotonic;
-	struct timespec64 boottime;
+	struct timespec64 monotonic __aligned(8);
+	struct timespec64 boottime __aligned(8);
 };
 
 #endif
-- 
2.22.0

