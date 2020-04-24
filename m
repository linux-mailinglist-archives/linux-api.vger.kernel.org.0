Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74EB1B7B80
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2020 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgDXQWl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Apr 2020 12:22:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58612 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgDXQWB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Apr 2020 12:22:01 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jS15R-0004dV-QH; Fri, 24 Apr 2020 16:21:57 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Saravana Kannan <saravanak@google.com>,
        Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        David Rheinsberg <david.rheinsberg@gmail.com>,
        Tom Gundersen <teg@jklm.no>,
        Christian Kellner <ckellner@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        Steve Barber <smbarber@google.com>,
        Dylan Reid <dgreid@google.com>,
        Filipe Brandenburger <filbranden@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Benjamin Elder <bentheelder@google.com>,
        Akihiro Suda <suda.kyoto@gmail.com>
Subject: [PATCH v3 3/7] loop: use ns_capable for some loop operations
Date:   Fri, 24 Apr 2020 18:20:48 +0200
Message-Id: <20200424162052.441452-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424162052.441452-1-christian.brauner@ubuntu.com>
References: <20200424162052.441452-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The following  LOOP_GET_STATUS, LOOP_SET_STATUS, and LOOP_SET_BLOCK_SIZE
operations are now allowed in non-initial namespaces. Most other
operations were already possible before.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Tom Gundersen <teg@jklm.no>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christian Kellner <ckellner@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Rheinsberg <david.rheinsberg@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Adapated loop_capable() based on changes in the loopfs
    implementation patchset. Otherwise it is functionally equivalent to
    the v1 version.

/* v3 */
unchanged
---
 drivers/block/loop.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0c99ee0b42a8..40705f5aeabd 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1352,6 +1352,16 @@ void loopfs_evict_locked(struct loop_device *lo)
 	}
 	mutex_unlock(&loop_ctl_mutex);
 }
+
+static bool loop_capable(const struct loop_device *lo, int cap)
+{
+	return ns_capable(loopfs_ns(lo), cap);
+}
+#else /* !CONFIG_BLK_DEV_LOOPFS */
+static inline bool loop_capable(const struct loop_device *lo, int cap)
+{
+	return capable(cap);
+}
 #endif /* CONFIG_BLK_DEV_LOOPFS */
 
 static int
@@ -1368,7 +1378,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		return err;
 	if (lo->lo_encrypt_key_size &&
 	    !uid_eq(lo->lo_key_owner, uid) &&
-	    !capable(CAP_SYS_ADMIN)) {
+	    !loop_capable(lo, CAP_SYS_ADMIN)) {
 		err = -EPERM;
 		goto out_unlock;
 	}
@@ -1499,7 +1509,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
 	info->lo_encrypt_type =
 		lo->lo_encryption ? lo->lo_encryption->number : 0;
-	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
+	if (lo->lo_encrypt_key_size && loop_capable(lo, CAP_SYS_ADMIN)) {
 		info->lo_encrypt_key_size = lo->lo_encrypt_key_size;
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
 		       lo->lo_encrypt_key_size);
@@ -1723,7 +1733,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		return loop_clr_fd(lo);
 	case LOOP_SET_STATUS:
 		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
+		if ((mode & FMODE_WRITE) || loop_capable(lo, CAP_SYS_ADMIN)) {
 			err = loop_set_status_old(lo,
 					(struct loop_info __user *)arg);
 		}
@@ -1732,7 +1742,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		return loop_get_status_old(lo, (struct loop_info __user *) arg);
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
-		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
+		if ((mode & FMODE_WRITE) || loop_capable(lo, CAP_SYS_ADMIN)) {
 			err = loop_set_status64(lo,
 					(struct loop_info64 __user *) arg);
 		}
@@ -1742,7 +1752,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
 	case LOOP_SET_BLOCK_SIZE:
-		if (!(mode & FMODE_WRITE) && !capable(CAP_SYS_ADMIN))
+		if (!(mode & FMODE_WRITE) && !loop_capable(lo, CAP_SYS_ADMIN))
 			return -EPERM;
 		/* Fall through */
 	default:
-- 
2.26.2

