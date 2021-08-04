Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C773E0586
	for <lists+linux-api@lfdr.de>; Wed,  4 Aug 2021 18:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhHDQM5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 12:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhHDQKz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 12:10:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD6CC0613D5;
        Wed,  4 Aug 2021 09:10:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 77E571F43697
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <repnop@google.com>
Subject: [PATCH v2] fanotify.7, fanotify_mark.2: Document FAN_FS_ERROR
Date:   Wed,  4 Aug 2021 12:10:24 -0400
Message-Id: <20210804161024.3578338-1-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The kernel patches are not merged upstream, so please refrain from merging
it at the moment.  This submission attempts to preview the interface
and gather some interface review.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Bobrowski <repnop@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
(Matthew)
  - Grammar fixes
  - Don't use the term "submitted" for events sent to the listener
  - Clarify the kind of information that is file system specific
---
 man2/fanotify_mark.2 | 16 ++++++++++
 man7/fanotify.7      | 73 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
index be3f72e040c0..2ae52f81d43b 100644
--- a/man2/fanotify_mark.2
+++ b/man2/fanotify_mark.2
@@ -214,6 +214,22 @@ Create an event when a marked file or directory itself is deleted.
 An fanotify group that identifies filesystem objects by file handles
 is required.
 .TP
+.BR FAN_FS_ERROR "(since Linux 5.15)"
+.\" commit WIP
+Create an event when a file system error is detected.
+A fanotify group that identifies filesystem objects by file handles
+is required.
+Support for this type of notification is done per-file system,
+but not every filesystem supports it.
+A user can also expect to receive additional information
+in the form of a
+.BR FAN_EVENT_INFO_TYPE_ERROR
+record
+alongside the generic metadata event.
+See
+.BR fanotify (7)
+for additional details.
+.TP
 .BR FAN_MOVED_FROM " (since Linux 5.1)"
 .\" commit 235328d1fa4251c6dcb32351219bb553a58838d2
 Create an event when a file or directory has been moved from a marked
diff --git a/man7/fanotify.7 b/man7/fanotify.7
index 6a7e70d75845..b8b7f44d4e32 100644
--- a/man7/fanotify.7
+++ b/man7/fanotify.7
@@ -188,6 +188,24 @@ struct fanotify_event_info_fid {
 .EE
 .in
 .PP
+In case of a FAN_FS_ERROR event,
+besides the file handle record,
+an additional record describing the error that occurred
+is included in the read buffer.
+The structure described below, will follow the generic
+.I fanotify_event_metadata
+structure within the read buffer:
+.PP
+.in +4n
+.EX
+struct fanotify_event_info_error {
+    struct fanotify_event_info_header hdr;
+    __s32 error;
+    __u32 error_count;
+};
+.EE
+.in
+.PP
 For performance reasons, it is recommended to use a large
 buffer size (for example, 4096 bytes),
 so that multiple events can be retrieved by a single
@@ -311,6 +329,9 @@ A child file or directory was deleted in a watched parent.
 .B FAN_DELETE_SELF
 A watched file or directory was deleted.
 .TP
+.B FAN_FS_ERROR
+A file-system error was detected.
+.TP
 .B FAN_MOVED_FROM
 A file or directory has been moved from a watched parent directory.
 .TP
@@ -510,6 +531,32 @@ and the file handle is followed by a null terminated string that identifies the
 name of a directory entry in that directory, or '.' to identify the directory
 object itself.
 .PP
+The fields of the
+.I fanotify_event_info_error
+structure are as follows:
+.TP
+.I hdr
+This is a structure of type
+.IR fanotify_event_info_header .
+and is a generic header that contains information used to
+describe an additional information record attached to the event.
+For
+.IR fanotify_event_info_error ,
+.I info_type
+will have the value
+.BR FAN_EVENT_INFO_TYPE_ERROR .
+.I len
+has the size of the additional information record including the
+.IR fanotify_event_info_header
+itself.
+.TP
+.I error
+Identifies the file system specific error that occured
+.TP
+.I error_count
+This counts the number of errors suppressed
+since the last error was read.
+.PP
 The following macros are provided to iterate over a buffer containing
 fanotify event metadata returned by a
 .BR read (2)
@@ -599,6 +646,32 @@ field.
 In that case, the audit subsystem will log information about the access
 decision to the audit logs.
 .\"
+.SS Monitoring file systems for errors
+A single FAN_FS_ERROR event is stored by the kernel at once.
+Extra error messages are suppressed and accounted for
+inside the current FAN_FS_ERROR event record,
+but details about the errors are lost.
+.PP
+Error types reported by FAN_FS_ERROR are file system specific
+and not all kinds of errors are reported by all file system.
+Refer to the file system documentation
+for additional information on the type of errors that are reported,
+and the meaning of those errors.
+.PP
+Errors not directly related to a file (i.e. super block corruption)
+are reported with an invalid
+.IR file_handle .
+For these errors, the
+.I file_handle
+will have the field
+.I handle_type
+set to
+.BR FILEID_INVALID ,
+and the
+.I f_handle
+buffer set to
+.BR 0 .
+.\"
 .SS Closing the fanotify file descriptor
 When all file descriptors referring to the fanotify notification group are
 closed, the fanotify group is released and its resources
-- 
2.32.0

