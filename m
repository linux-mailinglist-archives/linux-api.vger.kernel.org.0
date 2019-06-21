Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7124DE7D
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfFUBUv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:20:51 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52454 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfFUBUv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:51 -0400
Received: by mail-pf1-f201.google.com with SMTP id a20so3236061pfn.19
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C6hPbD+Iite9Yd/m2NEQoViniv+GetSpL6U00OfqPQs=;
        b=NC6cvFMGa8LejGjE8bJbN1AjDuFigoPl9T5orQwUKoq5IHOK8TozHCyvx0pPD2Rm8e
         bAyYl6xX/9Gy6Ipt42VzJZAyzi+X8rwrGgyiJX2wO4FJoIAAshNER1I5g7DXlyexK9si
         XMGS9K5vDj3tcpUbP2jAxzxgnc44GP4nj6CujSLV5K8B0mf6TsN8S+Umh0dIYpi+cKUv
         TeeJWfiWg32yGsZouUCqeP0hIShv+te6wXoeV8hILDOXlVOqLKbveOi4H6TW1Z22WtK8
         PdG1aRyg2ehyWgENrRcZiD1V78WlJpvC7CHV81NGewkkT8mPY/5rO5kwlttQr8GOIH8v
         cfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C6hPbD+Iite9Yd/m2NEQoViniv+GetSpL6U00OfqPQs=;
        b=aw4S9KUIlta9jOv68UC2v59ta+x3s7irgM3vaZPg5FhWbPpZX1Q72ph25048EO+ZBs
         k7DB4QVOb8iyi52Yvfyms7FFAvqQvengkD0MBsLd+32ye9HvPHaAKZDRAbPJyvL9Qzyz
         dxXOE5UUPwnuZG+QJZcLWl3rFd0DyccC9FZZJT0NDyR+h82kOHQUHJD1dQXuS+smDQXM
         lLSO3im6ozjxt1ePOZs94flJtOjCerfV/7RoeABEPlxeNhmhmT44qS3d8Cb7KjHSveUw
         QMc/L0THAVzDPy/k0cDkaebNGn/5cIBUR/4sCz77tEMqQQx+0p2f3C+ZhwOsyoSgRcnX
         cQCQ==
X-Gm-Message-State: APjAAAWJBRxvlTku1qozWJ5pNOgFFaLnAs3ED+o7cRDIRdokoCKUC8//
        a6mRGWGV3Ch2U0QjoxGwbXa493oTuFIGuVSqc2b1bw==
X-Google-Smtp-Source: APXvYqxY8KgyzR/E7rGtXtVWwMwLdjH8s+X06tcYPkPHRkAcJ+3cLw9bjREqZyBYZWv/RvvI6zuPEKjeSTS4RGxN0sM41Q==
X-Received: by 2002:a63:5a02:: with SMTP id o2mr14952617pgb.93.1561080050519;
 Thu, 20 Jun 2019 18:20:50 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:36 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-26-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 25/30] Lock down perf when in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 include/linux/security.h     | 1 +
 kernel/events/core.c         | 5 +++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8bf426cdd151..36a9daa13bb0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -98,6 +98,7 @@ enum lockdown_reason {
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
 	LOCKDOWN_BPF,
+	LOCKDOWN_PERF,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 72d06e302e99..ac1045caa44d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10731,6 +10731,11 @@ SYSCALL_DEFINE5(perf_event_open,
 			return -EINVAL;
 	}
 
+	if ((attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    security_is_locked_down(LOCKDOWN_PERF))
+		/* REGS_INTR can leak data, lockdown must prevent this */
+		return -EPERM;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
 	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 0a3bbf1ba01d..14edc475d75c 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -34,6 +34,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_BPF] = "use of bpf",
+	[LOCKDOWN_PERF] = "unsafe use of perf",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.22.0.410.gd8fdbe21b5-goog

