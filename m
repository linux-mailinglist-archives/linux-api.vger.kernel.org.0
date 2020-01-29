Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3606C14D2B8
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 22:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgA2VtM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 16:49:12 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:65099 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgA2VtM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 16:49:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TokJOHV_1580334531;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TokJOHV_1580334531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Jan 2020 05:48:58 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mtk.manpages@gmail.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH] move_pages.2: Returning positive value is a new error case
Date:   Thu, 30 Jan 2020 05:48:51 +0800
Message-Id: <1580334531-80354-1-git-send-email-yang.shi@linux.alibaba.com>
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

Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: * Added notes about status array per Michal.
    * Added Michal's Acked-by.

 man2/move_pages.2 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/man2/move_pages.2 b/man2/move_pages.2
index 1bf1053..83d5c81 100644
--- a/man2/move_pages.2
+++ b/man2/move_pages.2
@@ -104,7 +104,9 @@ pages that need to be moved.
 is an array of integers that return the status of each page.
 The array contains valid values only if
 .BR move_pages ()
-did not return an error.
+did not return an error.  Pre-initialization of the array to -1 or
+similar value which cannot represent a real numa node could help to
+identify pages that have been migrated
 .PP
 .I flags
 specify what types of pages to move.
@@ -164,9 +166,13 @@ returns zero.
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

