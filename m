Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4664B858
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfFSMas (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:30:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56176 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbfFSMar (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 08:30:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so1577962wmj.5
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 05:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNbb6ySXfk0LsxFqiydMR/t6l2T9CSD+Rib4fd27MSM=;
        b=XhRjNh1liQRmWVu5Zy+Ex4lMxQxw8c5H4vXupqd9YB+xxiodtIpoQZc8grO8YIBp1K
         bVXqpiJ1SUm6kWu6bKxxxsYg0gNF13aMbgTDjJc8oOvhpOAwKtGp23nX4JSiar0QPBTc
         d5zbpbOb/waNFpSYCb+y+2fo5oNvAIrC735qpxzjbDTbfFnB6gJQ2ny0dvB0Q9/OyZPJ
         75ToGFfTxZWQb5zOEODjWE0HKQOJJBQ2o7Ctl3n4UPKzjvIA6W69PmHLV/I+B81tdT7Q
         NfviNwZbKxefoeGBjWbpElp4vlpKBNuvv+Dxqy5kXD6ry+oIs9rvpbbrdYFwdvt9ZZyD
         jETg==
X-Gm-Message-State: APjAAAW3ugGVmV/vo/1rXMlPQLifAToKP1xdEhp4KPHMo/pMzwdq5Xbr
        8TvvHPsTaKW5/twCi/1XQwF5ug==
X-Google-Smtp-Source: APXvYqzDtNt23rFHKuVaUEO5oLhVSqmtdo5dNeWIEYEQF22eYOjWI12j/aKbz0NzzlQAmjdhiRPz6Q==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr8627226wmf.127.1560947445793;
        Wed, 19 Jun 2019 05:30:45 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:45 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] resctrl: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:19 +0200
Message-Id: <20190619123019.30032-13-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the resctrl filesystem.  If these options
are supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 83d3c358f95e..16b110d31457 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2053,7 +2053,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	int ret, opt;
 
-	ret = vfs_parse_sb_flag(fc, param);
+	ret = vfs_parse_ro_rw(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
-- 
2.21.0

