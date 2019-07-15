Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336E169C3A
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfGOUC0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:02:26 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:39689 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbfGOUAV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:21 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so10862861pfi.6
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Fsa5djs+VQ2BrQJC+FUs9YwCCHQQfjCNM9PGrMIw+A=;
        b=cJ58uU0XE/YKJRyI5Mt8XS66fhl7mlr/5SBCN06rI3kOZahs9sJMcXx2ibpLoUVCaE
         9N1NY7OgxzhRPwe9rAJ9sX1BJ0ihRRRL3eB1ATlWoL9AgojAMGNFU+IEzasvl9Qi8eeC
         ZkFc3LVDfGlr7B4KL2h2Fk7rzQRbQLG0fV2EprbbLhYAb3pInpVl0C4tpIWrC5ke1CaF
         8SpfsbNg0HaA8UNxyOZPyFO9oH7pXi6W4xurmmtxgY7D5fmX5k+NL4JCD8shTiLjN3Q2
         SXoPSH4JASf5Jv9Der3AxoWSuW+W9hMxss6p61KH1/LToqcS5HgvobYgH+qD2KX+O9I0
         NjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Fsa5djs+VQ2BrQJC+FUs9YwCCHQQfjCNM9PGrMIw+A=;
        b=DiNy8PR32Jbrj1EH2XaJ7lpxu4igtuH8DdFSMdZ6R2//6x8d7olonJ4SJxJk8HwoIM
         mEoXegUhRy2kHs6ej+rsIkRXybz2r01bqI4nDEcxZQN0i/7VByP92YgUZm8PzNKlk4MA
         0ivkLew98sdUVL6WWKHlfXvPk1IWNjkQ7NpBIprsb2h4i1fbRpfAdPyPUSu/5um00pq4
         CfiFXw25CHQH0Nv3F389hTfOq6iw/V8hYFDJhVWNwWGzVugFsVM230OfBZEAXczSKx/5
         S/FFl+NmmlWgRESzRmUk/1QS9qHNgGQJWFPK9KrJ/YpghRs98Vvu2ZM1pOarAzCYtLQm
         tJAw==
X-Gm-Message-State: APjAAAXyA1TkjhDhXSC4zsouOtT6g50dbbte72mJ+lpQCcWhtT9Xxabv
        WzrP+tk94rdwmCT4ezNmLUyyGQdFL/kZ20t5XRFisw==
X-Google-Smtp-Source: APXvYqwVtJa9IPgk7H5zDUOO19rxBXwa1dInRZDEXWO7Uz1DWQaii5wotdUMuZXkJSevrN+xH8Yzo5reUPeuqmqn92YMUQ==
X-Received: by 2002:a63:f857:: with SMTP id v23mr3963600pgj.228.1563220820065;
 Mon, 15 Jul 2019 13:00:20 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:27 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-11-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 10/29] hibernate: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, rjw@rjwysocki.net,
        pavel@ucw.cz, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Josh Boyer <jwboyer@fedoraproject.org>

There is currently no way to verify the resume image when returning
from hibernate.  This might compromise the signed modules trust model,
so until we can work with signed hibernate images we disable it when the
kernel is locked down.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: rjw@rjwysocki.net
Cc: pavel@ucw.cz
cc: linux-pm@vger.kernel.org
---
 include/linux/security.h     | 1 +
 kernel/power/hibernate.c     | 3 ++-
 security/lockdown/lockdown.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 69c5de539e9a..304a155a5628 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -106,6 +106,7 @@ enum lockdown_reason {
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
 	LOCKDOWN_KEXEC,
+	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index cd7434e6000d..3c0a5a8170b0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -30,6 +30,7 @@
 #include <linux/ctype.h>
 #include <linux/genhd.h>
 #include <linux/ktime.h>
+#include <linux/security.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -68,7 +69,7 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 bool hibernation_available(void)
 {
-	return (nohibernate == 0);
+	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 /**
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 6f302c156bc8..a0996f75629f 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -21,6 +21,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.510.g264f2c817a-goog

