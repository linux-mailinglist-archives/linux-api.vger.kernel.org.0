Return-Path: <linux-api+bounces-6653-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s4LWGLriO2obewgAu9opvQ
	(envelope-from <linux-api+bounces-6653-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 15:59:22 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E0C6BEE41
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 15:59:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="XJ+/66S2";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6653-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6653-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10ADC302BCC2
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56A3B8D4A;
	Wed, 24 Jun 2026 13:59:06 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531293B8BA1
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 13:59:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309546; cv=none; b=HF9g8kTKCj5PgeKYf+5A7uKBXUQkfLNne9hXI8bOv/GKJscGHECdAEu8NlHx2Dd0aq+kdfGTOHJdQhcsJrzDlbhVATEkDgpU7q3XVNvvS/+EfyT/XLI1Kw+3wtc8fimbe5D2MPURku7o/+imPDek6iGNEywiID5YrAGl4wrKZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309546; c=relaxed/simple;
	bh=FPKaOr0o36xivKMs1N7PLAma+N5tkY3Jb1rmAu8kDuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgR5Cue1asvMOKI4YCDwMgfPKkWv6GQRACagqXSAq2QmQE7M8aLeCLedyfn32kB3LY7jZCS95IAawAc73MZvOt9doCW4vniK7OJKqDyuZKxZ1tZyywf+qaEX3i4qV0yp9jJgATq9+nxUOaXla+XvCFRhtyRUVCGG2YOyOfwipsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ+/66S2; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso20891035e9.0
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309544; x=1782914344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RYVoqlyU8kAuuCCBlRgPYzXd5w3OqO5J7/NZsGZb6w=;
        b=XJ+/66S2OC0u6nwRk7r4+LG8k8X9p/b2J0azPhWj6tMp8WzeKjF/uUna+2XXMmZ0g6
         WLopf4oGtGSg8kU1f72PgzzcN9biMnwchfeLHUYDqxPLlRBhOrBU3Sim1upKvZhdMYnA
         T6T+uFhCiaXP6VuvWi+s5844h65GSFuE2g93M5UpHc2bCCxrS54qpliSqr3QVbiCN5YZ
         u9egpc57d3HGxV2op5/UB8KB/I9VnF0DdMy8Fuzu/+sHbNa/IZsw3y5OSw7NSyL4AJ6f
         esXWvuuy6q3AvKX2faI/YkDLxy+EXqW5EBhvBXPR6b5gDk35vnBmR7a+g3XClV2ayYeY
         Ed7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309544; x=1782914344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RYVoqlyU8kAuuCCBlRgPYzXd5w3OqO5J7/NZsGZb6w=;
        b=QuRil/DEL8AOMaTVT/3M4/Hf1aKE11OdrHIAa2hFnj/bCC5Kw8U+3ALOkrFNwORYKH
         V3LcqSjf7LjUPV7uzz1asLqbI3hs93QT/0d2/4uNIQ2ZC13ojkHHCRFEFGcdoNOapdB/
         f+ctW3GJX6TapdpgSxdeLEJVopZ/3k51x1fpm4qcTVbuaHm5+HvLV6es0COAP1i711A7
         chv7BpwA6ng/xPzFNABZ0xoQpl3cYEJVHvNKUAgGKHZRRkSn8AxCZ4cH5rTepvpqiK2G
         NYERS0XSifBmRLakfBFrS0GqZcPbc7N//YoYnyoVmiV6J+fi+yhTj/2Pn4uVVX3IAqtn
         +AAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoZxIBAikC3JdTZAamjiv9y1XYczcsYdgtW7lwPyoKR1hKCB0kN0U0rPvd8ctDlgywHoWALl++XtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ9kjPCBrNd/Z0HsgubKVHMlDUSqr+TnwM4jnoFqFf8lTKxeg1
	dZar1Xy8poqVIBFQi9x0nSJ1R8BYeMEoAAaKrm4ltFkhvT7eFnzjWDHjtN2DvXzv0VbBCr8J
X-Gm-Gg: AfdE7clCg0CBDOeDDPNRPGS1bdUwk9qaqKOBH37nJkB1fpmOxhz0o/EqTnYjbd6qm3g
	C8AD4rNE6NJrd5x0olu7QDoXtj7rfXzB6mR5KXxZl2IjRX9HkRsqk+h3B/fpDOG4avObIEL79Ad
	5p7j8IKgsuBrLh6ZJo30AMx4rY9GxC6XbI/tz6Xng9vfxjA5Gnc4wUnuMcBS7PtY6OVxysKXXEe
	ZXkpptxSG1VLJOINMvQhzMonKr04DYxMf/R/WPMbKaL+O5zrlDP5esLFXWkf3g6iSbtTLlRVUyW
	MS1jjC8vKM4SI5S613ZuXw0TBmgKQwVrQIOBRCm65aR3FOsQEgCGFSIKtoIv4GdJGmKnX9aKlvf
	mmJ1pW4bxe5mBeJMqXTnbzOGQ8vNpekPG8N2M22ouCyozo4uqGzkHoiDSKhB29SwQp9856kdXTg
	nvcFdAXGHhQMaO
X-Received: by 2002:a05:6000:1888:b0:460:21e7:330e with SMTP id ffacd0b85a97d-46a7efb72e0mr14353626f8f.10.1782309543440;
        Wed, 24 Jun 2026 06:59:03 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93eesm6734311f8f.20.2026.06.24.06.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:59:03 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH v2 1/2] power: supply: Add PbAc, NiZn, RAM, and ZnAr support
Date: Wed, 24 Jun 2026 16:57:17 +0300
Message-ID: <20260624135718.286771-2-borissh1983@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624135718.286771-1-borissh1983@gmail.com>
References: <20260624135718.286771-1-borissh1983@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6653-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sre@kernel.org,m:shuah@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-api@vger.kernel.org,m:borissh1983@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[borissh1983@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sbs-forum.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3E0C6BEE41

Add four new members to the POWER_SUPPLY_TECHNOLOGY
enum and sysfs interface to represent the Smart Battery
Data Specification v1.1 (Section 5.1.30 DeviceChemistry) battery types:

 - Lead Acid (PbAc)
 - Nickel Zinc (NiZn)
 - Rechargeable Alkaline-Manganese (RAM)
 - Zinc Air (ZnAr)

Update documentation to express these types.
Update ABI testing for these types.

Link: https://sbs-forum.org/specs/sbdat110.pdf
Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-power                   | 2 +-
 drivers/power/supply/power_supply_sysfs.c                     | 4 ++++
 include/linux/power_supply.h                                  | 4 ++++
 .../selftests/power_supply/test_power_supply_properties.sh    | 3 ++-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 32697b926cc8..5641f1fd5fd6 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -525,7 +525,7 @@ Description:
 
 		Valid values:
 			      "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
-			      "NiCd", "LiMn"
+			      "NiCd", "LiMn", "PbAc", "NiZn", "RAM", "ZnAr"
 
 
 What:		/sys/class/power_supply/<supply_name>/voltage_avg,
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f30a7b9ccd5e..9d6b24856c8b 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -124,6 +124,10 @@ static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
 	[POWER_SUPPLY_TECHNOLOGY_LiFe]		= "LiFe",
 	[POWER_SUPPLY_TECHNOLOGY_NiCd]		= "NiCd",
 	[POWER_SUPPLY_TECHNOLOGY_LiMn]		= "LiMn",
+	[POWER_SUPPLY_TECHNOLOGY_PbAc]		= "PbAc",
+	[POWER_SUPPLY_TECHNOLOGY_NiZn]		= "NiZn",
+	[POWER_SUPPLY_TECHNOLOGY_RAM]		= "RAM",
+	[POWER_SUPPLY_TECHNOLOGY_ZnAr]		= "ZnAr",
 };
 
 static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] = {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7a5e4c3242a0..034800cd21da 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -83,6 +83,10 @@ enum {
 	POWER_SUPPLY_TECHNOLOGY_LiFe,
 	POWER_SUPPLY_TECHNOLOGY_NiCd,
 	POWER_SUPPLY_TECHNOLOGY_LiMn,
+	POWER_SUPPLY_TECHNOLOGY_PbAc,
+	POWER_SUPPLY_TECHNOLOGY_NiZn,
+	POWER_SUPPLY_TECHNOLOGY_RAM,
+	POWER_SUPPLY_TECHNOLOGY_ZnAr,
 };
 
 enum {
diff --git a/tools/testing/selftests/power_supply/test_power_supply_properties.sh b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
index a66b1313ed88..1ebac6fe5d23 100755
--- a/tools/testing/selftests/power_supply/test_power_supply_properties.sh
+++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
@@ -74,7 +74,8 @@ for DEVNAME in $supplies; do
 	test_sysfs_prop_optional model_name
 	test_sysfs_prop_optional manufacturer
 	test_sysfs_prop_optional serial_number
-	test_sysfs_prop_optional_list technology "Unknown","NiMH","Li-ion","Li-poly","LiFe","NiCd","LiMn"
+	test_sysfs_prop_optional_list technology "Unknown","NiMH","Li-ion","Li-poly","LiFe","NiCd"\
+		,"LiMn","PbAc","NiZn","RAM","ZnAr"
 
 	test_sysfs_prop_optional cycle_count
 
-- 
2.47.3


