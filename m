Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4326D4DEA4
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfFUBVv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:21:51 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50436 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfFUBUd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:33 -0400
Received: by mail-pf1-f201.google.com with SMTP id h27so3235003pfq.17
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=21zVfVQIgxs18frGEjlMaz6K2O9ZtjPmBWXUPVoOvcs=;
        b=WyOmpA9QtPvqxVTlHFAr1aYSi9expt/Y60JFM3suEeorE0t0yy/GrUS6vGGOUzScpn
         JWZAFEuq63FT1Mk6EFCTu9MKkPJwkf6/tNKBPo/ySXxusxtXZjsaTBT6xs8DpkhwinQ5
         FTZ2Sxvb8IZVoca4y42ewg/D89PAQq98EgQWP4Nv/z2yRE6dIbskvmYmpCRgKGY17NII
         SxM05/6NL1lIjhSm9Fc/EvF6I9txsfx6UkmcI2qGr0BzsfKJ35bbQYacXol/JRRmPs9r
         F4qDUqadiASSdMEkkd/udpLqwhtA7xlA60IhnZSY0xQ/cN6d/wGSp+5h8Lo/i0xiMjM8
         qLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=21zVfVQIgxs18frGEjlMaz6K2O9ZtjPmBWXUPVoOvcs=;
        b=MRTPsZS66SMND3BTaIMSmRrIYeeV+vz64oLnnysPYtjHuoMLFQXWvfBABrSBBTYy9f
         fwycK3XgkJ+RHFamZ8u7To+G9vpiOyjxpPSljDHAIT0m7YzXPl2Iw4k8uslyZ8aiL/y7
         jkQPY0bYPM8iT3CSkIR+tRI5WXpmyIjqUOccuPaXd6Q4iWTo8/lnv75h2FN0i8uL33zX
         1haT6Kffdz/vqq7W7XN7FWumVe+nzp8XGiDBrqheBOwxp40mi4ukg2He48Ie2p5bGclx
         EE6CRcRk+9Csw2eM27/R0P/yRYJrjxUDNYL1QvIwxXFiOXFiGD9nafyIoauUiYhFo2ij
         FV4w==
X-Gm-Message-State: APjAAAXOBQV582zkqqdQmrTNqEia3NzBkhMeqbV0gg7ITzSeBSnsuga4
        pN6ukF6pjqTyFcFsdUyonkz1RDP20g6xigEVOSdQJQ==
X-Google-Smtp-Source: APXvYqwEzCwIrRjE59rfKIbX5unImEXqInpU7egqI3leYK2BXnc2J7PTQq9FXUBiEv6Uf3x9yvCNNc7wrzJ3FCaAgld2Ug==
X-Received: by 2002:a63:5152:: with SMTP id r18mr15484090pgl.324.1561080032751;
 Thu, 20 Jun 2019 18:20:32 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:29 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 18/30] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/pcmcia/cistpl.c      | 4 ++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..fb54e262578c 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1578,6 +1579,9 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (security_is_locked_down(LOCKDOWN_PCMCIA_CIS))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index 88d0f5d0cd87..87c433f1e7db 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -90,6 +90,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index bfc0e088aa85..ced4ddbb36b4 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

