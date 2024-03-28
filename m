Return-Path: <linux-api+bounces-1113-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C77468795FE
	for <lists+linux-api@lfdr.de>; Tue, 12 Mar 2024 15:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0211F23026
	for <lists+linux-api@lfdr.de>; Tue, 12 Mar 2024 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E367B3D5;
	Tue, 12 Mar 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuX+KZ1g"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B797B3C7;
	Tue, 12 Mar 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253454; cv=none; b=p+utODWUZYYYhReW3mICIoc97pAQA10b0KO9I5taxCa4ao2sIoBADKqLSxtNqQq/yuaxEIh4Z1nchYfv5OreuUEtim4/GslvCQ7J48eKFO9aVEW/F2sbIFXoOEFq6RgwTI+0+S5D+C7gnbs4dMnE58MlHg1a18LbtiF1yCY9+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253454; c=relaxed/simple;
	bh=9qlk7GD9pq1DJKHl/qvH6Vvyk7ogZ7rO5bWU0G4xQ30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGx3zTtbgejqWt72k7VEat8s/f6M+JgB3lqvJo2tVSID/zPeXWjV3wIXx0k9A3wRJc/iw08235xDKWD3J+bI6nqHLYlsw0pzvzQmJP8sWvwrPfGZCt8n62pfRaNxn6+m7NWPrS6FXVAkb0NmaXie98RLS2qwZENZcdVqmCup/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuX+KZ1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DF3C43399;
	Tue, 12 Mar 2024 14:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253453;
	bh=9qlk7GD9pq1DJKHl/qvH6Vvyk7ogZ7rO5bWU0G4xQ30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuX+KZ1gFoe0h5o4Ny53zZrvAWMtdFr0qqQHm43GN9Zis1Ml7oGsZuykoiJsWKYyq
	 OW+xdKp6f63QOwCVv/3NJspSL+g24ak46iT0jId8NJW2eC0rujYYNR79qgX6jxcLM5
	 7uoBI9P6OQlM7x7Qp3QeddhLJ76YV0lEqynHLaM3GLM57RCq90KD/CD7E7lyGohZzb
	 nP6uokfCONJCFZHCXkPrhY1o1fpdVTTJniDRXwnNNW2Zo8Sn659EyWQ15+WcdtLOO2
	 YUZfpCSZQURktpMFptyluii7cHICOxWOztUaS+1j7JznPNXu66TCYACq0GazjlPBlC
	 8vTw4lM0cbX2Q==
From: legion@kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 1/2] VT: Add KDFONTINFO ioctl
Date: Tue, 12 Mar 2024 15:23:57 +0100
Message-ID: <ed056326540f04b72c97a276fbcc316e1b2f6371.1710252966.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710252966.git.legion@kernel.org>
References: <cover.1708960303.git.legion@kernel.org> <cover.1710252966.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Gladkov <legion@kernel.org>

Each driver has its own restrictions on font size. There is currently no
way to understand what the requirements are. The new ioctl allows
userspace to get the minmum and maximum font size values.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
 drivers/tty/vt/vt_ioctl.c | 13 +++++++++++++
 include/linux/console.h   |  2 ++
 include/linux/vt_kern.h   |  1 +
 include/uapi/linux/kd.h   | 13 ++++++++++++-
 5 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c80d..8c2a3d98b5ec 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4680,6 +4680,30 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
 	return -ENOSYS;
 }
 
+int con_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	int rc = -EINVAL;
+
+	info->min_height = 0;
+	info->max_height = max_font_height;
+
+	info->min_width = 0;
+	info->max_width = max_font_width;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	console_lock();
+	if (vc->vc_mode != KD_TEXT)
+		rc = -EINVAL;
+	else if (vc->vc_sw->con_font_info)
+		rc = vc->vc_sw->con_font_info(vc, info);
+	else
+		rc = -ENOSYS;
+	console_unlock();
+
+	return rc;
+}
+
 /*
  *	Interface exported to selection and vcs.
  */
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 8c685b501404..b3b4e4b69366 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -479,6 +479,19 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 		break;
 	}
 
+	case KDFONTINFO: {
+		struct console_font_info fnt_info;
+
+		if (copy_from_user(&fnt_info, up, sizeof(fnt_info)))
+			return -EFAULT;
+		ret = con_font_info(vc, &fnt_info);
+		if (ret)
+			return ret;
+		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
+			return -EFAULT;
+		break;
+	}
+
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/linux/console.h b/include/linux/console.h
index 779d388af8a0..5bea6f6c2042 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 
 struct vc_data;
+struct console_font_info;
 struct console_font_op;
 struct console_font;
 struct module;
@@ -59,6 +60,7 @@ struct consw {
 			unsigned int lines);
 	int	(*con_switch)(struct vc_data *vc);
 	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
+	int	(*con_font_info)(struct vc_data *vc, struct console_font_info *info);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
 			unsigned int vpitch, unsigned int flags);
 	int	(*con_font_get)(struct vc_data *vc, struct console_font *font,
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index c1f5aebef170..6bda4cc1fe6f 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -32,6 +32,7 @@ void do_blank_screen(int entering_gfx);
 void do_unblank_screen(int leaving_gfx);
 void poke_blanked_console(void);
 int con_font_op(struct vc_data *vc, struct console_font_op *op);
+int con_font_info(struct vc_data *vc, struct console_font_info *info);
 int con_set_cmap(unsigned char __user *cmap);
 int con_get_cmap(unsigned char __user *cmap);
 void scrollback(struct vc_data *vc);
diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 6b384065c013..781e086e55bf 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -183,8 +183,19 @@ struct console_font {
 
 #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
 
+#define KDFONTINFO	0x4B73	/* font information */
+
+#define KD_FONT_INFO_FLAG_LOW_SIZE	(1U << 0) /* 256 */
+#define KD_FONT_INFO_FLAG_HIGH_SIZE	(1U << 1) /* 512 */
+
+struct console_font_info {
+	unsigned int min_width, min_height;	/* minimal font size */
+	unsigned int max_width, max_height;	/* maximum font size */
+	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */
+};
+
 /* note: 0x4B00-0x4B4E all have had a value at some time;
    don't reuse for the time being */
-/* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */
+/* note: 0x4B60-0x4B6D, 0x4B70-0x4B73 used above */
 
 #endif /* _UAPI_LINUX_KD_H */
-- 
2.44.0


