Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A343A2141
	for <lists+linux-api@lfdr.de>; Thu, 10 Jun 2021 02:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFJAXP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Jun 2021 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJAXP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Jun 2021 20:23:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04D9C061574
        for <linux-api@vger.kernel.org>; Wed,  9 Jun 2021 17:21:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e1so23343pld.13
        for <linux-api@vger.kernel.org>; Wed, 09 Jun 2021 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9XM72zD0z0Xv0rMHyaHFP495n4l5kcvzJAmEfdgpKZs=;
        b=r69a7dK48SfE/AuNUC3ncvxS/ezeS+XV31Udl98vgJM0OIxgguKnDzxmFBRGAWhVeL
         8zFPVlO+FbcN8D7+oLFKxV+kBBAw/ADFnJtlhnvvKo5F0hLSDL2uzfoF/jxe8J0OGLaj
         YEU8XovYPMmuQGOvZphjuc1k0xVo4KwabpmJluF9UhnuMh6m8X7d/iupPpZMDI/oJW3g
         L1xc/SWQxJI5EGKBm8K4EH5C87cDTj3EzEVeSN5M+MJW+jlpM1Y7gPW6arG5/0fk6YoB
         ciMXbngv4V2hHY8Emfq7pnACLsOsRDfkVyP5PUHPWhq8bazB2kRArs1YqnIEEbPnEHgF
         fCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9XM72zD0z0Xv0rMHyaHFP495n4l5kcvzJAmEfdgpKZs=;
        b=I6DBUhNkPAbn2xroooDDSVRaT74jQU/YP4Q/zv7FESUq9ld7LzQ+oP2FmRNwCKB+Nx
         ScrEB7eTUl8s3hS5N9P3fe9WCMucppWpnynolk/R5JyXxmf5pTLaTGWmaejRZacQSpsz
         Ehiw2cNUL6FfwkPDofYxWf+prv1rqJUFl91zqo4AZZa3tIkPzf95jal9mRq5fozB8OFZ
         sqAgbSlK2EFSj6YIUK0g0uroRY+A/1Gg18EySR7hRu6DSX9kCUscaBdKEL6tRp2w6mXA
         l101dsmiML+BYkzpoojMPKUEwK33mzN0lk/zsFcnUNnDPRi/WYV7DOo12GosPPwiIoUC
         wTMg==
X-Gm-Message-State: AOAM532IgH0DtGsWxncO4rr1/Px8Ert5XvElsfyDkfSC9sY5VrtO5KL9
        McFO+yNuRIOwjcIU5lcgkmxepw==
X-Google-Smtp-Source: ABdhPJxQCsARBOCqNzcDxVCfUX8XXLDM9dtBMmYlloJi8aoBFru2oT+aUDuaaJCZwG41p88BEwu+ew==
X-Received: by 2002:a17:90a:8581:: with SMTP id m1mr350223pjn.47.1623284478922;
        Wed, 09 Jun 2021 17:21:18 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id v18sm607993pff.90.2021.06.09.17.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 17:21:18 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:21:07 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 3/5] fanotify/fanotify_user.c: minor cosmetic adjustments
 to fid labels
Message-ID: <718053d928066d8932065433c6f1a7120f82f903.1623282854.git.repnop@google.com>
References: <cover.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623282854.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

With the idea to support additional info record types in the future
i.e. fanotify_event_info_pidfd, it's a good idea to rename some of the
labels assigned to some of the existing fid related functions,
parameters, etc which more accurately represent the intent behind
their usage.

For example, copy_info_to_user() was defined with a generic function
label, which arguably reads as being supportive of different info
record types, however the parameter list for this function is
explicitly tailored towards the creation and copying of the
fanotify_event_info_fid records. This same point applies to the macro
defined as FANOTIFY_INFO_HDR_LEN.

With fanotify_event_info_len(), we change the parameter label so that
the function implies that it can be extended to calculate the length
for additional info record types.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index be5b6d2c01e7..6223ffd0e4db 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -104,7 +104,7 @@ struct kmem_cache *fanotify_path_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 
 #define FANOTIFY_EVENT_ALIGN 4
-#define FANOTIFY_INFO_HDR_LEN \
+#define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
@@ -114,10 +114,11 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 	if (name_len)
 		info_len += name_len + 1;
 
-	return roundup(FANOTIFY_INFO_HDR_LEN + info_len, FANOTIFY_EVENT_ALIGN);
+	return roundup(FANOTIFY_FID_INFO_HDR_LEN + info_len,
+		       FANOTIFY_EVENT_ALIGN);
 }
 
-static int fanotify_event_info_len(unsigned int fid_mode,
+static int fanotify_event_info_len(unsigned int info_mode,
 				   struct fanotify_event *event)
 {
 	struct fanotify_info *info = fanotify_event_info(event);
@@ -128,7 +129,8 @@ static int fanotify_event_info_len(unsigned int fid_mode,
 
 	if (dir_fh_len) {
 		info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
-	} else if ((fid_mode & FAN_REPORT_NAME) && (event->mask & FAN_ONDIR)) {
+	} else if ((info_mode & FAN_REPORT_NAME) &&
+		   (event->mask & FAN_ONDIR)) {
 		/*
 		 * With group flag FAN_REPORT_NAME, if name was not recorded in
 		 * event on a directory, we will report the name ".".
@@ -303,9 +305,10 @@ static int process_access_response(struct fsnotify_group *group,
 	return -ENOENT;
 }
 
-static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
-			     int info_type, const char *name, size_t name_len,
-			     char __user *buf, size_t count)
+static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
+				 int info_type, const char *name,
+				 size_t name_len,
+				 char __user *buf, size_t count)
 {
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
@@ -466,10 +469,11 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_event_dir_fh_len(event)) {
 		info_type = info->name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
 					     FAN_EVENT_INFO_TYPE_DFID;
-		ret = copy_info_to_user(fanotify_event_fsid(event),
-					fanotify_info_dir_fh(info),
-					info_type, fanotify_info_name(info),
-					info->name_len, buf, count);
+		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
+					    fanotify_info_dir_fh(info),
+					    info_type,
+					    fanotify_info_name(info),
+					    info->name_len, buf, count);
 		if (ret < 0)
 			return ret;
 
@@ -515,9 +519,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 			info_type = FAN_EVENT_INFO_TYPE_FID;
 		}
 
-		ret = copy_info_to_user(fanotify_event_fsid(event),
-					fanotify_event_object_fh(event),
-					info_type, dot, dot_len, buf, count);
+		ret = copy_fid_info_to_user(fanotify_event_fsid(event),
+					    fanotify_event_object_fh(event),
+					    info_type, dot, dot_len,
+					    buf, count);
 		if (ret < 0)
 			return ret;
 
-- 
2.30.2

/M
