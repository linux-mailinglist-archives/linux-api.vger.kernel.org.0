Return-Path: <linux-api+bounces-4790-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C7B55D85
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 03:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E31CC84E9
	for <lists+linux-api@lfdr.de>; Sat, 13 Sep 2025 01:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFB27470;
	Sat, 13 Sep 2025 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdasfyAT"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F119258E
	for <linux-api@vger.kernel.org>; Sat, 13 Sep 2025 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726373; cv=none; b=ToZ2196hPLlbqeloRFlRA/CnPxdvwlVQNhYE9pFSpaf5dVsOdOz0vPdbkVjoraPuCBOwEuJ7mAX5Nq96LeM3JwiRZT9ug261E0vZjixA1SlgrsDWR3aLkgI7gcMcKCSq9qm5ya4KD6YiBhnGm2n8AmXBqTUw/36u4Kkl+ElcALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726373; c=relaxed/simple;
	bh=0dZBfgRsarIoSXxUVt0yhSx8VT0ilXZcRzH3UEVxVxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOKQwkmNENCxpmVKNPZzeYD6CxIPXJX6n/AH0yJm4kSbfNW+wVn/gF1BoY5jB9ANbmll9/qTxhXHPnLjJJZs7F5p1L1KmXB8dgB8muQC+NXBGn3utUIZFopjPVdRHS+VYJ7zvvygE7moI9akrK6xWXsm39a0CVWXXCTao1/gp48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdasfyAT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07c38680b3so228178466b.1
        for <linux-api@vger.kernel.org>; Fri, 12 Sep 2025 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757726370; x=1758331170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01GQX+A5wcxVOfa45EtHUSgPI4YB4B2sFvA+zw7J76I=;
        b=JdasfyATZKgVuDGioUqz8M95vHmUjDA0X+pQzxpf/9WU/t+U6Kr5Hnn8A/pwyQbEEj
         tG9d5C4koMLr9jbbHvOg3kmOIpnqmXdSH9FzLhmDOw7FKaw9Ew5j+I2E2DqtaAF0kBLZ
         78wviOrJLl+vWbv0yCaEb7FNWVwdYcrEt3ieIj7Euu12bhdJuyE+iXc5Pb1FYjgjb8hF
         cX5p4CCG19iBqFwJotgYe++od9U/7qY0/+Gz7PK70bhGuzPjXacGCU6LuDPtHZleKndu
         uaVp9WGOG3lboi/Y241AWiDrohHR47mki0UFwavjwS1g6Qe4yDpW5hurcQZvXGxBtRDc
         ssdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757726370; x=1758331170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01GQX+A5wcxVOfa45EtHUSgPI4YB4B2sFvA+zw7J76I=;
        b=ED3oyEFi/Vh9G/1c3OEo7nUx2lgxionolwAyQHhT54X4sFqFJaemCwSg8U6EXYA+2i
         UhkzowsQD6TOJXPiupU+lVyncwv93A24PRJhocW2B+l1NxOug0XEeVKwEMtIJoZt7zY4
         OIkJgh187xTyI88KSv+UQjocALa/8Q7BXOTGuIY+wq6LmU9Ca5IpKFishfE4XBdeMFCF
         /p6XbCA4FVHHqIfcjsZ8RZnRm73yv3NZwsBibLgTba22wGQN6Ur03gJCX7Aad9oPJctq
         8SuZ3wqkG/r+11V+eEBk5f3E2cweDIkpw17sMNms67kdxhItv525gvwrGwM8WQXNWurs
         PDHg==
X-Forwarded-Encrypted: i=1; AJvYcCVPtkN2mkXpcEANLK2jzSbc3XMrApyB9r1SqMARhik3jl+TnOUapHQeAMc1nwjMblX2pqjDZYZfRX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQly8bTnXwOb+nvPLODxRsKNvUR5vBP9e4erRQaP9jQoXttx4L
	9ZrC0UoRLHZsUp2N/kvbhqYgGsvNuW5L+SyMAovVGms6LglZKqETNnb3
X-Gm-Gg: ASbGncv+NS8drNOETg7OqAzyr4gfVY6hNcd+d0UNwPsfCYhlmNmGOZXblHo8dQ3Fe/v
	aljAQSBJBC8EysW+kFAmx2eG589kia8Jv0t262eA8XsOm3FmtAYqviXq5FuTGWIrt6+pl8UC4fc
	UOt+ixedZFH1VfOZx/QvGd2JB8/mhAu2e6ptPbB1ELrcnDssuNLubnGQbYlXSYrfDz1lR5Hizmf
	sUUNUTOYcpaGc8HXcLnybV9rbVo2nWZqs0JafWmGjPdKO7IQn2aOy0vHrbY8qbs94CvwFW4sp5v
	RCANdQefz4LuocwNYjIbDyt3zLstPP4xLX0CbNd5Xnmdl4iHbWGbTjm+XRui3R/YShHRuIQNzJl
	QhdDDqSi0CkjDmJVbydPMUTGEmtLtog==
X-Google-Smtp-Source: AGHT+IEzeVwYKpSq5hVwsza+AqQmwMGGceGxnApLyMFPwDCsoulMW4PoMJQ37ACnH/5BZ1euJLookQ==
X-Received: by 2002:a17:906:2493:b0:b04:9822:1ab4 with SMTP id a640c23a62f3a-b07c35fb2e4mr458597866b.27.1757726369974;
        Fri, 12 Sep 2025 18:19:29 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5bfsm465661666b.63.2025.09.12.18.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:19:29 -0700 (PDT)
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
Subject: [PATCH RESEND 36/62] init: make mount_root static
Date: Sat, 13 Sep 2025 00:38:15 +0000
Message-ID: <20250913003842.41944-37-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts.c | 2 +-
 init/do_mounts.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index c722351c991f..7ec5ee5a5c19 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -381,7 +381,7 @@ static inline void mount_block_root(char *root_device_name)
 }
 #endif /* CONFIG_BLOCK */
 
-void __init mount_root(char *root_device_name)
+static void __init mount_root(char *root_device_name)
 {
 	switch (ROOT_DEV) {
 	case Root_NFS:
diff --git a/init/do_mounts.h b/init/do_mounts.h
index f291c30f7407..90422fb07c02 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,7 +12,6 @@
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
 /* Ensure that async file closing finished to prevent spurious errors. */
-- 
2.47.2


