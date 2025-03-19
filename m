Return-Path: <linux-api+bounces-3387-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E119BA68129
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 01:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA873BADFE
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 00:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B638528E;
	Wed, 19 Mar 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c15ZypT8"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20BEACD
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343341; cv=none; b=UkZ6ly24ceQllWE7n29eim4Hdzt3VLmyE6P0VhawMaC5iAqNW+OrF5SoWm2nsvUSk4mhmOrX9W+c8Rck+VenkCy6TeSpA7Llmr2pyWtI3Aw8kwfDfyeJuF/mZiIfM9hBjn1y8N85bMw6mMbmaqC/B3Sj+oRNxuoPoKLoM2hKaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343341; c=relaxed/simple;
	bh=F+Fl+hJmeyq3YWzTs6D9ZDaWGOG6IPUOQDfOlysIeuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsGWSNN6xm1oqeNbX9Arj6eZQ8a5KEJ2y5ZvSn7mOMp/IeUdAM9a2v5GEn8vDFYUConW1QX8852itwmtugnxrz7NEpmRjjQM8kXDBiJh1vVju5vRnEwcKpO7vop+ZOGLgPbF+TzzPikLI+XJsfmESl+MgdsJh+Nfkq50uQRihq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c15ZypT8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so7127273a91.0
        for <linux-api@vger.kernel.org>; Tue, 18 Mar 2025 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343338; x=1742948138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciean/zWrbirFJ6x0i1/pN9FA0IKn0ZUFy/flQBxt2c=;
        b=c15ZypT8L1mzw749Vu6yvbOQWTg1d566iXrxBwFUrtc04MkaXhvFKCRKYekK66oUAe
         hniCMAklfD3Okow66BOahdsnXukn+F4oQMvLgsBOSizEUMOcBMjoBpiUQYnPgv6OUxjM
         DqbVqJAsPDX3z3pJnmykkXGWnIM9tc5E4SuiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343338; x=1742948138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciean/zWrbirFJ6x0i1/pN9FA0IKn0ZUFy/flQBxt2c=;
        b=oGpL6z8HVPlhc5eK1oASAJqUh7MWDZXQh3KzOlGMgHx8hw6GCsi48ytuWvaotvzDVq
         rafyTnIvO1wrfRmToHBdom8eoR2tMa7zOL9Jjq4MoblPqnUDXr182Oenw2rWcL1YzqdG
         mVe1g/ZL60XO/oDglJnhuh3ofkxdZq0mypLcepSwY5r5/u8vyiISOszc91w+J9WWjhNm
         PV4aExAKiwj0FwofS2ZfW9CAW8jtL5f6ylDbhyFOQOqMyPY6BzgfRpqBmFIGgVglU6Cr
         4AKT08tJzNEuVRRH+jlBBCzs9mLA9bwSsFmC20LjzTk9jJKBySZ74LZGWiJFX48yndHz
         JEiA==
X-Forwarded-Encrypted: i=1; AJvYcCVoAf+2HmkKZJ8Xp0kVmeyAg5/qCvI9Ae66GwzgsW9qTBC4tOvNqfTldDSHanTrWcwHaMIKxOHHzAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsXMooLNlCP7khrjy7kwTReTSCi0Eo/Y5uxksk/jEiYklTHNS
	xP7o8B9mWaxZJnfs8YjRO00MP4yrBGwmNvDPPMFgnBBPLM8CxoL97e8KYNAyNPI=
X-Gm-Gg: ASbGnct7dWtEDn+r5cyb2btlKIA1ODgOYPNLQRrS+zkMg2oscd0S4CmkLtwAHTk+mLl
	Fj50oHec0q5FTHPH3qviCHZNe12R/HMPDat//JDxV4M9QyjDzBr/Zq6ecy4TyibtJrCvk/zBnuY
	/UDMN/Jimzxu0ZZh0c8i06+u2De9WQ68gwmSfr5H+2wn0yBtoi9fi/lfFwy3dZK40iS+ZZUCbAJ
	REakCwiL2FA2OhZqXQ6jVYj2altb0yPEVdyylgEUptE9u/wXIC8l5owwgROtdqAfy5O8cNH5pzN
	VJwioodF39PTGPiadlSHIwQs4aj1dgLBwv19zm9S6ZErqOsVIJMDr2l26DD2Dso=
X-Google-Smtp-Source: AGHT+IHkLC7P0qxfNOZ7am8oGQAhk+QCLx5pooxaYbMLyunCN1d9iFhe6ACMIi4+onLyvuY52I93jw==
X-Received: by 2002:a17:90b:17c5:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-301be205cfamr891476a91.29.1742343337829;
        Tue, 18 Mar 2025 17:15:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:37 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 01/10] splice: Add ubuf_info to prepare for ZC
Date: Wed, 19 Mar 2025 00:15:12 +0000
Message-ID: <20250319001521.53249-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update struct splice_desc to include ubuf_info to prepare splice for
zero copy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/splice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/splice.h b/include/linux/splice.h
index 9dec4861d09f..7477df3916e2 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -10,6 +10,7 @@
 #define SPLICE_H
 
 #include <linux/pipe_fs_i.h>
+#include <linux/skbuff.h>
 
 /*
  * Flags passed in from splice/tee/vmsplice
@@ -43,6 +44,7 @@ struct splice_desc {
 	loff_t *opos;			/* sendfile: output position */
 	size_t num_spliced;		/* number of bytes already spliced */
 	bool need_wakeup;		/* need to wake up writer */
+	struct ubuf_info *ubuf_info;    /* zerocopy infrastructure */
 };
 
 struct partial_page {
-- 
2.43.0


