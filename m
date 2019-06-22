Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293B64F290
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfFVAGj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:06:39 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37495 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfFVAEZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:25 -0400
Received: by mail-pg1-f201.google.com with SMTP id e16so5003059pga.4
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o4JS6ZsbyHnt4Iukj8bZlTq9cv6XEso1+I/lLyLsbpA=;
        b=a+jT2ExBtmOGrE2RBwibGRFthL5zBOYgrJWml8uNIPt9rHxq+DfglrA0/Y5pBqU9QQ
         HpS+WH2bZYzHAFWpqgCYqmXUCwak+27QIHhABd4BbGjacaPht5GkZL4AUiYAZqiFEw4g
         OWfCM5eDm4KrIttm0QlSi2FmyQ5mMxmZMrAg0PPYAY9jtCypjRtwPzqrvztnH6gGIENN
         6gg0DvWo19xJnE3hv2pBXaws7upY4aoCIGqykeQepmFEC2MeVBjac+ouverM2jCUIr0N
         76vtr2+s7zaSAuTfMYgT3Eb5U8sq72+KctC6jCs732M5YkTFIz0QsAVT6vMlXfsS6YBn
         4DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o4JS6ZsbyHnt4Iukj8bZlTq9cv6XEso1+I/lLyLsbpA=;
        b=Q6QLsob0+gS9i5+4z4zmhmgHLKZjtFjQhrzuPPjMRGC7FeDrYjYqT5T08V7Raj+RaP
         bHX2reh4MualWnWaPX9hdIfh95lrTZItCVCWKtWu8WvjamMeE6hWatGJovZO0IEoUt9S
         Vl2i12czWtr2qIwEIDXA39LIyZXuSoreZ9yNteSs7heUlnYrb2qPCaIdjvZoVJ7DQiXv
         8N7gB7Wpx6LlGOguCglTQVfqdewXpLw+Id8I2aILxyo2BXdhuZvt+elkYzKE6ca066DI
         Y+2b6OTR9L8kNMGNA/7vu6kjCTeyFf3l883yYaNDg0OqwaKBxEH48Yf3AidGbRrz1Yt7
         yhfA==
X-Gm-Message-State: APjAAAUT6rz66eskcwzwJ+sdbLFtsVPmVtKrmO3ngBCGisH0UN5Aivzr
        lli/hs/ovmyWhwAO6bqpPZ6ocRoEao4AUw9BzlgGNw==
X-Google-Smtp-Source: APXvYqw5rFft+vShj1dHsGGITKkOPUFNJ8H0xme43V9+MAij1nj1qBbMAY4uDsOV1ThNNZ0FUlZ3kOxEzhFD4poriXVZqQ==
X-Received: by 2002:a63:8c0f:: with SMTP id m15mr1862896pgd.441.1561161864327;
 Fri, 21 Jun 2019 17:04:24 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:38 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Jiri Bohac <jbohac@suse.cz>

When KEXEC_SIG is not enabled, kernel should not load images through
kexec_file systemcall if the kernel is locked down.

[Modified by David Howells to fit with modifications to the previous patch
 and to return -EPERM if the kernel is locked down for consistency with
 other lockdowns. Modified by Matthew Garrett to remove the IMA
 integration, which will be replaced by integrating with the IMA
 architecture policy patches.]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eec7e5bb2a08..27adb4312b03 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -237,7 +237,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		ret = 0;
+		ret = security_locked_down(LOCKDOWN_KEXEC);
+		if (ret)
+			goto out;
+
 		break;
 
 		/* All other errors are fatal, including nomem, unparseable
-- 
2.22.0.410.gd8fdbe21b5-goog

