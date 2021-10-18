Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4D432AAD
	for <lists+linux-api@lfdr.de>; Tue, 19 Oct 2021 02:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhJSAD1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Oct 2021 20:03:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40690 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSAD1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Oct 2021 20:03:27 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E95701F41A9C;
        Tue, 19 Oct 2021 01:01:13 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v8 07/32] inotify: Don't force FS_IN_IGNORED
Date:   Mon, 18 Oct 2021 20:59:50 -0300
Message-Id: <20211019000015.1666608-8-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

According to Amir:

"FS_IN_IGNORED is completely internal to inotify and there is no need
to set it in i_fsnotify_mask at all, so if we remove the bit from the
output of inotify_arg_to_mask() no functionality will change and we will
be able to overload the event bit for FS_ERROR."

This is done in preparation to overload FS_ERROR with the notification
mechanism in fanotify.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/inotify/inotify_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 62051247f6d2..29fca3284bb5 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -94,10 +94,10 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
 	__u32 mask;
 
 	/*
-	 * Everything should accept their own ignored and should receive events
-	 * when the inode is unmounted.  All directories care about children.
+	 * Everything should receive events when the inode is unmounted.
+	 * All directories care about children.
 	 */
-	mask = (FS_IN_IGNORED | FS_UNMOUNT);
+	mask = (FS_UNMOUNT);
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_EVENT_ON_CHILD;
 
-- 
2.33.0

