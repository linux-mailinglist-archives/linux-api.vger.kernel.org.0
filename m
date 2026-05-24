Return-Path: <linux-api+bounces-6388-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAauL0N+E2ppCAcAu9opvQ
	(envelope-from <linux-api+bounces-6388-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 00:40:03 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BC5C4A1C
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 959ED300875B
	for <lists+linux-api@lfdr.de>; Sun, 24 May 2026 22:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03A37BE9B;
	Sun, 24 May 2026 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P3ky81wA"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AD37B3E1;
	Sun, 24 May 2026 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662395; cv=none; b=r3iCeejNNDUsTw3Zpm8G/BB2CCy+kNARbecQUwEsrkADflOJ9HnyuQaJ5Y2GIQyN08gWBuSHO5H2u9tXZXNnfeBAZ9MPlur27VbIxmx4OiJ6//ImnGbx6mOG7foxx6phz0GRE1HjuNiIR32ns81H4xSBK10eSkhAQDTJ5lqgDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662395; c=relaxed/simple;
	bh=IzfWb3FIR60iFfSyvP7+1f4VtR+EYtoEKOgTcB72TyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKZPu1iSY+soWc5rzQbJFChUDjQJXFL8MJeDdaDi/G8WLw7XQHO1TBmdVFhaK9sheZ8sLgUNBKYeZWt7G5LEFD3xVBRzaOeHRBpnf9kX29/PqdikIpG2FZu2k3cHm8+UUGethS7OVSnu/6hNCimFVkxzpbO0anejsVH+vr7cjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P3ky81wA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jA0jwO8NqAbbwvetC+CA7ZxVTwLGbB+JAjjbDxxkNIo=; b=P3ky81wAo8B7O3cTVu6wf0JyN/
	l9o27mQ36tO2akMmIg2Mhz4ZKJUhDmhqwJLqKmCWGStSyWyFQ8+10Xs3AGWq9o9hTRts5TUdlAdKP
	hU+KO4zsujgCtvOec9f6qORXLS5CKXC/z0FtMT6nkWjpCNJ4+DJDdVOFZuM1xEcWRF5hp7lSI15T5
	Qxl/xixT0sqRASw3k6YibT7iFCKhqcgcYvomH64N7D+Wsf3oJ9egz5rcg7TnydONr8j8T3wbc2teq
	XenIlSa451Pi6jKJkdwVVDodTB2aUlJF1dhvDEAuIWmj1pyxaYL39f0/5rEc2UCkT3Dcd96A5qU5Q
	tBYlCn3g==;
Received: from [179.118.191.12] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wRHU2-007fJn-B6; Mon, 25 May 2026 00:39:46 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 24 May 2026 19:38:51 -0300
Subject: [PATCH v2 1/6] sched: Update get_task_comm() comment
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260524-tonyk-long_name-v2-1-332f6bd041c4@igalia.com>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
In-Reply-To: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
To: Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, willy@infradead.org, 
 mathieu.desnoyers@efficios.com, David Laight <david.laight.linux@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, 
 Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, 
 arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-mm@kvack.org, 
 linux-api@vger.kernel.org, Bhupesh <bhupesh@igalia.com>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6388-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,gmail.com,linux-foundation.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.494];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 1B9BC5C4A1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 3a3f61ce5e0b ("exec: Make sure task->comm is always
NUL-terminated"), __set_task_comm() no longer uses strscpy_pad(). Update
the stale comment accordingly.

Co-developed-by: Bhupesh <bhupesh@igalia.com>
Signed-off-by: Bhupesh <bhupesh@igalia.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 368c7b4d7cb5..60d004a49a27 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2005,7 +2005,7 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
  *   User space can randomly change their names anyway, so locking for readers
  *   doesn't make sense. For writers, locking is probably necessary, as a race
  *   condition could lead to long-term mixed results.
- *   The strscpy_pad() in __set_task_comm() can ensure that the task comm is
+ *   The logic inside __set_task_comm() ensures that the task comm is
  *   always NUL-terminated and zero-padded. Therefore the race condition between
  *   reader and writer is not an issue.
  *

-- 
2.54.0


