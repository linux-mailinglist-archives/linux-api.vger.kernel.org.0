Return-Path: <linux-api+bounces-6442-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NIEKVkVGGprcwgAu9opvQ
	(envelope-from <linux-api+bounces-6442-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:13:45 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109EB5F05A8
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 12:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D0F0315F699
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E0C3B2FE7;
	Thu, 28 May 2026 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="YUJuo6pz"
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70F3ACEF6;
	Thu, 28 May 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962305; cv=pass; b=oQJqUPjThrddSf1N8mUl4H4mPa8RKl37cdnp6cop14zKqz//sKpCEWgnRlHX32AxvIGf8BckKYLSrNyfXN5HTD0gCpoz19b4/o7xM70SAcY8PBw3o6QYlJL/ErwASc7MKZHFbZ91rYXjTxS8N2rY5u24ZGxdIqx8S+ENwH7Lcv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962305; c=relaxed/simple;
	bh=TNQhlKE5ncbDbax/x2D0txr5da9b+jQxZpuKlwO+Tdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq3kefsREVKzazq4+kX1BJ3wWGPw0ZI/cP+cjLJH/tXiCRHLYK+liTXO3dAGaemKU5q9ae+bF1BY+SCuy02yBKZk8RC2DEofoCPyzK+WRH9HlXSGeWKGhBHs7H44+GtofQZOe/GSEq705wIfy+tL4vWS8Nz3cqyifDkjuxMqs5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=YUJuo6pz; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1779962067; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dB9yOHSNdn+pWFMuwv0a5OAZPV6rGF6mxWBxJYpmxnEQhcE9PL2qzlDtn+HCW4P572tQZIbnSjl1UThemLDSlHOb1ox6eGvNTl2c30rdT7plQX0/sSxhEynNGE244uzmVMwUwGIUYH+I0SGH+lM+u5tpjxoWeVbb1D1BLn/sFLw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779962067; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IHFIJ1vwh+H9qkGl5p1gj4xNKLC/W2D7/bdfKg3hdPk=; 
	b=mYzWwm9UB/Ibj317Bb1PC9rRaGISOA2iVqGm0hi+RK+JmoPPQIbXazZ02brt9atvBtr7mcXQkRWqrtiUSXokiG/HC+l1oUn8LBEK9bORfoWQ6/qwCPn0NTi2lKR4hfTze889JeRBdk4JJsTnf1qTswL7XgVnizMzdl5FMmSrGSM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779962067;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IHFIJ1vwh+H9qkGl5p1gj4xNKLC/W2D7/bdfKg3hdPk=;
	b=YUJuo6pzThKZZRmNDytEoVG8XxhsJEgV2A64AF9QCP+z4KxxS9ZpHYsTi5cgWN+m
	xbowODJ26oN67r27JDk1J0H00zzU65hURcQW+e5i88PENqjWcJCO40KgZkUszKdfKLF
	QCRs14tqi6O2lD4jNAljNciyS8r70RPa3Ie1MejE=
Received: by mx.zohomail.com with SMTPS id 1779962065945647.9310517427938;
	Thu, 28 May 2026 02:54:25 -0700 (PDT)
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
Subject: [RFC PATCH v1 11/13] exec: let close-range actions target the max fd
Date: Thu, 28 May 2026 17:52:32 +0800
Message-ID: <20260528095235.2491226-12-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6442-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.beauty:email,linux.beauty:mid,linux.beauty:dkim]
X-Rspamd-Queue-Id: 109EB5F05A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow CLOSE_RANGE actions to pass newfd == -1 to mean the largest
possible fd. This gives userspace a compact way to request the common
close_range(first, ~0U, flags) pattern even though the UAPI action uses
signed fd fields so OPEN actions can still carry AT_FDCWD.

Signed-off-by: Li Chen <me@linux.beauty>
---
 Documentation/userspace-api/spawn_template.rst |  3 ++-
 fs/spawn_template.c                            | 10 +++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/spawn_template.rst b/Documentation/userspace-api/spawn_template.rst
index afe215e51db6f..be66be20d4fde 100644
--- a/Documentation/userspace-api/spawn_template.rst
+++ b/Documentation/userspace-api/spawn_template.rst
@@ -86,7 +86,8 @@ kind of setup that ``posix_spawn_file_actions_t`` commonly performs:
   Open a path using ``struct open_how`` and install it at ``newfd``.
 
 ``SPAWN_TEMPLATE_ACTION_CLOSE_RANGE``
-  Apply ``close_range()`` to a child fd range.
+  Apply ``close_range()`` to a child fd range.  Passing ``newfd == -1`` means
+  the range extends to the largest possible fd.
 
 ``SPAWN_TEMPLATE_ACTION_SIGMASK``
   Set the child signal mask.
diff --git a/fs/spawn_template.c b/fs/spawn_template.c
index 6430a6645fb57..82b833bc9865a 100644
--- a/fs/spawn_template.c
+++ b/fs/spawn_template.c
@@ -220,6 +220,8 @@ static int spawn_template_apply_sigdefault(const struct spawn_template_action *a
 
 static int spawn_template_apply_action(const struct spawn_template_action *action)
 {
+	unsigned int max_fd;
+
 	switch (action->type) {
 	case SPAWN_TEMPLATE_ACTION_CLOSE:
 		return close_fd(action->fd);
@@ -251,7 +253,8 @@ static int spawn_template_apply_action(const struct spawn_template_action *actio
 	case SPAWN_TEMPLATE_ACTION_OPEN:
 		return spawn_template_apply_open(action);
 	case SPAWN_TEMPLATE_ACTION_CLOSE_RANGE:
-		return do_close_range(action->fd, action->newfd, action->flags);
+		max_fd = action->newfd == -1 ? ~0U : action->newfd;
+		return do_close_range(action->fd, max_fd, action->flags);
 	case SPAWN_TEMPLATE_ACTION_SIGMASK:
 		return spawn_template_apply_sigmask(action);
 	case SPAWN_TEMPLATE_ACTION_SIGDEFAULT:
@@ -306,8 +309,9 @@ static int spawn_template_copy_actions(struct spawn_template_action **out_action
 				return -EINVAL;
 			break;
 		case SPAWN_TEMPLATE_ACTION_CLOSE_RANGE:
-			if (actions[i].fd < 0 || actions[i].newfd < 0 ||
-			    actions[i].fd > actions[i].newfd ||
+			if (actions[i].fd < 0 || actions[i].newfd < -1 ||
+			    (actions[i].newfd >= 0 &&
+			     actions[i].fd > actions[i].newfd) ||
 			    (actions[i].flags &
 			     ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC)) ||
 			    actions[i].arg)
-- 
2.52.0


