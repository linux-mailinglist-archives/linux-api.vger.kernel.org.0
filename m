Return-Path: <linux-api+bounces-4805-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DC5B5656F
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 05:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896FC200CA3
	for <lists+linux-api@lfdr.de>; Sun, 14 Sep 2025 03:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A443271A9D;
	Sun, 14 Sep 2025 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/aQn20j"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945326C383
	for <linux-api@vger.kernel.org>; Sun, 14 Sep 2025 03:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822197; cv=none; b=tvQ8+jmtF8J1P7frrgteL3lCAGgVuOQEX0BjgAd0fhXyRJPOqpUzX9sQfHQ8sGbGygby9op856rALDIK/QeJAVBFgRu5n/6Qg/r+Ex9VuoVaZFZ0LNolftIBPNi4F9K0mZB5uKN+wNJiNhgdduZU5Qyz/jKZaSboHsT7/59YLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822197; c=relaxed/simple;
	bh=Z/NLntZrolo0ykWAS3sXBn6sCvdr4Jv7RqhYT4lljv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvFDCsAZjxl9DahkO0mWeiFCRUJiyHXdBaclnFcH7sB5qtNu92VAIscSi6Ch8ueOH1YiPS/frGGV+rphNFLukQIicdlXZIFgYSxu44UBuulBrX2M/ibn7yo3rEaCMHC6xqrJ+33n7FwQD4RCktcO7aTj5DtQ7pwXs7F11Zfs7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/aQn20j; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so6096927a12.2
        for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822193; x=1758426993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukssGXUYVXOD0e/noqLCBxDtEOgQieVYL/7Zl394zX0=;
        b=B/aQn20j3rCcnelgL9u2/4O+eOA6v5R53N6bq1hQiG+7SX2YgByw2FYlpCjzRXxtnW
         pIRzVvX8n7M9DI69LAZpmiB7CJAX56lYS5GAnWBineIBTco+JP4EqzYq7o7yG55oCDe8
         35HZsaymtSR/LtZsodlZSGJdg2xL+mKPxTXC3x3PIWWX0RdnCd9MANmz+0g6uFYOpX2d
         3rA9ueyvK+Pevogq90X4nOo9tL9Xw/m1bpvd7pha0F23PnyPM528fcRKFwxjBXoLaW99
         q2nlq3MbEhp8qgVNZ+Ko7S3az0mFadW15Y88ekI0f4VwlPH9nMBsPF265pr4XPbH7gel
         ptoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822193; x=1758426993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukssGXUYVXOD0e/noqLCBxDtEOgQieVYL/7Zl394zX0=;
        b=Y8VOmUoNOBYat0Zku51iyx0g/6HWvnnGztxD5ajQAeC9wn3EZDag8XJwRNChIkq4y+
         WKnT8XcsWujk2PAuMtUl7kAIAFqSQ8BxCaSdulLcRZrDV4xRitt0YMSPmG+VfZxNkeya
         HF2X9ROz8B8hhR8L4E1vj9dmYL4QovoX+KgCS2te6/4CD0RpBkuoZ0pFzJSWMubMpNME
         LaqaMzrESWX2KzcOB25OenNh1gdX+q3v3oiDLOaESBvHZaZOXzOXWdpNaD+OmnW4+U7G
         ZuMwYvEFUPn7eEID9idgdBRGT7lF3D5038JUOTdylS/1p/cJdrT5NewyRbhVJvxrjLAf
         B2eA==
X-Forwarded-Encrypted: i=1; AJvYcCX6hZxHZpPhlnUzOYrbAEgNbD27qhj0xBJuDXCfuPX+XJ4hQgOcNPOBg24g8ioIodJg0vuV2sDR/m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkE4d91ThFrx3V4g4KCxJ2KIC9qngjMmM3zvHy6OF6a/aHWx/
	AZEvtm9tQY49HyzzDPa3P5bwUs8LCKMnvg9W64zdMOfBsYuCtuB5/kpC
X-Gm-Gg: ASbGncvjknsixoesflCKSMDvzhx8jEVnyzqBPJ2VHd1evw+Sgl4CKcdOi0GNifAf4a4
	F4/0qbeWAK9TpVeygw1mcUiWZJDmdEOwMSAnlqudCPdnaOd++Uirqw4t/WFrhaN26c6WB2oGs+c
	Uhqc/G+ZwJy/5aiU5yXYYQ3eTDexQeViJ93zDxcPVtYOYLwwf8nHWkTQgQV2agw2iREHfL+bu7A
	PvBumt1WWsbWWYnKeIVb+WojG31K5tQF5caC8P8fp/1F7/YGDX1LF4IhcLpwHrtV4190CgJQmRC
	D/FABJSK9l4r1UIMHJolZdYgSTvTLpUSGJ2+8EVq7BdoAOdubox7RihA1cwUrbpXvJ01Zgpq4Ld
	CDOJGamF2IM+ClXPAFkc=
X-Google-Smtp-Source: AGHT+IEh42ac6WqH282xp0DieWYXKfg+ycti4urbWWAb1GXqLLNoKNDdAlfHKjc5T4lrTIZzL6YLwA==
X-Received: by 2002:a05:6402:2815:b0:61c:e1d6:6bf6 with SMTP id 4fb4d7f45d1cf-62ed80fd3fdmr8226990a12.7.1757822192729;
        Sat, 13 Sep 2025 20:56:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33ad2d6sm6510443a12.18.2025.09.13.20.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:56:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 48/62] init: fix comment
Date: Sun, 14 Sep 2025 06:56:26 +0300
Message-ID: <20250914035626.3718268-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make #endif match #ifdef

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index cf19b7c0c358..30e94ebf4902 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -717,7 +717,7 @@ static inline bool kexec_free_initrd(void)
 {
 	return false;
 }
-#endif /* CONFIG_KEXEC_CORE */
+#endif /* CONFIG_CRASH_RESERVE */
 
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
-- 
2.47.2


