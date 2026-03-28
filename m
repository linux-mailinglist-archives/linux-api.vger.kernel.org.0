Return-Path: <linux-api+bounces-6040-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKbOIEEPyGmNggUAu9opvQ
	(envelope-from <linux-api+bounces-6040-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 18:26:25 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB39734F54A
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC433030E96
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF83A4524;
	Sat, 28 Mar 2026 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnk5RSPO"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7A34D4CC
	for <linux-api@vger.kernel.org>; Sat, 28 Mar 2026 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718652; cv=none; b=ScByZx4RFmodfntaCkGK8rxLpS/C7nW32Ut2pfVdXlETe5d+CVj6OUrgtrvX0QHSfVIZmlW5kb9VFh/2cXLntsxIEAx9hBWhOKmG6XcXDjiy3InR65TnPwHcy6tTdNWUJAR8+HR0rx/INw//8RaT8W2YXR8zm4BooGbd+4VoR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718652; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NR10s+JUui0kKIa5xh8Weo4GvkpzDpM5gP9J1A9TsZ8vZgRqiKTgigzvojyX3dh2KvXse49YwIF0I+4xadnlhznjVUNq3Tn44H0B57phfh4Ut0Wn6eXFrP1qqN+kp//Xvwew0B23/gVidWQfs95BugM35VhUzLARqdaPF7vTPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnk5RSPO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so353019a91.3
        for <linux-api@vger.kernel.org>; Sat, 28 Mar 2026 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718650; x=1775323450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=lnk5RSPO5uaZzdvoYplj50n4Pdtn+IjdotyTh0EqRdl95MlH9XHvqx40Q/bH7sXudC
         m/87dqBHYnZMw8YXKzWk9pIvZkucoFMsFUgueCgMWoF6JQteXbdUudF5qj4JQBi27/RR
         OAjcQGQJ9/dINc8bZ263JhPxPxZJX5y/UofCbwEybJ7ma4Sgtz51okm3POF4gNkgNgEm
         /42sOkx4X5LBDAUb1nbwbXfMloVd7i9IdURNwKPk/oiSqEMvfbvlv6QEHEFqMjVntep6
         T2vGonEWlWtxfXjEGKsjnrLZQMBM2yxBhMfdi8Pr2EX7UL4lM/ELJHByPdWR7MIIFY2a
         /7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718650; x=1775323450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=mhuAXUVKHpR8cL8/Kw0IUc7Lh4AwY0FLrbP4jvb/qeAQnEh66vfYKHyZERCSSTQZG2
         iGGbsJcYJrpQOO0fjhs2ADs4Nq5cEpPcE3wX8WRTpdH/imfSS4TCYPDCG8I/e9ztkvsG
         tSnovo1Gl6ttnWpO+b1nXM1jz/Cdx5DxoP7dSjIBGPNGS3hAxh7d1ZMpBJsXV7MeM56v
         g+hiPhHz5Xr0z761ubratE2j8LUWobWBIsjS7qLesQYC+neKVPob8HEGynCNghF+K2mO
         h2zxVgMyc3sUxfW8cAIF+v4s4b8xXm7tZzSf8twc5m7dVMWAqQd8uJfoYf5n+BWZ3+EG
         Hqsg==
X-Forwarded-Encrypted: i=1; AJvYcCUPQNzyIADbXuXKmt+KJDFFC3pkLqsx1djemHNOl/cB5wCsxtxzUGtiBZIZQett07cHp9zemyp5bck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEh71MrXrMkXrfCyh/sasn4/oWcTurp/57JPbHeEiro6ILBvhS
	15SnpCxt0kDFw4pgNZERyILGyPxGTLnloJh8J2WVi300m6m9ZYi3pHMw
X-Gm-Gg: ATEYQzzJpINw6N2MeXh0NE93RAUADGFCNIGEt1BLAswaSI6PMCId+w2zty9hvpbW7nc
	x1dvD7Ttu3Q4rDxb/QaRTVPifBYTCuWbI/7lc9GMLalNQVw5KaP/oMsiIYnqhDsYqCy7psb+Lm6
	6OTqz9Ke216n6kk1jg6cPWkC/AAtC/Ix8ufcyy2FvuGR2M0eGCL7cROwXpfnxtjFs3hfE4uyfQG
	5oiYRKDGxheU9Yy5ebGmMsg7QpfobMHZPSGBquvPazBhvNqPdhO0iUOvWXfLnqFcee0eED/T7bi
	gILyM1DUaj4dG1Q+D9Wl/w9TtYuPnfBCBxDcQU8lKPDlMG+OksXCoL+TKksPOGVPDiNV2SDfv16
	oEMWEWbWvteUEWAev3sJTr6qYRBPxnMuV1OGJzzXe9g9CWdY5bDxJljOOf5H+zi6WdKJG0Pamwc
	cNOaWKiFrXOLGoejJMOUwfi7xUg9c4S5Vr3UuR9R6/gqADNfFEP9yvR5A=
X-Received: by 2002:a17:90b:164a:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-35c2ffb6610mr6349220a91.4.1774718649869;
        Sat, 28 Mar 2026 10:24:09 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:24:09 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v6 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat, 28 Mar 2026 23:22:23 +0600
Message-ID: <20260328172314.45807-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328172314.45807-1-dorjoychy111@gmail.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6040-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB39734F54A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..e8847f7d416c 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,42 @@ void test_openat2_flags(void)
 	}
 }
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR 040000000
+#endif
+
+#ifndef EFTYPE
+#define EFTYPE 134
+#endif
+
+void test_openat2_regular_flag(void)
+{
+	if (!openat2_supported) {
+		ksft_test_result_skip("Skipping %s as openat2 is not supported\n", __func__);
+		return;
+	}
+
+	struct open_how how = {
+		.flags = OPENAT2_REGULAR | O_RDONLY
+	};
+
+	int fd = sys_openat2(AT_FDCWD, "/dev/null", &how);
+
+	if (fd == -ENOENT) {
+		ksft_test_result_skip("Skipping %s as there is no /dev/null\n", __func__);
+		return;
+	}
+
+	if (fd != -EFTYPE) {
+		ksft_test_result_fail("openat2 should return EFTYPE\n");
+		return;
+	}
+
+	ksft_test_result_pass("%s succeeded\n", __func__);
+}
+
 #define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
-		   NUM_OPENAT2_FLAG_TESTS)
+		   NUM_OPENAT2_FLAG_TESTS + 1)
 
 int main(int argc, char **argv)
 {
@@ -330,6 +364,7 @@ int main(int argc, char **argv)
 
 	test_openat2_struct();
 	test_openat2_flags();
+	test_openat2_regular_flag();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
 		ksft_exit_fail();
-- 
2.53.0


