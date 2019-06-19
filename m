Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061694B891
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfFSMcC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:32:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38215 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731795AbfFSMac (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 08:30:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so3211977wrs.5
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vz+znNR3F5kjJHoZn9Crk81ccCGx1/tiF7Xfm+PRQVc=;
        b=UGEOATSv2mW4hXV6XIUEIo/NstQtnKUvH8YHddZaJtjJz/ESdZ6+hIBY2BsX86UB+F
         pHx3ASIJVofxgu8mJa2s/2rXqNGCEw8esGbp9vm5Hp7OxnRB4ZYMmR7jfz5RaKQDBdBS
         DYnHmgkutGVKJgTmbZX9wEYZoV18/oJSg9jPct80MuEp3oZJaKqoVmS/NFOjl+bYavNl
         ou/4Wcyy6j+7OiJ+9fl87g1aVUA0lRVvqD46b7kI4VrRJsJGnx5Y3/IC03e29+AKR7mt
         amWpAOAcZf4vLYVfIqcuNvt5OOZ4+vx1ETMm0fsgygGdPKkpUzzzSnxIcQmGEymvp0Jx
         mUng==
X-Gm-Message-State: APjAAAUa6g92d1I5JSn+2PIH31kikPkRGvFtMAsJAzCXtZUKDLtlmc9b
        wMYTUZxrnjAaIDmiIcKCorrq+Q==
X-Google-Smtp-Source: APXvYqwz5ogA7h2G+mp6k4mHrwtXmsKu8SbTaB/WQVZOvIU+slS295oTNMYD8Kyv4OO88vNv8l44ig==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr22487471wrv.63.1560947430518;
        Wed, 19 Jun 2019 05:30:30 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:29 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] vfs: don't parse "posixacl" option
Date:   Wed, 19 Jun 2019 14:30:10 +0200
Message-Id: <20190619123019.30032-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Unlike the others, this is _not_ a standard option accepted by mount(8).

In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
mount(2) interface is possibly a bug.

The only filesystem that apparently wants to handle the "posixacl" option
is 9p, but it has special handling of that option besides setting
SB_POSIXACL.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index cbf89117a507..49636e541293 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -42,7 +42,6 @@ static const struct constant_table common_set_sb_flag[] = {
 	{ "dirsync",	SB_DIRSYNC },
 	{ "lazytime",	SB_LAZYTIME },
 	{ "mand",	SB_MANDLOCK },
-	{ "posixacl",	SB_POSIXACL },
 	{ "ro",		SB_RDONLY },
 	{ "sync",	SB_SYNCHRONOUS },
 };
-- 
2.21.0

