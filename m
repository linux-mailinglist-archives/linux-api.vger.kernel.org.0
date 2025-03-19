Return-Path: <linux-api+bounces-3390-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D368A68136
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 01:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A987A83C0
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DBD1922FB;
	Wed, 19 Mar 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gIVpTV15"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272515B971
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343345; cv=none; b=MdKU0DuZCgH8alXQHH6ey2WYP3u3nvDpPZaPjHEU14oqONzEDcrEa/1Lg0QPSBYM+GA/3lTC4/jUqV+zXC4KLxQj96e48F37G9SnyY0N+IGYbSTsnQm79KiXE/uQH18i92PsZ2WRLLXRPI6mwU8r8eBfkcrw/YCDWbtxn2qncko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343345; c=relaxed/simple;
	bh=SowAWf3suxdJmhbIj/+rpT/CNsAYNCCACOuR5s/3LGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgCd0DEr7npH688DR6JwUCmbcxkJmOZPZnWHfpFESIVf0XIuJRczXrHxhf6FOYuT4l3dSnpiLJjltjuOk1IqShrP/Nx96+7JM7U/6vAxvOONShHkqFj8YDZgEO7E89r2HFwflOdEY48gBMhGCiJlYZngzh0hmPGVWn2DjJk6wEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gIVpTV15; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22409077c06so157974845ad.1
        for <linux-api@vger.kernel.org>; Tue, 18 Mar 2025 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343343; x=1742948143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BqxlSUPLPLK+n0IEZ/na32d+xFXeCa925E/NE7WMKY=;
        b=gIVpTV15hhkkYilj5BypVWGWlzUL3CqQ72S1nz2FWsVuUY16SNpf5KQkU11mnaTAKn
         1WaoeJcNBjDgCS32IwIWKfkUfCs3oFZs0wmmQtBRsXJzqoJr4KgKFKcmXmUWyDSv1UL4
         BoqqJF1llr2ptP6/5CELh0Zkw4SLxiefAIwMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343343; x=1742948143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BqxlSUPLPLK+n0IEZ/na32d+xFXeCa925E/NE7WMKY=;
        b=jyKJ9wsodqC/PhDF5IIlTFrjkYAUdMVQzCPta81ZXitaGhrU0VY+g+antHv6l/XQ4i
         eTkfTf5LWQrrHdFwevqSelsVEU0WBaUl7KCRbkt5TJQMlP2rVlKJuutFlGQCweulIEVT
         8UwmXhxlnuCwNU90TMfqtajLpQKIPebjcOwWpq8rqmOctOuibCDWKx+ksuOOrDx+8hNo
         vHgRHpypr7EvkjXgYHVyWFoo3RvVFrSZKcRLwmEudpzxfPK23v23Bj79JcECbySfxWes
         7BUF+FCWiXReZQRWL27Ss+zLTQW9b3M6CwPHV6HCD+djuae9OF8AVrDYA48m5LeH/EWp
         BnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUreOTDby1GIsO0uEhyB3oWTWTZxS0rOvio3GH6eRbWBlc9+PkjxlJZ+dBE2ZGSomznfNjH9OYK/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5UmPIa5DYpGaOwD427QwlH5xhFZL/OolaV/t1AIjPmJNYkCBx
	wQPY4pDCPYk9fc7OsX2ZDmEgm999eluVfYPaNuczOwMekguqvrM3PUoGRDXVFfI=
X-Gm-Gg: ASbGncuQ71hGNkuEp58Jx6b7PDYqeRT9q4D+ngzZm98KfQZPhdYRl9XXbSsUluDsYED
	aNkz3zl7VWFU6yfkNAFYlMjW/7WiT8sTqcpkCJXhRt1RTW7FXhOQbcU5UeboYGtBH11LMU3fRnD
	01o3xAviR0paKobAYdS8z+XaW/lTL9Y1E12UJ465Snh3/Y4CwWbfp8LEWWGKOh9955pGFfaxVP6
	IPe45BtlUbrfKnMzmC9/01bJOir5WmfpfO4w7wvVDhmXkmaFMmcpq/+6qj5sWDJH4ZN1oiBhfFJ
	fbWjFWWyIuE56PvyLJK+frmA6VqGV7bkye7FigFF8btcyrThzlhs
X-Google-Smtp-Source: AGHT+IFxyw3nvWmVaD9tl0lJBbbnI8q3NC7K/P2umCsKr9U07OgWwl21w/NuymcNKusQI296uT0O6g==
X-Received: by 2002:a17:903:1cb:b0:224:76f:9e45 with SMTP id d9443c01a7336-22649a3476fmr9616615ad.21.1742343343024;
        Tue, 18 Mar 2025 17:15:43 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:42 -0700 (PDT)
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
Subject: [RFC -next 04/10] splice: Add SPLICE_F_ZC and attach ubuf
Date: Wed, 19 Mar 2025 00:15:15 +0000
Message-ID: <20250319001521.53249-5-jdamato@fastly.com>
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

Add the SPLICE_F_ZC flag and when it is set, allocate a ubuf and attach
it to generate zerocopy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c            | 20 ++++++++++++++++++++
 include/linux/splice.h |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 1f27ce6d1c34..6dc60f47f84e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -875,6 +875,11 @@ static ssize_t splice_socket_generic(struct pipe_inode_info *pipe,
 		if (out->f_flags & O_NONBLOCK)
 			msg.msg_flags |= MSG_DONTWAIT;
 
+		if (unlikely(flags & SPLICE_F_ZC) && ubuf_info) {
+			msg.msg_flags = MSG_ZEROCOPY;
+			msg.msg_ubuf = ubuf_info;
+		}
+
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
 		ret = sock_sendmsg(sock, &msg);
@@ -1223,12 +1228,27 @@ static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
 	if (unlikely(out->f_flags & O_APPEND))
 		return -EINVAL;
 
+	if (unlikely(flags & SPLICE_F_ZC)) {
+		struct socket *sock = sock_from_file(out);
+		struct sock *sk = sock->sk;
+		struct ubuf_info *ubuf_info;
+
+		ubuf_info = msg_zerocopy_realloc(sk, len, NULL);
+		if (!ubuf_info)
+			return -ENOMEM;
+		sd.ubuf_info = ubuf_info;
+	}
+
 	ret = splice_direct_to_actor(in, &sd, actor);
 	if (ret > 0)
 		*ppos = sd.pos;
 
+	if (unlikely(flags & SPLICE_F_ZC))
+		refcount_dec(&sd.ubuf_info->refcnt);
+
 	return ret;
 }
+
 /**
  * do_splice_direct - splices data directly between two files
  * @in:		file to splice from
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 7477df3916e2..a88588cf2754 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -21,8 +21,9 @@
 				 /* from/to, of course */
 #define SPLICE_F_MORE	(0x04)	/* expect more data */
 #define SPLICE_F_GIFT	(0x08)	/* pages passed in are a gift */
+#define SPLICE_F_ZC	(0x10)  /* generate zero copy notifications */
 
-#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT)
+#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT|SPLICE_F_ZC)
 
 /*
  * Passed to the actors
-- 
2.43.0


