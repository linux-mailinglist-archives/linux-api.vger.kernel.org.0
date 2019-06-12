Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022A342FE8
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfFLT0q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38095 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfFLT0p (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so18129606wrs.5
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQYuVRWeyp8z2V68VQ+ceXmiIOG++TFaEr2U30kvyLQ=;
        b=egvntGNUuOx2Kv0rzH4bBjA2d/eNgZbZseUfkKLYstwMkJMliXgTidpfMT3sG3TFJY
         v4csc575IjFXzArKvq/XEJqw6uqRdD7fP0BuOll2Vkh6jVSkU5yvohJPgAmdjcVXhIym
         zHJGPac4g2DwQvDWvzHNQ4+Mvxt02WZyYASyyeDIuVazqXyKfS/NYfyLBfeiZVquIWIK
         f7Q4vfabv7DIXn/IUQzCMUurmQBgwPQrSfev1KWqUI7EYctp/0i+MwsaFTRKdPbBNcM+
         8rpXXXZv4+L24wcohKOSMjO2ASwkkuaLNXYZMz0InXRqLnaS8vtOHj2BmHAxO2dEcdhI
         51gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQYuVRWeyp8z2V68VQ+ceXmiIOG++TFaEr2U30kvyLQ=;
        b=BGcIxK6XMSm8w078vbDaem3AT+lDL3ns09M+tm2vSJ6kfLukx2gnhWQKWFXLudKIr0
         uSxBMX2Dekrp1zX4U+I/8wOrAkrj0wdMxSS4hrhJQnc3SYOCGFIVKpRm0/QwEgG7U5uL
         Lor3aHdQnyzHQP+dVu+1QmRWd+x41+MWM/j5TeH3eeC0fHaVEIQg+D74XnwdusqNFBjy
         jGyNZIb+YTHeQpatsAY6XvN+NLoZJzwOHrJKgL8PCf4gOSHiI7KNng+g+kpyNSJXUWT/
         l7oQWOGfHhYwEeOqiDzmfvA48cNKwIHTbpwqiu7aDUVeVlvxy442A2x91MDcKoeojL3y
         j8cA==
X-Gm-Message-State: APjAAAVTl+mtr4JKC0YHZMWPIIMrLyHTuL7nUBKTQKLex+bYUXP3jxNT
        d/pSo0RFWoflVFgdF+edHSw9kg==
X-Google-Smtp-Source: APXvYqwSy+SQEmaxnOW73fMqtPP/7n7YbQcuU+lb8geAage2pxdtpBkw4APU7bz5Y21TMFCW2uf69A==
X-Received: by 2002:adf:c506:: with SMTP id q6mr41597659wrf.219.1560367604455;
        Wed, 12 Jun 2019 12:26:44 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:43 -0700 (PDT)
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
Subject: [PATCHv4 10/28] x86/vdso2c: Correct err messages on file opening
Date:   Wed, 12 Jun 2019 20:26:09 +0100
Message-Id: <20190612192628.23797-11-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

err() message in main() is misleading: it should print `outfilename`,
which is argv[3], not argv[2].

Correct error messages to be more precise about what failed and for
which file.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 3a4d8d4d39f8..ce67370d14e5 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -184,7 +184,7 @@ static void map_input(const char *name, void **addr, size_t *len, int prot)
 
 	int fd = open(name, O_RDONLY);
 	if (fd == -1)
-		err(1, "%s", name);
+		err(1, "open(%s)", name);
 
 	tmp_len = lseek(fd, 0, SEEK_END);
 	if (tmp_len == (off_t)-1)
@@ -237,7 +237,7 @@ int main(int argc, char **argv)
 	outfilename = argv[3];
 	outfile = fopen(outfilename, "w");
 	if (!outfile)
-		err(1, "%s", argv[2]);
+		err(1, "fopen(%s)", outfilename);
 
 	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
 
-- 
2.22.0

