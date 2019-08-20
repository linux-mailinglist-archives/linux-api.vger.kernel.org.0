Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D225D9525A
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfHTASf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:18:35 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43193 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfHTASf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:35 -0400
Received: by mail-vs1-f74.google.com with SMTP id p63so1388337vsd.10
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cMgjmtuBmfVa/CsXfb8uiBDSNgmdufQRbjNib4Tgcig=;
        b=tuuv3POpIuofzhNqZUKQoKR1Pan8nwWbDZbwkAoTf4UYx4zufPYGCTgfuOTsya6RGQ
         yhtHIODniLc3KhY4ZNrfLG5DMHIpncF400yxkZvzgcc3s6Rbw5nBUC+PtXubOVUvqxtW
         vOsCKrnFcVtFQv6TtLlXPOsSU/B9p5kp66ZWz/7m9TQYtAmW9PdPPao4btOAdtTn8IKG
         YrzMo2tEos2UTNJq9hQzUZhg2pZrv1T8fxHplMi75VM98FE7pqee6WC6llvC/03CIQ2D
         dRtXGSsQe7pfvMEIW5L5zL025IAA2sgUjgiBonoQXU87ScvIdQRI+pnoRzlL7QF1H4Dt
         dBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cMgjmtuBmfVa/CsXfb8uiBDSNgmdufQRbjNib4Tgcig=;
        b=fuDwueOnxcAG2vqmXRB+h43fBtOOvxOrp4qL5Gb2uR7Zu8Q85MUAtkeokmfWVUM+ML
         gmP5yrKjhGfFvqHt//DhbKiEDysv6fVfPBpmlLPgKfMuhYSd5LB75Ikcu1K/pJIxO9hS
         A85AWOycO1V9YcxLZs6WpAlXGHRm8uwdhYFPEIvm+bPenlZ8XM1Ou7e/707OcxldDzaH
         dBYlaYF/IdsYIqXDgEl78BGVuZENEBF6roH3XKU+dG8hHn0oiBehOIwXZ5iZx1zUzd7E
         FVwp/HZw27Oz17rUJQK+nZA4orwel/SbtTDixEWK2+r25SjOZcYq399d/DJte0IWjAnq
         CIbw==
X-Gm-Message-State: APjAAAXaTitck/oR4kytWpBMdvCgiqzmALH5gzHFXKnRJ/YzqJt88lN7
        Gz+wJlTfFvhHBGUBAN/Bsj81gMY94GopToBA7agz0A==
X-Google-Smtp-Source: APXvYqz2ynQdbLiUsjOrrUKHOXJ0Mc6Mp5pwCEivYXxMZqOZfnKiMw4ugozFFPwBAWnW5mdgj8UTYLY3eIdKjtzPeInLmg==
X-Received: by 2002:a67:d02:: with SMTP id 2mr3153609vsn.43.1566260313925;
 Mon, 19 Aug 2019 17:18:33 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:45 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 09/29] kexec_file: Restrict at runtime if the kernel is
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
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 972931201995..43109ef4d6bf 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -208,7 +208,7 @@ kimage_validate_signature(struct kimage *image)
 			return ret;
 		}
 
-		return 0;
+		return security_locked_down(LOCKDOWN_KEXEC);
 
 		/* All other errors are fatal, including nomem, unparseable
 		 * signatures and signature check failures - even if signatures
-- 
2.23.0.rc1.153.gdeed80330f-goog

