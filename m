Return-Path: <linux-api+bounces-6237-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GtlDxGu8mkatgEAu9opvQ
	(envelope-from <linux-api+bounces-6237-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 03:19:13 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 359D649BF98
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 03:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27FA330060AE
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 01:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26204258CD0;
	Thu, 30 Apr 2026 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQV3aXAl"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E123EA8A;
	Thu, 30 Apr 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777511948; cv=none; b=cy4wgf0UZSwTrkwd3PJ20yM7QGPjfxJPUxGs4jLOlTyx+QmAwnRU4dJJ9E15QUU6l7yyOt5EFJWZqRnGIq+liEPBFtxCtvIPrM+EuA82WRlA9YCb5T9wNZHfP5kdzXtrqsYhh6DXi6KSdhbJGVmSTQbYjnf2Fbf/93V2DjgAk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777511948; c=relaxed/simple;
	bh=6czsOlNriyalap6EeFnkX5tgFtke+HknraCqL0WxuNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROeIXqnQTLY1k7PEabB0fhvABV1FjhsC3FTz09Tfhjm8WTSU8phtiGttQMjYhE9SQB7esq3fo9zOFvLc1N+VlQgN6C+tBoixDrk4gzHZJ/rNWqyBbDak/k01kROkD6pXVa+ga0pJLNeyLxEugn4bOR3BJuk2fp84CQRQL0vtOTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQV3aXAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCCCC19425;
	Thu, 30 Apr 2026 01:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777511947;
	bh=6czsOlNriyalap6EeFnkX5tgFtke+HknraCqL0WxuNI=;
	h=From:To:Cc:Subject:Date:From;
	b=ZQV3aXAlpikEuzoE2QSEIEEH7BanzAKa27C4vM6on6FOu/quvXe9632AMzF9wycOH
	 oMKrBt9Fnz05dqtS0DBK5fMbiMiPZA0k4JIeFtjUhxB09W6h0Qqvrbw76k/5rJSOMU
	 0GqSbldRfCnKjm8QCoBXEVf6MUegQFoAYtv8+assh9Y9GBZhNJDrBH24krekphJ4i5
	 RopZpz7kAv/WKEX+7vbAs2jJPVEQnT2UQFmK7s4U+92GJMsuj7thb13GdxGq4awKvw
	 1Wa0Via3K/6vG5gRxINYsAo9cNq/CDJBg+wxD5pMnNspYIeRldp6oFD75NdNb00Md5
	 HRGylGPtLzX9w==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
Date: Wed, 29 Apr 2026 18:15:44 -0700
Message-ID: <20260430011544.31823-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 359D649BF98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6237-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chronox.de:url,copy.fail:url]

AF_ALG is almost completely unnecessary, and it exposes a massive attack
surface that hasn't been standing up to modern vulnerability discovery
tools.  The latest one even has its own website, providing a small
Python script that reliably roots most Linux distros: https://copy.fail/

This isn't sustainable, especially as LLMs have accelerated the rate the
vulnerabilities are coming in.  The effort that is being put into this
thing is vastly disproportional to the few programs that actually use
it, and those programs would be better served by userspace code anyway.

These issues have been noted in many mailing list discussions already.
But until now they haven't been reflected in the documentation or
kconfig menu itself, and the vulnerabilities are still coming in.

Let's go ahead and document the deprecation.

This isn't intended to change anything overnight.  After all, most Linux
distros won't be able to disable the kconfig options quite yet, mainly
because of iwd.  But this should create a bit more impetus for these
userspace programs to be fixed, and the documentation update should also
help prevent more users from appearing.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch is targeting crypto/master

 Documentation/crypto/userspace-if.rst | 82 ++++++++++++++++++++-------
 crypto/Kconfig                        | 69 ++++++++++++++++------
 2 files changed, 113 insertions(+), 38 deletions(-)

diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto/userspace-if.rst
index 021759198fe7..c39f5c79a5b7 100644
--- a/Documentation/crypto/userspace-if.rst
+++ b/Documentation/crypto/userspace-if.rst
@@ -2,30 +2,72 @@ User Space Interface
 ====================
 
 Introduction
 ------------
 
-The concepts of the kernel crypto API visible to kernel space is fully
-applicable to the user space interface as well. Therefore, the kernel
-crypto API high level discussion for the in-kernel use cases applies
-here as well.
-
-The major difference, however, is that user space can only act as a
-consumer and never as a provider of a transformation or cipher
-algorithm.
-
-The following covers the user space interface exported by the kernel
-crypto API. A working example of this description is libkcapi that can
-be obtained from [1]. That library can be used by user space
-applications that require cryptographic services from the kernel.
-
-Some details of the in-kernel kernel crypto API aspects do not apply to
-user space, however. This includes the difference between synchronous
-and asynchronous invocations. The user space API call is fully
-synchronous.
-
-[1] https://www.chronox.de/libkcapi/index.html
+AF_ALG provides unprivileged userspace programs access to arbitrary hash,
+symmetric cipher, AEAD, and RNG algorithms that are implemented in kernel-mode
+code.
+
+AF_ALG is insecure and is deprecated. Originally added to the kernel in 2010,
+most kernel developers now consider it to be a mistake.
+
+AF_ALG continues to be supported only for backwards compatibility. On systems
+where no programs using AF_ALG remain, the support for it should be disabled by
+disabling ``CONFIG_CRYPTO_USER_API_*``.
+
+Deprecation
+-----------
+
+AF_ALG was originally intended to provide userspace programs access to crypto
+accelerators that they wouldn't otherwise have access to.
+
+However, that capability turned out to not be useful on very many systems. More
+significantly, the actual implementation exposes a vastly greater amount of
+functionality than that. It actually provides access to all software algorithms.
+
+This includes arbitrary compositions of different algorithms created via a
+complex template system, as well as algorithms that only make sense as internal
+implementation details of other algorithms. It also includes full zero-copy
+support, which is difficult for the kernel to implement securely.
+
+Ultimately, these algorithms are just math computations. They use the same
+instructions that userspace programs already have access to, just accessed in a
+much more convoluted and less efficient way.
+
+Indeed, userspace code is nearly always what is being used anyway. These same
+algorithms are widely implemented in userspace crypto libraries.
+
+Meanwhile, AF_ALG hasn't been withstanding modern vulnerability discovery tools
+such as syzbot and large language models. It receives a steady stream of CVEs.
+Some of the examples include:
+
+- CVE-2026-31677
+- CVE-2026-31431 (https://copy.fail)
+- CVE-2025-38079
+- CVE-2025-37808
+- CVE-2024-26824
+- CVE-2022-48781
+- CVE-2019-8912
+- CVE-2018-14619
+- CVE-2017-18075
+- CVE-2017-17806
+- CVE-2017-17805
+- CVE-2016-10147
+- CVE-2015-8970
+- CVE-2015-3331
+- CVE-2014-9644
+- CVE-2013-7421
+- CVE-2011-4081
+
+It is recommended that, whenever possible, userspace programs be migrated to
+userspace crypto code (which again, is what is normally used anyway) and
+``CONFIG_CRYPTO_USER_API_*`` be disabled.  On systems that use SELinux, SELinux
+can also be used to restrict the use of AF_ALG to trusted programs.
+
+The remainder of this documentation provides the historical documentation for
+the deprecated AF_ALG interface.
 
 User Space API General Remarks
 ------------------------------
 
 The kernel crypto API is accessible from user space. Currently, the
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 103d1f58cb7c..6cd1c478d4be 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1278,48 +1278,72 @@ config CRYPTO_DF80090A
 	tristate
 	select CRYPTO_AES
 	select CRYPTO_CTR
 
 endmenu
-menu "Userspace interface"
+menu "Userspace interface (deprecated)"
 
 config CRYPTO_USER_API
 	tristate
 
 config CRYPTO_USER_API_HASH
-	tristate "Hash algorithms"
+	tristate "Hash algorithms (deprecated)"
 	depends on NET
 	select CRYPTO_HASH
 	select CRYPTO_USER_API
 	help
-	  Enable the userspace interface for hash algorithms.
+	  Enable the AF_ALG userspace interface for hash algorithms.  This
+	  provides unprivileged userspace programs access to arbitrary hash
+	  algorithms implemented in the kernel's privileged execution context.
 
-	  See Documentation/crypto/userspace-if.rst and
-	  https://www.chronox.de/libkcapi/html/index.html
+	  This interface is deprecated and is supported only for backwards
+	  compatibility.  It regularly has vulnerabilities, and the capabilities
+	  it provides are redundant with userspace crypto libraries.
+
+	  Enable this only if needed for support for a program that hasn't yet
+	  been converted to userspace crypto, for example iwd.
+
+	  See also Documentation/crypto/userspace-if.rst
 
 config CRYPTO_USER_API_SKCIPHER
-	tristate "Symmetric key cipher algorithms"
+	tristate "Symmetric key cipher algorithms (deprecated)"
 	depends on NET
 	select CRYPTO_SKCIPHER
 	select CRYPTO_USER_API
 	help
-	  Enable the userspace interface for symmetric key cipher algorithms.
+	  Enable the AF_ALG userspace interface for symmetric key algorithms.
+	  This provides unprivileged userspace programs access to arbitrary
+	  symmetric key algorithms implemented in the kernel's privileged
+	  execution context.
+
+	  This interface is deprecated and is supported only for backwards
+	  compatibility.  It regularly has vulnerabilities, and the capabilities
+	  it provides are redundant with userspace crypto libraries.
+
+	  Enable this only if needed for support for a program that hasn't yet
+	  been converted to userspace crypto, for example iwd, or cryptsetup
+	  with certain algorithms.
 
-	  See Documentation/crypto/userspace-if.rst and
-	  https://www.chronox.de/libkcapi/html/index.html
+	  See also Documentation/crypto/userspace-if.rst
 
 config CRYPTO_USER_API_RNG
-	tristate "RNG (random number generator) algorithms"
+	tristate "Random number generation algorithms (deprecated)"
 	depends on NET
 	select CRYPTO_RNG
 	select CRYPTO_USER_API
 	help
-	  Enable the userspace interface for RNG (random number generator)
-	  algorithms.
+	  Enable the AF_ALG userspace interface for random number generation
+	  (RNG) algorithms.  This provides unprivileged userspace programs
+	  access to arbitrary RNG algorithms implemented in the kernel's
+	  privileged execution context.
 
-	  See Documentation/crypto/userspace-if.rst and
-	  https://www.chronox.de/libkcapi/html/index.html
+	  This interface is deprecated and is supported only for backwards
+	  compatibility.  It regularly has vulnerabilities, and the capabilities
+	  it provides are redundant with userspace crypto libraries as well as
+	  the normal kernel RNG (e.g., /dev/urandom and getrandom(2)).
+
+	  See also Documentation/crypto/userspace-if.rst
 
 config CRYPTO_USER_API_RNG_CAVP
 	bool "Enable CAVP testing of DRBG"
 	depends on CRYPTO_USER_API_RNG && CRYPTO_DRBG
 	help
@@ -1330,20 +1354,29 @@ config CRYPTO_USER_API_RNG_CAVP
 
 	  This should only be enabled for CAVP testing. You should say
 	  no unless you know what this is.
 
 config CRYPTO_USER_API_AEAD
-	tristate "AEAD cipher algorithms"
+	tristate "AEAD cipher algorithms (deprecated)"
 	depends on NET
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
 	select CRYPTO_USER_API
 	help
-	  Enable the userspace interface for AEAD cipher algorithms.
+	  Enable the AF_ALG userspace interface for authenticated encryption
+	  with associated data (AEAD) algorithms.  This provides unprivileged
+	  userspace programs access to arbitrary AEAD algorithms implemented in
+	  the kernel's privileged execution context.
+
+	  This interface is deprecated and is supported only for backwards
+	  compatibility.  It regularly has vulnerabilities, and the capabilities
+	  it provides are redundant with userspace crypto libraries.
+
+	  Enable this only if needed for support for a program that hasn't yet
+	  been converted to userspace crypto, for example iwd.
 
-	  See Documentation/crypto/userspace-if.rst and
-	  https://www.chronox.de/libkcapi/html/index.html
+	  See also Documentation/crypto/userspace-if.rst
 
 config CRYPTO_USER_API_ENABLE_OBSOLETE
 	bool "Obsolete cryptographic algorithms"
 	depends on CRYPTO_USER_API
 	default y

base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
-- 
2.54.0


