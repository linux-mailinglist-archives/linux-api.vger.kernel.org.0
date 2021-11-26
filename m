Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB74345F65F
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 22:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbhKZVbu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 16:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbhKZV3u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 16:29:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E7C061759;
        Fri, 26 Nov 2021 13:26:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08AB462346;
        Fri, 26 Nov 2021 21:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E275C53FAD;
        Fri, 26 Nov 2021 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637961995;
        bh=HaGx4JF11p+WQ9iaeDVe72ZYLkEwsJMlPfUA5+V3JNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piMSQeAgQhVGI+MHQ9m1gKCRrg1k7EwULMhHsr+9BLKfubisegzWQA7d3jflpH2Xh
         lPR5UQNq03D7Wq1alFrdxyoEoASiRc0uUIaD8C3nmLq+c7r1ulrg7HnpqBcUNAVfpl
         MFWk3GUfG7vzn7c9LpzeJ8agKBYIYXYT8CBmYB0nQIKFBSdSnarD0VMPiGySSnGMMr
         74/0o6kPhlfsG/b4snY/q3LDk1xfQzaQFhNXxPsV0QxDav4XOTtoL87wF6VP0QmUU0
         0bcCGQZ7qNvP2uRMJisWy3ttlt4mNgCZP6vBxr4yKr3lixEMkPfkJicpU2GqIaXqig
         kIGZ7yN72te0w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 3/3] blk-crypto: show crypto capabilities in sysfs
Date:   Fri, 26 Nov 2021 13:25:14 -0800
Message-Id: <20211126212514.173334-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211126212514.173334-1-ebiggers@kernel.org>
References: <20211126212514.173334-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add sysfs files that expose the inline encryption capabilities of
request queues:

	/sys/class/block/$disk/queue/crypto/max_dun_bits
	/sys/class/block/$disk/queue/crypto/modes/$mode
	/sys/class/block/$disk/queue/crypto/num_keyslots

Userspace can use these new files to decide what encryption settings to
use, or whether to use inline encryption at all.  This also brings the
crypto capabilities in line with the other queue properties, which are
already discoverable via the queue directory in sysfs.

Design notes:

  - Place the new files in a new subdirectory "crypto" to group them
    together and to avoid complicating the main "queue" directory.  This
    also makes it possible to replace "crypto" with a symlink later if
    we ever make the blk_crypto_profiles into real kobjects (see below).

  - It was necessary to define a new kobject that corresponds to the
    crypto subdirectory.  For now, this kobject just contains a pointer
    to the blk_crypto_profile.  Note that multiple queues (and hence
    multiple such kobjects) may refer to the same blk_crypto_profile.

    An alternative design would more closely match the current kernel
    data structures: the blk_crypto_profile could be a kobject itself,
    located directly under the host controller device's kobject, while
    /sys/class/block/$disk/queue/crypto would be a symlink to it.

    I decided not to do that for now because it would require a lot more
    changes, such as no longer embedding blk_crypto_profile in other
    structures, and also because I'm not sure we can rule out moving the
    crypto capabilities into 'struct queue_limits' in the future.  (Even
    if multiple queues share the same crypto engine, maybe the supported
    data unit sizes could differ due to other queue properties.)  It
    would also still be possible to switch to that design later without
    breaking userspace, by replacing the directory with a symlink.

  - Use "max_dun_bits" instead of "max_dun_bytes".  Currently, the
    kernel internally stores this value in bytes, but that's an
    implementation detail.  It probably makes more sense to talk about
    this value in bits, and choosing bits is more future-proof.

  - "modes" is a sub-subdirectory, since there may be multiple supported
    crypto modes, and sysfs is supposed to have one value per file.

  - Each mode had to be named.  The crypto API names like "xts(aes)" are
    not appropriate because they don't specify the key size.  Therefore,
    I assigned new names.  The exact names chosen are arbitrary, but
    they happen to match the names used in log messages in fs/crypto/.

  - The "num_keyslots" file is a bit different from the others in that
    it is only useful to know for performance reasons.  However, it's
    included as it can still be useful.  For example, a user might not
    want to use inline encryption if there aren't very many keyslots.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/block/queue-sysfs.rst |  30 +++++
 block/Makefile                      |   3 +-
 block/blk-crypto-internal.h         |  12 ++
 block/blk-crypto-sysfs.c            | 177 ++++++++++++++++++++++++++++
 block/blk-crypto.c                  |   3 +
 block/blk-sysfs.c                   |   6 +
 include/linux/blkdev.h              |   1 +
 7 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 block/blk-crypto-sysfs.c

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index 3f569d5324857..252939f340459 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -24,6 +24,36 @@ or host-managed, chunk_sectors indicates the size in 512B sectors of the zones
 of the device, with the eventual exception of the last zone of the device which
 may be smaller.
 
+crypto
+------
+This subdirectory is present if the device supports inline encryption.
+(See :ref:`Documentation/block/inline-encryption.rst <inline_encryption>`.)
+This subdirectory contains the following files and subdirectories which describe
+the inline encryption capabilities of the device:
+
+max_dun_bits (RO)
+~~~~~~~~~~~~~~~~~
+The maximum length, in bits, of data unit numbers (DUNs) accepted by the device.
+
+modes
+~~~~~
+This subdirectory contains one file (RO) per crypto mode the device supports.
+Each such file contains a hexadecimal number that is a bitmask of the supported
+data unit sizes, in bytes, for the crypto mode.
+
+The crypto modes that may be supported are:
+
+* AES-256-XTS
+* AES-128-CBC-ESSIV
+* Adiantum
+
+For example, if a device supports AES-256-XTS with data unit sizes of 512 and
+4096 bytes, the file "AES-256-XTS" will be present and will contain "0x1200".
+
+num_keyslots (RO)
+~~~~~~~~~~~~~~~~~
+The number of crypto keyslots the device has.
+
 dax (RO)
 --------
 This file indicates whether the device supports Direct Access (DAX),
diff --git a/block/Makefile b/block/Makefile
index f38eaa6129296..3950ecbc5c263 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
-obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o
+obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
+					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 2fb0d65a464ca..e6818ffaddbf8 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -11,6 +11,7 @@
 
 /* Represents a crypto mode supported by blk-crypto  */
 struct blk_crypto_mode {
+	const char *name; /* name of this mode, shown in sysfs */
 	const char *cipher_str; /* crypto API name (for fallback case) */
 	unsigned int keysize; /* key size in bytes */
 	unsigned int ivsize; /* iv size in bytes */
@@ -20,6 +21,10 @@ extern const struct blk_crypto_mode blk_crypto_modes[];
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 
+int blk_crypto_sysfs_register(struct request_queue *q);
+
+void blk_crypto_sysfs_unregister(struct request_queue *q);
+
 void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 			     unsigned int inc);
 
@@ -62,6 +67,13 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
+static inline int blk_crypto_sysfs_register(struct request_queue *q)
+{
+	return 0;
+}
+
+static inline void blk_crypto_sysfs_unregister(struct request_queue *q) { }
+
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
 					       struct bio *bio)
 {
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
new file mode 100644
index 0000000000000..fcfb711c296e3
--- /dev/null
+++ b/block/blk-crypto-sysfs.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC
+ *
+ * sysfs support for blk-crypto.  This file contains the code which exports the
+ * crypto capabilities of devices via /sys/class/block/$disk/queue/crypto/.
+ */
+
+#include <linux/blk-crypto-profile.h>
+
+#include "blk-crypto-internal.h"
+
+struct blk_crypto_kobj {
+	struct kobject kobj;
+	struct blk_crypto_profile *profile;
+};
+
+struct blk_crypto_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct blk_crypto_profile *profile,
+			struct blk_crypto_attr *attr, char *page);
+};
+
+static struct blk_crypto_profile *kobj_to_crypto_profile(struct kobject *kobj)
+{
+	return container_of(kobj, struct blk_crypto_kobj, kobj)->profile;
+}
+
+static struct blk_crypto_attr *attr_to_crypto_attr(struct attribute *attr)
+{
+	return container_of(attr, struct blk_crypto_attr, attr);
+}
+
+static ssize_t blk_crypto_max_dun_bits_show(struct blk_crypto_profile *profile,
+					    struct blk_crypto_attr *attr,
+					    char *page)
+{
+	return sprintf(page, "%u\n", 8 * profile->max_dun_bytes_supported);
+}
+
+static ssize_t blk_crypto_num_keyslots_show(struct blk_crypto_profile *profile,
+					    struct blk_crypto_attr *attr,
+					    char *page)
+{
+	return sprintf(page, "%u\n", profile->num_slots);
+}
+
+#define BLK_CRYPTO_RO_ATTR(_name)			\
+static struct blk_crypto_attr blk_crypto_##_name = {	\
+	.attr	= { .name = #_name, .mode = 0444 },	\
+	.show	= blk_crypto_##_name##_show,		\
+}
+
+BLK_CRYPTO_RO_ATTR(max_dun_bits);
+BLK_CRYPTO_RO_ATTR(num_keyslots);
+
+static struct attribute *blk_crypto_attrs[] = {
+	&blk_crypto_max_dun_bits.attr,
+	&blk_crypto_num_keyslots.attr,
+	NULL,
+};
+
+static const struct attribute_group blk_crypto_attr_group = {
+	.attrs = blk_crypto_attrs,
+};
+
+/*
+ * The encryption mode attributes.  To avoid hard-coding the list of encryption
+ * modes, these are initialized at boot time by blk_crypto_sysfs_init().
+ */
+static struct blk_crypto_attr __blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX];
+static struct attribute *blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX + 1];
+
+static umode_t blk_crypto_mode_is_visible(struct kobject *kobj,
+					  struct attribute *attr, int n)
+{
+	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
+	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+	int mode_num = a - __blk_crypto_mode_attrs;
+
+	if (profile->modes_supported[mode_num])
+		return 0444;
+	return 0;
+}
+
+static ssize_t blk_crypto_mode_show(struct blk_crypto_profile *profile,
+				    struct blk_crypto_attr *attr, char *page)
+{
+	int mode_num = attr - __blk_crypto_mode_attrs;
+
+	return sprintf(page, "0x%x\n", profile->modes_supported[mode_num]);
+}
+
+static const struct attribute_group blk_crypto_modes_attr_group = {
+	.name = "modes",
+	.attrs = blk_crypto_mode_attrs,
+	.is_visible = blk_crypto_mode_is_visible,
+};
+
+static const struct attribute_group *blk_crypto_attr_groups[] = {
+	&blk_crypto_attr_group,
+	&blk_crypto_modes_attr_group,
+	NULL,
+};
+
+static ssize_t blk_crypto_attr_show(struct kobject *kobj,
+				    struct attribute *attr, char *page)
+{
+	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
+	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
+
+	return a->show(profile, a, page);
+}
+
+static const struct sysfs_ops blk_crypto_attr_ops = {
+	.show = blk_crypto_attr_show,
+};
+
+static void blk_crypto_release(struct kobject *kobj)
+{
+	kfree(container_of(kobj, struct blk_crypto_kobj, kobj));
+}
+
+static struct kobj_type blk_crypto_ktype = {
+	.default_groups = blk_crypto_attr_groups,
+	.sysfs_ops	= &blk_crypto_attr_ops,
+	.release	= blk_crypto_release,
+};
+
+/*
+ * If the request_queue has a blk_crypto_profile, create the "crypto"
+ * subdirectory in sysfs (/sys/class/block/$disk/queue/crypto/).
+ */
+int blk_crypto_sysfs_register(struct request_queue *q)
+{
+	struct blk_crypto_kobj *obj;
+	int err;
+
+	if (!q->crypto_profile)
+		return 0;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+	obj->profile = q->crypto_profile;
+
+	err = kobject_init_and_add(&obj->kobj, &blk_crypto_ktype, &q->kobj,
+				   "crypto");
+	if (err) {
+		kobject_put(&obj->kobj);
+		return err;
+	}
+	q->crypto_kobject = &obj->kobj;
+	return 0;
+}
+
+void blk_crypto_sysfs_unregister(struct request_queue *q)
+{
+	kobject_put(q->crypto_kobject);
+}
+
+static int __init blk_crypto_sysfs_init(void)
+{
+	int i;
+
+	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
+	for (i = 1; i < BLK_ENCRYPTION_MODE_MAX; i++) {
+		struct blk_crypto_attr *attr = &__blk_crypto_mode_attrs[i];
+
+		attr->attr.name = blk_crypto_modes[i].name;
+		attr->attr.mode = 0444;
+		attr->show = blk_crypto_mode_show;
+		blk_crypto_mode_attrs[i - 1] = &attr->attr;
+	}
+	return 0;
+}
+subsys_initcall(blk_crypto_sysfs_init);
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index ec9efeeeca918..f8a36c723a987 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -19,16 +19,19 @@
 
 const struct blk_crypto_mode blk_crypto_modes[] = {
 	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
+		.name = "AES-256-XTS",
 		.cipher_str = "xts(aes)",
 		.keysize = 64,
 		.ivsize = 16,
 	},
 	[BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV] = {
+		.name = "AES-128-CBC-ESSIV",
 		.cipher_str = "essiv(cbc(aes),sha256)",
 		.keysize = 16,
 		.ivsize = 16,
 	},
 	[BLK_ENCRYPTION_MODE_ADIANTUM] = {
+		.name = "Adiantum",
 		.cipher_str = "adiantum(xchacha12,aes)",
 		.keysize = 32,
 		.ivsize = 32,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 1368dfe3ee500..e551498a0a850 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -876,6 +876,10 @@ int blk_register_queue(struct gendisk *disk)
 			goto put_dev;
 	}
 
+	ret = blk_crypto_sysfs_register(q);
+	if (ret)
+		goto put_dev;
+
 	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	wbt_enable_default(q);
 	blk_throtl_register_queue(q);
@@ -907,6 +911,7 @@ int blk_register_queue(struct gendisk *disk)
 	return ret;
 
 put_dev:
+	elv_unregister_queue(q);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
@@ -951,6 +956,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	 */
 	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
+	blk_crypto_sysfs_unregister(q);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0a4416ef4fbf8..1fed574e56133 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -261,6 +261,7 @@ struct request_queue {
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
+	struct kobject *crypto_kobject;
 #endif
 
 	unsigned int		rq_timeout;
-- 
2.34.1

