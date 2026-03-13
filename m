Return-Path: <linux-api+bounces-5947-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDhmBFEqtGkQiQAAu9opvQ
	(envelope-from <linux-api+bounces-5947-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:16:33 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E35285BE4
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9364C3095CD5
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D03B2FD7;
	Fri, 13 Mar 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/zEIL5n"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EE3ACA72;
	Fri, 13 Mar 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414600; cv=none; b=X7M+yNkRknhlUUsLlu0w/s2ulVQAPsAlU8Epv2ZvyyvX1tjLC5JLWTz4KHSzxwfMAkmUQZAqtn2PUSV0/BP85rCwYoQXmtNMgZaEgOfktPActFjpK+ChPpSw+2fTG5u2vk1WwSXo74ia41wWdg0Yi6pHWIT4WAcChYdEOTxTsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414600; c=relaxed/simple;
	bh=SZy63dGHWX3CIq7Wryi9g3JQJTFs0AZ5cvb+bJGMIlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZblraKq4v7tk2Negyo0jMiPP1w8FoTHHxnqPqoKrqTVTbR3QHYqrIbEc90V2XklK0n5tbAL+BPTaegNeqCytma7zIk7rkng/LgkrVh0/U00tKmQqcC4ioD68ljkXXVWXZFEaWsttrZrCNh5TZvVgE/6uomCwoq181DbxanpkhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/zEIL5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2674C19421;
	Fri, 13 Mar 2026 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773414599;
	bh=SZy63dGHWX3CIq7Wryi9g3JQJTFs0AZ5cvb+bJGMIlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/zEIL5nPXyp9bZy3lHnoSLhewAUsuuYL5bKsggZRe8+oLbbw3ER+H6c4a8ItFxmj
	 NR/m6J1F5uOqamfIyEbmH2PbwlM1LTv8Uo7sr7XjiP+0pJtZxcvfX8hxveYB18IJEE
	 YOUN1o4Sl3PZ2nDCXeAzb2nUEdUxcfKIgbq3xBJTNUW+n6LxXy3dcOUQVEBXdhsT3H
	 U1C4Y/KJh1+dv9KVWeH0DB152W+ezjN66ZWUbZdfsjcPDqblKYsXAY14NJpjBZlXK4
	 sdz2undhfqKmslEem4pT8ErXfQJtQUa0/ZBS8mKYIXtHDVi3lsA01+hefP+HAF1GFE
	 HgEvsMsBgXZUg==
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
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: [PATCH 4/9] tools/kapi: Add kernel API specification extraction tool
Date: Fri, 13 Mar 2026 11:09:14 -0400
Message-ID: <20260313150928.2637368-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313150928.2637368-1-sashal@kernel.org>
References: <20260313150928.2637368-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5947-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,effect.target:url,f.name:url,p.name:url,constraint.name:url,family.family:url]
X-Rspamd-Queue-Id: 78E35285BE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The kapi tool extracts and displays kernel API specifications.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/dev-tools/kernel-api-spec.rst   |  195 ++-
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.toml                         |   19 +
 tools/kapi/src/extractor/debugfs.rs           |  581 ++++++
 tools/kapi/src/extractor/kerneldoc_parser.rs  | 1554 +++++++++++++++++
 tools/kapi/src/extractor/mod.rs               |  463 +++++
 tools/kapi/src/extractor/source_parser.rs     |  405 +++++
 .../src/extractor/vmlinux/binary_utils.rs     |  505 ++++++
 .../src/extractor/vmlinux/magic_finder.rs     |  112 ++
 tools/kapi/src/extractor/vmlinux/mod.rs       |  842 +++++++++
 tools/kapi/src/formatter/json.rs              |  727 ++++++++
 tools/kapi/src/formatter/mod.rs               |  140 ++
 tools/kapi/src/formatter/plain.rs             |  708 ++++++++
 tools/kapi/src/formatter/rst.rs               |  852 +++++++++
 tools/kapi/src/main.rs                        |  119 ++
 15 files changed, 7215 insertions(+), 11 deletions(-)
 create mode 100644 tools/kapi/.gitignore
 create mode 100644 tools/kapi/Cargo.toml
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
index 6ec6e65a1902a..9103ba1d580cf 100644
--- a/Documentation/dev-tools/kernel-api-spec.rst
+++ b/Documentation/dev-tools/kernel-api-spec.rst
@@ -31,7 +31,9 @@ The framework aims to:
    common programming errors during development and testing.
 
 3. **Support Tooling**: Export API specifications in machine-readable formats for
-   use by static analyzers, documentation generators, and development tools.
+   use by static analyzers, documentation generators, and development tools. The
+   ``kapi`` tool (see `The kapi Tool`_) provides comprehensive extraction and
+   formatting capabilities.
 
 4. **Enhance Debugging**: Provide detailed API information at runtime through debugfs
    for debugging and introspection.
@@ -65,6 +67,13 @@ The framework consists of several key components:
    - Type-safe parameter specifications
    - Context and constraint definitions
 
+5. **kapi Tool** (``tools/kapi/``)
+
+   - Userspace utility for extracting specifications
+   - Multiple input sources (source, binary, debugfs)
+   - Multiple output formats (plain, JSON, RST)
+   - Testing and validation utilities
+
 Data Model
 ----------
 
@@ -289,8 +298,177 @@ Documentation Generation
 ------------------------
 
 The framework exports specifications via debugfs that can be used
-to generate documentation. Tools for automatic documentation generation
-from specifications are planned for future development.
+to generate documentation. The ``kapi`` tool provides comprehensive
+extraction and formatting capabilities for kernel API specifications.
+
+The kapi Tool
+=============
+
+Overview
+--------
+
+The ``kapi`` tool is a userspace utility that extracts and displays kernel API
+specifications from multiple sources. It provides a unified interface to access
+API documentation whether from compiled kernels, source code, or runtime systems.
+
+Installation
+------------
+
+Build the tool from the kernel source tree::
+
+    $ cd tools/kapi
+    $ cargo build --release
+
+    # Optional: Install system-wide
+    $ cargo install --path .
+
+The tool requires Rust and Cargo to build. The binary will be available at
+``tools/kapi/target/release/kapi``.
+
+Command-Line Usage
+------------------
+
+Basic syntax::
+
+    kapi [OPTIONS] [API_NAME]
+
+Options:
+
+- ``--vmlinux <PATH>``: Extract from compiled kernel binary
+- ``--source <PATH>``: Extract from kernel source code
+- ``--debugfs <PATH>``: Extract from debugfs (default: /sys/kernel/debug)
+- ``-f, --format <FORMAT>``: Output format (plain, json, rst)
+- ``-h, --help``: Display help information
+- ``-V, --version``: Display version information
+
+Input Modes
+-----------
+
+**1. Source Code Mode**
+
+Extract specifications directly from kernel source::
+
+    # Scan entire kernel source tree
+    $ kapi --source /path/to/linux
+
+    # Extract from specific file
+    $ kapi --source kernel/sched/core.c
+
+    # Get details for specific API
+    $ kapi --source /path/to/linux sys_sched_yield
+
+**2. Vmlinux Mode**
+
+Extract from compiled kernel with debug symbols::
+
+    # List all APIs in vmlinux
+    $ kapi --vmlinux /boot/vmlinux-5.15.0
+
+    # Get specific syscall details
+    $ kapi --vmlinux ./vmlinux sys_read
+
+**3. Debugfs Mode**
+
+Extract from running kernel via debugfs::
+
+    # Use default debugfs path
+    $ kapi
+
+    # Use custom debugfs mount
+    $ kapi --debugfs /mnt/debugfs
+
+    # Get specific API from running kernel
+    $ kapi sys_write
+
+Output Formats
+--------------
+
+**Plain Text Format** (default)::
+
+    $ kapi sys_read
+
+    Detailed information for sys_read:
+    ==================================
+    Description: Read from a file descriptor
+
+    Detailed Description:
+    Reads up to count bytes from file descriptor fd into the buffer starting at buf.
+
+    Execution Context:
+      - KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+
+    Parameters (3):
+
+    Available since: 1.0
+
+**JSON Format**::
+
+    $ kapi --format json sys_read
+    {
+      "api_details": {
+        "name": "sys_read",
+        "description": "Read from a file descriptor",
+        "long_description": "Reads up to count bytes...",
+        "context_flags": ["KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE"],
+        "since_version": "1.0"
+      }
+    }
+
+**ReStructuredText Format**::
+
+    $ kapi --format rst sys_read
+
+    sys_read
+    ========
+
+    **Read from a file descriptor**
+
+    Reads up to count bytes from file descriptor fd into the buffer...
+
+Usage Examples
+--------------
+
+**Generate complete API documentation**::
+
+    # Export all kernel APIs to JSON
+    $ kapi --source /path/to/linux --format json > kernel-apis.json
+
+    # Generate RST documentation for all syscalls
+    $ kapi --vmlinux ./vmlinux --format rst > syscalls.rst
+
+    # List APIs from specific subsystem
+    $ kapi --source drivers/gpu/drm/
+
+**Integration with other tools**::
+
+    # Find all APIs that can sleep
+    $ kapi --format json | jq '.apis[] | select(.context_flags[] | contains("SLEEPABLE"))'
+
+    # Generate markdown documentation
+    $ kapi --format rst sys_mmap | pandoc -f rst -t markdown
+
+**Debugging and analysis**::
+
+    # Compare API between kernel versions
+    $ diff <(kapi --vmlinux vmlinux-5.10) <(kapi --vmlinux vmlinux-5.15)
+
+    # Check if specific API exists
+    $ kapi --source . my_custom_api || echo "API not found"
+
+Implementation Details
+----------------------
+
+The tool extracts API specifications from three sources:
+
+1. **Source Code**: Parses KAPI specification macros using regular expressions
+2. **Vmlinux**: Reads the ``.kapi_specs`` ELF section from compiled kernels
+3. **Debugfs**: Reads from ``/sys/kernel/debug/kapi/`` filesystem interface
+
+The tool supports all KAPI specification types:
+
+- System calls (``DEFINE_KERNEL_API_SPEC`` or kerneldoc annotations)
+- IOCTLs (kerneldoc annotations with ioctl-specific tags)
+- Kernel functions (kerneldoc annotations with KAPI tags)
 
 IDE Integration
 ---------------
@@ -302,15 +480,10 @@ Modern IDEs can use the JSON export for:
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
diff --git a/tools/kapi/Cargo.toml b/tools/kapi/Cargo.toml
new file mode 100644
index 0000000000000..7df8a159689f4
--- /dev/null
+++ b/tools/kapi/Cargo.toml
@@ -0,0 +1,19 @@
+[package]
+name = "kapi"
+version = "0.1.0"
+edition = "2021"
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
diff --git a/tools/kapi/src/extractor/debugfs.rs b/tools/kapi/src/extractor/debugfs.rs
new file mode 100644
index 0000000000000..9a4f4c1599b78
--- /dev/null
+++ b/tools/kapi/src/extractor/debugfs.rs
@@ -0,0 +1,581 @@
+use crate::formatter::OutputFormatter;
+use anyhow::{Context, Result, bail};
+use serde::Deserialize;
+use std::fs;
+use std::io::Write;
+use std::path::PathBuf;
+
+use super::{ApiExtractor, ApiSpec, CapabilitySpec, ErrorSpec, LockSpec, ParamSpec, ReturnSpec, display_api_spec};
+
+#[derive(Deserialize)]
+struct KernelApiJson {
+    name: String,
+    api_type: Option<String>,
+    version: Option<u32>,
+    description: Option<String>,
+    long_description: Option<String>,
+    context_flags: Option<u32>,
+    since_version: Option<String>,
+    examples: Option<String>,
+    notes: Option<String>,
+    capabilities: Option<Vec<KernelCapabilityJson>>,
+    #[serde(default)]
+    parameters: Option<Vec<KernelParamJson>>,
+    #[serde(default)]
+    errors: Option<Vec<KernelErrorJson>>,
+    #[serde(default)]
+    return_spec: Option<KernelReturnJson>,
+    #[serde(default)]
+    locks: Option<Vec<KernelLockJson>>,
+}
+
+#[derive(Deserialize)]
+struct KernelParamJson {
+    name: String,
+    #[serde(rename = "type")]
+    type_name: Option<String>,
+    description: Option<String>,
+    #[serde(default)]
+    flags: u32,
+    #[serde(default)]
+    param_type: u32,
+}
+
+#[derive(Deserialize)]
+struct KernelErrorJson {
+    error_code: i32,
+    name: Option<String>,
+    condition: Option<String>,
+    description: Option<String>,
+}
+
+#[derive(Deserialize)]
+struct KernelReturnJson {
+    #[serde(rename = "type")]
+    type_name: Option<String>,
+    description: Option<String>,
+    #[serde(default)]
+    return_type: u32,
+    #[serde(default)]
+    check_type: u32,
+    success_value: Option<i64>,
+}
+
+#[derive(Deserialize)]
+struct KernelLockJson {
+    name: String,
+    #[serde(default)]
+    lock_type: u32,
+    #[serde(default)]
+    scope: u32,
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
+    /// Try to parse JSON content, convert context flags from u32 to string representations
+    fn parse_context_flags(flags: u32) -> Vec<String> {
+        let mut result = Vec::new();
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
+            api_type: json_data.api_type.unwrap_or_else(|| "unknown".to_string()),
+            description: json_data.description,
+            long_description: json_data.long_description,
+            version: json_data.version.map(|v| v.to_string()),
+            context_flags: json_data
+                .context_flags
+                .map_or_else(Vec::new, Self::parse_context_flags),
+            param_count: None,
+            error_count: None,
+            examples: json_data.examples,
+            notes: json_data.notes,
+            since_version: json_data.since_version,
+            subsystem: None,   // Not in current JSON format
+            sysfs_path: None,  // Not in current JSON format
+            permissions: None, // Not in current JSON format
+            socket_state: None,
+            protocol_behaviors: vec![],
+            addr_families: vec![],
+            buffer_spec: None,
+            async_spec: None,
+            net_data_transfer: None,
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
+        // Convert parameters
+        if let Some(params) = json_data.parameters {
+            for (i, p) in params.into_iter().enumerate() {
+                spec.parameters.push(ParamSpec {
+                    index: i as u32,
+                    name: p.name,
+                    type_name: p.type_name.unwrap_or_default(),
+                    description: p.description.unwrap_or_default(),
+                    flags: p.flags,
+                    param_type: p.param_type,
+                    constraint_type: 0,
+                    constraint: None,
+                    min_value: None,
+                    max_value: None,
+                    valid_mask: None,
+                    enum_values: vec![],
+                    size: None,
+                    alignment: None,
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
+            spec.return_spec = Some(ReturnSpec {
+                type_name: ret.type_name.unwrap_or_default(),
+                description: ret.description.unwrap_or_default(),
+                return_type: ret.return_type,
+                check_type: ret.check_type,
+                success_value: ret.success_value,
+                success_min: None,
+                success_max: None,
+                error_values: vec![],
+            });
+        }
+
+        // Convert locks
+        if let Some(locks) = json_data.locks {
+            for l in locks {
+                spec.locks.push(LockSpec {
+                    lock_name: l.name,
+                    lock_type: l.lock_type,
+                    scope: l.scope,
+                    description: l.description.unwrap_or_default(),
+                });
+            }
+        }
+
+        Some(spec)
+    }
+
+    /// Parse a single API specification file
+    fn parse_spec_file(&self, api_name: &str) -> Result<ApiSpec> {
+        let spec_path = self.debugfs_path.join(format!("kapi/specs/{}", api_name));
+        let content = fs::read_to_string(&spec_path)
+            .with_context(|| format!("Failed to read {}", spec_path.display()))?;
+
+        // Try JSON parsing first
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
+            since_version: None,
+            subsystem: None,
+            sysfs_path: None,
+            permissions: None,
+            socket_state: None,
+            protocol_behaviors: vec![],
+            addr_families: vec![],
+            buffer_spec: None,
+            async_spec: None,
+            net_data_transfer: None,
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
+        let mut current_capability: Option<CapabilitySpec> = None;
+
+        for line in content.lines() {
+            // Handle capability sections
+            if line.starts_with("Capabilities (") {
+                continue; // Skip the header
+            }
+            if line.starts_with("  ") && line.contains(" (") && line.ends_with("):") {
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
+                    || line.starts_with("Since: ")
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
+            } else if let Some(since) = line.strip_prefix("Since: ") {
+                spec.since_version = Some(since.to_string());
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
index 0000000000000..767e4b2bf26b9
--- /dev/null
+++ b/tools/kapi/src/extractor/kerneldoc_parser.rs
@@ -0,0 +1,1554 @@
+use super::{
+    ApiSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec,
+    ReturnSpec, SideEffectSpec, SignalSpec, StateTransitionSpec, StructSpec,
+    StructFieldSpec,
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
+    Param(String),     // param: <name>
+    Error(String),     // error: <name>
+    Signal,            // signal: <name>
+    Capability,        // capability: <name>
+    SideEffect,        // side-effect: <type>
+    StateTransition,   // state-trans: ...
+    Constraint,        // constraint: <name>
+    Lock,              // lock: <name>
+    Return,            // return:
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
+            // If indented and we're in a block, parse as block attribute
+            if is_indented && block != BlockContext::None {
+                self.parse_block_attribute(trimmed, &block, &mut param_map,
+                    &mut current_error, &mut current_signal,
+                    &mut current_capability, &mut current_side_effect,
+                    &mut current_constraint, &mut current_lock,
+                    &mut current_return);
+                i += 1;
+                continue;
+            }
+
+            // Not indented or not in block — flush current block if any
+            self.flush_block(&mut block, &mut spec, &mut current_error,
+                &mut current_signal, &mut current_capability,
+                &mut current_side_effect, &mut current_constraint,
+                &mut current_lock, &mut current_return);
+
+            // Parse top-level annotations
+            if let Some(rest) = trimmed.strip_prefix("@") {
+                // @param: description — standard kerneldoc parameter
+                if let Some((param_name, desc)) = rest.split_once(':') {
+                    let param_name = param_name.trim();
+                    let desc = desc.trim();
+                    if !param_name.contains('-') {
+                        let idx = param_map.len() as u32;
+                        let type_name = type_map.get(param_name)
+                            .cloned()
+                            .unwrap_or_default();
+                        param_map.insert(param_name.to_string(), ParamSpec {
+                            index: idx,
+                            name: param_name.to_string(),
+                            type_name,
+                            description: desc.to_string(),
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
+                        });
+                    }
+                }
+            } else if let Some(rest) = trimmed.strip_prefix("long-desc:") {
+                let (val, next_i) = self.collect_multiline_value(&lines, i, rest);
+                spec.long_description = Some(val);
+                i = next_i;
+                continue;
+            } else if let Some(rest) = trimmed.strip_prefix("context-flags:") {
+                spec.context_flags = self.parse_context_flags(rest.trim());
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
+                    let type_name = type_map.get(param_name.as_str())
+                        .cloned()
+                        .unwrap_or_default();
+                    param_map.insert(param_name.clone(), ParamSpec {
+                        index: idx,
+                        name: param_name,
+                        type_name,
+                        description: String::new(),
+                        flags: 0,
+                        param_type: 0,
+                        constraint_type: 0,
+                        constraint: None,
+                        min_value: None,
+                        max_value: None,
+                        valid_mask: None,
+                        enum_values: vec![],
+                        size: None,
+                        alignment: None,
+                    });
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
+                    if let Some(constraint) = spec.constraints.iter_mut().find(|c| c.name == parts[0]) {
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
+            } else if let Some(rest) = trimmed.strip_prefix("since-version:") {
+                spec.since_version = Some(rest.trim().to_string());
+            }
+
+            i += 1;
+        }
+
+        // Flush any remaining block
+        self.flush_block(&mut block, &mut spec, &mut current_error,
+            &mut current_signal, &mut current_capability,
+            &mut current_side_effect, &mut current_constraint,
+            &mut current_lock, &mut current_return);
+
+        // Convert param_map to vec preserving order
+        let mut params: Vec<ParamSpec> = param_map.into_values().collect();
+        params.sort_by_key(|p| p.index);
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
+    fn parse_block_attribute(
+        &self,
+        trimmed: &str,
+        block: &BlockContext,
+        param_map: &mut HashMap<String, ParamSpec>,
+        current_error: &mut Option<ErrorSpec>,
+        current_signal: &mut Option<SignalSpec>,
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
+                        param.param_type = self.parse_param_type(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("flags:") {
+                        param.flags = self.parse_param_flags(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("constraint-type:") {
+                        param.constraint_type = self.parse_constraint_type(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("valid-mask:") {
+                        // Don't try to parse symbolic mask values — leave for binary
+                        let _ = rest; // valid-mask parsing needs constant resolution
+                    } else if let Some(rest) = trimmed.strip_prefix("constraint:") {
+                        // May be multiline — append
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
+                    } else if let Some(rest) = trimmed.strip_prefix("desc:") {
+                        param.description = rest.trim().to_string();
+                    } else if !trimmed.contains(':') || trimmed.starts_with("  ") {
+                        // Continuation of previous attribute (e.g., multiline constraint)
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
+                    } else if let Some(rest) = trimmed.strip_prefix("error:") {
+                        let code_str = rest.trim().trim_start_matches('-');
+                        if let Ok(code) = code_str.parse::<i32>() {
+                            signal.error_on_signal = Some(code);
+                        } else {
+                            signal.error_on_signal = Some(self.error_name_to_code(rest.trim().trim_start_matches('-')));
+                        }
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
+                        cap.action = rest.trim().to_string();
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
+                    } else if trimmed.starts_with("acquired:") || trimmed.starts_with("released:") {
+                        // Ignored — handled via scope
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
+                        ret.type_name = rest.trim().to_string();
+                        ret.return_type = self.parse_param_type(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("check-type:") {
+                        ret.check_type = self.parse_return_check_type(rest.trim());
+                    } else if let Some(rest) = trimmed.strip_prefix("success:") {
+                        // Parse success value — could be "= 0", ">= 0", etc.
+                        let val = rest.trim().trim_start_matches(|c: char| !c.is_ascii_digit() && c != '-');
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
+    fn collect_multiline_value(&self, lines: &[&str], start_idx: usize, first_part: &str) -> (String, usize) {
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
+            "param:", "param-", "error:", "error-", "lock:", "lock-",
+            "signal:", "signal-", "side-effect:", "state-trans:",
+            "capability:", "capability-", "constraint:", "constraint-",
+            "struct-", "return:", "return-", "examples:", "notes:",
+            "since-", "context-", "long-desc:", "api-type:",
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
+    fn parse_context_flags(&self, flags: &str) -> Vec<String> {
+        flags.split('|')
+            .map(|f| f.trim().to_string())
+            .filter(|f| !f.is_empty())
+            .collect()
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
+    fn parse_param_type(&self, type_str: &str) -> u32 {
+        match type_str {
+            "KAPI_TYPE_INT" => 1,
+            "KAPI_TYPE_UINT" => 2,
+            "KAPI_TYPE_LONG" => 3,
+            "KAPI_TYPE_ULONG" => 4,
+            "KAPI_TYPE_STRING" => 5,
+            "KAPI_TYPE_USER_PTR" => 6,
+            "KAPI_TYPE_PATH" => 5, // PATH is a string type
+            _ => 0,
+        }
+    }
+
+    fn parse_constraint_type(&self, type_str: &str) -> u32 {
+        match type_str {
+            "KAPI_CONSTRAINT_RANGE" => 1,
+            "KAPI_CONSTRAINT_MASK" => 2,
+            "KAPI_CONSTRAINT_ENUM" => 3,
+            "KAPI_CONSTRAINT_ALIGN" => 4,
+            "KAPI_CONSTRAINT_CUSTOM" => 5,
+            "KAPI_CONSTRAINT_STRLEN" => 6,
+            "KAPI_CONSTRAINT_NULLABLE" => 7,
+            "KAPI_CONSTRAINT_FD" => 8,
+            "KAPI_CONSTRAINT_USER_PATH" => 9,
+            "KAPI_CONSTRAINT_PID" => 10,
+            "KAPI_CONSTRAINT_BUFFER" => 11,
+            "KAPI_CONSTRAINT_IOCTL_CMD" => 12,
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
+        let mut result = 0;
+        for flag in flags.split('|') {
+            match flag.trim() {
+                "KAPI_PARAM_IN" | "IN" => result |= 1,
+                "KAPI_PARAM_OUT" | "OUT" => result |= 2,
+                "KAPI_PARAM_INOUT" | "INOUT" => result |= 3,
+                "KAPI_PARAM_USER" | "USER" => result |= 64,
+                _ => {}
+            }
+        }
+        result
+    }
+
+    fn parse_lock_type(&self, type_str: &str) -> u32 {
+        match type_str.trim() {
+            "KAPI_LOCK_SPINLOCK" => 0,
+            "KAPI_LOCK_MUTEX" => 1,
+            "KAPI_LOCK_RWLOCK" => 2,
+            "KAPI_LOCK_RCU" => 3,
+            _ => 3,
+        }
+    }
+
+    fn parse_signal_direction(&self, dir: &str) -> u32 {
+        match dir {
+            "KAPI_SIGNAL_RECEIVE" => 1,
+            "KAPI_SIGNAL_SEND" => 2,
+            "KAPI_SIGNAL_HANDLE" => 4,
+            "KAPI_SIGNAL_BLOCK" => 8,
+            "KAPI_SIGNAL_IGNORE" => 16,
+            _ => 0,
+        }
+    }
+
+    fn parse_signal_action(&self, action: &str) -> u32 {
+        match action {
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
+            _ => 0,
+        }
+    }
+
+    fn parse_signal_timing(&self, timing: &str) -> u32 {
+        match timing {
+            "KAPI_SIGNAL_TIME_BEFORE" => 0,
+            "KAPI_SIGNAL_TIME_DURING" => 1,
+            "KAPI_SIGNAL_TIME_AFTER" => 2,
+            _ => 0,
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
+    fn parse_effect_type(&self, type_str: &str) -> u32 {
+        let mut result = 0;
+        for flag in type_str.split('|') {
+            match flag.trim() {
+                "KAPI_EFFECT_MODIFY_STATE" => result |= 1,
+                "KAPI_EFFECT_PROCESS_STATE" => result |= 2,
+                "KAPI_EFFECT_SCHEDULE" => result |= 4,
+                "KAPI_EFFECT_ALLOC_MEMORY" => result |= 128,
+                "KAPI_EFFECT_RESOURCE_CREATE" => result |= 1,
+                "KAPI_EFFECT_FILESYSTEM" => result |= 4096,
+                _ => {}
+            }
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
+    fn parse_return_check_type(&self, check: &str) -> u32 {
+        match check {
+            "KAPI_RETURN_ERROR_CHECK" => 1,
+            "KAPI_RETURN_SUCCESS_CHECK" => 2,
+            "KAPI_RETURN_FD" => 3,
+            _ => 0,
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
+param-type: fd, KAPI_TYPE_INT
+param-type: buf, KAPI_TYPE_USER_PTR
+param-type: count, KAPI_TYPE_UINT
+param-type: flags, KAPI_TYPE_ULONG
+";
+        let sig = "(bar, int, fd, char __user *, buf, size_t, count, unsigned long, flags)";
+        let spec = parser()
+            .parse_kerneldoc(doc, "sys_bar", "syscall", Some(sig))
+            .unwrap();
+
+        assert_eq!(spec.parameters.len(), 4);
+
+        let fd_param = spec.parameters.iter().find(|p| p.name == "fd").unwrap();
+        assert_eq!(fd_param.param_type, 1); // INT
+
+        let buf_param = spec.parameters.iter().find(|p| p.name == "buf").unwrap();
+        assert_eq!(buf_param.param_type, 6); // USER_PTR
+        assert_eq!(buf_param.type_name, "char __user * buf");
+
+        let count_param = spec.parameters.iter().find(|p| p.name == "count").unwrap();
+        assert_eq!(count_param.param_type, 2); // UINT
+
+        let flags_param = spec.parameters.iter().find(|p| p.name == "flags").unwrap();
+        assert_eq!(flags_param.param_type, 4); // ULONG
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
+        assert_eq!(sig.action, 1);    // TERMINATE
+        assert_eq!(sig.timing, 1);    // DURING
+        assert_eq!(sig.priority, 3);
+        assert!(sig.restartable);
+        assert!(sig.interruptible);
+        assert_eq!(sig.description.as_deref(), Some("Process termination signal"));
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
+        assert_eq!(se.effect_type, 1); // MODIFY_STATE
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
+        assert_eq!(se.effect_type, 128); // ALLOC_MEMORY
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
+        assert_eq!(p.flags, 1);      // IN
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
+        assert_eq!(ret.check_type, 3);  // FD
+        assert_eq!(ret.success_value, Some(0));
+        assert_eq!(ret.description, "Returns file descriptor on success");
+    }
+}
diff --git a/tools/kapi/src/extractor/mod.rs b/tools/kapi/src/extractor/mod.rs
new file mode 100644
index 0000000000000..336e8c0a29cb3
--- /dev/null
+++ b/tools/kapi/src/extractor/mod.rs
@@ -0,0 +1,463 @@
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
+/// Socket state specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct SocketStateSpec {
+    pub required_states: Vec<String>,
+    pub forbidden_states: Vec<String>,
+    pub resulting_state: Option<String>,
+    pub condition: Option<String>,
+    pub applicable_protocols: Option<String>,
+}
+
+/// Protocol behavior specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct ProtocolBehaviorSpec {
+    pub applicable_protocols: String,
+    pub behavior: String,
+    pub protocol_flags: Option<String>,
+    pub flag_description: Option<String>,
+}
+
+/// Address family specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct AddrFamilySpec {
+    pub family: i32,
+    pub family_name: String,
+    pub addr_struct_size: usize,
+    pub min_addr_len: usize,
+    pub max_addr_len: usize,
+    pub addr_format: Option<String>,
+    pub supports_wildcard: bool,
+    pub supports_multicast: bool,
+    pub supports_broadcast: bool,
+    pub special_addresses: Option<String>,
+    pub port_range_min: u32,
+    pub port_range_max: u32,
+}
+
+/// Buffer specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct BufferSpec {
+    pub buffer_behaviors: Option<String>,
+    pub min_buffer_size: Option<usize>,
+    pub max_buffer_size: Option<usize>,
+    pub optimal_buffer_size: Option<usize>,
+}
+
+/// Async specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct AsyncSpec {
+    pub supported_modes: Option<String>,
+    pub nonblock_errno: Option<i32>,
+}
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
+    pub since_version: Option<String>,
+    // Sysfs-specific fields
+    pub subsystem: Option<String>,
+    pub sysfs_path: Option<String>,
+    pub permissions: Option<String>,
+    // Networking-specific fields
+    pub socket_state: Option<SocketStateSpec>,
+    pub protocol_behaviors: Vec<ProtocolBehaviorSpec>,
+    pub addr_families: Vec<AddrFamilySpec>,
+    pub buffer_spec: Option<BufferSpec>,
+    pub async_spec: Option<AsyncSpec>,
+    pub net_data_transfer: Option<String>,
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
+    if let Some(version) = &spec.since_version {
+        formatter.since_version(writer, version)?;
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
+    // Display networking-specific fields
+    if let Some(socket_state) = &spec.socket_state {
+        formatter.socket_state(writer, socket_state)?;
+    }
+
+    if !spec.protocol_behaviors.is_empty() {
+        formatter.begin_protocol_behaviors(writer)?;
+        for behavior in &spec.protocol_behaviors {
+            formatter.protocol_behavior(writer, behavior)?;
+        }
+        formatter.end_protocol_behaviors(writer)?;
+    }
+
+    if !spec.addr_families.is_empty() {
+        formatter.begin_addr_families(writer)?;
+        for family in &spec.addr_families {
+            formatter.addr_family(writer, family)?;
+        }
+        formatter.end_addr_families(writer)?;
+    }
+
+    if let Some(buffer_spec) = &spec.buffer_spec {
+        formatter.buffer_spec(writer, buffer_spec)?;
+    }
+
+    if let Some(async_spec) = &spec.async_spec {
+        formatter.async_spec(writer, async_spec)?;
+    }
+
+    if let Some(net_data_transfer) = &spec.net_data_transfer {
+        formatter.net_data_transfer(writer, net_data_transfer)?;
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
+        formatter.begin_struct_specs(writer, spec.struct_specs.len().try_into().unwrap_or(u32::MAX))?;
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
index 0000000000000..4d92d69e3ef28
--- /dev/null
+++ b/tools/kapi/src/extractor/source_parser.rs
@@ -0,0 +1,405 @@
+use super::{
+    ApiExtractor, ApiSpec, display_api_spec,
+};
+use super::kerneldoc_parser::KerneldocParserImpl;
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
+            function_regex: Regex::new(
+                r"(?m)^(?:static\s+)?(?:inline\s+)?(?:(?:unsigned\s+)?(?:long|int|void|char|short|struct\s+\w+\s*\*?|[\w_]+_t)\s*\*?\s+)?(\w+)\s*\([^)]*\)",
+            )?,
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
+                    if current_doc.contains("context-flags:") ||
+                       current_doc.contains("param-count:") ||
+                       current_doc.contains("side-effect:") ||
+                       current_doc.contains("state-trans:") ||
+                       current_doc.contains("error-code:") {
+
+                        // Look ahead for the function declaration
+                        if let Some((name, api_type, signature)) = self.find_function_after(&lines, i + 1) {
+                            if let Ok(spec) = self.parser.parse_kerneldoc(&current_doc, &name, &api_type, Some(&signature)) {
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
+    fn find_function_after(&self, lines: &[&str], start: usize) -> Option<(String, String, String)> {
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
+                    paren_count = line[pos..].chars().filter(|&c| c == '(').count() -
+                                  line[pos..].chars().filter(|&c| c == ')').count();
+                }
+            } else if in_paren {
+                sig.push(' ');
+                sig.push_str(line.trim());
+                paren_count += line.chars().filter(|&c| c == '(').count();
+                paren_count = paren_count.saturating_sub(line.chars().filter(|&c| c == ')').count());
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
+                .filter(|e| e.path().extension().is_some_and(|ext| ext == "c" || ext == "h"))
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
+        let lines = vec![
+            "",
+            "",
+            "SYSCALL_DEFINE2(foo, int, bar, int, baz)",
+            "{",
+        ];
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
+        let lines = vec![
+            "#include <linux/fs.h>",
+            "#define FOO 1",
+            "/* comment */",
+        ];
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
+        let lines = vec![
+            "",
+            "int do_something(struct task_struct *task)",
+            "{",
+        ];
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
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/vmlinux/binary_utils.rs b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
new file mode 100644
index 0000000000000..95610eedce546
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
@@ -0,0 +1,505 @@
+// Constants for all structure field sizes
+pub mod sizes {
+    pub const NAME: usize = 128;
+    pub const DESC: usize = 512;
+    pub const MAX_PARAMS: usize = 16;
+    pub const MAX_ERRORS: usize = 32;
+    pub const MAX_CONSTRAINTS: usize = 32;
+    pub const MAX_CAPABILITIES: usize = 8;
+    pub const MAX_SIGNALS: usize = 32;
+    pub const MAX_STRUCT_SPECS: usize = 8;
+    pub const MAX_SIDE_EFFECTS: usize = 32;
+    pub const MAX_STATE_TRANS: usize = 8;
+    pub const MAX_PROTOCOL_BEHAVIORS: usize = 8;
+    pub const MAX_ADDR_FAMILIES: usize = 8;
+}
+
+/// Endianness of the target ELF binary
+#[derive(Clone, Copy, PartialEq)]
+pub enum Endian {
+    Little,
+    Big,
+}
+
+// Helper for reading data at specific offsets
+pub struct DataReader<'a> {
+    pub data: &'a [u8],
+    pub pos: usize,
+    pub endian: Endian,
+    /// true for 64-bit ELF, false for 32-bit
+    pub is_64bit: bool,
+}
+
+impl<'a> DataReader<'a> {
+    pub fn new(data: &'a [u8], offset: usize, endian: Endian, is_64bit: bool) -> Self {
+        Self {
+            data,
+            pos: offset,
+            endian,
+            is_64bit,
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
+    pub fn read_cstring(&mut self, max_len: usize) -> Option<String> {
+        let bytes = self.read_bytes(max_len)?;
+        if let Some(null_pos) = bytes.iter().position(|&b| b == 0) {
+            if null_pos > 0 {
+                if let Ok(s) = std::str::from_utf8(&bytes[..null_pos]) {
+                    return Some(s.to_string());
+                }
+            }
+        }
+        None
+    }
+
+    pub fn read_u32(&mut self) -> Option<u32> {
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
+        let b: [u8; 4] = self.read_bytes(4)?.try_into().unwrap();
+        Some(match self.endian {
+            Endian::Little => i32::from_le_bytes(b),
+            Endian::Big => i32::from_be_bytes(b),
+        })
+    }
+
+    pub fn read_u64(&mut self) -> Option<u64> {
+        let b: [u8; 8] = self.read_bytes(8)?.try_into().unwrap();
+        Some(match self.endian {
+            Endian::Little => u64::from_le_bytes(b),
+            Endian::Big => u64::from_be_bytes(b),
+        })
+    }
+
+    pub fn read_i64(&mut self) -> Option<i64> {
+        let b: [u8; 8] = self.read_bytes(8)?.try_into().unwrap();
+        Some(match self.endian {
+            Endian::Little => i64::from_le_bytes(b),
+            Endian::Big => i64::from_be_bytes(b),
+        })
+    }
+
+    /// Read a target-sized unsigned value (4 bytes for 32-bit, 8 bytes for 64-bit)
+    pub fn read_usize(&mut self) -> Option<usize> {
+        if self.is_64bit {
+            self.read_u64().map(|v| v as usize)
+        } else {
+            self.read_u32().map(|v| v as usize)
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
+    pub fn read_optional_string(&mut self, max_len: usize) -> Option<String> {
+        self.read_cstring(max_len).filter(|s| !s.is_empty())
+    }
+
+    pub fn read_string_or_default(&mut self, max_len: usize) -> String {
+        self.read_cstring(max_len).unwrap_or_default()
+    }
+
+    // Skip and discard - advances position by reading and discarding
+    pub fn discard_cstring(&mut self, max_len: usize) {
+        let _ = self.read_cstring(max_len);
+    }
+
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
+pub fn socket_state_spec_layout_size() -> usize {
+    // struct kapi_socket_state_spec
+    sizes::NAME * sizes::MAX_CONSTRAINTS + // required_states array
+    sizes::NAME * sizes::MAX_CONSTRAINTS + // forbidden_states array
+    sizes::NAME + // resulting_state
+    sizes::DESC + // condition
+    sizes::NAME + // applicable_protocols
+    4 + // required_count
+    4 // forbidden_count
+}
+
+pub fn protocol_behavior_spec_layout_size() -> usize {
+    // struct kapi_protocol_behavior
+    sizes::NAME + // applicable_protocols
+    sizes::DESC + // behavior
+    sizes::NAME + // protocol_flags
+    sizes::DESC // flag_description
+}
+
+pub fn buffer_spec_layout_size() -> usize {
+    // struct kapi_buffer_spec
+    sizes::DESC + // buffer_behaviors
+    8 + // min_buffer_size (size_t)
+    8 + // max_buffer_size (size_t)
+    8 // optimal_buffer_size (size_t)
+}
+
+pub fn async_spec_layout_size() -> usize {
+    // struct kapi_async_spec
+    sizes::NAME + // supported_modes
+    4 // nonblock_errno (int)
+}
+
+pub fn addr_family_spec_layout_size() -> usize {
+    // struct kapi_addr_family_spec
+    4 + // family (int)
+    sizes::NAME + // family_name
+    8 + // addr_struct_size (size_t)
+    8 + // min_addr_len (size_t)
+    8 + // max_addr_len (size_t)
+    sizes::DESC + // addr_format
+    1 + // supports_wildcard (bool)
+    1 + // supports_multicast (bool)
+    1 + // supports_broadcast (bool)
+    sizes::DESC + // special_addresses
+    4 + // port_range_min (u32)
+    4 // port_range_max (u32)
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
+    // ---- read_cstring tests ----
+
+    #[test]
+    fn read_cstring_nul_at_start() {
+        let data = [0u8, b'h', b'e', b'l', b'l', b'o'];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        // NUL at position 0 means null_pos == 0, so the function returns None
+        assert_eq!(reader.read_cstring(6), None);
+    }
+
+    #[test]
+    fn read_cstring_nul_in_middle() {
+        let data = [b'h', b'i', 0, b'x', b'y'];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_cstring(5), Some("hi".to_string()));
+    }
+
+    #[test]
+    fn read_cstring_nul_at_end() {
+        let data = [b'a', b'b', b'c', b'd', 0];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        assert_eq!(reader.read_cstring(5), Some("abcd".to_string()));
+    }
+
+    #[test]
+    fn read_cstring_no_nul_returns_none() {
+        let data = [b'x', b'y', b'z'];
+        let mut reader = DataReader::new(&data, 0, Endian::Little, true);
+        // No NUL terminator in the 3 bytes -> None
+        assert_eq!(reader.read_cstring(3), None);
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
+        let data = [0x00, 0x00, 0x78, 0x56, 0x34, 0x12];
+        let mut reader = DataReader::new(&data, 2, Endian::Little, true);
+        assert_eq!(reader.read_u32(), Some(0x12345678));
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
+    // ---- is_valid_api_name tests (from vmlinux/mod.rs) ----
+    // We test it via the super module since it's defined in vmlinux/mod.rs
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
+
+/// Tests for is_valid_api_name (defined in vmlinux/mod.rs, tested here
+/// since binary_utils is its sibling module)
+#[cfg(test)]
+mod api_name_tests {
+    use super::super::is_valid_api_name;
+
+    #[test]
+    fn valid_syscall_name() {
+        assert!(is_valid_api_name("sys_open"));
+        assert!(is_valid_api_name("sys_read"));
+        assert!(is_valid_api_name("sys_write"));
+    }
+
+    #[test]
+    fn valid_ioctl_name() {
+        assert!(is_valid_api_name("vfs_ioctl"));
+        assert!(is_valid_api_name("drm_ioctl"));
+    }
+
+    #[test]
+    fn valid_dunder_name() {
+        assert!(is_valid_api_name("__do_sys_open"));
+        assert!(is_valid_api_name("__x64_sys_read"));
+    }
+
+    #[test]
+    fn empty_name_is_invalid() {
+        assert!(!is_valid_api_name(""));
+    }
+
+    #[test]
+    fn too_short_name_is_invalid() {
+        assert!(!is_valid_api_name("ab")); // len < 3
+    }
+
+    #[test]
+    fn too_long_name_is_invalid() {
+        let long_name = "a".repeat(101);
+        assert!(!is_valid_api_name(&long_name));
+    }
+
+    #[test]
+    fn name_starting_with_digit_is_invalid() {
+        assert!(!is_valid_api_name("3func_test"));
+    }
+
+    #[test]
+    fn name_with_special_chars_is_invalid() {
+        assert!(!is_valid_api_name("sys-open")); // dash not allowed
+        assert!(!is_valid_api_name("sys.open")); // dot not allowed
+        assert!(!is_valid_api_name("sys open")); // space not allowed
+    }
+
+    #[test]
+    fn name_with_underscore_is_valid() {
+        assert!(is_valid_api_name("do_some_thing"));
+        assert!(is_valid_api_name("_internal_func"));
+    }
+
+    #[test]
+    fn long_name_without_underscore_is_valid_if_gt_6() {
+        // name.len() > 6 is the fallback condition
+        assert!(is_valid_api_name("longname")); // 8 chars, no underscore but len > 6
+    }
+
+    #[test]
+    fn short_name_without_pattern_may_be_invalid() {
+        // "abc" has len 3, no underscore, no prefix match, len <= 6
+        assert!(!is_valid_api_name("abc"));
+    }
+}
diff --git a/tools/kapi/src/extractor/vmlinux/magic_finder.rs b/tools/kapi/src/extractor/vmlinux/magic_finder.rs
new file mode 100644
index 0000000000000..8b660e99f6015
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/magic_finder.rs
@@ -0,0 +1,112 @@
+use super::binary_utils::Endian;
+
+// Magic markers for each section
+pub const MAGIC_PARAM: u32 = 0x4B415031;    // 'KAP1'
+pub const MAGIC_RETURN: u32 = 0x4B415232;   // 'KAR2'
+pub const MAGIC_ERROR: u32 = 0x4B414533;    // 'KAE3'
+pub const MAGIC_LOCK: u32 = 0x4B414C34;     // 'KAL4'
+pub const MAGIC_CONSTRAINT: u32 = 0x4B414335; // 'KAC5'
+pub const MAGIC_INFO: u32 = 0x4B414936;     // 'KAI6'
+pub const MAGIC_SIGNAL: u32 = 0x4B415337;   // 'KAS7'
+pub const MAGIC_SIGMASK: u32 = 0x4B414D38;  // 'KAM8'
+pub const MAGIC_STRUCT: u32 = 0x4B415439;   // 'KAT9'
+pub const MAGIC_EFFECT: u32 = 0x4B414641;   // 'KAFA'
+pub const MAGIC_TRANS: u32 = 0x4B415442;    // 'KATB'
+pub const MAGIC_CAP: u32 = 0x4B414343;      // 'KACC'
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
+                },
+                MAGIC_RETURN if offsets.return_offset.is_none() => {
+                    offsets.return_offset = Some(base_offset + i);
+                },
+                MAGIC_ERROR if offsets.error_offset.is_none() => {
+                    offsets.error_offset = Some(base_offset + i);
+                },
+                MAGIC_LOCK if offsets.lock_offset.is_none() => {
+                    offsets.lock_offset = Some(base_offset + i);
+                },
+                MAGIC_CONSTRAINT if offsets.constraint_offset.is_none() => {
+                    offsets.constraint_offset = Some(base_offset + i);
+                },
+                MAGIC_INFO if offsets.info_offset.is_none() => {
+                    offsets.info_offset = Some(base_offset + i);
+                },
+                MAGIC_SIGNAL if offsets.signal_offset.is_none() => {
+                    offsets.signal_offset = Some(base_offset + i);
+                },
+                MAGIC_SIGMASK if offsets.sigmask_offset.is_none() => {
+                    offsets.sigmask_offset = Some(base_offset + i);
+                },
+                MAGIC_STRUCT if offsets.struct_offset.is_none() => {
+                    offsets.struct_offset = Some(base_offset + i);
+                },
+                MAGIC_EFFECT if offsets.effect_offset.is_none() => {
+                    offsets.effect_offset = Some(base_offset + i);
+                },
+                MAGIC_TRANS if offsets.trans_offset.is_none() => {
+                    offsets.trans_offset = Some(base_offset + i);
+                },
+                MAGIC_CAP if offsets.cap_offset.is_none() => {
+                    offsets.cap_offset = Some(base_offset + i);
+                },
+                _ => {}
+            }
+
+            i += 1;
+        }
+
+        offsets
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/vmlinux/mod.rs b/tools/kapi/src/extractor/vmlinux/mod.rs
new file mode 100644
index 0000000000000..168f4efe23ec7
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/mod.rs
@@ -0,0 +1,842 @@
+use super::{
+    ApiExtractor, ApiSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec,
+    ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec, StateTransitionSpec, StructSpec,
+    StructFieldSpec,
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
+    DataReader, Endian, addr_family_spec_layout_size, async_spec_layout_size,
+    buffer_spec_layout_size, protocol_behavior_spec_layout_size, signal_mask_spec_layout_size,
+    sizes, socket_state_spec_layout_size, struct_field_layout_size,
+};
+
+// Helper to convert empty strings to None
+fn opt_string(s: String) -> Option<String> {
+    if s.is_empty() { None } else { Some(s) }
+}
+
+pub struct VmlinuxExtractor {
+    kapi_data: Vec<u8>,
+    specs: Vec<KapiSpec>,
+    endian: Endian,
+    is_64bit: bool,
+}
+
+#[derive(Debug)]
+struct KapiSpec {
+    name: String,
+    api_type: String,
+    offset: usize,
+}
+
+impl VmlinuxExtractor {
+    pub fn new(vmlinux_path: &str) -> Result<Self> {
+        let vmlinux_data = fs::read(vmlinux_path)
+            .with_context(|| format!("Failed to read vmlinux file: {vmlinux_path}"))?;
+
+        let elf = Elf::parse(&vmlinux_data).context("Failed to parse ELF file")?;
+
+        let endian = if elf.little_endian { Endian::Little } else { Endian::Big };
+        let is_64bit = elf.is_64;
+
+        // Find __start_kapi_specs and __stop_kapi_specs symbols first
+        let mut start_addr = None;
+        let mut stop_addr = None;
+
+        for sym in &elf.syms {
+            if let Some(name) = elf.strtab.get_at(sym.st_name) {
+                match name {
+                    "__start_kapi_specs" => start_addr = Some(sym.st_value),
+                    "__stop_kapi_specs" => stop_addr = Some(sym.st_value),
+                    _ => {}
+                }
+            }
+        }
+
+        let start = start_addr.context("Could not find __start_kapi_specs symbol")?;
+        let stop = stop_addr.context("Could not find __stop_kapi_specs symbol")?;
+
+        if stop <= start {
+            anyhow::bail!("No kernel API specifications found in vmlinux");
+        }
+
+        // Find the section containing the kapi specs data
+        // The specs may be in .kapi_specs (standalone) or .rodata (embedded in RO_DATA)
+        let containing_section = elf
+            .section_headers
+            .iter()
+            .find(|sh| {
+                // Check if this section contains the start address
+                start >= sh.sh_addr && start < sh.sh_addr + sh.sh_size
+            })
+            .context("Could not find section containing kapi_specs data")?;
+
+        // Calculate the offset within the file
+        let section_vaddr = containing_section.sh_addr;
+        let file_offset = containing_section.sh_offset + (start - section_vaddr);
+        let data_size: usize = (stop - start)
+            .try_into()
+            .context("Data size too large for platform")?;
+
+        let file_offset_usize: usize = file_offset
+            .try_into()
+            .context("File offset too large for platform")?;
+
+        if file_offset_usize + data_size > vmlinux_data.len() {
+            anyhow::bail!("Invalid offset/size for kapi_specs data");
+        }
+
+        // Extract the raw data
+        let kapi_data = vmlinux_data[file_offset_usize..(file_offset_usize + data_size)].to_vec();
+
+        // Parse the specifications
+        let specs = parse_kapi_specs(&kapi_data, endian)?;
+
+        Ok(VmlinuxExtractor { kapi_data, specs, endian, is_64bit })
+    }
+}
+
+fn parse_kapi_specs(data: &[u8], endian: Endian) -> Result<Vec<KapiSpec>> {
+    let mut specs = Vec::new();
+    let mut offset = 0;
+    let mut last_found_offset = None;
+
+    // Expected offset from struct start to param_magic based on struct layout
+    let param_magic_offset = sizes::NAME + 4 + sizes::DESC + (sizes::DESC * 4) + 4;
+
+    // Find specs by validating API name and magic marker pairs
+    while offset + param_magic_offset + 4 <= data.len() {
+        // Read potential API name
+        let name_bytes = &data[offset..offset + sizes::NAME.min(data.len() - offset)];
+
+        // Find null terminator
+        let name_len = name_bytes.iter().position(|&b| b == 0).unwrap_or(0);
+
+        if name_len > 0 && name_len < 100 {
+            let name = String::from_utf8_lossy(&name_bytes[..name_len]).to_string();
+
+            // Validate API name format
+            if is_valid_api_name(&name) {
+                // Verify magic marker at expected position
+                let magic_offset = offset + param_magic_offset;
+                if magic_offset + 4 <= data.len() {
+                    let magic_bytes = &data[magic_offset..magic_offset + 4];
+                    let magic_value = match endian {
+                        Endian::Little => u32::from_le_bytes([magic_bytes[0], magic_bytes[1], magic_bytes[2], magic_bytes[3]]),
+                        Endian::Big => u32::from_be_bytes([magic_bytes[0], magic_bytes[1], magic_bytes[2], magic_bytes[3]]),
+                    };
+
+                    if magic_value == magic_finder::MAGIC_PARAM {
+                        // Avoid duplicate detection of the same spec
+                        if last_found_offset.is_none() || offset >= last_found_offset.unwrap() + param_magic_offset {
+                            let api_type = if name.starts_with("sys_") {
+                                "syscall"
+                            } else if name.ends_with("_ioctl") {
+                                "ioctl"
+                            } else if name.contains("sysfs") {
+                                "sysfs"
+                            } else {
+                                "function"
+                            }
+                            .to_string();
+
+                            specs.push(KapiSpec {
+                                name: name.clone(),
+                                api_type,
+                                offset,
+                            });
+
+                            last_found_offset = Some(offset);
+                        }
+                    }
+                }
+            }
+        }
+
+        // Scan byte by byte to find all specs
+        offset += 1;
+    }
+
+    Ok(specs)
+}
+
+
+
+
+fn is_valid_api_name(name: &str) -> bool {
+    // Validate API name format and length
+    if name.is_empty() || name.len() < 3 || name.len() > 100 {
+        return false;
+    }
+
+    // Alphanumeric and underscore characters only
+    if !name.chars().all(|c| c.is_ascii_alphanumeric() || c == '_') {
+        return false;
+    }
+
+    // Must start with letter or underscore
+    let first_char = name.chars().next().unwrap();
+    if !first_char.is_ascii_alphabetic() && first_char != '_' {
+        return false;
+    }
+
+    // Match common kernel API patterns
+    name.starts_with("sys_") ||
+    name.starts_with("__") ||
+    name.ends_with("_ioctl") ||
+    name.contains("_") ||
+    name.len() > 6
+}
+
+impl ApiExtractor for VmlinuxExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        Ok(self
+            .specs
+            .iter()
+            .map(|spec| {
+                // Parse the full spec for listing
+                parse_binary_to_api_spec(&self.kapi_data, spec.offset, self.endian, self.is_64bit)
+                    .unwrap_or_else(|_| ApiSpec {
+                        name: spec.name.clone(),
+                        api_type: spec.api_type.clone(),
+                        ..Default::default()
+                    })
+            })
+            .collect())
+    }
+
+    fn extract_by_name(&self, api_name: &str) -> Result<Option<ApiSpec>> {
+        if let Some(spec) = self.specs.iter().find(|s| s.name == api_name) {
+            Ok(Some(parse_binary_to_api_spec(&self.kapi_data, spec.offset, self.endian, self.is_64bit)?))
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
+            let api_spec = parse_binary_to_api_spec(&self.kapi_data, spec.offset, self.endian, self.is_64bit)?;
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
+        // Parse items up to max_items
+        for i in 0..count.min(max_items) as usize {
+            if let Some(item) = parse_fn(reader, i) {
+                items.push(item);
+            }
+        }
+    }
+    items
+}
+
+fn parse_binary_to_api_spec(data: &[u8], offset: usize, endian: Endian, is_64bit: bool) -> Result<ApiSpec> {
+    let mut reader = DataReader::new(data, offset, endian, is_64bit);
+
+    // Search for magic markers in the entire spec data
+    let search_end = (offset + 0x70000).min(data.len()); // Search full spec size
+    let spec_data = &data[offset..search_end];
+
+    // Find magic markers relative to the spec start
+    let magic_offsets = magic_finder::MagicOffsets::find_in_data(spec_data, offset, endian);
+
+    // Read fields in exact order of struct kernel_api_spec
+
+    // Read name (128 bytes)
+    let name = reader
+        .read_cstring(sizes::NAME)
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
+    let description = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+
+    // Read long_description (2048 bytes)
+    let long_description = reader
+        .read_cstring(sizes::DESC * 4)
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
+        sizes::MAX_CONSTRAINTS as u32,
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
+        let examples = reader.read_cstring(sizes::DESC * 2).filter(|s| !s.is_empty());
+        let notes = reader.read_cstring(sizes::DESC * 2).filter(|s| !s.is_empty());
+        (examples, notes)
+    } else {
+        let examples = reader.read_cstring(sizes::DESC * 2).filter(|s| !s.is_empty());
+        let notes = reader.read_cstring(sizes::DESC * 2).filter(|s| !s.is_empty());
+        (examples, notes)
+    };
+
+    // Read since_version (32 bytes)
+    let since_version = reader.read_cstring(32).filter(|s| !s.is_empty());
+
+    // Skip deprecated (bool = 1 byte + 3 bytes padding) and replacement (128 bytes)
+    // These fields were removed from kernel but we need to skip them for binary compatibility
+    reader.skip(4); // deprecated + padding
+    reader.discard_cstring(sizes::NAME); // replacement
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
+    // Skip remaining network/socket fields
+    reader.skip(
+        socket_state_spec_layout_size() +
+        protocol_behavior_spec_layout_size() * sizes::MAX_PROTOCOL_BEHAVIORS +
+        4 + // protocol_behavior_count
+        buffer_spec_layout_size() +
+        async_spec_layout_size() +
+        addr_family_spec_layout_size() * sizes::MAX_ADDR_FAMILIES +
+        4 + // addr_family_count
+        6 + 2 + // 6 bool flags + padding
+        sizes::DESC * 3 // 3 semantic descriptions
+    );
+
+    Ok(ApiSpec {
+        name,
+        api_type,
+        description,
+        long_description,
+        version,
+        context_flags,
+        param_count: if parameters.is_empty() { None } else { Some(parameters.len() as u32) },
+        error_count: if errors.is_empty() { None } else { Some(errors.len() as u32) },
+        examples,
+        notes,
+        since_version,
+        subsystem: None,
+        sysfs_path: None,
+        permissions: None,
+        socket_state: None,
+        protocol_behaviors: vec![],
+        addr_families: vec![],
+        buffer_spec: None,
+        async_spec: None,
+        net_data_transfer: None,
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
+    let name = reader.read_cstring(sizes::NAME)?;
+    let type_name = reader.read_cstring(sizes::NAME)?;
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
+    let _size_param_idx = reader.read_i32()?; // Must use ? to propagate errors
+    let _size_multiplier = reader.read_usize()?; // Must use ? to propagate errors
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
+    // Skip is_success function pointer (8 bytes)
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
+    let name = reader.read_cstring(sizes::NAME)?;
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
+    let lock_name = reader.read_cstring(sizes::NAME)?;
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
+    let name = reader.read_cstring(sizes::NAME)?;
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
+    let signal_num = reader.read_i32()?;
+    let signal_name = reader.read_cstring(32)?; // signal_name[32]
+    let direction = reader.read_u32()?;
+    let action = reader.read_u32()?;
+    let target = reader.read_optional_string(sizes::DESC); // target[512]
+    let condition = reader.read_optional_string(sizes::DESC); // condition[512]
+    let description = reader.read_optional_string(sizes::DESC); // description[512]
+    let restartable = reader.read_bool()?;
+    let sa_flags_required = reader.read_u32()?;
+    let sa_flags_forbidden = reader.read_u32()?;
+    let error_on_signal = reader.read_i32()?;
+    let _transform_to = reader.read_i32()?; // transform_to
+    let timing_bytes = reader.read_bytes(32)?; // timing[32]
+    let timing = if let Some(end) = timing_bytes.iter().position(|&b| b == 0) {
+        String::from_utf8_lossy(&timing_bytes[..end]).parse().unwrap_or(0)
+    } else {
+        0
+    };
+    let priority = reader.read_u8()?;
+    let interruptible = reader.read_bool()?;
+    let _queue_behavior = reader.read_bytes(128)?; // queue_behavior[128]
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
+        queue: None, // queue_behavior not exposed in SignalSpec
+        sa_flags: 0, // Not directly available
+        sa_flags_required,
+        sa_flags_forbidden,
+        state_required,
+        state_forbidden,
+        error_on_signal: Some(error_on_signal),
+    })
+}
+
+fn parse_signal_mask(reader: &mut DataReader) -> Option<SignalMaskSpec> {
+    let name = reader.read_cstring(sizes::NAME)?;
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    // Skip signals array
+    for _ in 0..sizes::MAX_SIGNALS {
+        reader.read_i32();
+    }
+
+    let _signal_count = reader.read_u32()?;
+
+    Some(SignalMaskSpec {
+        name,
+        description,
+    })
+}
+
+fn parse_struct_field(reader: &mut DataReader) -> Option<StructFieldSpec> {
+    let name = reader.read_cstring(sizes::NAME)?;
+    let field_type = reader.read_u32()?;
+    let type_name = reader.read_cstring(sizes::NAME)?;
+    let offset = reader.read_usize()?;
+    let size = reader.read_usize()?;
+    let flags = reader.read_u32()?;
+    let constraint_type = reader.read_u32()?;
+    let min_value = reader.read_i64()?;
+    let max_value = reader.read_i64()?;
+    let valid_mask = reader.read_u64()?;
+    // Skip enum_values field (512 bytes)
+    let _enum_values = reader.read_cstring(sizes::DESC); // Don't fail on optional field
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
+    let name = reader.read_cstring(sizes::NAME)?;
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
+    let target = reader.read_cstring(sizes::NAME)?;
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
+    let from_state = reader.read_cstring(sizes::NAME)?;
+    let to_state = reader.read_cstring(sizes::NAME)?;
+    let condition = reader.read_string_or_default(sizes::DESC);
+    let object = reader.read_cstring(sizes::NAME)?;
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
+    let capability = reader.read_i32()?;
+    let cap_name = reader.read_cstring(sizes::NAME)?;
+    let action = reader.read_u32()?;
+    let allows = reader.read_string_or_default(sizes::DESC);
+    let without_cap = reader.read_string_or_default(sizes::DESC);
+    let check_condition = reader.read_optional_string(sizes::DESC);
+    let priority = reader.read_u32()?;
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
+    let _alternative_count = reader.read_u32()?; // alternative_count
+
+    Some(CapabilitySpec {
+        capability,
+        name: cap_name,
+        action: action.to_string(),
+        allows,
+        without_cap,
+        check_condition,
+        priority: Some(priority as u8),
+        alternatives,
+    })
+}
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/json.rs b/tools/kapi/src/formatter/json.rs
new file mode 100644
index 0000000000000..c281eed9ce593
--- /dev/null
+++ b/tools/kapi/src/formatter/json.rs
@@ -0,0 +1,727 @@
+use super::OutputFormatter;
+use crate::extractor::{
+    AddrFamilySpec, AsyncSpec, BufferSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec,
+    ParamSpec, ProtocolBehaviorSpec, ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec,
+    SocketStateSpec, StateTransitionSpec, StructSpec,
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
+    #[serde(skip_serializing_if = "Option::is_none")]
+    since_version: Option<String>,
+    // Sysfs-specific fields
+    #[serde(skip_serializing_if = "Option::is_none")]
+    subsystem: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    sysfs_path: Option<String>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    permissions: Option<String>,
+    // Networking-specific fields
+    #[serde(skip_serializing_if = "Option::is_none")]
+    socket_state: Option<SocketStateSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    protocol_behaviors: Vec<ProtocolBehaviorSpec>,
+    #[serde(skip_serializing_if = "Vec::is_empty")]
+    addr_families: Vec<AddrFamilySpec>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    buffer_spec: Option<BufferSpec>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    async_spec: Option<AsyncSpec>,
+    #[serde(skip_serializing_if = "Option::is_none")]
+    net_data_transfer: Option<String>,
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
+            since_version: None,
+            subsystem: None,
+            sysfs_path: None,
+            permissions: None,
+            socket_state: None,
+            protocol_behaviors: Vec::new(),
+            addr_families: Vec::new(),
+            buffer_spec: None,
+            async_spec: None,
+            net_data_transfer: None,
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
+    fn since_version(&mut self, _w: &mut dyn Write, version: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.since_version = Some(version.to_string());
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
+    // Networking-specific methods
+    fn socket_state(&mut self, _w: &mut dyn Write, state: &SocketStateSpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.socket_state = Some(state.clone());
+        }
+        Ok(())
+    }
+
+    fn begin_protocol_behaviors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn protocol_behavior(
+        &mut self,
+        _w: &mut dyn Write,
+        behavior: &ProtocolBehaviorSpec,
+    ) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.protocol_behaviors.push(behavior.clone());
+        }
+        Ok(())
+    }
+
+    fn end_protocol_behaviors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_addr_families(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn addr_family(&mut self, _w: &mut dyn Write, family: &AddrFamilySpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.addr_families.push(family.clone());
+        }
+        Ok(())
+    }
+
+    fn end_addr_families(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn buffer_spec(&mut self, _w: &mut dyn Write, spec: &BufferSpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.buffer_spec = Some(spec.clone());
+        }
+        Ok(())
+    }
+
+    fn async_spec(&mut self, _w: &mut dyn Write, spec: &AsyncSpec) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.async_spec = Some(spec.clone());
+        }
+        Ok(())
+    }
+
+    fn net_data_transfer(&mut self, _w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        if let Some(details) = &mut self.data.api_details {
+            details.net_data_transfer = Some(desc.to_string());
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
+        assert_eq!(
+            parsed["api_details"]["name"].as_str(),
+            Some("sys_test")
+        );
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
+        f.description(&mut sink, "Contains \"quotes\" and \\backslashes\\").unwrap();
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
+        assert_eq!(
+            parsed["apis"][0]["name"].as_str(),
+            Some("sys_new\tline")
+        );
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
+        f.description(&mut sink, "Supports unicode: \u{00e9}\u{00e8}\u{00ea}").unwrap();
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
index 0000000000000..3de8bf23bc29a
--- /dev/null
+++ b/tools/kapi/src/formatter/mod.rs
@@ -0,0 +1,140 @@
+use crate::extractor::{
+    AddrFamilySpec, AsyncSpec, BufferSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec,
+    ParamSpec, ProtocolBehaviorSpec, ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec,
+    SocketStateSpec, StateTransitionSpec, StructSpec,
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
+    fn since_version(&mut self, w: &mut dyn Write, version: &str) -> std::io::Result<()>;
+
+    // Sysfs-specific methods
+    fn sysfs_subsystem(&mut self, w: &mut dyn Write, subsystem: &str) -> std::io::Result<()>;
+    fn sysfs_path(&mut self, w: &mut dyn Write, path: &str) -> std::io::Result<()>;
+    fn sysfs_permissions(&mut self, w: &mut dyn Write, perms: &str) -> std::io::Result<()>;
+
+    // Networking-specific methods
+    fn socket_state(&mut self, w: &mut dyn Write, state: &SocketStateSpec) -> std::io::Result<()>;
+
+    fn begin_protocol_behaviors(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn protocol_behavior(
+        &mut self,
+        w: &mut dyn Write,
+        behavior: &ProtocolBehaviorSpec,
+    ) -> std::io::Result<()>;
+    fn end_protocol_behaviors(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_addr_families(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+    fn addr_family(&mut self, w: &mut dyn Write, family: &AddrFamilySpec) -> std::io::Result<()>;
+    fn end_addr_families(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn buffer_spec(&mut self, w: &mut dyn Write, spec: &BufferSpec) -> std::io::Result<()>;
+    fn async_spec(&mut self, w: &mut dyn Write, spec: &AsyncSpec) -> std::io::Result<()>;
+    fn net_data_transfer(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()>;
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
+    -> std::io::Result<()>;
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
index 0000000000000..09e054e323f5e
--- /dev/null
+++ b/tools/kapi/src/formatter/plain.rs
@@ -0,0 +1,708 @@
+use super::OutputFormatter;
+use crate::extractor::{
+    AddrFamilySpec, AsyncSpec, BufferSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec,
+    ParamSpec, ProtocolBehaviorSpec, ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec,
+    SocketStateSpec, StateTransitionSpec,
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
+    fn since_version(&mut self, w: &mut dyn Write, version: &str) -> std::io::Result<()> {
+        writeln!(w, "\nAvailable since: {version}")
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
+    // Networking-specific methods
+    fn socket_state(&mut self, w: &mut dyn Write, state: &SocketStateSpec) -> std::io::Result<()> {
+        writeln!(w, "\nSocket State Requirements:")?;
+        if !state.required_states.is_empty() {
+            writeln!(w, "  Required states: {:?}", state.required_states)?;
+        }
+        if !state.forbidden_states.is_empty() {
+            writeln!(w, "  Forbidden states: {:?}", state.forbidden_states)?;
+        }
+        if let Some(result) = &state.resulting_state {
+            writeln!(w, "  Resulting state: {result}")?;
+        }
+        if let Some(cond) = &state.condition {
+            writeln!(w, "  Condition: {cond}")?;
+        }
+        if let Some(protos) = &state.applicable_protocols {
+            writeln!(w, "  Applicable protocols: {protos}")?;
+        }
+        Ok(())
+    }
+
+    fn begin_protocol_behaviors(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nProtocol-Specific Behaviors:")
+    }
+
+    fn protocol_behavior(
+        &mut self,
+        w: &mut dyn Write,
+        behavior: &ProtocolBehaviorSpec,
+    ) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "  {} - {}",
+            behavior.applicable_protocols, behavior.behavior
+        )?;
+        if let Some(flags) = &behavior.protocol_flags {
+            writeln!(w, "    Flags: {flags}")?;
+        }
+        Ok(())
+    }
+
+    fn end_protocol_behaviors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_addr_families(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nSupported Address Families:")
+    }
+
+    fn addr_family(&mut self, w: &mut dyn Write, family: &AddrFamilySpec) -> std::io::Result<()> {
+        writeln!(w, "  {} ({}):", family.family_name, family.family)?;
+        writeln!(w, "    Struct size: {} bytes", family.addr_struct_size)?;
+        writeln!(
+            w,
+            "    Address length: {}-{} bytes",
+            family.min_addr_len, family.max_addr_len
+        )?;
+        if let Some(format) = &family.addr_format {
+            writeln!(w, "    Format: {format}")?;
+        }
+        writeln!(
+            w,
+            "    Features: wildcard={}, multicast={}, broadcast={}",
+            family.supports_wildcard, family.supports_multicast, family.supports_broadcast
+        )?;
+        if let Some(special) = &family.special_addresses {
+            writeln!(w, "    Special addresses: {special}")?;
+        }
+        if family.port_range_max > 0 {
+            writeln!(
+                w,
+                "    Port range: {}-{}",
+                family.port_range_min, family.port_range_max
+            )?;
+        }
+        Ok(())
+    }
+
+    fn end_addr_families(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn buffer_spec(&mut self, w: &mut dyn Write, spec: &BufferSpec) -> std::io::Result<()> {
+        writeln!(w, "\nBuffer Specification:")?;
+        if let Some(behaviors) = &spec.buffer_behaviors {
+            writeln!(w, "  Behaviors: {behaviors}")?;
+        }
+        if let Some(min) = spec.min_buffer_size {
+            writeln!(w, "  Min size: {min} bytes")?;
+        }
+        if let Some(max) = spec.max_buffer_size {
+            writeln!(w, "  Max size: {max} bytes")?;
+        }
+        if let Some(optimal) = spec.optimal_buffer_size {
+            writeln!(w, "  Optimal size: {optimal} bytes")?;
+        }
+        Ok(())
+    }
+
+    fn async_spec(&mut self, w: &mut dyn Write, spec: &AsyncSpec) -> std::io::Result<()> {
+        writeln!(w, "\nAsynchronous Operation:")?;
+        if let Some(modes) = &spec.supported_modes {
+            writeln!(w, "  Supported modes: {modes}")?;
+        }
+        if let Some(errno) = spec.nonblock_errno {
+            writeln!(w, "  Non-blocking errno: {errno}")?;
+        }
+        Ok(())
+    }
+
+    fn net_data_transfer(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "\nNetwork Data Transfer: {desc}")
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
+        if signal.direction & 1 != 0 { dirs.push("RECEIVE"); }
+        if signal.direction & 2 != 0 { dirs.push("SEND"); }
+        if signal.direction & 4 != 0 { dirs.push("HANDLE"); }
+        if signal.direction & 8 != 0 { dirs.push("BLOCK"); }
+        if signal.direction & 16 != 0 { dirs.push("IGNORE"); }
+        let direction = if dirs.is_empty() { "UNKNOWN".to_string() } else { dirs.join("|") };
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
+        if let Some(error) = signal.error_on_signal {
+            writeln!(w, "      Error on signal: {error}")?;
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
+    fn struct_spec(&mut self, w: &mut dyn Write, spec: &crate::extractor::StructSpec) -> std::io::Result<()> {
+        writeln!(w, "  {} (size={}, align={}):", spec.name, spec.size, spec.alignment)?;
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
+                    writeln!(w, "          Range: [{}, {}]", field.min_value, field.max_value)?;
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
+        f.long_description(&mut sink, "Detailed description here").unwrap();
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
index 0000000000000..21c5f95e60e93
--- /dev/null
+++ b/tools/kapi/src/formatter/rst.rs
@@ -0,0 +1,852 @@
+use super::OutputFormatter;
+use crate::extractor::{
+    AddrFamilySpec, AsyncSpec, BufferSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec,
+    ParamSpec, ProtocolBehaviorSpec, ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec,
+    SocketStateSpec, StateTransitionSpec,
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
+
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
+
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
+
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
+
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
+
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
+
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
+    fn since_version(&mut self, w: &mut dyn Write, version: &str) -> std::io::Result<()> {
+        writeln!(w, ":Available since: {version}")?;
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
+    // Networking-specific methods
+    fn socket_state(&mut self, w: &mut dyn Write, state: &SocketStateSpec) -> std::io::Result<()> {
+
+        let title = "Socket State Requirements";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)?;
+
+        if !state.required_states.is_empty() {
+            writeln!(
+                w,
+                "**Required states:** {}",
+                state.required_states.join(", ")
+            )?;
+        }
+        if !state.forbidden_states.is_empty() {
+            writeln!(
+                w,
+                "**Forbidden states:** {}",
+                state.forbidden_states.join(", ")
+            )?;
+        }
+        if let Some(result) = &state.resulting_state {
+            writeln!(w, "**Resulting state:** {result}")?;
+        }
+        if let Some(cond) = &state.condition {
+            writeln!(w, "**Condition:** {cond}")?;
+        }
+        if let Some(protos) = &state.applicable_protocols {
+            writeln!(w, "**Applicable protocols:** {protos}")?;
+        }
+        writeln!(w)
+    }
+
+    fn begin_protocol_behaviors(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+
+        let title = "Protocol-Specific Behaviors";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn protocol_behavior(
+        &mut self,
+        w: &mut dyn Write,
+        behavior: &ProtocolBehaviorSpec,
+    ) -> std::io::Result<()> {
+        writeln!(w, "**{}**", behavior.applicable_protocols)?;
+        writeln!(w)?;
+        writeln!(w, "{}", behavior.behavior)?;
+        if let Some(flags) = &behavior.protocol_flags {
+            writeln!(w)?;
+            writeln!(w, "*Flags:* {flags}")?;
+        }
+        writeln!(w)
+    }
+
+    fn end_protocol_behaviors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_addr_families(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+
+        let title = "Supported Address Families";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)
+    }
+
+    fn addr_family(&mut self, w: &mut dyn Write, family: &AddrFamilySpec) -> std::io::Result<()> {
+        writeln!(w, "**{} ({})**", family.family_name, family.family)?;
+        writeln!(w)?;
+        writeln!(w, "* **Struct size:** {} bytes", family.addr_struct_size)?;
+        writeln!(
+            w,
+            "* **Address length:** {}-{} bytes",
+            family.min_addr_len, family.max_addr_len
+        )?;
+        if let Some(format) = &family.addr_format {
+            writeln!(w, "* **Format:** ``{format}``")?;
+        }
+        writeln!(
+            w,
+            "* **Features:** wildcard={}, multicast={}, broadcast={}",
+            family.supports_wildcard, family.supports_multicast, family.supports_broadcast
+        )?;
+        if let Some(special) = &family.special_addresses {
+            writeln!(w, "* **Special addresses:** {special}")?;
+        }
+        if family.port_range_max > 0 {
+            writeln!(
+                w,
+                "* **Port range:** {}-{}",
+                family.port_range_min, family.port_range_max
+            )?;
+        }
+        writeln!(w)
+    }
+
+    fn end_addr_families(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn buffer_spec(&mut self, w: &mut dyn Write, spec: &BufferSpec) -> std::io::Result<()> {
+
+        let title = "Buffer Specification";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)?;
+
+        if let Some(behaviors) = &spec.buffer_behaviors {
+            writeln!(w, "**Behaviors:** {behaviors}")?;
+        }
+        if let Some(min) = spec.min_buffer_size {
+            writeln!(w, "**Min size:** {min} bytes")?;
+        }
+        if let Some(max) = spec.max_buffer_size {
+            writeln!(w, "**Max size:** {max} bytes")?;
+        }
+        if let Some(optimal) = spec.optimal_buffer_size {
+            writeln!(w, "**Optimal size:** {optimal} bytes")?;
+        }
+        writeln!(w)
+    }
+
+    fn async_spec(&mut self, w: &mut dyn Write, spec: &AsyncSpec) -> std::io::Result<()> {
+
+        let title = "Asynchronous Operation";
+        writeln!(w, "{title}")?;
+        writeln!(
+            w,
+            "{}",
+            Self::section_char(1).to_string().repeat(title.len())
+        )?;
+        writeln!(w)?;
+
+        if let Some(modes) = &spec.supported_modes {
+            writeln!(w, "**Supported modes:** {modes}")?;
+        }
+        if let Some(errno) = spec.nonblock_errno {
+            writeln!(w, "**Non-blocking errno:** {errno}")?;
+        }
+        writeln!(w)
+    }
+
+    fn net_data_transfer(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "**Network Data Transfer:** {desc}")?;
+        writeln!(w)
+    }
+
+    fn begin_capabilities(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+
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
+
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
+        if signal.direction & 1 != 0 { dirs.push("receive"); }
+        if signal.direction & 2 != 0 { dirs.push("send"); }
+        if signal.direction & 4 != 0 { dirs.push("handle"); }
+        if signal.direction & 8 != 0 { dirs.push("block"); }
+        if signal.direction & 16 != 0 { dirs.push("ignore"); }
+        let direction = if dirs.is_empty() { "unknown".to_string() } else { dirs.join(", ") };
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
+        if let Some(cond) = &signal.condition {
+            writeln!(w, "  :Condition: {}", cond)?;
+        }
+        if let Some(desc) = &signal.description {
+            writeln!(w, "  :Description: {}", desc)?;
+        }
+        if signal.interruptible {
+            writeln!(w, "  :Interruptible: yes")?;
+        }
+        if signal.restartable {
+            writeln!(w, "  :Restartable: yes")?;
+        }
+        writeln!(w)
+    }
+
+    fn end_signals(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_signal_masks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+
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
+
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
+
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
+
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
+
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
+    fn struct_spec(&mut self, w: &mut dyn Write, spec: &crate::extractor::StructSpec) -> std::io::Result<()> {
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
index 0000000000000..ceaf174481e3c
--- /dev/null
+++ b/tools/kapi/src/main.rs
@@ -0,0 +1,119 @@
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
+use formatter::{OutputFormat, create_formatter};
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
+            let filtered: Vec<_> = all_specs.iter()
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
2.51.0


