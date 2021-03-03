Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7A232C691
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355511AbhCDA3Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:29:16 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:35199 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388000AbhCCUTO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Mar 2021 15:19:14 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5A5232223A;
        Wed,  3 Mar 2021 21:18:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614802710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bH5OIkVqJBqAQ09VIrZoFL+fgJq/hfQAqXuKtC2hFko=;
        b=fzN6MJMnfbZg9AaRVlOKMsI9HmE9rktmpJz+tjAiqpFuwq9dcRJiiQIxzNaMjR6gT1Wr0B
        3Lrgl6DybeyDsYNEhQSxe1fPfzh5tbDkF8qifpMPmARkiERM9ZI8icFrSvgTZ56PO6FNkN
        FBFiw92krw7WR2QOHEMHAMdvruzWhak=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor.Ambarus@microchip.com, Michael Walle <michael@walle.cc>
Subject: [PATCH] mtd: add OTP (one-time-programmable) erase ioctl
Date:   Wed,  3 Mar 2021 21:18:19 +0100
Message-Id: <20210303201819.2752-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This may sound like a contradiction but some SPI-NOR flashes really
support erasing their OTP region until it is finally locked. Having the
possibility to erase an OTP region might come in handy during
development.

The ioctl argument follows the OTPLOCK style.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since RFC:
 - check write permissions for OTPERASE
 - use correct ioctl macro (_IOW)

 drivers/mtd/mtdchar.c      |  7 ++++++-
 drivers/mtd/mtdcore.c      | 12 ++++++++++++
 include/linux/mtd/mtd.h    |  3 +++
 include/uapi/mtd/mtd-abi.h |  2 ++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 57c4a2f0b703..b9b56eb9457e 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -666,6 +666,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	case MEMWRITEOOB:
 	case MEMWRITEOOB64:
 	case MEMWRITE:
+	case OTPERASE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EPERM;
 		break;
@@ -930,6 +931,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	}
 
 	case OTPLOCK:
+	case OTPERASE:
 	{
 		struct otp_info oinfo;
 
@@ -937,7 +939,10 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 			return -EINVAL;
 		if (copy_from_user(&oinfo, argp, sizeof(oinfo)))
 			return -EFAULT;
-		ret = mtd_lock_user_prot_reg(mtd, oinfo.start, oinfo.length);
+		if (cmd == OTPLOCK)
+			ret = mtd_lock_user_prot_reg(mtd, oinfo.start, oinfo.length);
+		else
+			ret = mtd_erase_user_prot_reg(mtd, oinfo.start, oinfo.length);
 		break;
 	}
 
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 38782ceea1f6..aea58366a94e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1919,6 +1919,18 @@ int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
 }
 EXPORT_SYMBOL_GPL(mtd_lock_user_prot_reg);
 
+int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+
+	if (!master->_erase_user_prot_reg)
+		return -EOPNOTSUPP;
+	if (!len)
+		return 0;
+	return master->_erase_user_prot_reg(master, from, len);
+}
+EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
+
 /* Chip-supported device locking */
 int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index ceabc2cae8a4..4aac200ca8b5 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -337,6 +337,8 @@ struct mtd_info {
 				     size_t len, size_t *retlen, u_char *buf);
 	int (*_lock_user_prot_reg) (struct mtd_info *mtd, loff_t from,
 				    size_t len);
+	int (*_erase_user_prot_reg) (struct mtd_info *mtd, loff_t from,
+				     size_t len);
 	int (*_writev) (struct mtd_info *mtd, const struct kvec *vecs,
 			unsigned long count, loff_t to, size_t *retlen);
 	void (*_sync) (struct mtd_info *mtd);
@@ -518,6 +520,7 @@ int mtd_read_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
 int mtd_write_user_prot_reg(struct mtd_info *mtd, loff_t to, size_t len,
 			    size_t *retlen, u_char *buf);
 int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len);
+int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len);
 
 int mtd_writev(struct mtd_info *mtd, const struct kvec *vecs,
 	       unsigned long count, loff_t to, size_t *retlen);
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index 65b9db936557..b869990c2db2 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -205,6 +205,8 @@ struct otp_info {
  * without OOB, e.g., NOR flash.
  */
 #define MEMWRITE		_IOWR('M', 24, struct mtd_write_req)
+/* Erase a given range of user data (must be in mode %MTD_FILE_MODE_OTP_USER) */
+#define OTPERASE		_IOW('M', 25, struct otp_info)
 
 /*
  * Obsolete legacy interface. Keep it in order not to break userspace
-- 
2.20.1

