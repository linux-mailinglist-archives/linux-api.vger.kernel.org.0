Return-Path: <linux-api+bounces-1072-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9972867B2E
	for <lists+linux-api@lfdr.de>; Mon, 26 Feb 2024 17:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40ACBB39123
	for <lists+linux-api@lfdr.de>; Mon, 26 Feb 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04A412BEBD;
	Mon, 26 Feb 2024 15:21:36 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922012BEA1
	for <linux-api@vger.kernel.org>; Mon, 26 Feb 2024 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960896; cv=none; b=hHEDeAC6GpZF+89FFolZDorjtw9NaaDQ8AYP9Krf4vzpXHs+Om0dm7siB0GsP5DwHWrN1lQZeetm8i8EqvBEltgm0B6SdbI1tImpH1Ajgqz7HPlQfGOvvkMd5+AviTEPOOglYJ0jSPtDnKbMXeSUMe3ZYeW80a/pRU3Zwcdvo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960896; c=relaxed/simple;
	bh=y3ktYAlWGlGh0UnsX6kzOaJ18fiNnqB5N6XWTMa6ZYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf5aJiWXD0gTIdlvSbkXJuj7/hk55YNKx0yTQ7Lk4/ptXdfUdjYpuR2GcGfkJonSbHTJm165WrctG1EgXMQniz1U2YlBg2rSdceu1y10BjrXLLRqshxZJiiYQwyeRELkzPnQuN3sdxlucNaDEWWVwD34wI2qp4wWWshZ47gAM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-hUFdyclRNYa7u9Dzspq9HQ-1; Mon, 26 Feb 2024 10:21:27 -0500
X-MC-Unique: hUFdyclRNYa7u9Dzspq9HQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC846185A781;
	Mon, 26 Feb 2024 15:21:26 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED5D3492BE2;
	Mon, 26 Feb 2024 15:21:25 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-api@vger.kernel.org
Subject: [RFC PATCH v2 5/5] fbcon: Allow to get max font width and height
Date: Mon, 26 Feb 2024 16:21:14 +0100
Message-ID: <ab4ce129aef39b81cd27f10d49142a1c64f87a37.1708960303.git.legion@kernel.org>
In-Reply-To: <cover.1708960303.git.legion@kernel.org>
References: <cover.1708011391.git.legion@kernel.org> <cover.1708960303.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1183e7a871f8..055d0d01243c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -101,6 +101,9 @@ enum {
 	FBCON_LOGO_DONTSHOW	= -3	/* do not show the logo */
 };
 
+#define FBCON_MAX_FONT_WIDTH 32
+#define FBCON_MAX_FONT_HEIGHT 32
+
 static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
 static struct fb_info *fbcon_registered_fb[FB_MAX];
@@ -2458,6 +2461,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	return ret;
 }
 
+
+static int fbcon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = 0;
+	info->min_height = 0;
+
+	info->max_width = FBCON_MAX_FONT_WIDTH;
+	info->max_height = FBCON_MAX_FONT_HEIGHT;
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
@@ -2485,7 +2503,8 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	    h > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))
 		return -EINVAL;
 
-	if (font->width > 32 || font->height > 32)
+	if (font->width > FBCON_MAX_FONT_WIDTH ||
+	    font->height > FBCON_MAX_FONT_HEIGHT)
 		return -EINVAL;
 
 	/* Make sure drawing engine can handle the font */
@@ -3160,6 +3179,7 @@ static const struct consw fb_con = {
 	.con_scroll 		= fbcon_scroll,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
+	.con_font_info 		= fbcon_font_info,
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-- 
2.44.0


