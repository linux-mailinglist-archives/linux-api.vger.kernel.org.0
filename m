Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49157856FD
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389832AbfHHAJB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:09:01 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:52669 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389741AbfHHAI1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:08:27 -0400
Received: by mail-vk1-f201.google.com with SMTP id l186so39833721vke.19
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wWUVtXS/AXD8335Dh0MfmfyjjxhSNslzhtjFi/unWYg=;
        b=DdNVqYf2plZN2kFlxuLhjtuWgXV8nm1gqJlf97T8/uot+/jaf1l90CprMRuBIm7xA8
         VYaRWGfMozlZ0zi/w8YA51Hh/y+9qBV6iXNBdePVkg/sDgT9NEVyXH0lPlgX3vY5F6RW
         Ug+ylmGoY9yf9ILn3vJ1NZaONO0mdn/TbdCjm3B8uoV3r/8Gm7rISK+G0lWADAZtre0Z
         pEr8J5UFhOLT4Y5TKH+mAoKVke8ovg8ipF4UbWDLGX/xGDQ+xsU5EnbAXQNtkXyj7Skr
         Ih1a7z3Zs1TBZJdE+SOw6CU/yhIkcrbYCP4xstObpW3RBdf5krwSl2Zy7EQGS/VQqiQ1
         h0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wWUVtXS/AXD8335Dh0MfmfyjjxhSNslzhtjFi/unWYg=;
        b=gzUq+HF6MXjxAL/HEFQa96HA4W0fHoTv/b5JkA9/+V1mON57mXL+DllGeV/YVBBYFi
         A77HrnhVl9x6MAi+ZpgxTF/AuHKsM85qcz0D6FnC01DE7AMPcasPHe2NXKkeglfAR5rl
         ThfPjm6PDexPKEBdY9nHqk+3QTUbZ3+l+cdqkDCMcIM9rM7gXQv8i1fUyJgEdWf5fLV7
         Ri19V4ENGdBNtxTu2Gs9QN1q+3RRKCYLnDEAfVw/xDme5o+BMdjE+EG/jrkM5Nh++Ydy
         4PqA9fUgbp6svp99s4lqnT5eMY8XvglpALjIoxoSACONJQSrvt+t955T0mxaf97HnJYU
         uPMQ==
X-Gm-Message-State: APjAAAW0hxvZee9311eX2hcYQ0sNzKHYBxuHviNEpKcL4H2//m25VM3O
        4T3knQSkJ3kyywMattMoxFUziMz4LG9zQpY28ygzFA==
X-Google-Smtp-Source: APXvYqyxitklonktuhTk+1mcdmR320NSTCDOmTIQ4olyD+HJafcsfRdiGKNYDfexQo7EkUdQUykMv/dJMQOjq6/JJ9k+4w==
X-Received: by 2002:a1f:b0b:: with SMTP id 11mr4694030vkl.64.1565222906414;
 Wed, 07 Aug 2019 17:08:26 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:16 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-25-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 24/29] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the use of certain perf facilities that might allow userspace to
access kernel data.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/events/core.c         | 7 +++++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8dd1741a52cd..8ef366de70b0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -119,6 +119,7 @@ enum lockdown_reason {
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF_READ,
+	LOCKDOWN_PERF,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c1f52a749db2..5c520b60163a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10826,6 +10826,13 @@ SYSCALL_DEFINE5(perf_event_open,
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
+	err = security_locked_down(LOCKDOWN_PERF);
+	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return err;
+
+	err = 0;
+
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
 	 * opened to the cgroup directory in cgroupfs. The cpu argument
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 1b89d3e8e54d..fb437a7ef5f2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -34,6 +34,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
+	[LOCKDOWN_PERF] = "unsafe use of perf",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.770.g0f2c4a37fd-goog

