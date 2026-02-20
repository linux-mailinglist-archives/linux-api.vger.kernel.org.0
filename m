Return-Path: <linux-api+bounces-5868-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GpxHMrDmGl/LwMAu9opvQ
	(envelope-from <linux-api+bounces-5868-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:27:54 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D5216AA0C
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8D01301015C
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A021D3019BE;
	Fri, 20 Feb 2026 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZBYl1FzM"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC72FB99A;
	Fri, 20 Feb 2026 20:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619263; cv=none; b=EViYmEZJGctlGCGImb9zVcHxY8WKkI5DDqWkRVdnFWgmY18IiYL5iWI48tlHvfZsErN0QWRQ1/j50Jmf73l/vnAq2GUNAA5TroEUX/FPuBNAmZuNVGvdEG4Ry7HR36m23a9WYE5olOmUSomW1XeT8oGpschN63ErqmGLVSGmHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619263; c=relaxed/simple;
	bh=qfgc6WxgjzSuKeiRpMAd9MocMsWaTgKveADr+1kuvD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iVSE4hh/KMKuNfFx5hesuEpnzfNXManPmGUiqGUtjDdTpYzFrhhE6f7A304fdAH490kQx1/r3kCn64ovztIi/VT1ZqVDkeNRey2/ZHnBf231D3BoSLPte9xK96tWlbr4YlR5d3pR5RMM7HEWZgb7Kbi7a4s0nkmI1SIAQdR/WJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZBYl1FzM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C+xTVEgi7UaEFZNNdjOZRbwxjimZapcq1Tyr+3xwoD0=; b=ZBYl1FzM8ozc332kzDFs/B8ewN
	CUcvOudwg1CzmbUdjKiSbVazSeY6VIAX9nN9NWHHZ5lq0dlTeYTeRuoZpdtuLihLH9ov+Fzx9VvZj
	l4VFzgmI7ICTxjEonq3kI8n57EW1ejl66OGatFXqRrxat4Luh1hVTfqX6j5qYjyBx60sDzDfVKzAj
	phSduiAiU6nqjc45mOVJv1TDWjves5gYEFJoPLVJkBNrRHG2qLRBZtAnzSFe0YZp10ErTk1KVceyc
	dUwNdMTFJ3zfhDe/6btOIETDrfrG/GcAYXYJt4W6rsE1DMJX1YiVI9Kmidhjw8XibH2Sk6lJdnV2H
	s8OMQb7g==;
Received: from [187.57.77.133] (helo=computador)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vtX5L-0036Zi-PD; Fri, 20 Feb 2026 21:26:48 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Carlos O'Donell <carlos@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Rich Felker <dalias@aerifal.cx>,
	Torvald Riegel <triegel@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: kernel-dev@igalia.com,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 2/2] futex: hack: Add debug delays
Date: Fri, 20 Feb 2026 17:26:20 -0300
Message-ID: <20260220202620.139584-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220202620.139584-1-andrealmeid@igalia.com>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5868-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12D5216AA0C
X-Rspamd-Action: no action

Add delays to handle_futex_death() to increase the chance of hitting the race
condition.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 kernel/futex/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index cf7e610eac42..d409b3368cb3 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -44,6 +44,7 @@
 #include <linux/prctl.h>
 #include <linux/mempolicy.h>
 #include <linux/mmap_lock.h>
+#include <linux/delay.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -1095,6 +1096,12 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 	 * does not guarantee R/W access. If that fails we
 	 * give up and leave the futex locked.
 	 */
+
+	if (!strcmp(current->comm, "robust_bug")) {
+		printk("robust_bug is exiting\n");
+		msleep(500);
+	}
+
 	if ((err = futex_cmpxchg_value_locked(&nval, uaddr, uval, mval))) {
 		switch (err) {
 		case -EFAULT:
@@ -1112,6 +1119,9 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
 		}
 	}
 
+	if (!strcmp(current->comm, "robust_bug"))
+		printk("memory written\n");
+
 	if (nval != uval)
 		goto retry;
 
-- 
2.53.0


