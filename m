Return-Path: <linux-api+bounces-6441-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBVkIMQRGGrKbggAu9opvQ
	(envelope-from <linux-api+bounces-6441-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 11:58:28 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A95F0118
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A5A93059FD4
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FE53B4EBD;
	Thu, 28 May 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="O3C9UCiZ"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F813B47C4;
	Thu, 28 May 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962278; cv=pass; b=DkwOpEyM81iUn1LK88hHbxkiO+O4eUJEGtneHSaGTr9OgEyuxoPxC0v1u/4iPdgRebBdz4+Q5uA0yq3PSf3djb+tLRWnjQqYMfL+YrpWp4ojyZh/qGZsthyxKO9gvses33k6r0QOyifo7qm3AeljAJEVGuB68ygdn+iRxD1oDpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962278; c=relaxed/simple;
	bh=z+oC9ewpPw1wqe8Lxu1OmdVUASLXJvs/4YmKTwjOah0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWBUAJ4bl3LaikUqYYdpvelYfFjE/Jx4Lmvu9jxuYT1FIG21zHUKLygvcOgd2u0HN8e5IGQApcnfEIigoQGsfT8QX/mJ+yeYoWcdp4XhEt+uzpRypusfbylJL6YiRW/NgpSV+ztY9sAiW+G8Pz0gkDFXf45rYEovhLYeWTl8fps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=O3C9UCiZ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779962061; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZSD0dV6lu2Vs+GZU/uLmqBVKLcZQTGeGjy2Gjh6UBP4213jrrG+4btwTtJgRBcLfDVNWnhfpATXTDqCtCqF0rKfy6gp+ZLTdaIrKrlSPzsYPh1HbbI1LZSJzSTLDLL5MGTqbyQQafwD93JyAq1SKIsIPDkivvJ5Bblsdq5bnJoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779962061; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WEVp4I6koulmeQRg+AIvYnO6/dhMP9EJtXGNcBGqGsg=; 
	b=FNBcgu95moxMmh04dwtDpU3B829r1xYZ9iRBsf/YE6S4c4QtVhaVzAMDUlUX4MWCoroEvqNGPXjXHfsio9lyXB4WiERWwyU2li6Uulk7E3TTLnhNi4S9eeHahOa+4KtIrWHk8aj4Hp4pUI8Mac3K85dj2rnbcMePE5zV/cT06mk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779962061;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WEVp4I6koulmeQRg+AIvYnO6/dhMP9EJtXGNcBGqGsg=;
	b=O3C9UCiZqPS7hLT7Zuq6qgdvMasGpu8vLibnOglnjFiWu1gjTzYAPeAftjYYrShv
	6MpmBwRW6piWgJpWqTBAdKclQQ4VVK8DZFPDtnzMhg8BCSBfKuNyRkGcj26edyh+O7V
	Rplpyc9maRQnBeYk571pu4AG/nEK3MuPZtKRUFBo=
Received: by mx.zohomail.com with SMTPS id 1779962058247658.000025721033;
	Thu, 28 May 2026 02:54:18 -0700 (PDT)
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
Subject: [RFC PATCH v1 10/13] exec: require absolute paths for path-created templates
Date: Thu, 28 May 2026 17:52:31 +0800
Message-ID: <20260528095235.2491226-11-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6441-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.beauty:email,linux.beauty:mid,linux.beauty:dkim]
X-Rspamd-Queue-Id: 213A95F0118
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Path-created spawn templates re-open the stored path during spawn-time
revalidation. A relative path would be interpreted against the caller cwd
at spawn time, not necessarily the cwd used when the template was created.

Reject relative paths for now. Userspace can resolve the executable first
or create the template from an executable fd when it needs cwd-relative
lookup.

Signed-off-by: Li Chen <me@linux.beauty>
---
 Documentation/userspace-api/spawn_template.rst | 17 ++++++++++++++---
 fs/spawn_template.c                            |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/spawn_template.rst b/Documentation/userspace-api/spawn_template.rst
index 0396d292fd17d..afe215e51db6f 100644
--- a/Documentation/userspace-api/spawn_template.rst
+++ b/Documentation/userspace-api/spawn_template.rst
@@ -30,9 +30,20 @@ returns a template fd.  The fd is an ordinary file descriptor backed by an
 anonymous inode.  Closing the fd releases the template.
 
 Userspace can identify the executable either by an existing executable fd or by
-path.  Exactly one of ``execfd`` and ``filename`` must be supplied.  Passing
-``SPAWN_TEMPLATE_CREATE_CLOEXEC`` sets ``O_CLOEXEC`` on the returned template
-fd.
+an absolute path.  Exactly one of ``execfd`` and ``filename`` must be supplied.
+Passing ``SPAWN_TEMPLATE_CREATE_CLOEXEC`` sets ``O_CLOEXEC`` on the returned
+template fd.
+
+Relative paths are rejected for path-created templates.  The kernel stores the
+filename and re-opens it at spawn time to check that the path still names the
+same executable.  A relative filename would be resolved against the caller's
+current working directory at spawn time, not the directory that was current
+when the template was created.  For example, a template created for ``bin/tool``
+while the caller is in ``/repo-a`` could later be spawned after the caller has
+changed to ``/repo-b``.  Revalidating ``bin/tool`` would then look under
+``/repo-b`` and give different semantics from the executable that was
+originally templated.  Userspace that wants directory-relative lookup should
+open the executable itself and create the template from ``execfd``.
 
 Creating a template for an unsupported executable format fails.  For this RFC
 that means non-ELF executables fail template creation rather than becoming a
diff --git a/fs/spawn_template.c b/fs/spawn_template.c
index a11a7ed676416..6430a6645fb57 100644
--- a/fs/spawn_template.c
+++ b/fs/spawn_template.c
@@ -441,6 +441,8 @@ static int spawn_template_open_filename(u64 filename, struct file **file,
 	tmp = strndup_user(u64_to_user_ptr(filename), PATH_MAX);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
+	if (tmp[0] != '/')
+		return -EINVAL;
 	kfilename = tmp;
 
 	tmp_file = open_exec(kfilename);
-- 
2.52.0


