Return-Path: <linux-api+bounces-1580-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08F98CCF1B
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 11:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14A81C224D2
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2713D521;
	Thu, 23 May 2024 09:23:21 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6D13D517;
	Thu, 23 May 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456201; cv=none; b=IeOYvQQriOnQpCcrFne6D+Yaf9WQTmFCSo6rcfQn3AVgUzFW06FFbRL5pTUIkKEUw1qUrvuox5Zmed7Bxer6y2X2dnoCboqHAxZLORLcZ2IfwgexUIVy5wm3SLTULVKPbetWunqOMHSIs+V7gHex/0bBN58PSFT6uPKzKCEbNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456201; c=relaxed/simple;
	bh=sSl4mdMNsQfCaeLKfYHltVf4jsmx6GOt1H4ZYsJwLU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mZSml2izJydfogB7yhzeoIRU2z3uiO8TrtjNJu7VGcUwFKHiNjRS0AXUc/REmf/ZuqKfUulWbpTQlRr9S9cqwrn1B7cOvfRTuQljs2oavdNULJXDhhGKlx1RMxkLYJuZrhUJMGY42OciRwLL+Uu4h1+HH5Lvgl4a5OiuZ5OdkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2029972C8F5;
	Thu, 23 May 2024 12:23:11 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 072C67CCB39; Thu, 23 May 2024 12:23:10 +0300 (IDT)
Date: Thu, 23 May 2024 12:23:10 +0300
From: "Dmitry V. Levin" <ldv@strace.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Gladkov <legion@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: linux/kd.h: include missing header
Message-ID: <20240523092310.GA31777@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Given that linux/kd.h now uses macros defined in linux/ioctl.h,
do not rely on that header being already included by linux/kd.h users
and include linux/ioctl.h explicitly.

This bug was found by strace CI.

Fixes: 8c467f330059 ("VT: Use macros to define ioctls")
Signed-off-by: Dmitry V. Levin <ldv@strace.io>
---
 include/uapi/linux/kd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 8ddb2219a84b..8fcce939ba25 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -3,6 +3,7 @@
 #define _UAPI_LINUX_KD_H
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/ioctl.h>
 
 /* 0x4B is 'K', to avoid collision with termios and vt */
 #define KD_IOCTL_BASE	'K'
-- 
ldv

