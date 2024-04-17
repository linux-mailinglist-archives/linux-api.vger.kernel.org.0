Return-Path: <linux-api+bounces-1313-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 038EA8A8A60
	for <lists+linux-api@lfdr.de>; Wed, 17 Apr 2024 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB81281A1E
	for <lists+linux-api@lfdr.de>; Wed, 17 Apr 2024 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE26174ECA;
	Wed, 17 Apr 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av0RgA4q"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B89174EC2;
	Wed, 17 Apr 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375525; cv=none; b=LCl5N6qoi8Ga7iqnu8x/R/l3rDWTdEGd72P5BPQ0qmrAfANBGWl5Oouoa9CP4vhKl/xOBVeVJyxOeK31DRed+iIANIlYbNLUjSnTfb8+7DVau3Ir1y5Fi5l5Og3lfHDeE7HLZAuNU1QM36S6Pil4jagf/d9KGK/wHLWUm+kZWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375525; c=relaxed/simple;
	bh=CcyeG5LEOSpGWOeOm3cbVKAtUzZmD4pho93LO4Lftsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh/hFF75eeUIbL62HocW30lfLe/fnGOl/OTq2Y/xC1ZlNDtMHMstiyEXmZiyqPnKxP5on0fXAsF5yL37FvArdSdOesd42gETok4xaFQ40Y/R5mJd0Shdd/jsUHn5KqDrs0NIfpQMeUm4/fcV2MxGQ6I3xVnM/20cF7ULTOmFxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av0RgA4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698B7C2BD11;
	Wed, 17 Apr 2024 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713375525;
	bh=CcyeG5LEOSpGWOeOm3cbVKAtUzZmD4pho93LO4Lftsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Av0RgA4qaltC6R2UAP+IZbyAGnKjB4ekzdULv8j9eAPqnmFRvKNI/tSGeYj3OWUcp
	 qc6c8ihVRqy5xvc1FVVs2AxLK01Y5zF1DP+w65R/cmtzKmijs4sBJAFcGvJ+PWVSTP
	 Cs/VrPh5fAS/kkgAPnngqXBr12G9wrAq4ALJdrKkFbuR04kIY/UfY/8zewzmRyNyY4
	 FGtYvbl/zSPCI7kUk+ONgLL+oU0ba0PVJb/rKvaJnoI9fvRcg6tMMJfO6YNiEDxytp
	 PvkY+gEYNCBbvMfU4hPx2MfJOZBDAA8oqfeSJpxvsX31dlnXX2vy74MbgvamfGDaZI
	 OHANGbu9LOAzA==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v5 3/3] VT: Allow to get max font width and height
Date: Wed, 17 Apr 2024 19:37:37 +0200
Message-ID: <2b0c4ab198935cdd92a41dc718682b3658553961.1713375378.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713375378.git.legion@kernel.org>
References: <cover.1712080158.git.legion@kernel.org> <cover.1713375378.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Console drivers has more restrictive font size limits than vt_ioctl.
This leads to errors that are difficult to handle. If a font whose size
is not supported is used, an EINVAL error will be returned, which is
also returned in case of errors in the font itself. At the moment there
is no way to understand what font sizes the current console driver
supports.

To solve this problem, we need to transfer information about the
supported font to userspace from the console driver.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/video/console/newport_con.c | 21 +++++++++++++++++----
 drivers/video/console/sticon.c      | 25 +++++++++++++++++++++++--
 drivers/video/console/vgacon.c      | 21 ++++++++++++++++++++-
 drivers/video/fbdev/core/fbcon.c    | 16 ++++++++++++++++
 4 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index a51cfc1d560e..6167f45326ac 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -33,6 +33,9 @@
 
 #define NEWPORT_LEN	0x10000
 
+#define NEWPORT_MAX_FONT_WIDTH 8
+#define NEWPORT_MAX_FONT_HEIGHT 16
+
 #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
 
 static unsigned char *font_data[MAX_NR_CONSOLES];
@@ -328,8 +331,8 @@ static void newport_init(struct vc_data *vc, bool init)
 {
 	int cols, rows;
 
-	cols = newport_xsize / 8;
-	rows = newport_ysize / 16;
+	cols = newport_xsize / NEWPORT_MAX_FONT_WIDTH;
+	rows = newport_ysize / NEWPORT_MAX_FONT_HEIGHT;
 	vc->vc_can_do_color = 1;
 	if (init) {
 		vc->vc_cols = cols;
@@ -507,8 +510,8 @@ static int newport_set_font(int unit, const struct console_font *op,
 
 	/* ladis: when I grow up, there will be a day... and more sizes will
 	 * be supported ;-) */
-	if ((w != 8) || (h != 16) || (vpitch != 32)
-	    || (op->charcount != 256 && op->charcount != 512))
+	if ((w != NEWPORT_MAX_FONT_WIDTH) || (h != NEWPORT_MAX_FONT_HEIGHT) ||
+	    (vpitch != 32) || (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 
 	if (!(new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size,
@@ -570,6 +573,15 @@ static int newport_font_default(struct vc_data *vc, struct console_font *op,
 	return newport_set_def_font(vc->vc_num, op);
 }
 
+static int newport_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = info->max_width = NEWPORT_MAX_FONT_WIDTH;
+	info->min_height = info->max_height = NEWPORT_MAX_FONT_HEIGHT;
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
 static int newport_font_set(struct vc_data *vc, const struct console_font *font,
 			    unsigned int vpitch, unsigned int flags)
 {
@@ -689,6 +701,7 @@ const struct consw newport_con = {
 	.con_scroll	  = newport_scroll,
 	.con_switch	  = newport_switch,
 	.con_blank	  = newport_blank,
+	.con_font_info	  = newport_font_info,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
 	.con_save_screen  = newport_save_screen
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 4c7b4959a1aa..490e6b266a31 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -56,6 +56,11 @@
 #define BLANK 0
 static int vga_is_gfx;
 
+#define STICON_MIN_FONT_WIDTH 6
+#define STICON_MIN_FONT_HEIGHT 6
+#define STICON_MAX_FONT_WIDTH 32
+#define STICON_MAX_FONT_HEIGHT 32
+
 #define STI_DEF_FONT	sticon_sti->font
 
 /* borrowed from fbcon.c */
@@ -166,8 +171,10 @@ static int sticon_set_font(struct vc_data *vc, const struct console_font *op,
 	struct sti_cooked_font *cooked_font;
 	unsigned char *data = op->data, *p;
 
-	if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch != 32)
-	    || (op->charcount != 256 && op->charcount != 512))
+	if (!in_range(w, STICON_MIN_FONT_WIDTH, STICON_MAX_FONT_WIDTH) ||
+	    !in_range(h, STICON_MIN_FONT_HEIGHT, STICON_MAX_FONT_HEIGHT) ||
+	    (vpitch != 32) ||
+	    (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 	pitch = ALIGN(w, 8) / 8;
 	bpc = pitch * h;
@@ -260,6 +267,19 @@ static int sticon_font_set(struct vc_data *vc, const struct console_font *font,
 	return sticon_set_font(vc, font, vpitch);
 }
 
+static int sticon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = STICON_MIN_FONT_WIDTH;
+	info->min_height = STICON_MIN_FONT_HEIGHT;
+
+	info->max_width = STICON_MAX_FONT_WIDTH;
+	info->max_height = STICON_MAX_FONT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
 static void sticon_init(struct vc_data *c, bool init)
 {
     struct sti_struct *sti = sticon_sti;
@@ -356,6 +376,7 @@ static const struct consw sti_con = {
 	.con_scroll		= sticon_scroll,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
+	.con_font_info		= sticon_font_info,
 	.con_font_set		= sticon_font_set,
 	.con_font_default	= sticon_font_default,
 	.con_build_attr		= sticon_build_attr,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 7597f04b0dc7..b5465e555fdc 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -61,6 +61,10 @@ static struct vgastate vgastate;
 #define BLANK 0x0020
 
 #define VGA_FONTWIDTH       8   /* VGA does not support fontwidths != 8 */
+
+#define VGACON_MAX_FONT_WIDTH VGA_FONTWIDTH
+#define VGACON_MAX_FONT_HEIGHT 32
+
 /*
  *  Interface used by the world
  */
@@ -1039,6 +1043,19 @@ static int vgacon_adjust_height(struct vc_data *vc, unsigned fontheight)
 	return 0;
 }
 
+static int vgacon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = VGACON_MAX_FONT_WIDTH;
+	info->min_height = 0;
+
+	info->max_width = VGACON_MAX_FONT_WIDTH;
+	info->max_height = VGACON_MAX_FONT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
 static int vgacon_font_set(struct vc_data *c, const struct console_font *font,
 			   unsigned int vpitch, unsigned int flags)
 {
@@ -1048,7 +1065,8 @@ static int vgacon_font_set(struct vc_data *c, const struct console_font *font,
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	if (font->width != VGA_FONTWIDTH || font->height > 32 || vpitch != 32 ||
+	if (font->width != VGACON_MAX_FONT_WIDTH ||
+	    font->height > VGACON_MAX_FONT_HEIGHT || vpitch != 32 ||
 	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
@@ -1201,6 +1219,7 @@ const struct consw vga_con = {
 	.con_scroll = vgacon_scroll,
 	.con_switch = vgacon_switch,
 	.con_blank = vgacon_blank,
+	.con_font_info = vgacon_font_info,
 	.con_font_set = vgacon_font_set,
 	.con_font_get = vgacon_font_get,
 	.con_resize = vgacon_resize,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index fcabc668e9fb..b54031da49fd 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2452,6 +2452,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	return ret;
 }
 
+
+static int fbcon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = 0;
+	info->min_height = 0;
+
+	info->max_width = FB_MAX_BLIT_WIDTH;
+	info->max_height = FB_MAX_BLIT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
+
 /*
  *  User asked to set font; we are guaranteed that charcount does not exceed 512
  *  but lets not assume that, since charcount of 512 is small for unicode support.
@@ -3127,6 +3142,7 @@ static const struct consw fb_con = {
 	.con_scroll 		= fbcon_scroll,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
+	.con_font_info		= fbcon_font_info,
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-- 
2.44.0


