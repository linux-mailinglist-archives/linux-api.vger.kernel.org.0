Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30477432AC0
	for <lists+linux-api@lfdr.de>; Tue, 19 Oct 2021 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhJSAES (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Oct 2021 20:04:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40796 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhJSAES (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Oct 2021 20:04:18 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6471D1F424C4;
        Tue, 19 Oct 2021 01:02:03 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v8 13/32] fanotify: Support null inode event in fanotify_dfid_inode
Date:   Mon, 18 Oct 2021 20:59:56 -0300
Message-Id: <20211019000015.1666608-14-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

FAN_FS_ERROR doesn't support DFID, but this function is still called for
every event.  The problem is that it is not capable of handling null
inodes, which now can happen in case of superblock error events.  For
this case, just returning dir will be enough.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c620b4f6fe12..397ee623ff1e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -452,7 +452,7 @@ static struct inode *fanotify_dfid_inode(u32 event_mask, const void *data,
 	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
 		return dir;
 
-	if (S_ISDIR(inode->i_mode))
+	if (inode && S_ISDIR(inode->i_mode))
 		return inode;
 
 	return dir;
-- 
2.33.0

