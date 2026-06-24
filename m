Return-Path: <linux-api+bounces-6654-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /YrCC7LjO2qkewgAu9opvQ
	(envelope-from <linux-api+bounces-6654-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 16:03:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8526BEEAE
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 16:03:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BtPmQPIA;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6654-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6654-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D853147A44
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423073B9D99;
	Wed, 24 Jun 2026 13:59:09 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348B2571B8
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 13:59:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309549; cv=none; b=Pk+oVI9bO1GKwEVFjfdQ2Mvws4h1BDTfSwi+LodTkuRrt41BYrl0l3ZCOSVX2CmUf2Ifi7bSZJg9hisJd1wpk/iZEbAoEQqqGylr5ptJdKKLaQYoFDD5hjzedheuRMCCIZt3mQLWuOHVjBUcjrKi6wjG0bGG3F4XfLOMhDCTR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309549; c=relaxed/simple;
	bh=jLHVNY6cQEgKL3Q7WFwqzYEQ72tquerqepTpM8X9NFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVQlDBssaqhlKfTkmSwNWJX7RtTuie1yAoMDe7DhqGd7KFfkrnwr6cyn5YtQP0s3x0kuwT2fNEwXXgU41+Q5LP0CY2Epp0bXdTdNRUT8n3BEqZfRV4XxKgRG1xCtxx+xkCjmYNJlTdvRmJlz8QX0YDvgEAeBwm1DT8u7219TLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtPmQPIA; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49222b6e871so6932815e9.3
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309546; x=1782914346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke4xsnfQvAtj9HUGdRHxC0rQqe0tdop+3YHmyiDVwDY=;
        b=BtPmQPIAdMiU0GA4mRA5grwqXptR6kXOHRDahxG3rnTyXIRRHN6dqPx7pnTnQqjRs9
         IybfJKG++3yQn19zhAOFdu6BBaOP9RQkj/7Sx1jI9M92O8f8biP10UAzK+adSKAT+mgT
         zZgggYo8pnrFzUFif16yo+05Uis7ufmKfCfQkNddaEFACzkayUsVZvocMsIfoNJjurtm
         rOR8tdbJ6bEOTC5UCuucFHXNCT17eb9syJpTW4KeTsOvSV40esplm6pEPeyNWDm6befQ
         0d6Wo1U6pBGhvicAY+g9e2qSFcolquIQXmHRhEnjEy6Zp7/bFFlZFAJZP2OxszIsviDg
         aFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309546; x=1782914346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ke4xsnfQvAtj9HUGdRHxC0rQqe0tdop+3YHmyiDVwDY=;
        b=M+5R7zS5GafEU5kWYuwf6hp1b44nTmKE/wUJNwOQsRGi8r+6bU2OzSBSGy9rheIZkI
         PcLVECvs+n+H6vyQF3X1Bnp3pIyBehkEO4BXMnioDuevNn20PPdLV2Z4vmsDT9W2v1sv
         hyKRhvjg19a6zSJHV5wnA9WdqeeG2f1FknhAL+TDyWHEZMRZgJtWhXhs5GFNMqNai0ZX
         J9UoIpgktmxLoNs/TBIVFXtyM14A6CqVrOXK031LonxLROcnnpZHOkA+n5qoLrMZPNbI
         8fIqYlOt5Y4GDZxuJwkB+LO1QyzCSRVwOfCFUNGleoeKoEf1UUB8gRlhe66ZrIWNLRA9
         0fAw==
X-Forwarded-Encrypted: i=1; AFNElJ9zIYVX8cJ5N+1ElGo5XolBzM6YKokTkdXJPKyALuZKYnziNARVLXivXpjdcNnRB0s4QOinwdC1OkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77fVSZYVISwdsV5AZ6uDLIGC1/0WKJb6swvcUa+VhZ/7gvdgB
	xn3bIh/1PYlAByIXhqXmSPJQxsDlq0Vv00c/aHBqoNb/Qy5p1KLt8b9f
X-Gm-Gg: AfdE7cmF2mgm86MAhLVCgdLPKP41TwIadgRRcGQDOIqCgZQTN9XABD7GK9fi8J0pzJM
	0Hu6v+V2GhEzIvC/2g48/zzPTUrydDJ8iPaZeE1qUb9hPrkOwL4V0an+CGUICV0jDuJ3fckBfr/
	F9pJHe6+2C46OnPIgyZ8zjeCgwzquCKSSByDsdt+Pk/0jCzbArwCWq4WAuxbKbHEjquyo/lo7qz
	nBHVK8kviRKulBqFUS7HtP6LblfAiwKIqNwH6Bm0igUqnkK8HsIa2ViXnMi0TXGhmd7CbGyaF81
	SEQyXhUIOATqKszkLLi31Wc3sQVT2qJlJvHxc0Tkgq6HpizpKTRcZ9JpI6ysRXY8HJyiTK/ES/8
	WZLxc3CmecM7+U6PoMckb10sQutHPeiJITJd9ll0JOlz82VJHfTfwlp1NWyiRZrx2oyqLS7QuTF
	t7IInYy5HWR03+9mHZJHbz8RI=
X-Received: by 2002:a05:600c:83c5:b0:492:3fc4:bd6b with SMTP id 5b1f17b1804b1-4925b34eab6mr121375675e9.7.1782309545981;
        Wed, 24 Jun 2026 06:59:05 -0700 (PDT)
Received: from beast.lan ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93eesm6734311f8f.20.2026.06.24.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:59:05 -0700 (PDT)
From: Boris Shtrasman <borissh1983@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org,
	Boris Shtrasman <borissh1983@gmail.com>
Subject: [PATCH v2 2/2] power: supply: sbs-battery: Add PbAc, NiZn, RAM, and ZnAr support
Date: Wed, 24 Jun 2026 16:57:18 +0300
Message-ID: <20260624135718.286771-3-borissh1983@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6654-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sre@kernel.org,m:shuah@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-api@vger.kernel.org,m:borissh1983@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[borissh1983@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sbs-forum.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E8526BEEAE

Add support for PbAc, NiZn, RAM, and ZnAr chemistries as defined in the
Smart Battery Data Specification v1.1 (Section 5.1.30 DeviceChemistry).

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

Link: https://sbs-forum.org/specs/sbdat110.pdf
Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 43c48196c167..42a941e99155 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -860,6 +860,14 @@ static int sbs_get_chemistry(struct sbs_info *chip,
 		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
 	else if (!strncasecmp(chemistry, "NiMH", 4))
 		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiMH;
+	else if (!strncasecmp(chemistry, "PbAc", 4))
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_PbAc;
+	else if (!strncasecmp(chemistry, "NiZn", 4))
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_NiZn;
+	else if (!strncasecmp(chemistry, "RAM", 3))
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_RAM;
+	else if (!strncasecmp(chemistry, "ZnAr", 4))
+		chip->technology = POWER_SUPPLY_TECHNOLOGY_ZnAr;
 	else
 		chip->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 
-- 
2.47.3


