Return-Path: <linux-api+bounces-2898-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C3C9EF957
	for <lists+linux-api@lfdr.de>; Thu, 12 Dec 2024 18:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78341188A4B5
	for <lists+linux-api@lfdr.de>; Thu, 12 Dec 2024 17:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393C4229696;
	Thu, 12 Dec 2024 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dOuvs+/G"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E322652C
	for <linux-api@vger.kernel.org>; Thu, 12 Dec 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025377; cv=none; b=O7Sm2/iHUoS8xTL1QmqUqgnbqtkZo96GV0CkdOZpX8qU9DhpK/PJLu9ZSfOrV+o+/3cqPBdHrLM4tkSz20GV8i6/1HKHtMGFu3V3X44nqvjE/pj4Vty+HyrPqzm0f2b4WFw6sQ0+6ruVNpmILoyvk+gt+yENF/SxTqxOyPdZUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025377; c=relaxed/simple;
	bh=QDdGJ4b6TLjTo21kiQPE8vi0Kz9+yyMPOFlHYQDPk4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zf7bxVQDoJX7LQFFLfshB9yAIycCzpupYGuBRJfksDnS8dDsGfyXmevybhCHskVI4CubBQnQfnXcAGI9U+sqkyD/ORF00OPkoEW3vOJiOGadkI5nTDj676VGiTqSHh+3cDA/mwYXfc5Rc+8yu8GZBcTQ04+Ops5iEVyYQoJ9yPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dOuvs+/G; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y8KYf342Bz8TD;
	Thu, 12 Dec 2024 18:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734025366;
	bh=GBc+grD+RTjGsWmnoQitfhm9MAWUGCvE9QwlCnHtBJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOuvs+/GOiJZnkIqzAe9hDVhAAzSyKjYNXNf8eRrZHrE+QA/h5foEWQBiQCkkBGwz
	 cxTkVvuhNpyY5zcpb6yDwQe/WCLyeIlHBG8uGKOpTPQR5LUxauE1xm/iHK9MUp6pyd
	 mDYmra3RxEETQdE1yxbYaira6PB9r7H64isGnUkA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y8KYd2X6lz4dd;
	Thu, 12 Dec 2024 18:42:45 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v23 6/8] selftests: ktap_helpers: Fix uninitialized variable
Date: Thu, 12 Dec 2024 18:42:21 +0100
Message-ID: <20241212174223.389435-7-mic@digikod.net>
In-Reply-To: <20241212174223.389435-1-mic@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

__ktap_test() may be called without the optional third argument which is
an issue for scripts using `set -u` to detect uninitialized variables
and potential bugs.

Fix this optional "directive" argument by either using the third
argument or an empty string.

This is required for the next commit to properly test script execution
control.

Cc: Kees Cook <kees@kernel.org>
Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241212174223.389435-7-mic@digikod.net
---

Also sent as a standalone patch:
https://lore.kernel.org/r/20241127160342.31472-1-mic@digikod.net
---
 tools/testing/selftests/kselftest/ktap_helpers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 79a125eb24c2..14e7f3ec3f84 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -40,7 +40,7 @@ ktap_skip_all() {
 __ktap_test() {
 	result="$1"
 	description="$2"
-	directive="$3" # optional
+	directive="${3:-}" # optional
 
 	local directive_str=
 	[ ! -z "$directive" ] && directive_str="# $directive"
-- 
2.47.1


