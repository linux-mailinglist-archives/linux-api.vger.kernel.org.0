Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36923473DE
	for <lists+linux-api@lfdr.de>; Sun, 16 Jun 2019 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfFPI67 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Jun 2019 04:58:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38457 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfFPI6n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Jun 2019 04:58:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so6689830wrs.5
        for <linux-api@vger.kernel.org>; Sun, 16 Jun 2019 01:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sgxUU390W2PtuQ88MMXWGwjdnv5ZXrQD67uDLz3qgg=;
        b=ENGNXi7IroqWSnwd/8hrqwJsAhefF6crs3ukOU6f0obWkAzJ8OIGhvG7RxSsjAt7qV
         vg8qSBsI3WgKz1IU2Fp1hgpVNeIr2eTfKTDhCEA4qVokVsaaoIQpycFjn3QnOVeY2gxi
         mr3gz0jwxbHEFFf1rKu/3voH5iNK/Tv5fSRNMOXReySqqQsjj9rgEjB6emToT7uFuFjB
         pWAzpylv1gH9SXJQYT+Ba+bPwYDOxlE/FPzlPHeIdHZKzZxYNu1XHRxTnj+F6iEnLTFG
         uhZzhaPQPW49nyZlrnBnB5sSx9Bw9H4Ov59EVZTqDQYTr1DyVELtMvfIKRU499+Mgcsu
         jdYA==
X-Gm-Message-State: APjAAAVPans5PxLryWn8rfkuGtr2Yw1msdDAKZJnUp0x88s+sX+T2d7t
        EdAOoBO+3L/XVOG0YAl9UP+We5beHaA=
X-Google-Smtp-Source: APXvYqwX2256HeSx7fk/qLqgGOiy/mrmlvd+nYfLi1zyyw8W3Dtaz40qJJqmoIRaEQdsdMHYjWP9JQ==
X-Received: by 2002:adf:f610:: with SMTP id t16mr9367740wrp.3.1560675522190;
        Sun, 16 Jun 2019 01:58:42 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h90sm18578838wrh.15.2019.06.16.01.58.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:41 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 3/5] mm: include uio.h to madvise.c
Date:   Sun, 16 Jun 2019 10:58:33 +0200
Message-Id: <20190616085835.953-4-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I couldn't compile it w/o this header.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 70aeb54f3e1c..9755340da157 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -25,6 +25,7 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
+#include <linux/uio.h>
 
 #include <asm/tlb.h>
 
-- 
2.22.0

