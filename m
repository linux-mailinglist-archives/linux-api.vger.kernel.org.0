Return-Path: <linux-api+bounces-1766-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866BA90FEB4
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE17B2144D
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813EB181329;
	Thu, 20 Jun 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="cMv9yLM1"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF95B05E;
	Thu, 20 Jun 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871800; cv=none; b=GVaIfJX/Lp7A1y9bG+96l6mrm2Op+uniT/2z8jqMO6hYeqffHADLX16XVe7VJ1fcQxskg36YVydITBTC6xfX7+VAzJU1r5em+0EnRF9Pb8Bupf2IvH+QdUfLN1HanDD1MRxETDFmyBT4iMkaBqZpBFH4eVp/atDPhr7uHrGU3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871800; c=relaxed/simple;
	bh=gqRCh7V0zgazq4fZJ0RImt/6DBk5XXoaUCsCtJKRyVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhyk3MnAavTVA0GYEcaVx1XR6YzZACy43Ph3h2LUOHm5r9ZgCEUKYnSiAJ2Z7lXOyhzhBTTWWPWZ43HNAdRzfjPocmmLBpblS94AhIs2EHZNWPBiZCD2rJiYRJKf0CGtXuVNG2gQvK99HTpnpKq5c89Xpn7OiKCBzis9L2duQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=cMv9yLM1; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W4YQg4VHRz9sb6;
	Thu, 20 Jun 2024 10:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1718871787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zftazIbKjTs3PvlI6d239BfHmQVryi+vLjtlNVjjeMY=;
	b=cMv9yLM1f1U73fwUYuMJhRO/d4oULd92Ued2MF/0zbxAGs7Cc6JcBkMFQYcGHSSDS3ld/y
	UCuPobmooQux5Piwzr0ESj32RNKu2zRkewMwuZRLFSrQqaXOAJBd8cx6DcGI9gMPvuuXj9
	AFmvIs9unO4rMRHpKZ6BA0TCctGaQTfqjU4EjB6Uvg+P5VvhuWfKKLdT3y9l+0WzmkWI1Y
	Nw7K6IJtcfARQ8ZdS0Wbo+E/07r45eC1r6/wgGzo/xkatpz5ZQcSRUE92A7c/jW5QJ1L8q
	ItZQTPsl21mFVzSSBb//sIEwq6EwpsWYAvxYC2ZFepDTvDtUaNp2Lnfz1GgBiQ==
From: Devin Bayer <dev@doubly.so>
To: corentin.chary@gmail.com,
	luke@ljones.dev
Cc: hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	Devin Bayer <dev@doubly.so>
Subject: [PATCH 0/2] platform/x86: asus-wmi: support a couple Zenbook 2023 features
Date: Thu, 20 Jun 2024 08:22:21 +0000
Message-ID: <20240620082223.20178-1-dev@doubly.so>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W4YQg4VHRz9sb6

This patch series adds support for a couple features on
my Zenbook UX3404VC:

1. the LED on F11 "disable camera" key
2. fan speed control

Devin Bayer (2):
  platform/x86: asus-wmi: support camera disable LED
  platform/x86: asus-wmi: support newer fan_boost_mode dev_id

 drivers/platform/x86/asus-wmi.c            | 121 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   3 +
 2 files changed, 119 insertions(+), 5 deletions(-)

-- 
2.45.2


