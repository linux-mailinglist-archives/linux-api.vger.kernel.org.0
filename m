Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AF5AE789
	for <lists+linux-api@lfdr.de>; Tue, 10 Sep 2019 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405550AbfIJKD3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Sep 2019 06:03:29 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33400 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405501AbfIJKD3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Sep 2019 06:03:29 -0400
Received: by mail-pg1-f202.google.com with SMTP id a21so10348053pgv.0
        for <linux-api@vger.kernel.org>; Tue, 10 Sep 2019 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bv5qoXxIm9QGTQUTxQOHCsSBy/Qj7ow+gIETe7B67Bk=;
        b=VS1WLrahvCRQTVPhrnh5NGtHefwOtMvCg1ehhBF6kQbjUks8gmIIHPTZiKlEzV5kxf
         GSILG6mOciwN7+TJw5Co4LVGFi5qK0QFAnE2m94COxwsfWZir8BcWl7qnooghwCvC2KW
         OrHCyqdAdw5Xn2p41aI6DRFF9qEKIfxrrip4grVq+YprBXZRDHq1v+BZhFfNqQZtGSU+
         MkTlOeSBfr1cmhliquwIJ1pSR72yuSao+a+Zeq7PDymvA1puCgUON+MjGbsFRIL7AKOB
         E2iQY+CsmctLt4DRgLWOU7nbzJNZo8Bprv0UoMEbGpfMu7q4jsa5cwb+eRL9UwxhaoQe
         RThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bv5qoXxIm9QGTQUTxQOHCsSBy/Qj7ow+gIETe7B67Bk=;
        b=HRvvDcCidMQwFT1uYurw6RPSv2HTxk+DNKfn3nAzC5Ds4S/GNb5Yh7cXx58KL2utWL
         40nbrGL1icHF9GZwPwQmedyylXS1Evcteo0AcK81ZgxAvtU1uA5RpSF063pAJuduzR25
         BcK1YYyMcNua/ZdiRjeakK3NZw9zltp0nj2pGhv5K6c6ZByYeDQ4dS/ZVdD8el9W0OK0
         7p+KshOnIaeN1RiYOogcptMkvPHIdcIaALzlqP9uJMo7rmR/3yuRgkSVSxHmJ3PZDW5x
         wXgJD8q+NCPqCeB7KgG8p4AfckB70crdDq4d6p20QXQImgCJLjU8rIlmOFI2kylK3lT+
         f6dw==
X-Gm-Message-State: APjAAAXL48AJhMH6fmpU0tBRGgdUlhqhkulQykTM63ARi9tkTwSRKx3L
        qJqqAeCNxAOSpX5VpzCBakRfQCwSmutkxIYlriJ1Vg==
X-Google-Smtp-Source: APXvYqx8cHOYdn1JFbj+lJuVOsHB+4rC9cO4yzh0N7mo38wEIqxIpOO3PrkduWZWmrxebAtj1X8l6jj829HaWpjFrxVRmg==
X-Received: by 2002:a63:394:: with SMTP id 142mr27066827pgd.43.1568109808362;
 Tue, 10 Sep 2019 03:03:28 -0700 (PDT)
Date:   Tue, 10 Sep 2019 03:03:18 -0700
In-Reply-To: <20190910100318.204420-1-matthewgarrett@google.com>
Message-Id: <20190910100318.204420-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190910100318.204420-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH 2/2] kexec: Fix file verification on S390
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Philipp Rudo <prudo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I accidentally typoed this #ifdef, so verification would always be
disabled.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Reported-by: Philipp Rudo <prudo@linux.ibm.com>
---
 arch/s390/kernel/kexec_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 9b4f37a4edf1..9da6fa30c447 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -130,7 +130,7 @@ static int s390_elf_probe(const char *buf, unsigned long len)
 const struct kexec_file_ops s390_kexec_elf_ops = {
 	.probe = s390_elf_probe,
 	.load = s390_elf_load,
-#ifdef CONFIG_KEXEC__SIG
+#ifdef CONFIG_KEXEC_SIG
 	.verify_sig = s390_verify_sig,
 #endif /* CONFIG_KEXEC_SIG */
 };
-- 
2.23.0.162.g0b9fbb3734-goog

