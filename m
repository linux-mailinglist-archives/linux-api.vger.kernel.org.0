Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFC1B98D0
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD0Hmr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 03:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgD0Hmq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 03:42:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA2C061A41
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 00:42:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u16so19265384wmc.5
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2020 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5F50p+vZUxpVs6G1Sij0eAs6fVJw9OhKD5dcn7Nhqk=;
        b=GT76iOHWX38pFtAPcXhMHsG0oXaug+HDpaN2ONpegjBg+3dLkZFpxCr/kfZYDXO8VF
         GEOToh+uwVDBj22S3PsngayTgpk3D5yHevxw9m7+UqRsbGyYFjCHGTZd7oERXdLMhHwW
         yCIth/TR3VZMwAtdHoRuOvENcw5jXjN13Fq9xDHFD/HM4Gn3wdNsoNFKFOJdnOy6MTPt
         pR8pXfQsBiqshnrj1BTgXSVh9Mbd/wyJE4oE6IIs34vOGWERjRKXpEi/Q+YUzvSJpSio
         65ITJiTs/MZWd7Hx5qtzuA7iPgXhxWEHez0S4VZwsG/JcUkrIc+11UwlTSULIwKDg45W
         11qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5F50p+vZUxpVs6G1Sij0eAs6fVJw9OhKD5dcn7Nhqk=;
        b=r+4Kx0xeqXDft+BuzH7zliKL5+zuP5Y1eanYdxBS6i+2X7KujAEUXO8qi2r0bBMaYW
         wDqKW6w4MxP/JDC8ojfFbvhy0GWFN72Njp01FVZjGr8iAccYDztw8yMUdEah4KsehsWZ
         pzLC3DbiAH0lre/85YP24JMtH0dzienEiJiiHV7zUjp2N4cUCqOb2qDE+85j1z3NJ5iB
         liOZ9b5Y5AT2/pHGrrQF0qgJQFBHtyorERFtlkgljQV6lxfKYlP/Em/Gmbu8mYmgJ3X6
         2TLSFxDpRbOUO1AHGHYt/zRJVVibqAQuiSF5Hpa7RWsQkMScTpXmYZfRwl9QeFHJNoJA
         Hy5Q==
X-Gm-Message-State: AGi0PublAF81SCpTXB0BprQWPlBjA6aMKX8KsFfksnpCiyQFRwp4TStv
        cXZiSWHJoaon572GmaazQVLHHg==
X-Google-Smtp-Source: APiQypLMsONfT/ydInrYnq3ss7muzDFkNCSsJMBb0dPqQNbOekEWl0Ts3hcELQB/bsXzFc92NOIx3w==
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr23666626wmh.157.1587973364411;
        Mon, 27 Apr 2020 00:42:44 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:43 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH v3 9/9] loop: Add LOOP_SET_FD_AND_STATUS ioctl
Date:   Mon, 27 Apr 2020 09:42:22 +0200
Message-Id: <20200427074222.65369-10-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427074222.65369-1-maco@android.com>
References: <20200427074222.65369-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This allows userspace to completely setup a loop device with a single
ioctl, removing the in-between state where the device can be partially
configured - eg the loop device has a backing file associated with it,
but is reading from the wrong offset.

Besides removing the intermediate state, another big benefit of this
ioctl is that LOOP_SET_STATUS can be slow; the main reason for this
slowness is that LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to
freeze the associated queue; this requires waiting for RCU
synchronization, which I've measured can take about 15-20ms on this
device on average.

Here's setting up ~70 regular loop devices with an offset on an x86
Android device, using LOOP_SET_FD and LOOP_SET_STATUS:

vsoc_x86:/system/apex # time for i in `seq 30 100`;
do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
    0m03.40s real     0m00.02s user     0m00.03s system

Here's configuring ~70 devices in the same way, but using a modified
losetup that uses the new LOOP_SET_FD_AND_STATUS ioctl:

vsoc_x86:/system/apex # time for i in `seq 30 100`;
do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
    0m01.94s real     0m00.01s user     0m00.01s system

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c      | 45 +++++++++++++++++++++++++++++----------
 include/uapi/linux/loop.h |  7 ++++++
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 92bbe368ab62..3c9b5d469ded 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1066,8 +1066,9 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static int loop_set_fd(struct loop_device *lo, fmode_t mode,
-		       struct block_device *bdev, unsigned int arg)
+static int loop_set_fd_and_status(struct loop_device *lo, fmode_t mode,
+				  struct block_device *bdev,
+				  const struct loop_fd_and_status *fds)
 {
 	struct file	*file;
 	struct inode	*inode;
@@ -1082,7 +1083,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	__module_get(THIS_MODULE);
 
 	error = -EBADF;
-	file = fget(arg);
+	file = fget(fds->fd);
 	if (!file)
 		goto out;
 
@@ -1091,7 +1092,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
+		claimed_bdev = bd_start_claiming(bdev, loop_set_fd_and_status);
 		if (IS_ERR(claimed_bdev)) {
 			error = PTR_ERR(claimed_bdev);
 			goto out_putf;
@@ -1121,6 +1122,11 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	error = loop_validate_size(size);
 	if (error)
 		goto out_unlock;
+
+	error = loop_set_status_from_info(lo, &fds->info);
+	if (error)
+		goto out_unlock;
+
 	error = loop_prepare_queue(lo);
 	if (error)
 		goto out_unlock;
@@ -1133,9 +1139,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
-	lo->transfer = NULL;
-	lo->ioctl = NULL;
-	lo->lo_sizelimit = 0;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
@@ -1173,14 +1176,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
+		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd_and_status);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_bdev:
 	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
+		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd_and_status);
 out_putf:
 	fput(file);
 out:
@@ -1664,8 +1667,27 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	int err;
 
 	switch (cmd) {
-	case LOOP_SET_FD:
-		return loop_set_fd(lo, mode, bdev, arg);
+	case LOOP_SET_FD: {
+		/*
+		 * Legacy case - pass in a struct loop_fd_and_status with
+		 * a zeroed out loop_info64, which corresponds with the default
+		 * parameters we'd have used otherwise.
+		 */
+		struct loop_fd_and_status fds;
+
+		memset(&fds, 0, sizeof(fds));
+		fds.fd = arg;
+
+		return loop_set_fd_and_status(lo, mode, bdev, &fds);
+	}
+	case LOOP_SET_FD_AND_STATUS: {
+		struct loop_fd_and_status fds;
+
+		if (copy_from_user(&fds, argp, sizeof(fds)))
+			return -EFAULT;
+
+		return loop_set_fd_and_status(lo, mode, bdev, &fds);
+	}
 	case LOOP_CHANGE_FD:
 		return loop_change_fd(lo, bdev, arg);
 	case LOOP_CLR_FD:
@@ -1837,6 +1859,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_CLR_FD:
 	case LOOP_GET_STATUS64:
 	case LOOP_SET_STATUS64:
+	case LOOP_SET_FD_AND_STATUS:
 		arg = (unsigned long) compat_ptr(arg);
 		/* fall through */
 	case LOOP_SET_FD:
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 080a8df134ef..05ab625c40db 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -60,6 +60,12 @@ struct loop_info64 {
 	__u64		   lo_init[2];
 };
 
+struct loop_fd_and_status {
+	struct loop_info64	info;
+	__u32			fd;
+	__u32			__pad;
+};
+
 /*
  * Loop filter types
  */
@@ -90,6 +96,7 @@ struct loop_info64 {
 #define LOOP_SET_CAPACITY	0x4C07
 #define LOOP_SET_DIRECT_IO	0x4C08
 #define LOOP_SET_BLOCK_SIZE	0x4C09
+#define LOOP_SET_FD_AND_STATUS	0x4C0A
 
 /* /dev/loop-control interface */
 #define LOOP_CTL_ADD		0x4C80
-- 
2.26.2.303.gf8c07b1a785-goog

