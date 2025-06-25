Return-Path: <linux-api+bounces-4012-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA7CAE926C
	for <lists+linux-api@lfdr.de>; Thu, 26 Jun 2025 01:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4368A1897F79
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CEB2FCFCC;
	Wed, 25 Jun 2025 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="B1eRO5Hg"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718762D9781
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893558; cv=none; b=JOpjIBpW4xzE9OhTik+JLoffZqWJjzBr9WNTudBPYTlJp4T5d/7/p85ggFSLTj3RVnH9INKuP+0v8KVDcaeEDfLawynhCSRE65aw2ccOrProfUqvehOYJ2lqZSGEH26xZyHLfeT4JRcOz6yIkwbN2dmGIprPpM96OHMNtQuKy6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893558; c=relaxed/simple;
	bh=MeL5rpabCOQ9W64WCDzEoX0aCqKWSq3A09PvP5YRATc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABb8O+TvzVq9zjAvYok9Abygl3hdvq67GBkB6tUTh9RTuE4xAL8+75XTTJ7i0IswRIq3WptxCWGwL4Ck93QTdrbx8/6oCOogRCJ1po0OUysj+06eSvnK9Ktdrw+zBBcDZB5JRqYltmQCfzHDOjnoXggyTYiAqKkQoZIHmqXPjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=B1eRO5Hg; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e73e9e18556so556534276.0
        for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 16:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893554; x=1751498354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=B1eRO5HgatGq4rstuHwQb5lRLPCJUJPeYDwYtXoaXEQ6M2ydVeMdgP5sfHosPCqzX+
         826BuhtF/jpBSjO5u3Cd+iCrP6EZuAeF4wz4RAtfsPcJZDSHrbN0ug8kX514GEaI6IfH
         1HTxR5Xakww2tpQn/usIrCPwX1y8c0DJzwCGf5kSvD93mJ3XzDwh+LBjP0HOw48/JdUY
         xOnYtcV+oCc+PEIUc7ZjHB1O/cr6DZCTCT+v6avxVYgKQPF3P1fHAREVroltDj+JPWcR
         Rrz2ol7e7zdDcJGEEJe1LKpcg/jZUsxt8owjNaN31J2PanxwMS43usRsTmUcBQFkLv3h
         i3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893554; x=1751498354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FWnE5Bow2uoaZcwISvBgq/4l5cKqkAoia4t69mDLc0=;
        b=O7DQPrsSanp6mmprfdWFsVaxDhXEepaFouEELM+rYFmdwbnMf2zHqw7HY53T5LHlp2
         5jLGQuZAeMhMuxJrPoPrxqFKhCxy3AXCwprg+RbS+5j1FMnZs7WKocLKvHpZCUVHxDQW
         24rAJmAgKYCpgi6aHUxAAOPFuV/IPIbyrxab4HWLDugLgIfqRftd6pnKPHeA6HWJ1C/R
         Z3B3dyhtGcqOqIEqrg+GgFfUwTZf9XQISGDhM6oSC7TFv4tFKUOES91Fu8GrCOJLdmjG
         0IC5ugTFc5ul82dVzr/xGfV0XSbcHVNh3XhZomFLZKQ9eF6Znij5ChMRbIkM7BxSuQRN
         AD1g==
X-Forwarded-Encrypted: i=1; AJvYcCXOJufI47eNSlxFDINEcwilHAABut5a+ac+VN+eBeyF6a2pRNtSLST3C1KZq2ubMp+R3VMTic1XeHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygNHPjDjFsD4Uf5CR1HWRWhb8wewFncM175x3DBzlgTCHkrRoe
	KqhquINajZKshVdT+/acSLWwMo5Rit5yZSdGk5ytoWmj6cRkBX53tZ07GIhEs6AHkzE=
X-Gm-Gg: ASbGncuYL2urVV/KyQx7mRhFTV18uFNqfFdj8zY87I0LIYGbDvM4dzead4AjLG4MomB
	o7BNHIxkZvFza81ERSMsQdhoTxERfcirQlIaHCjcM49pPpE0quEnCDqWeLgY1FZcYz6oaqj9PxK
	OOV8gEhoxpwHymJB+WKjTBD87qC+ffJq8vT8tSjvf7ul8wL7IAJ5okQasiaJhEbIaXrnF31qAah
	RVELj4h0UGJ5glDAoWndKEkqeMmUe3GQXLG4llgh9iaShniQ4EtkVinsdnxCsP+cHDi/G64nd2D
	8QvfyR+46MHUVBD16+A4AUa0LUXIvdCkiJiXTGIPR4q3Knp+J1ismF34Z26RmFoSgtyYxjE3l4+
	jbGYt4nTV5xzXFjN8qZRgLkJhN5l+HmJ5eucLqPRa2Lk4jlp+Jlv0
X-Google-Smtp-Source: AGHT+IEYYs2N6RASXojR+QxIpPej80Rm+js0xnYmL5jy1Q+a192E7kIXIViEBMDkie7fGIqIBRd0Pg==
X-Received: by 2002:a05:6902:138b:b0:e81:8305:b8d9 with SMTP id 3f1490d57ef6-e879c092ef1mr2020971276.1.1750893554316;
        Wed, 25 Jun 2025 16:19:14 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:13 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 18/32] reboot: call liveupdate_reboot() before kexec
Date: Wed, 25 Jun 2025 23:18:05 +0000
Message-ID: <20250625231838.1897085-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the reboot() syscall handler in kernel/reboot.c to call
liveupdate_reboot() when processing the LINUX_REBOOT_CMD_KEXEC
command.

This ensures that the Live Update Orchestrator is notified just
before the kernel executes the kexec jump. The liveupdate_reboot()
function triggers the final LIVEUPDATE_FREEZE event, allowing
participating subsystems to perform last-minute state saving within
the blackout window, and transitions the LUO state machine to FROZEN.

The call is placed immediately before kernel_kexec() to ensure LUO
finalization happens at the latest possible moment before the kernel
transition.

If liveupdate_reboot() returns an error (indicating a failure during
LUO finalization), the kexec operation is aborted to prevent proceeding
with an inconsistent state.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/reboot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec087827c85c..bdeb04a773db 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,6 +13,7 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/liveupdate.h>
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
@@ -797,6 +798,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 
 #ifdef CONFIG_KEXEC_CORE
 	case LINUX_REBOOT_CMD_KEXEC:
+		ret = liveupdate_reboot();
+		if (ret)
+			break;
 		ret = kernel_kexec();
 		break;
 #endif
-- 
2.50.0.727.gbf7dc18ff4-goog


