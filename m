Return-Path: <linux-api+bounces-6652-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jm67H6fiO2oVewgAu9opvQ
	(envelope-from <linux-api+bounces-6652-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 15:59:03 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E375A6BEE32
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 15:59:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="mV+//V+B";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6652-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6652-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6CF33023070
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6333B8D4A;
	Wed, 24 Jun 2026 13:59:01 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA103B8BBB
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 13:58:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309541; cv=none; b=CHPcttupB/ye/EONEBTdcQSE5nOL2LX/FKV+SNbfBydEctJZetQEZOpuBzA9QpvZki9NMB0uKQB4nTgvviTs4dPT55CLVJ7FnJJQv2VNTVOcutgj/0Pus8thI3VB9Yhlxid3FbIbFBY270ArvuS2KIzy47bFs8kXWJoB1lN+1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309541; c=relaxed/simple;
	bh=rZoy75d1F530K2+ThODvbmPdZCic8tHOaNMPkK37BVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntMEk7xnEqpyNey+uqA4c2/ZvMgW5IAumltaNx70WGbzpqU1g5tXv+SL3LLINobuVaLEnWS49GhO2RD1CL1iN79svwTmi1vKBNI1jI8jgxG9pYVOBs1ejfeSJrhgv8GZVlQY9Ux1ptWfN+qwUBJ5kiENaVMLPx182DebbDiiacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV+//V+B; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4924593f45dso12181755e9.1
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309538; x=1782914338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy3H6Mm52Vr1FVRw8xaYMztW/ew2mK+cmZQhwwKNUmw=;
        b=mV+//V+BxCtvsA8WDrD8kQNm0frliGCNwyyCYDV8hBontCw8/MfgOGQFuCVQ0SzZ0v
         CxwjOGpJaudlo/is3ejefrTocpsOJUeMmX2gEob60MBFOVvZrqaesYM4VQ0Qglv+caa3
         CneBhX5rJzNtT1AWlUqi5qH73vLpAhrdpSJftBpbm4fR4JZO0pFo5G1V1pSlGp7iREAr
         XYMSppk/b+f7lJ3FBPJor1mZ+3vyctxKtCOAXzvZuMN/Rp47/Orzg49uXLWOvDSoNyKe
         fjafct5mrzdJLLFk4wCzkLS591BcnRuXuxXtoNcHo7qudWkXewbkTbcRK1GfDIVFRbk0
         0hlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309538; x=1782914338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy3H6Mm52Vr1FVRw8xaYMztW/ew2mK+cmZQhwwKNUmw=;
        b=IdqdGIn0vQ9ASy4o7aKy/BSpUUGVH152RxPV1MFcJHmUQcoEzGh46zkOyUQc3MPD7L
         bG24aa0YnGlKt/A/iPqTmKZ0kv31aY18lK7OOG+LhAbMlizZx6Q9ShoWLYiDOWVnpChM
         /iGkjtVwzxf8m/M/qeh3jDUK3u0GrKa0r2XA0TgXF1EC1sCL2jVxzRFBqQbSXHgd50bb
         GA6vqDySKddWt+5q5zewW8GCt+T4+fQYdu8xdOpAsHZY2hur/x5Ycq6nELi/H5JqawzP
         lJaeDBZ2NkUYws0TekHOgQRO5nYQIP9s0p0aLR4S2XzSmjpLEYuCYMeXCBWvHllPQ3IO
         Ie3A==
X-Forwarded-Encrypted: i=1; AFNElJ+h/oIjFBEPCDAX978l5xmwahsGrmvla9N7kKh/j80xPK4B4MJS4/KvdyA2ezcFOk6rQbrbZiXsLFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbB7oMqKDnuDHWYMonHXbsJ2ohDutSJX0fwAzVRP+vjQcT7CB5
	T1+8nwOys5Q+rQpZnYBoCK++P4TBdeSsLmhB5ExE2RpPlFWBBr6qkblZ
X-Gm-Gg: AfdE7clkAB/AqoR4kyu3Icu+M8537fmjnpWPikWeAku1cuqO2PCr9M2p4sLHVDrpJAo
	4y+tBEvtj9SjUE7BnmpuJAiLGMLlkShjsesyso6uolqrpvmN0J2OUzaO5A63K0nYRWlgR8j7/Dj
	5VzZ2dIDf3uoi+HYp1xjT6wYrznsoO/f+ltq6i0HsHa9ZhilVUV8TgHm6WlyRllalui5RL2D8jK
	M5fiMCD6tHtlfXJHe3B0VhZ4ona6WnPbl++Ni8f7QaVIJYhmmHqFb8SBYVfvDNymrCixrf0Z6Mh
	G7h0f3B5kqS1LRcGcKxhnPvxFWp9LUnscoRZ5Zr4aNXTusJjegZGR7vt0v8nQ8YS4gVvyOR4u8w
	d6UY6VnbwBa7rNZlmHnOBMzmpwJpcTl7BzvKU0VaHqs6Cc6QBgkmxLs7wHZtVJKBSM9+AtZU18G
	phxvkM0/CTdLfe
X-Received: by 2002:a05:600c:3489:b0:490:b8e6:be40 with SMTP id 5b1f17b1804b1-4926086e5edmr52079765e9.21.1782309538140;
        Wed, 24 Jun 2026 06:58:58 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93eesm6734311f8f.20.2026.06.24.06.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:58:57 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: PATCH v2 0/2] Power: supply: Add PbAc, NiZn, RAM, and ZnAr support
Date: Wed, 24 Jun 2026 16:57:16 +0300
Message-ID: <20260624135718.286771-1-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6652-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sre@kernel.org,m:shuah@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-api@vger.kernel.org,m:borissh1983@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[borissh1983@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[borissh1983@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sbs-forum.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E375A6BEE32

These series adds support for PbAc, NiZn, RAM, and ZnAr chemistries as 
defined in the Smart Battery Data Specification v1.1 (Section 5.1.30 
DeviceChemistry).

Currently, the sbs-battery driver only handles LION, LiP, NiCd and NiMH.
The Smart Battery specification defines 8 possible values:
 - Lead Acid (PbAc)
 - Lithium Ion (LION)
 - Nickel Cadmium (NiCd)
 - Nickel Metal Hydride (NiMH)
 - Nickel Zinc (NiZn)
 - Rechargeable Alkaline-Manganese (RAM)
 - Zinc Air (ZnAr)
 - Lithium Polymer (LiP)

Map the missing specification values to their respective core kernel
POWER_SUPPLY_TECHNOLOGY definitions and documenation, declare these
values into selftest. 

In selftest LiMn is moved to the next line to comply with
checkpatch warning after adding said types.

It is an update for 
https://lore.kernel.org/linux-pm/ajmc_naB7zYv0SPY@venus.

Link: https://sbs-forum.org/specs/sbdat110.pdf
Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
--
Changes in V2:

1. Seperate into two patches.
2. Modify Documenation, self test and sysfs interface. self test is
updated as the documeation is now mentioning them.
--

Boris Shtrasman (2):
  power: supply: Add PbAc, NiZn, RAM, and ZnAr support
  power: supply: sbs-battery: Add PbAc, NiZn, RAM, and ZnAr support

 Documentation/ABI/testing/sysfs-class-power               | 2 +-
 drivers/power/supply/power_supply_sysfs.c                 | 4 ++++
 drivers/power/supply/sbs-battery.c                        | 8 ++++++++
 include/linux/power_supply.h                              | 4 ++++
 .../power_supply/test_power_supply_properties.sh          | 3 ++-
 5 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.47.3


