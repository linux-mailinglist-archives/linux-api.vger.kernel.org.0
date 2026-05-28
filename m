Return-Path: <linux-api+bounces-6434-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAswHesQGGrmbQgAu9opvQ
	(envelope-from <linux-api+bounces-6434-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 11:54:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D775EFFFD
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D74D303CD6E
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E83B0AF8;
	Thu, 28 May 2026 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="ibP9/gpb"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54D3B19CD;
	Thu, 28 May 2026 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962089; cv=pass; b=nOBkKObhVYUWxnFN1rug3HCIMteF1fnj9Dwl1otGO37qjwJQyp0tHIo8tQYXYlZaPPEeBzbdVT5xnq8yf+7lHnmM6Yt+FcnWiTOEezfl48SuT06/795XYIwDEwPbZgpUPbovqHlbHo3j2nu326xQ9qyDJgykmVwn1d+BbrbxTVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962089; c=relaxed/simple;
	bh=p8JwGfGwuQJSTehFaGTsZoPBVvd78o6xdHJNlYzgKGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtHJq7bz8wfywG0z8JQNFjmGOlDp+45ppHj93llKjSsTGb/iO88Cl12hZr9FEmL5txt1O6uwkf8u1U02k/mzuY5moX3FQRybDuzdKPINsJkxOaBjPkDHH1Kl9aRQCZnDV2/Ti/Lb66v397KTF2PBYJvw6VPj8mK4iAChRiGYEoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=ibP9/gpb; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779962002; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BjY+rrmWLeXJJjQO8PJHtywe0UJQ7E2pjwCx5wcNHnA4egGvITx/6i2EtDKw/2QqNijDBOqEimBC9n8mh1z5puanqcp1ql2SmS9gCg70wze3E/yaOE/v+ub7FWNQ0WbpSi79NU88eYotN8TMyyRvKJAxy3KuyMrG9rZROYEWuH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779962002; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MC4dHb80t6/BIqcUh3zzA0OufX3r53dp1BU6A+dxByg=; 
	b=DWGfOBX55kPaMTFI0EZNeE/PGV94CywIhXgl+CCRnmAWmdgsCpA+SHASORGhm79ZvFWpdOf9NuVZOIUf9dkHGoN6ZrYu0cc035jAag50/MWLMdB2yg13Rf3ey+sXW7HzVr87mVyVmb8hNeEtVnClLGL+QfoVZ5Mf20d21GDY/EE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779962002;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MC4dHb80t6/BIqcUh3zzA0OufX3r53dp1BU6A+dxByg=;
	b=ibP9/gpbHz+8ZyfY8Yxk0qP/vQNgBX0rzt1bGyckd4RNeJkQqw5x+v2ABym4GyET
	SZA91nuGCe9SpX2YTxy/S6LA8HV00AM10poCIJaWS8/YHddtqYafv4m2Lfng6Nv29FI
	XdRjwESCU5nRsJaVHk7lPHNvHbMljrXf7abRlHGo=
Received: by mx.zohomail.com with SMTPS id 1779961999561196.25957869706974;
	Thu, 28 May 2026 02:53:19 -0700 (PDT)
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
Subject: [RFC PATCH v1 03/13] file: expose helpers for in-kernel fd actions
Date: Thu, 28 May 2026 17:52:24 +0800
Message-ID: <20260528095235.2491226-4-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6434-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,linux.beauty:mid,linux.beauty:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 16D775EFFFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Split do_close_range() from the close_range syscall wrapper and make
ksys_dup3() available to in-kernel callers. Later spawn-template fd
actions use these helpers instead of duplicating close and dup logic.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/file.c               | 11 ++++++++---
 include/linux/fdtable.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index e5c75b22e0c7c..a9f4b4e2dcd45 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -815,8 +815,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
  * from @fd up to and including @max_fd are closed.
  * Currently, errors to close a given file descriptor are ignored.
  */
-SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
-		unsigned int, flags)
+int do_close_range(unsigned int fd, unsigned int max_fd, unsigned int flags)
 {
 	struct task_struct *me = current;
 	struct files_struct *cur_fds = me->files, *fds = NULL;
@@ -867,6 +866,12 @@ SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
 	return 0;
 }
 
+SYSCALL_DEFINE3(close_range, unsigned int, fd, unsigned int, max_fd,
+		unsigned int, flags)
+{
+	return do_close_range(fd, max_fd, flags);
+}
+
 /**
  * file_close_fd - return file associated with fd
  * @fd: file descriptor to retrieve file for
@@ -1421,7 +1426,7 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
 	return new_fd;
 }
 
-static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
+int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
 {
 	int err = -EBADF;
 	struct file *file;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f0072..7f852fcc082a4 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -112,6 +112,8 @@ int iterate_fd(struct files_struct *, unsigned,
 
 extern int close_fd(unsigned int fd);
 extern struct file *file_close_fd(unsigned int fd);
+int do_close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
+int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags);
 
 extern struct kmem_cache *files_cachep;
 
-- 
2.52.0


