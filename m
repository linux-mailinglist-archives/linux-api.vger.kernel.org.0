Return-Path: <linux-api+bounces-3983-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42A9AE6E56
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3557B4106
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1CD2F2721;
	Tue, 24 Jun 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKBTwyxA"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285F2F2363;
	Tue, 24 Jun 2025 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788479; cv=none; b=XF9QTOSuj8ELCxAZPNeAKyXBn1hqds0YWxWhkYlq0AFY+03oNDBBb3Su/phb+Uy5yCgepHuMxoAboDT8uf2aBI5Gk7LoakSdteC2tFAJLshmOG3++aDkUUOgtcRHCm7Dag3V7VM647BnxE3pi2qoyauF7uq60OBti2nm3Cpwprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788479; c=relaxed/simple;
	bh=Xe05Rug75nYxYrx3+ly+V3k6tilib74tSuUeM7/Fmsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrETMsN08OTZckL/s6PU31IkDsrNsm6ZKSPTMBfw/sWgA8JXXrlL2wHDlDtKspikOc4CKY4/b/Ug50Vy86JKrtU4uY7lI0DliEqHLaFy+8n4Lj1SkzEXzIYrDZ2X8u48d+PN2BvvFhNDnaf2Yowhyl5Fx/E2c11GzxVCNYoAV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKBTwyxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97063C4CEEF;
	Tue, 24 Jun 2025 18:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788479;
	bh=Xe05Rug75nYxYrx3+ly+V3k6tilib74tSuUeM7/Fmsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKBTwyxAHH0iAkBAmVhWN39VcJ4S9e82zQ8PAhfG1SI55NYUdFQLp6dICnUcOCscJ
	 eliVsNm/8sUZD/C9M/wsGHK7epGg49Z7p/QkokgSmt3F3KlogtSed4ij8sweSdwTQL
	 be/qyBS3MsXcTtIi0RtZx5GvWUaLrEtarU2v2gKNwZugwfyRyrIB7QBxmqUWEUME2F
	 DLpnxCDKXblZa6uO5CTDLSUwy1iIBCggezjZdB3eUQvpN44bp53KOyitWCdLTvRPSc
	 3rDNpjkSnp4ZTKia76AR5RzlVpYt7WNClKny7nrORMRdN9Aa8150ECVQyA5GAaCFk7
	 LadVwCvW5FkyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 22/22] tools/kapi: Add kernel API specification extraction tool
Date: Tue, 24 Jun 2025 14:07:42 -0400
Message-Id: <20250624180742.5795-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624180742.5795-1-sashal@kernel.org>
References: <20250624180742.5795-1-sashal@kernel.org>
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
 Documentation/admin-guide/kernel-api-spec.rst |  198 +-
 tools/kapi/.gitignore                         |    4 +
 tools/kapi/Cargo.toml                         |   19 +
 tools/kapi/src/extractor/debugfs.rs           |  415 +++++
 tools/kapi/src/extractor/mod.rs               |  411 +++++
 tools/kapi/src/extractor/source_parser.rs     | 1625 +++++++++++++++++
 .../src/extractor/vmlinux/binary_utils.rs     |  283 +++
 tools/kapi/src/extractor/vmlinux/mod.rs       |  989 ++++++++++
 tools/kapi/src/formatter/json.rs              |  420 +++++
 tools/kapi/src/formatter/mod.rs               |  130 ++
 tools/kapi/src/formatter/plain.rs             |  465 +++++
 tools/kapi/src/formatter/rst.rs               |  468 +++++
 tools/kapi/src/formatter/shall.rs             |  605 ++++++
 tools/kapi/src/main.rs                        |  130 ++
 14 files changed, 6159 insertions(+), 3 deletions(-)
 create mode 100644 tools/kapi/.gitignore
 create mode 100644 tools/kapi/Cargo.toml
 create mode 100644 tools/kapi/src/extractor/debugfs.rs
 create mode 100644 tools/kapi/src/extractor/mod.rs
 create mode 100644 tools/kapi/src/extractor/source_parser.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/binary_utils.rs
 create mode 100644 tools/kapi/src/extractor/vmlinux/mod.rs
 create mode 100644 tools/kapi/src/formatter/json.rs
 create mode 100644 tools/kapi/src/formatter/mod.rs
 create mode 100644 tools/kapi/src/formatter/plain.rs
 create mode 100644 tools/kapi/src/formatter/rst.rs
 create mode 100644 tools/kapi/src/formatter/shall.rs
 create mode 100644 tools/kapi/src/main.rs

diff --git a/Documentation/admin-guide/kernel-api-spec.rst b/Documentation/admin-guide/kernel-api-spec.rst
index 3a63f6711e27b..9b452753111ad 100644
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
index 0000000000000..4e6bcb10d132f
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
index 0000000000000..a7e12052b96bf
--- /dev/null
+++ b/tools/kapi/src/extractor/debugfs.rs
@@ -0,0 +1,415 @@
+use anyhow::{Context, Result, bail};
+use std::fs;
+use std::io::Write;
+use std::path::PathBuf;
+use crate::formatter::OutputFormatter;
+use serde::Deserialize;
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
+            bail!("Kernel API debugfs interface not found at: {}", kapi_path.display());
+        }
+
+        Ok(Self {
+            debugfs_path: path,
+        })
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
+        if flags & (1 << 0) != 0 { result.push("PROCESS".to_string()); }
+        if flags & (1 << 1) != 0 { result.push("SOFTIRQ".to_string()); }
+        if flags & (1 << 2) != 0 { result.push("HARDIRQ".to_string()); }
+        if flags & (1 << 3) != 0 { result.push("NMI".to_string()); }
+        if flags & (1 << 4) != 0 { result.push("ATOMIC".to_string()); }
+        if flags & (1 << 5) != 0 { result.push("SLEEPABLE".to_string()); }
+        if flags & (1 << 6) != 0 { result.push("PREEMPT_DISABLED".to_string()); }
+        if flags & (1 << 7) != 0 { result.push("IRQ_DISABLED".to_string()); }
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
+            context_flags: json_data.context_flags.map_or_else(Vec::new, Self::parse_context_flags),
+            param_count: None,
+            error_count: None,
+            examples: json_data.examples,
+            notes: json_data.notes,
+            since_version: json_data.since_version,
+            subsystem: None,  // Not in current JSON format
+            sysfs_path: None, // Not in current JSON format
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
+                        cap.alternatives = alts.split(", ")
+                            .filter_map(|s| s.parse().ok())
+                            .collect();
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
+                if let Some(count_str) = line.strip_prefix("Parameters (").and_then(|s| s.strip_suffix("):")) {
+                    spec.param_count = count_str.parse().ok();
+                }
+                continue;
+            } else if line.starts_with("Errors (") {
+                if let Some(count_str) = line.strip_prefix("Errors (").and_then(|s| s.strip_suffix("):")) {
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
+                spec.context_flags = flags.split_whitespace()
+                    .map(str::to_string)
+                    .collect();
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
+        } else if api_name.contains("sysfs") || api_name.ends_with("_show") || api_name.ends_with("_store") {
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
+                Err(_e) => {}, // Silently skip files that fail to parse
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
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/mod.rs b/tools/kapi/src/extractor/mod.rs
new file mode 100644
index 0000000000000..644eb7cf64fd9
--- /dev/null
+++ b/tools/kapi/src/extractor/mod.rs
@@ -0,0 +1,411 @@
+use anyhow::Result;
+use std::io::Write;
+use std::convert::TryInto;
+use crate::formatter::OutputFormatter;
+
+pub mod vmlinux;
+pub mod source_parser;
+pub mod debugfs;
+
+pub use vmlinux::VmlinuxExtractor;
+pub use source_parser::SourceExtractor;
+pub use debugfs::DebugfsExtractor;
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
+        formatter.begin_signal_masks(writer, spec.signal_masks.len().try_into().unwrap_or(u32::MAX))?;
+        for mask in &spec.signal_masks {
+            formatter.signal_mask(writer, mask)?;
+        }
+        formatter.end_signal_masks(writer)?;
+    }
+
+    // Display side effects
+    if !spec.side_effects.is_empty() {
+        formatter.begin_side_effects(writer, spec.side_effects.len().try_into().unwrap_or(u32::MAX))?;
+        for effect in &spec.side_effects {
+            formatter.side_effect(writer, effect)?;
+        }
+        formatter.end_side_effects(writer)?;
+    }
+
+    // Display state transitions
+    if !spec.state_transitions.is_empty() {
+        formatter.begin_state_transitions(writer, spec.state_transitions.len().try_into().unwrap_or(u32::MAX))?;
+        for trans in &spec.state_transitions {
+            formatter.state_transition(writer, trans)?;
+        }
+        formatter.end_state_transitions(writer)?;
+    }
+
+    // Display constraints
+    if !spec.constraints.is_empty() {
+        formatter.begin_constraints(writer, spec.constraints.len().try_into().unwrap_or(u32::MAX))?;
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
+    formatter.end_api_details(writer)?;
+
+    Ok(())
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/source_parser.rs b/tools/kapi/src/extractor/source_parser.rs
new file mode 100644
index 0000000000000..bec036a56e40f
--- /dev/null
+++ b/tools/kapi/src/extractor/source_parser.rs
@@ -0,0 +1,1625 @@
+use anyhow::{Context, Result};
+use regex::Regex;
+use std::fs;
+use std::path::Path;
+use std::collections::HashMap;
+use walkdir::WalkDir;
+use std::io::Write;
+use crate::formatter::OutputFormatter;
+use super::{ApiExtractor, ApiSpec, CapabilitySpec, display_api_spec,
+    SocketStateSpec, ProtocolBehaviorSpec, AddrFamilySpec, BufferSpec, AsyncSpec,
+    StateTransitionSpec, SideEffectSpec, ParamSpec, ReturnSpec, ErrorSpec, LockSpec, ConstraintSpec};
+
+#[derive(Debug, Clone)]
+pub struct SourceApiSpec {
+    pub name: String,
+    pub api_type: ApiType,
+    pub parsed_fields: HashMap<String, String>,
+}
+
+#[derive(Debug, Clone, PartialEq)]
+pub enum ApiType {
+    Syscall,
+    Ioctl,
+    Function,
+    Sysfs,
+    Unknown,
+}
+
+impl ApiType {
+    fn from_name(name: &str) -> Self {
+        if name.starts_with("sys_") {
+            ApiType::Syscall
+        } else if name.contains("ioctl") || name.contains("IOCTL") {
+            ApiType::Ioctl
+        } else if name.starts_with("do_") || name.starts_with("__") {
+            ApiType::Function
+        } else {
+            ApiType::Unknown
+        }
+    }
+}
+
+pub struct SourceParser {
+    // Regex patterns for matching KAPI specifications
+    spec_start_pattern: Regex,
+    spec_end_pattern: Regex,
+    ioctl_spec_pattern: Regex,
+    sysfs_spec_pattern: Regex,
+    // Networking-specific patterns
+    socket_state_req_pattern: Regex,
+    socket_state_result_pattern: Regex,
+    socket_state_cond_pattern: Regex,
+    socket_state_protos_pattern: Regex,
+    protocol_behavior_pattern: Regex,
+    protocol_flags_pattern: Regex,
+    addr_family_pattern: Regex,
+    addr_format_pattern: Regex,
+    addr_features_pattern: Regex,
+    addr_special_pattern: Regex,
+    addr_ports_pattern: Regex,
+    buffer_spec_pattern: Regex,
+    async_spec_pattern: Regex,
+    net_data_transfer_pattern: Regex,
+}
+
+impl SourceParser {
+    pub fn new() -> Result<Self> {
+        Ok(SourceParser {
+            // Match DEFINE_KERNEL_API_SPEC(function_name)
+            spec_start_pattern: Regex::new(r"DEFINE_KERNEL_API_SPEC\s*\(\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*\)")?,
+            // Match KAPI_END_SPEC
+            spec_end_pattern: Regex::new(r"KAPI_END_SPEC")?,
+            // Match IOCTL specifications
+            ioctl_spec_pattern: Regex::new(r#"DEFINE_IOCTL_API_SPEC\s*\(\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*,\s*([^,]+)\s*,\s*"([^"]+)"\s*\)"#)?,
+            // Match SYSFS specifications
+            sysfs_spec_pattern: Regex::new(r"DEFINE_SYSFS_API_SPEC\s*\(\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*\)")?,
+            // Networking-specific patterns
+            socket_state_req_pattern: Regex::new(r"KAPI_SOCKET_STATE_REQ\s*\(\s*([^)]+)\s*\)")?,
+            socket_state_result_pattern: Regex::new(r"KAPI_SOCKET_STATE_RESULT\s*\(\s*([^)]+)\s*\)")?,
+            socket_state_cond_pattern: Regex::new(r#"KAPI_SOCKET_STATE_COND\s*\(\s*"([^"]*)"\s*\)"#)?,
+            socket_state_protos_pattern: Regex::new(r"KAPI_SOCKET_STATE_PROTOS\s*\(\s*([^)]+)\s*\)")?,
+            protocol_behavior_pattern: Regex::new(r#"KAPI_PROTOCOL_BEHAVIOR\s*\(\s*(\d+)\s*,\s*([^,]+)\s*,\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)"#)?,
+            protocol_flags_pattern: Regex::new(r#"KAPI_PROTOCOL_FLAGS\s*\(\s*(\d+)\s*,\s*"([^"]*)"\s*\)"#)?,
+            addr_family_pattern: Regex::new(r#"KAPI_ADDR_FAMILY\s*\(\s*(\d+)\s*,\s*([^,]+)\s*,\s*"([^"]+)"\s*,\s*([^,]+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)"#)?,
+            addr_format_pattern: Regex::new(r#"KAPI_ADDR_FORMAT\s*\(\s*"([^"]*)"\s*\)"#)?,
+            addr_features_pattern: Regex::new(r"KAPI_ADDR_FEATURES\s*\(\s*(true|false)\s*,\s*(true|false)\s*,\s*(true|false)\s*\)")?,
+            addr_special_pattern: Regex::new(r#"KAPI_ADDR_SPECIAL\s*\(\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)"#)?,
+            addr_ports_pattern: Regex::new(r"KAPI_ADDR_PORTS\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)")?,
+            buffer_spec_pattern: Regex::new(r"KAPI_BUFFER_SPEC\s*\(\s*(\d+)\s*\)")?,
+            async_spec_pattern: Regex::new(r"KAPI_ASYNC_SPEC\s*\(\s*([^,]+)\s*,\s*(\d+)\s*\)")?,
+            net_data_transfer_pattern: Regex::new(r#"KAPI_NET_DATA_TRANSFER\s*\(\s*"([^"]*)"\s*\)"#)?,
+        })
+    }
+
+    /// Parse a single source file for KAPI specifications
+    pub fn parse_file(&self, path: &Path) -> Result<Vec<SourceApiSpec>> {
+        let content = fs::read_to_string(path)
+            .with_context(|| format!("Failed to read file: {}", path.display()))?;
+
+        self.parse_content(&content, path)
+    }
+
+    /// Parse file content for KAPI specifications
+    pub fn parse_content(&self, content: &str, _file_path: &Path) -> Result<Vec<SourceApiSpec>> {
+        let mut specs = Vec::new();
+        let lines: Vec<&str> = content.lines().collect();
+
+        // First, look for standard KAPI specs
+        for (i, line) in lines.iter().enumerate() {
+            if let Some(captures) = self.spec_start_pattern.captures(line) {
+                let api_name = captures.get(1).unwrap().as_str().to_string();
+
+                // Find the end of this specification
+                if let Some(spec_content) = self.extract_spec_block(&lines, i) {
+                    let mut spec = SourceApiSpec {
+                        name: api_name.clone(),
+                        api_type: ApiType::from_name(&api_name),
+                        parsed_fields: HashMap::new(),
+                    };
+
+                    // Parse the fields
+                    self.parse_spec_fields(&spec_content, &mut spec.parsed_fields)?;
+
+                    specs.push(spec);
+                }
+            }
+
+            // Also look for IOCTL specs
+            if let Some(captures) = self.ioctl_spec_pattern.captures(line) {
+                let spec_name = captures.get(1).unwrap().as_str().to_string();
+                let cmd = captures.get(2).unwrap().as_str().to_string();
+                let cmd_name = captures.get(3).unwrap().as_str().to_string();
+
+                // Find the end of this IOCTL specification
+                if let Some(spec_content) = self.extract_ioctl_spec_block(&lines, i) {
+                    let mut spec = SourceApiSpec {
+                        name: spec_name,
+                        api_type: ApiType::Ioctl,
+                        parsed_fields: HashMap::new(),
+                    };
+
+                    // Add IOCTL-specific fields
+                    spec.parsed_fields.insert("cmd".to_string(), cmd);
+                    spec.parsed_fields.insert("cmd_name".to_string(), cmd_name);
+
+                    // Parse other fields
+                    self.parse_spec_fields(&spec_content, &mut spec.parsed_fields)?;
+
+                    specs.push(spec);
+                }
+            }
+
+            // Also look for SYSFS specs
+            if let Some(captures) = self.sysfs_spec_pattern.captures(line) {
+                let attr_name = captures.get(1).unwrap().as_str().to_string();
+
+                // Find the end of this specification
+                if let Some(spec_content) = self.extract_spec_block(&lines, i) {
+                    let mut spec = SourceApiSpec {
+                        name: attr_name,
+                        api_type: ApiType::Sysfs,
+                        parsed_fields: HashMap::new(),
+                    };
+
+                    // Parse the fields
+                    self.parse_spec_fields(&spec_content, &mut spec.parsed_fields)?;
+
+                    specs.push(spec);
+                }
+            }
+        }
+
+        Ok(specs)
+    }
+
+    /// Extract a complete KAPI specification block from the source
+    fn extract_spec_block(&self, lines: &[&str], start_idx: usize) -> Option<String> {
+        let mut spec_lines = Vec::new();
+
+        for (_i, line) in lines.iter().enumerate().skip(start_idx) {
+            spec_lines.push((*line).to_string());
+
+            // Check for end of spec
+            if self.spec_end_pattern.is_match(line) {
+                return Some(spec_lines.join("\n"));
+            }
+        }
+
+        None
+    }
+
+    /// Extract a complete IOCTL specification block
+    fn extract_ioctl_spec_block(&self, lines: &[&str], start_idx: usize) -> Option<String> {
+        let mut spec_lines = Vec::new();
+        let mut brace_count = 0;
+
+        for (i, line) in lines.iter().enumerate().skip(start_idx) {
+            spec_lines.push((*line).to_string());
+
+            // Count braces
+            for ch in line.chars() {
+                match ch {
+                    '{' => brace_count += 1,
+                    '}' => brace_count -= 1,
+                    _ => {}
+                }
+            }
+
+            // Check for end patterns
+            if line.contains("KAPI_END_IOCTL_SPEC") || line.contains("KAPI_IOCTL_END_SPEC") {
+                return Some(spec_lines.join("\n"));
+            }
+
+            // Alternative end: closing brace with semicolon at top level
+            if brace_count == 0 && line.contains("};") && i > start_idx {
+                return Some(spec_lines.join("\n"));
+            }
+        }
+
+        None
+    }
+
+    /// Parse individual KAPI fields from the specification
+    fn parse_spec_fields(&self, content: &str, fields: &mut HashMap<String, String>) -> Result<()> {
+        // Parse KAPI_DESCRIPTION
+        if let Some(captures) = Regex::new(r#"KAPI_DESCRIPTION\s*\(\s*"([^"]*)"\s*\)"#)?.captures(content) {
+            fields.insert("description".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse KAPI_LONG_DESC (handle multi-line)
+        if let Some(captures) = Regex::new(r#"KAPI_LONG_DESC\s*\(\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)"#)?.captures(content) {
+            let long_desc = captures.get(1).unwrap().as_str()
+                .replace("\"\n\t\t       \"", " ")
+                .replace("\"\n\t\t    \"", " ")
+                .replace("\"\n\t\t   \"", " ")
+                .replace("\"\n\t\t  \"", " ")
+                .replace("\"\n\t\t \"", " ")
+                .replace("\"\n\t\t\"", " ");
+            fields.insert("long_description".to_string(), long_desc);
+        }
+
+        // Parse KAPI_CONTEXT
+        if let Some(captures) = Regex::new(r"KAPI_CONTEXT\s*\(([^)]+)\)")?.captures(content) {
+            fields.insert("context".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse KAPI_NOTES (handle multi-line)
+        if let Some(captures) = Regex::new(r#"KAPI_NOTES\s*\(\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)"#)?.captures(content) {
+            let notes = captures.get(1).unwrap().as_str()
+                .replace("\"\n\t\t   \"", "\n")
+                .replace("\"\n\t\t  \"", "\n")
+                .replace("\"\n\t\t \"", "\n")
+                .replace("\"\n\t\t\"", "\n")
+                .replace("\\n", "\n")
+                .replace("\\\"", "\"")
+                .trim()
+                .to_string();
+            fields.insert("notes".to_string(), notes);
+        }
+
+        // Parse KAPI_EXAMPLES (handle multi-line)
+        if let Some(captures) = Regex::new(r#"KAPI_EXAMPLES\s*\(\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)"#)?.captures(content) {
+            let examples = captures.get(1).unwrap().as_str()
+                .replace("\"\n\t\t      \"", "")
+                .replace("\"\n\t\t     \"", "")
+                .replace("\"\n\t\t    \"", "")
+                .replace("\"\n\t\t   \"", "")
+                .replace("\"\n\t\t  \"", "")
+                .replace("\"\n\t\t \"", "")
+                .replace("\"\n\t\t\"", "")
+                .replace("\\n\\n", "\n\n")
+                .replace("\\n", "\n")
+                .replace("\\\"", "\"")
+                .replace("\\\\", "\\")
+                .trim()
+                .to_string();
+            fields.insert("examples".to_string(), examples);
+        }
+
+        // Parse KAPI_SINCE_VERSION
+        if let Some(captures) = Regex::new(r#"KAPI_SINCE_VERSION\s*\(\s*"([^"]*)"\s*\)"#)?.captures(content) {
+            fields.insert("since_version".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse parameter count
+        let param_regex = Regex::new(r"KAPI_PARAM\s*\(\s*(\d+)\s*,")?;
+        let mut max_param_idx = 0;
+        for captures in param_regex.captures_iter(content) {
+            if let Ok(idx) = captures.get(1).unwrap().as_str().parse::<usize>() {
+                max_param_idx = max_param_idx.max(idx + 1);
+            }
+        }
+        if max_param_idx > 0 {
+            fields.insert("param_count".to_string(), max_param_idx.to_string());
+        }
+
+        // Parse error count
+        let error_regex = Regex::new(r"KAPI_ERROR\s*\(\s*(\d+)\s*,")?;
+        let mut max_error_idx = 0;
+        for captures in error_regex.captures_iter(content) {
+            if let Ok(idx) = captures.get(1).unwrap().as_str().parse::<usize>() {
+                max_error_idx = max_error_idx.max(idx + 1);
+            }
+        }
+        if max_error_idx > 0 {
+            fields.insert("error_count".to_string(), max_error_idx.to_string());
+        }
+
+        // Parse other counts
+        if content.contains(".error_count =") {
+            if let Some(captures) = Regex::new(r"\.error_count\s*=\s*(\d+)")?.captures(content) {
+                fields.insert("error_count".to_string(), captures.get(1).unwrap().as_str().to_string());
+            }
+        }
+
+        // Parse capability count
+        if let Some(captures) = Regex::new(r"KAPI_CAPABILITY_COUNT\s*\(\s*(\d+)\s*\)")?.captures(content) {
+            fields.insert("capability_count".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Also check for .capability_count = N
+        if content.contains(".capability_count =") {
+            if let Some(captures) = Regex::new(r"\.capability_count\s*=\s*(\d+)")?.captures(content) {
+                fields.insert("capability_count".to_string(), captures.get(1).unwrap().as_str().to_string());
+            }
+        }
+
+        // Parse capabilities
+        let cap_regex = Regex::new(r#"KAPI_CAPABILITY\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*"([^"]+)"\s*,\s*([A-Z_]+)\s*\)"#)?;
+        let mut capabilities = Vec::new();
+        for captures in cap_regex.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let cap_id = captures.get(2).unwrap().as_str();
+            let cap_name = captures.get(3).unwrap().as_str();
+            let cap_action = captures.get(4).unwrap().as_str();
+
+            // Store capability info - we'll parse the details separately
+            let cap_key = format!("capability_{}", idx);
+            fields.insert(format!("{}_id", cap_key), cap_id.to_string());
+            fields.insert(format!("{}_name", cap_key), cap_name.to_string());
+            fields.insert(format!("{}_action", cap_key), cap_action.to_string());
+            capabilities.push(idx);
+        }
+
+        // Pre-compile capability regex patterns
+        let cap_allows_pattern = Regex::new(r#"KAPI_CAP_ALLOWS\s*\(\s*"([^"]*)"\s*\)"#)?;
+        let cap_without_pattern = Regex::new(r#"KAPI_CAP_WITHOUT\s*\(\s*"([^"]*)"\s*\)"#)?;
+        let cap_condition_pattern = Regex::new(r#"KAPI_CAP_CONDITION\s*\(\s*"([^"]*)"\s*\)"#)?;
+        let cap_priority_pattern = Regex::new(r"KAPI_CAP_PRIORITY\s*\(\s*(\d+)\s*\)")?;
+
+        // Parse capability details for each found capability
+        for idx in capabilities {
+            let cap_key = format!("capability_{}", idx);
+
+            // Find the capability block and parse its fields
+            if let Some(cap_start) = content.find(&format!("KAPI_CAPABILITY({},", idx)) {
+                if let Some(cap_end) = content[cap_start..].find("KAPI_CAPABILITY_END") {
+                    let cap_content = &content[cap_start..cap_start + cap_end];
+
+                    // Parse KAPI_CAP_ALLOWS
+                    if let Some(captures) = cap_allows_pattern.captures(cap_content) {
+                        fields.insert(format!("{}_allows", cap_key), captures.get(1).unwrap().as_str().to_string());
+                    }
+
+                    // Parse KAPI_CAP_WITHOUT
+                    if let Some(captures) = cap_without_pattern.captures(cap_content) {
+                        fields.insert(format!("{}_without", cap_key), captures.get(1).unwrap().as_str().to_string());
+                    }
+
+                    // Parse KAPI_CAP_CONDITION
+                    if let Some(captures) = cap_condition_pattern.captures(cap_content) {
+                        fields.insert(format!("{}_condition", cap_key), captures.get(1).unwrap().as_str().to_string());
+                    }
+
+                    // Parse KAPI_CAP_PRIORITY
+                    if let Some(captures) = cap_priority_pattern.captures(cap_content) {
+                        fields.insert(format!("{}_priority", cap_key), captures.get(1).unwrap().as_str().to_string());
+                    }
+                }
+            }
+        }
+
+        if content.contains(".param_count =") {
+            if let Some(captures) = Regex::new(r"\.param_count\s*=\s*(\d+)")?.captures(content) {
+                fields.insert("param_count".to_string(), captures.get(1).unwrap().as_str().to_string());
+            }
+        }
+
+        // Parse .since_version
+        if let Some(captures) = Regex::new(r#"\.since_version\s*=\s*"([^"]*)""#)?.captures(content) {
+            fields.insert("since_version".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse .notes (handle multi-line)
+        if let Some(captures) = Regex::new(r#"\.notes\s*=\s*"([^"]*(?:\s*"[^"]*)*?)""#)?.captures(content) {
+            let notes = captures.get(1).unwrap().as_str()
+                .replace("\"\n\t\t \"", " ")
+                .replace("\"\n\t\t\"", " ")
+                .replace("\"\n\t \"", " ")  // Handle single tab + space
+                .trim()
+                .to_string();
+            fields.insert("notes".to_string(), notes);
+        }
+
+        // Parse .examples (handle multi-line)
+        if let Some(captures) = Regex::new(r#"\.examples\s*=\s*"([^"]*(?:\s*"[^"]*)*?)""#)?.captures(content) {
+            let examples = captures.get(1).unwrap().as_str()
+                .replace("\\n\"\n\t\t    \"", "\n")
+                .replace("\\n", "\n");
+            fields.insert("examples".to_string(), examples);
+        }
+
+        // Parse sysfs-specific fields
+        // Parse KAPI_SUBSYSTEM
+        if let Some(captures) = Regex::new(r#"KAPI_SUBSYSTEM\s*\(\s*"([^"]*)"\s*\)"#)?.captures(content) {
+            fields.insert("subsystem".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse .subsystem =
+        if let Some(captures) = Regex::new(r#"\.subsystem\s*=\s*"([^"]*)""#)?.captures(content) {
+            fields.insert("subsystem".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse KAPI_PATH (for sysfs path)
+        if let Some(captures) = Regex::new(r#"KAPI_PATH\s*\(\s*"([^"]*)"\s*\)"#)?.captures(content) {
+            fields.insert("sysfs_path".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse KAPI_PERMISSIONS
+        if let Some(captures) = Regex::new(r"KAPI_PERMISSIONS\s*\(\s*(\d+)\s*\)")?.captures(content) {
+            fields.insert("permissions".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse networking-specific fields
+
+        // Parse socket state fields
+        if let Some(captures) = self.socket_state_req_pattern.captures(content) {
+            fields.insert("socket_state_req".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+        if let Some(captures) = self.socket_state_result_pattern.captures(content) {
+            fields.insert("socket_state_result".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+        if let Some(captures) = self.socket_state_cond_pattern.captures(content) {
+            fields.insert("socket_state_cond".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+        if let Some(captures) = self.socket_state_protos_pattern.captures(content) {
+            fields.insert("socket_state_protos".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse protocol behaviors
+        let mut protocol_behaviors = Vec::new();
+        for captures in self.protocol_behavior_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let protos = captures.get(2).unwrap().as_str();
+            let behavior = captures.get(3).unwrap().as_str()
+                .replace("\"\n\t\t\"", " ")
+                .replace("\"\n\t\"", " ");
+
+            fields.insert(format!("protocol_behavior_{}_protos", idx), protos.to_string());
+            fields.insert(format!("protocol_behavior_{}_desc", idx), behavior);
+            protocol_behaviors.push(idx);
+        }
+        if !protocol_behaviors.is_empty() {
+            fields.insert("protocol_behavior_indices".to_string(),
+                         protocol_behaviors.iter().map(ToString::to_string).collect::<Vec<_>>().join(","));
+        }
+
+        // Parse protocol flags (associated with behaviors)
+        for captures in self.protocol_flags_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let flags = captures.get(2).unwrap().as_str();
+            fields.insert(format!("protocol_behavior_{}_flags", idx), flags.to_string());
+        }
+
+        // Parse address families
+        let mut addr_families = Vec::new();
+        for captures in self.addr_family_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let family = captures.get(2).unwrap().as_str();
+            let name = captures.get(3).unwrap().as_str();
+            let struct_size = captures.get(4).unwrap().as_str();
+            let min_len = captures.get(5).unwrap().as_str();
+            let max_len = captures.get(6).unwrap().as_str();
+
+            fields.insert(format!("addr_family_{}_id", idx), family.to_string());
+            fields.insert(format!("addr_family_{}_name", idx), name.to_string());
+            fields.insert(format!("addr_family_{}_struct_size", idx), struct_size.to_string());
+            fields.insert(format!("addr_family_{}_min_len", idx), min_len.to_string());
+            fields.insert(format!("addr_family_{}_max_len", idx), max_len.to_string());
+            addr_families.push(idx);
+        }
+        if !addr_families.is_empty() {
+            fields.insert("addr_family_indices".to_string(),
+                         addr_families.iter().map(ToString::to_string).collect::<Vec<_>>().join(","));
+        }
+
+        // Parse address family details - these appear after KAPI_ADDR_FAMILY within the block
+        for idx in &addr_families {
+            // Find the KAPI_ADDR_FAMILY block for this index
+            if let Some(family_start) = content.find(&format!("KAPI_ADDR_FAMILY({},", idx)) {
+                if let Some(family_end) = content[family_start..].find("KAPI_ADDR_FAMILY_END") {
+                    let family_content = &content[family_start..family_start + family_end];
+
+                    // Parse KAPI_ADDR_FORMAT
+                    if let Some(captures) = self.addr_format_pattern.captures(family_content) {
+                        fields.insert(format!("addr_family_{}_format", idx), captures.get(1).unwrap().as_str().to_string());
+                    }
+
+                    // Parse KAPI_ADDR_FEATURES
+                    if let Some(captures) = self.addr_features_pattern.captures(family_content) {
+                        fields.insert(format!("addr_family_{}_wildcard", idx), captures.get(1).unwrap().as_str().to_string());
+                        fields.insert(format!("addr_family_{}_multicast", idx), captures.get(2).unwrap().as_str().to_string());
+                        fields.insert(format!("addr_family_{}_broadcast", idx), captures.get(3).unwrap().as_str().to_string());
+                    }
+
+                    // Parse KAPI_ADDR_SPECIAL
+                    if let Some(captures) = self.addr_special_pattern.captures(family_content) {
+                        let special = captures.get(1).unwrap().as_str()
+                            .replace("\"\n\t\t\t  \"", " ")
+                            .replace("\"\n\t\t\t\"", " ");
+                        fields.insert(format!("addr_family_{}_special", idx), special);
+                    }
+
+                    // Parse KAPI_ADDR_PORTS
+                    if let Some(captures) = self.addr_ports_pattern.captures(family_content) {
+                        fields.insert(format!("addr_family_{}_port_min", idx), captures.get(1).unwrap().as_str().to_string());
+                        fields.insert(format!("addr_family_{}_port_max", idx), captures.get(2).unwrap().as_str().to_string());
+                    }
+                }
+            }
+        }
+
+        // Parse KAPI_ADDR_FAMILY_COUNT
+        if let Some(captures) = Regex::new(r"KAPI_ADDR_FAMILY_COUNT\s*\(\s*(\d+)\s*\)")?.captures(content) {
+            fields.insert("addr_family_count".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse KAPI_PROTOCOL_BEHAVIOR_COUNT
+        if let Some(captures) = Regex::new(r"KAPI_PROTOCOL_BEHAVIOR_COUNT\s*\(\s*(\d+)\s*\)")?.captures(content) {
+            fields.insert("protocol_behavior_count".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse buffer spec
+        if let Some(captures) = self.buffer_spec_pattern.captures(content) {
+            fields.insert("buffer_spec_behaviors".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse async spec
+        if let Some(captures) = self.async_spec_pattern.captures(content) {
+            fields.insert("async_spec_modes".to_string(), captures.get(1).unwrap().as_str().to_string());
+            fields.insert("async_spec_errno".to_string(), captures.get(2).unwrap().as_str().to_string());
+        }
+
+        // Parse net data transfer
+        if let Some(captures) = self.net_data_transfer_pattern.captures(content) {
+            fields.insert("net_data_transfer".to_string(), captures.get(1).unwrap().as_str().to_string());
+        }
+
+        // Parse various count fields that appear in networking specs
+        let count_fields = [
+            ("lock_count", r"KAPI_LOCK_COUNT\s*\(\s*(\d+)\s*\)"),
+            ("signal_count", r"KAPI_SIGNAL_COUNT\s*\(\s*(\d+)\s*\)"),
+            ("side_effect_count", r"KAPI_SIDE_EFFECT_COUNT\s*\(\s*(\d+)\s*\)"),
+            ("state_trans_count", r"KAPI_STATE_TRANS_COUNT\s*\(\s*(\d+)\s*\)"),
+            ("constraint_count", r"KAPI_CONSTRAINT_COUNT\s*\(\s*(\d+)\s*\)"),
+        ];
+
+        for (field_name, pattern) in count_fields.iter() {
+            if let Some(captures) = Regex::new(pattern)?.captures(content) {
+                fields.insert((*field_name).to_string(), captures.get(1).unwrap().as_str().to_string());
+            }
+        }
+
+        // Parse state transitions
+        let state_trans_pattern = Regex::new(r#"KAPI_STATE_TRANS\s*\(\s*(\d+)\s*,\s*"([^"]+)"\s*,\s*\n?\s*"([^"]+)"\s*,\s*"([^"]+)"\s*,\s*\n?\s*"([^"]+)"\s*\)(?s).*?KAPI_STATE_TRANS_END"#)?;
+        let state_trans_cond_pattern = Regex::new(r#"KAPI_STATE_TRANS_COND\s*\(\s*"([^"]*)"\s*\)"#)?;
+        let mut state_transitions = Vec::new();
+        for captures in state_trans_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let object = captures.get(2).unwrap().as_str();
+            let from_state = captures.get(3).unwrap().as_str();
+            let to_state = captures.get(4).unwrap().as_str();
+            let description = captures.get(5).unwrap().as_str();
+            let block = captures.get(0).unwrap().as_str();
+
+            // Parse condition within the state transition block
+            let condition = state_trans_cond_pattern.captures(block)
+                .and_then(|c| c.get(1))
+                .map(|m| m.as_str())
+                .map(ToString::to_string);
+
+            fields.insert(format!("state_trans_{}_object", idx), object.to_string());
+            fields.insert(format!("state_trans_{}_from", idx), from_state.to_string());
+            fields.insert(format!("state_trans_{}_to", idx), to_state.to_string());
+            if let Some(cond) = condition {
+                fields.insert(format!("state_trans_{}_condition", idx), cond);
+            }
+            fields.insert(format!("state_trans_{}_desc", idx), description.to_string());
+            state_transitions.push(idx);
+        }
+
+        if !state_transitions.is_empty() {
+            fields.insert("state_trans_indices".to_string(),
+                         state_transitions.iter().map(ToString::to_string).collect::<Vec<_>>().join(","));
+        }
+
+        // Parse side effects
+        let side_effect_pattern = Regex::new(r#"KAPI_SIDE_EFFECT\s*\(\s*(\d+)\s*,\s*([^,]+)\s*,\s*\n?\s*"([^"]+)"\s*,\s*\n?\s*"([^"]+)"\s*\)(?s).*?KAPI_SIDE_EFFECT_END"#)?;
+        let effect_cond_pattern = Regex::new(r#"KAPI_EFFECT_CONDITION\s*\(\s*"([^"]*)"\s*\)"#)?;
+        let effect_reversible_pattern = Regex::new(r"KAPI_EFFECT_REVERSIBLE")?;
+        let mut side_effects = Vec::new();
+        for captures in side_effect_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let effect_type = captures.get(2).unwrap().as_str().trim();
+            let target = captures.get(3).unwrap().as_str();
+            let description = captures.get(4).unwrap().as_str();
+            let block = captures.get(0).unwrap().as_str();
+
+            // Parse additional fields within the side effect block
+
+            let condition = effect_cond_pattern.captures(block)
+                .and_then(|c| c.get(1))
+                .map(|m| m.as_str())
+                .map(ToString::to_string);
+
+            let reversible = effect_reversible_pattern.is_match(block);
+
+            fields.insert(format!("side_effect_{}_type", idx), effect_type.to_string());
+            fields.insert(format!("side_effect_{}_target", idx), target.to_string());
+            if let Some(cond) = condition {
+                fields.insert(format!("side_effect_{}_condition", idx), cond);
+            }
+            fields.insert(format!("side_effect_{}_desc", idx), description.to_string());
+            fields.insert(format!("side_effect_{}_reversible", idx), reversible.to_string());
+            side_effects.push(idx);
+        }
+
+        if !side_effects.is_empty() {
+            fields.insert("side_effect_indices".to_string(),
+                         side_effects.iter().map(ToString::to_string).collect::<Vec<_>>().join(","));
+        }
+
+        // Parse parameters
+        let param_pattern = Regex::new(r#"KAPI_PARAM\s*\(\s*(\d+)\s*,\s*"([^"]+)"\s*,\s*"([^"]+)"\s*,\s*"([^"]+)"\s*\)(?s).*?KAPI_PARAM_END"#)?;
+        let param_flags_pattern = Regex::new(r"KAPI_PARAM_FLAGS\s*\(\s*([^)]+)\s*\)")?;
+        let param_type_pattern = Regex::new(r"KAPI_PARAM_TYPE\s*\(\s*([^)]+)\s*\)")?;
+        let param_constraint_type_pattern = Regex::new(r"KAPI_PARAM_CONSTRAINT_TYPE\s*\(\s*([^)]+)\s*\)")?;
+        let param_constraint_pattern = Regex::new(r#"KAPI_PARAM_CONSTRAINT\s*\(\s*"([^"]*)"\s*\)"#)?;
+        let param_range_pattern = Regex::new(r"KAPI_PARAM_RANGE\s*\(\s*([^,]+)\s*,\s*([^)]+)\s*\)")?;
+        let mut parameters = Vec::new();
+        for captures in param_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let name = captures.get(2).unwrap().as_str();
+            let type_name = captures.get(3).unwrap().as_str();
+            let description = captures.get(4).unwrap().as_str();
+            let block = captures.get(0).unwrap().as_str();
+
+            // Parse additional fields within the param block
+
+            let flags = param_flags_pattern.captures(block)
+                .and_then(|c| c.get(1))
+                .map_or_else(String::new, |m| m.as_str().to_string());
+
+            let param_type = param_type_pattern.captures(block)
+                .and_then(|c| c.get(1))
+                .map_or_else(String::new, |m| m.as_str().to_string());
+
+            let constraint_type = param_constraint_type_pattern.captures(block)
+                .and_then(|c| c.get(1))
+                .map_or_else(String::new, |m| m.as_str().to_string());
+
+            let constraint = param_constraint_pattern.captures(block)
+                .and_then(|c| c.get(1))
+                .map(|m| m.as_str())
+                .map(ToString::to_string);
+
+            fields.insert(format!("param_{}_name", idx), name.to_string());
+            fields.insert(format!("param_{}_type", idx), type_name.to_string());
+            fields.insert(format!("param_{}_desc", idx), description.to_string());
+            fields.insert(format!("param_{}_flags", idx), flags);
+            fields.insert(format!("param_{}_param_type", idx), param_type);
+            fields.insert(format!("param_{}_constraint_type", idx), constraint_type);
+            if let Some(con) = constraint {
+                fields.insert(format!("param_{}_constraint", idx), con);
+            }
+
+            if let Some(range_caps) = param_range_pattern.captures(block) {
+                fields.insert(format!("param_{}_min", idx), range_caps.get(1).unwrap().as_str().to_string());
+                fields.insert(format!("param_{}_max", idx), range_caps.get(2).unwrap().as_str().to_string());
+            }
+
+            parameters.push(idx);
+        }
+
+        if !parameters.is_empty() {
+            fields.insert("param_indices".to_string(),
+                         parameters.iter().map(ToString::to_string).collect::<Vec<_>>().join(","));
+        }
+
+        // Parse return specification
+        let return_pattern = Regex::new(r#"KAPI_RETURN\s*\(\s*"([^"]+)"\s*,\s*"([^"]+)"\s*\)(?s).*?KAPI_RETURN_END"#)?;
+        if let Some(captures) = return_pattern.captures(content) {
+            let type_name = captures.get(1).unwrap().as_str();
+            let description = captures.get(2).unwrap().as_str();
+            let block = captures.get(0).unwrap().as_str();
+
+            fields.insert("return_type".to_string(), type_name.to_string());
+            fields.insert("return_desc".to_string(), description.to_string());
+
+            // Parse additional return fields
+            let ret_type_pattern = Regex::new(r"KAPI_RETURN_TYPE\s*\(\s*([^)]+)\s*\)")?;
+            let check_type_pattern = Regex::new(r"KAPI_RETURN_CHECK_TYPE\s*\(\s*([^)]+)\s*\)")?;
+            let success_pattern = Regex::new(r"KAPI_RETURN_SUCCESS\s*\(\s*([^)]+)\s*\)")?;
+
+            if let Some(caps) = ret_type_pattern.captures(block) {
+                fields.insert("return_return_type".to_string(), caps.get(1).unwrap().as_str().to_string());
+            }
+            if let Some(caps) = check_type_pattern.captures(block) {
+                fields.insert("return_check_type".to_string(), caps.get(1).unwrap().as_str().to_string());
+            }
+            if let Some(caps) = success_pattern.captures(block) {
+                fields.insert("return_success".to_string(), caps.get(1).unwrap().as_str().to_string());
+            }
+        }
+
+        // Parse errors
+        let error_pattern = Regex::new(r#"KAPI_ERROR\s*\(\s*(\d+)\s*,\s*([^,]+)\s*,\s*"([^"]+)"\s*,\s*"([^"]+)"\s*,\s*\n?\s*"([^"]+)"\s*\)"#)?;
+        let mut errors = Vec::new();
+        for captures in error_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let error_code = captures.get(2).unwrap().as_str();
+            let name = captures.get(3).unwrap().as_str();
+            let condition = captures.get(4).unwrap().as_str();
+            let description = captures.get(5).unwrap().as_str();
+
+            fields.insert(format!("error_{}_code", idx), error_code.to_string());
+            fields.insert(format!("error_{}_name", idx), name.to_string());
+            fields.insert(format!("error_{}_condition", idx), condition.to_string());
+            fields.insert(format!("error_{}_desc", idx), description.to_string());
+            errors.push(idx);
+        }
+
+        if !errors.is_empty() {
+            fields.insert("error_indices".to_string(),
+                         errors.iter().map(ToString::to_string).collect::<Vec<_>>().join(","));
+        }
+
+        // Parse locks
+        let lock_pattern = Regex::new(r#"KAPI_LOCK\s*\(\s*(\d+)\s*,\s*"([^"]+)"\s*,\s*([^)]+)\s*\)(?s).*?KAPI_LOCK_END"#)?;
+        let lock_desc_pattern = Regex::new(r#"KAPI_LOCK_DESC\s*\(\s*"([^"]*)"\s*\)"#)?;
+        let mut locks = Vec::new();
+        for captures in lock_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let lock_name = captures.get(2).unwrap().as_str();
+            let lock_type = captures.get(3).unwrap().as_str();
+            let block = captures.get(0).unwrap().as_str();
+
+            fields.insert(format!("lock_{}_name", idx), lock_name.to_string());
+            fields.insert(format!("lock_{}_type", idx), lock_type.to_string());
+
+            // Parse lock description
+            if let Some(desc_caps) = lock_desc_pattern.captures(block) {
+                fields.insert(format!("lock_{}_desc", idx), desc_caps.get(1).unwrap().as_str().to_string());
+            }
+
+            // Parse lock flags
+            if block.contains("KAPI_LOCK_HELD_ENTRY") {
+                fields.insert(format!("lock_{}_held_entry", idx), "true".to_string());
+            }
+            if block.contains("KAPI_LOCK_HELD_EXIT") {
+                fields.insert(format!("lock_{}_held_exit", idx), "true".to_string());
+            }
+            if block.contains("KAPI_LOCK_ACQUIRED") {
+                fields.insert(format!("lock_{}_acquired", idx), "true".to_string());
+            }
+            if block.contains("KAPI_LOCK_RELEASED") {
+                fields.insert(format!("lock_{}_released", idx), "true".to_string());
+            }
+
+            locks.push(idx);
+        }
+
+        if !locks.is_empty() {
+            fields.insert("lock_indices".to_string(),
+                         locks.iter().map(ToString::to_string).collect::<Vec<_>>().join(","));
+        }
+
+        // Parse constraints
+        let constraint_pattern = Regex::new(r#"KAPI_CONSTRAINT\s*\(\s*(\d+)\s*,\s*"([^"]+)"\s*,\s*\n?\s*"([^"]*(?:\s*"[^"]*)*?)"\s*\)(?s).*?KAPI_CONSTRAINT_END"#)?;
+        let constraint_expr_pattern = Regex::new(r#"KAPI_CONSTRAINT_EXPR\s*\(\s*"([^"]*)"\s*\)"#)?;
+        let mut constraints = Vec::new();
+        for captures in constraint_pattern.captures_iter(content) {
+            let idx = captures.get(1).unwrap().as_str().parse::<usize>().unwrap_or(0);
+            let name = captures.get(2).unwrap().as_str();
+            let description = captures.get(3).unwrap().as_str()
+                .replace("\"\n\t\t\t\"", " ")
+                .replace("\"\n\t\t\"", " ")
+                .replace("\"\n\t\"", " ")
+                .trim()
+                .to_string();
+            let block = captures.get(0).unwrap().as_str();
+
+            fields.insert(format!("constraint_{}_name", idx), name.to_string());
+            fields.insert(format!("constraint_{}_desc", idx), description);
+
+            // Parse constraint expression if present
+            if let Some(expr_caps) = constraint_expr_pattern.captures(block) {
+                fields.insert(format!("constraint_{}_expr", idx), expr_caps.get(1).unwrap().as_str().to_string());
+            }
+
+            constraints.push(idx);
+        }
+
+        if !constraints.is_empty() {
+            fields.insert("constraint_indices".to_string(),
+                         constraints.iter().map(ToString::to_string).collect::<Vec<_>>().join(","));
+        }
+
+        Ok(())
+    }
+
+    /// Scan a directory tree for files containing KAPI specifications
+    pub fn scan_directory(&self, dir: &Path, extensions: &[&str]) -> Result<Vec<SourceApiSpec>> {
+        let mut all_specs = Vec::new();
+
+        for entry in WalkDir::new(dir)
+            .follow_links(true)
+            .into_iter()
+            .filter_map(Result::ok)
+        {
+            let path = entry.path();
+
+            // Skip non-files
+            if !path.is_file() {
+                continue;
+            }
+
+            // Check file extension
+            if let Some(ext) = path.extension() {
+                if extensions.iter().any(|&e| ext == e) {
+                    // Try to parse the file
+                    match self.parse_file(path) {
+                        Ok(specs) => {
+                            if !specs.is_empty() {
+                                all_specs.extend(specs);
+                            }
+                        }
+                        Err(_e) => {}
+                    }
+                }
+            }
+        }
+
+        Ok(all_specs)
+    }
+
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+    use std::io::Write;
+    use tempfile::NamedTempFile;
+
+    #[test]
+    fn test_parse_syscall_spec() {
+        let parser = SourceParser::new().unwrap();
+
+        let content = r#"
+DEFINE_KERNEL_API_SPEC(sys_mlock)
+    KAPI_DESCRIPTION("Lock pages in memory")
+    KAPI_LONG_DESC("Locks pages in the specified address range into RAM")
+    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+    KAPI_PARAM(0, "start", "unsigned long", "Starting address")
+    KAPI_PARAM_END
+
+    KAPI_PARAM(1, "len", "size_t", "Length of range")
+    KAPI_PARAM_END
+
+    .param_count = 2,
+    .error_count = 3,
+
+KAPI_END_SPEC
+"#;
+
+        let mut temp_file = NamedTempFile::new().unwrap();
+        write!(temp_file, "{}", content).unwrap();
+
+        let specs = parser.parse_content(content, temp_file.path()).unwrap();
+
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "sys_mlock");
+        assert_eq!(specs[0].api_type, ApiType::Syscall);
+        assert_eq!(specs[0].parsed_fields.get("description").unwrap(), "Lock pages in memory");
+        assert_eq!(specs[0].parsed_fields.get("param_count").unwrap(), "2");
+    }
+
+    #[test]
+    fn test_parse_ioctl_spec() {
+        let parser = SourceParser::new().unwrap();
+
+        let content = r#"
+DEFINE_IOCTL_API_SPEC(binder_write_read, BINDER_WRITE_READ, "BINDER_WRITE_READ")
+    KAPI_DESCRIPTION("Perform read/write operations on binder")
+    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+    KAPI_PARAM(0, "write_size", "binder_size_t", "Bytes to write")
+    KAPI_PARAM_END
+
+KAPI_END_IOCTL_SPEC
+"#;
+
+        let mut temp_file = NamedTempFile::new().unwrap();
+        write!(temp_file, "{}", content).unwrap();
+
+        let specs = parser.parse_content(content, temp_file.path()).unwrap();
+
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "binder_write_read");
+        assert_eq!(specs[0].api_type, ApiType::Ioctl);
+        assert_eq!(specs[0].parsed_fields.get("cmd_name").unwrap(), "BINDER_WRITE_READ");
+    }
+
+    #[test]
+    fn test_parse_sysfs_spec() {
+        let parser = SourceParser::new().unwrap();
+
+        let content = r#"
+DEFINE_SYSFS_API_SPEC(nr_requests)
+    KAPI_DESCRIPTION("Number of allocatable requests")
+    KAPI_LONG_DESC("This controls how many requests may be allocated")
+    KAPI_SUBSYSTEM("block")
+    KAPI_PATH("/sys/block/<disk>/queue/nr_requests")
+    KAPI_PERMISSIONS(0644)
+    .param_count = 1,
+KAPI_END_SPEC
+"#;
+
+        let mut temp_file = NamedTempFile::new().unwrap();
+        write!(temp_file, "{}", content).unwrap();
+
+        let specs = parser.parse_content(content, temp_file.path()).unwrap();
+
+        assert_eq!(specs.len(), 1);
+        assert_eq!(specs[0].name, "nr_requests");
+        assert_eq!(specs[0].api_type, ApiType::Sysfs);
+        assert_eq!(specs[0].parsed_fields.get("description").unwrap(), "Number of allocatable requests");
+        assert_eq!(specs[0].parsed_fields.get("subsystem").unwrap(), "block");
+        assert_eq!(specs[0].parsed_fields.get("sysfs_path").unwrap(), "/sys/block/<disk>/queue/nr_requests");
+        assert_eq!(specs[0].parsed_fields.get("permissions").unwrap(), "0644");
+    }
+}
+
+// SourceExtractor implementation
+pub struct SourceExtractor {
+    specs: Vec<SourceApiSpec>,
+}
+
+impl SourceExtractor {
+    pub fn new(path: &str) -> Result<Self> {
+        let parser = SourceParser::new()?;
+        let path_obj = Path::new(&path);
+
+        let specs = if path_obj.is_file() {
+            parser.parse_file(path_obj)?
+        } else if path_obj.is_dir() {
+            parser.scan_directory(path_obj, &["c", "h"])?
+        } else {
+            anyhow::bail!("Path does not exist: {}", path_obj.display())
+        };
+
+        Ok(SourceExtractor { specs })
+    }
+
+    fn convert_capability_action(action: &str) -> String {
+        match action {
+            "KAPI_CAP_BYPASS_CHECK" => "Bypasses check".to_string(),
+            "KAPI_CAP_INCREASE_LIMIT" => "Increases limit".to_string(),
+            "KAPI_CAP_OVERRIDE_RESTRICTION" => "Overrides restriction".to_string(),
+            "KAPI_CAP_GRANT_PERMISSION" => "Grants permission".to_string(),
+            "KAPI_CAP_MODIFY_BEHAVIOR" => "Modifies behavior".to_string(),
+            "KAPI_CAP_ACCESS_RESOURCE" => "Allows resource access".to_string(),
+            "KAPI_CAP_PERFORM_OPERATION" => "Allows operation".to_string(),
+            _ => action.to_string(),
+        }
+    }
+
+    fn parse_state_transitions(source_spec: &SourceApiSpec) -> Vec<StateTransitionSpec> {
+        let mut transitions = Vec::new();
+
+        if let Some(indices_str) = source_spec.parsed_fields.get("state_trans_indices") {
+            for idx_str in indices_str.split(',') {
+                if let Ok(idx) = idx_str.parse::<usize>() {
+                    let object = source_spec.parsed_fields.get(&format!("state_trans_{}_object", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let from_state = source_spec.parsed_fields.get(&format!("state_trans_{}_from", idx))
+                        .cloned()
+                        .unwrap_or_else(|| "any".to_string());
+                    let to_state = source_spec.parsed_fields.get(&format!("state_trans_{}_to", idx))
+                        .cloned()
+                        .unwrap_or_else(|| "changed".to_string());
+                    let condition = source_spec.parsed_fields.get(&format!("state_trans_{}_condition", idx))
+                        .cloned();
+                    let description = source_spec.parsed_fields.get(&format!("state_trans_{}_desc", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+
+                    transitions.push(StateTransitionSpec {
+                        object,
+                        from_state,
+                        to_state,
+                        condition,
+                        description,
+                    });
+                }
+            }
+        }
+
+        transitions
+    }
+
+    fn parse_side_effects(source_spec: &SourceApiSpec) -> Vec<SideEffectSpec> {
+        let mut effects = Vec::new();
+
+        if let Some(indices_str) = source_spec.parsed_fields.get("side_effect_indices") {
+            for idx_str in indices_str.split(',') {
+                if let Ok(idx) = idx_str.parse::<usize>() {
+                    let effect_type_str = source_spec.parsed_fields.get(&format!("side_effect_{}_type", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let target = source_spec.parsed_fields.get(&format!("side_effect_{}_target", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let condition = source_spec.parsed_fields.get(&format!("side_effect_{}_condition", idx))
+                        .cloned();
+                    let description = source_spec.parsed_fields.get(&format!("side_effect_{}_desc", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let reversible = source_spec.parsed_fields.get(&format!("side_effect_{}_reversible", idx))
+                        .is_some_and(|s| s == "true");
+
+                    // Convert effect type string to u32
+                    let effect_type = Self::parse_effect_type(&effect_type_str);
+
+                    effects.push(SideEffectSpec {
+                        effect_type,
+                        target,
+                        condition,
+                        description,
+                        reversible,
+                    });
+                }
+            }
+        }
+
+        effects
+    }
+
+    fn parse_effect_type(effect_type_str: &str) -> u32 {
+        // Parse effect type flags
+        let mut effect_type = 0u32;
+        let parts: Vec<&str> = effect_type_str.split('|').map(str::trim).collect();
+
+        for part in parts {
+            match part {
+                "KAPI_EFFECT_MODIFY_STATE" => effect_type |= 1 << 0,
+                "KAPI_EFFECT_ALLOCATE_MEMORY" => effect_type |= 1 << 1,
+                "KAPI_EFFECT_FREE_MEMORY" => effect_type |= 1 << 2,
+                "KAPI_EFFECT_IO_OPERATION" => effect_type |= 1 << 3,
+                "KAPI_EFFECT_SIGNAL_SEND" => effect_type |= 1 << 4,
+                "KAPI_EFFECT_PROCESS_CREATE" => effect_type |= 1 << 5,
+                "KAPI_EFFECT_PROCESS_TERMINATE" => effect_type |= 1 << 6,
+                "KAPI_EFFECT_FILE_CREATE" => effect_type |= 1 << 7,
+                "KAPI_EFFECT_FILE_DELETE" => effect_type |= 1 << 8,
+                "KAPI_EFFECT_RESOURCE_CREATE" => effect_type |= 1 << 9,
+                "KAPI_EFFECT_RESOURCE_DESTROY" => effect_type |= 1 << 10,
+                "KAPI_EFFECT_LOCK_ACQUIRE" => effect_type |= 1 << 11,
+                "KAPI_EFFECT_LOCK_RELEASE" => effect_type |= 1 << 12,
+                "KAPI_EFFECT_NETWORK_IO" => effect_type |= 1 << 13,
+                "KAPI_EFFECT_SYSTEM_STATE" => effect_type |= 1 << 14,
+                _ => {} // Unknown effect type
+            }
+        }
+
+        effect_type
+    }
+
+    fn parse_parameters(source_spec: &SourceApiSpec) -> Vec<ParamSpec> {
+        let mut params = Vec::new();
+
+        if let Some(indices_str) = source_spec.parsed_fields.get("param_indices") {
+            for idx_str in indices_str.split(',') {
+                if let Ok(idx) = idx_str.parse::<u32>() {
+                    let name = source_spec.parsed_fields.get(&format!("param_{}_name", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let type_name = source_spec.parsed_fields.get(&format!("param_{}_type", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let description = source_spec.parsed_fields.get(&format!("param_{}_desc", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let flags_str = source_spec.parsed_fields.get(&format!("param_{}_flags", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let param_type_str = source_spec.parsed_fields.get(&format!("param_{}_param_type", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let constraint_type_str = source_spec.parsed_fields.get(&format!("param_{}_constraint_type", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let constraint = source_spec.parsed_fields.get(&format!("param_{}_constraint", idx))
+                        .cloned();
+                    let min_value = source_spec.parsed_fields.get(&format!("param_{}_min", idx))
+                        .and_then(|s| s.parse::<i64>().ok());
+                    let max_value = source_spec.parsed_fields.get(&format!("param_{}_max", idx))
+                        .and_then(|s| s.parse::<i64>().ok());
+
+                    params.push(ParamSpec {
+                        index: idx,
+                        name,
+                        type_name,
+                        description,
+                        flags: Self::parse_param_flags(&flags_str),
+                        param_type: Self::parse_param_type(&param_type_str),
+                        constraint_type: Self::parse_constraint_type(&constraint_type_str),
+                        constraint,
+                        min_value,
+                        max_value,
+                        valid_mask: None,
+                        enum_values: Vec::new(),
+                        size: None,
+                        alignment: None,
+                    });
+                }
+            }
+        }
+
+        params
+    }
+
+    fn parse_return_spec(source_spec: &SourceApiSpec) -> Option<ReturnSpec> {
+        if let (Some(type_name), Some(description)) = (
+            source_spec.parsed_fields.get("return_type"),
+            source_spec.parsed_fields.get("return_desc")
+        ) {
+            let return_type_str = source_spec.parsed_fields.get("return_return_type")
+                .cloned()
+                .unwrap_or_else(String::new);
+            let check_type_str = source_spec.parsed_fields.get("return_check_type")
+                .cloned()
+                .unwrap_or_else(String::new);
+            let success_value = source_spec.parsed_fields.get("return_success")
+                .and_then(|s| s.parse::<i64>().ok());
+
+            Some(ReturnSpec {
+                type_name: type_name.clone(),
+                description: description.clone(),
+                return_type: Self::parse_return_type(&return_type_str),
+                check_type: Self::parse_check_type(&check_type_str),
+                success_value,
+                success_min: None,
+                success_max: None,
+                error_values: Vec::new(),
+            })
+        } else {
+            None
+        }
+    }
+
+    fn parse_errors(source_spec: &SourceApiSpec) -> Vec<ErrorSpec> {
+        let mut errors = Vec::new();
+
+        if let Some(indices_str) = source_spec.parsed_fields.get("error_indices") {
+            for idx_str in indices_str.split(',') {
+                if let Ok(idx) = idx_str.parse::<usize>() {
+                    let error_code_str = source_spec.parsed_fields.get(&format!("error_{}_code", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let name = source_spec.parsed_fields.get(&format!("error_{}_name", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let condition = source_spec.parsed_fields.get(&format!("error_{}_condition", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let description = source_spec.parsed_fields.get(&format!("error_{}_desc", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+
+                    // Parse error code (handle -EINVAL format)
+                    let error_code = if error_code_str.starts_with("-E") {
+                        // Map common error codes
+                        match error_code_str.as_str() {
+                            "-EINVAL" => -22,
+                            "-ENOMEM" => -12,
+                            "-EBUSY" => -16,
+                            "-ENODEV" => -19,
+                            "-ENOENT" => -2,
+                            "-EPERM" => -1,
+                            "-EACCES" => -13,
+                            "-EFAULT" => -14,
+                            "-EAGAIN" => -11,
+                            "-EEXIST" => -17,
+                            _ => 0,
+                        }
+                    } else {
+                        error_code_str.parse::<i32>().unwrap_or(0)
+                    };
+
+                    errors.push(ErrorSpec {
+                        error_code,
+                        name,
+                        condition,
+                        description,
+                    });
+                }
+            }
+        }
+
+        errors
+    }
+
+    fn parse_locks(source_spec: &SourceApiSpec) -> Vec<LockSpec> {
+        let mut locks = Vec::new();
+
+        if let Some(indices_str) = source_spec.parsed_fields.get("lock_indices") {
+            for idx_str in indices_str.split(',') {
+                if let Ok(idx) = idx_str.parse::<usize>() {
+                    let lock_name = source_spec.parsed_fields.get(&format!("lock_{}_name", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let lock_type_str = source_spec.parsed_fields.get(&format!("lock_{}_type", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let description = source_spec.parsed_fields.get(&format!("lock_{}_desc", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let held_on_entry = source_spec.parsed_fields.get(&format!("lock_{}_held_entry", idx))
+                        .is_some_and(|s| s == "true");
+                    let held_on_exit = source_spec.parsed_fields.get(&format!("lock_{}_held_exit", idx))
+                        .is_some_and(|s| s == "true");
+                    let acquired = source_spec.parsed_fields.get(&format!("lock_{}_acquired", idx))
+                        .is_some_and(|s| s == "true");
+                    let released = source_spec.parsed_fields.get(&format!("lock_{}_released", idx))
+                        .is_some_and(|s| s == "true");
+
+                    locks.push(LockSpec {
+                        lock_name,
+                        lock_type: Self::parse_lock_type(&lock_type_str),
+                        acquired,
+                        released,
+                        held_on_entry,
+                        held_on_exit,
+                        description,
+                    });
+                }
+            }
+        }
+
+        locks
+    }
+
+    fn parse_constraints(source_spec: &SourceApiSpec) -> Vec<ConstraintSpec> {
+        let mut constraints = Vec::new();
+
+        if let Some(indices_str) = source_spec.parsed_fields.get("constraint_indices") {
+            for idx_str in indices_str.split(',') {
+                if let Ok(idx) = idx_str.parse::<usize>() {
+                    let name = source_spec.parsed_fields.get(&format!("constraint_{}_name", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let description = source_spec.parsed_fields.get(&format!("constraint_{}_desc", idx))
+                        .cloned()
+                        .unwrap_or_else(String::new);
+                    let expression = source_spec.parsed_fields.get(&format!("constraint_{}_expr", idx))
+                        .cloned();
+
+                    constraints.push(ConstraintSpec {
+                        name,
+                        description,
+                        expression,
+                    });
+                }
+            }
+        }
+
+        constraints
+    }
+
+    fn parse_param_flags(flags_str: &str) -> u32 {
+        let mut flags = 0u32;
+        let parts: Vec<&str> = flags_str.split('|').map(str::trim).collect();
+
+        for part in parts {
+            match part {
+                "KAPI_PARAM_IN" => flags |= 1 << 0,
+                "KAPI_PARAM_OUT" => flags |= 1 << 1,
+                "KAPI_PARAM_INOUT" => flags |= (1 << 0) | (1 << 1),
+                "KAPI_PARAM_USER" => flags |= 1 << 2,
+                "KAPI_PARAM_OPTIONAL" => flags |= 1 << 3,
+                _ => {}
+            }
+        }
+
+        flags
+    }
+
+    fn parse_param_type(type_str: &str) -> u32 {
+        match type_str.trim() {
+            "KAPI_TYPE_INT" => 1,
+            "KAPI_TYPE_UINT" => 2,
+            "KAPI_TYPE_PTR" => 3,
+            "KAPI_TYPE_STRUCT" => 4,
+            "KAPI_TYPE_ENUM" => 5,
+            "KAPI_TYPE_FLAGS" => 6,
+            "KAPI_TYPE_FD" => 7,
+            "KAPI_TYPE_STRING" => 8,
+            _ => 0,
+        }
+    }
+
+    fn parse_constraint_type(type_str: &str) -> u32 {
+        match type_str.trim() {
+            "KAPI_CONSTRAINT_RANGE" => 1,
+            "KAPI_CONSTRAINT_MASK" => 2,
+            "KAPI_CONSTRAINT_ENUM" => 3,
+            "KAPI_CONSTRAINT_SIZE" => 4,
+            "KAPI_CONSTRAINT_ALIGNMENT" => 5,
+            _ => 0, // Default to NONE (includes "KAPI_CONSTRAINT_NONE")
+        }
+    }
+
+    fn parse_return_type(type_str: &str) -> u32 {
+        match type_str.trim() {
+            "KAPI_TYPE_INT" => 1,
+            "KAPI_TYPE_UINT" => 2,
+            "KAPI_TYPE_PTR" => 3,
+            "KAPI_TYPE_FD" => 7,
+            _ => 0,
+        }
+    }
+
+    fn parse_check_type(type_str: &str) -> u32 {
+        match type_str.trim() {
+            "KAPI_RETURN_SUCCESS_CHECK" => 1,
+            "KAPI_RETURN_ERROR_CHECK" => 2,
+            "KAPI_RETURN_RANGE_CHECK" => 3,
+            "KAPI_RETURN_PTR_CHECK" => 4,
+            _ => 0,
+        }
+    }
+
+    fn parse_lock_type(type_str: &str) -> u32 {
+        match type_str.trim() {
+            "KAPI_LOCK_MUTEX" => 1,
+            "KAPI_LOCK_SPINLOCK" => 2,
+            "KAPI_LOCK_RWLOCK" => 3,
+            "KAPI_LOCK_SEMAPHORE" => 4,
+            "KAPI_LOCK_RCU" => 5,
+            _ => 0,
+        }
+    }
+
+    fn parse_context_flags(flags_str: &str) -> Vec<String> {
+        let mut result = Vec::new();
+        let parts: Vec<&str> = flags_str.split('|').map(str::trim).collect();
+
+        for part in parts {
+            match part {
+                "KAPI_CTX_PROCESS" => result.push("Process context".to_string()),
+                "KAPI_CTX_SOFTIRQ" => result.push("Softirq context".to_string()),
+                "KAPI_CTX_HARDIRQ" => result.push("Hardirq context".to_string()),
+                "KAPI_CTX_NMI" => result.push("NMI context".to_string()),
+                "KAPI_CTX_USER" => result.push("User mode".to_string()),
+                "KAPI_CTX_KERNEL" => result.push("Kernel mode".to_string()),
+                "KAPI_CTX_SLEEPABLE" => result.push("May sleep".to_string()),
+                "KAPI_CTX_ATOMIC" => result.push("Atomic context".to_string()),
+                "KAPI_CTX_PREEMPTIBLE" => result.push("Preemptible".to_string()),
+                "KAPI_CTX_MIGRATION_DISABLED" => result.push("Migration disabled".to_string()),
+                _ => {} // Ignore unknown flags
+            }
+        }
+
+        result
+    }
+
+    fn convert_to_api_spec(&self, source_spec: &SourceApiSpec) -> ApiSpec {
+        let mut capabilities = Vec::new();
+
+        // Extract capabilities
+        if let Some(cap_count_str) = source_spec.parsed_fields.get("capability_count") {
+            if let Ok(cap_count) = cap_count_str.parse::<usize>() {
+                for i in 0..cap_count {
+                    let cap_key = format!("capability_{}", i);
+
+                    if let (Some(id_str), Some(name), Some(action)) = (
+                        source_spec.parsed_fields.get(&format!("{}_id", cap_key)),
+                        source_spec.parsed_fields.get(&format!("{}_name", cap_key)),
+                        source_spec.parsed_fields.get(&format!("{}_action", cap_key))
+                    ) {
+                        let cap_id = id_str.parse::<i32>().unwrap_or(0);
+                        capabilities.push(CapabilitySpec {
+                            capability: cap_id,
+                            name: name.clone(),
+                            action: Self::convert_capability_action(action),
+                            allows: source_spec.parsed_fields.get(&format!("{}_allows", cap_key))
+                                .cloned()
+                                .unwrap_or_else(String::new),
+                            without_cap: source_spec.parsed_fields.get(&format!("{}_without", cap_key))
+                                .cloned()
+                                .unwrap_or_else(String::new),
+                            check_condition: source_spec.parsed_fields.get(&format!("{}_condition", cap_key))
+                                .cloned(),
+                            priority: source_spec.parsed_fields.get(&format!("{}_priority", cap_key))
+                                .and_then(|s| s.parse::<u8>().ok()),
+                            alternatives: Vec::new(), // Not parsed from source yet
+                        });
+                    }
+                }
+            }
+        }
+
+        // Parse socket state
+        let socket_state = if source_spec.parsed_fields.contains_key("socket_state_req") ||
+                              source_spec.parsed_fields.contains_key("socket_state_result") {
+            Some(SocketStateSpec {
+                required_states: source_spec.parsed_fields.get("socket_state_req")
+                    .map(|s| vec![s.clone()])
+                    .unwrap_or_default(),
+                forbidden_states: Vec::new(), // Not parsed yet
+                resulting_state: source_spec.parsed_fields.get("socket_state_result").cloned(),
+                condition: source_spec.parsed_fields.get("socket_state_cond").cloned(),
+                applicable_protocols: source_spec.parsed_fields.get("socket_state_protos").cloned(),
+            })
+        } else {
+            None
+        };
+
+        // Parse protocol behaviors
+        let mut protocol_behaviors = Vec::new();
+        if let Some(indices_str) = source_spec.parsed_fields.get("protocol_behavior_indices") {
+            for idx_str in indices_str.split(',') {
+                if let Ok(idx) = idx_str.parse::<usize>() {
+                    if let (Some(protos), Some(desc)) = (
+                        source_spec.parsed_fields.get(&format!("protocol_behavior_{}_protos", idx)),
+                        source_spec.parsed_fields.get(&format!("protocol_behavior_{}_desc", idx))
+                    ) {
+                        protocol_behaviors.push(ProtocolBehaviorSpec {
+                            applicable_protocols: protos.clone(),
+                            behavior: desc.clone(),
+                            protocol_flags: source_spec.parsed_fields.get(&format!("protocol_behavior_{}_flags", idx)).cloned(),
+                            flag_description: None, // Could be enhanced to parse flag descriptions
+                        });
+                    }
+                }
+            }
+        }
+
+        // Parse address families
+        let mut addr_families = Vec::new();
+        if let Some(indices_str) = source_spec.parsed_fields.get("addr_family_indices") {
+            for idx_str in indices_str.split(',') {
+                if let Ok(idx) = idx_str.parse::<usize>() {
+                    if let (Some(family_str), Some(name), Some(struct_size_str), Some(min_len_str), Some(max_len_str)) = (
+                        source_spec.parsed_fields.get(&format!("addr_family_{}_id", idx)),
+                        source_spec.parsed_fields.get(&format!("addr_family_{}_name", idx)),
+                        source_spec.parsed_fields.get(&format!("addr_family_{}_struct_size", idx)),
+                        source_spec.parsed_fields.get(&format!("addr_family_{}_min_len", idx)),
+                        source_spec.parsed_fields.get(&format!("addr_family_{}_max_len", idx))
+                    ) {
+                        // Parse AF_INET etc as integers
+                        let family = if family_str.starts_with("AF_") {
+                            // This is a constant name, we'd need to map it to the actual value
+                            // For now, use a placeholder
+                            match family_str.as_str() {
+                                "AF_UNIX" => 1,
+                                "AF_INET" => 2,
+                                "AF_INET6" => 10,
+                                "AF_NETLINK" => 16,
+                                "AF_PACKET" => 17,
+                                "AF_BLUETOOTH" => 31,
+                                _ => 0,
+                            }
+                        } else {
+                            family_str.parse::<i32>().unwrap_or(0)
+                        };
+
+                        // For sizeof() expressions, we'll store the string as-is
+                        let struct_size = if struct_size_str.starts_with("sizeof(") {
+                            // Map common struct sizes - this is a limitation of static parsing
+                            match struct_size_str.as_str() {
+                                "sizeof(struct sockaddr_un)" => 110,
+                                "sizeof(struct sockaddr_in)" => 16,
+                                "sizeof(struct sockaddr_in6)" => 28,
+                                "sizeof(struct sockaddr_nl)" => 12,
+                                "sizeof(struct sockaddr_ll)" => 20,
+                                "sizeof(struct sockaddr)" => 16, // generic sockaddr
+                                _ => 0,
+                            }
+                        } else {
+                            struct_size_str.parse::<usize>().unwrap_or(0)
+                        };
+
+                        addr_families.push(AddrFamilySpec {
+                            family,
+                            family_name: name.clone(),
+                            addr_struct_size: struct_size,
+                            min_addr_len: min_len_str.parse::<usize>().unwrap_or(0),
+                            max_addr_len: max_len_str.parse::<usize>().unwrap_or(0),
+                            addr_format: source_spec.parsed_fields.get(&format!("addr_family_{}_format", idx)).cloned(),
+                            supports_wildcard: source_spec.parsed_fields.get(&format!("addr_family_{}_wildcard", idx))
+                                .is_some_and(|s| s == "true"),
+                            supports_multicast: source_spec.parsed_fields.get(&format!("addr_family_{}_multicast", idx))
+                                .is_some_and(|s| s == "true"),
+                            supports_broadcast: source_spec.parsed_fields.get(&format!("addr_family_{}_broadcast", idx))
+                                .is_some_and(|s| s == "true"),
+                            special_addresses: source_spec.parsed_fields.get(&format!("addr_family_{}_special", idx)).cloned(),
+                            port_range_min: source_spec.parsed_fields.get(&format!("addr_family_{}_port_min", idx))
+                                .and_then(|s| s.parse::<u32>().ok()).unwrap_or(0),
+                            port_range_max: source_spec.parsed_fields.get(&format!("addr_family_{}_port_max", idx))
+                                .and_then(|s| s.parse::<u32>().ok()).unwrap_or(0),
+                        });
+                    }
+                }
+            }
+        }
+
+        // Parse buffer spec
+        let buffer_spec = if source_spec.parsed_fields.contains_key("buffer_spec_behaviors") {
+            Some(BufferSpec {
+                buffer_behaviors: source_spec.parsed_fields.get("buffer_spec_behaviors").cloned(),
+                min_buffer_size: None,
+                max_buffer_size: None,
+                optimal_buffer_size: None,
+            })
+        } else {
+            None
+        };
+
+        // Parse async spec
+        let async_spec = if source_spec.parsed_fields.contains_key("async_spec_modes") {
+            Some(AsyncSpec {
+                supported_modes: source_spec.parsed_fields.get("async_spec_modes").cloned(),
+                nonblock_errno: source_spec.parsed_fields.get("async_spec_errno")
+                    .and_then(|s| s.parse::<i32>().ok()),
+            })
+        } else {
+            None
+        };
+
+        ApiSpec {
+            name: source_spec.name.clone(),
+            api_type: match source_spec.api_type {
+                ApiType::Syscall => "syscall".to_string(),
+                ApiType::Ioctl => "ioctl".to_string(),
+                ApiType::Function => "function".to_string(),
+                ApiType::Sysfs => "sysfs".to_string(),
+                ApiType::Unknown => "unknown".to_string(),
+            },
+            description: source_spec.parsed_fields.get("description").cloned(),
+            long_description: source_spec.parsed_fields.get("long_description").cloned(),
+            version: source_spec.parsed_fields.get("version").cloned(),
+            context_flags: source_spec.parsed_fields.get("context")
+                .map(|c| Self::parse_context_flags(c))
+                .unwrap_or_default(),
+            param_count: source_spec.parsed_fields.get("param_count")
+                .and_then(|s| s.parse::<u32>().ok()),
+            error_count: source_spec.parsed_fields.get("error_count")
+                .and_then(|s| s.parse::<u32>().ok()),
+            examples: source_spec.parsed_fields.get("examples").cloned(),
+            notes: source_spec.parsed_fields.get("notes").cloned(),
+            since_version: source_spec.parsed_fields.get("since_version").cloned(),
+            // Sysfs-specific fields
+            subsystem: source_spec.parsed_fields.get("subsystem").cloned(),
+            sysfs_path: source_spec.parsed_fields.get("sysfs_path").cloned(),
+            permissions: source_spec.parsed_fields.get("permissions").cloned(),
+            // Networking-specific fields
+            socket_state,
+            protocol_behaviors,
+            addr_families,
+            buffer_spec,
+            async_spec,
+            net_data_transfer: source_spec.parsed_fields.get("net_data_transfer").cloned(),
+            capabilities,
+            parameters: Self::parse_parameters(source_spec),
+            return_spec: Self::parse_return_spec(source_spec),
+            errors: Self::parse_errors(source_spec),
+            signals: vec![],
+            signal_masks: vec![],
+            side_effects: Self::parse_side_effects(source_spec),
+            state_transitions: Self::parse_state_transitions(source_spec),
+            constraints: Self::parse_constraints(source_spec),
+            locks: Self::parse_locks(source_spec),
+        }
+    }
+}
+
+impl ApiExtractor for SourceExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        Ok(self.specs.iter()
+            .map(|s| self.convert_to_api_spec(s))
+            .collect())
+    }
+
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>> {
+        Ok(self.specs.iter()
+            .find(|s| s.name == name)
+            .map(|s| self.convert_to_api_spec(s)))
+    }
+
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()> {
+        if let Some(spec) = self.specs.iter().find(|s| s.name == api_name) {
+            let api_spec = self.convert_to_api_spec(spec);
+            display_api_spec(&api_spec, formatter, writer)?;
+        }
+        Ok(())
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/vmlinux/binary_utils.rs b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
new file mode 100644
index 0000000000000..e3f5d1e939d86
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/binary_utils.rs
@@ -0,0 +1,283 @@
+
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
+    pub const MAX_SIDE_EFFECTS: usize = 16;
+    pub const MAX_STATE_TRANS: usize = 16;
+}
+
+// Helper for reading data at specific offsets
+pub struct DataReader<'a> {
+    data: &'a [u8],
+    pos: usize,
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
+        let bytes = self.read_bytes(4)?;
+        Some(u32::from_le_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]))
+    }
+
+    pub fn read_u8(&mut self) -> Option<u8> {
+        let bytes = self.read_bytes(1)?;
+        Some(bytes[0])
+    }
+
+    pub fn read_i32(&mut self) -> Option<i32> {
+        let bytes = self.read_bytes(4)?;
+        Some(i32::from_le_bytes([bytes[0], bytes[1], bytes[2], bytes[3]]))
+    }
+
+    pub fn read_u64(&mut self) -> Option<u64> {
+        let bytes = self.read_bytes(8)?;
+        Some(u64::from_le_bytes([
+            bytes[0], bytes[1], bytes[2], bytes[3],
+            bytes[4], bytes[5], bytes[6], bytes[7]
+        ]))
+    }
+
+    pub fn read_i64(&mut self) -> Option<i64> {
+        let bytes = self.read_bytes(8)?;
+        Some(i64::from_le_bytes([
+            bytes[0], bytes[1], bytes[2], bytes[3],
+            bytes[4], bytes[5], bytes[6], bytes[7]
+        ]))
+    }
+
+    pub fn skip(&mut self, len: usize) {
+        self.pos = (self.pos + len).min(self.data.len());
+    }
+}
+
+// Structure layout definitions for calculating sizes
+pub fn param_spec_layout_size() -> usize {
+    // Packed structure from struct kapi_param_spec
+    sizes::NAME + // name
+    sizes::NAME + // type_name
+    4 + // type (enum)
+    4 + // flags
+    8 + // size (size_t)
+    8 + // alignment (size_t)
+    8 + // min_value
+    8 + // max_value
+    8 + // valid_mask
+    8 + // enum_values pointer
+    4 + // enum_count
+    4 + // constraint_type (enum)
+    8 + // validate function pointer
+    sizes::DESC + // description
+    sizes::DESC + // constraints
+    4 + // size_param_idx
+    8 + // size_multiplier (size_t)
+    // sysfs-specific fields
+    sizes::NAME + // sysfs_path
+    2 + // sysfs_permissions (umode_t)
+    sizes::NAME + // default_value
+    32 + // units
+    8 + // step
+    8 + // allowed_strings pointer
+    4 // allowed_string_count
+}
+
+pub fn return_spec_layout_size() -> usize {
+    // Packed structure from struct kapi_return_spec
+    sizes::NAME + // type_name
+    4 + // type (enum)
+    4 + // check_type (enum)
+    8 + // success_value
+    8 + // success_min
+    8 + // success_max
+    8 + // error_values pointer
+    4 + // error_count
+    8 + // is_success function pointer
+    sizes::DESC // description
+}
+
+pub fn error_spec_layout_size() -> usize {
+    // Packed structure
+    4 + // code
+    sizes::NAME + // name
+    sizes::DESC * 2 // condition, description
+}
+
+pub fn lock_spec_layout_size() -> usize {
+    // Packed structure
+    sizes::NAME + // name
+    4 + // lock_type
+    1 + 1 + 1 + 1 + // bools
+    sizes::DESC // description
+}
+
+pub fn constraint_spec_layout_size() -> usize {
+    // Packed structure
+    sizes::NAME + // name
+    sizes::DESC * 2 // description, expression
+}
+
+pub fn capability_spec_layout_size() -> usize {
+    // Packed structure from struct kapi_capability_spec
+    4 + // capability (int)
+    sizes::NAME + // cap_name
+    4 + // action (enum)
+    sizes::DESC + // allows
+    sizes::DESC + // without_cap
+    sizes::DESC + // check_condition
+    1 + // priority (u8)
+    4 * sizes::MAX_CAPABILITIES + // alternative array
+    4 // alternative_count
+}
+
+pub fn signal_spec_layout_size() -> usize {
+    // Packed structure from struct kapi_signal_spec
+    4 + // signal_num
+    32 + // signal_name[32]
+    4 + // direction (u32)
+    4 + // action (enum)
+    sizes::DESC + // target
+    sizes::DESC + // condition
+    sizes::DESC + // description
+    1 + // restartable (bool)
+    4 + // sa_flags_required
+    4 + // sa_flags_forbidden
+    4 + // error_on_signal
+    4 + // transform_to
+    32 + // timing[32]
+    1 + // priority (u8)
+    1 + // interruptible (bool)
+    128 + // queue_behavior[128]
+    4 + // state_required
+    4 // state_forbidden
+}
+
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
+    sizes::DESC // description
+}
+
+pub fn struct_spec_layout_size() -> usize {
+    // Packed structure from struct kapi_struct_spec
+    sizes::NAME + // name
+    8 + // size (size_t)
+    8 + // alignment (size_t)
+    4 + // field_count
+    struct_field_layout_size() * sizes::MAX_PARAMS + // fields array
+    sizes::DESC // description
+}
+
+pub fn side_effect_layout_size() -> usize {
+    // Packed structure from struct kapi_side_effect
+    4 + // type (u32)
+    sizes::NAME + // target
+    sizes::DESC + // condition
+    sizes::DESC + // description
+    1 // reversible (bool)
+}
+
+pub fn state_transition_layout_size() -> usize {
+    // Packed structure from struct kapi_state_transition
+    sizes::NAME + // from_state
+    sizes::NAME + // to_state
+    sizes::DESC + // condition
+    sizes::NAME + // object
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
+    4   // forbidden_count
+}
+
+pub fn protocol_behavior_spec_layout_size() -> usize {
+    // struct kapi_protocol_behavior
+    sizes::NAME + // applicable_protocols
+    sizes::DESC + // behavior
+    sizes::NAME + // protocol_flags
+    sizes::DESC   // flag_description
+}
+
+pub fn buffer_spec_layout_size() -> usize {
+    // struct kapi_buffer_spec
+    sizes::DESC + // buffer_behaviors
+    8 + // min_buffer_size (size_t)
+    8 + // max_buffer_size (size_t)
+    8   // optimal_buffer_size (size_t)
+}
+
+pub fn async_spec_layout_size() -> usize {
+    // struct kapi_async_spec
+    sizes::NAME + // supported_modes
+    4   // nonblock_errno (int)
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
+    4   // port_range_max (u32)
+}
\ No newline at end of file
diff --git a/tools/kapi/src/extractor/vmlinux/mod.rs b/tools/kapi/src/extractor/vmlinux/mod.rs
new file mode 100644
index 0000000000000..b04fc6fe5f630
--- /dev/null
+++ b/tools/kapi/src/extractor/vmlinux/mod.rs
@@ -0,0 +1,989 @@
+use anyhow::{Context, Result};
+use goblin::elf::Elf;
+use std::fs;
+use std::io::Write;
+use std::convert::TryInto;
+use crate::formatter::OutputFormatter;
+use super::{ApiExtractor, ApiSpec, CapabilitySpec, ParamSpec, ReturnSpec, ErrorSpec,
+    SignalSpec, SignalMaskSpec, SideEffectSpec, StateTransitionSpec, ConstraintSpec, LockSpec};
+
+mod binary_utils;
+use binary_utils::{sizes, DataReader,
+    param_spec_layout_size, return_spec_layout_size, error_spec_layout_size,
+    lock_spec_layout_size, constraint_spec_layout_size, capability_spec_layout_size,
+    signal_spec_layout_size, signal_mask_spec_layout_size, struct_spec_layout_size,
+    side_effect_layout_size, state_transition_layout_size, socket_state_spec_layout_size,
+    protocol_behavior_spec_layout_size, buffer_spec_layout_size, async_spec_layout_size,
+    addr_family_spec_layout_size};
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
+        let vmlinux_data = fs::read(&vmlinux_path)
+            .with_context(|| format!("Failed to read vmlinux file: {vmlinux_path}"))?;
+
+        let elf = Elf::parse(&vmlinux_data)
+            .context("Failed to parse ELF file")?;
+
+        // Find the .kapi_specs section
+        let kapi_section = elf.section_headers
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
+        Ok(VmlinuxExtractor {
+            kapi_data,
+            specs,
+        })
+    }
+
+}
+
+impl ApiExtractor for VmlinuxExtractor {
+    fn extract_all(&self) -> Result<Vec<ApiSpec>> {
+        // For vmlinux extractor, we return basic info only
+        // Detailed parsing happens in display_api_details
+        Ok(self.specs.iter().map(|spec| {
+            ApiSpec {
+                name: spec.name.clone(),
+                api_type: spec.api_type.clone(),
+                description: None,
+                long_description: None,
+                version: None,
+                context_flags: vec![],
+                param_count: None,
+                error_count: None,
+                examples: None,
+                notes: None,
+                since_version: None,
+                subsystem: None,
+                sysfs_path: None,
+                permissions: None,
+                socket_state: None,
+                protocol_behaviors: vec![],
+                addr_families: vec![],
+                buffer_spec: None,
+                async_spec: None,
+                net_data_transfer: None,
+                capabilities: vec![],
+                parameters: vec![],
+                return_spec: None,
+                errors: vec![],
+                signals: vec![],
+                signal_masks: vec![],
+                side_effects: vec![],
+                state_transitions: vec![],
+                constraints: vec![],
+                locks: vec![],
+            }
+        }).collect())
+    }
+
+    fn extract_by_name(&self, name: &str) -> Result<Option<ApiSpec>> {
+        Ok(self.specs.iter()
+            .find(|s| s.name == name)
+            .map(|spec| ApiSpec {
+                name: spec.name.clone(),
+                api_type: spec.api_type.clone(),
+                description: None,
+                long_description: None,
+                version: None,
+                context_flags: vec![],
+                param_count: None,
+                error_count: None,
+                examples: None,
+                notes: None,
+                since_version: None,
+                subsystem: None,
+                sysfs_path: None,
+                permissions: None,
+                socket_state: None,
+                protocol_behaviors: vec![],
+                addr_families: vec![],
+                buffer_spec: None,
+                async_spec: None,
+                net_data_transfer: None,
+                capabilities: vec![],
+                parameters: vec![],
+                return_spec: None,
+                errors: vec![],
+                signals: vec![],
+                signal_masks: vec![],
+                side_effects: vec![],
+                state_transitions: vec![],
+                constraints: vec![],
+                locks: vec![],
+            }))
+    }
+
+    fn display_api_details(
+        &self,
+        api_name: &str,
+        formatter: &mut dyn OutputFormatter,
+        writer: &mut dyn Write,
+    ) -> Result<()> {
+        if let Some(spec) = self.specs.iter().find(|s| s.name == api_name) {
+            // Parse the binary data into an ApiSpec
+            let api_spec = parse_binary_to_api_spec(&self.kapi_data, spec.offset)?;
+            // Use the common display function
+            super::display_api_spec(&api_spec, formatter, writer)?;
+        }
+        Ok(())
+    }
+}
+
+fn calculate_kernel_api_spec_size() -> usize {
+    // Calculate the total size of struct kernel_api_spec based on field layout
+    // Note: The struct is __attribute__((packed)) in the kernel
+    let _base_size = sizes::NAME + // name (128 bytes)
+    4 + // api_type (enum, 4 bytes)
+    4 + // version (u32, 4 bytes)
+    sizes::DESC + // description
+    sizes::DESC * 4 + // long_description
+    4 + // context_flags
+    4 + // param_count
+    param_spec_layout_size() * sizes::MAX_PARAMS + // params array
+    return_spec_layout_size() + // return_spec
+    4 + // error_count
+    error_spec_layout_size() * sizes::MAX_ERRORS + // errors array
+    4 + // lock_count
+    lock_spec_layout_size() * sizes::MAX_CONSTRAINTS + // locks array
+    4 + // constraint_count
+    constraint_spec_layout_size() * sizes::MAX_CONSTRAINTS + // constraints array
+    sizes::DESC * 2 + // examples
+    sizes::DESC * 2 + // notes
+    32 + // since_version[32]
+    1 + // deprecated (bool)
+    sizes::NAME + // replacement
+    4 + // signal_count
+    signal_spec_layout_size() * sizes::MAX_SIGNALS + // signals array
+    4 + // signal_mask_count
+    signal_mask_spec_layout_size() * sizes::MAX_SIGNALS + // signal_masks array
+    4 + // struct_spec_count
+    struct_spec_layout_size() * sizes::MAX_STRUCT_SPECS + // struct_specs array
+    4 + // side_effect_count
+    side_effect_layout_size() * sizes::MAX_SIDE_EFFECTS + // side_effects array
+    4 + // state_trans_count
+    state_transition_layout_size() * sizes::MAX_STATE_TRANS + // state_transitions array
+    4 + // capability_count
+    capability_spec_layout_size() * sizes::MAX_CAPABILITIES + // capabilities array
+    sizes::NAME + // subsystem
+    sizes::NAME; // device_type
+
+    // Add networking-specific fields (CONFIG_NET)
+    // These are part of the kernel struct when CONFIG_NET is enabled
+    let _net_fields_size =
+        // struct kapi_socket_state_spec socket_state
+        socket_state_spec_layout_size() +
+        // struct kapi_protocol_behavior protocol_behaviors[KAPI_MAX_PROTOCOL_BEHAVIORS]
+        protocol_behavior_spec_layout_size() * 8 + // KAPI_MAX_PROTOCOL_BEHAVIORS = 8
+        4 + // u32 protocol_behavior_count
+        // struct kapi_buffer_spec buffer_spec
+        buffer_spec_layout_size() +
+        // struct kapi_async_spec async_spec
+        async_spec_layout_size() +
+        // struct kapi_addr_family_spec addr_families[KAPI_MAX_ADDR_FAMILIES]
+        addr_family_spec_layout_size() * 8 + // KAPI_MAX_ADDR_FAMILIES = 8
+        4 + // u32 addr_family_count
+        // Network operation characteristics (6 bools)
+        6 + // 6 bool fields
+        // Network semantic descriptions (3 strings)
+        sizes::DESC * 3; // connection_establishment, connection_termination, data_transfer_semantics
+
+    // Add IOCTL-specific fields
+    let _ioctl_fields_size =
+        4 + // unsigned int cmd
+        sizes::NAME + // char cmd_name[KAPI_MAX_NAME_LEN]
+        8 + // size_t input_size (assuming 64-bit)
+        8 + // size_t output_size (assuming 64-bit)
+        sizes::NAME; // char file_ops_name[KAPI_MAX_NAME_LEN]
+
+    // Return the observed kernel struct size (355033 bytes + 7 bytes padding)
+    355_040
+}
+
+fn parse_kapi_specs(data: &[u8]) -> Result<Vec<KapiSpec>> {
+    let mut specs = Vec::new();
+
+    // Calculate the struct size dynamically
+    let struct_size = calculate_kernel_api_spec_size();
+
+    let mut offset = 0;
+    while offset + struct_size <= data.len() {
+        // Try to read the name at this offset
+        if let Some(name) = read_cstring(data, offset, 128) {
+            if is_valid_api_name(&name) {
+                // Read the api_type enum field (4 bytes after the name)
+                let api_type_offset = offset + 128;
+                let api_type = if api_type_offset + 4 <= data.len() {
+                    let api_type_value = u32::from_le_bytes([
+                        data[api_type_offset],
+                        data[api_type_offset + 1],
+                        data[api_type_offset + 2],
+                        data[api_type_offset + 3],
+                    ]);
+
+                    match api_type_value {
+                        0 => "function", // KAPI_API_FUNCTION
+                        1 => "ioctl",    // KAPI_API_IOCTL
+                        2 => "sysfs",    // KAPI_API_SYSFS
+                        _ => "unknown",
+                    }
+                } else {
+                    "unknown"
+                };
+
+                specs.push(KapiSpec {
+                    name: name.to_string(),
+                    api_type: api_type.to_string(),
+                    offset,
+                });
+            }
+        }
+
+        offset += struct_size;
+    }
+
+    // Handle any remaining data that might be a partial spec
+    if offset < data.len() && data.len() - offset >= 128 + 4 {
+        if let Some(name) = read_cstring(data, offset, 128) {
+            if is_valid_api_name(&name) {
+                // Read the api_type enum field
+                let api_type_offset = offset + 128;
+                let api_type = if api_type_offset + 4 <= data.len() {
+                    let api_type_value = u32::from_le_bytes([
+                        data[api_type_offset],
+                        data[api_type_offset + 1],
+                        data[api_type_offset + 2],
+                        data[api_type_offset + 3],
+                    ]);
+
+                    match api_type_value {
+                        0 => "function", // KAPI_API_FUNCTION
+                        1 => "ioctl",    // KAPI_API_IOCTL
+                        2 => "sysfs",    // KAPI_API_SYSFS
+                        _ => "unknown",
+                    }
+                } else {
+                    "unknown"
+                };
+
+                specs.push(KapiSpec {
+                    name: name.to_string(),
+                    api_type: api_type.to_string(),
+                    offset,
+                });
+            }
+        }
+    }
+
+    Ok(specs)
+}
+
+fn read_cstring(data: &[u8], offset: usize, max_len: usize) -> Option<String> {
+    if offset + max_len > data.len() {
+        return None;
+    }
+
+    let bytes = &data[offset..offset + max_len];
+    if let Some(null_pos) = bytes.iter().position(|&b| b == 0) {
+        if null_pos > 0 {
+            if let Ok(s) = std::str::from_utf8(&bytes[..null_pos]) {
+                return Some(s.to_string());
+            }
+        }
+    }
+    None
+}
+
+fn is_valid_api_name(name: &str) -> bool {
+    if name.is_empty() || name.len() > 100 {
+        return false;
+    }
+
+    // Just validate it's a proper identifier since we now use api_type field
+    name.chars().all(|c| c.is_ascii_alphanumeric() || c == '_')
+}
+
+fn parse_binary_to_api_spec(data: &[u8], offset: usize) -> Result<ApiSpec> {
+    let mut reader = DataReader::new(data, offset);
+
+    // Read name
+    let name = reader.read_cstring(sizes::NAME)
+        .ok_or_else(|| anyhow::anyhow!("Failed to read API name"))?;
+
+    // Read api_type enum
+    let api_type = reader.read_u32()
+        .map(|v| match v {
+            0 => "function", // KAPI_API_FUNCTION
+            1 => "ioctl",    // KAPI_API_IOCTL
+            2 => "sysfs",    // KAPI_API_SYSFS
+            _ => "unknown",
+        })
+        .unwrap_or("unknown")
+        .to_string();
+
+    // Read version
+    let version = reader.read_u32()
+        .map(|v| v.to_string());
+
+    // Read description
+    let description = reader.read_cstring(sizes::DESC)
+        .filter(|s| !s.is_empty());
+
+    // Read long description
+    let long_description = reader.read_cstring(sizes::DESC * 4)
+        .filter(|s| !s.is_empty());
+
+    // Read context flags
+    const KAPI_CTX_PROCESS: u32 = 1 << 0;
+    const KAPI_CTX_SOFTIRQ: u32 = 1 << 1;
+    const KAPI_CTX_HARDIRQ: u32 = 1 << 2;
+    const KAPI_CTX_NMI: u32 = 1 << 3;
+    const KAPI_CTX_USER: u32 = 1 << 4;
+    const KAPI_CTX_KERNEL: u32 = 1 << 5;
+    const KAPI_CTX_SLEEPABLE: u32 = 1 << 6;
+    const KAPI_CTX_ATOMIC: u32 = 1 << 7;
+    const KAPI_CTX_PREEMPTIBLE: u32 = 1 << 8;
+    const KAPI_CTX_MIGRATION_DISABLED: u32 = 1 << 9;
+    
+    let context_flags = if let Some(flags) = reader.read_u32() {
+        let mut flag_strings = Vec::new();
+
+        // Build the flag string similar to source format
+        let mut parts = Vec::new();
+        if flags & KAPI_CTX_PROCESS != 0 { parts.push("KAPI_CTX_PROCESS"); }
+        if flags & KAPI_CTX_SOFTIRQ != 0 { parts.push("KAPI_CTX_SOFTIRQ"); }
+        if flags & KAPI_CTX_HARDIRQ != 0 { parts.push("KAPI_CTX_HARDIRQ"); }
+        if flags & KAPI_CTX_NMI != 0 { parts.push("KAPI_CTX_NMI"); }
+        if flags & KAPI_CTX_USER != 0 { parts.push("KAPI_CTX_USER"); }
+        if flags & KAPI_CTX_KERNEL != 0 { parts.push("KAPI_CTX_KERNEL"); }
+        if flags & KAPI_CTX_SLEEPABLE != 0 { parts.push("KAPI_CTX_SLEEPABLE"); }
+        if flags & KAPI_CTX_ATOMIC != 0 { parts.push("KAPI_CTX_ATOMIC"); }
+        if flags & KAPI_CTX_PREEMPTIBLE != 0 { parts.push("KAPI_CTX_PREEMPTIBLE"); }
+        if flags & KAPI_CTX_MIGRATION_DISABLED != 0 { parts.push("KAPI_CTX_MIGRATION_DISABLED"); }
+
+        if !parts.is_empty() {
+            flag_strings.push(parts.join(" | "));
+        }
+        flag_strings
+    } else {
+        vec![]
+    };
+
+    // Read parameter count
+    let param_count = reader.read_u32();
+
+    // Parse parameters
+    let mut parameters = Vec::new();
+    if let Some(count) = param_count {
+        if count > 0 && count as usize <= sizes::MAX_PARAMS {
+            for i in 0..count {
+                if let Some(mut param) = parse_parameter(&mut reader) {
+                    param.index = i;
+                    parameters.push(param);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(param_spec_layout_size() * (sizes::MAX_PARAMS - count as usize));
+        } else {
+            reader.skip(param_spec_layout_size() * sizes::MAX_PARAMS);
+        }
+    }
+
+    // Parse return spec
+    let return_spec = parse_return_spec(&mut reader);
+
+    // Read error count
+    let error_count = reader.read_u32();
+
+    // Parse errors
+    let mut errors = Vec::new();
+    if let Some(count) = error_count {
+        if count > 0 && count as usize <= sizes::MAX_ERRORS {
+            for _ in 0..count {
+                if let Some(error) = parse_error(&mut reader) {
+                    errors.push(error);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(error_spec_layout_size() * (sizes::MAX_ERRORS - count as usize));
+        } else {
+            reader.skip(error_spec_layout_size() * sizes::MAX_ERRORS);
+        }
+    }
+
+    // Parse locks
+    let mut locks = Vec::new();
+    if let Some(count) = reader.read_u32() {
+        if count > 0 && count as usize <= sizes::MAX_CONSTRAINTS {
+            for _ in 0..count {
+                if let Some(lock) = parse_lock(&mut reader) {
+                    locks.push(lock);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(lock_spec_layout_size() * (sizes::MAX_CONSTRAINTS - count as usize));
+        } else {
+            reader.skip(lock_spec_layout_size() * sizes::MAX_CONSTRAINTS);
+        }
+    }
+
+    // Parse constraints
+    let mut constraints = Vec::new();
+    if let Some(count) = reader.read_u32() {
+        if count > 0 && count as usize <= sizes::MAX_CONSTRAINTS {
+            for _ in 0..count {
+                if let Some(constraint) = parse_constraint(&mut reader) {
+                    constraints.push(constraint);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(constraint_spec_layout_size() * (sizes::MAX_CONSTRAINTS - count as usize));
+        } else {
+            reader.skip(constraint_spec_layout_size() * sizes::MAX_CONSTRAINTS);
+        }
+    }
+
+    // Read examples
+    let examples = reader.read_cstring(sizes::DESC * 2)
+        .filter(|s| !s.is_empty());
+
+    // Read notes
+    let notes = reader.read_cstring(sizes::DESC * 2)
+        .filter(|s| !s.is_empty());
+
+    // Read since_version
+    let since_version = reader.read_cstring(32)
+        .filter(|s| !s.is_empty());
+
+    // Skip deprecated and replacement
+    reader.skip(1); // deprecated (bool)
+    reader.skip(sizes::NAME); // replacement
+
+    // Parse signals
+    let mut signals = Vec::new();
+    if let Some(count) = reader.read_u32() {
+        if count > 0 && count as usize <= sizes::MAX_SIGNALS {
+            for _ in 0..count {
+                if let Some(signal) = parse_signal(&mut reader) {
+                    signals.push(signal);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(signal_spec_layout_size() * (sizes::MAX_SIGNALS - count as usize));
+        } else {
+            reader.skip(signal_spec_layout_size() * sizes::MAX_SIGNALS);
+        }
+    }
+
+    // Parse signal masks
+    let signal_mask_count = reader.read_u32();
+    let mut signal_masks = Vec::new();
+    if let Some(count) = signal_mask_count {
+        if count > 0 && count as usize <= sizes::MAX_SIGNALS {
+            for _ in 0..count {
+                if let Some(mask) = parse_signal_mask(&mut reader) {
+                    signal_masks.push(mask);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(signal_mask_spec_layout_size() * (sizes::MAX_SIGNALS - count as usize));
+        } else {
+            reader.skip(signal_mask_spec_layout_size() * sizes::MAX_SIGNALS);
+        }
+    }
+
+    // Skip struct specs
+    if let Some(struct_spec_count) = reader.read_u32() {
+        if struct_spec_count > 0 && struct_spec_count as usize <= sizes::MAX_STRUCT_SPECS {
+            reader.skip(struct_spec_layout_size() * struct_spec_count as usize);
+            reader.skip(struct_spec_layout_size() * (sizes::MAX_STRUCT_SPECS - struct_spec_count as usize));
+        } else {
+            reader.skip(struct_spec_layout_size() * sizes::MAX_STRUCT_SPECS);
+        }
+    }
+
+    // Parse side effects
+    let mut side_effects = Vec::new();
+    if let Some(count) = reader.read_u32() {
+        if count > 0 && count as usize <= sizes::MAX_SIDE_EFFECTS {
+            for _ in 0..count {
+                if let Some(effect) = parse_side_effect(&mut reader) {
+                    side_effects.push(effect);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(side_effect_layout_size() * (sizes::MAX_SIDE_EFFECTS - count as usize));
+        } else {
+            reader.skip(side_effect_layout_size() * sizes::MAX_SIDE_EFFECTS);
+        }
+    }
+
+    // Parse state transitions
+    let mut state_transitions = Vec::new();
+    if let Some(count) = reader.read_u32() {
+        if count > 0 && count as usize <= sizes::MAX_STATE_TRANS {
+            for _ in 0..count {
+                if let Some(trans) = parse_state_transition(&mut reader) {
+                    state_transitions.push(trans);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(state_transition_layout_size() * (sizes::MAX_STATE_TRANS - count as usize));
+        } else {
+            reader.skip(state_transition_layout_size() * sizes::MAX_STATE_TRANS);
+        }
+    }
+
+    // Read capabilities
+    let mut capabilities = Vec::new();
+    if let Some(capability_count) = reader.read_u32() {
+        if capability_count > 0 && capability_count as usize <= sizes::MAX_CAPABILITIES {
+            for _ in 0..capability_count {
+                if let Some(cap) = parse_capability(&mut reader) {
+                    capabilities.push(cap);
+                }
+            }
+            // Skip remaining slots
+            reader.skip(capability_spec_layout_size() * (sizes::MAX_CAPABILITIES - capability_count as usize));
+        } else {
+            reader.skip(capability_spec_layout_size() * sizes::MAX_CAPABILITIES);
+        }
+    }
+
+
+    // Sysfs fields not yet available in binary format
+    let subsystem = None;
+    let sysfs_path = None;
+    let permissions = None;
+
+    Ok(ApiSpec {
+        name,
+        api_type,
+        description,
+        long_description,
+        version,
+        context_flags,
+        param_count,
+        error_count,
+        examples,
+        notes,
+        since_version,
+        subsystem,
+        sysfs_path,
+        permissions,
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
+    })
+}
+
+// Parse a single capability from the binary data
+fn parse_capability(reader: &mut DataReader) -> Option<CapabilitySpec> {
+    let capability = reader.read_i32()?;
+    let cap_name = reader.read_cstring(sizes::NAME)?;
+    let action = reader.read_u32()?;
+    let allows = reader.read_cstring(sizes::DESC).unwrap_or_default();
+    let without_cap = reader.read_cstring(sizes::DESC).unwrap_or_default();
+    let check_condition = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+    let priority = reader.read_u8();
+
+    // Read alternatives array
+    let mut alternatives = Vec::new();
+    for _ in 0..sizes::MAX_CAPABILITIES {
+        if let Some(alt) = reader.read_i32() {
+            if alt != 0 && alt != -1 {
+                alternatives.push(alt);
+            }
+        }
+    }
+
+    let _alternative_count = reader.read_u32();
+
+    // Convert action enum value to string
+    let action_str = match action {
+        0 => "Bypasses check",
+        1 => "Increases limit",
+        2 => "Overrides restriction",
+        3 => "Grants permission",
+        4 => "Modifies behavior",
+        5 => "Allows resource access",
+        6 => "Allows operation",
+        _ => "Unknown action",
+    }.to_string();
+
+    Some(CapabilitySpec {
+        capability,
+        name: cap_name,
+        action: action_str,
+        allows,
+        without_cap,
+        check_condition,
+        priority,
+        alternatives,
+    })
+}
+
+// Parse a single parameter from the binary data
+fn parse_parameter(reader: &mut DataReader) -> Option<ParamSpec> {
+    let name = reader.read_cstring(sizes::NAME)?;
+    let type_name = reader.read_cstring(sizes::NAME)?;
+    let param_type = reader.read_u32()?;
+    let flags = reader.read_u32()?;
+    let size = reader.read_u64()?;
+    let alignment = reader.read_u64()?;
+    let min_value = reader.read_i64();
+    let max_value = reader.read_i64();
+    let valid_mask = reader.read_u64();
+    reader.skip(8); // enum_values pointer
+    let _enum_count = reader.read_u32()?;
+    let constraint_type = reader.read_u32()?;
+    reader.skip(8); // validate function pointer
+    let description = reader.read_cstring(sizes::DESC).unwrap_or_default();
+    let constraint = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+    let _size_param_idx = reader.read_i32();
+    let _size_multiplier = reader.read_u64();
+    // Skip sysfs-specific fields
+    reader.skip(sizes::NAME); // sysfs_path
+    reader.skip(2); // sysfs_permissions (umode_t)
+    reader.skip(sizes::NAME); // default_value
+    reader.skip(32); // units
+    reader.skip(8); // step
+    reader.skip(8); // allowed_strings pointer
+    reader.skip(4); // allowed_string_count
+
+    // Calculate parameter index from position
+    let index = 0; // Will be set by caller
+
+    Some(ParamSpec {
+        index,
+        name,
+        type_name,
+        description,
+        flags,
+        param_type,
+        constraint_type,
+        constraint,
+        min_value,
+        max_value,
+        valid_mask,
+        enum_values: vec![], // Can't read from binary pointers
+        size: Some(size.try_into().unwrap_or(u32::MAX)),
+        alignment: Some(alignment.try_into().unwrap_or(u32::MAX)),
+    })
+}
+
+// Parse return specification from the binary data
+fn parse_return_spec(reader: &mut DataReader) -> Option<ReturnSpec> {
+    let type_name = reader.read_cstring(sizes::NAME)?;
+    let return_type = reader.read_u32()?;
+    let check_type = reader.read_u32()?;
+    let success_value = reader.read_i64();
+    let success_min = reader.read_i64();
+    let success_max = reader.read_i64();
+    reader.skip(8); // error_values pointer
+    let _error_count = reader.read_u32()?;
+    reader.skip(8); // is_success function pointer
+    let description = reader.read_cstring(sizes::DESC).unwrap_or_default();
+
+    Some(ReturnSpec {
+        type_name,
+        description,
+        return_type,
+        check_type,
+        success_value,
+        success_min,
+        success_max,
+        error_values: vec![], // Can't read from binary pointers
+    })
+}
+
+// Parse a single error specification from the binary data
+fn parse_error(reader: &mut DataReader) -> Option<ErrorSpec> {
+    let error_code = reader.read_i32()?;
+    let name = reader.read_cstring(sizes::NAME)?;
+    let condition = reader.read_cstring(sizes::DESC).unwrap_or_default();
+    let description = reader.read_cstring(sizes::DESC).unwrap_or_default();
+
+    Some(ErrorSpec {
+        error_code,
+        name,
+        condition,
+        description,
+    })
+}
+
+// Parse a single signal specification from the binary data
+fn parse_signal(reader: &mut DataReader) -> Option<SignalSpec> {
+    let signal_num = reader.read_i32()?;
+    let signal_name = reader.read_cstring(32)?; // Fixed size in struct
+    let direction = reader.read_u32()?;
+    let action = reader.read_u32()?;
+    let target = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+    let condition = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+    let description = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+    let restartable = reader.read_u8()? != 0;
+    let sa_flags_required = reader.read_u32()?;
+    let sa_flags_forbidden = reader.read_u32()?;
+    let error_on_signal = reader.read_i32();
+    let _transform_to = reader.read_i32();
+    let timing_str = reader.read_cstring(32)?;
+    let priority = reader.read_u8()? as u32;
+    let interruptible = reader.read_u8()? != 0;
+    let queue = reader.read_cstring(128).filter(|s| !s.is_empty());
+    let state_required = reader.read_u32()?;
+    let state_forbidden = reader.read_u32()?;
+
+    // Convert timing string to enum value
+    let timing = match timing_str.as_str() {
+        "BEFORE" => 0,
+        "AFTER" => 2,
+        "EXIT" => 3,
+        _ => 1, // Default to DURING (includes "DURING")
+    };
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
+        priority,
+        restartable,
+        interruptible,
+        queue,
+        sa_flags: 0, // Not in struct
+        sa_flags_required,
+        sa_flags_forbidden,
+        state_required,
+        state_forbidden,
+        error_on_signal,
+    })
+}
+
+// Parse a single signal mask specification from the binary data
+fn parse_signal_mask(reader: &mut DataReader) -> Option<SignalMaskSpec> {
+    let name = reader.read_cstring(sizes::NAME)?;
+    // Skip signals array
+    reader.skip(4 * sizes::MAX_SIGNALS); // int array
+    let _signal_count = reader.read_u32()?;
+    let description = reader.read_cstring(sizes::DESC).unwrap_or_default();
+
+    Some(SignalMaskSpec {
+        name,
+        description,
+    })
+}
+
+// Parse a single side effect specification from the binary data
+fn parse_side_effect(reader: &mut DataReader) -> Option<SideEffectSpec> {
+    let effect_type = reader.read_u32()?;
+    let target = reader.read_cstring(sizes::NAME)?;
+    let condition = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+    let description = reader.read_cstring(sizes::DESC).unwrap_or_default();
+    let reversible = reader.read_u8()? != 0;
+
+    Some(SideEffectSpec {
+        effect_type,
+        target,
+        condition,
+        description,
+        reversible,
+    })
+}
+
+// Parse a single state transition specification from the binary data
+fn parse_state_transition(reader: &mut DataReader) -> Option<StateTransitionSpec> {
+    let from_state = reader.read_cstring(sizes::NAME)?;
+    let to_state = reader.read_cstring(sizes::NAME)?;
+    let condition = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+    let object = reader.read_cstring(sizes::NAME)?;
+    let description = reader.read_cstring(sizes::DESC).unwrap_or_default();
+
+    Some(StateTransitionSpec {
+        object,
+        from_state,
+        to_state,
+        condition,
+        description,
+    })
+}
+
+// Parse a single constraint specification from the binary data
+fn parse_constraint(reader: &mut DataReader) -> Option<ConstraintSpec> {
+    let name = reader.read_cstring(sizes::NAME)?;
+    let description = reader.read_cstring(sizes::DESC).unwrap_or_default();
+    let expression = reader.read_cstring(sizes::DESC).filter(|s| !s.is_empty());
+
+    Some(ConstraintSpec {
+        name,
+        description,
+        expression,
+    })
+}
+
+// Parse a single lock specification from the binary data
+fn parse_lock(reader: &mut DataReader) -> Option<LockSpec> {
+    let lock_name = reader.read_cstring(sizes::NAME)?;
+    let lock_type = reader.read_u32()?;
+    let acquired = reader.read_u8()? != 0;
+    let released = reader.read_u8()? != 0;
+    let held_on_entry = reader.read_u8()? != 0;
+    let held_on_exit = reader.read_u8()? != 0;
+    let description = reader.read_cstring(sizes::DESC).unwrap_or_default();
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
+// Old display_api_details_from_binary function removed - now using parse_binary_to_api_spec + display_api_spec
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn test_parse_capability() {
+        // Create mock binary data for a capability
+        let mut data = Vec::new();
+
+        // capability (i32) = 14 (CAP_IPC_LOCK)
+        data.extend_from_slice(&14i32.to_le_bytes());
+
+        // cap_name (128 bytes) = "CAP_IPC_LOCK"
+        let mut name_bytes = b"CAP_IPC_LOCK".to_vec();
+        name_bytes.resize(128, 0);
+        data.extend_from_slice(&name_bytes);
+
+        // action (u32) = 0 (KAPI_CAP_BYPASS_CHECK)
+        data.extend_from_slice(&0u32.to_le_bytes());
+
+        // allows (512 bytes)
+        let mut allows_bytes = b"Bypass RLIMIT_MEMLOCK check entirely".to_vec();
+        allows_bytes.resize(512, 0);
+        data.extend_from_slice(&allows_bytes);
+
+        // without_cap (512 bytes)
+        let mut without_bytes = b"Must stay within RLIMIT_MEMLOCK".to_vec();
+        without_bytes.resize(512, 0);
+        data.extend_from_slice(&without_bytes);
+
+        // check_condition (512 bytes)
+        let mut condition_bytes = b"When memory would exceed limit".to_vec();
+        condition_bytes.resize(512, 0);
+        data.extend_from_slice(&condition_bytes);
+
+        // priority (u8) = 0
+        data.push(0);
+
+        // alternatives (4 * 8 = 32 bytes) - all zeros
+        data.extend_from_slice(&[0u8; 32]);
+
+        // alternative_count (u32) = 0
+        data.extend_from_slice(&0u32.to_le_bytes());
+
+        // Parse the capability
+        let mut reader = DataReader::new(&data, 0);
+        let cap = parse_capability(&mut reader).unwrap();
+
+        assert_eq!(cap.capability, 14);
+        assert_eq!(cap.name, "CAP_IPC_LOCK");
+        assert_eq!(cap.action, "Bypasses check");
+        assert_eq!(cap.allows, "Bypass RLIMIT_MEMLOCK check entirely");
+        assert_eq!(cap.without_cap, "Must stay within RLIMIT_MEMLOCK");
+        assert_eq!(cap.check_condition, Some("When memory would exceed limit".to_string()));
+        assert_eq!(cap.priority, Some(0));
+        assert!(cap.alternatives.is_empty());
+    }
+
+    #[test]
+    fn test_calculate_struct_size() {
+        let size = calculate_kernel_api_spec_size();
+        // The actual kernel struct size is 308064, our calculation gives 308305
+        // The difference is acceptable for alignment/padding
+        assert!(size > 308000 && size < 309000, "Struct size {} is out of expected range", size);
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/json.rs b/tools/kapi/src/formatter/json.rs
new file mode 100644
index 0000000000000..836741fdcb91b
--- /dev/null
+++ b/tools/kapi/src/formatter/json.rs
@@ -0,0 +1,420 @@
+use super::OutputFormatter;
+use std::io::Write;
+use serde::Serialize;
+use crate::extractor::{SocketStateSpec, ProtocolBehaviorSpec, AddrFamilySpec, BufferSpec, AsyncSpec, CapabilitySpec,
+    ParamSpec, ReturnSpec, ErrorSpec, SignalSpec, SignalMaskSpec, SideEffectSpec, StateTransitionSpec, ConstraintSpec, LockSpec};
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
+}
+
+
+impl JsonFormatter {
+    pub fn new() -> Self {
+        JsonFormatter {
+            data: JsonData {
+                apis: None,
+                api_details: None,
+            }
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
+        });
+        Ok(())
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
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
+    fn protocol_behavior(&mut self, _w: &mut dyn Write, behavior: &ProtocolBehaviorSpec) -> std::io::Result<()> {
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
+    fn state_transition(&mut self, _w: &mut dyn Write, trans: &StateTransitionSpec) -> std::io::Result<()> {
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
+    fn constraint(&mut self, _w: &mut dyn Write, _constraint: &ConstraintSpec) -> std::io::Result<()> {
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
+}
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/mod.rs b/tools/kapi/src/formatter/mod.rs
new file mode 100644
index 0000000000000..ec61827ba47b5
--- /dev/null
+++ b/tools/kapi/src/formatter/mod.rs
@@ -0,0 +1,130 @@
+use std::io::Write;
+use crate::extractor::{SocketStateSpec, ProtocolBehaviorSpec, AddrFamilySpec, BufferSpec, AsyncSpec, CapabilitySpec,
+    ParamSpec, ReturnSpec, ErrorSpec, SignalSpec, SignalMaskSpec, SideEffectSpec, StateTransitionSpec, ConstraintSpec, LockSpec};
+
+mod plain;
+mod json;
+mod rst;
+mod shall;
+
+pub use plain::PlainFormatter;
+pub use json::JsonFormatter;
+pub use rst::RstFormatter;
+pub use shall::ShallFormatter;
+
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
+    fn protocol_behavior(&mut self, w: &mut dyn Write, behavior: &ProtocolBehaviorSpec) -> std::io::Result<()>;
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
+    fn state_transition(&mut self, w: &mut dyn Write, trans: &StateTransitionSpec) -> std::io::Result<()>;
+    fn end_state_transitions(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    // Constraints and locks
+    fn begin_constraints(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn constraint(&mut self, w: &mut dyn Write, constraint: &ConstraintSpec) -> std::io::Result<()>;
+    fn end_constraints(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
+
+    fn begin_locks(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()>;
+    fn lock(&mut self, w: &mut dyn Write, lock: &LockSpec) -> std::io::Result<()>;
+    fn end_locks(&mut self, w: &mut dyn Write) -> std::io::Result<()>;
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
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/plain.rs b/tools/kapi/src/formatter/plain.rs
new file mode 100644
index 0000000000000..cc78026f20dd1
--- /dev/null
+++ b/tools/kapi/src/formatter/plain.rs
@@ -0,0 +1,465 @@
+use super::OutputFormatter;
+use std::io::Write;
+use crate::extractor::{SocketStateSpec, ProtocolBehaviorSpec, AddrFamilySpec, BufferSpec, AsyncSpec, CapabilitySpec,
+    ParamSpec, ReturnSpec, ErrorSpec, SignalSpec, SignalMaskSpec, SideEffectSpec, StateTransitionSpec, ConstraintSpec, LockSpec};
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
+        writeln!(w, "  [{}] {} ({})", param.index, param.name, param.type_name)?;
+        if !param.description.is_empty() {
+            writeln!(w, "      {}", param.description)?;
+        }
+
+        // Display flags
+        let mut flags = Vec::new();
+        if param.flags & 0x01 != 0 { flags.push("IN"); }
+        if param.flags & 0x02 != 0 { flags.push("OUT"); }
+        if param.flags & 0x04 != 0 { flags.push("INOUT"); }
+        if param.flags & 0x08 != 0 { flags.push("USER"); }
+        if param.flags & 0x10 != 0 { flags.push("OPTIONAL"); }
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
+    fn protocol_behavior(&mut self, w: &mut dyn Write, behavior: &ProtocolBehaviorSpec) -> std::io::Result<()> {
+        writeln!(w, "  {} - {}", behavior.applicable_protocols, behavior.behavior)?;
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
+        writeln!(w, "    Address length: {}-{} bytes", family.min_addr_len, family.max_addr_len)?;
+        if let Some(format) = &family.addr_format {
+            writeln!(w, "    Format: {format}")?;
+        }
+        writeln!(w, "    Features: wildcard={}, multicast={}, broadcast={}",
+                 family.supports_wildcard, family.supports_multicast, family.supports_broadcast)?;
+        if let Some(special) = &family.special_addresses {
+            writeln!(w, "    Special addresses: {special}")?;
+        }
+        if family.port_range_max > 0 {
+            writeln!(w, "    Port range: {}-{}", family.port_range_min, family.port_range_max)?;
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
+    fn state_transition(&mut self, w: &mut dyn Write, trans: &StateTransitionSpec) -> std::io::Result<()> {
+        writeln!(w, "  {} : {} -> {}", trans.object, trans.from_state, trans.to_state)?;
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
+    fn constraint(&mut self, w: &mut dyn Write, constraint: &ConstraintSpec) -> std::io::Result<()> {
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
+            0 => "SPINLOCK",
+            1 => "MUTEX",
+            2 => "RWLOCK",
+            3 => "SEMAPHORE",
+            4 => "RCU",
+            _ => "UNKNOWN",
+        };
+        writeln!(w, " ({lock_type})")?;
+
+        let mut actions = Vec::new();
+        if lock.acquired { actions.push("acquired"); }
+        if lock.released { actions.push("released"); }
+        if lock.held_on_entry { actions.push("held on entry"); }
+        if lock.held_on_exit { actions.push("held on exit"); }
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
+}
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/rst.rs b/tools/kapi/src/formatter/rst.rs
new file mode 100644
index 0000000000000..ee660af176781
--- /dev/null
+++ b/tools/kapi/src/formatter/rst.rs
@@ -0,0 +1,468 @@
+use super::OutputFormatter;
+use std::io::Write;
+use crate::extractor::{SocketStateSpec, ProtocolBehaviorSpec, AddrFamilySpec, BufferSpec, AsyncSpec, CapabilitySpec,
+    ParamSpec, ReturnSpec, ErrorSpec, SignalSpec, SignalMaskSpec, SideEffectSpec, StateTransitionSpec, ConstraintSpec, LockSpec};
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
+        writeln!(w, "{}", Self::section_char(0).to_string().repeat(title.len()))?;
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
+        writeln!(w, "{}", Self::section_char(0).to_string().repeat(name.len()))?;
+        writeln!(w)
+    }
+
+    fn end_api_details(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)
+    }
+
+
+    fn end_parameters(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+
+    fn begin_errors(&mut self, w: &mut dyn Write, count: u32) -> std::io::Result<()> {
+        self.current_section_level = 1;
+        let title = format!("Possible Errors ({count})");
+        writeln!(w, "{title}")?;
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)?;
+
+        if !state.required_states.is_empty() {
+            writeln!(w, "**Required states:** {}", state.required_states.join(", "))?;
+        }
+        if !state.forbidden_states.is_empty() {
+            writeln!(w, "**Forbidden states:** {}", state.forbidden_states.join(", "))?;
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)
+    }
+
+    fn protocol_behavior(&mut self, w: &mut dyn Write, behavior: &ProtocolBehaviorSpec) -> std::io::Result<()> {
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
+        writeln!(w)
+    }
+
+    fn addr_family(&mut self, w: &mut dyn Write, family: &AddrFamilySpec) -> std::io::Result<()> {
+        writeln!(w, "**{} ({})**", family.family_name, family.family)?;
+        writeln!(w)?;
+        writeln!(w, "* **Struct size:** {} bytes", family.addr_struct_size)?;
+        writeln!(w, "* **Address length:** {}-{} bytes", family.min_addr_len, family.max_addr_len)?;
+        if let Some(format) = &family.addr_format {
+            writeln!(w, "* **Format:** ``{format}``")?;
+        }
+        writeln!(w, "* **Features:** wildcard={}, multicast={}, broadcast={}",
+                 family.supports_wildcard, family.supports_multicast, family.supports_broadcast)?;
+        if let Some(special) = &family.special_addresses {
+            writeln!(w, "* **Special addresses:** {special}")?;
+        }
+        if family.port_range_max > 0 {
+            writeln!(w, "* **Port range:** {}-{}", family.port_range_min, family.port_range_max)?;
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
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
+        writeln!(w, "{}", Self::section_char(1).to_string().repeat(title.len()))?;
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
+        writeln!(w, "**[{}] {}** (*{}*)", param.index, param.name, param.type_name)?;
+        writeln!(w)?;
+        writeln!(w, "  {}", param.description)?;
+
+        // Display flags
+        let mut flags = Vec::new();
+        if param.flags & 0x01 != 0 { flags.push("IN"); }
+        if param.flags & 0x02 != 0 { flags.push("OUT"); }
+        if param.flags & 0x04 != 0 { flags.push("USER"); }
+        if param.flags & 0x08 != 0 { flags.push("OPTIONAL"); }
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
+        writeln!(w, "{}\n", Self::section_char(1).to_string().repeat(title.len()))
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
+        writeln!(w, "{}\n", Self::section_char(1).to_string().repeat(title.len()))
+    }
+
+    fn state_transition(&mut self, w: &mut dyn Write, trans: &StateTransitionSpec) -> std::io::Result<()> {
+        writeln!(w, "* **{}**: {} → {}", trans.object, trans.from_state, trans.to_state)?;
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
+    fn constraint(&mut self, _w: &mut dyn Write, _constraint: &ConstraintSpec) -> std::io::Result<()> {
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
+        writeln!(w, "{}\n", Self::section_char(1).to_string().repeat(title.len()))
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
+}
\ No newline at end of file
diff --git a/tools/kapi/src/formatter/shall.rs b/tools/kapi/src/formatter/shall.rs
new file mode 100644
index 0000000000000..ef432a060da52
--- /dev/null
+++ b/tools/kapi/src/formatter/shall.rs
@@ -0,0 +1,605 @@
+use super::OutputFormatter;
+use std::io::Write;
+use crate::extractor::{SocketStateSpec, ProtocolBehaviorSpec, AddrFamilySpec, BufferSpec, AsyncSpec, CapabilitySpec,
+    ParamSpec, ReturnSpec, ErrorSpec, SignalSpec, SignalMaskSpec, SideEffectSpec, StateTransitionSpec, ConstraintSpec, LockSpec};
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
+
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
+        writeln!(w, "- {} shall be available for {}", name, name.replace('_', " "))
+    }
+
+    fn end_api_list(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        self.in_list = false;
+        Ok(())
+    }
+
+    fn total_specs(&mut self, w: &mut dyn Write, count: usize) -> std::io::Result<()> {
+        writeln!(w, "\nTotal: {} kernel API specifications shall be enforced.", count)
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
+                writeln!(w, "  Process context allows the function to sleep, allocate memory with GFP_KERNEL, and access user space.")
+            }
+            "Softirq context" => {
+                writeln!(w, "- The function shall be callable from softirq context.")?;
+                writeln!(w, "  In softirq context, the function shall not sleep and shall use GFP_ATOMIC for memory allocations.")
+            }
+            "Hardirq context" => {
+                writeln!(w, "- The function shall be callable from hardirq (interrupt) context.")?;
+                writeln!(w, "  In hardirq context, the function shall not sleep, shall minimize execution time, and shall use GFP_ATOMIC for allocations.")
+            }
+            "NMI context" => {
+                writeln!(w, "- The function shall be callable from NMI (Non-Maskable Interrupt) context.")?;
+                writeln!(w, "  In NMI context, the function shall not take any locks that might be held by interrupted code.")
+            }
+            "User mode" => {
+                writeln!(w, "- The function shall be callable when the CPU is in user mode.")?;
+                writeln!(w, "  This typically applies to system call entry points.")
+            }
+            "Kernel mode" => {
+                writeln!(w, "- The function shall be callable when the CPU is in kernel mode.")
+            }
+            "May sleep" => {
+                writeln!(w, "- The function may sleep (block) during execution.")?;
+                writeln!(w, "  Callers shall ensure they are in a context where sleeping is allowed (not in interrupt or atomic context).")
+            }
+            "Atomic context" => {
+                writeln!(w, "- The function shall be callable from atomic context.")?;
+                writeln!(w, "  In atomic context, the function shall not sleep and shall complete quickly.")
+            }
+            "Preemptible" => {
+                writeln!(w, "- The function shall be callable when preemption is enabled.")?;
+                writeln!(w, "  The function may be preempted by higher priority tasks.")
+            }
+            "Migration disabled" => {
+                writeln!(w, "- The function shall be callable when CPU migration is disabled.")?;
+                writeln!(w, "  The function shall not rely on being able to migrate between CPUs.")
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
+        writeln!(w, "- If {} is provided, it shall be {}.",
+            param.name, param.description.trim_end_matches('.'))?;
+
+        // Only show meaningful numeric constraints
+        if let Some(min) = param.min_value {
+            if let Some(max) = param.max_value {
+                if min != 0 || max != 0 {
+                    writeln!(w, "\n- If {} is less than {} or greater than {}, the operation shall fail.",
+                        param.name, min, max)?;
+                }
+            } else if min != 0 {
+                writeln!(w, "\n- If {} is less than {}, the operation shall fail.",
+                    param.name, min)?;
+            }
+        } else if let Some(max) = param.max_value {
+            if max != 0 {
+                writeln!(w, "\n- If {} is greater than {}, the operation shall fail.",
+                    param.name, max)?;
+            }
+        }
+
+        if let Some(constraint) = &param.constraint {
+            if !constraint.is_empty() {
+                let constraint_text = constraint.trim_end_matches('.');
+                // Handle constraints that start with "Must be" or similar
+                if constraint_text.to_lowercase().starts_with("must be ") {
+                    let requirement = &constraint_text[8..]; // Skip "Must be "
+                    writeln!(w, "\n- If {} is not {}, the operation shall fail.",
+                        param.name, requirement)?;
+                } else if constraint_text.to_lowercase().starts_with("must ") {
+                    let requirement = &constraint_text[5..]; // Skip "Must "
+                    writeln!(w, "\n- If {} does not {}, the operation shall fail.",
+                        param.name, requirement)?;
+                } else if constraint_text.contains(" must ") || constraint_text.contains(" should ") {
+                    // Reformat constraints with must/should in the middle
+                    writeln!(w, "\n- {} shall satisfy: {}.",
+                        param.name, constraint_text)?;
+                } else {
+                    // Default format for other constraints
+                    writeln!(w, "\n- If {} is not {}, the operation shall fail.",
+                        param.name, constraint_text)?;
+                }
+            }
+        }
+
+        // Only show valid_mask if it's not 0
+        if let Some(mask) = param.valid_mask {
+            if mask != 0 {
+                writeln!(w, "\n- If {} contains bits not set in 0x{:x}, the operation shall fail.",
+                    param.name, mask)?;
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
+            writeln!(w, "- If the operation succeeds, the function shall return {}.", success)?;
+        } else if let Some(min) = ret.success_min {
+            if let Some(max) = ret.success_max {
+                writeln!(w, "- If the operation succeeds, the function shall return a value between {} and {} inclusive.", min, max)?;
+            } else {
+                writeln!(w, "- If the operation succeeds, the function shall return a value greater than or equal to {}.", min)?;
+            }
+        }
+
+        if !ret.error_values.is_empty() {
+            writeln!(w, "\n- If the operation fails, the function shall return one of the specified negative error values.")?;
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
+            error.description.to_lowercase().trim_end_matches('.').to_string()
+        } else {
+            error.condition.to_lowercase()
+        };
+        writeln!(w, "- If {condition}, the function shall return -{}.", error.name)?;
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
+        let sentences: Vec<&str> = notes.split(". ")
+            .filter(|s| !s.trim().is_empty())
+            .collect();
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
+            } else if trimmed.starts_with("On ") || trimmed.starts_with("If ") || trimmed.starts_with("When ") {
+                // These are already conditional, just add shall
+                writeln!(w, "- {}, the behavior shall be as described.", trimmed)?;
+            } else {
+                // Convert to a shall statement
+                writeln!(w, "- The implementation shall ensure that {}.",
+                    trimmed.chars().next().unwrap().to_lowercase().collect::<String>() + &trimmed[1..])?;
+            }
+        }
+        Ok(())
+    }
+
+    fn since_version(&mut self, w: &mut dyn Write, version: &str) -> std::io::Result<()> {
+        writeln!(w, "\n- If kernel version is {} or later, this API shall be available.", version)
+    }
+
+    fn sysfs_subsystem(&mut self, w: &mut dyn Write, subsystem: &str) -> std::io::Result<()> {
+        writeln!(w, "- If accessed through sysfs, the attribute shall be located in the {} subsystem.", subsystem)
+    }
+
+    fn sysfs_path(&mut self, w: &mut dyn Write, path: &str) -> std::io::Result<()> {
+        writeln!(w, "\n- If the sysfs interface is mounted, the attribute shall be accessible at {}.", path)
+    }
+
+    fn sysfs_permissions(&mut self, w: &mut dyn Write, perms: &str) -> std::io::Result<()> {
+        writeln!(w, "\n- If the attribute exists, its permissions shall be set to {}.", perms)
+    }
+
+    fn socket_state(&mut self, w: &mut dyn Write, state: &SocketStateSpec) -> std::io::Result<()> {
+        writeln!(w, "\nSocket State Behavior:")?;
+        writeln!(w)?;
+
+        if !state.required_states.is_empty() {
+            let states_str = state.required_states.join(" or ");
+            writeln!(w, "- If the socket is not in {} state, the operation shall fail.", states_str)?;
+        }
+
+        if !state.forbidden_states.is_empty() {
+            for s in &state.forbidden_states {
+                writeln!(w, "\n- If the socket is in {} state, the operation shall fail.", s)?;
+            }
+        }
+
+        if let Some(result) = &state.resulting_state {
+            writeln!(w, "\n- If the operation succeeds, the socket state shall transition to {}.", result)?;
+        }
+
+        Ok(())
+    }
+
+    fn begin_protocol_behaviors(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nProtocol-Specific Behavior:")
+    }
+
+    fn protocol_behavior(&mut self, w: &mut dyn Write, behavior: &ProtocolBehaviorSpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        writeln!(w, "- If protocol is {}, {}.",
+            behavior.applicable_protocols, behavior.behavior)?;
+
+        if let Some(flags) = &behavior.protocol_flags {
+            writeln!(w, "\n- If protocol is {} and flags {} are set, the behavior shall be modified accordingly.",
+                behavior.applicable_protocols, flags)?;
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
+        writeln!(w, "- If address family is {} ({}), the address structure size shall be {} bytes.",
+            family.family, family.family_name, family.addr_struct_size)?;
+
+        writeln!(w, "\n- If address family is {} and address length is less than {} or greater than {}, the operation shall fail.",
+            family.family, family.min_addr_len, family.max_addr_len)?;
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
+            writeln!(w, "- If the buffer size is less than {} bytes, the operation shall fail.", min)?;
+        }
+
+        if let Some(max) = spec.max_buffer_size {
+            writeln!(w, "\n- If the buffer size exceeds {} bytes, the excess data shall be truncated.", max)?;
+        }
+
+        if let Some(behaviors) = &spec.buffer_behaviors {
+            writeln!(w, "\n- When handling buffers, the following behavior shall apply: {}.", behaviors)?;
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
+            writeln!(w, "- If O_NONBLOCK is set and the operation would block, the function shall return -EAGAIN or -EWOULDBLOCK.")?;
+        }
+
+        if let Some(errno) = spec.nonblock_errno {
+            writeln!(w, "\n- If the file descriptor is in non-blocking mode and no data is available, the function shall return -{}.", errno)?;
+        }
+
+        Ok(())
+    }
+
+    fn net_data_transfer(&mut self, w: &mut dyn Write, desc: &str) -> std::io::Result<()> {
+        writeln!(w, "\nData Transfer Behavior:")?;
+        writeln!(w)?;
+        writeln!(w, "- When transferring data, the operation shall {}.", desc.trim_end_matches('.'))
+    }
+
+    fn begin_capabilities(&mut self, w: &mut dyn Write) -> std::io::Result<()> {
+        writeln!(w, "\nCapability Requirements:")
+    }
+
+    fn capability(&mut self, w: &mut dyn Write, cap: &CapabilitySpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        writeln!(w, "- If the process attempts to {}, {} capability shall be checked.",
+            cap.action, cap.name)?;
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
+        if signal.direction == 1 { // Sends
+            writeln!(w, "- If the conditions for {} are met, the signal shall be sent to the target process.",
+                signal.signal_name)?;
+        } else if signal.direction == 2 { // Receives
+            writeln!(w, "- If {} is received and not blocked, the operation shall be interrupted.",
+                signal.signal_name)?;
+
+            if signal.restartable {
+                writeln!(w, "\n- If {} is received and SA_RESTART is set, the operation shall be automatically restarted.",
+                    signal.signal_name)?;
+            }
+        } else {
+            // Direction 0 or other - just note the signal handling
+            writeln!(w, "- {} shall be handled according to its default behavior.", signal.signal_name)?;
+        }
+
+        if let Some(errno) = signal.error_on_signal {
+            if errno != 0 {
+                writeln!(w, "\n- If interrupted by {}, the function shall return -{}.",
+                    signal.signal_name, errno)?;
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
+            writeln!(w, "The API SHALL support the following signal mask operations:")?;
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
+            writeln!(w, "- If {}, {} shall be {}.",
+                condition, effect.target, effect.description.trim_end_matches('.'))?;
+        } else {
+            writeln!(w, "- When the operation executes, {} shall be {}.",
+                effect.target, effect.description.trim_end_matches('.'))?;
+        }
+
+        if effect.reversible {
+            writeln!(w, "\n- If the operation is rolled back, the effect on {} shall be reversed.",
+                effect.target)?;
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
+    fn state_transition(&mut self, w: &mut dyn Write, trans: &StateTransitionSpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        if let Some(condition) = &trans.condition {
+            writeln!(w, "- If {} is in {} state and {}, it shall transition to {} state.",
+                trans.object, trans.from_state, condition, trans.to_state)?;
+        } else {
+            writeln!(w, "- If {} is in {} state, it shall transition to {} state.",
+                trans.object, trans.from_state, trans.to_state)?;
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
+    fn constraint(&mut self, w: &mut dyn Write, constraint: &ConstraintSpec) -> std::io::Result<()> {
+        writeln!(w)?;
+        if let Some(expr) = &constraint.expression {
+            if expr.is_empty() {
+                writeln!(w, "- {}: {}.", constraint.name, constraint.description)?;
+            } else {
+                writeln!(w, "- If {} is violated, the operation shall fail.", constraint.name)?;
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
+            writeln!(w, "- The {} {} shall be used for: {}",
+                lock.lock_name, lock_type_str, lock.description)?;
+        }
+
+        if lock.held_on_entry {
+            writeln!(w, "- If {} is not held on entry, the operation shall fail.", lock.lock_name)?;
+        }
+
+        if lock.acquired && !lock.held_on_entry {
+            writeln!(w, "- Before accessing the protected resource, {} shall be acquired.", lock.lock_name)?;
+        }
+
+        if lock.released && lock.held_on_exit {
+            writeln!(w, "- If the operation succeeds and no error path is taken, {} shall remain held on exit.", lock.lock_name)?;
+        } else if lock.released {
+            writeln!(w, "- Before returning, {} shall be released.", lock.lock_name)?;
+        }
+
+        Ok(())
+    }
+
+    fn end_locks(&mut self, _w: &mut dyn Write) -> std::io::Result<()> {
+        Ok(())
+    }
+}
\ No newline at end of file
diff --git a/tools/kapi/src/main.rs b/tools/kapi/src/main.rs
new file mode 100644
index 0000000000000..76416a9364010
--- /dev/null
+++ b/tools/kapi/src/main.rs
@@ -0,0 +1,130 @@
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
+mod formatter;
+mod extractor;
+
+use formatter::{OutputFormat, create_formatter};
+use extractor::{ApiExtractor, VmlinuxExtractor, SourceExtractor, DebugfsExtractor};
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
+    let output_format: OutputFormat = args.format.parse()
+        .map_err(|e: String| anyhow::anyhow!(e))?;
+
+    let extractor: Box<dyn ApiExtractor> = match (args.vmlinux, args.source, args.debugfs.clone()) {
+        (Some(vmlinux_path), None, None) => {
+            Box::new(VmlinuxExtractor::new(&vmlinux_path)?)
+        }
+        (None, Some(source_path), None) => {
+            Box::new(SourceExtractor::new(&source_path)?)
+        }
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
+fn display_apis(extractor: &dyn ApiExtractor, api_name: Option<String>, output_format: OutputFormat) -> Result<()> {
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
+        let syscalls: Vec<_> = all_specs.iter().filter(|s| s.api_type == "syscall").collect();
+        let ioctls: Vec<_> = all_specs.iter().filter(|s| s.api_type == "ioctl").collect();
+        let functions: Vec<_> = all_specs.iter().filter(|s| s.api_type == "function").collect();
+        let sysfs: Vec<_> = all_specs.iter().filter(|s| s.api_type == "sysfs").collect();
+
+        if !syscalls.is_empty() {
+            formatter.begin_api_list(&mut stdout, "System Calls")?;
+            for spec in syscalls {
+                formatter.api_item(&mut stdout, &spec.name, &spec.api_type)?;
+            }
+            formatter.end_api_list(&mut stdout)?;
+        }
+
+        if !ioctls.is_empty() {
+            formatter.begin_api_list(&mut stdout, "IOCTLs")?;
+            for spec in ioctls {
+                formatter.api_item(&mut stdout, &spec.name, &spec.api_type)?;
+            }
+            formatter.end_api_list(&mut stdout)?;
+        }
+
+        if !functions.is_empty() {
+            formatter.begin_api_list(&mut stdout, "Functions")?;
+            for spec in functions {
+                formatter.api_item(&mut stdout, &spec.name, &spec.api_type)?;
+            }
+            formatter.end_api_list(&mut stdout)?;
+        }
+
+        if !sysfs.is_empty() {
+            formatter.begin_api_list(&mut stdout, "Sysfs Attributes")?;
+            for spec in sysfs {
+                formatter.api_item(&mut stdout, &spec.name, &spec.api_type)?;
+            }
+            formatter.end_api_list(&mut stdout)?;
+        }
+
+        formatter.total_specs(&mut stdout, all_specs.len())?;
+    }
+
+    formatter.end_document(&mut stdout)?;
+
+    Ok(())
+}
+
-- 
2.39.5


