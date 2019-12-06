Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEDC114A89
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 02:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfLFBfD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Dec 2019 20:35:03 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53825 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfLFBfD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Dec 2019 20:35:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Tk4jgLJ_1575596090;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tk4jgLJ_1575596090)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Dec 2019 09:34:57 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mtk.manpages@gmail.com, cl@linux.com, jhubbard@nvidia.com,
        mhocko@suse.com, cai@lca.pw, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] move_pages.2: not return ENOENT if the page are already on the target nodes
Date:   Fri,  6 Dec 2019 09:34:50 +0800
Message-Id: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Since commit e78bbfa82624 ("mm: stop returning -ENOENT
from sys_move_pages() if nothing got migrated"), move_pages doesn't
return -ENOENT anymore if the pages are already on the target nodes, but
this change is never reflected in manpage.

Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 man2/move_pages.2 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/man2/move_pages.2 b/man2/move_pages.2
index 2d96468..2a2f3cd 100644
--- a/man2/move_pages.2
+++ b/man2/move_pages.2
@@ -192,9 +192,8 @@ was specified or an attempt was made to migrate pages of a kernel thread.
 One of the target nodes is not online.
 .TP
 .B ENOENT
-No pages were found that require moving.
-All pages are either already
-on the target node, not present, had an invalid address or could not be
+No pages were found.
+All pages are either not present, had an invalid address or could not be
 moved because they were mapped by multiple processes.
 .TP
 .B EPERM
-- 
1.8.3.1

