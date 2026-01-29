Return-Path: <linux-api+bounces-5773-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNnVGLEFe2maAgIAu9opvQ
	(envelope-from <linux-api+bounces-5773-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 29 Jan 2026 08:01:05 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A22AC61F
	for <lists+linux-api@lfdr.de>; Thu, 29 Jan 2026 08:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1492C30180B7
	for <lists+linux-api@lfdr.de>; Thu, 29 Jan 2026 07:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856A7336EC5;
	Thu, 29 Jan 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnvXz1ZB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E709274643
	for <linux-api@vger.kernel.org>; Thu, 29 Jan 2026 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670046; cv=none; b=m+A+1sU1XO2A/B6TEblJKF2DKQKdGiE5Vn1+QN1wob3JtfjT+TO+47Z5kODzXYZQtvrzbOObO/CwuvkSVQPWQwxc+t1gPxBLPTaKnKnssbagJQ0y+avB9qoQ31WxPEbeDIMO0wmX9eA7LpGwDtIofuf3vOyM1xf5dpB4PRHAjCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670046; c=relaxed/simple;
	bh=jgenuMj03TK6D5/8eKsMdxUuXfNrv6NeOB/FQYl3Nvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1M/G9wFLe1ipTyIPvrWGGj2T1QBRjLPwG/A7S3tpJVrpTzysHPgNTeDuc04q07rn0alkmRwQbnVNcbSX9MGh9OnVwvY6Ca+yDITjYbpfm9tkWfp+lzt8GAJcbGSFnZwogt9cVIgv14fEcuGEHXJw/bpJ9yf2Pw16xjpRRIu1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnvXz1ZB; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c5320536bfso66420885a.1
        for <linux-api@vger.kernel.org>; Wed, 28 Jan 2026 23:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670044; x=1770274844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CVEIy0ce/mZ1haXqw7kJfBAznZATEelMO91BOoKnDkI=;
        b=mnvXz1ZBEKu9zbVjbZB8PVmLbCHn/BW0EbK71HwauVl6A1oIrLYgi5FZSJJ5RY0LH9
         ygFz1EYC1zrWKoAzEIgn9Qi3x8fOYusQbiRyb9CTqq1aupP43YQReoY2zuiD8Jov5EEY
         mYQQWfaT1YvpaMnSDJqbUMbHfsgmLJko5Phc3Vq1P5FyTG9PoKidGhmnUy6389HyVQv3
         U1tCX+udyPlBv7fEaWNuO0MARZSEG6J3LxCRLkIHkH6mq4+/LO5YdZ0ZXVdG4O49Is1C
         o3DQWE+TBRelUKbzMG1B5oeYgJBA7iFGnztiSsY7goeSRJTJT0+u9bl5rGsblzpLXapK
         6uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670044; x=1770274844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVEIy0ce/mZ1haXqw7kJfBAznZATEelMO91BOoKnDkI=;
        b=RPlwJ0BeZNok9CjP7egUfSKtqWv2pes665tp9/50t5KATXVbzkWpnp97tVN5SxnGhl
         mIXfkhgiOoWXE79mQWdlfFtg+kDA51x6+A9mw/GuQHQq1V8p+ksxNVK9yH4PX6wPIanZ
         RuqAaeAvTdEmpaBbSrylODkObL74DWzkGc7IXcNAqNHjBl6skU9fsV64MzvuWpQucBQx
         Qu7yhk2kRqOpU/DAcqpFzknp7EbDmzW5MRtPfEDxTTRrFSSgEAUf+3+zQFmQgJpKH0ay
         fTfHpVyZWR3FPeNc+wWVCxWVYVgy891eRoFqxGXz6pNLtsQbjsa5XRvWKusmdQl33cFL
         QrJQ==
X-Gm-Message-State: AOJu0YxSIhXAwKZGF3khBh++gwtMdN0/6Agaxzlj+QR/de/OBDEmYZIJ
	LjLS21HrmTMGmFaIElDQd4ToLQM/Cprwr3V0bcg9+qAjcDRhfJVW5Hhl0nsUHksm
X-Gm-Gg: AZuq6aKqvE0Ly0ua8BhzoUoUIvp0QH/wsBVQ6KvQU7DEVsvpmkwNSj68IeE81elMfwP
	lh/X/I7rBr4zEgGYfdK3xRLUjxJJWNCwFjLOJczt0cPy2nMMeBP6jHz9PK+f7hqj5xZu2Uf0KeH
	LgQZioqajJ5bBMv6k5oREYJiSWiArd+VowggKAjy8yySxqvdq++5DLM3hPs+76HRvjl0aikmq/j
	dqWgnLb57HV9ulQpA9qYwB9QXJRDAWGXzCEApXa4zbZzQLm57UMUaOhTSoENTIOHMLcyX/L0L9k
	pcNuGGZtpyW7BcpQG5AMHMUMmxgZXUk94h42VG9694ogF6+xIp4vgfEGvVXM1nFSGrpEgGPxiiP
	urwjHnfn0wRXTAoO0y2b8PWMsl1724JwBB79CDX0OXx07weMP/fKSS97h76FsC/4HRPk006LHj6
	zliTfzKW8L00u1J060EOJPd+U2C5m7hxhuX24VLrQ5aHpsfEiKpCIp+0rLeAfSo6twZawx5YWCD
	cHFak6OLSDJ6eUlGMQ4n7/+nAX+vWSseeU061nDzOA10KlXqcHGZeyqXUkPKqxEUQp4Aun2R3u5
	HcQx
X-Received: by 2002:a05:7300:e607:b0:2b0:4b5b:6820 with SMTP id 5a478bee46e88-2b78d98ec0amr4513162eec.26.1769663866887;
        Wed, 28 Jan 2026 21:17:46 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88c4sm5466345eec.31.2026.01.28.21.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:17:46 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next] uapi: net: mii: correct 100BASE4 bit descriptions
Date: Wed, 28 Jan 2026 21:17:35 -0800
Message-ID: <20260129051736.18986-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-5773-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7A22AC61F
X-Rspamd-Action: no action

The 100BASE4 bits in MII registers indicate 100BASE-T4, as can be seen
in Ethernet PHY documentation (such as the datasheet linked below), not
4K packets. Correct the comments describing these bits.

Link: https://www.ti.com/lit/ds/symlink/dp83849c.pdf
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 include/uapi/linux/mii.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 39f7c44baf53..ba6f8a4fe0a6 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -66,7 +66,7 @@
 #define BMSR_10FULL		0x1000	/* Can do 10mbps, full-duplex  */
 #define BMSR_100HALF		0x2000	/* Can do 100mbps, half-duplex */
 #define BMSR_100FULL		0x4000	/* Can do 100mbps, full-duplex */
-#define BMSR_100BASE4		0x8000	/* Can do 100mbps, 4k packets  */
+#define BMSR_100BASE4		0x8000	/* Can do 100BASE-T4           */
 
 /* Advertisement control register. */
 #define ADVERTISE_SLCT		0x001f	/* Selector bits               */
@@ -79,7 +79,7 @@
 #define ADVERTISE_1000XPAUSE	0x0080	/* Try for 1000BASE-X pause    */
 #define ADVERTISE_100FULL	0x0100	/* Try for 100mbps full-duplex */
 #define ADVERTISE_1000XPSE_ASYM	0x0100	/* Try for 1000BASE-X asym pause */
-#define ADVERTISE_100BASE4	0x0200	/* Try for 100mbps 4k packets  */
+#define ADVERTISE_100BASE4	0x0200	/* Try for 100BASE-T4          */
 #define ADVERTISE_PAUSE_CAP	0x0400	/* Try for pause               */
 #define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymetric pause     */
 #define ADVERTISE_RESV		0x1000	/* Unused...                   */
@@ -102,7 +102,7 @@
 #define LPA_1000XPAUSE		0x0080	/* Can do 1000BASE-X pause     */
 #define LPA_100FULL		0x0100	/* Can do 100mbps full-duplex  */
 #define LPA_1000XPAUSE_ASYM	0x0100	/* Can do 1000BASE-X pause asym*/
-#define LPA_100BASE4		0x0200	/* Can do 100mbps 4k packets   */
+#define LPA_100BASE4		0x0200	/* Can do 100BASE-T4           */
 #define LPA_PAUSE_CAP		0x0400	/* Can pause                   */
 #define LPA_PAUSE_ASYM		0x0800	/* Can pause asymetrically     */
 #define LPA_RESV		0x1000	/* Unused...                   */
-- 
2.43.0


