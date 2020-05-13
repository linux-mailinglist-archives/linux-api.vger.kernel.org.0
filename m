Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E861D15DB
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2020 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbgEMNjV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 May 2020 09:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbgEMNjE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 May 2020 09:39:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A0AC05BD09
        for <linux-api@vger.kernel.org>; Wed, 13 May 2020 06:39:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so28574694wma.4
        for <linux-api@vger.kernel.org>; Wed, 13 May 2020 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m42DexSkjthnmR2nv1z7z9ZHwTht4oRAMG/N2nS3T54=;
        b=kQeB/K4jcQYEjcw+9FHGg/IXlltIydy0Hgjac/SFoG0F3KfEHQIROVvwdIVkfHnms8
         tL5jiu5VaMkyBlgwk3tXtComo3k7d8qXxLXX5BMQ08QSSHZ+DuSnomSt0Ozorf3cIFzn
         eSuatGamb3DGTcLgW/WFHAz7n7PKi7DtQ9cLGRdUA3uwp3U60j4VKEyIUz0zr4tthZHU
         j1U1mb+hG5yaG1H08evvxTCUKsEnVL7n9yefpdlBWXTieOZAHK9TSJK/CFIsbYfgTzzU
         Vxu1dqeYsyAGp2R+X4tXs475YkmUz7qaZ9NrDCnEMyv9nZDkzJ/2yvBAlayqCgb99+mp
         7ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m42DexSkjthnmR2nv1z7z9ZHwTht4oRAMG/N2nS3T54=;
        b=dHGeSWnfxBWN/EYQsLLZ/P+ByTS4YOwtNqy/ittWJNYxWxh3ip5oi1ZcW3G8WNEDCk
         ZF3v9lw2RQlxuQ1jZYY/5g67OHWXbA9s7RPZbtAkxfGO7/85qvJ53pl+Jub+2JRYECOy
         pDMy93hwgZL5YaW0K26aNXG7aSlAu//itEctqZhK8dOCGb6+8iscpiEaguWOcYAM1q2X
         s5DzX+muJV2Vk6PRaJgcDPxxmhtsS3OlPYmxeml0KU3+pIfAev2W2odetEn9XWN5xjAe
         Cygqn2uNm07CHPZeip8sHsG7EeKz1imoAzaEskDIgbqkgmuX8TkEX/8l33Jv3MbnHwRF
         72Ig==
X-Gm-Message-State: AGi0Pub48ffnL7hWOIKHWuodWTY0/lbrhhtSXDZClm6859i8jjKi1zSJ
        io8ZdIq9FFtkVLE0jw1HRV6Z6Q==
X-Google-Smtp-Source: APiQypJaSku80ijd+GlLJCgxQu5fjO4XKe64vj7INT3TepylibJN/t/CMrDBhsGo1S5zX9b44LUTuw==
X-Received: by 2002:a1c:384:: with SMTP id 126mr43642294wmd.58.1589377142570;
        Wed, 13 May 2020 06:39:02 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:39:01 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH v5 11/11] loop: Add LOOP_CONFIGURE ioctl
Date:   Wed, 13 May 2020 15:38:45 +0200
Message-Id: <20200513133845.244903-12-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
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

In addition to doing what LOOP_SET_STATUS can do, LOOP_CONFIGURE can
also be used to:
- Set the correct block size immediately by setting
  loop_config.block_size (avoids LOOP_SET_BLOCK_SIZE)
- Explicitly request direct I/O mode by setting LO_FLAGS_DIRECT_IO
  in loop_config.info.lo_flags (avoids LOOP_SET_DIRECT_IO)
- Explicitly request read-only mode by setting LO_FLAGS_READ_ONLY
  in loop_config.info.lo_flags

Here's setting up ~70 regular loop devices with an offset on an x86
Android device, using LOOP_SET_FD and LOOP_SET_STATUS:

vsoc_x86:/system/apex # time for i in `seq 30 100`;
do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
    0m03.40s real     0m00.02s user     0m00.03s system

Here's configuring ~70 devices in the same way, but using a modified
losetup that uses the new LOOP_CONFIGURE ioctl:

vsoc_x86:/system/apex # time for i in `seq 30 100`;
do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
    0m01.94s real     0m00.01s user     0m00.01s system

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c      | 104 ++++++++++++++++++++++++++++----------
 include/uapi/linux/loop.h |  21 ++++++++
 2 files changed, 97 insertions(+), 28 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 13518ba191f5..a565c5aafa52 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -228,6 +228,19 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
+/**
+ * loop_validate_block_size() - validates the passed in block size
+ * @bsize: size to validate
+ */
+static int
+loop_validate_block_size(unsigned short bsize)
+{
+	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * loop_set_size() - sets device size and notifies userspace
  * @lo: struct loop_device to set the size for
@@ -1050,23 +1063,24 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static int loop_set_fd(struct loop_device *lo, fmode_t mode,
-		       struct block_device *bdev, unsigned int arg)
+static int loop_configure(struct loop_device *lo, fmode_t mode,
+			  struct block_device *bdev,
+			  const struct loop_config *config)
 {
 	struct file	*file;
 	struct inode	*inode;
 	struct address_space *mapping;
 	struct block_device *claimed_bdev = NULL;
-	int		lo_flags = 0;
 	int		error;
 	loff_t		size;
 	bool		partscan;
+	unsigned short  bsize;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
 	error = -EBADF;
-	file = fget(arg);
+	file = fget(config->fd);
 	if (!file)
 		goto out;
 
@@ -1075,7 +1089,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
+		claimed_bdev = bd_start_claiming(bdev, loop_configure);
 		if (IS_ERR(claimed_bdev)) {
 			error = PTR_ERR(claimed_bdev);
 			goto out_putf;
@@ -1097,11 +1111,26 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
+	size = get_loop_size(lo, file);
+
+	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
+		error = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (config->block_size) {
+		error = loop_validate_block_size(config->block_size);
+		if (error)
+			goto out_unlock;
+	}
+
+	error = loop_set_status_from_info(lo, &config->info);
+	if (error)
+		goto out_unlock;
+
 	if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
 	    !file->f_op->write_iter)
-		lo_flags |= LO_FLAGS_READ_ONLY;
-
-	size = get_loop_size(lo, file);
+		lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
 	error = loop_prepare_queue(lo);
 	if (error)
@@ -1109,30 +1138,28 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	error = 0;
 
-	set_device_ro(bdev, (lo_flags & LO_FLAGS_READ_ONLY) != 0);
+	set_device_ro(bdev, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
-	lo->use_dio = false;
+	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
-	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
-	lo->transfer = NULL;
-	lo->ioctl = NULL;
-	lo->lo_sizelimit = 0;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
-	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
+	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
-	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+	if (config->block_size)
+		bsize = config->block_size;
+	else if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev)
 		/* In case of direct I/O, match underlying block size */
-		unsigned short bsize = bdev_logical_block_size(
-			inode->i_sb->s_bdev);
+		bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
+	else
+		bsize = 512;
 
-		blk_queue_logical_block_size(lo->lo_queue, bsize);
-		blk_queue_physical_block_size(lo->lo_queue, bsize);
-		blk_queue_io_min(lo->lo_queue, bsize);
-	}
+	blk_queue_logical_block_size(lo->lo_queue, bsize);
+	blk_queue_physical_block_size(lo->lo_queue, bsize);
+	blk_queue_io_min(lo->lo_queue, bsize);
 
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
@@ -1155,14 +1182,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
+		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_bdev:
 	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
+		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
 out_putf:
 	fput(file);
 out:
@@ -1582,8 +1609,9 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
-	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
-		return -EINVAL;
+	err = loop_validate_block_size(arg);
+	if (err)
+		return err;
 
 	if (lo->lo_queue->limits.logical_block_size == arg)
 		return 0;
@@ -1645,8 +1673,27 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	int err;
 
 	switch (cmd) {
-	case LOOP_SET_FD:
-		return loop_set_fd(lo, mode, bdev, arg);
+	case LOOP_SET_FD: {
+		/*
+		 * Legacy case - pass in a zeroed out struct loop_config with
+		 * only the file descriptor set , which corresponds with the
+		 * default parameters we'd have used otherwise.
+		 */
+		struct loop_config config;
+
+		memset(&config, 0, sizeof(config));
+		config.fd = arg;
+
+		return loop_configure(lo, mode, bdev, &config);
+	}
+	case LOOP_CONFIGURE: {
+		struct loop_config config;
+
+		if (copy_from_user(&config, argp, sizeof(config)))
+			return -EFAULT;
+
+		return loop_configure(lo, mode, bdev, &config);
+	}
 	case LOOP_CHANGE_FD:
 		return loop_change_fd(lo, bdev, arg);
 	case LOOP_CLR_FD:
@@ -1818,6 +1865,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_CLR_FD:
 	case LOOP_GET_STATUS64:
 	case LOOP_SET_STATUS64:
+	case LOOP_CONFIGURE:
 		arg = (unsigned long) compat_ptr(arg);
 		/* fall through */
 	case LOOP_SET_FD:
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 6b32fee80ce0..24a1c45bd1ae 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -31,6 +31,10 @@ enum {
 /* LO_FLAGS that can be cleared using LOOP_SET_STATUS(64) */
 #define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR)
 
+/* LO_FLAGS that can be set using LOOP_CONFIGURE */
+#define LOOP_CONFIGURE_SETTABLE_FLAGS (LO_FLAGS_READ_ONLY | LO_FLAGS_AUTOCLEAR \
+				       | LO_FLAGS_PARTSCAN | LO_FLAGS_DIRECT_IO)
+
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
 #include <linux/types.h>	/* for __u64 */
 
@@ -66,6 +70,22 @@ struct loop_info64 {
 	__u64		   lo_init[2];
 };
 
+/**
+ * struct loop_config - Complete configuration for a loop device.
+ * @fd: fd of the file to be used as a backing file for the loop device.
+ * @block_size: block size to use; ignored if 0.
+ * @info: struct loop_info64 to configure the loop device with.
+ *
+ * This structure is used with the LOOP_CONFIGURE ioctl, and can be used to
+ * atomically setup and configure all loop device parameters at once.
+ */
+struct loop_config {
+	__u32			fd;
+	__u32                   block_size;
+	struct loop_info64	info;
+	__u64			__reserved[8];
+};
+
 /*
  * Loop filter types
  */
@@ -96,6 +116,7 @@ struct loop_info64 {
 #define LOOP_SET_CAPACITY	0x4C07
 #define LOOP_SET_DIRECT_IO	0x4C08
 #define LOOP_SET_BLOCK_SIZE	0x4C09
+#define LOOP_CONFIGURE		0x4C0A
 
 /* /dev/loop-control interface */
 #define LOOP_CTL_ADD		0x4C80
-- 
2.26.2.645.ge9eca65c58-goog

