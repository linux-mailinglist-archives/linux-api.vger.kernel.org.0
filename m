Return-Path: <linux-api+bounces-6171-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN/FGLei62kbPgAAu9opvQ
	(envelope-from <linux-api+bounces-6171-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:04:55 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FA46193D
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3360930D4852
	for <lists+linux-api@lfdr.de>; Fri, 24 Apr 2026 16:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701A3EBF18;
	Fri, 24 Apr 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlUIA49i"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AC3EB812;
	Fri, 24 Apr 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049509; cv=none; b=HMHeB87zw+s4VlscuThUYENhqI9RU7we5dnEYValVyzrELPx4k357XtuIlN/2F9Y+eA26kciK8tB0iJyPKxdyLOgQuIzL3no3V0oSNFKk689L0IKwRBiulYx4pZ7l8FH/5KQyOOtwwNLnqyIAD/HMvI6O4cohDD+xrkYMBkxkqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049509; c=relaxed/simple;
	bh=blgtcYiHkIzEH4T2Dor6pacRVEh8YEVie36R8Omhta0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFxgaiYjqc1zUAAv1tG2LfAsqj6+qvHb8+DWE0NdhyIsqd0CyowyZR3a9NbEmqiAKJAM56X1o2AUCnWd5/YKCEAZHACxgxxwmL5zeSHufJbkQ+ANslgeq9WFm52WqWUDsx1Ic+F0KM8VJn5LasHaRB/XrwmPpSY7aWKxcEKQ7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlUIA49i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21975C2BCB2;
	Fri, 24 Apr 2026 16:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049509;
	bh=blgtcYiHkIzEH4T2Dor6pacRVEh8YEVie36R8Omhta0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlUIA49i1fDM1JaOfVJSzQFCb9V5/83HhQavO9+qdKXyBjekGdJ2KIbz3OFsrNMt5
	 t9HsljP08zva/GsPwP2nJwovLEU6xLtnZeEjjLGWYVZ7iS0SOOXD2ITqlLdJJ6tpe1
	 NwGAPyW43RAixBwIEZz0Be085NEUYGRitNjl7cVHy+JEzxeR4VtAApKmw9SwidSm8e
	 LzIosMTsRj/WSATd4SJQywuFW0xev5pCxVckqtnSiGNSLPI1/QwR4OXDjlBBCeT8Yg
	 sfPsKczooL9fqan4tHN/6zv1y21xbNjNAsqLeO3xIJp8Jpa9/bYT8cmboCxmsoPnWa
	 Jk+U9dcFehE5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v3 4/9] tools/kapi: add kernel API specification extraction tool
Date: Fri, 24 Apr 2026 12:51:24 -0400
Message-ID: <20260424165130.2306833-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424165130.2306833-1-sashal@kernel.org>
References: <20260424165130.2306833-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 199FA46193D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6171-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]

The kapi tool extracts and renders kernel API specifications from
three input sources and emits them in one of three output formats:

  Input modes:
    --source PATH    parse kerneldoc blocks from a C source file or
                     directory
    --vmlinux PATH   decode the `.kapi_specs` ELF section from a
                     compiled kernel binary
    --debugfs PATH   read the spec dumps exposed under
                     /sys/kernel/debug/kapi/ on a running kernel

  Output formats: plain, json, rst

The tool is written in Rust and has no runtime dependencies beyond
cargo. It ships alongside the kernel to give documentation tools,
static analyzers, and IDE integrations a single entry point for
querying the spec data produced by the framework.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/dev-tools/kernel-api-spec.rst   |   15 +-
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.lock                         |  679 ++++
 tools/kapi/Cargo.toml                         |   20 +
 tools/kapi/Makefile                           |   33 +
 tools/kapi/README.md                          |   32 +
 tools/kapi/src/extractor/debugfs.rs           |  849 +++++
 tools/kapi/src/extractor/kerneldoc_parser.rs  | 2831 +++++++++++++++++
 tools/kapi/src/extractor/mod.rs               |  388 +++
 tools/kapi/src/extractor/source_parser.rs     |  415 +++
 .../src/extractor/vmlinux/binary_utils.rs     |  462 +++
 .../src/extractor/vmlinux/magic_finder.rs     |  115 +
 tools/kapi/src/extractor/vmlinux/mod.rs       |  857 +++++
 tools/kapi/src/formatter/json.rs              |  634 ++++
 tools/kapi/src/formatter/mod.rs               |  122 +
 tools/kapi/src/formatter/plain.rs             |  646 ++++
 tools/kapi/src/formatter/rst.rs               |  726 +++++
 tools/kapi/src/main.rs                        |  123 +
 18 files changed, 8942 insertions(+), 9 deletions(-)
 create mode 100644 tools/kapi/.gitignore
 create mode 100644 tools/kapi/Cargo.lock
 create mode 100644 tools/kapi/Cargo.toml
 create mode 100644 tools/kapi/Makefile
 create mode 100644 tools/kapi/README.md
 create mode 100644 tools/kapi/src/extractor/debugfs.rs
 create mode 100644 tools/kapi/src/extractor/kerneldoc_parser.rs
 create mode 100644 tools/kapi/src/extractor/mod.rs
 create mode 100644 tools/kapi/src/extractor/source_parser.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/binary_utils.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/magic_finder.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/mod.rs
 create mode 100644 tools/kapi/src/formatter/json.rs
 create mode 100644 tools/kapi/src/formatter/mod.rs
 create mode 100644 tools/kapi/src/formatter/plain.rs
 create mode 100644 tools/kapi/src/formatter/rst.rs
 create mode 100644 tools/kapi/src/main.rs

diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
index 49d53ba2e27f7..dace2e0bb86c7 100644
--- a/Documentation/dev-tools/kernel-api-spec.rst
+++ b/Documentation/dev-tools/kernel-api-spec.rst
@@ -30,7 +30,9 @@ The framework aims to:
    common programming errors during development and testing.
 
 3. **Support Tooling**: Export API specifications in machine-readable formats for
-   use by static analyzers, documentation generators, and development tools.
+   use by static analyzers, documentation generators, and development tools. The
+   ``kapi`` tool (see `The kapi Tool`_) provides comprehensive extraction and
+   formatting capabilities.
 
 4. **Formalize Contracts**: Explicitly document API contracts including parameter
    constraints, execution contexts, locking requirements, and side effects.
@@ -538,15 +540,10 @@ Modern IDEs can use the specification data for:
 - Context validation
 - Error code documentation
 
-Testing Framework
------------------
-
-The framework includes test helpers::
+Example IDE integration::
 
-    #ifdef CONFIG_KAPI_TESTING
-    /* Verify API behaves according to specification */
-    kapi_test_api("kmalloc", test_cases);
-    #endif
+    # Generate IDE completion data
+    $ kapi --format json > .vscode/kernel-apis.json
 
 Best Practices
 ==============
diff --git a/tools/kapi/.gitignore b/tools/kapi/.gitignore
new file mode 100644
index 0000000000000..1390bfc12686c
--- /dev/null
+++ b/tools/kapi/.gitignore
@@ -0,0 +1,4 @@
+# Rust build artifacts
+/target/
+**/*.rs.bk
+
diff --git a/tools/kapi/Cargo.lock b/tools/kapi/Cargo.lock
new file mode 100644
index 0000000000000..23d4ef8b910d2
--- /dev/null
+++ b/tools/kapi/Cargo.lock
@@ -0,0 +1,679 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 4
+
+[[package]]
+name = "aho-corasick"
+version = "1.1.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301"
+dependencies = [
+ "memchr",
+]
+
+[[package]]
+name = "anstream"
+version = "1.0.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "824a212faf96e9acacdbd09febd34438f8f711fb84e09a8916013cd7815ca28d"
+dependencies = [
+ "anstyle",
+ "anstyle-parse",
+ "anstyle-query",
+ "anstyle-wincon",
+ "colorchoice",
+ "is_terminal_polyfill",
+ "utf8parse",
+]
+
+[[package]]
+name = "anstyle"
+version = "1.0.14"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "940b3a0ca603d1eade50a4846a2afffd5ef57a9feac2c0e2ec2e14f9ead76000"
+
+[[package]]
+name = "anstyle-parse"
+version = "1.0.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "52ce7f38b242319f7cabaa6813055467063ecdc9d355bbb4ce0c68908cd8130e"
+dependencies = [
+ "utf8parse",
+]
+
+[[package]]
+name = "anstyle-query"
+version = "1.1.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "40c48f72fd53cd289104fc64099abca73db4166ad86ea0b4341abe65af83dadc"
+dependencies = [
+ "windows-sys",
+]
+
+[[package]]
+name = "anstyle-wincon"
+version = "3.0.11"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "291e6a250ff86cd4a820112fb8898808a366d8f9f58ce16d1f538353ad55747d"
+dependencies = [
+ "anstyle",
+ "once_cell_polyfill",
+ "windows-sys",
+]
+
+[[package]]
+name = "anyhow"
+version = "1.0.102"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7f202df86484c868dbad7eaa557ef785d5c66295e41b460ef922eca0723b842c"
+
+[[package]]
+name = "bitflags"
+version = "2.11.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c4512299f36f043ab09a583e57bceb5a5aab7a73db1805848e8fef3c9e8c78b3"
+
+[[package]]
+name = "cfg-if"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801"
+
+[[package]]
+name = "clap"
+version = "4.6.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1ddb117e43bbf7dacf0a4190fef4d345b9bad68dfc649cb349e7d17d28428e51"
+dependencies = [
+ "clap_builder",
+ "clap_derive",
+]
+
+[[package]]
+name = "clap_builder"
+version = "4.6.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "714a53001bf66416adb0e2ef5ac857140e7dc3a0c48fb28b2f10762fc4b5069f"
+dependencies = [
+ "anstream",
+ "anstyle",
+ "clap_lex",
+ "strsim",
+]
+
+[[package]]
+name = "clap_derive"
+version = "4.6.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f2ce8604710f6733aa641a2b3731eaa1e8b3d9973d5e3565da11800813f997a9"
+dependencies = [
+ "heck",
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "clap_lex"
+version = "1.1.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c8d4a3bb8b1e0c1050499d1815f5ab16d04f0959b233085fb31653fbfc9d98f9"
+
+[[package]]
+name = "colorchoice"
+version = "1.0.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1d07550c9036bf2ae0c684c4297d503f838287c83c53686d05370d0e139ae570"
+
+[[package]]
+name = "equivalent"
+version = "1.0.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f"
+
+[[package]]
+name = "errno"
+version = "0.3.14"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb"
+dependencies = [
+ "libc",
+ "windows-sys",
+]
+
+[[package]]
+name = "fastrand"
+version = "2.4.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9f1f227452a390804cdb637b74a86990f2a7d7ba4b7d5693aac9b4dd6defd8d6"
+
+[[package]]
+name = "foldhash"
+version = "0.1.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2"
+
+[[package]]
+name = "getrandom"
+version = "0.4.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0de51e6874e94e7bf76d726fc5d13ba782deca734ff60d5bb2fb2607c7406555"
+dependencies = [
+ "cfg-if",
+ "libc",
+ "r-efi",
+ "wasip2",
+ "wasip3",
+]
+
+[[package]]
+name = "goblin"
+version = "0.10.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "983a6aafb3b12d4c41ea78d39e189af4298ce747353945ff5105b54a056e5cd9"
+dependencies = [
+ "log",
+ "plain",
+ "scroll",
+]
+
+[[package]]
+name = "hashbrown"
+version = "0.15.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1"
+dependencies = [
+ "foldhash",
+]
+
+[[package]]
+name = "hashbrown"
+version = "0.17.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "4f467dd6dccf739c208452f8014c75c18bb8301b050ad1cfb27153803edb0f51"
+
+[[package]]
+name = "heck"
+version = "0.5.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea"
+
+[[package]]
+name = "id-arena"
+version = "2.3.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3d3067d79b975e8844ca9eb072e16b31c3c1c36928edf9c6789548c524d0d954"
+
+[[package]]
+name = "indexmap"
+version = "2.14.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9"
+dependencies = [
+ "equivalent",
+ "hashbrown 0.17.0",
+ "serde",
+ "serde_core",
+]
+
+[[package]]
+name = "is_terminal_polyfill"
+version = "1.70.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a6cb138bb79a146c1bd460005623e142ef0181e3d0219cb493e02f7d08a35695"
+
+[[package]]
+name = "itoa"
+version = "1.0.18"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682"
+
+[[package]]
+name = "kapi"
+version = "0.1.0"
+dependencies = [
+ "anyhow",
+ "clap",
+ "goblin",
+ "regex",
+ "serde",
+ "serde_json",
+ "tempfile",
+ "walkdir",
+]
+
+[[package]]
+name = "leb128fmt"
+version = "0.1.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "09edd9e8b54e49e587e4f6295a7d29c3ea94d469cb40ab8ca70b288248a81db2"
+
+[[package]]
+name = "libc"
+version = "0.2.185"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "52ff2c0fe9bc6cb6b14a0592c2ff4fa9ceb83eea9db979b0487cd054946a2b8f"
+
+[[package]]
+name = "linux-raw-sys"
+version = "0.12.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "32a66949e030da00e8c7d4434b251670a91556f4144941d37452769c25d58a53"
+
+[[package]]
+name = "log"
+version = "0.4.29"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5e5032e24019045c762d3c0f28f5b6b8bbf38563a65908389bf7978758920897"
+
+[[package]]
+name = "memchr"
+version = "2.8.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f8ca58f447f06ed17d5fc4043ce1b10dd205e060fb3ce5b979b8ed8e59ff3f79"
+
+[[package]]
+name = "once_cell"
+version = "1.21.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
+
+[[package]]
+name = "once_cell_polyfill"
+version = "1.70.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "384b8ab6d37215f3c5301a95a4accb5d64aa607f1fcb26a11b5303878451b4fe"
+
+[[package]]
+name = "plain"
+version = "0.2.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b4596b6d070b27117e987119b4dac604f3c58cfb0b191112e24771b2faeac1a6"
+
+[[package]]
+name = "prettyplease"
+version = "0.2.37"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "479ca8adacdd7ce8f1fb39ce9ecccbfe93a3f1344b3d0d97f20bc0196208f62b"
+dependencies = [
+ "proc-macro2",
+ "syn",
+]
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.106"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934"
+dependencies = [
+ "unicode-ident",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.45"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "41f2619966050689382d2b44f664f4bc593e129785a36d6ee376ddf37259b924"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "r-efi"
+version = "6.0.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf"
+
+[[package]]
+name = "regex"
+version = "1.12.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e10754a14b9137dd7b1e3e5b0493cc9171fdd105e0ab477f51b72e7f3ac0e276"
+dependencies = [
+ "aho-corasick",
+ "memchr",
+ "regex-automata",
+ "regex-syntax",
+]
+
+[[package]]
+name = "regex-automata"
+version = "0.4.14"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "6e1dd4122fc1595e8162618945476892eefca7b88c52820e74af6262213cae8f"
+dependencies = [
+ "aho-corasick",
+ "memchr",
+ "regex-syntax",
+]
+
+[[package]]
+name = "regex-syntax"
+version = "0.8.10"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "dc897dd8d9e8bd1ed8cdad82b5966c3e0ecae09fb1907d58efaa013543185d0a"
+
+[[package]]
+name = "rustix"
+version = "1.1.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b6fe4565b9518b83ef4f91bb47ce29620ca828bd32cb7e408f0062e9930ba190"
+dependencies = [
+ "bitflags",
+ "errno",
+ "libc",
+ "linux-raw-sys",
+ "windows-sys",
+]
+
+[[package]]
+name = "same-file"
+version = "1.0.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "93fc1dc3aaa9bfed95e02e6eadabb4baf7e3078b0bd1b4d7b6b0b68378900502"
+dependencies = [
+ "winapi-util",
+]
+
+[[package]]
+name = "scroll"
+version = "0.13.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c1257cd4248b4132760d6524d6dda4e053bc648c9070b960929bf50cfb1e7add"
+dependencies = [
+ "scroll_derive",
+]
+
+[[package]]
+name = "scroll_derive"
+version = "0.13.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ed76efe62313ab6610570951494bdaa81568026e0318eaa55f167de70eeea67d"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "semver"
+version = "1.0.28"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd"
+
+[[package]]
+name = "serde"
+version = "1.0.228"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e"
+dependencies = [
+ "serde_core",
+ "serde_derive",
+]
+
+[[package]]
+name = "serde_core"
+version = "1.0.228"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
+dependencies = [
+ "serde_derive",
+]
+
+[[package]]
+name = "serde_derive"
+version = "1.0.228"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "serde_json"
+version = "1.0.149"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "83fc039473c5595ace860d8c4fafa220ff474b3fc6bfdb4293327f1a37e94d86"
+dependencies = [
+ "itoa",
+ "memchr",
+ "serde",
+ "serde_core",
+ "zmij",
+]
+
+[[package]]
+name = "strsim"
+version = "0.11.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
+
+[[package]]
+name = "syn"
+version = "2.0.117"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e665b8803e7b1d2a727f4023456bbbbe74da67099c585258af0ad9c5013b9b99"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "tempfile"
+version = "3.27.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "32497e9a4c7b38532efcdebeef879707aa9f794296a4f0244f6f69e9bc8574bd"
+dependencies = [
+ "fastrand",
+ "getrandom",
+ "once_cell",
+ "rustix",
+ "windows-sys",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.24"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75"
+
+[[package]]
+name = "unicode-xid"
+version = "0.2.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853"
+
+[[package]]
+name = "utf8parse"
+version = "0.2.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "06abde3611657adf66d383f00b093d7faecc7fa57071cce2578660c9f1010821"
+
+[[package]]
+name = "walkdir"
+version = "2.5.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "29790946404f91d9c5d06f9874efddea1dc06c5efe94541a7d6863108e3a5e4b"
+dependencies = [
+ "same-file",
+ "winapi-util",
+]
+
+[[package]]
+name = "wasip2"
+version = "1.0.3+wasi-0.2.9"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "20064672db26d7cdc89c7798c48a0fdfac8213434a1186e5ef29fd560ae223d6"
+dependencies = [
+ "wit-bindgen 0.57.1",
+]
+
+[[package]]
+name = "wasip3"
+version = "0.4.0+wasi-0.3.0-rc-2026-01-06"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5428f8bf88ea5ddc08faddef2ac4a67e390b88186c703ce6dbd955e1c145aca5"
+dependencies = [
+ "wit-bindgen 0.51.0",
+]
+
+[[package]]
+name = "wasm-encoder"
+version = "0.244.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "990065f2fe63003fe337b932cfb5e3b80e0b4d0f5ff650e6985b1048f62c8319"
+dependencies = [
+ "leb128fmt",
+ "wasmparser",
+]
+
+[[package]]
+name = "wasm-metadata"
+version = "0.244.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "bb0e353e6a2fbdc176932bbaab493762eb1255a7900fe0fea1a2f96c296cc909"
+dependencies = [
+ "anyhow",
+ "indexmap",
+ "wasm-encoder",
+ "wasmparser",
+]
+
+[[package]]
+name = "wasmparser"
+version = "0.244.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "47b807c72e1bac69382b3a6fb3dbe8ea4c0ed87ff5629b8685ae6b9a611028fe"
+dependencies = [
+ "bitflags",
+ "hashbrown 0.15.5",
+ "indexmap",
+ "semver",
+]
+
+[[package]]
+name = "winapi-util"
+version = "0.1.11"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c2a7b1c03c876122aa43f3020e6c3c3ee5c05081c9a00739faf7503aeba10d22"
+dependencies = [
+ "windows-sys",
+]
+
+[[package]]
+name = "windows-link"
+version = "0.2.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5"
+
+[[package]]
+name = "windows-sys"
+version = "0.61.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc"
+dependencies = [
+ "windows-link",
+]
+
+[[package]]
+name = "wit-bindgen"
+version = "0.51.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5"
+dependencies = [
+ "wit-bindgen-rust-macro",
+]
+
+[[package]]
+name = "wit-bindgen"
+version = "0.57.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1ebf944e87a7c253233ad6766e082e3cd714b5d03812acc24c318f549614536e"
+
+[[package]]
+name = "wit-bindgen-core"
+version = "0.51.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ea61de684c3ea68cb082b7a88508a8b27fcc8b797d738bfc99a82facf1d752dc"
+dependencies = [
+ "anyhow",
+ "heck",
+ "wit-parser",
+]
+
+[[package]]
+name = "wit-bindgen-rust"
+version = "0.51.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b7c566e0f4b284dd6561c786d9cb0142da491f46a9fbed79ea69cdad5db17f21"
+dependencies = [
+ "anyhow",
+ "heck",
+ "indexmap",
+ "prettyplease",
+ "syn",
+ "wasm-metadata",
+ "wit-bindgen-core",
+ "wit-component",
+]
+
+[[package]]
+name = "wit-bindgen-rust-macro"
+version = "0.51.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0c0f9bfd77e6a48eccf51359e3ae77140a7f50b1e2ebfe62422d8afdaffab17a"
+dependencies = [
+ "anyhow",
+ "prettyplease",
+ "proc-macro2",
+ "quote",
+ "syn",
+ "wit-bindgen-core",
+ "wit-bindgen-rust",
+]
+
+[[package]]
+name = "wit-component"
+version = "0.244.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9d66ea20e9553b30172b5e831994e35fbde2d165325bec84fc43dbf6f4eb9cb2"
+dependencies = [
+ "anyhow",
+ "bitflags",
+ "indexmap",
+ "log",
+ "serde",
+ "serde_derive",
+ "serde_json",
+ "wasm-encoder",
+ "wasm-metadata",
+ "wasmparser",
+ "wit-parser",
+]
+
+[[package]]
+name = "wit-parser"
+version = "0.244.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ecc8ac4bc1dc3381b7f59c34f00b67e18f910c2c0f50015669dde7def656a736"
+dependencies = [
+ "anyhow",
+ "id-arena",
+ "indexmap",
+ "log",
+ "semver",
+ "serde",
+ "serde_derive",
+ "serde_json",
+ "unicode-xid",
+ "wasmparser",
+]
+
+[[package]]
+name = "zmij"
+version = "1.0.21"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
diff --git a/tools/kapi/Cargo.toml b/tools/kapi/Cargo.toml
new file mode 100644
index 0000000000000..3dd36fe412c21
--- /dev/null
+++ b/tools/kapi/Cargo.toml
@@ -0,0 +1,20 @@
+[package]
+name = "kapi"
+version = "0.1.0"
+edition = "2021"
+rust-version = "1.78"
+authors = ["Sasha Levin <sashal@kernel.org>"]
+description = "Tool for extracting and displaying kernel API specifications"
+license = "GPL-2.0"
+
+[dependencies]
+goblin = "0.10"
+clap = { version = "4.4", features = ["derive"] }
+anyhow = "1.0"
+serde = { version = "1.0", features = ["derive"] }
+serde_json = "1.0"
+regex = "1.10"
+walkdir = "2.4"
+
+[dev-dependencies]
+tempfile = "3.8"
diff --git a/tools/kapi/Makefile b/tools/kapi/Makefile
new file mode 100644
index 0000000000000..d4234538e4eee
--- /dev/null
+++ b/tools/kapi/Makefile
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile wrapper for the kapi tool (Rust userspace binary).
+#
+# See Documentation/dev-tools/kernel-api-spec.rst for details.
+
+PREFIX ?= /usr/local
+
+.PHONY: all build release debug clean install test fmt clippy
+
+all: release
+
+release:
+	cargo build --release
+
+build: release
+
+debug:
+	cargo build
+
+test:
+	cargo test
+
+fmt:
+	cargo fmt --all -- --check
+
+clippy:
+	cargo clippy --all-targets --all-features -- -D warnings
+
+clean:
+	cargo clean
+
+install: release
+	install -D -m 0755 target/release/kapi $(DESTDIR)$(PREFIX)/bin/kapi
diff --git a/tools/kapi/README.md b/tools/kapi/README.md
new file mode 100644
index 0000000000000..c0880b8abdc83
--- /dev/null
+++ b/tools/kapi/README.md
@@ -0,0 +1,32 @@
+# kapi — Kernel API Specification Extractor
+
+Userspace utility that extracts and displays kernel API specifications from
+three sources:
+
+- `--source PATH` — parse kerneldoc blocks in a C source file or tree
+- `--vmlinux PATH` — decode the `.kapi_specs` ELF section of a compiled vmlinux
+- `--debugfs PATH` — read the live specs from `/sys/kernel/debug/kapi/` on a
+  running kernel (defaults to `/sys/kernel/debug` if no path is given)
+
+Output formats: `plain` (default), `json`, `rst`.
+
+See `Documentation/dev-tools/kernel-api-spec.rst` for the full user guide,
+including the kerneldoc DSL reference and the surrounding framework design.
+
+## Build
+
+```
+make -C tools/kapi
+```
+
+(wraps `cargo build --release`; the binary is produced at
+`tools/kapi/target/release/kapi`).
+
+## Usage
+
+```
+tools/kapi/target/release/kapi --help
+tools/kapi/target/release/kapi --source fs/open.c sys_open
+tools/kapi/target/release/kapi --vmlinux vmlinux -f json
+tools/kapi/target/release/kapi --debugfs /sys/kernel/debug
+```
diff --git a/tools/kapi/src/extractor/debugfs.rs b/tools/kapi/src/extractor/debugfs.rs
new file mode 100644
index 0000000000000..a1b8157113eae
--- /dev/null
+++ b/tools/kapi/src/extractor/debugfs.rs
@@ -0,0 +1,849 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use crate::formatter::OutputFormatter;
+use anyhow::{bail, Context, Result};
+use serde::Deserialize;
+use std::fs;
+use std::io::Write;
+use std::path::PathBuf;
+
+use super::{
+    display_api_spec, ApiExtractor, ApiSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec,
+    ParamSpec, ReturnSpec,
+};
+
+// Schema matching what kapi_export_json() in the kernel emits.  The kernel
+// serialises several enum-like fields as hex strings ("0x%x") or token
+// strings ("exact", "process"); we keep them as Option<String> here and
+// interpret them during conversion.
+#[derive(Deserialize)]
+struct KernelApiJson {
+    name: String,
+    #[serde(default)]
+    api_type: Option<String>,
+    #[serde(default)]
+    version: Option<u32>,
+    #[serde(default)]
+    description: Option<String>,
+    #[serde(default)]
+    long_description: Option<String>,
+    #[serde(default)]
+    context_flags: Option<String>,
+    #[serde(default)]
+    examples: Option<String>,
+    #[serde(default)]
+    notes: Option<String>,
+    #[serde(default)]
+    capabilities: Option<Vec<KernelCapabilityJson>>,
+    #[serde(default)]
+    parameters: Option<Vec<KernelParamJson>>,
+    #[serde(default)]
+    errors: Option<Vec<KernelErrorJson>>,
+    #[serde(default, rename = "return")]
+    return_spec: Option<KernelReturnJson>,
+    #[serde(default)]
+    locks: Option<Vec<KernelLockJson>>,
+    #[serde(default)]
+    constraints: Option<Vec<KernelConstraintJson>>,
+    #[serde(default)]
+    signals: Option<Vec<KernelSignalJson>>,
+    #[serde(default)]
+    side_effects: Option<Vec<KernelSideEffectJson>>,
+}
+
+#[derive(Deserialize)]
+struct KernelConstraintJson {
+    name: String,
+    #[serde(default)]
+    description: Option<String>,
+    #[serde(default)]
+    expression: Option<String>,
+}
+
+#[derive(Deserialize)]
+struct KernelSignalJson {
+    #[serde(default)]
+    signal_num: i32,
+    #[serde(default)]
+    signal_name: Option<String>,
+    #[serde(default)]
+    direction: Option<String>,
+    #[serde(default)]
+    action: u32,
+    #[serde(default)]
+    target: Option<String>,
+    #[serde(default)]
+    condition: Option<String>,
+    #[serde(default)]
+    description: Option<String>,
+    #[serde(default)]
+    restartable: bool,
+    #[serde(default)]
+    sa_flags_required: Option<String>,
+    #[serde(default)]
+    sa_flags_forbidden: Option<String>,
+    #[serde(default)]
+    error_on_signal: i32,
+    #[serde(default)]
+    transform_to: i32,
+    #[serde(default)]
+    timing: Option<String>,
+    #[serde(default)]
+    priority: u32,
+    #[serde(default)]
+    interruptible: bool,
+    #[serde(default)]
+    queue_behavior: Option<String>,
+    #[serde(default)]
+    state_required: Option<String>,
+    #[serde(default)]
+    state_forbidden: Option<String>,
+}
+
+#[derive(Deserialize)]
+#[allow(dead_code)]
+struct KernelSideEffectJson {
+    #[serde(rename = "type", default)]
+    type_hex: Option<String>,
+    #[serde(default)]
+    target: Option<String>,
+    #[serde(default)]
+    condition: Option<String>,
+    #[serde(default)]
+    description: Option<String>,
+    #[serde(default)]
+    reversible: bool,
+}
+
+#[derive(Deserialize)]
+#[allow(dead_code)]
+struct KernelParamJson {
+    name: String,
+    #[serde(rename = "type", default)]
+    type_name: Option<String>,
+    #[serde(default)]
+    type_class: Option<String>,
+    #[serde(default)]
+    description: Option<String>,
+    #[serde(default)]
+    flags: Option<String>,
+}
+
+#[derive(Deserialize)]
+struct KernelErrorJson {
+    #[serde(rename = "code")]
+    error_code: i32,
+    #[serde(default)]
+    name: Option<String>,
+    #[serde(default)]
+    condition: Option<String>,
+    #[serde(default)]
+    description: Option<String>,
+}
+
+#[derive(Deserialize)]
+#[allow(dead_code)]
+struct KernelReturnJson {
+    #[serde(rename = "type", default)]
+    type_name: Option<String>,
+    #[serde(default)]
+    type_class: Option<String>,
+    #[serde(default)]
+    check_type: Option<String>,
+    #[serde(default)]
+    description: Option<String>,
+    #[serde(default)]
+    success_value: Option<i64>,
+    #[serde(default)]
+    success_min: Option<i64>,
+    #[serde(default)]
+    success_max: Option<i64>,
+}
+
+#[derive(Deserialize)]
+struct KernelLockJson {
+    name: String,
+    #[serde(rename = "type", default)]
+    lock_type: Option<String>,
+    #[serde(default)]
+    scope: Option<String>,
+    #[serde(default)]
+    description: Option<String>,
+}
+
+#[derive(Deserialize)]
+struct KernelCapabilityJson {
+    capability: i32,
+    name: String,
+    action: String,
+    allows: String,
+    without_cap: String,
+    check_condition: Option<String>,
+    priority: Option<u8>,
+    alternatives: Option<Vec<i32>>,
+}
+
+/// Extractor for kernel API specifications from debugfs
+pub struct DebugfsExtractor {
+    debugfs_path: PathBuf,
+}
+
+impl DebugfsExtractor {
+    /// Create a new debugfs extractor with the specified debugfs path
+    pub fn new(debugfs_path: Option<String>) -> Result<Self> {
+        let path = match debugfs_path {
+            Some(p) => PathBuf::from(p),
+            None => PathBuf::from("/sys/kernel/debug"),
+        };
+
+        // Check if the debugfs path exists
+        if !path.exists() {
+            bail!("Debugfs path does not exist: {}", path.display());
+        }
+
+        // Check if kapi directory exists
+        let kapi_path = path.join("kapi");
+        if !kapi_path.exists() {
+            bail!(
+                "Kernel API debugfs interface not found at: {}",
+                kapi_path.display()
+            );
+        }
+
+        Ok(Self { debugfs_path: path })
+    }
+
+    /// Parse the list file to get all available API names
+    fn parse_list_file(&self) -> Result<Vec<String>> {
+        let list_path = self.debugfs_path.join("kapi/list");
+        let content = fs::read_to_string(&list_path)
+            .with_context(|| format!("Failed to read {}", list_path.display()))?;
+
+        let mut apis = Vec::new();
+        let mut in_list = false;
+
+        for line in content.lines() {
+            if line.contains("===") {
+                in_list = true;
+                continue;
+            }
+
+            if in_list && line.starts_with("Total:") {
+                break;
+            }
+
+            if in_list && !line.trim().is_empty() {
+                // Extract API name from lines like "sys_read - Read from a file descriptor"
+                if let Some(name) = line.split(" - ").next() {
+                    apis.push(name.trim().to_string());
+                }
+            }
+        }
+
+        Ok(apis)
+    }
+
+    /// Convert context flags (emitted by the kernel as a hex string like
+    /// "0x21") into the token list consumed by the formatter.
+    fn parse_context_flags(flags: &str) -> Vec<String> {
+        let mut result = Vec::new();
+        let bits = flags
+            .strip_prefix("0x")
+            .or_else(|| flags.strip_prefix("0X"))
+            .unwrap_or(flags);
+        let Ok(flags) = u32::from_str_radix(bits, 16) else {
+            return result;
+        };
+
+        // These values should match KAPI_CTX_* flags from kernel
+        if flags & (1 << 0) != 0 {
+            result.push("PROCESS".to_string());
+        }
+        if flags & (1 << 1) != 0 {
+            result.push("SOFTIRQ".to_string());
+        }
+        if flags & (1 << 2) != 0 {
+            result.push("HARDIRQ".to_string());
+        }
+        if flags & (1 << 3) != 0 {
+            result.push("NMI".to_string());
+        }
+        if flags & (1 << 4) != 0 {
+            result.push("ATOMIC".to_string());
+        }
+        if flags & (1 << 5) != 0 {
+            result.push("SLEEPABLE".to_string());
+        }
+        if flags & (1 << 6) != 0 {
+            result.push("PREEMPT_DISABLED".to_string());
+        }
+        if flags & (1 << 7) != 0 {
+            result.push("IRQ_DISABLED".to_string());
+        }
+
+        result
+    }
+
+    /// Parse a hex-string like "0x123" into u32, returning 0 on failure.
+    fn parse_hex_u32(value: &str) -> u32 {
+        let bits = value
+            .strip_prefix("0x")
+            .or_else(|| value.strip_prefix("0X"))
+            .unwrap_or(value);
+        u32::from_str_radix(bits, 16).unwrap_or(0)
+    }
+
+    /// Map the check-type token emitted by the kernel
+    /// (return_check_type_to_string) back to the u32 enum the formatter wants.
+    fn parse_check_type(token: &str) -> u32 {
+        match token {
+            "exact" => 0,
+            "range" => 1,
+            "error_check" => 2,
+            "file_descriptor" => 3,
+            "custom" => 4,
+            "no_return" => 5,
+            _ => 0,
+        }
+    }
+
+    /// Map the lock-type token emitted by the kernel (lock_type_to_string).
+    fn parse_lock_type(token: &str) -> u32 {
+        match token {
+            "none" => 0,
+            "mutex" => 1,
+            "spinlock" => 2,
+            "rwlock" => 3,
+            "seqlock" => 4,
+            "rcu" => 5,
+            "semaphore" => 6,
+            "custom" => 7,
+            _ => 0,
+        }
+    }
+
+    /// Map the lock-scope token emitted by the kernel (lock_scope_to_string).
+    fn parse_lock_scope(token: &str) -> u32 {
+        match token {
+            "internal" => 0,
+            "acquires" => 1,
+            "releases" => 2,
+            "caller_held" => 3,
+            _ => 0,
+        }
+    }
+
+    /// Map the signal-timing token (e.g. "during") back to the u32 enum that
+    /// the source-side parser produces. Mirrors
+    /// KerneldocParser::parse_signal_timing in kerneldoc_parser.rs so the
+    /// debugfs path and the source path agree.
+    fn parse_signal_timing(token: &str) -> u32 {
+        match token.trim().to_ascii_lowercase().as_str() {
+            "before" => 0,
+            "during" => 1,
+            "after" => 2,
+            _ => 0,
+        }
+    }
+
+    /// Convert capability action from kernel representation
+    fn parse_capability_action(action: &str) -> String {
+        match action {
+            "bypass_check" => "Bypasses check".to_string(),
+            "increase_limit" => "Increases limit".to_string(),
+            "override_restriction" => "Overrides restriction".to_string(),
+            "grant_permission" => "Grants permission".to_string(),
+            "modify_behavior" => "Modifies behavior".to_string(),
+            "access_resource" => "Allows resource access".to_string(),
+            "perform_operation" => "Allows operation".to_string(),
+            _ => action.to_string(),
+        }
+    }
+
+    /// Try to parse as JSON first
+    fn try_parse_json(&self, content: &str) -> Option<ApiSpec> {
+        let json_data: KernelApiJson = serde_json::from_str(content).ok()?;
+
+        let mut spec = ApiSpec {
+            name: json_data.name,
+            api_type: json_data.api_type.unwrap_or_else(|| "syscall".to_string()),
+            description: json_data.description,
+            long_description: json_data.long_description,
+            version: json_data.version.map(|v| v.to_string()),
+            context_flags: json_data
+                .context_flags
+                .as_deref()
+                .map_or_else(Vec::new, Self::parse_context_flags),
+            param_count: None,
+            error_count: None,
+            examples: json_data.examples,
+            notes: json_data.notes,
+            subsystem: None,   // Not in current JSON format
+            sysfs_path: None,  // Not in current JSON format
+            permissions: None, // Not in current JSON format
+            capabilities: vec![],
+            parameters: vec![],
+            return_spec: None,
+            errors: vec![],
+            signals: vec![],
+            signal_masks: vec![],
+            side_effects: vec![],
+            state_transitions: vec![],
+            constraints: vec![],
+            locks: vec![],
+            struct_specs: vec![],
+        };
+
+        // Convert capabilities
+        if let Some(caps) = json_data.capabilities {
+            for cap in caps {
+                spec.capabilities.push(CapabilitySpec {
+                    capability: cap.capability,
+                    name: cap.name,
+                    action: Self::parse_capability_action(&cap.action),
+                    allows: cap.allows,
+                    without_cap: cap.without_cap,
+                    check_condition: cap.check_condition,
+                    priority: cap.priority,
+                    alternatives: cap.alternatives.unwrap_or_default(),
+                });
+            }
+        }
+
+        // Convert parameters.  kapi_json_str() passes through trailing
+        // whitespace that the macro generator may leave on description
+        // strings; trim here to match --source / --vmlinux.
+        if let Some(params) = json_data.parameters {
+            for (i, p) in params.into_iter().enumerate() {
+                let flags = p.flags.as_deref().map_or(0, Self::parse_hex_u32);
+                spec.parameters.push(ParamSpec {
+                    index: i as u32,
+                    name: p.name,
+                    type_name: p.type_name.unwrap_or_default(),
+                    description: p
+                        .description
+                        .map(|s| s.trim_end().to_string())
+                        .unwrap_or_default(),
+                    flags,
+                    param_type: 0,
+                    constraint_type: 0,
+                    constraint: None,
+                    min_value: None,
+                    max_value: None,
+                    valid_mask: None,
+                    enum_values: vec![],
+                    size: None,
+                    alignment: None,
+                    size_param_idx: None,
+                });
+            }
+            spec.param_count = Some(spec.parameters.len() as u32);
+        }
+
+        // Convert errors
+        if let Some(errors) = json_data.errors {
+            for e in errors {
+                spec.errors.push(ErrorSpec {
+                    error_code: e.error_code,
+                    name: e.name.unwrap_or_default(),
+                    condition: e.condition.unwrap_or_default(),
+                    description: e.description.unwrap_or_default(),
+                });
+            }
+            spec.error_count = Some(spec.errors.len() as u32);
+        }
+
+        // Convert return spec
+        if let Some(ret) = json_data.return_spec {
+            let check_type = ret.check_type.as_deref().map_or(0, Self::parse_check_type);
+            spec.return_spec = Some(ReturnSpec {
+                type_name: ret.type_name.unwrap_or_default(),
+                description: ret.description.unwrap_or_default(),
+                return_type: 0,
+                check_type,
+                success_value: ret.success_value,
+                success_min: ret.success_min,
+                success_max: ret.success_max,
+                error_values: vec![],
+            });
+        }
+
+        // Convert locks
+        if let Some(locks) = json_data.locks {
+            for l in locks {
+                let lock_type = l.lock_type.as_deref().map_or(0, Self::parse_lock_type);
+                let scope = l.scope.as_deref().map_or(0, Self::parse_lock_scope);
+                spec.locks.push(LockSpec {
+                    lock_name: l.name,
+                    lock_type,
+                    scope,
+                    description: l.description.unwrap_or_default(),
+                });
+            }
+        }
+
+        // Convert constraints.  Empty strings emitted from kapi_json_str()
+        // for NULL char * fields normalise back to None to match --source.
+        if let Some(constraints) = json_data.constraints {
+            for c in constraints {
+                spec.constraints.push(ConstraintSpec {
+                    name: c.name,
+                    description: c.description.unwrap_or_default(),
+                    expression: c.expression.filter(|v| !v.is_empty()),
+                });
+            }
+        }
+
+        // Convert signals.  The kernel-side kapi_json_str() emits NULL
+        // char * as the empty string "", so normalise empty -> None here
+        // to match the ApiSpec convention used by --source / --vmlinux.
+        fn opt_str(s: Option<String>) -> Option<String> {
+            s.filter(|v| !v.is_empty())
+        }
+        if let Some(signals) = json_data.signals {
+            for s in signals {
+                let direction = s.direction.as_deref().map_or(0, Self::parse_hex_u32);
+                let sa_flags_required = s
+                    .sa_flags_required
+                    .as_deref()
+                    .map_or(0, Self::parse_hex_u32);
+                let sa_flags_forbidden = s
+                    .sa_flags_forbidden
+                    .as_deref()
+                    .map_or(0, Self::parse_hex_u32);
+                let state_required = s.state_required.as_deref().map_or(0, Self::parse_hex_u32);
+                let state_forbidden = s.state_forbidden.as_deref().map_or(0, Self::parse_hex_u32);
+                let timing = s.timing.as_deref().map_or(0, Self::parse_signal_timing);
+                spec.signals.push(super::SignalSpec {
+                    signal_num: s.signal_num,
+                    signal_name: s.signal_name.unwrap_or_default(),
+                    direction,
+                    action: s.action,
+                    target: opt_str(s.target),
+                    condition: opt_str(s.condition),
+                    description: opt_str(s.description),
+                    timing,
+                    priority: s.priority,
+                    restartable: s.restartable,
+                    interruptible: s.interruptible,
+                    queue: opt_str(s.queue_behavior),
+                    sa_flags: 0,
+                    sa_flags_required,
+                    sa_flags_forbidden,
+                    state_required,
+                    state_forbidden,
+                    error_on_signal: if s.error_on_signal != 0 {
+                        Some(s.error_on_signal)
+                    } else {
+                        None
+                    },
+                    transform_to: if s.transform_to != 0 {
+                        // Kernel JSON already carries the numeric value.
+                        Some(s.transform_to)
+                    } else {
+                        None
+                    },
+                });
+            }
+        }
+
+        // Convert side effects.
+        if let Some(effects) = json_data.side_effects {
+            for e in effects {
+                let effect_type = e.type_hex.as_deref().map_or(0, Self::parse_hex_u32);
+                spec.side_effects.push(super::SideEffectSpec {
+                    effect_type,
+                    target: e.target.unwrap_or_default(),
+                    condition: e.condition.filter(|v| !v.is_empty()),
+                    description: e.description.unwrap_or_default(),
+                    reversible: e.reversible,
+                });
+            }
+        }
+
+        Some(spec)
+    }
+
+    /// Parse a single API specification file
+    fn parse_spec_file(&self, api_name: &str) -> Result<ApiSpec> {
+        // Prefer the JSON endpoint if the kernel exposes it (added together
+        // with the framework). Fall back to parsing the plain-text dump for
+        // older kernels that only provide /sys/kernel/debug/kapi/specs/.
+        let json_path = self
+            .debugfs_path
+            .join(format!("kapi/specs-json/{}", api_name));
+        if let Ok(content) = fs::read_to_string(&json_path) {
+            if let Some(spec) = self.try_parse_json(&content) {
+                return Ok(spec);
+            }
+        }
+
+        let spec_path = self.debugfs_path.join(format!("kapi/specs/{}", api_name));
+        let content = fs::read_to_string(&spec_path)
+            .with_context(|| format!("Failed to read {}", spec_path.display()))?;
+
+        // Older kernels may still emit JSON via specs/ if someone backported it.
+        if let Some(spec) = self.try_parse_json(&content) {
+            return Ok(spec);
+        }
+
+        // Fall back to plain text parsing
+        let mut spec = ApiSpec {
+            name: api_name.to_string(),
+            api_type: "unknown".to_string(),
+            description: None,
+            long_description: None,
+            version: None,
+            context_flags: Vec::new(),
+            param_count: None,
+            error_count: None,
+            examples: None,
+            notes: None,
+            subsystem: None,
+            sysfs_path: None,
+            permissions: None,
+            capabilities: vec![],
+            parameters: vec![],
+            return_spec: None,
+            errors: vec![],
+            signals: vec![],
+            signal_masks: vec![],
+            side_effects: vec![],
+            state_transitions: vec![],
+            constraints: vec![],
+            locks: vec![],
+            struct_specs: vec![],
+        };
+
+        // Parse the content
+        let mut collecting_multiline = false;
+        let mut multiline_buffer = String::new();
+        let mut multiline_field = "";
+        let mut parsing_capability = false;
+        let mut in_capabilities_section = false;
+        let mut current_capability: Option<CapabilitySpec> = None;
+
+        for line in content.lines() {
+            // Handle capability sections
+            if line.starts_with("Capabilities (") {
+                in_capabilities_section = true;
+                continue;
+            }
+            // Any other top-level section header ends the capabilities section
+            // so that "  pending_signals (0):" inside "Signal handling (1):"
+            // isn't mis-parsed as a capability entry.
+            if !line.starts_with(' ') && !line.is_empty() && line.ends_with(':') {
+                in_capabilities_section = false;
+            }
+            if in_capabilities_section
+                && line.starts_with("  ")
+                && line.contains(" (")
+                && line.ends_with("):")
+            {
+                // Start of a capability entry like "  CAP_IPC_LOCK (14):"
+                if let Some(cap) = current_capability.take() {
+                    spec.capabilities.push(cap);
+                }
+
+                let parts: Vec<&str> = line.trim().split(" (").collect();
+                if parts.len() == 2 {
+                    let cap_name = parts[0].to_string();
+                    let cap_id = parts[1].trim_end_matches("):").parse().unwrap_or(0);
+                    current_capability = Some(CapabilitySpec {
+                        capability: cap_id,
+                        name: cap_name,
+                        action: String::new(),
+                        allows: String::new(),
+                        without_cap: String::new(),
+                        check_condition: None,
+                        priority: None,
+                        alternatives: Vec::new(),
+                    });
+                    parsing_capability = true;
+                }
+                continue;
+            }
+            if parsing_capability && line.starts_with("    ") {
+                // Parse capability fields
+                if let Some(ref mut cap) = current_capability {
+                    if let Some(action) = line.strip_prefix("    Action: ") {
+                        cap.action = action.to_string();
+                    } else if let Some(allows) = line.strip_prefix("    Allows: ") {
+                        cap.allows = allows.to_string();
+                    } else if let Some(without) = line.strip_prefix("    Without: ") {
+                        cap.without_cap = without.to_string();
+                    } else if let Some(cond) = line.strip_prefix("    Condition: ") {
+                        cap.check_condition = Some(cond.to_string());
+                    } else if let Some(prio) = line.strip_prefix("    Priority: ") {
+                        cap.priority = prio.parse().ok();
+                    } else if let Some(alts) = line.strip_prefix("    Alternatives: ") {
+                        cap.alternatives =
+                            alts.split(", ").filter_map(|s| s.parse().ok()).collect();
+                    }
+                }
+                continue;
+            }
+            if parsing_capability && !line.starts_with("  ") {
+                // End of capabilities section
+                if let Some(cap) = current_capability.take() {
+                    spec.capabilities.push(cap);
+                }
+                parsing_capability = false;
+            }
+
+            // Handle section headers
+            if line.starts_with("Parameters (") {
+                if let Some(count_str) = line
+                    .strip_prefix("Parameters (")
+                    .and_then(|s| s.strip_suffix("):"))
+                {
+                    spec.param_count = count_str.parse().ok();
+                }
+                continue;
+            } else if line.starts_with("Errors (") {
+                if let Some(count_str) = line
+                    .strip_prefix("Errors (")
+                    .and_then(|s| s.strip_suffix("):"))
+                {
+                    spec.error_count = count_str.parse().ok();
+                }
+                continue;
+            } else if line.starts_with("Examples:") {
+                collecting_multiline = true;
+                multiline_field = "examples";
+                multiline_buffer.clear();
+                continue;
+            } else if line.starts_with("Notes:") {
+                collecting_multiline = true;
+                multiline_field = "notes";
+                multiline_buffer.clear();
+                continue;
+            }
+
+            // Handle multiline sections
+            if collecting_multiline {
+                // Terminate multiline on known field patterns or double blank line
+                let is_field = line.starts_with("Description: ")
+                    || line.starts_with("Long description: ")
+                    || line.starts_with("Version: ")
+                    || line.starts_with("Context flags: ")
+                    || line.starts_with("Subsystem: ")
+                    || line.starts_with("Sysfs Path: ")
+                    || line.starts_with("Permissions: ")
+                    || line.starts_with("Parameters (")
+                    || line.starts_with("Errors (")
+                    || line.starts_with("Capabilities (");
+                if is_field || (line.trim().is_empty() && multiline_buffer.ends_with("\n\n")) {
+                    collecting_multiline = false;
+                    match multiline_field {
+                        "examples" => spec.examples = Some(multiline_buffer.trim().to_string()),
+                        "notes" => spec.notes = Some(multiline_buffer.trim().to_string()),
+                        _ => {}
+                    }
+                    multiline_buffer.clear();
+                    if !is_field {
+                        continue;
+                    }
+                    // Fall through to parse this line as a field
+                } else {
+                    if !multiline_buffer.is_empty() {
+                        multiline_buffer.push('\n');
+                    }
+                    multiline_buffer.push_str(line);
+                    continue;
+                }
+            }
+
+            // Parse regular fields
+            if let Some(desc) = line.strip_prefix("Description: ") {
+                spec.description = Some(desc.to_string());
+            } else if let Some(long_desc) = line.strip_prefix("Long description: ") {
+                spec.long_description = Some(long_desc.to_string());
+            } else if let Some(version) = line.strip_prefix("Version: ") {
+                spec.version = Some(version.to_string());
+            } else if let Some(flags) = line.strip_prefix("Context flags: ") {
+                spec.context_flags = flags.split_whitespace().map(str::to_string).collect();
+            } else if let Some(subsys) = line.strip_prefix("Subsystem: ") {
+                spec.subsystem = Some(subsys.to_string());
+            } else if let Some(path) = line.strip_prefix("Sysfs Path: ") {
+                spec.sysfs_path = Some(path.to_string());
+            } else if let Some(perms) = line.strip_prefix("Permissions: ") {
+                spec.permissions = Some(perms.to_string());
+            }
+        }
+
+        // Flush any remaining multiline buffer
+        if collecting_multiline {
+            match multiline_field {
+                "examples" => spec.examples = Some(multiline_buffer.trim().to_string()),
+                "notes" => spec.notes = Some(multiline_buffer.trim().to_string()),
+                _ => {}
+            }
+        }
+
+        // Handle any remaining capability
+        if let Some(cap) = current_capability.take() {
+            spec.capabilities.push(cap);
+        }
+
+        // Determine API type based on name
+        if api_name.starts_with("sys_") {
+            spec.api_type = "syscall".to_string();
+        } else if api_name.contains("_ioctl") || api_name.starts_with("ioctl_") {
+            spec.api_type = "ioctl".to_string();
+        } else if api_name.contains("sysfs")
+            || api_name.ends_with("_show")
+            || api_name.ends_with("_store")
+        {
+            spec.api_type = "sysfs".to_string();
+        } else {
+            spec.api_type = "function".to_string();
+        }
+
+        Ok(spec)
+    }
+}
+
+impl ApiExtractor for DebugfsExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        let api_names = self.parse_list_file()?;
+        let mut specs = Vec::new();
+
+        for name in api_names {
+            match self.parse_spec_file(&name) {
+                Ok(spec) => specs.push(spec),
+                Err(e) => {
+                    eprintln!("Warning: failed to parse API spec '{}': {}", name, e);
+                }
+            }
+        }
+
+        Ok(specs)
+    }
+
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>> {
+        let api_names = self.parse_list_file()?;
+
+        if api_names.contains(&name.to_string()) {
+            Ok(Some(self.parse_spec_file(name)?))
+        } else {
+            Ok(None)
+        }
+    }
+
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()> {
+        if let Some(spec) = self.extract_by_name(api_name)? {
+            display_api_spec(&spec, formatter, writer)?;
+        } else {
+            writeln!(writer, "API '{api_name}' not found in debugfs")?;
+        }
+
+        Ok(())
+    }
+}
diff --git a/tools/kapi/src/extractor/kerneldoc_parser.rs b/tools/kapi/src/extractor/kerneldoc_parser.rs
new file mode 100644
index 0000000000000..f67110007d86f
--- /dev/null
+++ b/tools/kapi/src/extractor/kerneldoc_parser.rs
@@ -0,0 +1,2831 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use super::{
+    ApiSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec, ReturnSpec,
+    SideEffectSpec, SignalSpec, StateTransitionSpec, StructFieldSpec, StructSpec,
+};
+use anyhow::Result;
+use std::collections::HashMap;
+
+/// Real kerneldoc parser that extracts KAPI annotations
+pub struct KerneldocParserImpl;
+
+/// What block are we currently inside?
+#[derive(Debug, Clone, PartialEq)]
+enum BlockContext {
+    None,
+    Param(String),   // param: <name>
+    Error(String),   // error: <name>
+    Signal,          // signal: <name>
+    Capability,      // capability: <name>
+    SideEffect,      // side-effect: <type>
+    StateTransition, // state-trans: ...
+    Constraint,      // constraint: <name>
+    Lock,            // lock: <name>
+    Return,          // return:
+}
+
+/// Parse a numeric literal, supporting plain decimal and 0x-prefixed hex.
+/// Returns `None` for anything that requires cpp-level constant resolution
+/// (e.g. symbolic masks like `O_RDONLY | O_WRONLY`). Callers must treat
+/// that case as "mask unknown" and leave the downstream slot unset, not
+/// store it as 0 — which would wrongly assert that zero bits are valid.
+fn parse_u64_literal(s: &str) -> Option<u64> {
+    let t = s.trim();
+    if let Some(hex) = t.strip_prefix("0x").or_else(|| t.strip_prefix("0X")) {
+        u64::from_str_radix(hex, 16).ok()
+    } else {
+        t.parse().ok()
+    }
+}
+
+/// `true` if `s` contains more '(' than ')' when scanned left-to-right.
+/// Used to decide whether the caller needs to pull more continuation
+/// lines before trying to parse a constraint expression.
+fn has_unbalanced_paren(s: &str) -> bool {
+    let mut depth: i32 = 0;
+    for c in s.chars() {
+        match c {
+            '(' => depth += 1,
+            ')' => depth -= 1,
+            _ => {}
+        }
+    }
+    depth > 0
+}
+
+/// Canonicalise a kerneldoc `type:` value to its KAPI_TYPE_* spelling.
+/// Used in the `return:` block so `type_name` carries the long form
+/// regardless of which spelling the source used.
+fn canon_kapi_type_name(s: &str) -> String {
+    let t = s.trim();
+    if t.starts_with("KAPI_TYPE_") {
+        return t.to_string();
+    }
+    match t.to_ascii_lowercase().as_str() {
+        "void" => "KAPI_TYPE_VOID".to_string(),
+        "int" => "KAPI_TYPE_INT".to_string(),
+        "uint" => "KAPI_TYPE_UINT".to_string(),
+        "ptr" => "KAPI_TYPE_PTR".to_string(),
+        "struct" => "KAPI_TYPE_STRUCT".to_string(),
+        "union" => "KAPI_TYPE_UNION".to_string(),
+        "enum" => "KAPI_TYPE_ENUM".to_string(),
+        "func_ptr" => "KAPI_TYPE_FUNC_PTR".to_string(),
+        "array" => "KAPI_TYPE_ARRAY".to_string(),
+        "fd" => "KAPI_TYPE_FD".to_string(),
+        "user_ptr" | "uptr" => "KAPI_TYPE_USER_PTR".to_string(),
+        "path" => "KAPI_TYPE_PATH".to_string(),
+        "custom" => "KAPI_TYPE_CUSTOM".to_string(),
+        _ => t.to_string(),
+    }
+}
+
+/// Canonicalise a capability `type:` value to its KAPI_CAP_* spelling.
+fn canon_kapi_cap_action(s: &str) -> String {
+    let t = s.trim();
+    if t.starts_with("KAPI_CAP_") {
+        return t.to_string();
+    }
+    match t.to_ascii_lowercase().as_str() {
+        "bypass_check" => "KAPI_CAP_BYPASS_CHECK".to_string(),
+        "increase_limit" => "KAPI_CAP_INCREASE_LIMIT".to_string(),
+        "override_restriction" => "KAPI_CAP_OVERRIDE_RESTRICTION".to_string(),
+        "grant_permission" => "KAPI_CAP_GRANT_PERMISSION".to_string(),
+        "modify_behavior" => "KAPI_CAP_MODIFY_BEHAVIOR".to_string(),
+        "access_resource" => "KAPI_CAP_ACCESS_RESOURCE".to_string(),
+        "perform_operation" => "KAPI_CAP_PERFORM_OPERATION".to_string(),
+        _ => t.to_string(),
+    }
+}
+
+/// Types whose semantics imply `KAPI_PARAM_USER` on the param, so
+/// `type: user_ptr, input` doesn't need a separate `user` flag.
+fn type_implies_user_flag(tok: &str) -> bool {
+    matches!(tok.trim(), "KAPI_TYPE_USER_PTR" | "KAPI_TYPE_PATH")
+        || matches!(
+            tok.trim().to_ascii_lowercase().as_str(),
+            "user_ptr" | "uptr" | "path"
+        )
+}
+
+/// Return true if the line's first whitespace-delimited token is a
+/// bare identifier ending in ':' (e.g. `type:`, `constraint-type:`,
+/// `error:`). Used by the continuation folder to stop at the next
+/// block attribute.
+fn is_block_key(s: &str) -> bool {
+    let head = s.split_whitespace().next().unwrap_or("");
+    if !head.ends_with(':') || head.len() < 2 {
+        return false;
+    }
+    let ident = &head[..head.len() - 1];
+    !ident.is_empty()
+        && ident
+            .chars()
+            .all(|c| c.is_ascii_alphanumeric() || c == '_' || c == '-')
+}
+
+impl KerneldocParserImpl {
+    pub fn new() -> Self {
+        KerneldocParserImpl
+    }
+
+    pub fn parse_kerneldoc(
+        &self,
+        doc: &str,
+        name: &str,
+        api_type: &str,
+        signature: Option<&str>,
+    ) -> Result<ApiSpec> {
+        let mut spec = ApiSpec {
+            name: name.to_string(),
+            api_type: api_type.to_string(),
+            ..Default::default()
+        };
+
+        let lines: Vec<&str> = doc.lines().collect();
+
+        // Extract main description from function name line
+        if let Some(first_line) = lines.first() {
+            if let Some((_, desc)) = first_line.split_once(" - ") {
+                spec.description = Some(desc.trim().to_string());
+            }
+        }
+
+        // Extract type names from SYSCALL_DEFINE signature
+        let type_map = if let Some(sig) = signature {
+            self.extract_types_from_signature(sig)
+        } else {
+            HashMap::new()
+        };
+
+        // Keep track of parameters we've seen (from @param lines)
+        let mut param_map: HashMap<String, ParamSpec> = HashMap::new();
+        let mut struct_fields: Vec<StructFieldSpec> = Vec::new();
+
+        // Current block being parsed
+        let mut block = BlockContext::None;
+
+        // Temporary storage for current block items
+        let mut current_lock: Option<LockSpec> = None;
+        let mut current_signal: Option<SignalSpec> = None;
+        // Pending symbolic `transform-to:` token. Captured when the parser
+        // sees a non-numeric value, but only reported if the final
+        // `transform_to` after all lines in the signal block is still
+        // unresolved. A later numeric `transform-to:` clears this so we
+        // don't warn about a value that was subsequently overridden.
+        let mut pending_transform_warning: Option<String> = None;
+        let mut current_capability: Option<CapabilitySpec> = None;
+        let mut current_side_effect: Option<SideEffectSpec> = None;
+        let mut current_constraint: Option<ConstraintSpec> = None;
+        let mut current_error: Option<ErrorSpec> = None;
+        let mut current_return: Option<ReturnSpec> = None;
+
+        let mut i = 0;
+
+        while i < lines.len() {
+            let line = lines[i];
+            let trimmed = line.trim();
+
+            // Skip empty lines
+            if trimmed.is_empty() {
+                i += 1;
+                continue;
+            }
+
+            // Check if this is an indented continuation line (part of current block)
+            let is_indented = line.starts_with("  ") || line.starts_with('\t');
+
+            // If indented and we're in a block, parse as block attribute.
+            // Before dispatching, fold continuation lines into `trimmed`
+            // when the value has an unbalanced '(' so that expressions
+            // like `constraint-type: mask(FOO | BAR |` ... `| BAZ)`
+            // arrive as a single logical line.
+            if is_indented && block != BlockContext::None {
+                let mut folded: Option<String> = None;
+                if has_unbalanced_paren(trimmed) {
+                    let mut buf = trimmed.to_string();
+                    let mut j = i + 1;
+                    while j < lines.len() {
+                        let next = lines[j];
+                        let next_trim = next.trim();
+                        if next_trim.is_empty() {
+                            break;
+                        }
+                        if !(next.starts_with("  ") || next.starts_with('\t')) {
+                            break;
+                        }
+                        // Stop if we've hit another known key
+                        if is_block_key(next_trim) {
+                            break;
+                        }
+                        buf.push(' ');
+                        buf.push_str(next_trim);
+                        j += 1;
+                        if !has_unbalanced_paren(&buf) {
+                            break;
+                        }
+                    }
+                    if j > i + 1 {
+                        i = j - 1; // outer loop will += 1
+                        folded = Some(buf);
+                    }
+                }
+                let line_to_parse: &str = folded.as_deref().unwrap_or(trimmed);
+                self.parse_block_attribute(
+                    line_to_parse,
+                    &block,
+                    &mut param_map,
+                    &mut current_error,
+                    &mut current_signal,
+                    &mut pending_transform_warning,
+                    &mut current_capability,
+                    &mut current_side_effect,
+                    &mut current_constraint,
+                    &mut current_lock,
+                    &mut current_return,
+                );
+                i += 1;
+                continue;
+            }
+
+            // Not indented or not in block — flush current block if any.
+            // If a symbolic `transform-to:` was captured and no later
+            // numeric line cleared it, surface the warning now; by
+            // construction `transform_to` is None in that case.
+            if matches!(block, BlockContext::Signal) {
+                if let Some(raw) = pending_transform_warning.take() {
+                    eprintln!(
+                        "kapi: warning: transform-to: {raw:?} is symbolic; \
+                         source-mode cannot resolve signal numbers portably. \
+                         Use --vmlinux or --debugfs to get the resolved value.",
+                    );
+                }
+            }
+            self.flush_block(
+                &mut block,
+                &mut spec,
+                &mut current_error,
+                &mut current_signal,
+                &mut current_capability,
+                &mut current_side_effect,
+                &mut current_constraint,
+                &mut current_lock,
+                &mut current_return,
+            );
+
+            // Parse top-level annotations
+            if let Some(rest) = trimmed.strip_prefix("@") {
+                // @param: description — standard kerneldoc parameter
+                if let Some((param_name, desc)) = rest.split_once(':') {
+                    let param_name = param_name.trim();
+                    let desc = desc.trim();
+                    if !param_name.contains('-') {
+                        let idx = param_map.len() as u32;
+                        let type_name = type_map.get(param_name).cloned().unwrap_or_default();
+                        param_map.insert(
+                            param_name.to_string(),
+                            ParamSpec {
+                                index: idx,
+                                name: param_name.to_string(),
+                                type_name,
+                                description: desc.to_string(),
+                                flags: 0,
+                                param_type: 0,
+                                constraint_type: 0,
+                                constraint: None,
+                                min_value: None,
+                                max_value: None,
+                                valid_mask: None,
+                                enum_values: vec![],
+                                size: None,
+                                alignment: None,
+                                size_param_idx: None,
+                            },
+                        );
+                    }
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("long-desc:") {
+                let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                spec.long_description = Some(val);
+                i = next_i;
+                continue;
+            } else if let Some(rest) = trimmed.strip_prefix("context-flags:") {
+                spec.context_flags = self.parse_context_flags(rest.trim());
+            } else if let Some(rest) = trimmed.strip_prefix("contexts:") {
+                // Short form: "contexts: process, sleepable"
+                spec.context_flags = self.parse_context_list(rest.trim());
+            } else if let Some(rest) = trimmed.strip_prefix("param-count:") {
+                spec.param_count = rest.trim().parse().ok();
+            }
+            // Flat param-* annotations (alternative format)
+            else if let Some(rest) = trimmed.strip_prefix("param-type:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    if let Some(param) = param_map.get_mut(parts[0]) {
+                        param.param_type = self.parse_param_type(parts[1]);
+                    }
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("param-flags:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    if let Some(param) = param_map.get_mut(parts[0]) {
+                        param.flags = self.parse_param_flags(parts[1]);
+                    }
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("param-range:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 3 {
+                    if let Some(param) = param_map.get_mut(parts[0]) {
+                        param.min_value = parts[1].parse().ok();
+                        param.max_value = parts[2].parse().ok();
+                        param.constraint_type = 1; // KAPI_CONSTRAINT_RANGE
+                    }
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("param-constraint:") {
+                let parts: Vec<&str> = rest.splitn(2, ',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    if let Some(param) = param_map.get_mut(parts[0]) {
+                        param.constraint = Some(parts[1].to_string());
+                    }
+                }
+            }
+            // Block-start annotations
+            else if let Some(rest) = trimmed.strip_prefix("param:") {
+                let param_name = rest.trim().to_string();
+                block = BlockContext::Param(param_name.clone());
+                // Ensure param exists in map
+                if !param_map.contains_key(&param_name) {
+                    let idx = param_map.len() as u32;
+                    let type_name = type_map
+                        .get(param_name.as_str())
+                        .cloned()
+                        .unwrap_or_default();
+                    param_map.insert(
+                        param_name.clone(),
+                        ParamSpec {
+                            index: idx,
+                            name: param_name,
+                            type_name,
+                            description: String::new(),
+                            flags: 0,
+                            param_type: 0,
+                            constraint_type: 0,
+                            constraint: None,
+                            min_value: None,
+                            max_value: None,
+                            valid_mask: None,
+                            enum_values: vec![],
+                            size: None,
+                            alignment: None,
+                            size_param_idx: None,
+                        },
+                    );
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("error:") {
+                // error: NAME, condition
+                let parts: Vec<&str> = rest.splitn(2, ',').map(|s| s.trim()).collect();
+                if !parts.is_empty() {
+                    let error_name = parts[0].to_string();
+                    let condition = if parts.len() >= 2 {
+                        parts[1].to_string()
+                    } else {
+                        String::new()
+                    };
+                    let error_code = self.error_name_to_code(&error_name);
+                    current_error = Some(ErrorSpec {
+                        error_code,
+                        name: error_name.clone(),
+                        condition,
+                        description: String::new(),
+                    });
+                    block = BlockContext::Error(error_name);
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("signal:") {
+                let signal_name = rest.trim().to_string();
+                current_signal = Some(SignalSpec {
+                    signal_num: 0,
+                    signal_name,
+                    direction: 1,
+                    action: 0,
+                    target: None,
+                    condition: None,
+                    description: None,
+                    restartable: false,
+                    timing: 0,
+                    priority: 0,
+                    interruptible: false,
+                    queue: None,
+                    sa_flags: 0,
+                    sa_flags_required: 0,
+                    sa_flags_forbidden: 0,
+                    state_required: 0,
+                    state_forbidden: 0,
+                    error_on_signal: None,
+                    transform_to: None,
+                });
+                block = BlockContext::Signal;
+            } else if let Some(rest) = trimmed.strip_prefix("capability:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if !parts.is_empty() {
+                    let cap_name = parts[0].to_string();
+                    let cap_value = self.parse_capability_value(&cap_name);
+                    // If we have 3 parts, it's flat format: capability: CAP, action, name
+                    let (action, name) = if parts.len() >= 3 {
+                        (parts[1].to_string(), parts[2].to_string())
+                    } else {
+                        (String::new(), cap_name.clone())
+                    };
+                    current_capability = Some(CapabilitySpec {
+                        capability: cap_value,
+                        name,
+                        action,
+                        allows: String::new(),
+                        without_cap: String::new(),
+                        check_condition: None,
+                        priority: Some(0),
+                        alternatives: vec![],
+                    });
+                    block = BlockContext::Capability;
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("side-effect:") {
+                // Could be flat format (comma-separated) or block start
+                let rest = rest.trim();
+                // Check if it's the flat format with commas
+                let comma_parts: Vec<&str> = rest.splitn(3, ',').map(|s| s.trim()).collect();
+                if comma_parts.len() >= 3 {
+                    // Flat format: side-effect: TYPE, target, desc
+                    let mut effect = SideEffectSpec {
+                        effect_type: self.parse_effect_type(comma_parts[0]),
+                        target: comma_parts[1].to_string(),
+                        condition: None,
+                        description: comma_parts[2].to_string(),
+                        reversible: false,
+                    };
+                    if comma_parts[2].contains("reversible=yes") {
+                        effect.reversible = true;
+                    }
+                    spec.side_effects.push(effect);
+                } else {
+                    // Block format: side-effect: TYPE
+                    current_side_effect = Some(SideEffectSpec {
+                        effect_type: self.parse_effect_type(rest),
+                        target: String::new(),
+                        condition: None,
+                        description: String::new(),
+                        reversible: false,
+                    });
+                    block = BlockContext::SideEffect;
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("state-trans:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 4 {
+                    spec.state_transitions.push(StateTransitionSpec {
+                        object: parts[0].to_string(),
+                        from_state: parts[1].to_string(),
+                        to_state: parts[2].to_string(),
+                        condition: None,
+                        description: parts[3].to_string(),
+                    });
+                }
+                block = BlockContext::StateTransition;
+            } else if let Some(rest) = trimmed.strip_prefix("constraint:") {
+                let rest = rest.trim();
+                // Could be flat format: constraint: name, desc
+                // Or block format: constraint: name
+                let parts: Vec<&str> = rest.splitn(2, ',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    // Flat format
+                    current_constraint = Some(ConstraintSpec {
+                        name: parts[0].to_string(),
+                        description: parts[1].to_string(),
+                        expression: None,
+                    });
+                } else {
+                    // Block format
+                    current_constraint = Some(ConstraintSpec {
+                        name: rest.to_string(),
+                        description: String::new(),
+                        expression: None,
+                    });
+                }
+                block = BlockContext::Constraint;
+            } else if let Some(rest) = trimmed.strip_prefix("constraint-expr:") {
+                // Flat format: constraint-expr: name, expr
+                let parts: Vec<&str> = rest.splitn(2, ',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    if let Some(constraint) =
+                        spec.constraints.iter_mut().find(|c| c.name == parts[0])
+                    {
+                        constraint.expression = Some(parts[1].to_string());
+                    }
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("lock:") {
+                let rest = rest.trim();
+                // Could be flat: lock: name, type
+                // Or block: lock: name
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    current_lock = Some(LockSpec {
+                        lock_name: parts[0].to_string(),
+                        lock_type: self.parse_lock_type(parts[1]),
+                        scope: super::KAPI_LOCK_INTERNAL,
+                        description: String::new(),
+                    });
+                } else {
+                    current_lock = Some(LockSpec {
+                        lock_name: rest.to_string(),
+                        lock_type: 0,
+                        scope: super::KAPI_LOCK_INTERNAL,
+                        description: String::new(),
+                    });
+                }
+                block = BlockContext::Lock;
+            }
+            // Flat signal-* attributes (alternative format)
+            else if let Some(rest) = trimmed.strip_prefix("signal-direction:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.direction = self.parse_signal_direction(rest.trim());
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("signal-action:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.action = self.parse_signal_action(rest.trim());
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("signal-condition:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                    signal.condition = Some(val);
+                    i = next_i;
+                    continue;
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("signal-desc:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                    signal.description = Some(val);
+                    i = next_i;
+                    continue;
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("signal-timing:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.timing = self.parse_signal_timing(rest.trim());
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("signal-priority:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.priority = rest.trim().parse().unwrap_or(0);
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("signal-interruptible:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    let val = rest.trim().to_lowercase();
+                    signal.interruptible = !matches!(val.as_str(), "no" | "false" | "0");
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("signal-state-req:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.state_required = self.parse_signal_state(rest.trim());
+                }
+            }
+            // Flat capability-* attributes
+            else if let Some(rest) = trimmed.strip_prefix("capability-allows:") {
+                if let Some(cap) = current_capability.as_mut() {
+                    let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                    cap.allows = val;
+                    i = next_i;
+                    continue;
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("capability-without:") {
+                if let Some(cap) = current_capability.as_mut() {
+                    let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                    cap.without_cap = val;
+                    i = next_i;
+                    continue;
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("capability-condition:") {
+                if let Some(cap) = current_capability.as_mut() {
+                    let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                    cap.check_condition = Some(val);
+                    i = next_i;
+                    continue;
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("capability-priority:") {
+                if let Some(cap) = current_capability.as_mut() {
+                    cap.priority = rest.trim().parse().ok();
+                }
+            }
+            // Lock flat attributes
+            else if let Some(rest) = trimmed.strip_prefix("lock-scope:") {
+                if let Some(lock) = current_lock.as_mut() {
+                    lock.scope = match rest.trim() {
+                        "internal" => super::KAPI_LOCK_INTERNAL,
+                        "acquires" => super::KAPI_LOCK_ACQUIRES,
+                        "releases" => super::KAPI_LOCK_RELEASES,
+                        "caller_held" => super::KAPI_LOCK_CALLER_HELD,
+                        _ => super::KAPI_LOCK_INTERNAL,
+                    };
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("lock-desc:") {
+                if let Some(lock) = current_lock.as_mut() {
+                    let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                    lock.description = val;
+                    i = next_i;
+                    continue;
+                }
+            }
+            // Struct field annotations
+            else if let Some(rest) = trimmed.strip_prefix("struct-field:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 3 {
+                    struct_fields.push(StructFieldSpec {
+                        name: parts[0].to_string(),
+                        field_type: self.parse_field_type(parts[1]),
+                        type_name: parts[1].to_string(),
+                        offset: 0,
+                        size: 0,
+                        flags: 0,
+                        constraint_type: 0,
+                        min_value: 0,
+                        max_value: 0,
+                        valid_mask: 0,
+                        description: parts[2].to_string(),
+                    });
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("struct-field-range:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 3 {
+                    if let Some(field) = struct_fields.iter_mut().find(|f| f.name == parts[0]) {
+                        field.min_value = parts[1].parse().unwrap_or(0);
+                        field.max_value = parts[2].parse().unwrap_or(0);
+                        field.constraint_type = 1;
+                    }
+                }
+            }
+            // Other top-level annotations
+            else if let Some(rest) = trimmed.strip_prefix("return:") {
+                let rest = rest.trim();
+                if rest.is_empty() {
+                    // Block format
+                    current_return = Some(ReturnSpec {
+                        type_name: String::new(),
+                        description: String::new(),
+                        return_type: 0,
+                        check_type: 0,
+                        success_value: None,
+                        success_min: None,
+                        success_max: None,
+                        error_values: vec![],
+                    });
+                    block = BlockContext::Return;
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("return-type:") {
+                if spec.return_spec.is_none() {
+                    spec.return_spec = Some(ReturnSpec {
+                        type_name: rest.trim().to_string(),
+                        description: String::new(),
+                        return_type: self.parse_param_type(rest.trim()),
+                        check_type: 0,
+                        success_value: None,
+                        success_min: None,
+                        success_max: None,
+                        error_values: vec![],
+                    });
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("return-check-type:") {
+                if let Some(ret) = spec.return_spec.as_mut() {
+                    ret.check_type = self.parse_return_check_type(rest.trim());
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("return-success:") {
+                if let Some(ret) = spec.return_spec.as_mut() {
+                    ret.success_value = rest.trim().parse().ok();
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("examples:") {
+                let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                spec.examples = Some(val);
+                i = next_i;
+                continue;
+            } else if let Some(rest) = trimmed.strip_prefix("notes:") {
+                let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                spec.notes = Some(val);
+                i = next_i;
+                continue;
+            }
+
+            i += 1;
+        }
+
+        // Flush any remaining block. Emit a pending symbolic
+        // `transform-to:` warning if the final state still has no
+        // resolved numeric value (see per-line loop for rationale).
+        if matches!(block, BlockContext::Signal) {
+            if let Some(raw) = pending_transform_warning.take() {
+                eprintln!(
+                    "kapi: warning: transform-to: {raw:?} is symbolic; \
+                     source-mode cannot resolve signal numbers portably. \
+                     Use --vmlinux or --debugfs to get the resolved value.",
+                );
+            }
+        }
+        self.flush_block(
+            &mut block,
+            &mut spec,
+            &mut current_error,
+            &mut current_signal,
+            &mut current_capability,
+            &mut current_side_effect,
+            &mut current_constraint,
+            &mut current_lock,
+            &mut current_return,
+        );
+
+        // Convert param_map to vec preserving order
+        let mut params: Vec<ParamSpec> = param_map.into_values().collect();
+        params.sort_by_key(|p| p.index);
+
+        // If the spec carries an explicit param-count, warn when it
+        // disagrees with the number of param: blocks we actually saw.
+        // param-count: is otherwise redundant with the block count, and
+        // new short-form specs should just drop it.
+        if let Some(claimed) = spec.param_count {
+            if claimed as usize != params.len() {
+                eprintln!(
+                    "kapi: {}: param-count: {} disagrees with {} param: block(s)",
+                    name,
+                    claimed,
+                    params.len(),
+                );
+            }
+        }
+
+        spec.parameters = params;
+
+        // Create struct spec if we have fields
+        if !struct_fields.is_empty() {
+            spec.struct_specs.push(StructSpec {
+                name: format!("struct {name}"),
+                size: 0,
+                alignment: 0,
+                field_count: struct_fields.len() as u32,
+                fields: struct_fields,
+                description: "Structure specification".to_string(),
+            });
+        }
+
+        Ok(spec)
+    }
+
+    /// Parse an indented attribute line within a block
+    #[allow(clippy::too_many_arguments)]
+    fn parse_block_attribute(
+        &self,
+        trimmed: &str,
+        block: &BlockContext,
+        param_map: &mut HashMap<String, ParamSpec>,
+        current_error: &mut Option<ErrorSpec>,
+        current_signal: &mut Option<SignalSpec>,
+        pending_transform_warning: &mut Option<String>,
+        current_capability: &mut Option<CapabilitySpec>,
+        current_side_effect: &mut Option<SideEffectSpec>,
+        current_constraint: &mut Option<ConstraintSpec>,
+        current_lock: &mut Option<LockSpec>,
+        current_return: &mut Option<ReturnSpec>,
+    ) {
+        match block {
+            BlockContext::Param(param_name) => {
+                if let Some(param) = param_map.get_mut(param_name) {
+                    if let Some(rest) = trimmed.strip_prefix("type:") {
+                        // Accept either:
+                        //   type: KAPI_TYPE_UINT              (long, single token)
+                        //   type: uint                        (short, single token)
+                        //   type: uint, input                 (short, type + flags)
+                        //   type: path, input                 (short, type + flags)
+                        // Single-token inputs leave flags alone so existing
+                        // long-form specs that use a separate `flags:` line
+                        // keep working unchanged.
+                        //
+                        // User-space pointer types (user_ptr, path) imply
+                        // KAPI_PARAM_USER, so specs don't need to repeat
+                        // `user` after the type.
+                        let mut parts = rest.split(',').map(str::trim);
+                        let type_token = parts.next();
+                        if let Some(ty) = type_token {
+                            param.param_type = self.parse_param_type(ty);
+                        }
+                        for flag in parts {
+                            param.flags |= self.parse_param_flag_token(flag);
+                        }
+                        if type_token.map(type_implies_user_flag).unwrap_or(false) {
+                            param.flags |= 1 << 6; // KAPI_PARAM_USER
+                        }
+                    } else if let Some(rest) = trimmed.strip_prefix("flags:") {
+                        param.flags = self.parse_param_flags(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("constraint-type:") {
+                        // Accepts `KAPI_CONSTRAINT_*` enum tokens or
+                        // function-call expressions like `range(0, 4096)`
+                        // / `mask(0xff)` / `buffer(2)` that also populate
+                        // the matching numeric fields on `param`.
+                        let text = rest.trim();
+                        if !self.apply_constraint_expr(param, text) {
+                            param.constraint_type = self.parse_constraint_type(text);
+                        }
+                    } else if let Some(rest) = trimmed.strip_prefix("valid-mask:") {
+                        // Symbolic mask values need cpp-level resolution;
+                        // leave that to the binary reader.
+                        let _ = rest;
+                    } else if let Some(rest) = trimmed.strip_prefix("constraint:") {
+                        // Free-text constraint description; multiline append.
+                        let text = rest.trim();
+                        if param.constraint.is_none() {
+                            param.constraint = Some(text.to_string());
+                        } else if let Some(c) = param.constraint.as_mut() {
+                            c.push(' ');
+                            c.push_str(text);
+                        }
+                    } else if let Some(rest) = trimmed.strip_prefix("range:") {
+                        let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                        if parts.len() >= 2 {
+                            param.min_value = parts[0].parse().ok();
+                            param.max_value = parts[1].parse().ok();
+                            param.constraint_type = 1; // KAPI_CONSTRAINT_RANGE
+                        }
+                    } else if let Some(rest) = trimmed.strip_prefix("size-param:") {
+                        param.size_param_idx = rest.trim().parse().ok();
+                    } else if let Some(rest) = trimmed.strip_prefix("description:") {
+                        param.description = rest.trim().to_string();
+                    } else if let Some(rest) = trimmed.strip_prefix("desc:") {
+                        param.description = rest.trim().to_string();
+                    } else if !trimmed.contains(':') || trimmed.starts_with("  ") {
+                        // Continuation of the previous attribute's value.
+                        if let Some(c) = param.constraint.as_mut() {
+                            c.push(' ');
+                            c.push_str(trimmed);
+                        }
+                    }
+                }
+            }
+            BlockContext::Error(_) => {
+                if let Some(error) = current_error.as_mut() {
+                    if let Some(rest) = trimmed.strip_prefix("desc:") {
+                        let text = rest.trim().to_string();
+                        if error.description.is_empty() {
+                            error.description = text;
+                        } else {
+                            error.description.push(' ');
+                            error.description.push_str(&text);
+                        }
+                    } else if let Some(rest) = trimmed.strip_prefix("condition:") {
+                        error.condition = rest.trim().to_string();
+                    } else {
+                        // Continuation of description
+                        if !error.description.is_empty() {
+                            error.description.push(' ');
+                            error.description.push_str(trimmed);
+                        }
+                    }
+                }
+            }
+            BlockContext::Signal => {
+                if let Some(signal) = current_signal.as_mut() {
+                    if let Some(rest) = trimmed.strip_prefix("direction:") {
+                        signal.direction = self.parse_signal_direction(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("action:") {
+                        signal.action = self.parse_signal_action(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("condition:") {
+                        signal.condition = Some(rest.trim().to_string());
+                    } else if let Some(rest) = trimmed.strip_prefix("desc:") {
+                        let text = rest.trim().to_string();
+                        if signal.description.is_none() {
+                            signal.description = Some(text);
+                        } else if let Some(d) = signal.description.as_mut() {
+                            d.push(' ');
+                            d.push_str(&text);
+                        }
+                    } else if let Some(rest) = trimmed.strip_prefix("errno:") {
+                        // `error:` cannot be used here because kerneldoc
+                        // promotes it to a top-level section header.
+                        //
+                        // Accepted forms:
+                        //   errno: -4         -> numeric literal, stored as-is
+                        //   errno: -EINTR     -> kernel convention; resolve
+                        //                       the symbol and negate
+                        //   errno: EINTR      -> bare symbol; resolved value
+                        //                       is already negative
+                        let value = rest.trim();
+                        signal.error_on_signal = if let Ok(code) = value.parse::<i32>() {
+                            Some(code)
+                        } else if let Some(name) = value.strip_prefix('-') {
+                            // `error_name_to_code` already returns the negated
+                            // code (e.g. "EINTR" -> -4), so `-EINTR` resolves
+                            // to -4 too — the leading `-` on the symbolic form
+                            // is kernel-source convention, not a second negation.
+                            Some(self.error_name_to_code(name))
+                        } else {
+                            Some(self.error_name_to_code(value))
+                        };
+                    } else if let Some(rest) = trimmed.strip_prefix("timing:") {
+                        signal.timing = self.parse_signal_timing(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("restartable:") {
+                        let val = rest.trim().to_lowercase();
+                        signal.restartable = matches!(val.as_str(), "yes" | "true" | "1");
+                    } else if let Some(rest) = trimmed.strip_prefix("interruptible:") {
+                        let val = rest.trim().to_lowercase();
+                        signal.interruptible = matches!(val.as_str(), "yes" | "true" | "1");
+                    } else if let Some(rest) = trimmed.strip_prefix("priority:") {
+                        signal.priority = rest.trim().parse().unwrap_or(0);
+                    } else if let Some(rest) = trimmed.strip_prefix("target:") {
+                        signal.target = Some(rest.trim().to_string());
+                    } else if let Some(rest) = trimmed.strip_prefix("queue:") {
+                        signal.queue = Some(rest.trim().to_string());
+                    } else if let Some(rest) = trimmed
+                        .strip_prefix("transform-to:")
+                        .or_else(|| trimmed.strip_prefix("transform_to:"))
+                    {
+                        // transform-to: takes a signal constant (e.g.
+                        // SIGKILL) or a numeric literal. Only a numeric
+                        // literal fills `transform_to`; symbolic values
+                        // cannot be resolved portably in userspace
+                        // because signal numbers are arch-dependent and
+                        // we have no access to the target arch's
+                        // <asm/signal.h>. Report such cases to stderr so
+                        // they are not silently lost, and point the user
+                        // at --vmlinux / --debugfs, which consult the
+                        // compiled struct where the C preprocessor has
+                        // already baked in the correct value.
+                        //
+                        // Assign unconditionally so the last line in
+                        // the kerneldoc wins and an intended symbolic
+                        // override doesn't silently leave a stale
+                        // numeric value from an earlier line. The
+                        // warning is deferred until flush_block() so a
+                        // subsequent numeric line can cancel it; if the
+                        // last line was still symbolic we report it
+                        // then.
+                        let v = rest.trim();
+                        let parsed = v.parse::<i32>().ok();
+                        signal.transform_to = parsed;
+                        if parsed.is_some() {
+                            *pending_transform_warning = None;
+                        } else if !v.is_empty() {
+                            *pending_transform_warning = Some(v.to_string());
+                        }
+                    } else if let Some(rest) = trimmed
+                        .strip_prefix("sa-flags-required:")
+                        .or_else(|| trimmed.strip_prefix("sa_flags_required:"))
+                    {
+                        signal.sa_flags_required = self.parse_hex_or_bitmask(rest.trim());
+                    } else if let Some(rest) = trimmed
+                        .strip_prefix("sa-flags-forbidden:")
+                        .or_else(|| trimmed.strip_prefix("sa_flags_forbidden:"))
+                    {
+                        signal.sa_flags_forbidden = self.parse_hex_or_bitmask(rest.trim());
+                    } else if let Some(rest) = trimmed
+                        .strip_prefix("state-required:")
+                        .or_else(|| trimmed.strip_prefix("state_required:"))
+                    {
+                        signal.state_required = self.parse_signal_state_mask(rest.trim());
+                    } else if let Some(rest) = trimmed
+                        .strip_prefix("state-forbidden:")
+                        .or_else(|| trimmed.strip_prefix("state_forbidden:"))
+                    {
+                        signal.state_forbidden = self.parse_signal_state_mask(rest.trim());
+                    } else {
+                        // Continuation of description
+                        if let Some(d) = signal.description.as_mut() {
+                            d.push(' ');
+                            d.push_str(trimmed);
+                        }
+                    }
+                }
+            }
+            BlockContext::Capability => {
+                if let Some(cap) = current_capability.as_mut() {
+                    if let Some(rest) = trimmed.strip_prefix("type:") {
+                        cap.action = canon_kapi_cap_action(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("allows:") {
+                        cap.allows = rest.trim().to_string();
+                    } else if let Some(rest) = trimmed.strip_prefix("without:") {
+                        cap.without_cap = rest.trim().to_string();
+                    } else if let Some(rest) = trimmed.strip_prefix("condition:") {
+                        cap.check_condition = Some(rest.trim().to_string());
+                    } else if let Some(rest) = trimmed.strip_prefix("priority:") {
+                        cap.priority = rest.trim().parse().ok();
+                    }
+                }
+            }
+            BlockContext::SideEffect => {
+                if let Some(effect) = current_side_effect.as_mut() {
+                    if let Some(rest) = trimmed.strip_prefix("target:") {
+                        effect.target = rest.trim().to_string();
+                    } else if let Some(rest) = trimmed.strip_prefix("condition:") {
+                        effect.condition = Some(rest.trim().to_string());
+                    } else if let Some(rest) = trimmed.strip_prefix("desc:") {
+                        let text = rest.trim().to_string();
+                        if effect.description.is_empty() {
+                            effect.description = text;
+                        } else {
+                            effect.description.push(' ');
+                            effect.description.push_str(&text);
+                        }
+                    } else if let Some(rest) = trimmed.strip_prefix("reversible:") {
+                        let val = rest.trim().to_lowercase();
+                        effect.reversible = matches!(val.as_str(), "yes" | "true" | "1");
+                    } else {
+                        // Continuation of description
+                        if !effect.description.is_empty() {
+                            effect.description.push(' ');
+                            effect.description.push_str(trimmed);
+                        }
+                    }
+                }
+            }
+            BlockContext::Constraint => {
+                if let Some(constraint) = current_constraint.as_mut() {
+                    if let Some(rest) = trimmed.strip_prefix("desc:") {
+                        let text = rest.trim().to_string();
+                        if constraint.description.is_empty() {
+                            constraint.description = text;
+                        } else {
+                            constraint.description.push(' ');
+                            constraint.description.push_str(&text);
+                        }
+                    } else if let Some(rest) = trimmed.strip_prefix("expr:") {
+                        constraint.expression = Some(rest.trim().to_string());
+                    } else {
+                        // Continuation of description
+                        if !constraint.description.is_empty() {
+                            constraint.description.push(' ');
+                            constraint.description.push_str(trimmed);
+                        }
+                    }
+                }
+            }
+            BlockContext::Lock => {
+                if let Some(lock) = current_lock.as_mut() {
+                    if let Some(rest) = trimmed.strip_prefix("type:") {
+                        lock.lock_type = self.parse_lock_type(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("scope:") {
+                        lock.scope = match rest.trim() {
+                            "internal" => super::KAPI_LOCK_INTERNAL,
+                            "acquires" => super::KAPI_LOCK_ACQUIRES,
+                            "releases" => super::KAPI_LOCK_RELEASES,
+                            "caller_held" => super::KAPI_LOCK_CALLER_HELD,
+                            _ => super::KAPI_LOCK_INTERNAL,
+                        };
+                    } else if let Some(rest) = trimmed.strip_prefix("desc:") {
+                        let text = rest.trim().to_string();
+                        if lock.description.is_empty() {
+                            lock.description = text;
+                        } else {
+                            lock.description.push(' ');
+                            lock.description.push_str(&text);
+                        }
+                    } else if trimmed.starts_with("acquired:") {
+                        // KAPI_LOCK_ACQUIRED macro sets scope = ACQUIRES.
+                        lock.scope = super::KAPI_LOCK_ACQUIRES;
+                    } else if trimmed.starts_with("released:") {
+                        // KAPI_LOCK_RELEASED macro sets scope = RELEASES,
+                        // overriding any earlier scope. The generated
+                        // apispec.h emits these in source order, so
+                        // last-write-wins matches the binary layout.
+                        lock.scope = super::KAPI_LOCK_RELEASES;
+                    } else {
+                        // Continuation of description
+                        if !lock.description.is_empty() {
+                            lock.description.push(' ');
+                            lock.description.push_str(trimmed);
+                        }
+                    }
+                }
+            }
+            BlockContext::Return => {
+                if let Some(ret) = current_return.as_mut() {
+                    if let Some(rest) = trimmed.strip_prefix("type:") {
+                        let raw = rest.trim();
+                        ret.type_name = canon_kapi_type_name(raw);
+                        ret.return_type = self.parse_param_type(raw);
+                    } else if let Some(rest) = trimmed.strip_prefix("check-type:") {
+                        ret.check_type = self.parse_return_check_type(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("success:") {
+                        // Accepts "= 0", ">= 0", bare integer.
+                        let val = rest
+                            .trim()
+                            .trim_start_matches(|c: char| !c.is_ascii_digit() && c != '-');
+                        ret.success_value = val.parse().ok();
+                    } else if let Some(rest) = trimmed.strip_prefix("desc:") {
+                        let text = rest.trim().to_string();
+                        if ret.description.is_empty() {
+                            ret.description = text;
+                        } else {
+                            ret.description.push(' ');
+                            ret.description.push_str(&text);
+                        }
+                    } else {
+                        // Continuation of description
+                        if !ret.description.is_empty() {
+                            ret.description.push(' ');
+                            ret.description.push_str(trimmed);
+                        }
+                    }
+                }
+            }
+            BlockContext::StateTransition | BlockContext::None => {}
+        }
+    }
+
+    /// Flush the current block, pushing items into the spec
+    #[allow(clippy::too_many_arguments)]
+    fn flush_block(
+        &self,
+        block: &mut BlockContext,
+        spec: &mut ApiSpec,
+        current_error: &mut Option<ErrorSpec>,
+        current_signal: &mut Option<SignalSpec>,
+        current_capability: &mut Option<CapabilitySpec>,
+        current_side_effect: &mut Option<SideEffectSpec>,
+        current_constraint: &mut Option<ConstraintSpec>,
+        current_lock: &mut Option<LockSpec>,
+        current_return: &mut Option<ReturnSpec>,
+    ) {
+        match block {
+            BlockContext::Error(_) => {
+                if let Some(error) = current_error.take() {
+                    spec.errors.push(error);
+                }
+            }
+            BlockContext::Signal => {
+                if let Some(signal) = current_signal.take() {
+                    spec.signals.push(signal);
+                }
+            }
+            BlockContext::Capability => {
+                if let Some(cap) = current_capability.take() {
+                    spec.capabilities.push(cap);
+                }
+            }
+            BlockContext::SideEffect => {
+                if let Some(effect) = current_side_effect.take() {
+                    spec.side_effects.push(effect);
+                }
+            }
+            BlockContext::Constraint => {
+                if let Some(constraint) = current_constraint.take() {
+                    spec.constraints.push(constraint);
+                }
+            }
+            BlockContext::Lock => {
+                if let Some(lock) = current_lock.take() {
+                    spec.locks.push(lock);
+                }
+            }
+            BlockContext::Return => {
+                if let Some(ret) = current_return.take() {
+                    spec.return_spec = Some(ret);
+                }
+            }
+            _ => {}
+        }
+        *block = BlockContext::None;
+    }
+
+    /// Extract parameter type names from SYSCALL_DEFINE signature
+    fn extract_types_from_signature(&self, sig: &str) -> HashMap<String, String> {
+        let mut types = HashMap::new();
+
+        // Find content between outermost parens
+        let content = if let Some(start) = sig.find('(') {
+            let end = sig.rfind(')').unwrap_or(sig.len());
+            &sig[start + 1..end]
+        } else {
+            return types;
+        };
+
+        // Split by comma and process type/name pairs
+        // SYSCALL_DEFINE format: (syscall_name, type1, name1, type2, name2, ...)
+        let parts: Vec<&str> = content.split(',').map(|s| s.trim()).collect();
+
+        // Skip first part (syscall name), then process pairs
+        let mut i = 1;
+        while i + 1 < parts.len() {
+            let type_part = parts[i].trim();
+            let name_part = parts[i + 1].trim();
+
+            // Build the type_name string: "type name"
+            let type_name = format!("{} {}", type_part, name_part);
+            types.insert(name_part.to_string(), type_name);
+
+            i += 2;
+        }
+
+        types
+    }
+
+    fn collect_multiline_value(
+        &self,
+        lines: &[&str],
+        start_idx: usize,
+        first_part: &str,
+    ) -> (String, usize) {
+        let mut result = String::from(first_part.trim());
+        let mut i = start_idx + 1;
+
+        while i < lines.len() {
+            let line = lines[i];
+
+            if self.is_annotation_line(line) {
+                break;
+            }
+
+            if !line.trim().is_empty() && line.starts_with("  ") {
+                if !result.is_empty() {
+                    result.push(' ');
+                }
+                result.push_str(line.trim());
+            } else if line.trim().is_empty() {
+                i += 1;
+                continue;
+            } else {
+                break;
+            }
+
+            i += 1;
+        }
+
+        (result, i)
+    }
+
+    fn is_annotation_line(&self, line: &str) -> bool {
+        let trimmed = line.trim_start();
+        if !trimmed.contains(':') {
+            return false;
+        }
+        let annotations = [
+            "param:",
+            "param-",
+            "error:",
+            "error-",
+            "lock:",
+            "lock-",
+            "signal:",
+            "signal-",
+            "side-effect:",
+            "state-trans:",
+            "capability:",
+            "capability-",
+            "constraint:",
+            "constraint-",
+            "struct-",
+            "return:",
+            "return-",
+            "examples:",
+            "notes:",
+            "since-",
+            "context-",
+            "long-desc:",
+            "api-type:",
+        ];
+
+        for ann in &annotations {
+            if trimmed.starts_with(ann) {
+                return true;
+            }
+        }
+        false
+    }
+
+    /// Parse a constraint expression and apply it to `param`.
+    /// Shapes:
+    ///   NAME                         (e.g. "user_path", "nonzero")
+    ///   NAME ( ARG (, ARG)* )        (e.g. "range(0, 4096)", "buffer(2)")
+    /// Returns true if the expression matched a known constraint kind,
+    /// populating `param`'s numeric fields. Returns false if the text
+    /// is free-form, leaving `param` untouched.
+    fn apply_constraint_expr(&self, param: &mut ParamSpec, text: &str) -> bool {
+        let t = text.trim();
+        if t.is_empty() {
+            return false;
+        }
+        // Split NAME ( ARGS ) — no nesting, no escaping.
+        let (name, args): (&str, Option<&str>) = match (t.find('('), t.rfind(')')) {
+            (Some(lp), Some(rp)) if rp > lp => (t[..lp].trim(), Some(t[lp + 1..rp].trim())),
+            _ => (t, None),
+        };
+        // Bail out on anything that looks like free text (spaces inside the
+        // name part) so we don't swallow existing textual constraints.
+        if name.contains(char::is_whitespace) || name.is_empty() {
+            return false;
+        }
+        let name_lc = name.to_ascii_lowercase();
+        let split_args = || -> Vec<String> {
+            args.map(|a| a.split(',').map(|s| s.trim().to_string()).collect())
+                .unwrap_or_default()
+        };
+        match name_lc.as_str() {
+            "range" => {
+                let a = split_args();
+                if a.len() != 2 {
+                    return false;
+                }
+                param.min_value = a[0].parse().ok();
+                param.max_value = a[1].parse().ok();
+                param.constraint_type = 1; // KAPI_CONSTRAINT_RANGE
+                true
+            }
+            "mask" => {
+                let a = split_args();
+                if a.len() != 1 {
+                    return false;
+                }
+                // Symbolic masks (e.g. "O_RDONLY | O_WRONLY | ...") can't
+                // be resolved at parse time — leave valid_mask as None so
+                // downstream consumers treat the mask as unknown, matching
+                // the long-form `valid-mask:` handler (which also leaves
+                // the slot untouched when the value isn't a literal).
+                param.valid_mask = parse_u64_literal(&a[0]);
+                param.constraint_type = 2; // KAPI_CONSTRAINT_MASK
+                true
+            }
+            "enum" => {
+                let a = split_args();
+                if a.is_empty() {
+                    return false;
+                }
+                param.enum_values = a;
+                param.constraint_type = 3; // KAPI_CONSTRAINT_ENUM
+                true
+            }
+            "alignment" | "align" => {
+                let a = split_args();
+                if a.len() != 1 {
+                    return false;
+                }
+                param.alignment = a[0].parse().ok();
+                param.constraint_type = 4; // KAPI_CONSTRAINT_ALIGNMENT
+                true
+            }
+            "power_of_two" => {
+                if args.is_some() {
+                    return false;
+                }
+                param.constraint_type = 5; // KAPI_CONSTRAINT_POWER_OF_TWO
+                true
+            }
+            "page_aligned" => {
+                if args.is_some() {
+                    return false;
+                }
+                param.constraint_type = 6; // KAPI_CONSTRAINT_PAGE_ALIGNED
+                true
+            }
+            "nonzero" => {
+                if args.is_some() {
+                    return false;
+                }
+                param.constraint_type = 7; // KAPI_CONSTRAINT_NONZERO
+                true
+            }
+            "user_string" => {
+                // Optional size argument: user_string(N)
+                if let Some(arg) = args {
+                    if let Ok(n) = arg.trim().parse::<u32>() {
+                        param.size = Some(n);
+                    }
+                }
+                param.constraint_type = 8; // KAPI_CONSTRAINT_USER_STRING
+                true
+            }
+            "user_path" => {
+                if args.is_some() {
+                    return false;
+                }
+                param.constraint_type = 9; // KAPI_CONSTRAINT_USER_PATH
+                true
+            }
+            "user_ptr" => {
+                if args.is_some() {
+                    return false;
+                }
+                param.constraint_type = 10; // KAPI_CONSTRAINT_USER_PTR
+                true
+            }
+            "buffer" => {
+                // buffer(size_param_idx) — capture the index into
+                // param.size_param_idx so it matches the long-form
+                // `size-param: N` handler below (and the C struct
+                // field populated by KAPI_PARAM_SIZE_PARAM()).
+                let a = split_args();
+                if a.len() != 1 {
+                    return false;
+                }
+                param.size_param_idx = a[0].parse().ok();
+                param.constraint_type = 11; // KAPI_CONSTRAINT_BUFFER
+                true
+            }
+            "custom" => {
+                // custom(fn_name) — record function name as free-text constraint
+                // so downstream tooling can wire it up.
+                if let Some(arg) = args {
+                    param.constraint = Some(arg.trim().to_string());
+                }
+                param.constraint_type = 12; // KAPI_CONSTRAINT_CUSTOM
+                true
+            }
+            _ => false,
+        }
+    }
+
+    fn parse_context_flags(&self, flags: &str) -> Vec<String> {
+        flags
+            .split('|')
+            .map(|f| self.ctx_alias(f.trim()).to_string())
+            .filter(|f| !f.is_empty())
+            .collect()
+    }
+
+    /// Parse a comma-separated short-form context list
+    /// (e.g. "process, sleepable" -> ["KAPI_CTX_PROCESS", "KAPI_CTX_SLEEPABLE"]).
+    /// Tokens that already look like KAPI_CTX_* are passed through.
+    fn parse_context_list(&self, flags: &str) -> Vec<String> {
+        flags
+            .split(',')
+            .map(|f| self.ctx_alias(f.trim()).to_string())
+            .filter(|f| !f.is_empty())
+            .collect()
+    }
+
+    /// Canonicalise a single context token to its KAPI_CTX_* spelling.
+    /// Short aliases are case-insensitive. Unknown tokens pass through
+    /// verbatim so mixed/long-form input keeps working.
+    fn ctx_alias(&self, tok: &str) -> String {
+        let t = tok.trim();
+        if t.is_empty() {
+            return String::new();
+        }
+        match t.to_ascii_lowercase().as_str() {
+            "process" => "KAPI_CTX_PROCESS".to_string(),
+            "softirq" => "KAPI_CTX_SOFTIRQ".to_string(),
+            "hardirq" => "KAPI_CTX_HARDIRQ".to_string(),
+            "nmi" => "KAPI_CTX_NMI".to_string(),
+            "atomic" => "KAPI_CTX_ATOMIC".to_string(),
+            "sleepable" => "KAPI_CTX_SLEEPABLE".to_string(),
+            "preempt_disabled" => "KAPI_CTX_PREEMPT_DISABLED".to_string(),
+            "irq_disabled" => "KAPI_CTX_IRQ_DISABLED".to_string(),
+            _ => t.to_string(),
+        }
+    }
+
+    fn error_name_to_code(&self, name: &str) -> i32 {
+        match name {
+            "EPERM" => -1,
+            "ENOENT" => -2,
+            "ESRCH" => -3,
+            "EINTR" => -4,
+            "EIO" => -5,
+            "ENXIO" => -6,
+            "E2BIG" => -7,
+            "ENOEXEC" => -8,
+            "EBADF" => -9,
+            "ECHILD" => -10,
+            "EAGAIN" | "EWOULDBLOCK" => -11,
+            "ENOMEM" => -12,
+            "EACCES" => -13,
+            "EFAULT" => -14,
+            "ENOTBLK" => -15,
+            "EBUSY" => -16,
+            "EEXIST" => -17,
+            "EXDEV" => -18,
+            "ENODEV" => -19,
+            "ENOTDIR" => -20,
+            "EISDIR" => -21,
+            "EINVAL" => -22,
+            "ENFILE" => -23,
+            "EMFILE" => -24,
+            "ENOTTY" => -25,
+            "ETXTBSY" => -26,
+            "EFBIG" => -27,
+            "ENOSPC" => -28,
+            "ESPIPE" => -29,
+            "EROFS" => -30,
+            "EMLINK" => -31,
+            "EPIPE" => -32,
+            "EDOM" => -33,
+            "ERANGE" => -34,
+            "EDEADLK" => -35,
+            "ENAMETOOLONG" => -36,
+            "ENOLCK" => -37,
+            "ENOSYS" => -38,
+            "ENOTEMPTY" => -39,
+            "ELOOP" => -40,
+            "ENOMSG" => -42,
+            "ENODATA" => -61,
+            "ENOLINK" => -67,
+            "EPROTO" => -71,
+            "EOVERFLOW" => -75,
+            "ELIBBAD" => -80,
+            "EILSEQ" => -84,
+            "ENOTSOCK" => -88,
+            "EDESTADDRREQ" => -89,
+            "EMSGSIZE" => -90,
+            "EPROTOTYPE" => -91,
+            "ENOPROTOOPT" => -92,
+            "EPROTONOSUPPORT" => -93,
+            "EOPNOTSUPP" | "ENOTSUP" => -95,
+            "EADDRINUSE" => -98,
+            "EADDRNOTAVAIL" => -99,
+            "ENETDOWN" => -100,
+            "ENETUNREACH" => -101,
+            "ENETRESET" => -102,
+            "ECONNABORTED" => -103,
+            "ECONNRESET" => -104,
+            "ENOBUFS" => -105,
+            "EISCONN" => -106,
+            "ENOTCONN" => -107,
+            "ETIMEDOUT" => -110,
+            "ECONNREFUSED" => -111,
+            "EALREADY" => -114,
+            "EINPROGRESS" => -115,
+            "ESTALE" => -116,
+            "EDQUOT" => -122,
+            "ENOMEDIUM" => -123,
+            "ENOKEY" => -126,
+            "ERESTARTSYS" => -512,
+            _ => 0,
+        }
+    }
+
+    /// Map a KAPI_TYPE_* token (or its short-form alias) to the numeric
+    /// value declared in `enum kapi_param_type` in
+    /// `include/linux/kernel_api_spec.h`.
+    fn parse_param_type(&self, type_str: &str) -> u32 {
+        let s = type_str.trim();
+        match s {
+            "KAPI_TYPE_VOID" => 0,
+            "KAPI_TYPE_INT" => 1,
+            "KAPI_TYPE_UINT" => 2,
+            "KAPI_TYPE_PTR" => 3,
+            "KAPI_TYPE_STRUCT" => 4,
+            "KAPI_TYPE_UNION" => 5,
+            "KAPI_TYPE_ENUM" => 6,
+            "KAPI_TYPE_FUNC_PTR" => 7,
+            "KAPI_TYPE_ARRAY" => 8,
+            "KAPI_TYPE_FD" => 9,
+            "KAPI_TYPE_USER_PTR" => 10,
+            "KAPI_TYPE_PATH" => 11,
+            "KAPI_TYPE_CUSTOM" => 12,
+            _ => match s.to_ascii_lowercase().as_str() {
+                "void" => 0,
+                "int" => 1,
+                "uint" => 2,
+                "ptr" => 3,
+                "struct" => 4,
+                "union" => 5,
+                "enum" => 6,
+                "func_ptr" => 7,
+                "array" => 8,
+                "fd" => 9,
+                "user_ptr" | "uptr" => 10,
+                "path" => 11,
+                "custom" => 12,
+                _ => 0,
+            },
+        }
+    }
+
+    /// Map a KAPI_CONSTRAINT_* token to the numeric value declared in
+    /// `enum kapi_constraint_type` in `include/linux/kernel_api_spec.h`.
+    fn parse_constraint_type(&self, type_str: &str) -> u32 {
+        let s = type_str.trim();
+        match s {
+            "KAPI_CONSTRAINT_NONE" => 0,
+            "KAPI_CONSTRAINT_RANGE" => 1,
+            "KAPI_CONSTRAINT_MASK" => 2,
+            "KAPI_CONSTRAINT_ENUM" => 3,
+            "KAPI_CONSTRAINT_ALIGNMENT" => 4,
+            "KAPI_CONSTRAINT_POWER_OF_TWO" => 5,
+            "KAPI_CONSTRAINT_PAGE_ALIGNED" => 6,
+            "KAPI_CONSTRAINT_NONZERO" => 7,
+            "KAPI_CONSTRAINT_USER_STRING" => 8,
+            "KAPI_CONSTRAINT_USER_PATH" => 9,
+            "KAPI_CONSTRAINT_USER_PTR" => 10,
+            "KAPI_CONSTRAINT_BUFFER" => 11,
+            "KAPI_CONSTRAINT_CUSTOM" => 12,
+            _ => 0,
+        }
+    }
+
+    fn parse_field_type(&self, type_str: &str) -> u32 {
+        match type_str {
+            "__s32" | "int" => 1,
+            "__u32" | "unsigned int" => 2,
+            "__s64" | "long" => 3,
+            "__u64" | "unsigned long" => 4,
+            _ => 0,
+        }
+    }
+
+    fn parse_param_flags(&self, flags: &str) -> u32 {
+        flags
+            .split('|')
+            .map(|f| self.parse_param_flag_token(f.trim()))
+            .fold(0, |acc, bit| acc | bit)
+    }
+
+    /// Parse one flag token (long or short form, case-insensitive for
+    /// short form). Returns 0 for unknown tokens.
+    fn parse_param_flag_token(&self, tok: &str) -> u32 {
+        let t = tok.trim();
+        // Long / existing short forms first.
+        match t {
+            "KAPI_PARAM_IN" | "IN" => return 1,
+            "KAPI_PARAM_OUT" | "OUT" => return 2,
+            "KAPI_PARAM_INOUT" | "INOUT" => return 3,
+            "KAPI_PARAM_OPTIONAL" | "OPTIONAL" => return 1 << 3,
+            "KAPI_PARAM_CONST" | "CONST" => return 1 << 4,
+            "KAPI_PARAM_VOLATILE" | "VOLATILE" => return 1 << 5,
+            "KAPI_PARAM_USER" | "USER" => return 1 << 6,
+            "KAPI_PARAM_DMA" | "DMA" => return 1 << 7,
+            "KAPI_PARAM_ALIGNED" | "ALIGNED" => return 1 << 8,
+            _ => {}
+        }
+        // English short aliases (case-insensitive).
+        match t.to_ascii_lowercase().as_str() {
+            "input" => 1,
+            "output" => 2,
+            "inout" => 3,
+            "optional" => 1 << 3,
+            "const" => 1 << 4,
+            "volatile" => 1 << 5,
+            "user" => 1 << 6,
+            "dma" => 1 << 7,
+            "aligned" => 1 << 8,
+            _ => 0,
+        }
+    }
+
+    /// Map a KAPI_LOCK_* token to the numeric value declared in
+    /// `enum kapi_lock_type` in `include/linux/kernel_api_spec.h`.
+    fn parse_lock_type(&self, type_str: &str) -> u32 {
+        let s = type_str.trim();
+        match s {
+            "KAPI_LOCK_NONE" => 0,
+            "KAPI_LOCK_MUTEX" => 1,
+            "KAPI_LOCK_SPINLOCK" => 2,
+            "KAPI_LOCK_RWLOCK" => 3,
+            "KAPI_LOCK_SEQLOCK" => 4,
+            "KAPI_LOCK_RCU" => 5,
+            "KAPI_LOCK_SEMAPHORE" => 6,
+            "KAPI_LOCK_CUSTOM" => 7,
+            _ => match s.to_ascii_lowercase().as_str() {
+                "none" => 0,
+                "mutex" => 1,
+                "spinlock" => 2,
+                "rwlock" => 3,
+                "seqlock" => 4,
+                "rcu" => 5,
+                "semaphore" => 6,
+                "custom" => 7,
+                _ => 0,
+            },
+        }
+    }
+
+    fn parse_signal_direction(&self, dir: &str) -> u32 {
+        let s = dir.trim();
+        match s {
+            "KAPI_SIGNAL_RECEIVE" => 1,
+            "KAPI_SIGNAL_SEND" => 2,
+            "KAPI_SIGNAL_HANDLE" => 4,
+            "KAPI_SIGNAL_BLOCK" => 8,
+            "KAPI_SIGNAL_IGNORE" => 16,
+            _ => match s.to_ascii_lowercase().as_str() {
+                "receive" => 1,
+                "send" => 2,
+                "handle" => 4,
+                "block" => 8,
+                "ignore" => 16,
+                _ => 0,
+            },
+        }
+    }
+
+    fn parse_signal_action(&self, action: &str) -> u32 {
+        let s = action.trim();
+        match s {
+            "KAPI_SIGNAL_ACTION_DEFAULT" => 0,
+            "KAPI_SIGNAL_ACTION_TERMINATE" => 1,
+            "KAPI_SIGNAL_ACTION_COREDUMP" => 2,
+            "KAPI_SIGNAL_ACTION_STOP" => 3,
+            "KAPI_SIGNAL_ACTION_CONTINUE" => 4,
+            "KAPI_SIGNAL_ACTION_CUSTOM" => 5,
+            "KAPI_SIGNAL_ACTION_RETURN" => 6,
+            "KAPI_SIGNAL_ACTION_RESTART" => 7,
+            "KAPI_SIGNAL_ACTION_QUEUE" => 8,
+            "KAPI_SIGNAL_ACTION_DISCARD" => 9,
+            "KAPI_SIGNAL_ACTION_TRANSFORM" => 10,
+            _ => match s.to_ascii_lowercase().as_str() {
+                "default" => 0,
+                "terminate" => 1,
+                "coredump" => 2,
+                "stop" => 3,
+                "continue" => 4,
+                "custom" => 5,
+                "return" => 6,
+                "restart" => 7,
+                "queue" => 8,
+                "discard" => 9,
+                "transform" => 10,
+                _ => 0,
+            },
+        }
+    }
+
+    fn parse_signal_timing(&self, timing: &str) -> u32 {
+        let s = timing.trim();
+        match s {
+            "KAPI_SIGNAL_TIME_BEFORE" => 0,
+            "KAPI_SIGNAL_TIME_DURING" => 1,
+            "KAPI_SIGNAL_TIME_AFTER" => 2,
+            _ => match s.to_ascii_lowercase().as_str() {
+                "before" => 0,
+                "during" => 1,
+                "after" => 2,
+                _ => 0,
+            },
+        }
+    }
+
+    fn parse_signal_state(&self, state: &str) -> u32 {
+        match state {
+            "KAPI_SIGNAL_STATE_RUNNING" => 1,
+            "KAPI_SIGNAL_STATE_SLEEPING" => 2,
+            _ => 0,
+        }
+    }
+
+    /// Accept a hex literal ("0x4"), a decimal literal ("4"), or a '|'-separated
+    /// bitmask expression. Unknown tokens contribute 0.
+    fn parse_hex_or_bitmask(&self, value: &str) -> u32 {
+        let v = value.trim();
+        if let Some(hex) = v.strip_prefix("0x").or_else(|| v.strip_prefix("0X")) {
+            if let Ok(n) = u32::from_str_radix(hex, 16) {
+                return n;
+            }
+        }
+        if let Ok(n) = v.parse::<u32>() {
+            return n;
+        }
+        let mut acc = 0u32;
+        for part in v.split(['|', ',']) {
+            let t = part.trim();
+            if t.is_empty() {
+                continue;
+            }
+            if let Some(hex) = t.strip_prefix("0x").or_else(|| t.strip_prefix("0X")) {
+                if let Ok(n) = u32::from_str_radix(hex, 16) {
+                    acc |= n;
+                    continue;
+                }
+            }
+            if let Ok(n) = t.parse::<u32>() {
+                acc |= n;
+            }
+        }
+        acc
+    }
+
+    /// Parse a '|'-separated list of KAPI_SIGNAL_STATE_* tokens (or short
+    /// names like "RUNNING") and OR their bit values together. Matches the
+    /// BIT(N) definitions in kernel_api_spec.h.
+    fn parse_signal_state_mask(&self, value: &str) -> u32 {
+        let mut acc = 0u32;
+        for part in value.split(['|', ',']) {
+            let t = part.trim().trim_start_matches("KAPI_SIGNAL_STATE_");
+            let bit = match t.to_ascii_uppercase().as_str() {
+                "RUNNING" => 1 << 0,
+                "SLEEPING" => 1 << 1,
+                "STOPPED" => 1 << 2,
+                "TRACED" => 1 << 3,
+                "ZOMBIE" => 1 << 4,
+                "DEAD" => 1 << 5,
+                _ => 0,
+            };
+            acc |= bit;
+        }
+        acc
+    }
+
+    /// Bitmask of `KAPI_EFFECT_*` values joined by '|' or ','.
+    /// Values match `enum kapi_side_effect_type` in
+    /// `include/linux/kernel_api_spec.h`.
+    fn parse_effect_type(&self, type_str: &str) -> u32 {
+        let sep = if type_str.contains('|') || !type_str.contains(',') {
+            '|'
+        } else {
+            ','
+        };
+        let mut result = 0;
+        for flag in type_str.split(sep) {
+            let t = flag.trim();
+            let bit = match t {
+                "KAPI_EFFECT_NONE" => 0,
+                "KAPI_EFFECT_ALLOC_MEMORY" => 1 << 0,
+                "KAPI_EFFECT_FREE_MEMORY" => 1 << 1,
+                "KAPI_EFFECT_MODIFY_STATE" => 1 << 2,
+                "KAPI_EFFECT_SIGNAL_SEND" => 1 << 3,
+                "KAPI_EFFECT_FILE_POSITION" => 1 << 4,
+                "KAPI_EFFECT_LOCK_ACQUIRE" => 1 << 5,
+                "KAPI_EFFECT_LOCK_RELEASE" => 1 << 6,
+                "KAPI_EFFECT_RESOURCE_CREATE" => 1 << 7,
+                "KAPI_EFFECT_RESOURCE_DESTROY" => 1 << 8,
+                "KAPI_EFFECT_SCHEDULE" => 1 << 9,
+                "KAPI_EFFECT_HARDWARE" => 1 << 10,
+                "KAPI_EFFECT_NETWORK" => 1 << 11,
+                "KAPI_EFFECT_FILESYSTEM" => 1 << 12,
+                "KAPI_EFFECT_PROCESS_STATE" => 1 << 13,
+                "KAPI_EFFECT_IRREVERSIBLE" => 1 << 14,
+                _ => match t.to_ascii_lowercase().as_str() {
+                    "none" => 0,
+                    "alloc_memory" => 1 << 0,
+                    "free_memory" => 1 << 1,
+                    "modify_state" => 1 << 2,
+                    "signal_send" => 1 << 3,
+                    "file_position" => 1 << 4,
+                    "lock_acquire" => 1 << 5,
+                    "lock_release" => 1 << 6,
+                    "resource_create" => 1 << 7,
+                    "resource_destroy" => 1 << 8,
+                    "schedule" => 1 << 9,
+                    "hardware" => 1 << 10,
+                    "network" => 1 << 11,
+                    "filesystem" => 1 << 12,
+                    "process_state" => 1 << 13,
+                    "irreversible" => 1 << 14,
+                    _ => 0,
+                },
+            };
+            result |= bit;
+        }
+        result
+    }
+
+    fn parse_capability_value(&self, cap: &str) -> i32 {
+        match cap {
+            "CAP_CHOWN" => 0,
+            "CAP_DAC_OVERRIDE" => 1,
+            "CAP_DAC_READ_SEARCH" => 2,
+            "CAP_FOWNER" => 3,
+            "CAP_FSETID" => 4,
+            "CAP_KILL" => 5,
+            "CAP_SETGID" => 6,
+            "CAP_SETUID" => 7,
+            "CAP_SETPCAP" => 8,
+            "CAP_LINUX_IMMUTABLE" => 9,
+            "CAP_NET_BIND_SERVICE" => 10,
+            "CAP_NET_BROADCAST" => 11,
+            "CAP_NET_ADMIN" => 12,
+            "CAP_NET_RAW" => 13,
+            "CAP_IPC_LOCK" => 14,
+            "CAP_IPC_OWNER" => 15,
+            "CAP_SYS_MODULE" => 16,
+            "CAP_SYS_RAWIO" => 17,
+            "CAP_SYS_CHROOT" => 18,
+            "CAP_SYS_PTRACE" => 19,
+            "CAP_SYS_PACCT" => 20,
+            "CAP_SYS_ADMIN" => 21,
+            "CAP_SYS_BOOT" => 22,
+            "CAP_SYS_NICE" => 23,
+            "CAP_SYS_RESOURCE" => 24,
+            "CAP_SYS_TIME" => 25,
+            "CAP_SYS_TTY_CONFIG" => 26,
+            "CAP_MKNOD" => 27,
+            "CAP_LEASE" => 28,
+            "CAP_AUDIT_WRITE" => 29,
+            "CAP_AUDIT_CONTROL" => 30,
+            "CAP_SETFCAP" => 31,
+            "CAP_MAC_OVERRIDE" => 32,
+            "CAP_MAC_ADMIN" => 33,
+            "CAP_SYSLOG" => 34,
+            "CAP_WAKE_ALARM" => 35,
+            "CAP_BLOCK_SUSPEND" => 36,
+            "CAP_AUDIT_READ" => 37,
+            "CAP_PERFMON" => 38,
+            "CAP_BPF" => 39,
+            "CAP_CHECKPOINT_RESTORE" => 40,
+            _ => 0,
+        }
+    }
+
+    /// Map a KAPI_RETURN_* token to the numeric value declared in
+    /// `enum kapi_return_check_type` in `include/linux/kernel_api_spec.h`.
+    fn parse_return_check_type(&self, check: &str) -> u32 {
+        let s = check.trim();
+        match s {
+            "KAPI_RETURN_EXACT" => 0,
+            "KAPI_RETURN_RANGE" => 1,
+            "KAPI_RETURN_ERROR_CHECK" => 2,
+            "KAPI_RETURN_FD" => 3,
+            "KAPI_RETURN_CUSTOM" => 4,
+            "KAPI_RETURN_NO_RETURN" => 5,
+            _ => match s.to_ascii_lowercase().as_str() {
+                "exact" => 0,
+                "range" => 1,
+                "error_check" => 2,
+                "fd" => 3,
+                "custom" => 4,
+                "no_return" => 5,
+                _ => 0,
+            },
+        }
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    fn parser() -> KerneldocParserImpl {
+        KerneldocParserImpl::new()
+    }
+
+    #[test]
+    fn parse_minimal_kerneldoc() {
+        let doc = "\
+sys_foo - Do something useful
+context-flags: KAPI_CTX_PROCESS
+param-count: 1
+@fd: The file descriptor
+param-type: fd, KAPI_TYPE_INT
+error: EBADF, Bad file descriptor
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_foo", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.name, "sys_foo");
+        assert_eq!(spec.api_type, "syscall");
+        assert_eq!(spec.description.as_deref(), Some("Do something useful"));
+        assert_eq!(spec.param_count, Some(1));
+        assert_eq!(spec.parameters.len(), 1);
+        assert_eq!(spec.parameters[0].name, "fd");
+        assert_eq!(spec.parameters[0].description, "The file descriptor");
+        assert_eq!(spec.parameters[0].param_type, 1); // KAPI_TYPE_INT
+        assert_eq!(spec.errors.len(), 1);
+        assert_eq!(spec.errors[0].name, "EBADF");
+        assert_eq!(spec.errors[0].error_code, -9);
+    }
+
+    #[test]
+    fn parse_multiple_param_types() {
+        let doc = "\
+sys_bar - Multiple params
+@fd: file descriptor arg
+@buf: user buffer
+@count: byte count
+@flags: option flags
+param-type: fd, KAPI_TYPE_FD
+param-type: buf, KAPI_TYPE_USER_PTR
+param-type: count, KAPI_TYPE_UINT
+param-type: flags, KAPI_TYPE_UINT
+";
+        let sig = "(bar, int, fd, char __user *, buf, size_t, count, unsigned long, flags)";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_bar", "syscall", Some(sig))
+            .unwrap();
+
+        assert_eq!(spec.parameters.len(), 4);
+
+        let fd_param = spec.parameters.iter().find(|p| p.name == "fd").unwrap();
+        assert_eq!(fd_param.param_type, 9); // FD (kernel enum)
+
+        let buf_param = spec.parameters.iter().find(|p| p.name == "buf").unwrap();
+        assert_eq!(buf_param.param_type, 10); // USER_PTR (kernel enum)
+        assert_eq!(buf_param.type_name, "char __user * buf");
+
+        let count_param = spec.parameters.iter().find(|p| p.name == "count").unwrap();
+        assert_eq!(count_param.param_type, 2); // UINT
+
+        let flags_param = spec.parameters.iter().find(|p| p.name == "flags").unwrap();
+        assert_eq!(flags_param.param_type, 2); // UINT
+    }
+
+    #[test]
+    fn parse_error_codes_with_descriptions() {
+        let doc = "\
+sys_err - Error test
+error: EBADF
+  desc: Bad file descriptor
+  condition: fd < 0
+error: EFAULT
+  desc: Bad user pointer
+  condition: buf is NULL
+error: EINVAL
+  desc: Invalid argument
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_err", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.errors.len(), 3);
+
+        assert_eq!(spec.errors[0].name, "EBADF");
+        assert_eq!(spec.errors[0].error_code, -9);
+        assert_eq!(spec.errors[0].description, "Bad file descriptor");
+        assert_eq!(spec.errors[0].condition, "fd < 0");
+
+        assert_eq!(spec.errors[1].name, "EFAULT");
+        assert_eq!(spec.errors[1].error_code, -14);
+        assert_eq!(spec.errors[1].description, "Bad user pointer");
+
+        assert_eq!(spec.errors[2].name, "EINVAL");
+        assert_eq!(spec.errors[2].error_code, -22);
+        assert_eq!(spec.errors[2].description, "Invalid argument");
+    }
+
+    #[test]
+    fn parse_context_flags() {
+        let doc = "\
+sys_ctx - Context test
+context-flags: KAPI_CTX_PROCESS|KAPI_CTX_SLEEPABLE
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_ctx", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.context_flags.len(), 2);
+        assert_eq!(spec.context_flags[0], "KAPI_CTX_PROCESS");
+        assert_eq!(spec.context_flags[1], "KAPI_CTX_SLEEPABLE");
+    }
+
+    #[test]
+    fn parse_context_list_short() {
+        // "contexts: process, sleepable" -> KAPI_CTX_PROCESS | SLEEPABLE
+        let doc = "\
+sys_ctx - Context test
+contexts: process, sleepable
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_ctx", "syscall", None)
+            .unwrap();
+
+        assert_eq!(
+            spec.context_flags,
+            vec![
+                "KAPI_CTX_PROCESS".to_string(),
+                "KAPI_CTX_SLEEPABLE".to_string(),
+            ]
+        );
+    }
+
+    #[test]
+    fn parse_context_list_mixed() {
+        // Short tokens intermixed with explicit KAPI_CTX_* still work.
+        let doc = "\
+sys_ctx - Context test
+contexts: process, KAPI_CTX_SLEEPABLE, softirq
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_ctx", "syscall", None)
+            .unwrap();
+
+        assert_eq!(
+            spec.context_flags,
+            vec![
+                "KAPI_CTX_PROCESS".to_string(),
+                "KAPI_CTX_SLEEPABLE".to_string(),
+                "KAPI_CTX_SOFTIRQ".to_string(),
+            ]
+        );
+    }
+
+    #[test]
+    fn parse_context_flags_long_with_short_token() {
+        // Long-form "context-flags:" still accepts "|"-joined short
+        // aliases so mid-migration files parse correctly.
+        let doc = "\
+sys_ctx - Context test
+context-flags: process | KAPI_CTX_SLEEPABLE
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_ctx", "syscall", None)
+            .unwrap();
+
+        assert_eq!(
+            spec.context_flags,
+            vec![
+                "KAPI_CTX_PROCESS".to_string(),
+                "KAPI_CTX_SLEEPABLE".to_string(),
+            ]
+        );
+    }
+
+    #[test]
+    fn parse_param_type_short_combined() {
+        // "type: uint, input" combines the type and flag aliases.
+        let doc = "\
+sys_t - Short type test
+param: size
+  type: uint, input
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_t", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.parameters.len(), 1);
+        assert_eq!(spec.parameters[0].param_type, 2); // KAPI_TYPE_UINT
+        assert_eq!(spec.parameters[0].flags, 1); // KAPI_PARAM_IN
+    }
+
+    #[test]
+    fn parse_param_type_short_multi_flag() {
+        // "type: path, input, user" sets both the IN and USER flags.
+        let doc = "\
+sys_t - Short type test
+param: filename
+  type: path, input, user
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_t", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.parameters.len(), 1);
+        assert_eq!(spec.parameters[0].param_type, 11); // PATH (kernel enum)
+        assert_eq!(spec.parameters[0].flags, 1 | (1 << 6)); // IN | USER
+    }
+
+    #[test]
+    fn parse_constraint_type_range_expr() {
+        // Short form: "constraint-type: range(0, 4096)" replaces the
+        // two-line long form "constraint-type: KAPI_CONSTRAINT_RANGE"
+        // + "range: 0, 4096".
+        let doc = "\
+sys_c - Constraint test
+param: count
+  type: uint, input
+  constraint-type: range(0, 4096)
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_c", "syscall", None)
+            .unwrap();
+
+        let p = &spec.parameters[0];
+        assert_eq!(p.constraint_type, 1); // KAPI_CONSTRAINT_RANGE
+        assert_eq!(p.min_value, Some(0));
+        assert_eq!(p.max_value, Some(4096));
+    }
+
+    #[test]
+    fn parse_constraint_type_mask_expr() {
+        let doc = "\
+sys_c - Constraint test
+param: flags
+  type: uint, input
+  constraint-type: mask(0xff)
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_c", "syscall", None)
+            .unwrap();
+
+        let p = &spec.parameters[0];
+        assert_eq!(p.constraint_type, 2); // KAPI_CONSTRAINT_MASK
+        assert_eq!(p.valid_mask, Some(0xff));
+    }
+
+    #[test]
+    fn user_ptr_type_implies_user_flag() {
+        let doc = "\
+sys_u - Implicit user flag test
+param: buf
+  type: user_ptr, output
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_u", "syscall", None)
+            .unwrap();
+
+        let p = &spec.parameters[0];
+        assert_eq!(p.param_type, 10); // KAPI_TYPE_USER_PTR
+        assert_eq!(
+            p.flags,
+            (1 << 1) | (1 << 6), // OUT | USER
+            "user_ptr type must imply KAPI_PARAM_USER"
+        );
+    }
+
+    #[test]
+    fn fd_type_does_not_imply_user_flag() {
+        // Only user_ptr / path imply KAPI_PARAM_USER. fd, int, uint,
+        // and every other non-user-space type must leave flags alone.
+        let doc = "\
+sys_fd - fd has no implicit user flag
+param: fd
+  type: fd, input
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_fd", "syscall", None)
+            .unwrap();
+
+        let p = &spec.parameters[0];
+        assert_eq!(p.param_type, 9);
+        assert_eq!(p.flags, 1, "fd must not auto-set KAPI_PARAM_USER");
+    }
+
+    #[test]
+    fn path_type_implies_user_flag() {
+        let doc = "\
+sys_p - Path implicit user flag
+param: filename
+  type: path, input
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_p", "syscall", None)
+            .unwrap();
+
+        let p = &spec.parameters[0];
+        assert_eq!(p.param_type, 11);
+        assert_eq!(
+            p.flags,
+            1 | (1 << 6), // IN | USER
+            "path type must imply KAPI_PARAM_USER"
+        );
+    }
+
+    #[test]
+    fn short_form_enum_equivalence() {
+        // Short-form and long-form renderings of the same spec must
+        // produce identical ApiSpec output across every enum family:
+        // context flags, param type+flags, constraint type, lock type,
+        // signal direction/action/timing, capability action, side-effect
+        // bitmask, return check type.
+        let long = "\
+sys_x - Enum short form test
+context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+
+param: fd
+  type: KAPI_TYPE_FD
+  flags: KAPI_PARAM_IN
+
+lock: files->file_lock
+  type: KAPI_LOCK_SPINLOCK
+  scope: acquires
+  desc: table lock
+
+signal: pending_signals
+  direction: KAPI_SIGNAL_RECEIVE
+  action: KAPI_SIGNAL_ACTION_RETURN
+  timing: KAPI_SIGNAL_TIME_DURING
+  desc: sig
+
+capability: CAP_SYS_ADMIN
+  type: KAPI_CAP_BYPASS_CHECK
+
+return:
+  type: KAPI_TYPE_INT
+  check-type: KAPI_RETURN_FD
+  desc: fd or errno
+
+side-effect: KAPI_EFFECT_RESOURCE_CREATE | KAPI_EFFECT_ALLOC_MEMORY
+  target: t
+  desc: d
+";
+        let short = "\
+sys_x - Enum short form test
+contexts: process, sleepable
+
+param: fd
+  type: fd, input
+
+lock: files->file_lock
+  type: spinlock
+  scope: acquires
+  desc: table lock
+
+signal: pending_signals
+  direction: receive
+  action: return
+  timing: during
+  desc: sig
+
+capability: CAP_SYS_ADMIN
+  type: bypass_check
+
+return:
+  type: int
+  check-type: fd
+  desc: fd or errno
+
+side-effect: resource_create | alloc_memory
+  target: t
+  desc: d
+";
+        let sp_l = parser()
+            .parse_kerneldoc(long, "sys_x", "syscall", None)
+            .unwrap();
+        let sp_s = parser()
+            .parse_kerneldoc(short, "sys_x", "syscall", None)
+            .unwrap();
+        assert_eq!(
+            format!("{:#?}", sp_l),
+            format!("{:#?}", sp_s),
+            "long-form and short-form of every enum family must normalise identically"
+        );
+    }
+
+    #[test]
+    fn parse_buffer_short_captures_size_param_idx() {
+        let doc = "\
+sys_b - Buffer test
+param: buf
+  type: user_ptr, output, user
+  constraint-type: buffer(2)
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_b", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.parameters[0].constraint_type, 11);
+        assert_eq!(spec.parameters[0].size_param_idx, Some(2));
+    }
+
+    #[test]
+    fn buffer_short_and_size_param_long_are_symmetric() {
+        let short = "\
+sys_b - Symmetric buffer test
+param: buf
+  type: user_ptr, output, user
+  constraint-type: buffer(2)
+";
+        let long = "\
+sys_b - Symmetric buffer test
+param: buf
+  type: KAPI_TYPE_USER_PTR
+  flags: KAPI_PARAM_OUT | KAPI_PARAM_USER
+  constraint-type: KAPI_CONSTRAINT_BUFFER
+  size-param: 2
+";
+        let sp_s = parser()
+            .parse_kerneldoc(short, "sys_b", "syscall", None)
+            .unwrap();
+        let sp_l = parser()
+            .parse_kerneldoc(long, "sys_b", "syscall", None)
+            .unwrap();
+        assert_eq!(format!("{:#?}", sp_s), format!("{:#?}", sp_l));
+    }
+
+    #[test]
+    fn parse_constraint_type_bare_user_path() {
+        let doc = "\
+sys_c - Constraint test
+param: filename
+  type: path, input, user
+  constraint-type: user_path
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_c", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.parameters[0].constraint_type, 9); // USER_PATH
+    }
+
+    #[test]
+    fn is_block_key_recognises_ident_colon() {
+        // Any bare `IDENT:` indented line must end a continuation fold.
+        assert!(super::is_block_key("type:"));
+        assert!(super::is_block_key("constraint-type:"));
+        assert!(super::is_block_key("valid-mask: 0xff"));
+        assert!(super::is_block_key("error: -EINTR"));
+        assert!(super::is_block_key("expr: some expression"));
+        assert!(super::is_block_key("reversible: yes"));
+        // Expression fragments and punctuation are not block keys.
+        assert!(!super::is_block_key("O_RDONLY | O_WRONLY |"));
+        assert!(!super::is_block_key(")"));
+        assert!(!super::is_block_key("Must be positive."));
+    }
+
+    #[test]
+    fn multiline_fold_stops_at_sibling_block_attribute() {
+        // A signal: block below a param: block. The constraint-type's
+        // continuation must not greedily eat the next signal block's
+        // `direction:` or the final `error:` line. (Kerneldoc section
+        // headers are at indent 0, which the top-level fold check stops
+        // on anyway; this test asserts that sibling *indented* keys
+        // also stop the fold.)
+        let doc = "\
+sys_y - Fold stop test
+param: f
+  type: int, input
+  constraint-type: mask(FOO |
+                        BAR)
+  cdesc: something about f
+  direction: KAPI_SIGNAL_RECEIVE
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_y", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.parameters.len(), 1);
+        // If the fold over-consumed, `cdesc:` would have been swallowed
+        // into the mask expression and param.constraint_type would be 0.
+        assert_eq!(spec.parameters[0].constraint_type, 2);
+    }
+
+    #[test]
+    fn parse_constraint_type_mask_expr_multiline() {
+        // Real-world sys_open/flags case: a symbolic mask split across
+        // four continuation lines. The parser must fold the continuation
+        // lines before running the function-call match, otherwise the
+        // constraint type silently decays to 0.
+        let doc = "\
+sys_x - Multi-line mask test
+param: f
+  type: int, input
+  constraint-type: mask(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY |
+                        O_TRUNC | O_APPEND | O_NONBLOCK | O_DSYNC | O_SYNC | FASYNC |
+                        O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | O_NOATIME |
+                        O_CLOEXEC | O_PATH | O_TMPFILE)
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_x", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.parameters.len(), 1);
+        let p = &spec.parameters[0];
+        assert_eq!(p.constraint_type, 2, "multi-line mask must set MASK type");
+        // Symbolic mask — must stay unresolved rather than becoming Some(0).
+        assert_eq!(
+            p.valid_mask, None,
+            "symbolic mask values must remain None, not Some(0)"
+        );
+    }
+
+    #[test]
+    fn parse_constraint_long_form_still_works() {
+        let doc = "\
+sys_c - Constraint test
+param: foo
+  type: uint, input
+  constraint-type: KAPI_CONSTRAINT_MASK
+  valid-mask: 0xff
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_c", "syscall", None)
+            .unwrap();
+
+        let p = &spec.parameters[0];
+        assert_eq!(p.constraint_type, 2); // KAPI_CONSTRAINT_MASK
+    }
+
+    #[test]
+    fn parse_constraint_free_text_still_works() {
+        // `constraint:` carries free-text constraint description;
+        // function-call short form lives on `constraint-type:`.
+        let doc = "\
+sys_c - Constraint test
+param: foo
+  type: uint, input
+  constraint: must be a valid page descriptor
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_c", "syscall", None)
+            .unwrap();
+
+        let p = &spec.parameters[0];
+        assert_eq!(p.constraint_type, 0);
+        assert_eq!(
+            p.constraint.as_deref(),
+            Some("must be a valid page descriptor")
+        );
+    }
+
+    #[test]
+    fn parse_description_alias_overrides_kerneldoc() {
+        // `description:` inside a `param:` block is an alias for `desc:`
+        // and overrides the @param description.
+        let doc = "\
+sys_d - Description alias test
+@size: kerneldoc short description
+param: size
+  type: uint, input
+  description: The new long form description.
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_d", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.parameters.len(), 1);
+        assert_eq!(
+            spec.parameters[0].description,
+            "The new long form description."
+        );
+    }
+
+    #[test]
+    fn canonical_equivalence_short_vs_long() {
+        // The regression test for the DSL cleanup: two spellings of the
+        // same spec must produce identical ApiSpec JSON.
+        let long = "\
+sys_open - open a file
+context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+
+param: filename
+  type: KAPI_TYPE_PATH
+  flags: KAPI_PARAM_IN | KAPI_PARAM_USER
+  constraint-type: KAPI_CONSTRAINT_USER_PATH
+  desc: Pathname to open
+
+param: count
+  type: KAPI_TYPE_UINT
+  flags: KAPI_PARAM_IN
+  constraint-type: KAPI_CONSTRAINT_RANGE
+  range: 0, 4096
+  desc: Byte count
+";
+        let short = "\
+sys_open - open a file
+contexts: process, sleepable
+
+param: filename
+  type: path, input, user
+  constraint-type: user_path
+  description: Pathname to open
+
+param: count
+  type: uint, input
+  constraint-type: range(0, 4096)
+  description: Byte count
+";
+        let long_spec = parser()
+            .parse_kerneldoc(long, "sys_open", "syscall", None)
+            .unwrap();
+        let short_spec = parser()
+            .parse_kerneldoc(short, "sys_open", "syscall", None)
+            .unwrap();
+
+        // ApiSpec isn't Serialize as a whole, so compare the Debug
+        // rendering — that still proves every field canonicalises
+        // identically.
+        let d_long = format!("{:#?}", long_spec);
+        let d_short = format!("{:#?}", short_spec);
+        assert_eq!(
+            d_long, d_short,
+            "short-form and long-form specs must normalise identically"
+        );
+    }
+
+    #[test]
+    fn parse_capability_block() {
+        let doc = "\
+sys_cap - Capability test
+capability: CAP_SYS_ADMIN
+  type: required
+  allows: Full system administration
+  without: Operation not permitted
+  condition: always
+  priority: 5
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_cap", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.capabilities.len(), 1);
+        let cap = &spec.capabilities[0];
+        assert_eq!(cap.capability, 21); // CAP_SYS_ADMIN
+        assert_eq!(cap.action, "required");
+        assert_eq!(cap.allows, "Full system administration");
+        assert_eq!(cap.without_cap, "Operation not permitted");
+        assert_eq!(cap.check_condition.as_deref(), Some("always"));
+        assert_eq!(cap.priority, Some(5));
+    }
+
+    #[test]
+    fn parse_lock_block() {
+        let doc = "\
+sys_lock - Lock test
+lock: files_lock, KAPI_LOCK_MUTEX
+  scope: acquires
+  desc: Protects file table
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_lock", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.locks.len(), 1);
+        let lock = &spec.locks[0];
+        assert_eq!(lock.lock_name, "files_lock");
+        assert_eq!(lock.lock_type, 1); // MUTEX
+        assert_eq!(lock.scope, super::super::KAPI_LOCK_ACQUIRES);
+        assert_eq!(lock.description, "Protects file table");
+    }
+
+    #[test]
+    fn parse_signal_block() {
+        let doc = "\
+sys_sig - Signal test
+signal: SIGKILL
+  direction: KAPI_SIGNAL_RECEIVE
+  action: KAPI_SIGNAL_ACTION_TERMINATE
+  timing: KAPI_SIGNAL_TIME_DURING
+  priority: 3
+  restartable: yes
+  interruptible: yes
+  desc: Process termination signal
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_sig", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.signals.len(), 1);
+        let sig = &spec.signals[0];
+        assert_eq!(sig.signal_name, "SIGKILL");
+        assert_eq!(sig.direction, 1); // RECEIVE
+        assert_eq!(sig.action, 1); // TERMINATE
+        assert_eq!(sig.timing, 1); // DURING
+        assert_eq!(sig.priority, 3);
+        assert!(sig.restartable);
+        assert!(sig.interruptible);
+        assert_eq!(
+            sig.description.as_deref(),
+            Some("Process termination signal")
+        );
+    }
+
+    #[test]
+    fn parse_signal_errno_shapes() {
+        // All three accepted spellings of the signal errno field must
+        // produce the same negative kernel return code.
+        for (form, label) in [
+            ("errno: -EINTR", "-EINTR symbolic"),
+            ("errno: EINTR", "bare symbolic"),
+            ("errno: -4", "numeric literal"),
+        ] {
+            let doc = format!(
+                "sys_s - Signal errno test\n\
+                 signal: SIGINT\n\
+                 \x20 direction: receive\n\
+                 \x20 action: return\n\
+                 \x20 {}\n",
+                form,
+            );
+            let spec = parser()
+                .parse_kerneldoc(&doc, "sys_s", "syscall", None)
+                .unwrap();
+            assert_eq!(spec.signals.len(), 1, "{label}");
+            assert_eq!(
+                spec.signals[0].error_on_signal,
+                Some(-4),
+                "errno form {label:?} must resolve to -EINTR (-4)",
+            );
+        }
+    }
+
+    #[test]
+    fn parse_side_effect_flat() {
+        let doc = "\
+sys_se - Side effect test
+side-effect: KAPI_EFFECT_MODIFY_STATE, file_table, Allocates a new file descriptor
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_se", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.side_effects.len(), 1);
+        let se = &spec.side_effects[0];
+        assert_eq!(se.effect_type, 1 << 2); // KAPI_EFFECT_MODIFY_STATE
+        assert_eq!(se.target, "file_table");
+        assert_eq!(se.description, "Allocates a new file descriptor");
+    }
+
+    #[test]
+    fn parse_side_effect_block() {
+        let doc = "\
+sys_se2 - Side effect block test
+side-effect: KAPI_EFFECT_ALLOC_MEMORY
+  target: kernel_heap
+  desc: Allocates kernel memory
+  reversible: yes
+  condition: size > 0
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_se2", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.side_effects.len(), 1);
+        let se = &spec.side_effects[0];
+        assert_eq!(se.effect_type, 1 << 0); // KAPI_EFFECT_ALLOC_MEMORY
+        assert_eq!(se.target, "kernel_heap");
+        assert_eq!(se.description, "Allocates kernel memory");
+        assert!(se.reversible);
+        assert_eq!(se.condition.as_deref(), Some("size > 0"));
+    }
+
+    #[test]
+    fn parse_empty_doc_no_error() {
+        let doc = "";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_empty", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.name, "sys_empty");
+        assert!(spec.description.is_none());
+        assert!(spec.parameters.is_empty());
+        assert!(spec.errors.is_empty());
+        assert!(spec.signals.is_empty());
+        assert!(spec.capabilities.is_empty());
+        assert!(spec.locks.is_empty());
+        assert!(spec.side_effects.is_empty());
+        assert!(spec.context_flags.is_empty());
+    }
+
+    #[test]
+    fn parse_missing_sections_no_error() {
+        // Only has a description, no KAPI annotations
+        let doc = "\
+sys_simple - Just a simple syscall
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_simple", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.description.as_deref(), Some("Just a simple syscall"));
+        assert!(spec.parameters.is_empty());
+        assert!(spec.errors.is_empty());
+        assert!(spec.context_flags.is_empty());
+    }
+
+    #[test]
+    fn parse_constraint_block() {
+        let doc = "\
+sys_cst - Constraint test
+constraint: valid_fd
+  desc: File descriptor must be valid and open
+  expr: fd >= 0 && fd < NR_OPEN
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_cst", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.constraints.len(), 1);
+        let cst = &spec.constraints[0];
+        assert_eq!(cst.name, "valid_fd");
+        assert_eq!(cst.description, "File descriptor must be valid and open");
+        assert_eq!(cst.expression.as_deref(), Some("fd >= 0 && fd < NR_OPEN"));
+    }
+
+    #[test]
+    fn parse_state_transition_flat() {
+        let doc = "\
+sys_st - State transition test
+state-trans: fd, open, closed, File descriptor is closed
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_st", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.state_transitions.len(), 1);
+        let st = &spec.state_transitions[0];
+        assert_eq!(st.object, "fd");
+        assert_eq!(st.from_state, "open");
+        assert_eq!(st.to_state, "closed");
+        assert_eq!(st.description, "File descriptor is closed");
+    }
+
+    #[test]
+    fn parse_param_block_with_range() {
+        let doc = "\
+sys_rng - Range test
+@count: byte count
+param: count
+  type: KAPI_TYPE_UINT
+  flags: IN
+  range: 0, 4096
+  constraint-type: KAPI_CONSTRAINT_RANGE
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_rng", "syscall", None)
+            .unwrap();
+
+        assert_eq!(spec.parameters.len(), 1);
+        let p = &spec.parameters[0];
+        assert_eq!(p.name, "count");
+        assert_eq!(p.param_type, 2); // UINT
+        assert_eq!(p.flags, 1); // IN
+        assert_eq!(p.min_value, Some(0));
+        assert_eq!(p.max_value, Some(4096));
+        assert_eq!(p.constraint_type, 1); // RANGE
+    }
+
+    #[test]
+    fn parse_return_block() {
+        let doc = "\
+sys_ret - Return test
+return:
+  type: KAPI_TYPE_INT
+  check-type: KAPI_RETURN_FD
+  success: 0
+  desc: Returns file descriptor on success
+";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_ret", "syscall", None)
+            .unwrap();
+
+        let ret = spec.return_spec.as_ref().unwrap();
+        assert_eq!(ret.type_name, "KAPI_TYPE_INT");
+        assert_eq!(ret.return_type, 1); // INT
+        assert_eq!(ret.check_type, 3); // FD
+        assert_eq!(ret.success_value, Some(0));
+        assert_eq!(ret.description, "Returns file descriptor on success");
+    }
+}
diff --git a/tools/kapi/src/extractor/mod.rs b/tools/kapi/src/extractor/mod.rs
new file mode 100644
index 0000000000000..2d08dbd8769f8
--- /dev/null
+++ b/tools/kapi/src/extractor/mod.rs
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use crate::formatter::OutputFormatter;
+use anyhow::Result;
+use std::io::Write;
+
+pub mod debugfs;
+pub mod kerneldoc_parser;
+pub mod source_parser;
+pub mod vmlinux;
+
+pub use debugfs::DebugfsExtractor;
+pub use source_parser::SourceExtractor;
+pub use vmlinux::VmlinuxExtractor;
+
+/// Capability specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct CapabilitySpec {
+    pub capability: i32,
+    pub name: String,
+    pub action: String,
+    pub allows: String,
+    pub without_cap: String,
+    pub check_condition: Option<String>,
+    pub priority: Option<u8>,
+    pub alternatives: Vec<i32>,
+}
+
+/// Parameter specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct ParamSpec {
+    pub index: u32,
+    pub name: String,
+    pub type_name: String,
+    pub description: String,
+    pub flags: u32,
+    pub param_type: u32,
+    pub constraint_type: u32,
+    pub constraint: Option<String>,
+    pub min_value: Option<i64>,
+    pub max_value: Option<i64>,
+    pub valid_mask: Option<u64>,
+    pub enum_values: Vec<String>,
+    pub size: Option<u32>,
+    pub alignment: Option<u32>,
+    /// Index of the parameter that carries this parameter's byte count
+    /// (for KAPI_CONSTRAINT_BUFFER). Populated by either
+    /// `size-param: N` (long form) or `constraint-type: buffer(N)`
+    /// (short form).
+    pub size_param_idx: Option<u32>,
+}
+
+/// Return value specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct ReturnSpec {
+    pub type_name: String,
+    pub description: String,
+    pub return_type: u32,
+    pub check_type: u32,
+    pub success_value: Option<i64>,
+    pub success_min: Option<i64>,
+    pub success_max: Option<i64>,
+    pub error_values: Vec<i32>,
+}
+
+/// Error specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct ErrorSpec {
+    pub error_code: i32,
+    pub name: String,
+    pub condition: String,
+    pub description: String,
+}
+
+/// Signal specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct SignalSpec {
+    pub signal_num: i32,
+    pub signal_name: String,
+    pub direction: u32,
+    pub action: u32,
+    pub target: Option<String>,
+    pub condition: Option<String>,
+    pub description: Option<String>,
+    pub timing: u32,
+    pub priority: u32,
+    pub restartable: bool,
+    pub interruptible: bool,
+    pub queue: Option<String>,
+    pub sa_flags: u32,
+    pub sa_flags_required: u32,
+    pub sa_flags_forbidden: u32,
+    pub state_required: u32,
+    pub state_forbidden: u32,
+    pub error_on_signal: Option<i32>,
+    /// Signal number to transform to (e.g. `SIGKILL` → 9 on x86).
+    /// Always an integer or null in JSON -- the schema never widens to
+    /// a string. Extractors reading the compiled struct (`--vmlinux`,
+    /// `--debugfs`) populate this directly. The source-kerneldoc parser
+    /// populates it only when the `transform-to:` subfield is a numeric
+    /// literal; symbolic signal names are arch-dependent and cannot be
+    /// resolved portably in userspace, so they are reported via an
+    /// stderr warning and leave this field `None`. Consumers that need
+    /// the resolved number for a symbolic spec should use `--vmlinux`
+    /// or `--debugfs` against a kernel built for the target arch.
+    pub transform_to: Option<i32>,
+}
+
+/// Signal mask specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct SignalMaskSpec {
+    pub name: String,
+    pub description: String,
+}
+
+/// Side effect specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct SideEffectSpec {
+    pub effect_type: u32,
+    pub target: String,
+    pub condition: Option<String>,
+    pub description: String,
+    pub reversible: bool,
+}
+
+/// State transition specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct StateTransitionSpec {
+    pub object: String,
+    pub from_state: String,
+    pub to_state: String,
+    pub condition: Option<String>,
+    pub description: String,
+}
+
+/// Constraint specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct ConstraintSpec {
+    pub name: String,
+    pub description: String,
+    pub expression: Option<String>,
+}
+
+/// Lock scope enum values matching kernel enum kapi_lock_scope
+pub const KAPI_LOCK_INTERNAL: u32 = 0;
+pub const KAPI_LOCK_ACQUIRES: u32 = 1;
+pub const KAPI_LOCK_RELEASES: u32 = 2;
+pub const KAPI_LOCK_CALLER_HELD: u32 = 3;
+
+/// Lock specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct LockSpec {
+    pub lock_name: String,
+    pub lock_type: u32,
+    pub scope: u32,
+    pub description: String,
+}
+
+/// Struct field specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct StructFieldSpec {
+    pub name: String,
+    pub field_type: u32,
+    pub type_name: String,
+    pub offset: usize,
+    pub size: usize,
+    pub flags: u32,
+    pub constraint_type: u32,
+    pub min_value: i64,
+    pub max_value: i64,
+    pub valid_mask: u64,
+    pub description: String,
+}
+
+/// Struct specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct StructSpec {
+    pub name: String,
+    pub size: usize,
+    pub alignment: usize,
+    pub field_count: u32,
+    pub fields: Vec<StructFieldSpec>,
+    pub description: String,
+}
+
+/// Common API specification information that all extractors should provide
+#[derive(Debug, Clone, Default)]
+pub struct ApiSpec {
+    pub name: String,
+    pub api_type: String,
+    pub description: Option<String>,
+    pub long_description: Option<String>,
+    pub version: Option<String>,
+    pub context_flags: Vec<String>,
+    pub param_count: Option<u32>,
+    pub error_count: Option<u32>,
+    pub examples: Option<String>,
+    pub notes: Option<String>,
+    // Sysfs-specific fields
+    pub subsystem: Option<String>,
+    pub sysfs_path: Option<String>,
+    pub permissions: Option<String>,
+    pub capabilities: Vec<CapabilitySpec>,
+    pub parameters: Vec<ParamSpec>,
+    pub return_spec: Option<ReturnSpec>,
+    pub errors: Vec<ErrorSpec>,
+    pub signals: Vec<SignalSpec>,
+    pub signal_masks: Vec<SignalMaskSpec>,
+    pub side_effects: Vec<SideEffectSpec>,
+    pub state_transitions: Vec<StateTransitionSpec>,
+    pub constraints: Vec<ConstraintSpec>,
+    pub locks: Vec<LockSpec>,
+    pub struct_specs: Vec<StructSpec>,
+}
+
+/// Trait for extracting API specifications from different sources
+pub trait ApiExtractor {
+    /// Extract all API specifications from the source
+    fn extract_all(&self) -> Result<Vec<ApiSpec>>;
+
+    /// Extract a specific API specification by name
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>>;
+
+    /// Display detailed information about a specific API
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()>;
+}
+
+/// Helper function to display an ApiSpec using a formatter
+pub fn display_api_spec(
+    spec: &ApiSpec,
+    formatter: &mut dyn OutputFormatter,
+    writer: &mut dyn Write,
+) -> Result<()> {
+    formatter.begin_api_details(writer, &spec.name)?;
+
+    if let Some(desc) = &spec.description {
+        formatter.description(writer, desc)?;
+    }
+
+    if let Some(long_desc) = &spec.long_description {
+        formatter.long_description(writer, long_desc)?;
+    }
+
+    if !spec.context_flags.is_empty() {
+        formatter.begin_context_flags(writer)?;
+        for flag in &spec.context_flags {
+            formatter.context_flag(writer, flag)?;
+        }
+        formatter.end_context_flags(writer)?;
+    }
+
+    if !spec.parameters.is_empty() {
+        formatter.begin_parameters(writer, spec.parameters.len().try_into().unwrap_or(u32::MAX))?;
+        for param in &spec.parameters {
+            formatter.parameter(writer, param)?;
+        }
+        formatter.end_parameters(writer)?;
+    }
+
+    if let Some(ret) = &spec.return_spec {
+        formatter.return_spec(writer, ret)?;
+    }
+
+    if !spec.errors.is_empty() {
+        formatter.begin_errors(writer, spec.errors.len().try_into().unwrap_or(u32::MAX))?;
+        for error in &spec.errors {
+            formatter.error(writer, error)?;
+        }
+        formatter.end_errors(writer)?;
+    }
+
+    if let Some(notes) = &spec.notes {
+        formatter.notes(writer, notes)?;
+    }
+
+    if let Some(examples) = &spec.examples {
+        formatter.examples(writer, examples)?;
+    }
+
+    // Display sysfs-specific fields
+    if spec.api_type == "sysfs" {
+        if let Some(subsystem) = &spec.subsystem {
+            formatter.sysfs_subsystem(writer, subsystem)?;
+        }
+        if let Some(path) = &spec.sysfs_path {
+            formatter.sysfs_path(writer, path)?;
+        }
+        if let Some(perms) = &spec.permissions {
+            formatter.sysfs_permissions(writer, perms)?;
+        }
+    }
+
+    if !spec.capabilities.is_empty() {
+        formatter.begin_capabilities(writer)?;
+        for cap in &spec.capabilities {
+            formatter.capability(writer, cap)?;
+        }
+        formatter.end_capabilities(writer)?;
+    }
+
+    // Display signals
+    if !spec.signals.is_empty() {
+        formatter.begin_signals(writer, spec.signals.len().try_into().unwrap_or(u32::MAX))?;
+        for signal in &spec.signals {
+            formatter.signal(writer, signal)?;
+        }
+        formatter.end_signals(writer)?;
+    }
+
+    // Display signal masks
+    if !spec.signal_masks.is_empty() {
+        formatter.begin_signal_masks(
+            writer,
+            spec.signal_masks.len().try_into().unwrap_or(u32::MAX),
+        )?;
+        for mask in &spec.signal_masks {
+            formatter.signal_mask(writer, mask)?;
+        }
+        formatter.end_signal_masks(writer)?;
+    }
+
+    // Display side effects
+    if !spec.side_effects.is_empty() {
+        formatter.begin_side_effects(
+            writer,
+            spec.side_effects.len().try_into().unwrap_or(u32::MAX),
+        )?;
+        for effect in &spec.side_effects {
+            formatter.side_effect(writer, effect)?;
+        }
+        formatter.end_side_effects(writer)?;
+    }
+
+    // Display state transitions
+    if !spec.state_transitions.is_empty() {
+        formatter.begin_state_transitions(
+            writer,
+            spec.state_transitions.len().try_into().unwrap_or(u32::MAX),
+        )?;
+        for trans in &spec.state_transitions {
+            formatter.state_transition(writer, trans)?;
+        }
+        formatter.end_state_transitions(writer)?;
+    }
+
+    // Display constraints
+    if !spec.constraints.is_empty() {
+        formatter.begin_constraints(
+            writer,
+            spec.constraints.len().try_into().unwrap_or(u32::MAX),
+        )?;
+        for constraint in &spec.constraints {
+            formatter.constraint(writer, constraint)?;
+        }
+        formatter.end_constraints(writer)?;
+    }
+
+    // Display locks
+    if !spec.locks.is_empty() {
+        formatter.begin_locks(writer, spec.locks.len().try_into().unwrap_or(u32::MAX))?;
+        for lock in &spec.locks {
+            formatter.lock(writer, lock)?;
+        }
+        formatter.end_locks(writer)?;
+    }
+
+    // Display struct specs
+    if !spec.struct_specs.is_empty() {
+        formatter.begin_struct_specs(
+            writer,
+            spec.struct_specs.len().try_into().unwrap_or(u32::MAX),
+        )?;
+        for struct_spec in &spec.struct_specs {
+            formatter.struct_spec(writer, struct_spec)?;
+        }
+        formatter.end_struct_specs(writer)?;
+    }
+
+    formatter.end_api_details(writer)?;
+
+    Ok(())
+}
diff --git a/tools/kapi/src/extractor/source_parser.rs b/tools/kapi/src/extractor/source_parser.rs
new file mode 100644
index 0000000000000..4138c128b7a2e
--- /dev/null
+++ b/tools/kapi/src/extractor/source_parser.rs
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use super::kerneldoc_parser::KerneldocParserImpl;
+use super::{display_api_spec, ApiExtractor, ApiSpec};
+use crate::formatter::OutputFormatter;
+use anyhow::{Context, Result};
+use regex::Regex;
+use std::fs;
+use std::io::Write;
+use std::path::Path;
+use walkdir::WalkDir;
+
+/// Extractor for kernel source files with KAPI-annotated kerneldoc
+pub struct SourceExtractor {
+    path: String,
+    parser: KerneldocParserImpl,
+    syscall_regex: Regex,
+    ioctl_regex: Regex,
+    function_regex: Regex,
+}
+
+impl SourceExtractor {
+    pub fn new(path: &str) -> Result<Self> {
+        Ok(SourceExtractor {
+            path: path.to_string(),
+            parser: KerneldocParserImpl::new(),
+            syscall_regex: Regex::new(r"SYSCALL_DEFINE\d+\((\w+)")?,
+            ioctl_regex: Regex::new(r"(?:static\s+)?long\s+(\w+_ioctl)\s*\(")?,
+            function_regex: Regex::new(concat!(
+                r"(?m)^(?:static\s+)?(?:inline\s+)?",
+                r"(?:(?:unsigned\s+)?",
+                r"(?:long|int|void|char|short",
+                r"|struct\s+\w+\s*\*?",
+                r"|[\w_]+_t)",
+                r"\s*\*?\s+)?",
+                r"(\w+)\s*\([^)]*\)",
+            ))?,
+        })
+    }
+
+    fn extract_from_file(&self, path: &Path) -> Result<Vec<ApiSpec>> {
+        let content = fs::read_to_string(path)
+            .with_context(|| format!("Failed to read file: {}", path.display()))?;
+
+        self.extract_from_content(&content)
+    }
+
+    fn extract_from_content(&self, content: &str) -> Result<Vec<ApiSpec>> {
+        let mut specs = Vec::new();
+        let mut in_kerneldoc = false;
+        let mut current_doc = String::new();
+        let lines: Vec<&str> = content.lines().collect();
+        let mut i = 0;
+
+        while i < lines.len() {
+            let line = lines[i];
+
+            // Start of kerneldoc comment
+            if line.trim_start().starts_with("/**") {
+                in_kerneldoc = true;
+                current_doc.clear();
+                i += 1;
+                continue;
+            }
+
+            // Inside kerneldoc comment
+            if in_kerneldoc {
+                if line.contains("*/") {
+                    in_kerneldoc = false;
+
+                    // Check if this kerneldoc has KAPI annotations
+                    if current_doc.contains("context-flags:")
+                        || current_doc.contains("param-count:")
+                        || current_doc.contains("side-effect:")
+                        || current_doc.contains("state-trans:")
+                        || current_doc.contains("error-code:")
+                    {
+                        // Look ahead for the function declaration
+                        if let Some((name, api_type, signature)) =
+                            self.find_function_after(&lines, i + 1)
+                        {
+                            if let Ok(spec) = self.parser.parse_kerneldoc(
+                                &current_doc,
+                                &name,
+                                &api_type,
+                                Some(&signature),
+                            ) {
+                                specs.push(spec);
+                            }
+                        }
+                    }
+                } else {
+                    // Remove leading asterisk and preserve content
+                    let cleaned = if let Some(stripped) = line.trim_start().strip_prefix("*") {
+                        if let Some(no_space) = stripped.strip_prefix(' ') {
+                            no_space
+                        } else {
+                            stripped
+                        }
+                    } else {
+                        line.trim_start()
+                    };
+                    current_doc.push_str(cleaned);
+                    current_doc.push('\n');
+                }
+            }
+
+            i += 1;
+        }
+
+        Ok(specs)
+    }
+
+    fn find_function_after(
+        &self,
+        lines: &[&str],
+        start: usize,
+    ) -> Option<(String, String, String)> {
+        for i in start..lines.len().min(start + 10) {
+            let line = lines[i];
+
+            // Skip empty lines
+            if line.trim().is_empty() {
+                continue;
+            }
+
+            // Check for SYSCALL_DEFINE
+            if let Some(caps) = self.syscall_regex.captures(line) {
+                let name = format!("sys_{}", caps.get(1).unwrap().as_str());
+                let signature = self.extract_syscall_signature(lines, i);
+                return Some((name, "syscall".to_string(), signature));
+            }
+
+            // Check for ioctl function
+            if let Some(caps) = self.ioctl_regex.captures(line) {
+                let name = caps.get(1).unwrap().as_str().to_string();
+                return Some((name, "ioctl".to_string(), line.to_string()));
+            }
+
+            // Check for regular function
+            if let Some(caps) = self.function_regex.captures(line) {
+                let name = caps.get(1).unwrap().as_str().to_string();
+                return Some((name, "function".to_string(), line.to_string()));
+            }
+
+            // Stop if we hit something that's clearly not part of the function declaration
+            if !line.starts_with(' ') && !line.starts_with('\t') && !line.trim().is_empty() {
+                break;
+            }
+        }
+
+        None
+    }
+
+    fn extract_syscall_signature(&self, lines: &[&str], start: usize) -> String {
+        // Extract the full SYSCALL_DEFINE signature
+        let mut sig = String::new();
+        let mut in_paren = false;
+        let mut paren_count = 0;
+
+        for line in lines.iter().skip(start).take(20) {
+            let line = *line;
+
+            // Start of SYSCALL_DEFINE
+            if line.contains("SYSCALL_DEFINE") {
+                if let Some(pos) = line.find('(') {
+                    sig.push_str(&line[pos..]);
+                    in_paren = true;
+                    paren_count = line[pos..].chars().filter(|&c| c == '(').count()
+                        - line[pos..].chars().filter(|&c| c == ')').count();
+                }
+            } else if in_paren {
+                sig.push(' ');
+                sig.push_str(line.trim());
+                paren_count += line.chars().filter(|&c| c == '(').count();
+                paren_count =
+                    paren_count.saturating_sub(line.chars().filter(|&c| c == ')').count());
+
+                if paren_count == 0 {
+                    break;
+                }
+            }
+        }
+
+        sig
+    }
+}
+
+impl ApiExtractor for SourceExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        let path = Path::new(&self.path);
+        let mut all_specs = Vec::new();
+
+        if path.is_file() {
+            // Single file
+            all_specs.extend(self.extract_from_file(path)?);
+        } else if path.is_dir() {
+            // Directory - walk all .c files
+            for entry in WalkDir::new(path)
+                .into_iter()
+                .filter_map(|e| e.ok())
+                .filter(|e| {
+                    e.path()
+                        .extension()
+                        .is_some_and(|ext| ext == "c" || ext == "h")
+                })
+            {
+                match self.extract_from_file(entry.path()) {
+                    Ok(specs) => all_specs.extend(specs),
+                    Err(e) => {
+                        eprintln!("Warning: failed to parse {}: {}", entry.path().display(), e);
+                    }
+                }
+            }
+        }
+
+        Ok(all_specs)
+    }
+
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>> {
+        let all_specs = self.extract_all()?;
+        Ok(all_specs.into_iter().find(|s| s.name == name))
+    }
+
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        output: &mut dyn Write,
+    ) -> Result<()> {
+        if let Some(spec) = self.extract_by_name(api_name)? {
+            display_api_spec(&spec, formatter, output)?;
+        } else {
+            writeln!(output, "API '{}' not found", api_name)?;
+        }
+        Ok(())
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    fn make_extractor() -> SourceExtractor {
+        SourceExtractor::new("/dev/null").unwrap()
+    }
+
+    #[test]
+    fn detect_syscall_define3() {
+        let content = r#"
+/**
+ * sys_open - open a file
+ * context-flags: KAPI_CTX_PROCESS
+ * param-count: 3
+ * @filename: pathname to open
+ * param-type: filename, KAPI_TYPE_STRING
+ * error-code: ENOENT
+ */
+SYSCALL_DEFINE3(open, const char __user *, filename, int, flags, umode_t, mode)
+{
+    return 0;
+}
+"#;
+        let ext = make_extractor();
+        let specs = ext.extract_from_content(content).unwrap();
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "sys_open");
+        assert_eq!(specs[0].api_type, "syscall");
+    }
+
+    #[test]
+    fn detect_syscall_define1() {
+        let content = r#"
+/**
+ * sys_close - close a file descriptor
+ * context-flags: KAPI_CTX_PROCESS
+ * @fd: file descriptor to close
+ * error-code: EBADF
+ */
+SYSCALL_DEFINE1(close, unsigned int, fd)
+{
+    return 0;
+}
+"#;
+        let ext = make_extractor();
+        let specs = ext.extract_from_content(content).unwrap();
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "sys_close");
+    }
+
+    #[test]
+    fn detect_syscall_define6() {
+        let content = r#"
+/**
+ * sys_mmap - map memory
+ * context-flags: KAPI_CTX_PROCESS
+ * error-code: ENOMEM
+ */
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long, prot,
+    unsigned long, flags, unsigned long, fd, unsigned long, offset)
+{
+    return 0;
+}
+"#;
+        let ext = make_extractor();
+        let specs = ext.extract_from_content(content).unwrap();
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "sys_mmap");
+    }
+
+    #[test]
+    fn detect_ioctl_pattern() {
+        let content = r#"
+/**
+ * my_ioctl - handle ioctl
+ * context-flags: KAPI_CTX_PROCESS
+ * error-code: EINVAL
+ */
+static long my_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+    return 0;
+}
+"#;
+        let ext = make_extractor();
+        let specs = ext.extract_from_content(content).unwrap();
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "my_ioctl");
+        assert_eq!(specs[0].api_type, "ioctl");
+    }
+
+    #[test]
+    fn find_function_after_skips_blanks() {
+        // Test that find_function_after looks past blank lines
+        let lines = vec!["", "", "SYSCALL_DEFINE2(foo, int, bar, int, baz)", "{"];
+        let ext = make_extractor();
+        let result = ext.find_function_after(&lines, 0);
+        assert!(result.is_some());
+        let (name, api_type, _sig) = result.unwrap();
+        assert_eq!(name, "sys_foo");
+        assert_eq!(api_type, "syscall");
+    }
+
+    #[test]
+    fn find_function_after_returns_none_for_no_match() {
+        // No function declaration within lookahead range
+        let lines = vec!["#include <linux/fs.h>", "#define FOO 1", "/* comment */"];
+        let ext = make_extractor();
+        let result = ext.find_function_after(&lines, 0);
+        // The function_regex may or may not match #define, but let's check
+        // that a pure preprocessor/comment block doesn't false-positive on syscall/ioctl
+        if let Some((_, api_type, _)) = &result {
+            assert_ne!(api_type, "syscall");
+            assert_ne!(api_type, "ioctl");
+        }
+    }
+
+    #[test]
+    fn find_function_after_detects_regular_function() {
+        let lines = vec!["", "int do_something(struct task_struct *task)", "{"];
+        let ext = make_extractor();
+        let result = ext.find_function_after(&lines, 0);
+        assert!(result.is_some());
+        let (name, api_type, _) = result.unwrap();
+        assert_eq!(name, "do_something");
+        assert_eq!(api_type, "function");
+    }
+
+    #[test]
+    fn no_kapi_annotations_produces_empty() {
+        // kerneldoc without any KAPI annotations should not produce a spec
+        let content = r#"
+/**
+ * my_func - does stuff
+ * @arg: an argument
+ */
+void my_func(int arg)
+{
+}
+"#;
+        let ext = make_extractor();
+        let specs = ext.extract_from_content(content).unwrap();
+        assert!(specs.is_empty());
+    }
+
+    #[test]
+    fn multiple_syscalls_in_one_file() {
+        let content = r#"
+/**
+ * sys_read - read from fd
+ * context-flags: KAPI_CTX_PROCESS
+ * error-code: EBADF
+ */
+SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)
+{
+    return 0;
+}
+
+/**
+ * sys_write - write to fd
+ * context-flags: KAPI_CTX_PROCESS
+ * error-code: EBADF
+ */
+SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf, size_t, count)
+{
+    return 0;
+}
+"#;
+        let ext = make_extractor();
+        let specs = ext.extract_from_content(content).unwrap();
+        assert_eq!(specs.len(), 2);
+        assert_eq!(specs[0].name, "sys_read");
+        assert_eq!(specs[1].name, "sys_write");
+    }
+}
diff --git a/tools/kapi/src/extractor/vmlinux/binary_utils.rs b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
new file mode 100644
index 0000000000000..b03a75b289c1f
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+// Array-bound constants matching `include/linux/kernel_api_spec.h`.
+// String fields are `const char *`; call `DataReader::ptr_size()` for
+// the per-target pointer width.
+pub mod sizes {
+    pub const MAX_PARAMS: usize = 16;
+    pub const MAX_ERRORS: usize = 32;
+    pub const MAX_CONSTRAINTS: usize = 32;
+    pub const MAX_LOCKS: usize = 16;
+    pub const MAX_CAPABILITIES: usize = 8;
+    pub const MAX_SIGNALS: usize = 32;
+    pub const MAX_STRUCT_SPECS: usize = 8;
+    pub const MAX_SIDE_EFFECTS: usize = 32;
+    pub const MAX_STATE_TRANS: usize = 8;
+
+    pub const NAME: usize = 0;
+    pub const DESC: usize = 0;
+}
+
+/// Resolve a virtual-address string pointer against the vmlinux ELF
+/// and return the NUL-terminated C string it points at.
+pub fn resolve_vaddr_string(elf: &goblin::elf::Elf, data: &[u8], vaddr: u64) -> Option<String> {
+    if vaddr == 0 {
+        return None;
+    }
+    for sh in &elf.section_headers {
+        let start = sh.sh_addr;
+        let end = start.checked_add(sh.sh_size)?;
+        if vaddr < start || vaddr >= end {
+            continue;
+        }
+        // File-backed sections only (skip SHT_NOBITS etc.)
+        if sh.sh_type == goblin::elf::section_header::SHT_NOBITS {
+            return None;
+        }
+        let rel = (vaddr - start) as usize;
+        let file_start = sh.sh_offset as usize + rel;
+        if file_start >= data.len() {
+            return None;
+        }
+        let tail = &data[file_start..];
+        let nul = tail.iter().position(|&b| b == 0)?;
+        return std::str::from_utf8(&tail[..nul]).ok().map(str::to_string);
+    }
+    None
+}
+
+/// Endianness of the target ELF binary
+#[derive(Clone, Copy, PartialEq)]
+pub enum Endian {
+    Little,
+    Big,
+}
+
+/// Resolves string pointers read from `.kapi_specs` back to their
+/// underlying C strings in the vmlinux rodata.
+pub struct StringResolver<'a> {
+    pub elf: &'a goblin::elf::Elf<'a>,
+    pub vmlinux: &'a [u8],
+}
+
+// Helper for reading data at specific offsets
+pub struct DataReader<'a> {
+    pub data: &'a [u8],
+    pub pos: usize,
+    pub endian: Endian,
+    /// true for 64-bit ELF, false for 32-bit
+    pub is_64bit: bool,
+    /// Used to follow `const char *` fields into rodata.
+    pub resolver: Option<StringResolver<'a>>,
+}
+
+impl<'a> DataReader<'a> {
+    pub fn new(data: &'a [u8], offset: usize, endian: Endian, is_64bit: bool) -> Self {
+        Self {
+            data,
+            pos: offset,
+            endian,
+            is_64bit,
+            resolver: None,
+        }
+    }
+
+    pub fn with_resolver(mut self, resolver: StringResolver<'a>) -> Self {
+        self.resolver = Some(resolver);
+        self
+    }
+
+    /// Pointer width of the target in bytes (4 or 8).
+    pub fn ptr_size(&self) -> usize {
+        if self.is_64bit {
+            8
+        } else {
+            4
+        }
+    }
+
+    /// Advance the read position to the next multiple of `align`.
+    /// Needed before every naturally-aligned field when the containing
+    /// struct is not `__packed`.
+    pub fn align_to(&mut self, align: usize) {
+        if align > 1 {
+            let rem = self.pos % align;
+            if rem != 0 {
+                self.pos = (self.pos + (align - rem)).min(self.data.len());
+            }
+        }
+    }
+
+    /// Read a target-sized pointer slot. Returns the virtual address
+    /// stored in the slot, or `None` if there isn't enough data. The
+    /// caller is expected to align the reader first if the containing
+    /// struct demands natural alignment.
+    pub fn read_ptr(&mut self) -> Option<u64> {
+        self.align_to(self.ptr_size());
+        if self.is_64bit {
+            self.read_u64()
+        } else {
+            self.read_u32().map(|v| v as u64)
+        }
+    }
+
+    pub fn read_bytes(&mut self, len: usize) -> Option<&'a [u8]> {
+        if self.pos + len <= self.data.len() {
+            let bytes = &self.data[self.pos..self.pos + len];
+            self.pos += len;
+            Some(bytes)
+        } else {
+            None
+        }
+    }
+
+    pub fn read_u32(&mut self) -> Option<u32> {
+        self.align_to(4);
+        let b: [u8; 4] = self.read_bytes(4)?.try_into().unwrap();
+        Some(match self.endian {
+            Endian::Little => u32::from_le_bytes(b),
+            Endian::Big => u32::from_be_bytes(b),
+        })
+    }
+
+    pub fn read_u8(&mut self) -> Option<u8> {
+        self.read_bytes(1).map(|b| b[0])
+    }
+
+    pub fn read_i32(&mut self) -> Option<i32> {
+        self.align_to(4);
+        let b: [u8; 4] = self.read_bytes(4)?.try_into().unwrap();
+        Some(match self.endian {
+            Endian::Little => i32::from_le_bytes(b),
+            Endian::Big => i32::from_be_bytes(b),
+        })
+    }
+
+    pub fn read_u64(&mut self) -> Option<u64> {
+        self.align_to(8);
+        let b: [u8; 8] = self.read_bytes(8)?.try_into().unwrap();
+        Some(match self.endian {
+            Endian::Little => u64::from_le_bytes(b),
+            Endian::Big => u64::from_be_bytes(b),
+        })
+    }
+
+    pub fn read_i64(&mut self) -> Option<i64> {
+        self.align_to(8);
+        let b: [u8; 8] = self.read_bytes(8)?.try_into().unwrap();
+        Some(match self.endian {
+            Endian::Little => i64::from_le_bytes(b),
+            Endian::Big => i64::from_be_bytes(b),
+        })
+    }
+
+    /// Read a target-sized unsigned value (4 bytes for 32-bit, 8 bytes for 64-bit).
+    pub fn read_usize(&mut self) -> Option<usize> {
+        self.align_to(self.ptr_size());
+        if self.is_64bit {
+            // No double-align: read_u64 would re-align, but we just
+            // did that with ptr_size() which is 8 on 64-bit.
+            let b: [u8; 8] = self.read_bytes(8)?.try_into().unwrap();
+            Some(match self.endian {
+                Endian::Little => u64::from_le_bytes(b) as usize,
+                Endian::Big => u64::from_be_bytes(b) as usize,
+            })
+        } else {
+            let b: [u8; 4] = self.read_bytes(4)?.try_into().unwrap();
+            Some(match self.endian {
+                Endian::Little => u32::from_le_bytes(b) as usize,
+                Endian::Big => u32::from_be_bytes(b) as usize,
+            })
+        }
+    }
+
+    pub fn skip(&mut self, len: usize) {
+        self.pos = (self.pos + len).min(self.data.len());
+    }
+
+    // Helper methods for common patterns
+    pub fn read_bool(&mut self) -> Option<bool> {
+        self.read_u8().map(|v| v != 0)
+    }
+
+    /// Read a `const char *` slot using the target pointer width
+    /// (4 bytes on 32-bit, 8 bytes on 64-bit) and, if a resolver is
+    /// attached, follow the address into the vmlinux to recover the
+    /// C string. The `_max_len` argument is ignored.
+    pub fn read_optional_string(&mut self, _max_len: usize) -> Option<String> {
+        let vaddr = self.read_ptr()?;
+        let resolver = self.resolver.as_ref()?;
+        resolve_vaddr_string(resolver.elf, resolver.vmlinux, vaddr).filter(|s| !s.is_empty())
+    }
+
+    pub fn read_string_or_default(&mut self, max_len: usize) -> String {
+        self.read_optional_string(max_len).unwrap_or_default()
+    }
+}
+
+// Structure layout definitions for calculating sizes
+pub fn signal_mask_spec_layout_size() -> usize {
+    // Packed structure from struct kapi_signal_mask_spec
+    sizes::NAME + // mask_name
+    4 * sizes::MAX_SIGNALS + // signals array
+    4 + // signal_count
+    sizes::DESC // description
+}
+
+pub fn struct_field_layout_size() -> usize {
+    // Packed structure from struct kapi_struct_field
+    sizes::NAME + // name
+    4 + // type (enum)
+    sizes::NAME + // type_name
+    8 + // offset (size_t)
+    8 + // size (size_t)
+    4 + // flags
+    4 + // constraint_type (enum)
+    8 + // min_value (s64)
+    8 + // max_value (s64)
+    8 + // valid_mask (u64)
+    sizes::DESC + // enum_values
+    sizes::DESC // description
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    // ---- DataReader little-endian tests ----
+
+    #[test]
+    fn read_u32_little_endian() {
+        let data = [0x78, 0x56, 0x34, 0x12];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_u32(), Some(0x12345678));
+    }
+
+    #[test]
+    fn read_u32_big_endian() {
+        let data = [0x12, 0x34, 0x56, 0x78];
+        let mut reader = DataReader::new(&data, 0, Endian::Big, true);
+        assert_eq!(reader.read_u32(), Some(0x12345678));
+    }
+
+    #[test]
+    fn read_u64_little_endian() {
+        let data = 0xDEADBEEFCAFEBABEu64.to_le_bytes();
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_u64(), Some(0xDEADBEEFCAFEBABE));
+    }
+
+    #[test]
+    fn read_u64_big_endian() {
+        let data = 0xDEADBEEFCAFEBABEu64.to_be_bytes();
+        let mut reader = DataReader::new(&data, 0, Endian::Big, true);
+        assert_eq!(reader.read_u64(), Some(0xDEADBEEFCAFEBABE));
+    }
+
+    #[test]
+    fn read_i32_little_endian_negative() {
+        let val: i32 = -42;
+        let data = val.to_le_bytes();
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_i32(), Some(-42));
+    }
+
+    #[test]
+    fn read_i32_big_endian_negative() {
+        let val: i32 = -1;
+        let data = val.to_be_bytes();
+        let mut reader = DataReader::new(&data, 0, Endian::Big, true);
+        assert_eq!(reader.read_i32(), Some(-1));
+    }
+
+    #[test]
+    fn read_i64_little_endian() {
+        let val: i64 = -9999999999;
+        let data = val.to_le_bytes();
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_i64(), Some(-9999999999));
+    }
+
+    #[test]
+    fn read_i64_big_endian() {
+        let val: i64 = i64::MIN;
+        let data = val.to_be_bytes();
+        let mut reader = DataReader::new(&data, 0, Endian::Big, true);
+        assert_eq!(reader.read_i64(), Some(i64::MIN));
+    }
+
+    // ---- read_usize tests ----
+
+    #[test]
+    fn read_usize_64bit() {
+        let val: u64 = 0x00000000FFFFFFFF;
+        let data = val.to_le_bytes();
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_usize(), Some(0xFFFFFFFF));
+    }
+
+    #[test]
+    fn read_usize_32bit() {
+        let val: u32 = 0xABCD1234;
+        let data = val.to_le_bytes();
+        let mut reader = DataReader::new(&data, 0, Endian::Little, false);
+        assert_eq!(reader.read_usize(), Some(0xABCD1234));
+    }
+
+    #[test]
+    fn read_usize_32bit_does_not_consume_8_bytes() {
+        // In 32-bit mode, read_usize should only consume 4 bytes
+        let mut data = [0u8; 8];
+        data[..4].copy_from_slice(&42u32.to_le_bytes());
+        data[4..8].copy_from_slice(&99u32.to_le_bytes());
+        let mut reader = DataReader::new(&data, 0, Endian::Little, false);
+        assert_eq!(reader.read_usize(), Some(42));
+        // After reading 4 bytes, pos should be at 4
+        assert_eq!(reader.pos, 4);
+        assert_eq!(reader.read_usize(), Some(99));
+    }
+
+    // ---- Bounds checking ----
+
+    #[test]
+    fn read_u32_past_end_returns_none() {
+        let data = [0x01, 0x02, 0x03]; // only 3 bytes, need 4
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_u32(), None);
+    }
+
+    #[test]
+    fn read_u64_past_end_returns_none() {
+        let data = [0u8; 7]; // only 7 bytes, need 8
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_u64(), None);
+    }
+
+    #[test]
+    fn read_bytes_past_end_returns_none() {
+        let data = [0u8; 4];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_bytes(5), None);
+    }
+
+    #[test]
+    fn read_at_offset() {
+        // read_u32 auto-aligns to a 4-byte boundary, so the starting
+        // offset must itself be 4-aligned for the value to be read
+        // from its declared position.
+        let data = [0xFF, 0xFF, 0xFF, 0xFF, 0x78, 0x56, 0x34, 0x12];
+        let mut reader = DataReader::new(&data, 4, Endian::Little, true);
+        assert_eq!(reader.read_u32(), Some(0x12345678));
+    }
+
+    #[test]
+    fn read_u32_auto_aligns() {
+        // Starting mid-word, read_u32 snaps to the next 4-byte boundary.
+        let data = [0xDE, 0xAD, 0xBE, 0xEF, 0x78, 0x56, 0x34, 0x12];
+        let mut reader = DataReader::new(&data, 1, Endian::Little, true);
+        assert_eq!(reader.read_u32(), Some(0x12345678));
+        assert_eq!(reader.pos, 8);
+    }
+
+    #[test]
+    fn read_ptr_32bit_uses_4_bytes() {
+        let data = [0x78, 0x56, 0x34, 0x12];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, false);
+        assert_eq!(reader.read_ptr(), Some(0x12345678));
+        assert_eq!(reader.pos, 4);
+    }
+
+    #[test]
+    fn read_ptr_64bit_uses_8_bytes() {
+        let data = [0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x00, 0x00];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_ptr(), Some(0x12345678));
+        assert_eq!(reader.pos, 8);
+    }
+
+    #[test]
+    fn read_bool_values() {
+        let data = [0, 1, 255];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_bool(), Some(false));
+        assert_eq!(reader.read_bool(), Some(true));
+        assert_eq!(reader.read_bool(), Some(true)); // any non-zero is true
+    }
+
+    #[test]
+    fn skip_advances_position() {
+        let data = [0u8; 20];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        reader.skip(10);
+        assert_eq!(reader.pos, 10);
+        reader.skip(5);
+        assert_eq!(reader.pos, 15);
+    }
+
+    #[test]
+    fn skip_clamps_to_data_len() {
+        let data = [0u8; 10];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        reader.skip(100);
+        assert_eq!(reader.pos, 10);
+    }
+
+    #[test]
+    fn sequential_reads_advance_position() {
+        let mut data = [0u8; 12];
+        data[..4].copy_from_slice(&1u32.to_le_bytes());
+        data[4..8].copy_from_slice(&2u32.to_le_bytes());
+        data[8..12].copy_from_slice(&3u32.to_le_bytes());
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_u32(), Some(1));
+        assert_eq!(reader.read_u32(), Some(2));
+        assert_eq!(reader.read_u32(), Some(3));
+        assert_eq!(reader.pos, 12);
+    }
+
+    #[test]
+    fn read_optional_string_empty_returns_none() {
+        // A string buffer that is just NUL
+        let data = [0u8; 10];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        // read_cstring returns None when null_pos == 0
+        // read_optional_string filters empty strings, but read_cstring won't return empty
+        assert_eq!(reader.read_optional_string(10), None);
+    }
+
+    #[test]
+    fn read_string_or_default_with_empty() {
+        let data = [0u8; 10];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_string_or_default(10), "");
+    }
+
+    #[test]
+    fn read_u8_value() {
+        let data = [0x42];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_u8(), Some(0x42));
+    }
+}
diff --git a/tools/kapi/src/extractor/vmlinux/magic_finder.rs b/tools/kapi/src/extractor/vmlinux/magic_finder.rs
new file mode 100644
index 0000000000000..65081852ffaaf
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/magic_finder.rs
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use super::binary_utils::Endian;
+
+// Magic markers for each section
+pub const MAGIC_PARAM: u32 = 0x4B415031; // 'KAP1'
+pub const MAGIC_RETURN: u32 = 0x4B415232; // 'KAR2'
+pub const MAGIC_ERROR: u32 = 0x4B414533; // 'KAE3'
+pub const MAGIC_LOCK: u32 = 0x4B414C34; // 'KAL4'
+pub const MAGIC_CONSTRAINT: u32 = 0x4B414335; // 'KAC5'
+pub const MAGIC_INFO: u32 = 0x4B414936; // 'KAI6'
+pub const MAGIC_SIGNAL: u32 = 0x4B415337; // 'KAS7'
+pub const MAGIC_SIGMASK: u32 = 0x4B414D38; // 'KAM8'
+pub const MAGIC_STRUCT: u32 = 0x4B415439; // 'KAT9'
+pub const MAGIC_EFFECT: u32 = 0x4B414641; // 'KAFA'
+pub const MAGIC_TRANS: u32 = 0x4B415442; // 'KATB'
+pub const MAGIC_CAP: u32 = 0x4B414343; // 'KACC'
+
+fn read_u32_endian(bytes: &[u8], endian: Endian) -> u32 {
+    let b = [bytes[0], bytes[1], bytes[2], bytes[3]];
+    match endian {
+        Endian::Little => u32::from_le_bytes(b),
+        Endian::Big => u32::from_be_bytes(b),
+    }
+}
+
+pub struct MagicOffsets {
+    pub param_offset: Option<usize>,
+    pub return_offset: Option<usize>,
+    pub error_offset: Option<usize>,
+    pub lock_offset: Option<usize>,
+    pub constraint_offset: Option<usize>,
+    pub info_offset: Option<usize>,
+    pub signal_offset: Option<usize>,
+    pub sigmask_offset: Option<usize>,
+    pub struct_offset: Option<usize>,
+    pub effect_offset: Option<usize>,
+    pub trans_offset: Option<usize>,
+    pub cap_offset: Option<usize>,
+}
+
+impl MagicOffsets {
+    /// Find magic markers in the provided data slice
+    /// data: slice of data to search (typically one spec's worth)
+    /// base_offset: absolute offset where this slice starts in the full buffer
+    pub fn find_in_data(data: &[u8], base_offset: usize, endian: Endian) -> Self {
+        let mut offsets = MagicOffsets {
+            param_offset: None,
+            return_offset: None,
+            error_offset: None,
+            lock_offset: None,
+            constraint_offset: None,
+            info_offset: None,
+            signal_offset: None,
+            sigmask_offset: None,
+            struct_offset: None,
+            effect_offset: None,
+            trans_offset: None,
+            cap_offset: None,
+        };
+
+        // Scan through data looking for magic markers
+        // Only find the first occurrence of each magic to avoid cross-spec contamination
+        let mut i = 0;
+        while i + 4 <= data.len() {
+            let bytes = &data[i..i + 4];
+            let value = read_u32_endian(bytes, endian);
+
+            match value {
+                MAGIC_PARAM if offsets.param_offset.is_none() => {
+                    offsets.param_offset = Some(base_offset + i);
+                }
+                MAGIC_RETURN if offsets.return_offset.is_none() => {
+                    offsets.return_offset = Some(base_offset + i);
+                }
+                MAGIC_ERROR if offsets.error_offset.is_none() => {
+                    offsets.error_offset = Some(base_offset + i);
+                }
+                MAGIC_LOCK if offsets.lock_offset.is_none() => {
+                    offsets.lock_offset = Some(base_offset + i);
+                }
+                MAGIC_CONSTRAINT if offsets.constraint_offset.is_none() => {
+                    offsets.constraint_offset = Some(base_offset + i);
+                }
+                MAGIC_INFO if offsets.info_offset.is_none() => {
+                    offsets.info_offset = Some(base_offset + i);
+                }
+                MAGIC_SIGNAL if offsets.signal_offset.is_none() => {
+                    offsets.signal_offset = Some(base_offset + i);
+                }
+                MAGIC_SIGMASK if offsets.sigmask_offset.is_none() => {
+                    offsets.sigmask_offset = Some(base_offset + i);
+                }
+                MAGIC_STRUCT if offsets.struct_offset.is_none() => {
+                    offsets.struct_offset = Some(base_offset + i);
+                }
+                MAGIC_EFFECT if offsets.effect_offset.is_none() => {
+                    offsets.effect_offset = Some(base_offset + i);
+                }
+                MAGIC_TRANS if offsets.trans_offset.is_none() => {
+                    offsets.trans_offset = Some(base_offset + i);
+                }
+                MAGIC_CAP if offsets.cap_offset.is_none() => {
+                    offsets.cap_offset = Some(base_offset + i);
+                }
+                _ => {}
+            }
+
+            i += 1;
+        }
+
+        offsets
+    }
+}
diff --git a/tools/kapi/src/extractor/vmlinux/mod.rs b/tools/kapi/src/extractor/vmlinux/mod.rs
new file mode 100644
index 0000000000000..41c9bf1b06591
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/mod.rs
@@ -0,0 +1,857 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use super::{
+    ApiExtractor, ApiSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec,
+    ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec, StateTransitionSpec, StructFieldSpec,
+    StructSpec,
+};
+use crate::formatter::OutputFormatter;
+use anyhow::{Context, Result};
+use goblin::elf::Elf;
+use std::fs;
+use std::io::Write;
+
+mod binary_utils;
+mod magic_finder;
+use binary_utils::{
+    signal_mask_spec_layout_size, sizes, struct_field_layout_size, DataReader, Endian,
+};
+
+// Helper to convert empty strings to None
+fn opt_string(s: String) -> Option<String> {
+    if s.is_empty() {
+        None
+    } else {
+        Some(s)
+    }
+}
+
+pub struct VmlinuxExtractor {
+    vmlinux: Vec<u8>,
+    specs: Vec<KapiSpec>,
+    endian: Endian,
+    is_64bit: bool,
+}
+
+#[derive(Debug)]
+struct KapiSpec {
+    name: String,
+    api_type: String,
+    /// File offset in the vmlinux buffer where this spec's
+    /// `struct kernel_api_spec` begins.
+    file_offset: usize,
+}
+
+impl VmlinuxExtractor {
+    pub fn new(vmlinux_path: &str) -> Result<Self> {
+        let vmlinux = fs::read(vmlinux_path)
+            .with_context(|| format!("Failed to read vmlinux file: {vmlinux_path}"))?;
+
+        let elf = Elf::parse(&vmlinux).context("Failed to parse ELF file")?;
+        let endian = if elf.little_endian {
+            Endian::Little
+        } else {
+            Endian::Big
+        };
+        let is_64bit = elf.is_64;
+
+        // Locate the .kapi_specs section boundaries.
+        let mut start_addr = None;
+        let mut stop_addr = None;
+        for sym in &elf.syms {
+            if let Some(name) = elf.strtab.get_at(sym.st_name) {
+                match name {
+                    "__start_kapi_specs" => start_addr = Some(sym.st_value),
+                    "__stop_kapi_specs" => stop_addr = Some(sym.st_value),
+                    _ => {}
+                }
+            }
+        }
+        let start = start_addr.context("Could not find __start_kapi_specs symbol")?;
+        let stop = stop_addr.context("Could not find __stop_kapi_specs symbol")?;
+        if stop <= start {
+            anyhow::bail!("No kernel API specifications found in vmlinux");
+        }
+
+        // `.kapi_specs` is a tightly-packed array of `struct kernel_api_spec *`
+        // pointers; walk them to find each real spec's vaddr, then resolve to
+        // a file offset inside `vmlinux`. Pointer width tracks the target
+        // (4 bytes for 32-bit, 8 bytes for 64-bit).
+        let ptr_size = if is_64bit { 8usize } else { 4 };
+        let ptr_count = ((stop - start) as usize) / ptr_size;
+        let ptr_file_off =
+            vaddr_to_file_offset(&elf, start).context("Could not locate .kapi_specs in file")?;
+
+        let read_ptr = |raw: &[u8]| -> u64 {
+            match (endian, is_64bit) {
+                (Endian::Little, true) => u64::from_le_bytes(raw.try_into().unwrap()),
+                (Endian::Big, true) => u64::from_be_bytes(raw.try_into().unwrap()),
+                (Endian::Little, false) => u32::from_le_bytes(raw.try_into().unwrap()) as u64,
+                (Endian::Big, false) => u32::from_be_bytes(raw.try_into().unwrap()) as u64,
+            }
+        };
+
+        let mut specs = Vec::with_capacity(ptr_count);
+        for i in 0..ptr_count {
+            let p = ptr_file_off + i * ptr_size;
+            if p + ptr_size > vmlinux.len() {
+                break;
+            }
+            let spec_vaddr = read_ptr(&vmlinux[p..p + ptr_size]);
+            if spec_vaddr == 0 {
+                continue;
+            }
+            let Some(spec_file_off) = vaddr_to_file_offset(&elf, spec_vaddr) else {
+                continue;
+            };
+            // The first field of `struct kernel_api_spec` is `const char *name`.
+            if spec_file_off + ptr_size > vmlinux.len() {
+                continue;
+            }
+            let name_vaddr = read_ptr(&vmlinux[spec_file_off..spec_file_off + ptr_size]);
+            let name =
+                binary_utils::resolve_vaddr_string(&elf, &vmlinux, name_vaddr).unwrap_or_default();
+            if name.is_empty() {
+                continue;
+            }
+            let api_type = if name.starts_with("sys_") {
+                "syscall"
+            } else if name.ends_with("_ioctl") {
+                "ioctl"
+            } else {
+                "function"
+            }
+            .to_string();
+            specs.push(KapiSpec {
+                name,
+                api_type,
+                file_offset: spec_file_off,
+            });
+        }
+
+        Ok(VmlinuxExtractor {
+            vmlinux,
+            specs,
+            endian,
+            is_64bit,
+        })
+    }
+}
+
+/// Map a virtual address to a file offset inside the raw vmlinux bytes.
+fn vaddr_to_file_offset(elf: &Elf, vaddr: u64) -> Option<usize> {
+    for sh in &elf.section_headers {
+        let start = sh.sh_addr;
+        let end = start.checked_add(sh.sh_size)?;
+        if vaddr >= start && vaddr < end {
+            if sh.sh_type == goblin::elf::section_header::SHT_NOBITS {
+                return None;
+            }
+            return Some((sh.sh_offset + (vaddr - start)) as usize);
+        }
+    }
+    None
+}
+
+impl VmlinuxExtractor {
+    fn parse_at(&self, file_offset: usize) -> Result<ApiSpec> {
+        parse_binary_to_api_spec(&self.vmlinux, file_offset, self.endian, self.is_64bit)
+    }
+}
+
+impl ApiExtractor for VmlinuxExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        Ok(self
+            .specs
+            .iter()
+            .map(|spec| {
+                self.parse_at(spec.file_offset).unwrap_or_else(|_| ApiSpec {
+                    name: spec.name.clone(),
+                    api_type: spec.api_type.clone(),
+                    ..Default::default()
+                })
+            })
+            .collect())
+    }
+
+    fn extract_by_name(&self, api_name: &str) -> Result<Option<ApiSpec>> {
+        if let Some(spec) = self.specs.iter().find(|s| s.name == api_name) {
+            Ok(Some(self.parse_at(spec.file_offset)?))
+        } else {
+            Ok(None)
+        }
+    }
+
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()> {
+        if let Some(spec) = self.specs.iter().find(|s| s.name == api_name) {
+            let api_spec = self.parse_at(spec.file_offset)?;
+            super::display_api_spec(&api_spec, formatter, writer)?;
+        }
+        Ok(())
+    }
+}
+
+/// Helper to read count and parse array items with optional magic offset
+fn parse_array_with_magic<T, F>(
+    reader: &mut DataReader,
+    magic_offset: Option<usize>,
+    max_items: u32,
+    parse_fn: F,
+) -> Vec<T>
+where
+    F: Fn(&mut DataReader, usize) -> Option<T>,
+{
+    // Read count - position at magic+4 if magic offset exists
+    let count = if let Some(offset) = magic_offset {
+        reader.pos = offset + 4;
+        reader.read_u32()
+    } else {
+        reader.read_u32()
+    };
+
+    let mut items = Vec::new();
+    if let Some(count) = count {
+        // Position at start of array data if magic offset exists
+        if let Some(offset) = magic_offset {
+            reader.pos = offset + 8; // +4 for magic, +4 for count
+        }
+        // Parse items up to max_items. Each element-parse is followed
+        // by align_to(ptr_size) so the next element starts on the
+        // struct's natural alignment boundary (kernel structs are no
+        // longer __packed, so the compiler may insert trailing
+        // padding after bools / u8 fields).
+        let align = reader.ptr_size();
+        for i in 0..count.min(max_items) as usize {
+            if let Some(item) = parse_fn(reader, i) {
+                items.push(item);
+            }
+            reader.align_to(align);
+        }
+    }
+    items
+}
+
+fn parse_binary_to_api_spec(
+    data: &[u8],
+    offset: usize,
+    endian: Endian,
+    is_64bit: bool,
+) -> Result<ApiSpec> {
+    let elf = Elf::parse(data).context("Failed to re-parse ELF for string resolution")?;
+    let resolver = binary_utils::StringResolver {
+        elf: &elf,
+        vmlinux: data,
+    };
+    let mut reader = DataReader::new(data, offset, endian, is_64bit).with_resolver(resolver);
+
+    // Bound magic-marker search to roughly sizeof(struct kernel_api_spec).
+    // The packed-const-char-pointer layout is ~25 KB per spec; 32 KB gives
+    // headroom without letting the finder leak into the next spec (or
+    // unrelated rodata) and pick up stray magic markers.
+    let search_end = (offset + 0x8000).min(data.len());
+    let spec_data = &data[offset..search_end];
+    let magic_offsets = magic_finder::MagicOffsets::find_in_data(spec_data, offset, endian);
+
+    // Read fields in exact order of struct kernel_api_spec.
+    // Every string field is a `const char *` pointer resolved via the
+    // StringResolver attached to the DataReader.
+    let name = reader
+        .read_optional_string(sizes::NAME)
+        .ok_or_else(|| anyhow::anyhow!("Failed to read API name"))?;
+
+    // Determine API type
+    let api_type = if name.starts_with("sys_") {
+        "syscall"
+    } else if name.ends_with("_ioctl") {
+        "ioctl"
+    } else if name.contains("sysfs") {
+        "sysfs"
+    } else {
+        "function"
+    }
+    .to_string();
+
+    // Read version (u32)
+    let version = reader.read_u32().map(|v| v.to_string());
+
+    // Read description (512 bytes)
+    let description = reader
+        .read_optional_string(sizes::DESC)
+        .filter(|s| !s.is_empty());
+
+    // Read long_description (2048 bytes)
+    let long_description = reader
+        .read_optional_string(sizes::DESC)
+        .filter(|s| !s.is_empty());
+
+    // Read context_flags (u32)
+    let context_flags = parse_context_flags(&mut reader);
+
+    // Parse params array
+    let parameters = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.param_offset,
+        sizes::MAX_PARAMS as u32,
+        parse_param,
+    );
+
+    // Read return_spec - position using magic offset if available
+    if let Some(offset) = magic_offsets.return_offset {
+        reader.pos = offset + 4; // skip past the return_magic u32
+    }
+    let return_spec = parse_return_spec(&mut reader);
+
+    // Parse errors array
+    let errors = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.error_offset,
+        sizes::MAX_ERRORS as u32,
+        |r, _| parse_error(r),
+    );
+
+    // Parse locks array
+    let locks = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.lock_offset,
+        sizes::MAX_LOCKS as u32,
+        |r, _| parse_lock(r),
+    );
+
+    // Parse constraints array
+    let constraints = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.constraint_offset,
+        sizes::MAX_CONSTRAINTS as u32,
+        |r, _| parse_constraint(r),
+    );
+
+    // Read examples and notes - position reader at info section if magic found
+    let (examples, notes) = if let Some(info_offset) = magic_offsets.info_offset {
+        reader.pos = info_offset + 4; // +4 to skip magic
+        let examples = reader
+            .read_optional_string(sizes::DESC)
+            .filter(|s| !s.is_empty());
+        let notes = reader
+            .read_optional_string(sizes::DESC)
+            .filter(|s| !s.is_empty());
+        (examples, notes)
+    } else {
+        let examples = reader
+            .read_optional_string(sizes::DESC)
+            .filter(|s| !s.is_empty());
+        let notes = reader
+            .read_optional_string(sizes::DESC)
+            .filter(|s| !s.is_empty());
+        (examples, notes)
+    };
+
+    // Parse signals array
+    let signals = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.signal_offset,
+        sizes::MAX_SIGNALS as u32,
+        |r, _| parse_signal(r),
+    );
+
+    // Read signal_mask_count (u32)
+    let signal_mask_count = reader.read_u32();
+
+    // Parse signal_masks array
+    let mut signal_masks = Vec::new();
+    if let Some(count) = signal_mask_count {
+        for i in 0..sizes::MAX_SIGNALS {
+            if i < count as usize {
+                if let Some(mask) = parse_signal_mask(&mut reader) {
+                    signal_masks.push(mask);
+                }
+            } else {
+                reader.skip(signal_mask_spec_layout_size());
+            }
+        }
+    } else {
+        reader.skip(signal_mask_spec_layout_size() * sizes::MAX_SIGNALS);
+    }
+
+    // Parse struct_specs array
+    let struct_specs = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.struct_offset,
+        sizes::MAX_STRUCT_SPECS as u32,
+        |r, _| parse_struct_spec(r),
+    );
+
+    // According to the C struct, the order is:
+    // side_effect_count, side_effects array, state_trans_count, state_transitions array,
+    // capability_count, capabilities array
+
+    // Parse side_effects array
+    let side_effects = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.effect_offset,
+        sizes::MAX_SIDE_EFFECTS as u32,
+        |r, _| parse_side_effect(r),
+    );
+
+    // Parse state_transitions array
+    let state_transitions = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.trans_offset,
+        sizes::MAX_STATE_TRANS as u32,
+        |r, _| parse_state_transition(r),
+    );
+
+    // Parse capabilities array
+    let capabilities = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.cap_offset,
+        sizes::MAX_CAPABILITIES as u32,
+        |r, _| parse_capability(r),
+    );
+
+    Ok(ApiSpec {
+        name,
+        api_type,
+        description,
+        long_description,
+        version,
+        context_flags,
+        param_count: if parameters.is_empty() {
+            None
+        } else {
+            Some(parameters.len() as u32)
+        },
+        error_count: if errors.is_empty() {
+            None
+        } else {
+            Some(errors.len() as u32)
+        },
+        examples,
+        notes,
+        subsystem: None,
+        sysfs_path: None,
+        permissions: None,
+        capabilities,
+        parameters,
+        return_spec,
+        errors,
+        signals,
+        signal_masks,
+        side_effects,
+        state_transitions,
+        constraints,
+        locks,
+        struct_specs,
+    })
+}
+
+// Helper parsing functions
+
+fn parse_context_flags(reader: &mut DataReader) -> Vec<String> {
+    const KAPI_CTX_PROCESS: u32 = 1 << 0;
+    const KAPI_CTX_SOFTIRQ: u32 = 1 << 1;
+    const KAPI_CTX_HARDIRQ: u32 = 1 << 2;
+    const KAPI_CTX_NMI: u32 = 1 << 3;
+    const KAPI_CTX_ATOMIC: u32 = 1 << 4;
+    const KAPI_CTX_SLEEPABLE: u32 = 1 << 5;
+    const KAPI_CTX_PREEMPT_DISABLED: u32 = 1 << 6;
+    const KAPI_CTX_IRQ_DISABLED: u32 = 1 << 7;
+
+    if let Some(flags) = reader.read_u32() {
+        let mut parts = Vec::new();
+
+        if flags & KAPI_CTX_PROCESS != 0 {
+            parts.push("KAPI_CTX_PROCESS");
+        }
+        if flags & KAPI_CTX_SOFTIRQ != 0 {
+            parts.push("KAPI_CTX_SOFTIRQ");
+        }
+        if flags & KAPI_CTX_HARDIRQ != 0 {
+            parts.push("KAPI_CTX_HARDIRQ");
+        }
+        if flags & KAPI_CTX_NMI != 0 {
+            parts.push("KAPI_CTX_NMI");
+        }
+        if flags & KAPI_CTX_ATOMIC != 0 {
+            parts.push("KAPI_CTX_ATOMIC");
+        }
+        if flags & KAPI_CTX_SLEEPABLE != 0 {
+            parts.push("KAPI_CTX_SLEEPABLE");
+        }
+        if flags & KAPI_CTX_PREEMPT_DISABLED != 0 {
+            parts.push("KAPI_CTX_PREEMPT_DISABLED");
+        }
+        if flags & KAPI_CTX_IRQ_DISABLED != 0 {
+            parts.push("KAPI_CTX_IRQ_DISABLED");
+        }
+
+        parts.into_iter().map(|s| s.to_string()).collect()
+    } else {
+        vec![]
+    }
+}
+
+fn parse_param(reader: &mut DataReader, index: usize) -> Option<ParamSpec> {
+    let name = reader.read_optional_string(sizes::NAME)?;
+    let type_name = reader.read_optional_string(sizes::NAME)?;
+    let param_type = reader.read_u32()?;
+    let flags = reader.read_u32()?;
+    let size = reader.read_usize()?;
+    let alignment = reader.read_usize()?;
+    let min_value = reader.read_i64()?;
+    let max_value = reader.read_i64()?;
+    let valid_mask = reader.read_u64()?;
+
+    // Skip enum_values pointer (8 bytes)
+    reader.skip(8);
+    let _enum_count = reader.read_u32()?; // Must use ? to propagate errors
+    let constraint_type = reader.read_u32()?;
+    // Skip validate function pointer (8 bytes)
+    reader.skip(8);
+
+    let description = reader.read_string_or_default(sizes::DESC);
+    let constraint = reader.read_optional_string(sizes::DESC);
+    let size_param_idx_raw = reader.read_i32()?; // Must use ? to propagate errors
+    let _size_multiplier = reader.read_usize()?; // Must use ? to propagate errors
+
+    // In the C struct, size_param_idx is stored 1-based; 0 means
+    // "no size-carrying param". Surface the real (0-based) index as
+    // `Option<u32>`.
+    let size_param_idx = if size_param_idx_raw > 0 {
+        Some((size_param_idx_raw - 1) as u32)
+    } else {
+        None
+    };
+
+    Some(ParamSpec {
+        index: index as u32,
+        name,
+        type_name,
+        description,
+        flags,
+        param_type,
+        constraint_type,
+        constraint,
+        min_value: Some(min_value),
+        max_value: Some(max_value),
+        valid_mask: Some(valid_mask),
+        enum_values: vec![],
+        size: Some(size as u32),
+        alignment: Some(alignment as u32),
+        size_param_idx,
+    })
+}
+
+fn parse_return_spec(reader: &mut DataReader) -> Option<ReturnSpec> {
+    // Read type_name, but treat empty as valid (will be empty string)
+    let type_name = reader.read_string_or_default(sizes::NAME);
+
+    // Read return_type and check_type
+    let return_type = reader.read_u32().unwrap_or(0);
+    let check_type = reader.read_u32().unwrap_or(0);
+    let success_value = reader.read_i64().unwrap_or(0);
+    let success_min = reader.read_i64().unwrap_or(0);
+    let success_max = reader.read_i64().unwrap_or(0);
+
+    // Skip error_values pointer (8 bytes)
+    reader.skip(8);
+    let _error_count = reader.read_u32().unwrap_or(0); // Don't fail on return spec
+                                                       // Skip is_success function pointer (8 bytes)
+    reader.skip(8);
+
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    // Return a spec even if type_name is empty, as long as we have some data
+    // The type_name might be a string like "KAPI_TYPE_INT" that gets stored literally
+    if type_name.is_empty() && return_type == 0 && check_type == 0 && success_value == 0 {
+        // No return spec at all
+        return None;
+    }
+
+    Some(ReturnSpec {
+        type_name,
+        description,
+        return_type,
+        check_type,
+        success_value: Some(success_value),
+        success_min: Some(success_min),
+        success_max: Some(success_max),
+        error_values: vec![],
+    })
+}
+
+fn parse_error(reader: &mut DataReader) -> Option<ErrorSpec> {
+    let error_code = reader.read_i32()?;
+    let name = reader.read_optional_string(sizes::NAME)?;
+    let condition = reader.read_string_or_default(sizes::DESC);
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    Some(ErrorSpec {
+        error_code,
+        name,
+        condition,
+        description,
+    })
+}
+
+fn parse_lock(reader: &mut DataReader) -> Option<LockSpec> {
+    let lock_name = reader.read_optional_string(sizes::NAME)?;
+    let lock_type = reader.read_u32()?;
+    let scope = reader.read_u32()?;
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    Some(LockSpec {
+        lock_name,
+        lock_type,
+        scope,
+        description,
+    })
+}
+
+fn parse_constraint(reader: &mut DataReader) -> Option<ConstraintSpec> {
+    let name = reader.read_optional_string(sizes::NAME)?;
+    let description = reader.read_string_or_default(sizes::DESC);
+    let expression = reader.read_string_or_default(sizes::DESC);
+
+    // No function pointer in packed struct
+
+    Some(ConstraintSpec {
+        name,
+        description,
+        expression: opt_string(expression),
+    })
+}
+
+fn parse_signal(reader: &mut DataReader) -> Option<SignalSpec> {
+    // Matches `struct kapi_signal_spec`. All string fields are pointers.
+    let signal_num = reader.read_i32()?;
+    let signal_name = reader.read_optional_string(sizes::NAME).unwrap_or_default();
+    let direction = reader.read_u32()?;
+    let action = reader.read_u32()?;
+    let target = reader.read_optional_string(sizes::DESC);
+    let condition = reader.read_optional_string(sizes::DESC);
+    let description = reader.read_optional_string(sizes::DESC);
+    let restartable = reader.read_bool()?;
+    let sa_flags_required = reader.read_u32()?;
+    let sa_flags_forbidden = reader.read_u32()?;
+    let error_on_signal = reader.read_i32()?;
+    let transform_to = reader.read_i32()?;
+    // Read the symbolic timing token (const char *) and map it to the
+    // numeric timing code used by downstream consumers.
+    let timing_str = reader.read_optional_string(sizes::NAME).unwrap_or_default();
+    let timing = match timing_str.as_str() {
+        "KAPI_SIGNAL_TIME_BEFORE" | "before" => 0u32,
+        "KAPI_SIGNAL_TIME_DURING" | "during" => 1,
+        "KAPI_SIGNAL_TIME_AFTER" | "after" => 2,
+        _ => 0,
+    };
+    let priority = reader.read_u8()?;
+    let interruptible = reader.read_bool()?;
+    let queue_behavior = reader.read_optional_string(sizes::NAME);
+    let state_required = reader.read_u32()?;
+    let state_forbidden = reader.read_u32()?;
+
+    Some(SignalSpec {
+        signal_num,
+        signal_name,
+        direction,
+        action,
+        target,
+        condition,
+        description,
+        timing,
+        priority: priority as u32,
+        restartable,
+        interruptible,
+        queue: queue_behavior,
+        sa_flags: 0, // Not a field of struct kapi_signal_spec
+        sa_flags_required,
+        sa_flags_forbidden,
+        state_required,
+        state_forbidden,
+        // `error_on_signal` of 0 means "no errno returned"; surface
+        // that as None to match the source-parser convention.
+        error_on_signal: if error_on_signal != 0 {
+            Some(error_on_signal)
+        } else {
+            None
+        },
+        transform_to: if transform_to != 0 {
+            // The compiled struct holds the numeric value; the C
+            // preprocessor already resolved any signal symbol.
+            Some(transform_to)
+        } else {
+            None
+        },
+    })
+}
+
+fn parse_signal_mask(reader: &mut DataReader) -> Option<SignalMaskSpec> {
+    let name = reader.read_optional_string(sizes::NAME)?;
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    // Skip signals array
+    for _ in 0..sizes::MAX_SIGNALS {
+        reader.read_i32();
+    }
+
+    let _signal_count = reader.read_u32()?;
+
+    Some(SignalMaskSpec { name, description })
+}
+
+fn parse_struct_field(reader: &mut DataReader) -> Option<StructFieldSpec> {
+    let name = reader.read_optional_string(sizes::NAME)?;
+    let field_type = reader.read_u32()?;
+    let type_name = reader.read_optional_string(sizes::NAME)?;
+    let offset = reader.read_usize()?;
+    let size = reader.read_usize()?;
+    let flags = reader.read_u32()?;
+    let constraint_type = reader.read_u32()?;
+    let min_value = reader.read_i64()?;
+    let max_value = reader.read_i64()?;
+    let valid_mask = reader.read_u64()?;
+    // Skip enum_values field (512 bytes)
+    let _enum_values = reader.read_optional_string(sizes::DESC); // Don't fail on optional field
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    Some(StructFieldSpec {
+        name,
+        field_type,
+        type_name,
+        offset,
+        size,
+        flags,
+        constraint_type,
+        min_value,
+        max_value,
+        valid_mask,
+        description,
+    })
+}
+
+fn parse_struct_spec(reader: &mut DataReader) -> Option<StructSpec> {
+    let name = reader.read_optional_string(sizes::NAME)?;
+    let size = reader.read_usize()?;
+    let alignment = reader.read_usize()?;
+    let field_count = reader.read_u32()?;
+
+    // Parse fields array
+    let mut fields = Vec::new();
+    for _ in 0..field_count.min(sizes::MAX_PARAMS as u32) {
+        if let Some(field) = parse_struct_field(reader) {
+            fields.push(field);
+        } else {
+            // Skip this field if we can't parse it
+            reader.skip(struct_field_layout_size());
+        }
+    }
+
+    // Skip remaining fields if any
+    let remaining = sizes::MAX_PARAMS as u32 - field_count.min(sizes::MAX_PARAMS as u32);
+    for _ in 0..remaining {
+        reader.skip(struct_field_layout_size());
+    }
+
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    Some(StructSpec {
+        name,
+        size,
+        alignment,
+        field_count,
+        fields,
+        description,
+    })
+}
+
+fn parse_side_effect(reader: &mut DataReader) -> Option<SideEffectSpec> {
+    let effect_type = reader.read_u32()?;
+    let target = reader.read_optional_string(sizes::NAME)?;
+    let condition = reader.read_string_or_default(sizes::DESC);
+    let description = reader.read_string_or_default(sizes::DESC);
+    let reversible = reader.read_bool()?;
+    // No padding needed for packed struct
+
+    Some(SideEffectSpec {
+        effect_type,
+        target,
+        condition: opt_string(condition),
+        description,
+        reversible,
+    })
+}
+
+fn parse_state_transition(reader: &mut DataReader) -> Option<StateTransitionSpec> {
+    let from_state = reader.read_optional_string(sizes::NAME)?;
+    let to_state = reader.read_optional_string(sizes::NAME)?;
+    let condition = reader.read_string_or_default(sizes::DESC);
+    let object = reader.read_optional_string(sizes::NAME)?;
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    Some(StateTransitionSpec {
+        object,
+        from_state,
+        to_state,
+        condition: opt_string(condition),
+        description,
+    })
+}
+
+fn parse_capability(reader: &mut DataReader) -> Option<CapabilitySpec> {
+    // Struct layout matches `struct kapi_capability_spec`:
+    //   int capability; const char *cap_name; enum action;
+    //   const char *allows; const char *without_cap;
+    //   const char *check_condition; u8 priority;
+    //   int alternative[KAPI_MAX_CAPABILITIES]; u32 alternative_count;
+    let capability = reader.read_i32()?;
+    let cap_name = reader.read_optional_string(sizes::NAME)?;
+    let action = reader.read_u32()?;
+    let allows = reader.read_string_or_default(sizes::DESC);
+    let without_cap = reader.read_string_or_default(sizes::DESC);
+    let check_condition = reader.read_optional_string(sizes::DESC);
+    let priority = reader.read_u8()?;
+
+    let mut alternatives = Vec::new();
+    for _ in 0..sizes::MAX_CAPABILITIES {
+        if let Some(alt) = reader.read_i32() {
+            if alt != 0 {
+                alternatives.push(alt);
+            }
+        }
+    }
+
+    let _alternative_count = reader.read_u32()?;
+
+    Some(CapabilitySpec {
+        capability,
+        name: cap_name,
+        action: capability_action_to_string(action),
+        allows,
+        without_cap,
+        check_condition,
+        priority: Some(priority),
+        alternatives,
+    })
+}
+
+/// Map the `enum kapi_capability_action` numeric value to its symbolic
+/// spelling, matching `include/linux/kernel_api_spec.h`.
+fn capability_action_to_string(n: u32) -> String {
+    match n {
+        0 => "KAPI_CAP_BYPASS_CHECK",
+        1 => "KAPI_CAP_INCREASE_LIMIT",
+        2 => "KAPI_CAP_OVERRIDE_RESTRICTION",
+        3 => "KAPI_CAP_GRANT_PERMISSION",
+        4 => "KAPI_CAP_MODIFY_BEHAVIOR",
+        5 => "KAPI_CAP_ACCESS_RESOURCE",
+        6 => "KAPI_CAP_PERFORM_OPERATION",
+        _ => return n.to_string(),
+    }
+    .to_string()
+}
diff --git a/tools/kapi/src/formatter/json.rs b/tools/kapi/src/formatter/json.rs
new file mode 100644
index 0000000000000..ec1adfae0b448
--- /dev/null
+++ b/tools/kapi/src/formatter/json.rs
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use super::OutputFormatter;
+use crate::extractor::{
+    CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec, ReturnSpec, SideEffectSpec,
+    SignalMaskSpec, SignalSpec, StateTransitionSpec, StructSpec,
+};
+use serde::Serialize;
+use std::io::Write;
+
+pub struct JsonFormatter {
+    data: JsonData,
+}
+
+#[derive(Serialize)]
+struct JsonData {
+    #[serde(skip_serializing_if = "Option::is_none")]
+    apis: Option<Vec<JsonApi>>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    api_details: Option<JsonApiDetails>,
+}
+
+#[derive(Serialize)]
+struct JsonApi {
+    name: String,
+    api_type: String,
+}
+
+#[derive(Serialize)]
+struct JsonApiDetails {
+    name: String,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    description: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    long_description: Option<String>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    context_flags: Vec<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    examples: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    notes: Option<String>,
+    // Sysfs-specific fields
+    #[serde(skip_serializing_if = "Option::is_none")]
+    subsystem: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    sysfs_path: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    permissions: Option<String>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    capabilities: Vec<CapabilitySpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    state_transitions: Vec<StateTransitionSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    side_effects: Vec<SideEffectSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    parameters: Vec<ParamSpec>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    return_spec: Option<ReturnSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    errors: Vec<ErrorSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    locks: Vec<LockSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    struct_specs: Vec<StructSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    signals: Vec<SignalSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    signal_masks: Vec<SignalMaskSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    constraints: Vec<ConstraintSpec>,
+}
+
+impl JsonFormatter {
+    pub fn new() -> Self {
+        JsonFormatter {
+            data: JsonData {
+                apis: None,
+                api_details: None,
+            },
+        }
+    }
+}
+
+impl OutputFormatter for JsonFormatter {
+    fn begin_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_document(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        let json = serde_json::to_string_pretty(&self.data)?;
+        writeln!(w, "{json}")?;
+        Ok(())
+    }
+
+    fn begin_api_list(&mut self, _w: &mut dyn Write, _title: &str) -> std::io::Result<()> {
+        if self.data.apis.is_none() {
+            self.data.apis = Some(Vec::new());
+        }
+        Ok(())
+    }
+
+    fn api_item(&mut self, _w: &mut dyn Write, name: &str, api_type: &str) -> std::io::Result<()> {
+        if let Some(apis) = &mut self.data.apis {
+            apis.push(JsonApi {
+                name: name.to_string(),
+                api_type: api_type.to_string(),
+            });
+        }
+        Ok(())
+    }
+
+    fn end_api_list(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn total_specs(&mut self, _w: &mut dyn Write, _count: usize) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_api_details(&mut self, _w: &mut dyn Write, name: &str) -> std::io::Result<()> {
+        self.data.api_details = Some(JsonApiDetails {
+            name: name.to_string(),
+            description: None,
+            long_description: None,
+            context_flags: Vec::new(),
+            examples: None,
+            notes: None,
+            subsystem: None,
+            sysfs_path: None,
+            permissions: None,
+            capabilities: Vec::new(),
+            state_transitions: Vec::new(),
+            side_effects: Vec::new(),
+            parameters: Vec::new(),
+            return_spec: None,
+            errors: Vec::new(),
+            locks: Vec::new(),
+            struct_specs: Vec::new(),
+            signals: Vec::new(),
+            signal_masks: Vec::new(),
+            constraints: Vec::new(),
+        });
+        Ok(())
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn description(&mut self, _w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.description = Some(desc.to_string());
+        }
+        Ok(())
+    }
+
+    fn long_description(&mut self, _w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.long_description = Some(desc.to_string());
+        }
+        Ok(())
+    }
+
+    fn begin_context_flags(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn context_flag(&mut self, _w: &mut dyn Write, flag: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.context_flags.push(flag.to_string());
+        }
+        Ok(())
+    }
+
+    fn end_context_flags(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_parameters(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_parameters(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_errors(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_errors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn examples(&mut self, _w: &mut dyn Write, examples: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.examples = Some(examples.to_string());
+        }
+        Ok(())
+    }
+
+    fn notes(&mut self, _w: &mut dyn Write, notes: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.notes = Some(notes.to_string());
+        }
+        Ok(())
+    }
+
+    fn sysfs_subsystem(&mut self, _w: &mut dyn Write, subsystem: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.subsystem = Some(subsystem.to_string());
+        }
+        Ok(())
+    }
+
+    fn sysfs_path(&mut self, _w: &mut dyn Write, path: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.sysfs_path = Some(path.to_string());
+        }
+        Ok(())
+    }
+
+    fn sysfs_permissions(&mut self, _w: &mut dyn Write, perms: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.permissions = Some(perms.to_string());
+        }
+        Ok(())
+    }
+
+    fn begin_capabilities(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn capability(&mut self, _w: &mut dyn Write, cap: &CapabilitySpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.capabilities.push(cap.clone());
+        }
+        Ok(())
+    }
+
+    fn end_capabilities(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn parameter(&mut self, _w: &mut dyn Write, param: &ParamSpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.parameters.push(param.clone());
+        }
+        Ok(())
+    }
+
+    fn return_spec(&mut self, _w: &mut dyn Write, ret: &ReturnSpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.return_spec = Some(ret.clone());
+        }
+        Ok(())
+    }
+
+    fn error(&mut self, _w: &mut dyn Write, error: &ErrorSpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.errors.push(error.clone());
+        }
+        Ok(())
+    }
+
+    fn begin_signals(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn signal(&mut self, _w: &mut dyn Write, signal: &SignalSpec) -> std::io::Result<()> {
+        if let Some(api_details) = &mut self.data.api_details {
+            api_details.signals.push(signal.clone());
+        }
+        Ok(())
+    }
+
+    fn end_signals(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_signal_masks(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn signal_mask(&mut self, _w: &mut dyn Write, mask: &SignalMaskSpec) -> std::io::Result<()> {
+        if let Some(api_details) = &mut self.data.api_details {
+            api_details.signal_masks.push(mask.clone());
+        }
+        Ok(())
+    }
+
+    fn end_signal_masks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_side_effects(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn side_effect(&mut self, _w: &mut dyn Write, effect: &SideEffectSpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.side_effects.push(effect.clone());
+        }
+        Ok(())
+    }
+
+    fn end_side_effects(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_state_transitions(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn state_transition(
+        &mut self,
+        _w: &mut dyn Write,
+        trans: &StateTransitionSpec,
+    ) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.state_transitions.push(trans.clone());
+        }
+        Ok(())
+    }
+
+    fn end_state_transitions(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_constraints(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn constraint(
+        &mut self,
+        _w: &mut dyn Write,
+        constraint: &ConstraintSpec,
+    ) -> std::io::Result<()> {
+        if let Some(api_details) = &mut self.data.api_details {
+            api_details.constraints.push(constraint.clone());
+        }
+        Ok(())
+    }
+
+    fn end_constraints(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_locks(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn lock(&mut self, _w: &mut dyn Write, lock: &LockSpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.locks.push(lock.clone());
+        }
+        Ok(())
+    }
+
+    fn end_locks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_struct_specs(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn struct_spec(&mut self, _w: &mut dyn Write, spec: &StructSpec) -> std::io::Result<()> {
+        if let Some(ref mut details) = self.data.api_details {
+            details.struct_specs.push(spec.clone());
+        }
+        Ok(())
+    }
+
+    fn end_struct_specs(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+    use crate::extractor::{ErrorSpec, ParamSpec, ReturnSpec};
+
+    fn render_json(f: &mut JsonFormatter) -> String {
+        let mut buf = Vec::new();
+        f.end_document(&mut buf).unwrap();
+        String::from_utf8(buf).unwrap()
+    }
+
+    #[test]
+    fn json_output_is_valid() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.description(&mut sink, "A test syscall").unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+
+        // Verify it parses as valid JSON
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+        assert_eq!(parsed["api_details"]["name"].as_str(), Some("sys_test"));
+        assert_eq!(
+            parsed["api_details"]["description"].as_str(),
+            Some("A test syscall")
+        );
+    }
+
+    #[test]
+    fn json_api_list() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_list(&mut sink, "Syscalls").unwrap();
+        f.api_item(&mut sink, "sys_open", "syscall").unwrap();
+        f.api_item(&mut sink, "sys_read", "syscall").unwrap();
+        f.end_api_list(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+
+        let apis = parsed["apis"].as_array().unwrap();
+        assert_eq!(apis.len(), 2);
+        assert_eq!(apis[0]["name"].as_str(), Some("sys_open"));
+        assert_eq!(apis[0]["api_type"].as_str(), Some("syscall"));
+        assert_eq!(apis[1]["name"].as_str(), Some("sys_read"));
+    }
+
+    #[test]
+    fn json_special_characters_in_description() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.description(&mut sink, "Contains \"quotes\" and \\backslashes\\")
+            .unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+
+        // Must be valid JSON despite special characters
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+        assert_eq!(
+            parsed["api_details"]["description"].as_str(),
+            Some("Contains \"quotes\" and \\backslashes\\")
+        );
+    }
+
+    #[test]
+    fn json_special_characters_in_name() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_list(&mut sink, "APIs").unwrap();
+        // Names with underscores (common in kernel) and unusual strings
+        f.api_item(&mut sink, "sys_new\tline", "syscall").unwrap();
+        f.end_api_list(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+
+        // Must parse correctly; serde_json handles escaping for us
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+        assert_eq!(parsed["apis"][0]["name"].as_str(), Some("sys_new\tline"));
+    }
+
+    #[test]
+    fn json_parameters_serialized() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_write").unwrap();
+        f.begin_parameters(&mut sink, 2).unwrap();
+        f.parameter(
+            &mut sink,
+            &ParamSpec {
+                index: 0,
+                name: "fd".to_string(),
+                type_name: "unsigned int".to_string(),
+                description: "file descriptor".to_string(),
+                flags: 1,
+                param_type: 2,
+                constraint_type: 0,
+                constraint: None,
+                min_value: Some(0),
+                max_value: Some(1024),
+                valid_mask: None,
+                enum_values: vec![],
+                size: None,
+                alignment: None,
+                size_param_idx: None,
+            },
+        )
+        .unwrap();
+        f.end_parameters(&mut sink).unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+
+        let params = parsed["api_details"]["parameters"].as_array().unwrap();
+        assert_eq!(params.len(), 1);
+        assert_eq!(params[0]["name"].as_str(), Some("fd"));
+        assert_eq!(params[0]["param_type"].as_u64(), Some(2));
+    }
+
+    #[test]
+    fn json_errors_serialized() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_read").unwrap();
+        f.begin_errors(&mut sink, 1).unwrap();
+        f.error(
+            &mut sink,
+            &ErrorSpec {
+                error_code: -9,
+                name: "EBADF".to_string(),
+                condition: "fd is not valid".to_string(),
+                description: "Bad file descriptor".to_string(),
+            },
+        )
+        .unwrap();
+        f.end_errors(&mut sink).unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+
+        let errors = parsed["api_details"]["errors"].as_array().unwrap();
+        assert_eq!(errors.len(), 1);
+        assert_eq!(errors[0]["name"].as_str(), Some("EBADF"));
+        assert_eq!(errors[0]["error_code"].as_i64(), Some(-9));
+    }
+
+    #[test]
+    fn json_empty_details_omits_empty_fields() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_empty").unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+
+        // description should not be present (skip_serializing_if = Option::is_none)
+        assert!(parsed["api_details"]["description"].is_null());
+        // parameters empty array should not be present (skip_serializing_if = Vec::is_empty)
+        assert!(parsed["api_details"]["parameters"].is_null());
+        // errors empty array should not be present
+        assert!(parsed["api_details"]["errors"].is_null());
+    }
+
+    #[test]
+    fn json_braces_balance() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_balanced").unwrap();
+        f.description(&mut sink, "Test braces balance").unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+
+        let open_braces = json.chars().filter(|&c| c == '{').count();
+        let close_braces = json.chars().filter(|&c| c == '}').count();
+        assert_eq!(open_braces, close_braces, "Braces are unbalanced");
+
+        let open_brackets = json.chars().filter(|&c| c == '[').count();
+        let close_brackets = json.chars().filter(|&c| c == ']').count();
+        assert_eq!(open_brackets, close_brackets, "Brackets are unbalanced");
+    }
+
+    #[test]
+    fn json_return_spec_serialized() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_open").unwrap();
+        f.return_spec(
+            &mut sink,
+            &ReturnSpec {
+                type_name: "int".to_string(),
+                description: "file descriptor on success".to_string(),
+                return_type: 1,
+                check_type: 3,
+                success_value: Some(0),
+                success_min: None,
+                success_max: None,
+                error_values: vec![-1],
+            },
+        )
+        .unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+
+        let ret = &parsed["api_details"]["return_spec"];
+        assert_eq!(ret["type_name"].as_str(), Some("int"));
+        assert_eq!(ret["check_type"].as_u64(), Some(3));
+    }
+
+    #[test]
+    fn json_unicode_in_description() {
+        let mut f = JsonFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_uni").unwrap();
+        f.description(&mut sink, "Supports unicode: \u{00e9}\u{00e8}\u{00ea}")
+            .unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let json = render_json(&mut f);
+        let parsed: serde_json::Value = serde_json::from_str(&json).unwrap();
+        assert!(parsed["api_details"]["description"]
+            .as_str()
+            .unwrap()
+            .contains('\u{00e9}'));
+    }
+}
diff --git a/tools/kapi/src/formatter/mod.rs b/tools/kapi/src/formatter/mod.rs
new file mode 100644
index 0000000000000..362531af47102
--- /dev/null
+++ b/tools/kapi/src/formatter/mod.rs
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use crate::extractor::{
+    CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec, ReturnSpec, SideEffectSpec,
+    SignalMaskSpec, SignalSpec, StateTransitionSpec, StructSpec,
+};
+use std::io::Write;
+
+mod json;
+mod plain;
+mod rst;
+
+pub use json::JsonFormatter;
+pub use plain::PlainFormatter;
+pub use rst::RstFormatter;
+
+#[derive(Debug, Clone, Copy, PartialEq)]
+pub enum OutputFormat {
+    Plain,
+    Json,
+    Rst,
+}
+
+impl std::str::FromStr for OutputFormat {
+    type Err = String;
+
+    fn from_str(s: &str) -> Result<Self, Self::Err> {
+        match s.to_lowercase().as_str() {
+            "plain" => Ok(OutputFormat::Plain),
+            "json" => Ok(OutputFormat::Json),
+            "rst" => Ok(OutputFormat::Rst),
+            _ => Err(format!("Unknown output format: {}", s)),
+        }
+    }
+}
+
+pub trait OutputFormatter {
+    fn begin_document(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn end_document(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_api_list(&mut self, w: &mut dyn Write, title: &str) -> std::io::Result<()>;
+    fn api_item(&mut self, w: &mut dyn Write, name: &str, api_type: &str) -> std::io::Result<()>;
+    fn end_api_list(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn total_specs(&mut self, w: &mut dyn Write, count: usize) -> std::io::Result<()>;
+
+    fn begin_api_details(&mut self, w: &mut dyn Write, name: &str) -> std::io::Result<()>;
+    fn end_api_details(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()>;
+    fn long_description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()>;
+
+    fn begin_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn context_flag(&mut self, w: &mut dyn Write, flag: &str) -> std::io::Result<()>;
+    fn end_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_parameters(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn parameter(&mut self, w: &mut dyn Write, param: &ParamSpec) -> std::io::Result<()>;
+    fn end_parameters(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn return_spec(&mut self, w: &mut dyn Write, ret: &ReturnSpec) -> std::io::Result<()>;
+
+    fn begin_errors(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn error(&mut self, w: &mut dyn Write, error: &ErrorSpec) -> std::io::Result<()>;
+    fn end_errors(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn examples(&mut self, w: &mut dyn Write, examples: &str) -> std::io::Result<()>;
+    fn notes(&mut self, w: &mut dyn Write, notes: &str) -> std::io::Result<()>;
+
+    // Sysfs-specific methods
+    fn sysfs_subsystem(&mut self, w: &mut dyn Write, subsystem: &str) -> std::io::Result<()>;
+    fn sysfs_path(&mut self, w: &mut dyn Write, path: &str) -> std::io::Result<()>;
+    fn sysfs_permissions(&mut self, w: &mut dyn Write, perms: &str) -> std::io::Result<()>;
+
+    fn begin_capabilities(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn capability(&mut self, w: &mut dyn Write, cap: &CapabilitySpec) -> std::io::Result<()>;
+    fn end_capabilities(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    // Signal-related methods
+    fn begin_signals(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn signal(&mut self, w: &mut dyn Write, signal: &SignalSpec) -> std::io::Result<()>;
+    fn end_signals(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_signal_masks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn signal_mask(&mut self, w: &mut dyn Write, mask: &SignalMaskSpec) -> std::io::Result<()>;
+    fn end_signal_masks(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    // Side effects and state transitions
+    fn begin_side_effects(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn side_effect(&mut self, w: &mut dyn Write, effect: &SideEffectSpec) -> std::io::Result<()>;
+    fn end_side_effects(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_state_transitions(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn state_transition(
+        &mut self,
+        w: &mut dyn Write,
+        trans: &StateTransitionSpec,
+    ) -> std::io::Result<()>;
+    fn end_state_transitions(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    // Constraints and locks
+    fn begin_constraints(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn constraint(&mut self, w: &mut dyn Write, constraint: &ConstraintSpec)
+        -> std::io::Result<()>;
+    fn end_constraints(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_locks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn lock(&mut self, w: &mut dyn Write, lock: &LockSpec) -> std::io::Result<()>;
+    fn end_locks(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_struct_specs(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn struct_spec(&mut self, w: &mut dyn Write, spec: &StructSpec) -> std::io::Result<()>;
+    fn end_struct_specs(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+}
+
+pub fn create_formatter(format: OutputFormat) -> Box<dyn OutputFormatter> {
+    match format {
+        OutputFormat::Plain => Box::new(PlainFormatter::new()),
+        OutputFormat::Json => Box::new(JsonFormatter::new()),
+        OutputFormat::Rst => Box::new(RstFormatter::new()),
+    }
+}
diff --git a/tools/kapi/src/formatter/plain.rs b/tools/kapi/src/formatter/plain.rs
new file mode 100644
index 0000000000000..3b8a9e69e3b2a
--- /dev/null
+++ b/tools/kapi/src/formatter/plain.rs
@@ -0,0 +1,646 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use super::OutputFormatter;
+use crate::extractor::{
+    CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec, ReturnSpec, SideEffectSpec,
+    SignalMaskSpec, SignalSpec, StateTransitionSpec,
+};
+use std::io::Write;
+
+pub struct PlainFormatter;
+
+impl PlainFormatter {
+    pub fn new() -> Self {
+        PlainFormatter
+    }
+}
+
+impl OutputFormatter for PlainFormatter {
+    fn begin_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_api_list(&mut self, w: &mut dyn Write, title: &str) -> std::io::Result<()> {
+        writeln!(w, "\n{title}:")?;
+        writeln!(w, "{}", "-".repeat(title.len() + 1))
+    }
+
+    fn api_item(&mut self, w: &mut dyn Write, name: &str, _api_type: &str) -> std::io::Result<()> {
+        writeln!(w, "  {name}")
+    }
+
+    fn end_api_list(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn total_specs(&mut self, w: &mut dyn Write, count: usize) -> std::io::Result<()> {
+        writeln!(w, "\nTotal specifications found: {count}")
+    }
+
+    fn begin_api_details(&mut self, w: &mut dyn Write, name: &str) -> std::io::Result<()> {
+        writeln!(w, "\nDetailed information for {name}:")?;
+        writeln!(w, "{}=", "=".repeat(25 + name.len()))
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "Description: {desc}")
+    }
+
+    fn long_description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "\nDetailed Description:")?;
+        writeln!(w, "{desc}")
+    }
+
+    fn begin_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nExecution Context:")
+    }
+
+    fn context_flag(&mut self, w: &mut dyn Write, flag: &str) -> std::io::Result<()> {
+        writeln!(w, "  - {flag}")
+    }
+
+    fn end_context_flags(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_parameters(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nParameters ({count}):")
+    }
+
+    fn parameter(&mut self, w: &mut dyn Write, param: &ParamSpec) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "  [{}] {} ({})",
+            param.index, param.name, param.type_name
+        )?;
+        if !param.description.is_empty() {
+            writeln!(w, "      {}", param.description)?;
+        }
+
+        // Display flags
+        let mut flags = Vec::new();
+        if param.flags & 0x01 != 0 {
+            flags.push("IN");
+        }
+        if param.flags & 0x02 != 0 {
+            flags.push("OUT");
+        }
+        if param.flags & 0x04 != 0 {
+            flags.push("INOUT");
+        }
+        if param.flags & 0x08 != 0 {
+            flags.push("USER");
+        }
+        if param.flags & 0x10 != 0 {
+            flags.push("OPTIONAL");
+        }
+        if !flags.is_empty() {
+            writeln!(w, "      Flags: {}", flags.join(" | "))?;
+        }
+
+        // Display constraints
+        if let Some(constraint) = &param.constraint {
+            writeln!(w, "      Constraint: {constraint}")?;
+        }
+        if let (Some(min), Some(max)) = (param.min_value, param.max_value) {
+            writeln!(w, "      Range: {min} to {max}")?;
+        }
+        if let Some(mask) = param.valid_mask {
+            writeln!(w, "      Valid mask: 0x{mask:x}")?;
+        }
+        Ok(())
+    }
+
+    fn end_parameters(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn return_spec(&mut self, w: &mut dyn Write, ret: &ReturnSpec) -> std::io::Result<()> {
+        writeln!(w, "\nReturn Value:")?;
+        writeln!(w, "  Type: {}", ret.type_name)?;
+        writeln!(w, "  {}", ret.description)?;
+        if let Some(val) = ret.success_value {
+            writeln!(w, "  Success value: {val}")?;
+        }
+        if let (Some(min), Some(max)) = (ret.success_min, ret.success_max) {
+            writeln!(w, "  Success range: {min} to {max}")?;
+        }
+        Ok(())
+    }
+
+    fn begin_errors(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nPossible Errors ({count}):")
+    }
+
+    fn error(&mut self, w: &mut dyn Write, error: &ErrorSpec) -> std::io::Result<()> {
+        writeln!(w, "  {} ({})", error.name, error.error_code)?;
+        if !error.condition.is_empty() {
+            writeln!(w, "      Condition: {}", error.condition)?;
+        }
+        if !error.description.is_empty() {
+            writeln!(w, "      {}", error.description)?;
+        }
+        Ok(())
+    }
+
+    fn end_errors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn examples(&mut self, w: &mut dyn Write, examples: &str) -> std::io::Result<()> {
+        writeln!(w, "\nExamples:")?;
+        writeln!(w, "{examples}")
+    }
+
+    fn notes(&mut self, w: &mut dyn Write, notes: &str) -> std::io::Result<()> {
+        writeln!(w, "\nNotes:")?;
+        writeln!(w, "{notes}")
+    }
+
+    fn sysfs_subsystem(&mut self, w: &mut dyn Write, subsystem: &str) -> std::io::Result<()> {
+        writeln!(w, "Subsystem: {subsystem}")
+    }
+
+    fn sysfs_path(&mut self, w: &mut dyn Write, path: &str) -> std::io::Result<()> {
+        writeln!(w, "Sysfs Path: {path}")
+    }
+
+    fn sysfs_permissions(&mut self, w: &mut dyn Write, perms: &str) -> std::io::Result<()> {
+        writeln!(w, "Permissions: {perms}")
+    }
+
+    fn begin_capabilities(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nRequired Capabilities:")
+    }
+
+    fn capability(&mut self, w: &mut dyn Write, cap: &CapabilitySpec) -> std::io::Result<()> {
+        writeln!(w, "  {} ({}) - {}", cap.name, cap.capability, cap.action)?;
+        if !cap.allows.is_empty() {
+            writeln!(w, "    Allows: {}", cap.allows)?;
+        }
+        if !cap.without_cap.is_empty() {
+            writeln!(w, "    Without capability: {}", cap.without_cap)?;
+        }
+        if let Some(cond) = &cap.check_condition {
+            writeln!(w, "    Condition: {cond}")?;
+        }
+        Ok(())
+    }
+
+    fn end_capabilities(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    // Signal-related methods
+    fn begin_signals(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nSignal Specifications ({count}):")
+    }
+
+    fn signal(&mut self, w: &mut dyn Write, signal: &SignalSpec) -> std::io::Result<()> {
+        write!(w, "  {} ({})", signal.signal_name, signal.signal_num)?;
+
+        // Display direction (bitmask matching C enum kapi_signal_direction)
+        let mut dirs = Vec::new();
+        if signal.direction & 1 != 0 {
+            dirs.push("RECEIVE");
+        }
+        if signal.direction & 2 != 0 {
+            dirs.push("SEND");
+        }
+        if signal.direction & 4 != 0 {
+            dirs.push("HANDLE");
+        }
+        if signal.direction & 8 != 0 {
+            dirs.push("BLOCK");
+        }
+        if signal.direction & 16 != 0 {
+            dirs.push("IGNORE");
+        }
+        let direction = if dirs.is_empty() {
+            "UNKNOWN".to_string()
+        } else {
+            dirs.join("|")
+        };
+        write!(w, " - {direction}")?;
+
+        // Display action (matching C enum kapi_signal_action)
+        let action = match signal.action {
+            0 => "DEFAULT",
+            1 => "TERMINATE",
+            2 => "COREDUMP",
+            3 => "STOP",
+            4 => "CONTINUE",
+            5 => "CUSTOM",
+            6 => "RETURN",
+            7 => "RESTART",
+            8 => "QUEUE",
+            9 => "DISCARD",
+            10 => "TRANSFORM",
+            _ => "UNKNOWN",
+        };
+        writeln!(w, " - {action}")?;
+
+        if let Some(target) = &signal.target {
+            writeln!(w, "      Target: {target}")?;
+        }
+        if let Some(condition) = &signal.condition {
+            writeln!(w, "      Condition: {condition}")?;
+        }
+        if let Some(desc) = &signal.description {
+            writeln!(w, "      {desc}")?;
+        }
+
+        // Display timing
+        let timing = match signal.timing {
+            0 => "BEFORE",
+            1 => "DURING",
+            2 => "AFTER",
+            3 => "EXIT",
+            _ => "UNKNOWN",
+        };
+        writeln!(w, "      Timing: {timing}")?;
+        writeln!(w, "      Priority: {}", signal.priority)?;
+
+        if signal.restartable {
+            writeln!(w, "      Restartable: yes")?;
+        }
+        if signal.interruptible {
+            writeln!(w, "      Interruptible: yes")?;
+        }
+        if let Some(queue) = &signal.queue {
+            writeln!(w, "      Queue: {queue}")?;
+        }
+        if signal.sa_flags_required != 0 {
+            writeln!(
+                w,
+                "      SA flags required: {:#x}",
+                signal.sa_flags_required
+            )?;
+        }
+        if signal.sa_flags_forbidden != 0 {
+            writeln!(
+                w,
+                "      SA flags forbidden: {:#x}",
+                signal.sa_flags_forbidden
+            )?;
+        }
+        if signal.state_required != 0 {
+            writeln!(w, "      State required: {:#x}", signal.state_required)?;
+        }
+        if signal.state_forbidden != 0 {
+            writeln!(w, "      State forbidden: {:#x}", signal.state_forbidden)?;
+        }
+        if let Some(error) = signal.error_on_signal {
+            writeln!(w, "      Error on signal: {error}")?;
+        }
+        if let Some(transform) = signal.transform_to {
+            writeln!(w, "      Transform to: {transform}")?;
+        }
+        Ok(())
+    }
+
+    fn end_signals(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_signal_masks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nSignal Masks ({count}):")
+    }
+
+    fn signal_mask(&mut self, w: &mut dyn Write, mask: &SignalMaskSpec) -> std::io::Result<()> {
+        writeln!(w, "  {}", mask.name)?;
+        if !mask.description.is_empty() {
+            writeln!(w, "      {}", mask.description)?;
+        }
+        Ok(())
+    }
+
+    fn end_signal_masks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    // Side effects and state transitions
+    fn begin_side_effects(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nSide Effects ({count}):")
+    }
+
+    fn side_effect(&mut self, w: &mut dyn Write, effect: &SideEffectSpec) -> std::io::Result<()> {
+        writeln!(w, "  {} - {}", effect.target, effect.description)?;
+        if let Some(condition) = &effect.condition {
+            writeln!(w, "      Condition: {condition}")?;
+        }
+        if effect.reversible {
+            writeln!(w, "      Reversible: yes")?;
+        }
+        Ok(())
+    }
+
+    fn end_side_effects(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_state_transitions(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nState Transitions ({count}):")
+    }
+
+    fn state_transition(
+        &mut self,
+        w: &mut dyn Write,
+        trans: &StateTransitionSpec,
+    ) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "  {} : {} -> {}",
+            trans.object, trans.from_state, trans.to_state
+        )?;
+        if let Some(condition) = &trans.condition {
+            writeln!(w, "      Condition: {condition}")?;
+        }
+        if !trans.description.is_empty() {
+            writeln!(w, "      {}", trans.description)?;
+        }
+        Ok(())
+    }
+
+    fn end_state_transitions(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    // Constraints and locks
+    fn begin_constraints(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nAdditional Constraints ({count}):")
+    }
+
+    fn constraint(
+        &mut self,
+        w: &mut dyn Write,
+        constraint: &ConstraintSpec,
+    ) -> std::io::Result<()> {
+        writeln!(w, "  {}", constraint.name)?;
+        if !constraint.description.is_empty() {
+            writeln!(w, "      {}", constraint.description)?;
+        }
+        if let Some(expr) = &constraint.expression {
+            writeln!(w, "      Expression: {expr}")?;
+        }
+        Ok(())
+    }
+
+    fn end_constraints(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_locks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nLocking Requirements ({count}):")
+    }
+
+    fn lock(&mut self, w: &mut dyn Write, lock: &LockSpec) -> std::io::Result<()> {
+        write!(w, "  {}", lock.lock_name)?;
+
+        // Display lock type
+        let lock_type = match lock.lock_type {
+            0 => "NONE",
+            1 => "MUTEX",
+            2 => "SPINLOCK",
+            3 => "RWLOCK",
+            4 => "SEQLOCK",
+            5 => "RCU",
+            6 => "SEMAPHORE",
+            7 => "CUSTOM",
+            _ => "UNKNOWN",
+        };
+        writeln!(w, " ({lock_type})")?;
+
+        let scope_str = match lock.scope {
+            0 => "acquired and released",
+            1 => "acquired (not released)",
+            2 => "released (held on entry)",
+            3 => "held by caller",
+            _ => "unknown",
+        };
+        writeln!(w, "      Scope: {scope_str}")?;
+
+        if !lock.description.is_empty() {
+            writeln!(w, "      {}", lock.description)?;
+        }
+        Ok(())
+    }
+
+    fn end_locks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_struct_specs(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nStructure Specifications ({count}):")
+    }
+
+    fn struct_spec(
+        &mut self,
+        w: &mut dyn Write,
+        spec: &crate::extractor::StructSpec,
+    ) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "  {} (size={}, align={}):",
+            spec.name, spec.size, spec.alignment
+        )?;
+        if !spec.description.is_empty() {
+            writeln!(w, "      {}", spec.description)?;
+        }
+
+        if !spec.fields.is_empty() {
+            writeln!(w, "      Fields ({}):", spec.field_count)?;
+            for field in &spec.fields {
+                write!(w, "        - {} ({}):", field.name, field.type_name)?;
+                if !field.description.is_empty() {
+                    write!(w, " {}", field.description)?;
+                }
+                writeln!(w)?;
+
+                // Show constraints if present
+                if field.min_value != 0 || field.max_value != 0 {
+                    writeln!(
+                        w,
+                        "          Range: [{}, {}]",
+                        field.min_value, field.max_value
+                    )?;
+                }
+                if field.valid_mask != 0 {
+                    writeln!(w, "          Mask: {:#x}", field.valid_mask)?;
+                }
+            }
+        }
+        Ok(())
+    }
+
+    fn end_struct_specs(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+    use crate::extractor::{ErrorSpec, ParamSpec, ReturnSpec};
+
+    fn render_plain(f: &mut PlainFormatter, sink: &mut Vec<u8>) -> String {
+        f.end_document(sink).unwrap();
+        String::from_utf8(sink.clone()).unwrap()
+    }
+
+    #[test]
+    fn plain_api_list() {
+        let mut f = PlainFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_list(&mut sink, "System Calls").unwrap();
+        f.api_item(&mut sink, "sys_open", "syscall").unwrap();
+        f.api_item(&mut sink, "sys_read", "syscall").unwrap();
+        f.end_api_list(&mut sink).unwrap();
+        f.total_specs(&mut sink, 2).unwrap();
+
+        let out = render_plain(&mut f, &mut sink);
+        assert!(out.contains("sys_open"));
+        assert!(out.contains("sys_read"));
+        assert!(out.contains("Total specifications found: 2"));
+    }
+
+    #[test]
+    fn plain_api_details() {
+        let mut f = PlainFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.description(&mut sink, "A test syscall").unwrap();
+        f.long_description(&mut sink, "Detailed description here")
+            .unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_plain(&mut f, &mut sink);
+        assert!(out.contains("sys_test"));
+        assert!(out.contains("A test syscall"));
+        assert!(out.contains("Detailed description here"));
+    }
+
+    #[test]
+    fn plain_parameters() {
+        let mut f = PlainFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_write").unwrap();
+        f.begin_parameters(&mut sink, 1).unwrap();
+        f.parameter(
+            &mut sink,
+            &ParamSpec {
+                index: 0,
+                name: "fd".to_string(),
+                type_name: "unsigned int".to_string(),
+                description: "file descriptor".to_string(),
+                flags: 1,
+                param_type: 2,
+                constraint_type: 0,
+                constraint: None,
+                min_value: None,
+                max_value: None,
+                valid_mask: None,
+                enum_values: vec![],
+                size: None,
+                alignment: None,
+                size_param_idx: None,
+            },
+        )
+        .unwrap();
+        f.end_parameters(&mut sink).unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_plain(&mut f, &mut sink);
+        assert!(out.contains("fd"));
+        assert!(out.contains("unsigned int"));
+        assert!(out.contains("file descriptor"));
+    }
+
+    #[test]
+    fn plain_errors() {
+        let mut f = PlainFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.begin_errors(&mut sink, 1).unwrap();
+        f.error(
+            &mut sink,
+            &ErrorSpec {
+                error_code: -2,
+                name: "ENOENT".to_string(),
+                condition: "File not found".to_string(),
+                description: "The file does not exist".to_string(),
+            },
+        )
+        .unwrap();
+        f.end_errors(&mut sink).unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_plain(&mut f, &mut sink);
+        assert!(out.contains("ENOENT"));
+        assert!(out.contains("-2"));
+        assert!(out.contains("File not found"));
+    }
+
+    #[test]
+    fn plain_return_spec() {
+        let mut f = PlainFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.return_spec(
+            &mut sink,
+            &ReturnSpec {
+                type_name: "KAPI_TYPE_INT".to_string(),
+                description: "Returns 0 on success".to_string(),
+                return_type: 1,
+                check_type: 0,
+                success_value: Some(0),
+                success_min: None,
+                success_max: None,
+                error_values: vec![],
+            },
+        )
+        .unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_plain(&mut f, &mut sink);
+        assert!(out.contains("KAPI_TYPE_INT"));
+        assert!(out.contains("Returns 0 on success"));
+    }
+
+    #[test]
+    fn plain_context_flags() {
+        let mut f = PlainFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.begin_context_flags(&mut sink).unwrap();
+        f.context_flag(&mut sink, "KAPI_CTX_PROCESS").unwrap();
+        f.context_flag(&mut sink, "KAPI_CTX_SLEEPABLE").unwrap();
+        f.end_context_flags(&mut sink).unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_plain(&mut f, &mut sink);
+        assert!(out.contains("KAPI_CTX_PROCESS"));
+        assert!(out.contains("KAPI_CTX_SLEEPABLE"));
+    }
+}
diff --git a/tools/kapi/src/formatter/rst.rs b/tools/kapi/src/formatter/rst.rs
new file mode 100644
index 0000000000000..c4db74c9ad410
--- /dev/null
+++ b/tools/kapi/src/formatter/rst.rs
@@ -0,0 +1,726 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+use super::OutputFormatter;
+use crate::extractor::{
+    CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec, ReturnSpec, SideEffectSpec,
+    SignalMaskSpec, SignalSpec, StateTransitionSpec,
+};
+use std::io::Write;
+
+pub struct RstFormatter;
+
+impl RstFormatter {
+    pub fn new() -> Self {
+        RstFormatter
+    }
+
+    fn section_char(level: usize) -> char {
+        match level {
+            0 => '=',
+            1 => '-',
+            2 => '~',
+            3 => '^',
+            _ => '"',
+        }
+    }
+}
+
+impl OutputFormatter for RstFormatter {
+    fn begin_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_api_list(&mut self, w: &mut dyn Write, title: &str) -> std::io::Result<()> {
+        writeln!(w, "\n{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(0).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn api_item(&mut self, w: &mut dyn Write, name: &str, api_type: &str) -> std::io::Result<()> {
+        writeln!(w, "* **{name}** (*{api_type}*)")
+    }
+
+    fn end_api_list(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn total_specs(&mut self, w: &mut dyn Write, count: usize) -> std::io::Result<()> {
+        writeln!(w, "\n**Total specifications found:** {count}")
+    }
+
+    fn begin_api_details(&mut self, w: &mut dyn Write, name: &str) -> std::io::Result<()> {
+        writeln!(w, "\n{name}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(0).to_string().repeat(name.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "**{desc}**")?;
+        writeln!(w)
+    }
+
+    fn long_description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "{desc}")?;
+        writeln!(w)
+    }
+
+    fn begin_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        let title = "Execution Context";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn context_flag(&mut self, w: &mut dyn Write, flag: &str) -> std::io::Result<()> {
+        writeln!(w, "* {flag}")
+    }
+
+    fn end_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w)
+    }
+
+    fn begin_parameters(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        let title = format!("Parameters ({count})");
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn end_parameters(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_errors(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        let title = format!("Possible Errors ({count})");
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn end_errors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn examples(&mut self, w: &mut dyn Write, examples: &str) -> std::io::Result<()> {
+        let title = "Examples";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)?;
+        writeln!(w, ".. code-block:: c")?;
+        writeln!(w)?;
+        for line in examples.lines() {
+            writeln!(w, "   {line}")?;
+        }
+        writeln!(w)
+    }
+
+    fn notes(&mut self, w: &mut dyn Write, notes: &str) -> std::io::Result<()> {
+        let title = "Notes";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)?;
+        writeln!(w, "{notes}")?;
+        writeln!(w)
+    }
+
+    fn sysfs_subsystem(&mut self, w: &mut dyn Write, subsystem: &str) -> std::io::Result<()> {
+        writeln!(w, ":Subsystem: {subsystem}")?;
+        writeln!(w)
+    }
+
+    fn sysfs_path(&mut self, w: &mut dyn Write, path: &str) -> std::io::Result<()> {
+        writeln!(w, ":Sysfs Path: {path}")?;
+        writeln!(w)
+    }
+
+    fn sysfs_permissions(&mut self, w: &mut dyn Write, perms: &str) -> std::io::Result<()> {
+        writeln!(w, ":Permissions: {perms}")?;
+        writeln!(w)
+    }
+
+    fn begin_capabilities(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        let title = "Required Capabilities";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn capability(&mut self, w: &mut dyn Write, cap: &CapabilitySpec) -> std::io::Result<()> {
+        writeln!(w, "**{} ({})** - {}", cap.name, cap.capability, cap.action)?;
+        writeln!(w)?;
+        if !cap.allows.is_empty() {
+            writeln!(w, "* **Allows:** {}", cap.allows)?;
+        }
+        if !cap.without_cap.is_empty() {
+            writeln!(w, "* **Without capability:** {}", cap.without_cap)?;
+        }
+        if let Some(cond) = &cap.check_condition {
+            writeln!(w, "* **Condition:** {}", cond)?;
+        }
+        writeln!(w)
+    }
+
+    fn end_capabilities(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn parameter(&mut self, w: &mut dyn Write, param: &ParamSpec) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "**[{}] {}** (*{}*)",
+            param.index, param.name, param.type_name
+        )?;
+        writeln!(w)?;
+        writeln!(w, "  {}", param.description)?;
+
+        // Display flags
+        let mut flags = Vec::new();
+        if param.flags & 0x01 != 0 {
+            flags.push("IN");
+        }
+        if param.flags & 0x02 != 0 {
+            flags.push("OUT");
+        }
+        if param.flags & 0x04 != 0 {
+            flags.push("USER");
+        }
+        if param.flags & 0x08 != 0 {
+            flags.push("OPTIONAL");
+        }
+        if !flags.is_empty() {
+            writeln!(w, "  :Flags: {}", flags.join(", "))?;
+        }
+
+        if let Some(constraint) = &param.constraint {
+            writeln!(w, "  :Constraint: {}", constraint)?;
+        }
+
+        if let (Some(min), Some(max)) = (param.min_value, param.max_value) {
+            writeln!(w, "  :Range: {} to {}", min, max)?;
+        }
+
+        writeln!(w)
+    }
+
+    fn return_spec(&mut self, w: &mut dyn Write, ret: &ReturnSpec) -> std::io::Result<()> {
+        writeln!(w, "\nReturn Value")?;
+        writeln!(w, "{}\n", Self::section_char(1).to_string().repeat(12))?;
+        writeln!(w)?;
+        writeln!(w, ":Type: {}", ret.type_name)?;
+        writeln!(w, ":Description: {}", ret.description)?;
+        if let Some(success) = ret.success_value {
+            writeln!(w, ":Success value: {}", success)?;
+        }
+        writeln!(w)
+    }
+
+    fn error(&mut self, w: &mut dyn Write, error: &ErrorSpec) -> std::io::Result<()> {
+        writeln!(w, "**{}** ({})", error.name, error.error_code)?;
+        writeln!(w)?;
+        writeln!(w, "  :Condition: {}", error.condition)?;
+        if !error.description.is_empty() {
+            writeln!(w, "  :Description: {}", error.description)?;
+        }
+        writeln!(w)
+    }
+
+    fn begin_signals(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        let title = format!("Signals ({count})");
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn signal(&mut self, w: &mut dyn Write, signal: &SignalSpec) -> std::io::Result<()> {
+        write!(w, "* **{}**", signal.signal_name)?;
+        if signal.signal_num != 0 {
+            write!(w, " ({})", signal.signal_num)?;
+        }
+        writeln!(w)?;
+
+        // Direction (bitmask matching C enum kapi_signal_direction)
+        let mut dirs = Vec::new();
+        if signal.direction & 1 != 0 {
+            dirs.push("receive");
+        }
+        if signal.direction & 2 != 0 {
+            dirs.push("send");
+        }
+        if signal.direction & 4 != 0 {
+            dirs.push("handle");
+        }
+        if signal.direction & 8 != 0 {
+            dirs.push("block");
+        }
+        if signal.direction & 16 != 0 {
+            dirs.push("ignore");
+        }
+        let direction = if dirs.is_empty() {
+            "unknown".to_string()
+        } else {
+            dirs.join(", ")
+        };
+        writeln!(w, "  :Direction: {}", direction)?;
+
+        // Action (matching C enum kapi_signal_action)
+        let action = match signal.action {
+            0 => "default",
+            1 => "terminate",
+            2 => "coredump",
+            3 => "stop",
+            4 => "continue",
+            5 => "custom",
+            6 => "return",
+            7 => "restart",
+            8 => "queue",
+            9 => "discard",
+            10 => "transform",
+            _ => "unknown",
+        };
+        writeln!(w, "  :Action: {}", action)?;
+
+        if let Some(target) = &signal.target {
+            writeln!(w, "  :Target: {}", target)?;
+        }
+        if let Some(cond) = &signal.condition {
+            writeln!(w, "  :Condition: {}", cond)?;
+        }
+        if let Some(desc) = &signal.description {
+            writeln!(w, "  :Description: {}", desc)?;
+        }
+        let timing = match signal.timing {
+            0 => "before",
+            1 => "during",
+            2 => "after",
+            3 => "exit",
+            _ => "",
+        };
+        if !timing.is_empty() {
+            writeln!(w, "  :Timing: {}", timing)?;
+        }
+        if signal.priority != 0 {
+            writeln!(w, "  :Priority: {}", signal.priority)?;
+        }
+        if signal.interruptible {
+            writeln!(w, "  :Interruptible: yes")?;
+        }
+        if signal.restartable {
+            writeln!(w, "  :Restartable: yes")?;
+        }
+        if let Some(queue) = &signal.queue {
+            writeln!(w, "  :Queue: {}", queue)?;
+        }
+        if signal.sa_flags_required != 0 {
+            writeln!(w, "  :SA flags required: {:#x}", signal.sa_flags_required)?;
+        }
+        if signal.sa_flags_forbidden != 0 {
+            writeln!(w, "  :SA flags forbidden: {:#x}", signal.sa_flags_forbidden)?;
+        }
+        if signal.state_required != 0 {
+            writeln!(w, "  :State required: {:#x}", signal.state_required)?;
+        }
+        if signal.state_forbidden != 0 {
+            writeln!(w, "  :State forbidden: {:#x}", signal.state_forbidden)?;
+        }
+        if let Some(error) = signal.error_on_signal {
+            writeln!(w, "  :Error on signal: {}", error)?;
+        }
+        if let Some(transform) = signal.transform_to {
+            writeln!(w, "  :Transform to: {}", transform)?;
+        }
+        writeln!(w)
+    }
+
+    fn end_signals(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_signal_masks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        let title = format!("Signal Masks ({count})");
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn signal_mask(&mut self, w: &mut dyn Write, mask: &SignalMaskSpec) -> std::io::Result<()> {
+        writeln!(w, "* **{}**", mask.name)?;
+        if !mask.description.is_empty() {
+            writeln!(w, "  {}", mask.description)?;
+        }
+        writeln!(w)
+    }
+
+    fn end_signal_masks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_side_effects(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        let title = format!("Side Effects ({count})");
+        writeln!(w, "{}\n", title)?;
+        writeln!(
+            w,
+            "{}\n",
+            Self::section_char(1).to_string().repeat(title.len())
+        )
+    }
+
+    fn side_effect(&mut self, w: &mut dyn Write, effect: &SideEffectSpec) -> std::io::Result<()> {
+        write!(w, "* **{}**", effect.target)?;
+        if effect.reversible {
+            write!(w, " *(reversible)*")?;
+        }
+        writeln!(w)?;
+        writeln!(w, "  {}", effect.description)?;
+        if let Some(cond) = &effect.condition {
+            writeln!(w, "  :Condition: {}", cond)?;
+        }
+        writeln!(w)
+    }
+
+    fn end_side_effects(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_state_transitions(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        let title = format!("State Transitions ({count})");
+        writeln!(w, "{}\n", title)?;
+        writeln!(
+            w,
+            "{}\n",
+            Self::section_char(1).to_string().repeat(title.len())
+        )
+    }
+
+    fn state_transition(
+        &mut self,
+        w: &mut dyn Write,
+        trans: &StateTransitionSpec,
+    ) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "* **{}**: {} → {}",
+            trans.object, trans.from_state, trans.to_state
+        )?;
+        writeln!(w, "  {}", trans.description)?;
+        if let Some(cond) = &trans.condition {
+            writeln!(w, "  :Condition: {}", cond)?;
+        }
+        writeln!(w)
+    }
+
+    fn end_state_transitions(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_constraints(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        let title = format!("Constraints ({count})");
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn constraint(
+        &mut self,
+        w: &mut dyn Write,
+        constraint: &ConstraintSpec,
+    ) -> std::io::Result<()> {
+        writeln!(w, "* **{}**", constraint.name)?;
+        if !constraint.description.is_empty() {
+            writeln!(w, "  {}", constraint.description)?;
+        }
+        if let Some(expr) = &constraint.expression {
+            writeln!(w, "  :Expression: ``{}``", expr)?;
+        }
+        writeln!(w)
+    }
+
+    fn end_constraints(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_locks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        let title = format!("Locks ({count})");
+        writeln!(w, "{}\n", title)?;
+        writeln!(
+            w,
+            "{}\n",
+            Self::section_char(1).to_string().repeat(title.len())
+        )
+    }
+
+    fn lock(&mut self, w: &mut dyn Write, lock: &LockSpec) -> std::io::Result<()> {
+        write!(w, "* **{}**", lock.lock_name)?;
+        let lock_type_str = match lock.lock_type {
+            1 => " *(mutex)*",
+            2 => " *(spinlock)*",
+            3 => " *(rwlock)*",
+            4 => " *(semaphore)*",
+            5 => " *(RCU)*",
+            _ => "",
+        };
+        writeln!(w, "{}", lock_type_str)?;
+        if !lock.description.is_empty() {
+            writeln!(w, "  {}", lock.description)?;
+        }
+        writeln!(w)
+    }
+
+    fn end_locks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_struct_specs(&mut self, w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        writeln!(w)?;
+        writeln!(w, "Structure Specifications")?;
+        writeln!(w, "~~~~~~~~~~~~~~~~~~~~~~~")?;
+        writeln!(w)
+    }
+
+    fn struct_spec(
+        &mut self,
+        w: &mut dyn Write,
+        spec: &crate::extractor::StructSpec,
+    ) -> std::io::Result<()> {
+        writeln!(w, "**{}**", spec.name)?;
+        writeln!(w)?;
+
+        if !spec.description.is_empty() {
+            writeln!(w, "  {}", spec.description)?;
+            writeln!(w)?;
+        }
+
+        writeln!(w, "  :Size: {} bytes", spec.size)?;
+        writeln!(w, "  :Alignment: {} bytes", spec.alignment)?;
+        writeln!(w, "  :Fields: {}", spec.field_count)?;
+        writeln!(w)?;
+
+        if !spec.fields.is_empty() {
+            for field in &spec.fields {
+                writeln!(w, "  * **{}** ({})", field.name, field.type_name)?;
+                if !field.description.is_empty() {
+                    writeln!(w, "    {}", field.description)?;
+                }
+                if field.min_value != 0 || field.max_value != 0 {
+                    writeln!(w, "    Range: [{}, {}]", field.min_value, field.max_value)?;
+                }
+            }
+            writeln!(w)?;
+        }
+
+        Ok(())
+    }
+
+    fn end_struct_specs(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+    use crate::extractor::{ErrorSpec, ParamSpec, ReturnSpec};
+
+    fn render_rst(f: &mut RstFormatter, sink: &mut Vec<u8>) -> String {
+        f.end_document(sink).unwrap();
+        String::from_utf8(sink.clone()).unwrap()
+    }
+
+    #[test]
+    fn rst_api_details_has_heading() {
+        let mut f = RstFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.description(&mut sink, "A test syscall").unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_rst(&mut f, &mut sink);
+        assert!(out.contains("sys_test"));
+        assert!(out.contains("========"));
+        assert!(out.contains("**A test syscall**"));
+    }
+
+    #[test]
+    fn rst_api_list() {
+        let mut f = RstFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_list(&mut sink, "System Calls").unwrap();
+        f.api_item(&mut sink, "sys_open", "syscall").unwrap();
+        f.api_item(&mut sink, "sys_read", "syscall").unwrap();
+        f.end_api_list(&mut sink).unwrap();
+        f.total_specs(&mut sink, 2).unwrap();
+
+        let out = render_rst(&mut f, &mut sink);
+        assert!(out.contains("sys_open"));
+        assert!(out.contains("sys_read"));
+    }
+
+    #[test]
+    fn rst_parameters() {
+        let mut f = RstFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_write").unwrap();
+        f.begin_parameters(&mut sink, 1).unwrap();
+        f.parameter(
+            &mut sink,
+            &ParamSpec {
+                index: 0,
+                name: "fd".to_string(),
+                type_name: "unsigned int".to_string(),
+                description: "file descriptor".to_string(),
+                flags: 1,
+                param_type: 2,
+                constraint_type: 0,
+                constraint: None,
+                min_value: None,
+                max_value: None,
+                valid_mask: None,
+                enum_values: vec![],
+                size: None,
+                alignment: None,
+                size_param_idx: None,
+            },
+        )
+        .unwrap();
+        f.end_parameters(&mut sink).unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_rst(&mut f, &mut sink);
+        assert!(out.contains("**[0] fd**"));
+        assert!(out.contains("unsigned int"));
+        assert!(out.contains("file descriptor"));
+    }
+
+    #[test]
+    fn rst_errors() {
+        let mut f = RstFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.begin_errors(&mut sink, 1).unwrap();
+        f.error(
+            &mut sink,
+            &ErrorSpec {
+                error_code: -2,
+                name: "ENOENT".to_string(),
+                condition: "File not found".to_string(),
+                description: "The file does not exist".to_string(),
+            },
+        )
+        .unwrap();
+        f.end_errors(&mut sink).unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_rst(&mut f, &mut sink);
+        assert!(out.contains("**ENOENT**"));
+        assert!(out.contains("-2"));
+        assert!(out.contains("File not found"));
+    }
+
+    #[test]
+    fn rst_return_spec() {
+        let mut f = RstFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.return_spec(
+            &mut sink,
+            &ReturnSpec {
+                type_name: "KAPI_TYPE_INT".to_string(),
+                description: "Returns 0 on success".to_string(),
+                return_type: 1,
+                check_type: 0,
+                success_value: Some(0),
+                success_min: None,
+                success_max: None,
+                error_values: vec![],
+            },
+        )
+        .unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_rst(&mut f, &mut sink);
+        assert!(out.contains("KAPI_TYPE_INT"));
+        assert!(out.contains("Returns 0 on success"));
+        assert!(out.contains("Return Value"));
+    }
+
+    #[test]
+    fn rst_context_flags() {
+        let mut f = RstFormatter::new();
+        let mut sink = Vec::new();
+
+        f.begin_document(&mut sink).unwrap();
+        f.begin_api_details(&mut sink, "sys_test").unwrap();
+        f.begin_context_flags(&mut sink).unwrap();
+        f.context_flag(&mut sink, "KAPI_CTX_PROCESS").unwrap();
+        f.context_flag(&mut sink, "KAPI_CTX_SLEEPABLE").unwrap();
+        f.end_context_flags(&mut sink).unwrap();
+        f.end_api_details(&mut sink).unwrap();
+
+        let out = render_rst(&mut f, &mut sink);
+        assert!(out.contains("KAPI_CTX_PROCESS"));
+        assert!(out.contains("KAPI_CTX_SLEEPABLE"));
+        assert!(out.contains("Execution Context"));
+    }
+}
diff --git a/tools/kapi/src/main.rs b/tools/kapi/src/main.rs
new file mode 100644
index 0000000000000..29b76a42f26ab
--- /dev/null
+++ b/tools/kapi/src/main.rs
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Sasha Levin <sashal@kernel.org>
+
+//! kapi - Kernel API Specification Tool
+//!
+//! This tool extracts and displays kernel API specifications from multiple sources:
+//! - Kernel source code (KAPI macros)
+//! - Compiled vmlinux binaries (`.kapi_specs` ELF section)
+//! - Running kernel via debugfs
+
+use anyhow::Result;
+use clap::Parser;
+use std::io::{self, Write};
+
+mod extractor;
+mod formatter;
+
+use extractor::{ApiExtractor, DebugfsExtractor, SourceExtractor, VmlinuxExtractor};
+use formatter::{create_formatter, OutputFormat};
+
+#[derive(Parser, Debug)]
+#[command(author, version, about, long_about = None)]
+struct Args {
+    /// Path to the vmlinux file
+    #[arg(long, value_name = "PATH", group = "input")]
+    vmlinux: Option<String>,
+
+    /// Path to kernel source directory or file
+    #[arg(long, value_name = "PATH", group = "input")]
+    source: Option<String>,
+
+    /// Path to debugfs (defaults to /sys/kernel/debug if not specified)
+    #[arg(long, value_name = "PATH", group = "input")]
+    debugfs: Option<String>,
+
+    /// Optional: Name of specific API to show details for
+    api_name: Option<String>,
+
+    /// Output format
+    #[arg(long, short = 'f', default_value = "plain")]
+    format: String,
+}
+
+fn main() -> Result<()> {
+    let args = Args::parse();
+
+    let output_format: OutputFormat = args
+        .format
+        .parse()
+        .map_err(|e: String| anyhow::anyhow!(e))?;
+
+    let extractor: Box<dyn ApiExtractor> = match (&args.vmlinux, &args.source, &args.debugfs) {
+        (Some(vmlinux_path), None, None) => Box::new(VmlinuxExtractor::new(vmlinux_path)?),
+        (None, Some(source_path), None) => Box::new(SourceExtractor::new(source_path)?),
+        (None, None, Some(_) | None) => {
+            // If debugfs is specified or no input is provided, use debugfs
+            Box::new(DebugfsExtractor::new(args.debugfs.clone())?)
+        }
+        _ => {
+            anyhow::bail!("Please specify only one of --vmlinux, --source, or --debugfs")
+        }
+    };
+
+    display_apis(extractor.as_ref(), args.api_name, output_format)
+}
+
+fn display_apis(
+    extractor: &dyn ApiExtractor,
+    api_name: Option<String>,
+    output_format: OutputFormat,
+) -> Result<()> {
+    let mut formatter = create_formatter(output_format);
+    let mut stdout = io::stdout();
+
+    formatter.begin_document(&mut stdout)?;
+
+    if let Some(api_name_req) = api_name {
+        // Use the extractor to display API details
+        if let Some(_spec) = extractor.extract_by_name(&api_name_req)? {
+            extractor.display_api_details(&api_name_req, &mut *formatter, &mut stdout)?;
+        } else {
+            eprintln!("API '{}' not found.", api_name_req);
+            if output_format == OutputFormat::Plain {
+                writeln!(stdout, "\nAvailable APIs:")?;
+                for spec in extractor.extract_all()? {
+                    writeln!(stdout, "  {} ({})", spec.name, spec.api_type)?;
+                }
+            }
+            std::process::exit(1);
+        }
+    } else {
+        // Display list of APIs using the extractor
+        let all_specs = extractor.extract_all()?;
+
+        // Helper to display API list for a specific type
+        let mut display_api_type = |api_type: &str, title: &str| -> Result<()> {
+            let filtered: Vec<_> = all_specs
+                .iter()
+                .filter(|s| s.api_type == api_type)
+                .collect();
+
+            if !filtered.is_empty() {
+                formatter.begin_api_list(&mut stdout, title)?;
+                for spec in filtered {
+                    formatter.api_item(&mut stdout, &spec.name, &spec.api_type)?;
+                }
+                formatter.end_api_list(&mut stdout)?;
+            }
+            Ok(())
+        };
+
+        display_api_type("syscall", "System Calls")?;
+        display_api_type("ioctl", "IOCTLs")?;
+        display_api_type("function", "Functions")?;
+        display_api_type("sysfs", "Sysfs Attributes")?;
+
+        formatter.total_specs(&mut stdout, all_specs.len())?;
+    }
+
+    formatter.end_document(&mut stdout)?;
+
+    Ok(())
+}
-- 
2.53.0


