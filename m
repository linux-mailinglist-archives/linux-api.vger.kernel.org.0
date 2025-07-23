Return-Path: <linux-api+bounces-4220-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03871B0F63A
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75A018887C1
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737622F548E;
	Wed, 23 Jul 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="fNJQNMa6"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177082F5C4E
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282073; cv=none; b=hGR2cOvlSBNzsEVyvTXzhvrlFdgYie6cbwX+FUA1DgDSSiuG6VujwV/2NvhaEp4IY3+FH+nWsxp5te89C6rtywVtxzYG5ruLvpnWodxESwccdc2OhiDWoCGRLX48e9JupC7j8xIwnwh10axGlfVSVkzA7Y1Rl10ni8SWLxc2o/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282073; c=relaxed/simple;
	bh=p6mnW8nHz5mmsnmxHLqpu00m8RR2v1Mvzx5SXmQ28YA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnvhiUHvIWnFtKbx10ScF2oLb9tj9qkP31FmIpeDMkT4TM95ZFuhyZZw17llkoMrraZSlX1WvPbLF1x736iDbwVnWrde1+TkQFkUXmu0narhgHZK/yWNdePbr5dulmNPZfDm85hKtycqEISw+f3vbmp2sLlfQMWYPFiZwtUFd/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=fNJQNMa6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e3e0415a7so267757b3.0
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282063; x=1753886863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vA7LYlc82x3WwgY57zmotOihPt8s/pKmtJ2MhRkxfkk=;
        b=fNJQNMa6f1p8o9RygaADlwqx7OSnnaJFpIl/A6sRVgQasSvGeE3vggpKgKDHD85bwv
         qeEsuTGhhJFZopgjYe4ZAXcJ8xRjNE2KyT8noqLdunAzs1gAY8jVByk/v2NPbB29WIAB
         wFvy/Ty9RWKmNNwMDyWI+ytsL0YUvnJ9h7peQU9F8WE8xD+GsmYKXNtzsSqolNlAHhoN
         cT7/yWvkxRp1wV0b5aVebw3uvBs2OxxPF2gc5yy8wXQUmoG0jdvUTeJsVyrbBXvtCH5j
         RMRYi8uCufah4jhbvTMMHME+1+VwUtfaSZx6HdznbqEaAyYHq+EMYO0RiBxdepMlZ7FY
         V74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282063; x=1753886863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA7LYlc82x3WwgY57zmotOihPt8s/pKmtJ2MhRkxfkk=;
        b=MkMG8VOKVq7geeeMeWbRzFSbgQNv+MtfRT/wMGTRvW+kUlMPlR490sTLqmvIUVat64
         6lEINJse9lm/Ea1TAqK0/Rx+9vA8VdY3BiLuXKasAKpxfch1aTJ3MUMJ6rR9q4Nn+jff
         TD+rpG2fwUafzq4YLg0CM1ZY9iCESPduq8muWCbIPK5x+y/Mb14mpZxN2QnYgZjfMoUW
         3taSoHX+pNNbQVWKeG8y3beHvbCcZoZ0Fh7LTL/Z+H6+PxzozNJnRvBRIpbiqcO3HQQl
         /ENL1dICBJbKjY4Rvk3AIzXg8HyvKcxypxGBKJtmTckyEePB9S8CKbMu8UlpYXpOYWlc
         7AZw==
X-Forwarded-Encrypted: i=1; AJvYcCWeYHVMf394o5ETyTjyrsaUSNdwJwk7QJHYk6m+cbsfNEkYZNaQY5et39iIVJQ+oJWHksejPxFV3kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIH9YrDrrd4gQB4e3BrXjOiWgKBWHxpQ38BhcUOt8mtL9lyTD
	Sae2y0GDl8hx0xj6uZwAvKyzdLrW0CyNhBmJvHASMlYakqy6wxXtvJj/gy0Aqf/zXuE=
X-Gm-Gg: ASbGnctHHOksmuMq9d7VO/jhXZsw7qCBvJmHdpNt01V8Y2wk38JeeYpLZFQxzaD10Yu
	DFx6MkvVALHjmdFNHOWAq8GCK1p8LSCFeQXag/mOPKDnwO3r5R3nXYCqRYkEU/HM/nENnqyKjc6
	KU2ibvl4SprUBZcXtvMzc1nsO6HoldigUBPM2CuN8ZFXvowWmeo0hhw+3iURaRx+hAN4tqlHC/9
	ClJBQjAMWDFLrie+bZZSqVDGaBT+HpXQnHj0gCIzn025zOa5OsJXG6g8GuPesZRPmygEugHmYb/
	GXkXI0V3/Dse/vBUoK6Z2VbYer02jpEeFA9M4AMIpzEDPBmJrruDfdDl9bH0hlEKy6zgPc9Qz1d
	iwwbTZpCXk6pP92x8lonqFOqmfpGO0F2IkQuwnIANbl/CAt/lLb9mAa1KnMoOdVWmcnolJEWi+H
	EQV/iRDQJybotPJg==
X-Google-Smtp-Source: AGHT+IHqS70M03S5he3NvWDhoQuPFBoBKoEYJVBTcn9mZuJ/zrlY+6jXwnz4jOOosBMr5/pOQwUPow==
X-Received: by 2002:a05:690c:480b:b0:719:4c68:a713 with SMTP id 00721157ae682-719b4b26117mr35918287b3.2.1753282063460;
        Wed, 23 Jul 2025 07:47:43 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:42 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 24/32] MAINTAINERS: add liveupdate entry
Date: Wed, 23 Jul 2025 14:46:37 +0000
Message-ID: <20250723144649.1696299-25-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS file entry for the new Live Update Orchestrator
introduced in previous patches.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b276cfeb038..711cf25d283d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14012,6 +14012,19 @@ F:	kernel/module/livepatch.c
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
 
+LIVE UPDATE
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
+F:	Documentation/admin-guide/liveupdate.rst
+F:	Documentation/core-api/liveupdate.rst
+F:	Documentation/userspace-api/liveupdate.rst
+F:	include/linux/liveupdate.h
+F:	include/uapi/linux/liveupdate.h
+F:	kernel/liveupdate/
+F:	tools/testing/selftests/liveupdate/
+
 LLC (802.2)
 L:	netdev@vger.kernel.org
 S:	Odd fixes
-- 
2.50.0.727.gbf7dc18ff4-goog


