Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71A93153D
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 21:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfEaTXw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 15:23:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46502 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfEaTXv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 15:23:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so6744023pfm.13
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 12:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=hoDa1EoVZiT7Wkw8tpQ8ZdnhUm/f8Zh3zGc2U04HgkQ=;
        b=WiIUz10jmRbp0pIdfwTDrWrNg9pSpMMbr+ZvHgHQpD2I5ojOlc5tR72RlrEAsn4wyu
         05K9TZbIwMG5eZqqgalnhdmIbj8+QYTfTYZuVB2MrRO7EagiXd2fsZDyKXSeMachEhLI
         IAta7yEXgG1higsz4HoVAz7ytHBIHZIDXA4wr54vnemjNELaCu3La3X8imNGWmbH7Wam
         4jlqIpa2Cv2hszneBOWbrItWgGYTMV1L0AoVPIWZ9DD2/Kn2u3zpDvrihpl1yvv2T631
         rNd+1sRXcq73s0A8P5tpYUFGJt7ALaiUBhPB+I8QoXJte/1RrX35IR/O75e3Fr7YJKB+
         HQcg==
X-Gm-Message-State: APjAAAXp5sW4pddpSTlj43CjUfGqPr0AMH2YO4dgJZlRggKOwXqoKVBL
        P+X9veRGZ+sRUEe68JJ1m3ewvg==
X-Google-Smtp-Source: APXvYqwDdSFL7PzpLwvQOw94atoCEpoQ4xG/ZVsYwEVets4vEXAhhAUnBPue1jzZcGz3S4VsZQtyqQ==
X-Received: by 2002:a63:31d8:: with SMTP id x207mr10539257pgx.403.1559330630266;
        Fri, 31 May 2019 12:23:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o2sm5753489pgm.51.2019.05.31.12.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:49 -0700 (PDT)
Subject: [PATCH 1/5] Non-functional cleanup of a "__user * filename"
Date:   Fri, 31 May 2019 12:12:00 -0700
Message-Id: <20190531191204.4044-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531191204.4044-1-palmer@sifive.com>
References: <20190531191204.4044-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The next patch defines a very similar interface, which I copied from
this definition.  Since I'm touching it anyway I don't see any reason
not to just go fix this one up.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e446806a561f..396871b218f4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -433,7 +433,7 @@ asmlinkage long sys_chdir(const char __user *filename);
 asmlinkage long sys_fchdir(unsigned int fd);
 asmlinkage long sys_chroot(const char __user *filename);
 asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
-asmlinkage long sys_fchmodat(int dfd, const char __user * filename,
+asmlinkage long sys_fchmodat(int dfd, const char __user *filename,
 			     umode_t mode);
 asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
 			     gid_t group, int flag);
-- 
2.21.0

