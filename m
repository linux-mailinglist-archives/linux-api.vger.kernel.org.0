Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9114D084
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgA2Sap (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 13:30:45 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53179 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgA2Sap (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 13:30:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TojljaH_1580322632;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TojljaH_1580322632)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Jan 2020 02:30:40 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mtk.manpages@gmail.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] move_pages.2: Returning positive value is a new error case
Date:   Thu, 30 Jan 2020 02:30:32 +0800
Message-Id: <1580322632-93332-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
the semantic of move_pages() has changed to return the number of
non-migrated pages if they were result of a non-fatal reasons (usually a
busy page).  This was an unintentional change that hasn't been noticed
except for LTP tests which checked for the documented behavior.

There are two ways to go around this change.  We can even get back to the
original behavior and return -EAGAIN whenever migrate_pages is not able
to migrate pages due to non-fatal reasons.  Another option would be to
simply continue with the changed semantic and extend move_pages
documentation to clarify that -errno is returned on an invalid input or
when migration simply cannot succeed (e.g. -ENOMEM, -EBUSY) or the
number of pages that couldn't have been migrated due to ephemeral
reasons (e.g. page is pinned or locked for other reasons).

We decided to keep the second option in kernel because this behavior is in
place for some time without anybody complaining and possibly new users
depending on it.  Also it allows to have a slightly easier error handling
as the caller knows that it is worth to retry when err > 0.

Update man pages to reflect the new semantic.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 man2/move_pages.2 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/man2/move_pages.2 b/man2/move_pages.2
index 1bf1053..c6cf3f8 100644
--- a/man2/move_pages.2
+++ b/man2/move_pages.2
@@ -164,9 +164,13 @@ returns zero.
 .\" do the right thing?
 On error, it returns \-1, and sets
 .I errno
-to indicate the error.
+to indicate the error. Or positive value to report the number of
+non-migrated pages.
 .SH ERRORS
 .TP
+.B Positive value
+The number of non-migrated pages if they were result of a non-fatal
+reasons since version 4.17.
 .B E2BIG
 Too many pages to move.
 Since Linux 2.6.29,
-- 
1.8.3.1

