Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34BA7D095
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 00:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGaWQu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Jul 2019 18:16:50 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:35229 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbfGaWQu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Jul 2019 18:16:50 -0400
Received: by mail-vs1-f73.google.com with SMTP id 66so12932431vsp.2
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gySahCCzgGb/Q58L8c20Lrjjix8qIZkrCOd+PLUQfB8=;
        b=cmIx1daqZEKRBkMW2JYQfOqzUiRs2oBlgGsfJ136BcTbgFMR1CJl2NqSDVgDe896Bx
         mpbcsPT67i243WQ4vLJxFNcPA4oGZ3Cz6MDwB0lBJSVHyXdZ+LTkkVhocNH63pmKpNYi
         jzKaCCH1ri5of7nbJCrFDV2szkQzQ4/IyfgIxl0y5Pz8cdpCVYSWtX3QdnT/0R1pxHJ8
         86aVpuAguhOmGJFr5DCnDbgOLeH53KoQruXbdg8fiqbjwqEj4qIljZP/1qVz6Wc3j62q
         w8/FDQdrnu0IDQzCJ94OCBvj1zAWNGFs45jfQtd1ADYZiLLYm6kZQGlGm22DObG2SgD+
         u1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gySahCCzgGb/Q58L8c20Lrjjix8qIZkrCOd+PLUQfB8=;
        b=NeQ0JMMnlpjU4Y1YrxaQTs698U+XLIq/2XWvyUhnh/CGdkR7K9/IUeOukl6zmD7jt3
         JV3gsj2jsqAD5VxyS9j+UAbAdZNKktIuDAUr9KkoE+1crRl/qywve4IqN3wjaoiqBufd
         9MJmtXcbO6XjCDsn9MyqUMSEaK9J8/PUILAKGf229HFpISjPBB2wnf3vRN2leCpTxJ5o
         C3b1THm+2HtjSI4XbL/EBDwf8DP63EAQBNA0nBsrK5YY/KfPx9eiWMbzvBZdtEpmjK9c
         KE6sRwVOkTOxpsk9q3VCQu2F7qIfMcvRd044O9VS3yaOOtlLd5pFLcIFKxaXO/ivSASJ
         lrmw==
X-Gm-Message-State: APjAAAXkgAtRVvLItVwi9BJZevohqIKGSSwUkBabtvxYa+AR/drnA2g6
        6MwWnOF0gZctihB/77G16Iv6TaxhFb+tjZ0v9I6U+Q==
X-Google-Smtp-Source: APXvYqwxxFBGuXs7H0AALmQP7lKFkyE/Ao0WUi2DN+KhehbfvyAwH2M8AeJB6/9kmo67vl8W4RHQYCsqQBB2qu0nAvlB4Q==
X-Received: by 2002:ab0:60b9:: with SMTP id f25mr62470698uam.111.1564611409165;
 Wed, 31 Jul 2019 15:16:49 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:15:57 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-10-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 09/29] kexec_file: Restrict at runtime if the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
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
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 875482c34154..dd06f1070d66 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -228,7 +228,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
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
2.22.0.770.g0f2c4a37fd-goog

