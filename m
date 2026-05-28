Return-Path: <linux-api+bounces-6432-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHnyCuMTGGrKbggAu9opvQ
	(envelope-from <linux-api+bounces-6432-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:07:31 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA0D5F0326
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F180530A179C
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAFC3B3C12;
	Thu, 28 May 2026 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="sIdbe8n9"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609053B2FEB;
	Thu, 28 May 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962038; cv=pass; b=oGYkV5BXnkiCw2RyPciYwAPlP1uUAjlcYmFzLcqh0QXRyj32HfIi4n5ny8JoDpQGdWQcl6ZFrwGT/uFnjfnV4jlyCECn9RYHpY0VuzK/E36EhvPl0NJyYeJHeOMlbhW/GsPsbWHozu3FuQpIehSBzlgGXe6cIJb/DJjRLPRBn6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962038; c=relaxed/simple;
	bh=bM7VdoNzlN0OoaRFNHua4ms2D7EuHg+aAiw2Dpk0NZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvQIXIIH8iERvpF7RXWMJKrw071Cv6O46Vp2TZH7hfQQfaG+bJnhWx4WmIws5iNgUFc6A0PLNBIHhQ13yaoZerxIZWNDDJJptkK66HlPZveRIv1kGpgl1JF/hKl5h3B7CeP6XuZ260SWd18ENsttjyXpzHw/p7+QzwIl03CfSsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=sIdbe8n9; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779961986; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X7dnCemyRqEyut9V0SvVWbBJ81qtmnAvbGRlrccs1zrEKYNR8zMqZkq5SW8+5RzWC11E8wC4sZiczegs1Fas45T8ZhWzAjaGr3TvcGTGjvaMOtFwP2kUb+1F7sJK1gRm0iPRq80xbxUVeM1icNvoozlNjNl4qLYSHZUPx0ArOw8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779961986; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TW9xzJaDheLzGIs2ITQXktnE3vsoHg7TqlJgpHRDctk=; 
	b=ezVqXRV9miOfrjvwjSocUZyJf7ailaKqN+vVFlYzR/LoY1z7uDyNUwlRaK1Yr+XHjGxTDdFDKLmzuoxi8Jy4mp9jEByQP7kLMbnPlWaxgqAFxTWMzd/PUp/rGedmQoYbWUmX9YAoEvfwwvgmZ2Q0Z+VpiAno2m8ySfrPePBNY58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779961986;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TW9xzJaDheLzGIs2ITQXktnE3vsoHg7TqlJgpHRDctk=;
	b=sIdbe8n96YbY8VT5gwJ3g34/YwKwOlA+a+er8pX2jqmL1D6m+0PNAASmIKC2OVBe
	zmwW8CsIeGTvHbiPGhNvxdMby31wyE2juw4jNWa12UsRCrdHzolJfQcCCcI2jOniGy6
	oi/6XcU1WwLsWQn/y7xrIXUj9C5/43otDghx22Ek=
Received: by mx.zohomail.com with SMTPS id 1779961982944561.1060190300934;
	Thu, 28 May 2026 02:53:02 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Li Chen <me@linux.beauty>
Subject: [RFC PATCH v1 01/13] exec: factor argument setup out of do_execveat_common()
Date: Thu, 28 May 2026 17:52:22 +0800
Message-ID: <20260528095235.2491226-2-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528095235.2491226-1-me@linux.beauty>
References: <20260528095235.2491226-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6432-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,linux.beauty:mid,linux.beauty:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1EA0D5F0326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the common userspace argv and envp counting and stack setup code
into do_execveat_common_bprm(). Keep do_execveat_common() responsible
for the existing RLIMIT_NPROC check, bprm allocation, and error path.
This is a mechanical refactor for later opened-file exec users. It
does not change execve or execveat behavior.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/exec.c | 53 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2889b7cf808d7..53f7b18d2b1ea 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1775,31 +1775,12 @@ static int bprm_execve(struct linux_binprm *bprm)
 	return retval;
 }
 
-static int do_execveat_common(int fd, struct filename *filename,
-			      struct user_arg_ptr argv,
-			      struct user_arg_ptr envp,
-			      int flags)
+static int do_execveat_common_bprm(struct linux_binprm *bprm,
+				   struct user_arg_ptr argv,
+				   struct user_arg_ptr envp)
 {
 	int retval;
 
-	/*
-	 * We move the actual failure in case of RLIMIT_NPROC excess from
-	 * set*uid() to execve() because too many poorly written programs
-	 * don't check setuid() return code.  Here we additionally recheck
-	 * whether NPROC limit is still exceeded.
-	 */
-	if ((current->flags & PF_NPROC_EXCEEDED) &&
-	    is_rlimit_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)))
-		return -EAGAIN;
-
-	/* We're below the limit (still or again), so we don't want to make
-	 * further execve() calls fail. */
-	current->flags &= ~PF_NPROC_EXCEEDED;
-
-	CLASS(bprm, bprm)(fd, filename, flags);
-	if (IS_ERR(bprm))
-		return PTR_ERR(bprm);
-
 	retval = count(argv, MAX_ARG_STRINGS);
 	if (retval < 0)
 		return retval;
@@ -1846,6 +1827,34 @@ static int do_execveat_common(int fd, struct filename *filename,
 	return bprm_execve(bprm);
 }
 
+static int do_execveat_common(int fd, struct filename *filename,
+			      struct user_arg_ptr argv,
+			      struct user_arg_ptr envp,
+			      int flags)
+{
+	/*
+	 * We move the actual failure in case of RLIMIT_NPROC excess from
+	 * set*uid() to execve() because too many poorly written programs
+	 * don't check setuid() return code.  Here we additionally recheck
+	 * whether NPROC limit is still exceeded.
+	 */
+	if ((current->flags & PF_NPROC_EXCEEDED) &&
+	    is_rlimit_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)))
+		return -EAGAIN;
+
+	/*
+	 * We're below the limit (still or again), so we don't want to make
+	 * further execve() calls fail.
+	 */
+	current->flags &= ~PF_NPROC_EXCEEDED;
+
+	CLASS(bprm, bprm)(fd, filename, flags);
+	if (IS_ERR(bprm))
+		return PTR_ERR(bprm);
+
+	return do_execveat_common_bprm(bprm, argv, envp);
+}
+
 int kernel_execve(const char *kernel_filename,
 		  const char *const *argv, const char *const *envp)
 {
-- 
2.52.0


