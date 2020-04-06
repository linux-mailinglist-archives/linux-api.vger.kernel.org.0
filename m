Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43619FB24
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 19:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDFRNv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 13:13:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgDFRNu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 13:13:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so268474pgo.0
        for <linux-api@vger.kernel.org>; Mon, 06 Apr 2020 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGJACKQu1bguU+JASnr0st35ZbPyO/prVOsR97eFOTY=;
        b=C1p+CAcageRdS3KC99Y6ETnCxpN2z/k+fLn/ubFK9Kt38T7Baow42EI4AsMzxu+vgo
         7tQHAk7hzJuN/3qb0+oA3J3t07BCG+6Z1dc1p85nA5BxxOTNaNEB+OJGL6NS4zppBpUO
         I3aX3NGKydV1auY4P1etSTH9E1EsEyNaO2soSJVEU5qOCOLwXNyHXq0q2swc2pkdb2Sk
         WN9yUPDlI8trMZL8Cxm/5HGD1GddFpBAflz2A2ereTcSL36bYUr7TNWkGsS/reBXansp
         Sq85cpjt0zClcPaYNS3NspAtBR6mb2JCWds+9/jAR3K4zw0+CQkxFPqYn5XBjTiR1IWQ
         huiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGJACKQu1bguU+JASnr0st35ZbPyO/prVOsR97eFOTY=;
        b=oUbjrZXqHVedhPCicBQCv9uqkkXvc+Iie70tCfFJR9Un1KxiHgx11F1Vxeb0o8QB0Z
         /fHtYQ/4w8mmZhwkRny3/fEJaP2MU7sdxDJytyxZx+9g2usCF3NMXk+RKDcBMw198nA7
         niQdmytp4KzLrDbfICiQ+hvbX3NULldkCbiRbwKlLNlBL3IFYFMpHiGGhFar0kZPHW+l
         tCjSJU6vtQD0Ff30CnOboR0ogPqaU0HFVBwDSdke29z3h9KigVVoVn2nCvTcPPioTMJb
         AcTc8L0ZjadDNn4H8exmzkkPyxqa/4VoqZb/z0y1ub3iztreUKypEOUBynIrCRQKu849
         MwUA==
X-Gm-Message-State: AGi0Pua/isUSmcmwXesflZZ872Tpz0BlHbqy94TtRFIVwqcF04aREIj7
        kFOSrYb0TVk8u/xWkCUk/U+0KQ==
X-Google-Smtp-Source: APiQypKr3FJFeibyVamzRtJrpO32ZJnhX5YwVwWHy43COBXcQIeCyc45/KaSQgwsCSBC5hhs6UghaA==
X-Received: by 2002:a62:dd09:: with SMTP id w9mr424374pff.311.1586193229108;
        Mon, 06 Apr 2020 10:13:49 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id w29sm11219224pge.25.2020.04.06.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:13:48 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrey Vagin <avagin@openvz.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>, stable@kernel.org
Subject: [PATCH] kernel/time: Add max_time_namespaces ucount
Date:   Mon,  6 Apr 2020 18:13:42 +0100
Message-Id: <20200406171342.128733-1-dima@arista.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Introduce missing time namespaces limit per-userns.
Michael noticed that userns limit for number of time namespaces is
missing.

Furthermore, time namespace introduced UCOUNT_TIME_NAMESPACES, but
didn't introduce an array member in user_table[]. It would make array's
initialisation OOB write, but by luck the user_table array has
an excessive empty member (all accesses to the array are limited with
UCOUNT_COUNTS - so it silently reuses the last free member.

Fixes user-visible regression: max_inotify_instances by reason of the
missing UCOUNT_ENTRY() has limited max number of namespaces instead of
the number of inotify instances.

Fixes: 769071ac9f20 ("ns: Introduce Time Namespace")
Cc: Adrian Reber <adrian@lisas.de>
Cc: Andrey Vagin <avagin@openvz.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Containers <containers@lists.linux-foundation.org>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: stable@kernel.org # v5.6+
Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/admin-guide/sysctl/user.rst | 6 ++++++
 kernel/ucount.c                           | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/user.rst b/Documentation/admin-guide/sysctl/user.rst
index 650eaa03f15e..c45824589339 100644
--- a/Documentation/admin-guide/sysctl/user.rst
+++ b/Documentation/admin-guide/sysctl/user.rst
@@ -65,6 +65,12 @@ max_pid_namespaces
   The maximum number of pid namespaces that any user in the current
   user namespace may create.
 
+max_time_namespaces
+===================
+
+  The maximum number of time namespaces that any user in the current
+  user namespace may create.
+
 max_user_namespaces
 ===================
 
diff --git a/kernel/ucount.c b/kernel/ucount.c
index a53cc2b4179c..29c60eb4ec9b 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -69,6 +69,7 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_net_namespaces"),
 	UCOUNT_ENTRY("max_mnt_namespaces"),
 	UCOUNT_ENTRY("max_cgroup_namespaces"),
+	UCOUNT_ENTRY("max_time_namespaces"),
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
-- 
2.26.0

