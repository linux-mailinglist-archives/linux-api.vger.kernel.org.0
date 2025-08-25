Return-Path: <linux-api+bounces-4586-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE8B349FF
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 20:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5321B24223
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E643126B6;
	Mon, 25 Aug 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq0EAC6S"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49781311C37;
	Mon, 25 Aug 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145683; cv=none; b=ECR+p38MeUBIQruJaJMvQTYTOdJcTadb6D3WDNMcG6tJIgr0lx3bZ9JP9JD6AZRuHvSnLWKheymVh5dzOlS553W+cB5BFW2S9KNfKztP0zNVQiIxvVWGzgv3I6iIOqbNo+7VAHR1t4yN/LbpQ9lbeLWXWQU+gcCDWpVH+CvFMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145683; c=relaxed/simple;
	bh=eYLBbwKzBHEdhKyawfY9FzVAzFj8dgzKiWp6zOOcbxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGOmX8ywqpWQmia/RL3FMAHwFgIX1S+pXZs+tG63XsxGqXGWRj1H/qYCnSoaGZjLl1WH2ASXIcQxWqMk5B+QTq3nnRmVLT3jmh5N9W7qmreusaF4ATxr1vepQ8nKQw37aI1nFILEiJMVvE5ZG0Znb7HVIrXheEPoMJ4PKEkgpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq0EAC6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E3CC16AAE;
	Mon, 25 Aug 2025 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145683;
	bh=eYLBbwKzBHEdhKyawfY9FzVAzFj8dgzKiWp6zOOcbxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fq0EAC6S7w0V7aE0dBHQAJpZXi8DDGprovvxSa/w7ID1aXtVihtBpnaemdihZhnHb
	 g/q8S5TXE5mLRGP/Qiww5yOlhj3Hf/+arIB327ZrnMExtHGmACiEVVlRAZxJ0rPCED
	 WmhAY1oo9Hhsoy8AGxJ0avK+hNpSr8QTGPV+1/nuDL33oQoHethez7Zam7ksQCXIT/
	 F7Iewqy85M4LFSl9/Ldp9uSPty2CcTqAgjwXmGSDg0qwsr6gDQnGD97YXjj9uAJCtc
	 wp0eq87GSvYlMG/3hPnSwoNnaelP0CMEauRVzRVJ6ifIgBCNIEATXxtZvItywqEbTK
	 D1AwLQ3dNXkSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v4 7/7] tools/kapi: Add kernel API specification extraction tool
Date: Mon, 25 Aug 2025 14:14:34 -0400
Message-ID: <20250825181434.3340805-8-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825181434.3340805-1-sashal@kernel.org>
References: <20250825181434.3340805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kapi tool extracts and displays kernel API specifications.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/kernel-api-spec.rst | 198 +++-
 tools/kapi/.gitignore                         |   4 +
 tools/kapi/Cargo.toml                         |  19 +
 tools/kapi/src/extractor/debugfs.rs           | 442 +++++++++
 tools/kapi/src/extractor/kerneldoc_parser.rs  | 694 ++++++++++++++
 tools/kapi/src/extractor/mod.rs               | 461 +++++++++
 tools/kapi/src/extractor/source_parser.rs     | 213 +++++
 .../src/extractor/vmlinux/binary_utils.rs     | 180 ++++
 .../src/extractor/vmlinux/magic_finder.rs     | 102 ++
 tools/kapi/src/extractor/vmlinux/mod.rs       | 869 +++++++++++++++++
 tools/kapi/src/formatter/json.rs              | 468 +++++++++
 tools/kapi/src/formatter/mod.rs               | 145 +++
 tools/kapi/src/formatter/plain.rs             | 558 +++++++++++
 tools/kapi/src/formatter/rst.rs               | 621 ++++++++++++
 tools/kapi/src/formatter/shall.rs             | 891 ++++++++++++++++++
 tools/kapi/src/main.rs                        | 116 +++
 16 files changed, 5978 insertions(+), 3 deletions(-)
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
 create mode 100644 tools/kapi/src/formatter/shall.rs
 create mode 100644 tools/kapi/src/main.rs

diff --git a/Documentation/admin-guide/kernel-api-spec.rst b/Documentation/admin-guide/kernel-api-spec.rst
index 3a63f6711e27..9b452753111a 100644
--- a/Documentation/admin-guide/kernel-api-spec.rst
+++ b/Documentation/admin-guide/kernel-api-spec.rst
@@ -31,7 +31,9 @@ The framework aims to:
    common programming errors during development and testing.
 
 3. **Support Tooling**: Export API specifications in machine-readable formats for
-   use by static analyzers, documentation generators, and development tools.
+   use by static analyzers, documentation generators, and development tools. The
+   ``kapi`` tool (see `The kapi Tool`_) provides comprehensive extraction and
+   formatting capabilities.
 
 4. **Enhance Debugging**: Provide detailed API information at runtime through debugfs
    for debugging and introspection.
@@ -71,6 +73,13 @@ The framework consists of several key components:
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
 
@@ -344,8 +353,177 @@ Documentation Generation
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
+- System calls (``DEFINE_KERNEL_API_SPEC``)
+- IOCTLs (``DEFINE_IOCTL_API_SPEC``)
+- Kernel functions (``KAPI_DEFINE_SPEC``)
 
 IDE Integration
 ---------------
@@ -357,6 +535,11 @@ Modern IDEs can use the JSON export for:
 - Context validation
 - Error code documentation
 
+Example IDE integration::
+
+    # Generate IDE completion data
+    $ kapi --format json > .vscode/kernel-apis.json
+
 Testing Framework
 -----------------
 
@@ -367,6 +550,15 @@ The framework includes test helpers::
     kapi_test_api("kmalloc", test_cases);
     #endif
 
+The kapi tool can verify specifications against implementations::
+
+    # Run consistency tests
+    $ cd tools/kapi
+    $ ./test_consistency.sh
+
+    # Compare source vs binary specifications
+    $ ./compare_all_syscalls.sh
+
 Best Practices
 ==============
 
diff --git a/tools/kapi/.gitignore b/tools/kapi/.gitignore
new file mode 100644
index 000000000000..1390bfc12686
--- /dev/null
+++ b/tools/kapi/.gitignore
@@ -0,0 +1,4 @@
+# Rust build artifacts
+/target/
+**/*.rs.bk
+
diff --git a/tools/kapi/Cargo.toml b/tools/kapi/Cargo.toml
new file mode 100644
index 000000000000..4e6bcb10d132
--- /dev/null
+++ b/tools/kapi/Cargo.toml
@@ -0,0 +1,19 @@
+[package]
+name = "kapi"
+version = "0.1.0"
+edition = "2024"
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
index 000000000000..698c51e50438
--- /dev/null
+++ b/tools/kapi/src/extractor/debugfs.rs
@@ -0,0 +1,442 @@
+use crate::formatter::OutputFormatter;
+use anyhow::{Context, Result, bail};
+use serde::Deserialize;
+use std::fs;
+use std::io::Write;
+use std::path::PathBuf;
+
+use super::{ApiExtractor, ApiSpec, CapabilitySpec, display_api_spec};
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
+                if line.trim().is_empty() && multiline_buffer.ends_with("\n\n") {
+                    collecting_multiline = false;
+                    match multiline_field {
+                        "examples" => spec.examples = Some(multiline_buffer.trim().to_string()),
+                        "notes" => spec.notes = Some(multiline_buffer.trim().to_string()),
+                        _ => {}
+                    }
+                    multiline_buffer.clear();
+                } else {
+                    if !multiline_buffer.is_empty() {
+                        multiline_buffer.push('\n');
+                    }
+                    multiline_buffer.push_str(line);
+                }
+                continue;
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
+                Err(_e) => {} // Silently skip files that fail to parse
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
index 000000000000..2a6b5c896be9
--- /dev/null
+++ b/tools/kapi/src/extractor/kerneldoc_parser.rs
@@ -0,0 +1,694 @@
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
+        _signature: Option<&str>,
+    ) -> Result<ApiSpec> {
+        let mut spec = ApiSpec {
+            name: name.to_string(),
+            api_type: api_type.to_string(),
+            description: None,
+            long_description: None,
+            version: None,
+            context_flags: vec![],
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
+        // Parse line by line
+        let lines: Vec<&str> = doc.lines().collect();
+        let mut i = 0;
+
+        // Extract main description from function name line
+        if let Some(first_line) = lines.first() {
+            if let Some((_, desc)) = first_line.split_once(" - ") {
+                spec.description = Some(desc.trim().to_string());
+            }
+        }
+
+        // Keep track of parameters we've seen
+        let mut param_map: HashMap<String, ParamSpec> = HashMap::new();
+        let mut struct_fields: Vec<StructFieldSpec> = Vec::new();
+        let mut current_lock: Option<LockSpec> = None;
+        let mut current_signal: Option<SignalSpec> = None;
+        let mut current_capability: Option<CapabilitySpec> = None;
+
+        while i < lines.len() {
+            let line = lines[i].trim();
+
+            // Skip empty lines
+            if line.is_empty() {
+                i += 1;
+                continue;
+            }
+
+            // Parse @param lines
+            if let Some(rest) = line.strip_prefix("@") {
+                if let Some((param_name, desc)) = rest.split_once(':') {
+                    let param_name = param_name.trim();
+                    let desc = desc.trim();
+                    if !param_name.contains('-') {
+                        // This is a basic parameter description - add to map
+                        param_map.insert(param_name.to_string(), ParamSpec {
+                            index: param_map.len() as u32,
+                            name: param_name.to_string(),
+                            type_name: String::new(),
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
+            }
+            // Parse long-desc
+            else if let Some(rest) = line.strip_prefix("long-desc:") {
+                spec.long_description = Some(self.collect_multiline_value(&lines, i, rest));
+            }
+            // Parse context-flags
+            else if let Some(rest) = line.strip_prefix("context-flags:") {
+                spec.context_flags = self.parse_context_flags(rest.trim());
+            }
+            // Parse param-count
+            else if let Some(rest) = line.strip_prefix("param-count:") {
+                spec.param_count = rest.trim().parse().ok();
+            }
+            // Parse param-type
+            else if let Some(rest) = line.strip_prefix("param-type:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    if let Some(param) = param_map.get_mut(parts[0]) {
+                        param.param_type = self.parse_param_type(parts[1]);
+                    }
+                }
+            }
+            // Parse param-flags
+            else if let Some(rest) = line.strip_prefix("param-flags:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    if let Some(param) = param_map.get_mut(parts[0]) {
+                        param.flags = self.parse_param_flags(parts[1]);
+                    }
+                }
+            }
+            // Parse param-range
+            else if let Some(rest) = line.strip_prefix("param-range:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 3 {
+                    if let Some(param) = param_map.get_mut(parts[0]) {
+                        param.min_value = parts[1].parse().ok();
+                        param.max_value = parts[2].parse().ok();
+                        param.constraint_type = 1; // KAPI_CONSTRAINT_RANGE
+                    }
+                }
+            }
+            // Parse param-constraint
+            else if let Some(rest) = line.strip_prefix("param-constraint:") {
+                let parts: Vec<&str> = rest.splitn(2, ',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    if let Some(param) = param_map.get_mut(parts[0]) {
+                        param.constraint = Some(parts[1].to_string());
+                    }
+                }
+            }
+            // Parse error
+            else if let Some(rest) = line.strip_prefix("error:") {
+                // Parse error in format: "ERROR_CODE, description"
+                let parts: Vec<&str> = rest.splitn(2, ',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    let error_name = parts[0].to_string();
+                    let description = parts[1].to_string();
+
+                    // Look for desc: line on the next line
+                    let mut full_description = description;
+                    if i + 1 < lines.len() {
+                        if let Some(desc_line) = lines[i + 1].strip_prefix("*   desc:") {
+                            full_description = desc_line.trim().to_string();
+                        } else if let Some(desc_line) = lines[i + 1].strip_prefix("* desc:") {
+                            full_description = desc_line.trim().to_string();
+                        }
+                    }
+
+                    // Map common error names to codes
+                    let error_code = match error_name.as_str() {
+                        "E2BIG" => -7,
+                        "EACCES" => -13,
+                        "EAGAIN" => -11,
+                        "EBADF" => -9,
+                        "EBUSY" => -16,
+                        "EFAULT" => -14,
+                        "EINTR" => -4,
+                        "EINVAL" => -22,
+                        "EIO" => -5,
+                        "EISDIR" => -21,
+                        "ELIBBAD" => -80,
+                        "ELOOP" => -40,
+                        "EMFILE" => -24,
+                        "ENAMETOOLONG" => -36,
+                        "ENFILE" => -23,
+                        "ENOENT" => -2,
+                        "ENOEXEC" => -8,
+                        "ENOMEM" => -12,
+                        "ENOTDIR" => -20,
+                        "EOPNOTSUPP" => -95,
+                        "EPERM" => -1,
+                        "ESRCH" => -3,
+                        "ETXTBSY" => -26,
+                        _ => 0,
+                    };
+
+                    spec.errors.push(ErrorSpec {
+                        error_code,
+                        name: error_name,
+                        condition: String::new(),
+                        description: full_description,
+                    });
+                }
+            }
+            // Parse lock
+            else if let Some(rest) = line.strip_prefix("lock:") {
+                // Save previous lock if any
+                if let Some(lock) = current_lock.take() {
+                    spec.locks.push(lock);
+                }
+
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    current_lock = Some(LockSpec {
+                        lock_name: parts[0].to_string(),
+                        lock_type: self.parse_lock_type(parts[1]),
+                        acquired: false,
+                        released: false,
+                        held_on_entry: false,
+                        held_on_exit: false,
+                        description: String::new(),
+                    });
+                }
+            }
+            // Parse lock attributes
+            else if line.strip_prefix("lock-acquired:").is_some() {
+                if let Some(lock) = current_lock.as_mut() {
+                    lock.acquired = true;
+                }
+            }
+            else if line.strip_prefix("lock-released:").is_some() {
+                if let Some(lock) = current_lock.as_mut() {
+                    lock.released = true;
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("lock-desc:") {
+                if let Some(lock) = current_lock.as_mut() {
+                    lock.description = self.collect_multiline_value(&lines, i, rest);
+                }
+            }
+            // Parse signal
+            else if let Some(rest) = line.strip_prefix("signal:") {
+                // Save previous signal if any
+                if let Some(signal) = current_signal.take() {
+                    spec.signals.push(signal);
+                }
+
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
+            }
+            // Parse signal attributes
+            else if let Some(rest) = line.strip_prefix("signal-direction:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.direction = self.parse_signal_direction(rest.trim());
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("signal-action:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.action = self.parse_signal_action(rest.trim());
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("signal-condition:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.condition = Some(self.collect_multiline_value(&lines, i, rest));
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("signal-desc:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.description = Some(self.collect_multiline_value(&lines, i, rest));
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("signal-timing:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.timing = self.parse_signal_timing(rest.trim());
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("signal-priority:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.priority = rest.trim().parse().unwrap_or(0);
+                }
+            }
+            else if line.strip_prefix("signal-interruptible:").is_some() {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.interruptible = true;
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("signal-state-req:") {
+                if let Some(signal) = current_signal.as_mut() {
+                    signal.state_required = self.parse_signal_state(rest.trim());
+                }
+            }
+            // Parse side-effect
+            else if let Some(rest) = line.strip_prefix("side-effect:") {
+                let full_effect = self.collect_multiline_value(&lines, i, rest);
+                let parts: Vec<&str> = full_effect.splitn(3, ',').map(|s| s.trim()).collect();
+                if parts.len() >= 3 {
+                    let mut effect = SideEffectSpec {
+                        effect_type: self.parse_effect_type(parts[0]),
+                        target: parts[1].to_string(),
+                        condition: None,
+                        description: parts[2].to_string(),
+                        reversible: false,
+                    };
+
+                    // Check for additional attributes
+                    if let Some(pos) = parts[2].find("condition=") {
+                        let cond_str = &parts[2][pos + 10..];
+                        if let Some(end) = cond_str.find(',') {
+                            effect.condition = Some(cond_str[..end].to_string());
+                        } else {
+                            effect.condition = Some(cond_str.to_string());
+                        }
+                    }
+
+                    if parts[2].contains("reversible=yes") {
+                        effect.reversible = true;
+                    }
+
+                    spec.side_effects.push(effect);
+                }
+            }
+            // Parse state-trans
+            else if let Some(rest) = line.strip_prefix("state-trans:") {
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
+            }
+            // Parse capability
+            else if let Some(rest) = line.strip_prefix("capability:") {
+                // Save previous capability if any
+                if let Some(cap) = current_capability.take() {
+                    spec.capabilities.push(cap);
+                }
+
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 3 {
+                    current_capability = Some(CapabilitySpec {
+                        capability: self.parse_capability_value(parts[0]),
+                        action: parts[1].to_string(),
+                        name: parts[2].to_string(),
+                        allows: String::new(),
+                        without_cap: String::new(),
+                        check_condition: None,
+                        priority: Some(0),
+                        alternatives: vec![],
+                    });
+                }
+            }
+            // Parse capability attributes
+            else if let Some(rest) = line.strip_prefix("capability-allows:") {
+                if let Some(cap) = current_capability.as_mut() {
+                    cap.allows = self.collect_multiline_value(&lines, i, rest);
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("capability-without:") {
+                if let Some(cap) = current_capability.as_mut() {
+                    cap.without_cap = self.collect_multiline_value(&lines, i, rest);
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("capability-condition:") {
+                if let Some(cap) = current_capability.as_mut() {
+                    cap.check_condition = Some(self.collect_multiline_value(&lines, i, rest));
+                }
+            }
+            else if let Some(rest) = line.strip_prefix("capability-priority:") {
+                if let Some(cap) = current_capability.as_mut() {
+                    cap.priority = rest.trim().parse().ok();
+                }
+            }
+            // Parse constraint
+            else if let Some(rest) = line.strip_prefix("constraint:") {
+                let parts: Vec<&str> = rest.splitn(2, ',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    spec.constraints.push(ConstraintSpec {
+                        name: parts[0].to_string(),
+                        description: parts[1].to_string(),
+                        expression: None,
+                    });
+                }
+            }
+            // Parse constraint-expr
+            else if let Some(rest) = line.strip_prefix("constraint-expr:") {
+                let parts: Vec<&str> = rest.splitn(2, ',').map(|s| s.trim()).collect();
+                if parts.len() >= 2 {
+                    // Find matching constraint and update it
+                    if let Some(constraint) = spec.constraints.iter_mut().find(|c| c.name == parts[0]) {
+                        constraint.expression = Some(parts[1].to_string());
+                    }
+                }
+            }
+            // Parse struct-field
+            else if let Some(rest) = line.strip_prefix("struct-field:") {
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
+            }
+            // Parse struct-field-range
+            else if let Some(rest) = line.strip_prefix("struct-field-range:") {
+                let parts: Vec<&str> = rest.split(',').map(|s| s.trim()).collect();
+                if parts.len() >= 3 {
+                    // Update the field with range
+                    if let Some(field) = struct_fields.iter_mut().find(|f| f.name == parts[0]) {
+                        field.min_value = parts[1].parse().unwrap_or(0);
+                        field.max_value = parts[2].parse().unwrap_or(0);
+                        field.constraint_type = 1; // KAPI_CONSTRAINT_RANGE
+                    }
+                }
+            }
+            // Parse examples
+            else if let Some(rest) = line.strip_prefix("examples:") {
+                spec.examples = Some(self.collect_multiline_value(&lines, i, rest));
+            }
+            // Parse notes
+            else if let Some(rest) = line.strip_prefix("notes:") {
+                spec.notes = Some(self.collect_multiline_value(&lines, i, rest));
+            }
+            // Parse since-version
+            else if let Some(rest) = line.strip_prefix("since-version:") {
+                spec.since_version = Some(rest.trim().to_string());
+            }
+            // Parse return-type
+            else if let Some(rest) = line.strip_prefix("return-type:") {
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
+            }
+            // Parse return-check-type
+            else if let Some(rest) = line.strip_prefix("return-check-type:") {
+                if let Some(ret) = spec.return_spec.as_mut() {
+                    ret.check_type = self.parse_return_check_type(rest.trim());
+                }
+            }
+            // Parse return-success
+            else if let Some(rest) = line.strip_prefix("return-success:") {
+                if let Some(ret) = spec.return_spec.as_mut() {
+                    ret.success_value = rest.trim().parse().ok();
+                }
+            }
+
+            i += 1;
+        }
+
+        // Save any remaining items
+        if let Some(lock) = current_lock {
+            spec.locks.push(lock);
+        }
+        if let Some(signal) = current_signal {
+            spec.signals.push(signal);
+        }
+        if let Some(cap) = current_capability {
+            spec.capabilities.push(cap);
+        }
+
+        // Convert param_map to vec preserving order
+        let mut params: Vec<ParamSpec> = param_map.into_values().collect();
+        params.sort_by_key(|p| p.index);
+        spec.parameters = params;
+
+        // Create struct spec if we have fields
+        if !struct_fields.is_empty() {
+            spec.struct_specs.push(StructSpec {
+                name: "struct sched_attr".to_string(),
+                size: 120, // Default for sched_attr
+                alignment: 8,
+                field_count: struct_fields.len() as u32,
+                fields: struct_fields,
+                description: "Structure specification".to_string(),
+            });
+        }
+
+        Ok(spec)
+    }
+
+    fn collect_multiline_value(&self, lines: &[&str], start_idx: usize, first_part: &str) -> String {
+        let mut result = String::from(first_part.trim());
+        let mut i = start_idx + 1;
+
+        // Continue collecting lines until we hit another annotation or end
+        while i < lines.len() {
+            let line = lines[i];
+
+            // Stop if we hit another annotation (contains ':' and starts with valid keyword)
+            if self.is_annotation_line(line) {
+                break;
+            }
+
+            // Add continuation lines
+            if !line.trim().is_empty() && line.starts_with("  ") {
+                if !result.is_empty() {
+                    result.push(' ');
+                }
+                result.push_str(line.trim());
+            } else if line.trim().is_empty() {
+                // Empty line might be part of multiline
+                i += 1;
+                continue;
+            } else {
+                // Non-continuation line, stop
+                break;
+            }
+
+            i += 1;
+        }
+
+        result
+    }
+
+    fn is_annotation_line(&self, line: &str) -> bool {
+        let annotations = [
+            "param-", "error-", "lock", "signal", "side-effect:",
+            "state-trans:", "capability", "constraint", "struct-",
+            "return-", "examples:", "notes:", "since-", "context-",
+            "long-desc:"
+        ];
+
+        for ann in &annotations {
+            if line.trim_start().starts_with(ann) {
+                return true;
+            }
+        }
+        false
+    }
+
+    fn parse_context_flags(&self, flags: &str) -> Vec<String> {
+        flags.split('|')
+            .map(|f| f.trim().to_string())
+            .collect()
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
+                "KAPI_PARAM_IN" => result |= 1,
+                "KAPI_PARAM_OUT" => result |= 2,
+                "KAPI_PARAM_INOUT" => result |= 3,
+                "KAPI_PARAM_USER" => result |= 4,
+                _ => {}
+            }
+        }
+        result
+    }
+
+    fn parse_lock_type(&self, type_str: &str) -> u32 {
+        match type_str {
+            "KAPI_LOCK_SPINLOCK" => 0,
+            "KAPI_LOCK_MUTEX" => 1,
+            "KAPI_LOCK_RWLOCK" => 2,
+            _ => 3,
+        }
+    }
+
+    fn parse_signal_direction(&self, dir: &str) -> u32 {
+        match dir {
+            "KAPI_SIGNAL_SEND" => 1,
+            "KAPI_SIGNAL_RECEIVE" => 2,
+            _ => 0,
+        }
+    }
+
+    fn parse_signal_action(&self, action: &str) -> u32 {
+        match action {
+            "KAPI_SIGNAL_ACTION_DEFAULT" => 0,
+            "KAPI_SIGNAL_ACTION_IGNORE" => 1,
+            "KAPI_SIGNAL_ACTION_CUSTOM" => 2,
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
+                _ => {}
+            }
+        }
+        result
+    }
+
+    fn parse_capability_value(&self, cap: &str) -> i32 {
+        match cap {
+            "CAP_SYS_NICE" => 23,
+            _ => 0,
+        }
+    }
+
+    fn parse_return_check_type(&self, check: &str) -> u32 {
+        match check {
+            "KAPI_RETURN_ERROR_CHECK" => 1,
+            "KAPI_RETURN_SUCCESS_CHECK" => 2,
+            _ => 0,
+        }
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/mod.rs b/tools/kapi/src/extractor/mod.rs
new file mode 100644
index 000000000000..010851fe6a89
--- /dev/null
+++ b/tools/kapi/src/extractor/mod.rs
@@ -0,0 +1,461 @@
+use crate::formatter::OutputFormatter;
+use anyhow::Result;
+use std::convert::TryInto;
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
+/// Lock specification
+#[derive(Debug, Clone, serde::Serialize)]
+pub struct LockSpec {
+    pub lock_name: String,
+    pub lock_type: u32,
+    pub acquired: bool,
+    pub released: bool,
+    pub held_on_entry: bool,
+    pub held_on_exit: bool,
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
+#[derive(Debug, Clone)]
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
index 000000000000..7a72b85a83be
--- /dev/null
+++ b/tools/kapi/src/extractor/source_parser.rs
@@ -0,0 +1,213 @@
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
+                paren_count -= line.chars().filter(|&c| c == ')').count();
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
+                .filter(|e| e.path().extension().is_some_and(|ext| ext == "c"))
+            {
+                if let Ok(specs) = self.extract_from_file(entry.path()) {
+                    all_specs.extend(specs);
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
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/vmlinux/binary_utils.rs b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
new file mode 100644
index 000000000000..0a51943e1c02
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
@@ -0,0 +1,180 @@
+// Constants for all structure field sizes
+pub mod sizes {
+    pub const NAME: usize = 128;
+    pub const DESC: usize = 512;
+    pub const MAX_PARAMS: usize = 16;
+    pub const MAX_ERRORS: usize = 32;
+    pub const MAX_CONSTRAINTS: usize = 16;
+    pub const MAX_CAPABILITIES: usize = 8;
+    pub const MAX_SIGNALS: usize = 16;
+    pub const MAX_STRUCT_SPECS: usize = 8;
+    pub const MAX_SIDE_EFFECTS: usize = 32;
+    pub const MAX_STATE_TRANS: usize = 16;
+    pub const MAX_PROTOCOL_BEHAVIORS: usize = 8;
+    pub const MAX_ADDR_FAMILIES: usize = 8;
+}
+
+// Helper for reading data at specific offsets
+pub struct DataReader<'a> {
+    pub data: &'a [u8],
+    pub pos: usize,
+}
+
+impl<'a> DataReader<'a> {
+    pub fn new(data: &'a [u8], offset: usize) -> Self {
+        Self { data, pos: offset }
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
+        self.read_bytes(4).map(|b| u32::from_le_bytes(b.try_into().unwrap()))
+    }
+
+    pub fn read_u8(&mut self) -> Option<u8> {
+        self.read_bytes(1).map(|b| b[0])
+    }
+
+    pub fn read_i32(&mut self) -> Option<i32> {
+        self.read_bytes(4).map(|b| i32::from_le_bytes(b.try_into().unwrap()))
+    }
+
+    pub fn read_u64(&mut self) -> Option<u64> {
+        self.read_bytes(8).map(|b| u64::from_le_bytes(b.try_into().unwrap()))
+    }
+
+    pub fn read_i64(&mut self) -> Option<i64> {
+        self.read_bytes(8).map(|b| i64::from_le_bytes(b.try_into().unwrap()))
+    }
+
+    pub fn read_usize(&mut self) -> Option<usize> {
+        self.read_u64().map(|v| v as usize)
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
+    // Read multiple booleans at once
+    pub fn read_bools<const N: usize>(&mut self) -> Option<[bool; N]> {
+        let mut result = [false; N];
+        for item in &mut result {
+            *item = self.read_bool()?;
+        }
+        Some(result)
+    }
+
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
diff --git a/tools/kapi/src/extractor/vmlinux/magic_finder.rs b/tools/kapi/src/extractor/vmlinux/magic_finder.rs
new file mode 100644
index 000000000000..cb7dc535801a
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/magic_finder.rs
@@ -0,0 +1,102 @@
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
+    pub fn find_in_data(data: &[u8], base_offset: usize) -> Self {
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
+            let value = u32::from_le_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]);
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
index 000000000000..a8c4ed4de626
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/mod.rs
@@ -0,0 +1,869 @@
+use super::{
+    ApiExtractor, ApiSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec, ParamSpec,
+    ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec, StateTransitionSpec, StructSpec,
+    StructFieldSpec,
+};
+use crate::formatter::OutputFormatter;
+use anyhow::{Context, Result};
+use goblin::elf::Elf;
+use std::convert::TryInto;
+use std::fs;
+use std::io::Write;
+
+mod binary_utils;
+mod magic_finder;
+use binary_utils::{
+    DataReader, addr_family_spec_layout_size, async_spec_layout_size, buffer_spec_layout_size,
+    protocol_behavior_spec_layout_size, signal_mask_spec_layout_size,
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
+        // Find the .kapi_specs section
+        let kapi_section = elf
+            .section_headers
+            .iter()
+            .find(|sh| {
+                if let Some(name) = elf.shdr_strtab.get_at(sh.sh_name) {
+                    name == ".kapi_specs"
+                } else {
+                    false
+                }
+            })
+            .context("Could not find .kapi_specs section in vmlinux")?;
+
+        // Find __start_kapi_specs and __stop_kapi_specs symbols
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
+        // Calculate the offset within the file
+        let section_vaddr = kapi_section.sh_addr;
+        let file_offset = kapi_section.sh_offset + (start - section_vaddr);
+        let data_size: usize = (stop - start)
+            .try_into()
+            .context("Data size too large for platform")?;
+
+        let file_offset_usize: usize = file_offset
+            .try_into()
+            .context("File offset too large for platform")?;
+
+        if file_offset_usize + data_size > vmlinux_data.len() {
+            anyhow::bail!("Invalid offset/size for .kapi_specs data");
+        }
+
+        // Extract the raw data
+        let kapi_data = vmlinux_data[file_offset_usize..(file_offset_usize + data_size)].to_vec();
+
+        // Parse the specifications
+        let specs = parse_kapi_specs(&kapi_data)?;
+
+        Ok(VmlinuxExtractor { kapi_data, specs })
+    }
+}
+
+fn parse_kapi_specs(data: &[u8]) -> Result<Vec<KapiSpec>> {
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
+                    let magic_value = u32::from_le_bytes([magic_bytes[0], magic_bytes[1], magic_bytes[2], magic_bytes[3]]);
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
+                parse_binary_to_api_spec(&self.kapi_data, spec.offset)
+                    .unwrap_or_else(|_| ApiSpec {
+                        name: spec.name.clone(),
+                        api_type: spec.api_type.clone(),
+                        description: None,
+                        long_description: None,
+                        version: None,
+                        context_flags: vec![],
+                        param_count: None,
+                        error_count: None,
+                        examples: None,
+                        notes: None,
+                        since_version: None,
+                        subsystem: None,
+                        sysfs_path: None,
+                        permissions: None,
+                        socket_state: None,
+                        protocol_behaviors: vec![],
+                        addr_families: vec![],
+                        buffer_spec: None,
+                        async_spec: None,
+                        net_data_transfer: None,
+                        capabilities: vec![],
+                        parameters: vec![],
+                        return_spec: None,
+                        errors: vec![],
+                        signals: vec![],
+                        signal_masks: vec![],
+                        side_effects: vec![],
+                        state_transitions: vec![],
+                        constraints: vec![],
+                        locks: vec![],
+                        struct_specs: vec![],
+                    })
+            })
+            .collect())
+    }
+
+    fn extract_by_name(&self, api_name: &str) -> Result<Option<ApiSpec>> {
+        if let Some(spec) = self.specs.iter().find(|s| s.name == api_name) {
+            Ok(Some(parse_binary_to_api_spec(&self.kapi_data, spec.offset)?))
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
+            let api_spec = parse_binary_to_api_spec(&self.kapi_data, spec.offset)?;
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
+    F: Fn(&mut DataReader) -> Option<T>,
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
+        for _ in 0..count.min(max_items) as usize {
+            if let Some(item) = parse_fn(reader) {
+                items.push(item);
+            }
+        }
+    }
+    items
+}
+
+fn parse_binary_to_api_spec(data: &[u8], offset: usize) -> Result<ApiSpec> {
+    let mut reader = DataReader::new(data, offset);
+
+    // Search for magic markers in the entire spec data
+    let search_end = (offset + 0x70000).min(data.len()); // Search full spec size
+    let spec_data = &data[offset..search_end];
+
+    // Find magic markers relative to the spec start
+    let magic_offsets = magic_finder::MagicOffsets::find_in_data(spec_data, offset);
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
+        |r| parse_param(r, 0),  // Index doesn't seem to be used in parse_param
+    );
+
+    // Read return_spec
+    let return_spec = parse_return_spec(&mut reader);
+
+    // Parse errors array
+    let errors = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.error_offset,
+        sizes::MAX_ERRORS as u32,
+        parse_error,
+    );
+
+    // Parse locks array
+    let locks = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.lock_offset,
+        sizes::MAX_CONSTRAINTS as u32,
+        parse_lock,
+    );
+
+    // Parse constraints array
+    let constraints = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.constraint_offset,
+        sizes::MAX_CONSTRAINTS as u32,
+        parse_constraint,
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
+        parse_signal,
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
+        parse_struct_spec,
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
+        parse_side_effect,
+    );
+
+    // Parse state_transitions array
+    let state_transitions = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.trans_offset,
+        sizes::MAX_STATE_TRANS as u32,
+        parse_state_transition,
+    );
+
+    // Parse capabilities array
+    let capabilities = parse_array_with_magic(
+        &mut reader,
+        magic_offsets.cap_offset,
+        sizes::MAX_CAPABILITIES as u32,
+        parse_capability,
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
+        if !parts.is_empty() {
+            vec![parts.join(" | ")]
+        } else {
+            vec![]
+        }
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
+    let [acquired, released, held_on_entry, held_on_exit] = reader.read_bools()?;
+    let description = reader.read_string_or_default(sizes::DESC);
+
+    Some(LockSpec {
+        lock_name,
+        lock_type,
+        acquired,
+        released,
+        held_on_entry,
+        held_on_exit,
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
index 000000000000..8025467409d6
--- /dev/null
+++ b/tools/kapi/src/formatter/json.rs
@@ -0,0 +1,468 @@
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
+        self.data.apis = Some(Vec::new());
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
+    // Stub implementations for new methods
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
diff --git a/tools/kapi/src/formatter/mod.rs b/tools/kapi/src/formatter/mod.rs
new file mode 100644
index 000000000000..d799ff0ba971
--- /dev/null
+++ b/tools/kapi/src/formatter/mod.rs
@@ -0,0 +1,145 @@
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
+mod shall;
+
+pub use json::JsonFormatter;
+pub use plain::PlainFormatter;
+pub use rst::RstFormatter;
+pub use shall::ShallFormatter;
+
+#[derive(Debug, Clone, Copy, PartialEq)]
+pub enum OutputFormat {
+    Plain,
+    Json,
+    Rst,
+    Shall,
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
+            "shall" => Ok(OutputFormat::Shall),
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
+        OutputFormat::Shall => Box::new(ShallFormatter::new()),
+    }
+}
diff --git a/tools/kapi/src/formatter/plain.rs b/tools/kapi/src/formatter/plain.rs
new file mode 100644
index 000000000000..4c2d930aac94
--- /dev/null
+++ b/tools/kapi/src/formatter/plain.rs
@@ -0,0 +1,558 @@
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
+        // Display direction
+        let direction = match signal.direction {
+            0 => "SEND",
+            1 => "RECEIVE",
+            2 => "HANDLE",
+            3 => "IGNORE",
+            _ => "UNKNOWN",
+        };
+        write!(w, " - {direction}")?;
+
+        // Display action
+        let action = match signal.action {
+            0 => "DEFAULT",
+            1 => "TERMINATE",
+            2 => "COREDUMP",
+            3 => "STOP",
+            4 => "CONTINUE",
+            5 => "IGNORE",
+            6 => "CUSTOM",
+            7 => "DISCARD",
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
+        let mut actions = Vec::new();
+        if lock.acquired {
+            actions.push("acquired");
+        }
+        if lock.released {
+            actions.push("released");
+        }
+        if lock.held_on_entry {
+            actions.push("held on entry");
+        }
+        if lock.held_on_exit {
+            actions.push("held on exit");
+        }
+
+        if !actions.is_empty() {
+            writeln!(w, "      Actions: {}", actions.join(", "))?;
+        }
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
diff --git a/tools/kapi/src/formatter/rst.rs b/tools/kapi/src/formatter/rst.rs
new file mode 100644
index 000000000000..51d0be911480
--- /dev/null
+++ b/tools/kapi/src/formatter/rst.rs
@@ -0,0 +1,621 @@
+use super::OutputFormatter;
+use crate::extractor::{
+    AddrFamilySpec, AsyncSpec, BufferSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec,
+    ParamSpec, ProtocolBehaviorSpec, ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec,
+    SocketStateSpec, StateTransitionSpec,
+};
+use std::io::Write;
+
+pub struct RstFormatter {
+    current_section_level: usize,
+}
+
+impl RstFormatter {
+    pub fn new() -> Self {
+        RstFormatter {
+            current_section_level: 0,
+        }
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
+        self.current_section_level = 0;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+    // Stub implementations for new methods
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
+    fn begin_signals(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn signal(&mut self, _w: &mut dyn Write, _signal: &SignalSpec) -> std::io::Result<()> {
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
+    fn signal_mask(&mut self, _w: &mut dyn Write, _mask: &SignalMaskSpec) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_signal_masks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_side_effects(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        self.current_section_level = 1;
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
+        self.current_section_level = 1;
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
+    fn begin_constraints(&mut self, _w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn constraint(
+        &mut self,
+        _w: &mut dyn Write,
+        _constraint: &ConstraintSpec,
+    ) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_constraints(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_locks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        self.current_section_level = 1;
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
diff --git a/tools/kapi/src/formatter/shall.rs b/tools/kapi/src/formatter/shall.rs
new file mode 100644
index 000000000000..cc169d1290ca
--- /dev/null
+++ b/tools/kapi/src/formatter/shall.rs
@@ -0,0 +1,891 @@
+use super::OutputFormatter;
+use crate::extractor::{
+    AddrFamilySpec, AsyncSpec, BufferSpec, CapabilitySpec, ConstraintSpec, ErrorSpec, LockSpec,
+    ParamSpec, ProtocolBehaviorSpec, ReturnSpec, SideEffectSpec, SignalMaskSpec, SignalSpec,
+    SocketStateSpec, StateTransitionSpec,
+};
+use std::io::Write;
+
+pub struct ShallFormatter {
+    api_name: Option<String>,
+    in_list: bool,
+}
+
+impl ShallFormatter {
+    pub fn new() -> Self {
+        ShallFormatter {
+            api_name: None,
+            in_list: false,
+        }
+    }
+}
+
+impl OutputFormatter for ShallFormatter {
+    fn begin_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn end_document(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_api_list(&mut self, w: &mut dyn Write, title: &str) -> std::io::Result<()> {
+        self.in_list = true;
+        writeln!(w, "\n{} API Behavioral Requirements:", title)?;
+        writeln!(w)
+    }
+
+    fn api_item(&mut self, w: &mut dyn Write, name: &str, _api_type: &str) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "- {} shall be available for {}",
+            name,
+            name.replace('_', " ")
+        )
+    }
+
+    fn end_api_list(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        self.in_list = false;
+        Ok(())
+    }
+
+    fn total_specs(&mut self, w: &mut dyn Write, count: usize) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "\nTotal: {} kernel API specifications shall be enforced.",
+            count
+        )
+    }
+
+    fn begin_api_details(&mut self, w: &mut dyn Write, name: &str) -> std::io::Result<()> {
+        self.api_name = Some(name.to_string());
+        writeln!(w, "\nBehavioral Requirements for {}:", name)?;
+        writeln!(w)
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        self.api_name = None;
+        Ok(())
+    }
+
+    fn description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        if let Some(api_name) = &self.api_name {
+            writeln!(w, "- {} shall {}.", api_name, desc.trim_end_matches('.'))
+        } else {
+            writeln!(w, "- The API shall {}.", desc.trim_end_matches('.'))
+        }
+    }
+
+    fn long_description(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w)?;
+        for line in desc.lines() {
+            if !line.trim().is_empty() {
+                writeln!(w, "{}", line)?;
+            }
+        }
+        writeln!(w)
+    }
+
+    fn begin_context_flags(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nExecution Context Requirements:")?;
+        writeln!(w)
+    }
+
+    fn context_flag(&mut self, w: &mut dyn Write, flag: &str) -> std::io::Result<()> {
+        // Parse context flags and make them readable with specific requirements
+        match flag {
+            "Process context" => {
+                writeln!(w, "- The function shall be callable from process context.")?;
+                writeln!(
+                    w,
+                    "  Process context allows the function to sleep, allocate memory with GFP_KERNEL, and access user space."
+                )
+            }
+            "Softirq context" => {
+                writeln!(w, "- The function shall be callable from softirq context.")?;
+                writeln!(
+                    w,
+                    "  In softirq context, the function shall not sleep and shall use GFP_ATOMIC for memory allocations."
+                )
+            }
+            "Hardirq context" => {
+                writeln!(
+                    w,
+                    "- The function shall be callable from hardirq (interrupt) context."
+                )?;
+                writeln!(
+                    w,
+                    "  In hardirq context, the function shall not sleep, shall minimize execution time, and shall use GFP_ATOMIC for allocations."
+                )
+            }
+            "NMI context" => {
+                writeln!(
+                    w,
+                    "- The function shall be callable from NMI (Non-Maskable Interrupt) context."
+                )?;
+                writeln!(
+                    w,
+                    "  In NMI context, the function shall not take any locks that might be held by interrupted code."
+                )
+            }
+            "User mode" => {
+                writeln!(
+                    w,
+                    "- The function shall be callable when the CPU is in user mode."
+                )?;
+                writeln!(w, "  This typically applies to system call entry points.")
+            }
+            "Kernel mode" => {
+                writeln!(
+                    w,
+                    "- The function shall be callable when the CPU is in kernel mode."
+                )
+            }
+            "May sleep" => {
+                writeln!(w, "- The function may sleep (block) during execution.")?;
+                writeln!(
+                    w,
+                    "  Callers shall ensure they are in a context where sleeping is allowed (not in interrupt or atomic context)."
+                )
+            }
+            "Atomic context" => {
+                writeln!(w, "- The function shall be callable from atomic context.")?;
+                writeln!(
+                    w,
+                    "  In atomic context, the function shall not sleep and shall complete quickly."
+                )
+            }
+            "Preemptible" => {
+                writeln!(
+                    w,
+                    "- The function shall be callable when preemption is enabled."
+                )?;
+                writeln!(
+                    w,
+                    "  The function may be preempted by higher priority tasks."
+                )
+            }
+            "Migration disabled" => {
+                writeln!(
+                    w,
+                    "- The function shall be callable when CPU migration is disabled."
+                )?;
+                writeln!(
+                    w,
+                    "  The function shall not rely on being able to migrate between CPUs."
+                )
+            }
+            _ => {
+                // Fallback for unrecognized flags
+                writeln!(w, "- The function shall be callable from {} context.", flag)
+            }
+        }
+    }
+
+    fn end_context_flags(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_parameters(&mut self, w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nParameter Requirements:")
+    }
+
+    fn parameter(&mut self, w: &mut dyn Write, param: &ParamSpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        writeln!(
+            w,
+            "- If {} is provided, it shall be {}.",
+            param.name,
+            param.description.trim_end_matches('.')
+        )?;
+
+        // Only show meaningful numeric constraints
+        if let Some(min) = param.min_value {
+            if let Some(max) = param.max_value {
+                if min != 0 || max != 0 {
+                    writeln!(
+                        w,
+                        "\n- If {} is less than {} or greater than {}, the operation shall fail.",
+                        param.name, min, max
+                    )?;
+                }
+            } else if min != 0 {
+                writeln!(
+                    w,
+                    "\n- If {} is less than {}, the operation shall fail.",
+                    param.name, min
+                )?;
+            }
+        } else if let Some(max) = param.max_value {
+            if max != 0 {
+                writeln!(
+                    w,
+                    "\n- If {} is greater than {}, the operation shall fail.",
+                    param.name, max
+                )?;
+            }
+        }
+
+        if let Some(constraint) = &param.constraint {
+            if !constraint.is_empty() {
+                let constraint_text = constraint.trim_end_matches('.');
+                // Handle constraints that start with "Must be" or similar
+                if constraint_text.to_lowercase().starts_with("must be ") {
+                    let requirement = &constraint_text[8..]; // Skip "Must be "
+                    writeln!(
+                        w,
+                        "\n- If {} is not {}, the operation shall fail.",
+                        param.name, requirement
+                    )?;
+                } else if constraint_text.to_lowercase().starts_with("must ") {
+                    let requirement = &constraint_text[5..]; // Skip "Must "
+                    writeln!(
+                        w,
+                        "\n- If {} does not {}, the operation shall fail.",
+                        param.name, requirement
+                    )?;
+                } else if constraint_text.contains(" must ") || constraint_text.contains(" should ")
+                {
+                    // Reformat constraints with must/should in the middle
+                    writeln!(w, "\n- {} shall satisfy: {}.", param.name, constraint_text)?;
+                } else {
+                    // Default format for other constraints
+                    writeln!(
+                        w,
+                        "\n- If {} is not {}, the operation shall fail.",
+                        param.name, constraint_text
+                    )?;
+                }
+            }
+        }
+
+        // Only show valid_mask if it's not 0
+        if let Some(mask) = param.valid_mask {
+            if mask != 0 {
+                writeln!(
+                    w,
+                    "\n- If {} contains bits not set in 0x{:x}, the operation shall fail.",
+                    param.name, mask
+                )?;
+            }
+        }
+
+        Ok(())
+    }
+
+    fn end_parameters(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn return_spec(&mut self, w: &mut dyn Write, ret: &ReturnSpec) -> std::io::Result<()> {
+        writeln!(w, "\nReturn Value Behavior:")?;
+        writeln!(w)?;
+
+        if let Some(success) = ret.success_value {
+            writeln!(
+                w,
+                "- If the operation succeeds, the function shall return {}.",
+                success
+            )?;
+        } else if let Some(min) = ret.success_min {
+            if let Some(max) = ret.success_max {
+                writeln!(
+                    w,
+                    "- If the operation succeeds, the function shall return a value between {} and {} inclusive.",
+                    min, max
+                )?;
+            } else {
+                writeln!(
+                    w,
+                    "- If the operation succeeds, the function shall return a value greater than or equal to {}.",
+                    min
+                )?;
+            }
+        }
+
+        if !ret.error_values.is_empty() {
+            writeln!(
+                w,
+                "\n- If the operation fails, the function shall return one of the specified negative error values."
+            )?;
+        }
+
+        Ok(())
+    }
+
+    fn begin_errors(&mut self, w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nError Handling:")?;
+        Ok(())
+    }
+
+    fn error(&mut self, w: &mut dyn Write, error: &ErrorSpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        let condition = if error.condition.is_empty() {
+            error
+                .description
+                .to_lowercase()
+                .trim_end_matches('.')
+                .to_string()
+        } else {
+            error.condition.to_lowercase()
+        };
+        writeln!(
+            w,
+            "- If {condition}, the function shall return -{}.",
+            error.name
+        )?;
+
+        // Add description if available and different from condition
+        if !error.description.is_empty() && error.description != error.condition {
+            writeln!(w, "  {}", error.description)?;
+        }
+
+        Ok(())
+    }
+
+    fn end_errors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn examples(&mut self, w: &mut dyn Write, examples: &str) -> std::io::Result<()> {
+        writeln!(w, "\nExample Usage:")?;
+        writeln!(w)?;
+        writeln!(w, "```")?;
+        write!(w, "{}", examples)?;
+        writeln!(w, "```")
+    }
+
+    fn notes(&mut self, w: &mut dyn Write, notes: &str) -> std::io::Result<()> {
+        writeln!(w, "\nImplementation Notes:")?;
+        writeln!(w)?;
+
+        // Split notes into sentences and format each as a behavioral requirement
+        let sentences: Vec<&str> = notes.split(". ").filter(|s| !s.trim().is_empty()).collect();
+
+        for sentence in sentences {
+            let trimmed = sentence.trim().trim_end_matches('.');
+            if trimmed.is_empty() {
+                continue;
+            }
+
+            // Check if it already contains "shall" or similar
+            if trimmed.contains("shall") || trimmed.contains("must") {
+                writeln!(w, "- {}.", trimmed)?;
+            } else if trimmed.starts_with("On ")
+                || trimmed.starts_with("If ")
+                || trimmed.starts_with("When ")
+            {
+                // These are already conditional, just add shall
+                writeln!(w, "- {}, the behavior shall be as described.", trimmed)?;
+            } else {
+                // Convert to a shall statement
+                writeln!(
+                    w,
+                    "- The implementation shall ensure that {}.",
+                    trimmed
+                        .chars()
+                        .next()
+                        .unwrap()
+                        .to_lowercase()
+                        .collect::<String>()
+                        + &trimmed[1..]
+                )?;
+            }
+        }
+        Ok(())
+    }
+
+    fn since_version(&mut self, w: &mut dyn Write, version: &str) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "\n- If kernel version is {} or later, this API shall be available.",
+            version
+        )
+    }
+
+    fn sysfs_subsystem(&mut self, w: &mut dyn Write, subsystem: &str) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "- If accessed through sysfs, the attribute shall be located in the {} subsystem.",
+            subsystem
+        )
+    }
+
+    fn sysfs_path(&mut self, w: &mut dyn Write, path: &str) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "\n- If the sysfs interface is mounted, the attribute shall be accessible at {}.",
+            path
+        )
+    }
+
+    fn sysfs_permissions(&mut self, w: &mut dyn Write, perms: &str) -> std::io::Result<()> {
+        writeln!(
+            w,
+            "\n- If the attribute exists, its permissions shall be set to {}.",
+            perms
+        )
+    }
+
+    fn socket_state(&mut self, w: &mut dyn Write, state: &SocketStateSpec) -> std::io::Result<()> {
+        writeln!(w, "\nSocket State Behavior:")?;
+        writeln!(w)?;
+
+        if !state.required_states.is_empty() {
+            let states_str = state.required_states.join(" or ");
+            writeln!(
+                w,
+                "- If the socket is not in {} state, the operation shall fail.",
+                states_str
+            )?;
+        }
+
+        if !state.forbidden_states.is_empty() {
+            for s in &state.forbidden_states {
+                writeln!(
+                    w,
+                    "\n- If the socket is in {} state, the operation shall fail.",
+                    s
+                )?;
+            }
+        }
+
+        if let Some(result) = &state.resulting_state {
+            writeln!(
+                w,
+                "\n- If the operation succeeds, the socket state shall transition to {}.",
+                result
+            )?;
+        }
+
+        Ok(())
+    }
+
+    fn begin_protocol_behaviors(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nProtocol-Specific Behavior:")
+    }
+
+    fn protocol_behavior(
+        &mut self,
+        w: &mut dyn Write,
+        behavior: &ProtocolBehaviorSpec,
+    ) -> std::io::Result<()> {
+        writeln!(w)?;
+        writeln!(
+            w,
+            "- If protocol is {}, {}.",
+            behavior.applicable_protocols, behavior.behavior
+        )?;
+
+        if let Some(flags) = &behavior.protocol_flags {
+            writeln!(
+                w,
+                "\n- If protocol is {} and flags {} are set, the behavior shall be modified accordingly.",
+                behavior.applicable_protocols, flags
+            )?;
+        }
+
+        Ok(())
+    }
+
+    fn end_protocol_behaviors(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_addr_families(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nAddress Family Behavior:")
+    }
+
+    fn addr_family(&mut self, w: &mut dyn Write, family: &AddrFamilySpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        writeln!(
+            w,
+            "- If address family is {} ({}), the address structure size shall be {} bytes.",
+            family.family, family.family_name, family.addr_struct_size
+        )?;
+
+        writeln!(
+            w,
+            "\n- If address family is {} and address length is less than {} or greater than {}, the operation shall fail.",
+            family.family, family.min_addr_len, family.max_addr_len
+        )?;
+
+        Ok(())
+    }
+
+    fn end_addr_families(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn buffer_spec(&mut self, w: &mut dyn Write, spec: &BufferSpec) -> std::io::Result<()> {
+        writeln!(w, "\nBuffer Behavior:")?;
+        writeln!(w)?;
+
+        if let Some(min) = spec.min_buffer_size {
+            writeln!(
+                w,
+                "- If the buffer size is less than {} bytes, the operation shall fail.",
+                min
+            )?;
+        }
+
+        if let Some(max) = spec.max_buffer_size {
+            writeln!(
+                w,
+                "\n- If the buffer size exceeds {} bytes, the excess data shall be truncated.",
+                max
+            )?;
+        }
+
+        if let Some(behaviors) = &spec.buffer_behaviors {
+            writeln!(
+                w,
+                "\n- When handling buffers, the following behavior shall apply: {}.",
+                behaviors
+            )?;
+        }
+
+        Ok(())
+    }
+
+    fn async_spec(&mut self, w: &mut dyn Write, spec: &AsyncSpec) -> std::io::Result<()> {
+        writeln!(w, "\nAsynchronous Behavior:")?;
+        writeln!(w)?;
+
+        if let Some(_modes) = &spec.supported_modes {
+            writeln!(
+                w,
+                "- If O_NONBLOCK is set and the operation would block, the function shall return -EAGAIN or -EWOULDBLOCK."
+            )?;
+        }
+
+        if let Some(errno) = spec.nonblock_errno {
+            writeln!(
+                w,
+                "\n- If the file descriptor is in non-blocking mode and no data is available, the function shall return -{}.",
+                errno
+            )?;
+        }
+
+        Ok(())
+    }
+
+    fn net_data_transfer(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "\nData Transfer Behavior:")?;
+        writeln!(w)?;
+        writeln!(
+            w,
+            "- When transferring data, the operation shall {}.",
+            desc.trim_end_matches('.')
+        )
+    }
+
+    fn begin_capabilities(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nCapability Requirements:")
+    }
+
+    fn capability(&mut self, w: &mut dyn Write, cap: &CapabilitySpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        writeln!(
+            w,
+            "- If the process attempts to {}, {} capability shall be checked.",
+            cap.action, cap.name
+        )?;
+        writeln!(w)?;
+        writeln!(w, "- If {} is present, {}.", cap.name, cap.allows)?;
+        writeln!(w)?;
+        writeln!(w, "- If {} is not present, {}.", cap.name, cap.without_cap)?;
+
+        Ok(())
+    }
+
+    fn end_capabilities(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_signals(&mut self, w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nSignal Behavior:")?;
+        Ok(())
+    }
+
+    fn signal(&mut self, w: &mut dyn Write, signal: &SignalSpec) -> std::io::Result<()> {
+        writeln!(w)?;
+
+        // Skip signals with no meaningful description
+        if let Some(desc) = &signal.description {
+            if !desc.is_empty() {
+                writeln!(w, "- {}: {}.", signal.signal_name, desc)?;
+                return Ok(());
+            }
+        }
+
+        // Default behavior based on direction
+        if signal.direction == 1 {
+            // Sends
+            writeln!(
+                w,
+                "- If the conditions for {} are met, the signal shall be sent to the target process.",
+                signal.signal_name
+            )?;
+        } else if signal.direction == 2 {
+            // Receives
+            writeln!(
+                w,
+                "- If {} is received and not blocked, the operation shall be interrupted.",
+                signal.signal_name
+            )?;
+
+            if signal.restartable {
+                writeln!(
+                    w,
+                    "\n- If {} is received and SA_RESTART is set, the operation shall be automatically restarted.",
+                    signal.signal_name
+                )?;
+            }
+        } else {
+            // Direction 0 or other - just note the signal handling
+            writeln!(
+                w,
+                "- {} shall be handled according to its default behavior.",
+                signal.signal_name
+            )?;
+        }
+
+        if let Some(errno) = signal.error_on_signal {
+            if errno != 0 {
+                writeln!(
+                    w,
+                    "\n- If interrupted by {}, the function shall return -{}.",
+                    signal.signal_name, errno
+                )?;
+            }
+        }
+
+        Ok(())
+    }
+
+    fn end_signals(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_signal_masks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        writeln!(w, "\n### Signal Mask Requirements")?;
+        if count > 0 {
+            writeln!(
+                w,
+                "The API SHALL support the following signal mask operations:"
+            )?;
+        }
+        Ok(())
+    }
+
+    fn signal_mask(&mut self, w: &mut dyn Write, mask: &SignalMaskSpec) -> std::io::Result<()> {
+        writeln!(w, "\n- **{}**: {}", mask.name, mask.description)?;
+        Ok(())
+    }
+
+    fn end_signal_masks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_side_effects(&mut self, w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nSide Effects:")?;
+        Ok(())
+    }
+
+    fn side_effect(&mut self, w: &mut dyn Write, effect: &SideEffectSpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        if let Some(condition) = &effect.condition {
+            writeln!(
+                w,
+                "- If {}, {} shall be {}.",
+                condition,
+                effect.target,
+                effect.description.trim_end_matches('.')
+            )?;
+        } else {
+            writeln!(
+                w,
+                "- When the operation executes, {} shall be {}.",
+                effect.target,
+                effect.description.trim_end_matches('.')
+            )?;
+        }
+
+        if effect.reversible {
+            writeln!(
+                w,
+                "\n- If the operation is rolled back, the effect on {} shall be reversed.",
+                effect.target
+            )?;
+        }
+
+        Ok(())
+    }
+
+    fn end_side_effects(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_state_transitions(&mut self, w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nState Transitions:")?;
+        Ok(())
+    }
+
+    fn state_transition(
+        &mut self,
+        w: &mut dyn Write,
+        trans: &StateTransitionSpec,
+    ) -> std::io::Result<()> {
+        writeln!(w)?;
+        if let Some(condition) = &trans.condition {
+            writeln!(
+                w,
+                "- If {} is in {} state and {}, it shall transition to {} state.",
+                trans.object, trans.from_state, condition, trans.to_state
+            )?;
+        } else {
+            writeln!(
+                w,
+                "- If {} is in {} state, it shall transition to {} state.",
+                trans.object, trans.from_state, trans.to_state
+            )?;
+        }
+
+        Ok(())
+    }
+
+    fn end_state_transitions(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_constraints(&mut self, w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nConstraints:")?;
+        Ok(())
+    }
+
+    fn constraint(
+        &mut self,
+        w: &mut dyn Write,
+        constraint: &ConstraintSpec,
+    ) -> std::io::Result<()> {
+        writeln!(w)?;
+        if let Some(expr) = &constraint.expression {
+            if expr.is_empty() {
+                writeln!(w, "- {}: {}.", constraint.name, constraint.description)?;
+            } else {
+                writeln!(
+                    w,
+                    "- If {} is violated, the operation shall fail.",
+                    constraint.name
+                )?;
+                writeln!(w, "  Constraint: {}", expr)?;
+            }
+        } else {
+            writeln!(w, "- {}: {}.", constraint.name, constraint.description)?;
+        }
+
+        Ok(())
+    }
+
+    fn end_constraints(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_locks(&mut self, w: &mut dyn Write, _count: u32) -> std::io::Result<()> {
+        writeln!(w, "\nLocking Behavior:")?;
+        Ok(())
+    }
+
+    fn lock(&mut self, w: &mut dyn Write, lock: &LockSpec) -> std::io::Result<()> {
+        writeln!(w)?;
+
+        // Always show lock information if we have a description
+        if !lock.description.is_empty() {
+            let lock_type_str = match lock.lock_type {
+                1 => "mutex",
+                2 => "spinlock",
+                3 => "rwlock",
+                4 => "semaphore",
+                5 => "RCU",
+                _ => "lock",
+            };
+            writeln!(
+                w,
+                "- The {} {} shall be used for: {}",
+                lock.lock_name, lock_type_str, lock.description
+            )?;
+        }
+
+        if lock.held_on_entry {
+            writeln!(
+                w,
+                "- If {} is not held on entry, the operation shall fail.",
+                lock.lock_name
+            )?;
+        }
+
+        if lock.acquired && !lock.held_on_entry {
+            writeln!(
+                w,
+                "- Before accessing the protected resource, {} shall be acquired.",
+                lock.lock_name
+            )?;
+        }
+
+        if lock.released && lock.held_on_exit {
+            writeln!(
+                w,
+                "- If the operation succeeds and no error path is taken, {} shall remain held on exit.",
+                lock.lock_name
+            )?;
+        } else if lock.released {
+            writeln!(
+                w,
+                "- Before returning, {} shall be released.",
+                lock.lock_name
+            )?;
+        }
+
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
+    fn struct_spec(&mut self, w: &mut dyn Write, spec: &crate::extractor::StructSpec) -> std::io::Result<()> {
+        writeln!(w, "[STRUCT_SPEC] The system SHALL define a structure '{}' with the following properties:", spec.name)?;
+
+        if !spec.description.is_empty() {
+            writeln!(w, "  [DESCRIPTION] {}", spec.description)?;
+        }
+
+        writeln!(w, "  [SIZE] The structure SHALL have a size of {} bytes", spec.size)?;
+        writeln!(w, "  [ALIGNMENT] The structure SHALL have an alignment of {} bytes", spec.alignment)?;
+
+        if !spec.fields.is_empty() {
+            writeln!(w, "  [FIELDS] The structure SHALL contain {} fields:", spec.field_count)?;
+            for field in &spec.fields {
+                writeln!(w, "    - Field '{}' of type '{}': {}",
+                    field.name, field.type_name, field.description)?;
+
+                if field.min_value != 0 || field.max_value != 0 {
+                    writeln!(w, "      [RANGE] SHALL be in range [{}, {}]",
+                        field.min_value, field.max_value)?;
+                }
+            }
+        }
+
+        writeln!(w)?;
+        Ok(())
+    }
+
+    fn end_struct_specs(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+}
diff --git a/tools/kapi/src/main.rs b/tools/kapi/src/main.rs
new file mode 100644
index 000000000000..2d219046f328
--- /dev/null
+++ b/tools/kapi/src/main.rs
@@ -0,0 +1,116 @@
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
+    let extractor: Box<dyn ApiExtractor> = match (args.vmlinux, args.source, args.debugfs.clone()) {
+        (Some(vmlinux_path), None, None) => Box::new(VmlinuxExtractor::new(&vmlinux_path)?),
+        (None, Some(source_path), None) => Box::new(SourceExtractor::new(&source_path)?),
+        (None, None, Some(_) | None) => {
+            // If debugfs is specified or no input is provided, use debugfs
+            Box::new(DebugfsExtractor::new(args.debugfs)?)
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
+        } else if output_format == OutputFormat::Plain {
+            writeln!(stdout, "\nAPI '{}' not found.", api_name_req)?;
+            writeln!(stdout, "\nAvailable APIs:")?;
+            for spec in extractor.extract_all()? {
+                writeln!(stdout, "  {} ({})", spec.name, spec.api_type)?;
+            }
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
2.50.1


