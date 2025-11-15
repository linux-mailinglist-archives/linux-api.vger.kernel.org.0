Return-Path: <linux-api+bounces-5291-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B9C60D2C
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 00:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 805AC35DA0F
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4601E285C9D;
	Sat, 15 Nov 2025 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ifdsKQen"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77887283FF9
	for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249680; cv=none; b=rcqPTCkGrdIIkkvTSIapLsDArF6gY09xW7EZu6EQvqs6pmpbK+lSp3mzZ6S+GsYJid30SmfEcWBkoCp1BQxjHJKgtFGAqEY60rsH4rq4sPM3tZRf8d74gIiH89C1NPrNzlAVv9INs3j7u+eJHUZ5TSqZcwzEtOEjChDFgVth5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249680; c=relaxed/simple;
	bh=2mrQ965aNOyL25lReCyXI/DAGszixk+DgWv0xAAZqf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQl2dob23dRbUIQF8GMN9/kSRLN69dK0jb1mnVOvzCOG/pWUUnfcfo0bA93cUHYDx0Etyv5v1q9DtMQRAbgvPTlPdFZRBbz1q0BwvC/KvyDUoIguZAVt2jKfS65IaI4jiNopLRup+75ss6pb7OReYeKk0/cC7/yczm0w7MrCTyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ifdsKQen; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78802ac2296so31689427b3.3
        for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 15:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249677; x=1763854477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXGZnSu70DIN08Y0wZgdajU/gnoj90NX2WHdQr/BE9Y=;
        b=ifdsKQenuCkFbYlErcumtEHB7MCaBK+jrTWYSop+MA1bI9SXOMY9vZuXKirW4wWNSM
         Qe7ELLdfAe9e62omxkkDndWMjc2hTk2yQ8p5UbnwTmcZ+97CLWVji40SlMxMe3Sdjn7x
         H4dXBI7ES+KA+cY1Rp0ljwSSR0hkcDu0lmPpj9/GGCrEGA62q+4vJQhFLAuCV52yUlgy
         RQFrRPgGqJ/wLXwrMcuu4yRAdIFkoV+CQN6mcFASWo9Ua6ra8c4Yl4zRFY/rj1AoRApX
         euVsoZ+2lZ6wekiH4l49wQ7bW44FvQGuuCF06Ublhl5Jg2DQVGEeW9/V92RV7eE5Zsjk
         Aanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249677; x=1763854477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tXGZnSu70DIN08Y0wZgdajU/gnoj90NX2WHdQr/BE9Y=;
        b=Q2PtWWLpFFBiKDBvoQf/15xgnraUxTP41nSJU+2dMPAWbksFlEFNGWKgepUjRdzLvt
         bodrnEyU9Cp1dFp/TFmeBI6kM53xQUiA8MsNXaoBFS6y47YxyRyuRGutE2U+lmdOWP7R
         jwvm+F/sjMGDbTQNlIUBGKQKx+IkxeQJDhGm3j/0+CZy4pLSiaWK+7d38kElxfb49bLO
         lYMKGyIsj4i+8zq+dx52wcKE1fxp97tn/7LmOy45vmK9yXwS36STEUVj7d9jKlxYk3Rm
         V7o/VlhXN9SW8Ca9hSo6v+XXtIyuRSpPhuUsGBZq9rfmHw0Amc2Gdn0MOiaGkrWJxeBx
         3Ayg==
X-Forwarded-Encrypted: i=1; AJvYcCXvZOV0wik+PaQG+5K2i9hMCwmhYcmQz+pmcTdnZEssp/9mniHc/KVtKIqj2y0g9tvzIt8TPuDLC5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrD7PxDMAbL9R6h8sxzu8JwvjHG5Fl+JOSDXJby0mGae1Jzfu
	JNS+nzFSDnGTY1WnO3iG+NtZhnUFSWkENJfT4Xciu0Z9dmy1QjIwww8ZpaqdFCxGFm0=
X-Gm-Gg: ASbGncsbpbnVnMswavTIU9HN7hbnz73JPYM9sGCVkf6Mu4qfw3Ogn94JD8B86/xlBNS
	rpKeuHhKqNWTX6z7eeyqyHgAxuFYJiXy5zqnYN1EHeZwTlc5ImSwAfPpIVK4nm4HuUypyE4hZhE
	J9ZbjtM+61rRR01zIGE+ktI+Lsgbshs/pmgbdOx6BacjFxnu2la9lzms6NoyZoJxV8KuBuqMgbm
	rJ5uNu68fWxD4UvS+q7P2MuDA/d0O9ESSrK8uo6ho/YbTnfBBvqwkrhojk2supvvORGwIcpkaut
	I41mmluD6y2pvmrH3MQRUAJZYcphnu2apwgefJRbgKsCAeMh4WHBXZ2TNuem7qKebYItckrs5Ll
	uzWDzt2kWMpvb+8enjw2Kz0Au+yPA4PXcD0oA5iWxHmRtG1qU2YFP6tsOuYyNE4IehJ3JJDyzbn
	uV0ynQP0xVOKzVpYImqi0s524q1+xV7OOMu3X2mNJSIhvkiIurp4x4jNhbFVY6l2/uXSel
X-Google-Smtp-Source: AGHT+IEr4ZSX5F0ShTJnhoCAiRSreIR9tV+TAE+bMcxkAeUYbXHH2oKIfnq7gg9dS89JT0P8DLy0LQ==
X-Received: by 2002:a05:690c:9304:b0:784:8286:fde3 with SMTP id 00721157ae682-78929ee3a37mr62160337b3.42.1763249677538;
        Sat, 15 Nov 2025 15:34:37 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:37 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v6 09/20] docs: add luo documentation
Date: Sat, 15 Nov 2025 18:33:55 -0500
Message-ID: <20251115233409.768044-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation files for the Live Update Orchestrator

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/index.rst           |  1 +
 Documentation/core-api/liveupdate.rst      | 64 ++++++++++++++++++++++
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/liveupdate.rst | 20 +++++++
 4 files changed, 86 insertions(+)
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 6cbdcbfa79c3..5eb0fbbbc323 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -138,6 +138,7 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
+   liveupdate
    netlink
 
 .. only:: subproject and html
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
new file mode 100644
index 000000000000..deacc098d024
--- /dev/null
+++ b/Documentation/core-api/liveupdate.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Live Update Orchestrator
+========================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :doc: Live Update Orchestrator (LUO)
+
+LUO Sessions
+============
+.. kernel-doc:: kernel/liveupdate/luo_session.c
+   :doc: LUO Sessions
+
+LUO Preserving File Descriptors
+===============================
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :doc: LUO File Descriptors
+
+LUO File Lifecycle Bound Global Data
+====================================
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :doc: LUO File Lifecycle Bound Global Data
+
+Live Update Orchestrator ABI
+============================
+.. kernel-doc:: include/linux/liveupdate/abi/luo.h
+   :doc: Live Update Orchestrator ABI
+
+Public API
+==========
+.. kernel-doc:: include/linux/liveupdate.h
+
+.. kernel-doc:: include/linux/liveupdate/abi/luo.h
+
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :export:
+
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :export:
+
+Internal API
+============
+.. kernel-doc:: kernel/liveupdate/luo_core.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_flb.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_session.c
+   :internal:
+
+.. kernel-doc:: kernel/liveupdate/luo_file.c
+   :internal:
+
+See Also
+========
+
+- :doc:`Live Update uAPI </userspace-api/liveupdate>`
+- :doc:`/core-api/kho/concepts`
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb11..8a61ac4c1bf1 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -61,6 +61,7 @@ Everything else
    :maxdepth: 1
 
    ELF
+   liveupdate
    netlink/index
    sysfs-platform_profile
    vduse
diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
new file mode 100644
index 000000000000..04210a6cf6d6
--- /dev/null
+++ b/Documentation/userspace-api/liveupdate.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Live Update uAPI
+================
+:Author: Pasha Tatashin <pasha.tatashin@soleen.com>
+
+ioctl interface
+===============
+.. kernel-doc:: kernel/liveupdate/luo_ioctl.c
+   :doc: LUO ioctl Interface
+
+ioctl uAPI
+===========
+.. kernel-doc:: include/uapi/linux/liveupdate.h
+
+See Also
+========
+
+- :doc:`Live Update Orchestrator </core-api/liveupdate>`
-- 
2.52.0.rc1.455.g30608eb744-goog


