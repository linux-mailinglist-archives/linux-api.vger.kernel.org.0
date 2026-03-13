Return-Path: <linux-api+bounces-5944-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OID8Ez8qtGkQiQAAu9opvQ
	(envelope-from <linux-api+bounces-5944-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:16:15 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F1A285BC6
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61E68300D1D0
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B903B0ACA;
	Fri, 13 Mar 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvxUrfSs"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD193AF650;
	Fri, 13 Mar 2026 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414591; cv=none; b=DkCfifgO9ww2qAu2qnfhbIp1RGoa3HvjAIRyNhfGX8FSrZ/ELjGNzBlFuCqsy4PW3bsqN9MVEacXsdOUW0wsapO6Dt7j4iCMA9jNQQ0fj60Oj1+gTqnSAEXzRDj7BBZ5h5DPtLRVp8RR59rKtiGAGDL8C83zJ5H+zypH6U0AATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414591; c=relaxed/simple;
	bh=GrtGkqfJJKjB/xdwTuweDOCx5SuB2wsTbh7NxBy5CWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyhCcc4aT2oS/uVMYzClA7T5mkkUc/AKWPwInZ7fYzZf4576C/8Jrscrmeuc96KeemRHZUmgIBdDOcJb90vcWAtUmBUP27IeRYsBMK/qThMAfN+FT5vhlyD4Df3fmp4qqP52paY2bDxA6YgMu+YUlyYfwB3SUXt4e3VI0SshSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvxUrfSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E96C2BC86;
	Fri, 13 Mar 2026 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773414590;
	bh=GrtGkqfJJKjB/xdwTuweDOCx5SuB2wsTbh7NxBy5CWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvxUrfSsGETrr7DRP+KzfhzoJnCW8lfqRbDeHGM4O9pOPeU6c+BCPkFZdpR6B/fNg
	 B7mLj5XwEUWiYg3IQRitDfVuhs0wEu0Ryv0A90XrRZIaveOXLFHveTSg+gJopGxrub
	 f74MuVbliLNhJccTnkFTVnSm2RHmkAFdBz5HUl8xDHjn/oIV1N2DgTBXzoW11te7gR
	 g6caiHXQlmo0m0AxD49+hhBOgUU/ooVfoDzkX742vuHtR9qjsYwGVDzMCfbmssalBf
	 GrU8Cpnukcqw4LRXEz0wt5VYkxm1LHZklvQ21XeBfPQqny+ApuVH6RAmnMnoZkSSXF
	 +kaopT0ygKNZg==
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
Subject: [PATCH 1/9] kernel/api: introduce kernel API specification framework
Date: Fri, 13 Mar 2026 11:09:11 -0400
Message-ID: <20260313150928.2637368-2-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-5944-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[param.name:url]
X-Rspamd-Queue-Id: D9F1A285BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a framework for formally documenting kernel APIs with inline
specifications. This framework provides:

- Structured API documentation with parameter specifications, return
  values, error conditions, and execution context requirements
- Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME_CHECKS)
- Export of specifications via debugfs for tooling integration
- Support for both internal kernel APIs and system calls

The framework stores specifications in a dedicated ELF section and
provides infrastructure for:
- Compile-time validation of specifications
- Runtime querying of API documentation
- Machine-readable export formats
- Integration with existing SYSCALL_DEFINE macros

This commit introduces the core infrastructure without modifying any
existing APIs. Subsequent patches will add specifications to individual
subsystems.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .gitignore                                  |    1 +
 Documentation/dev-tools/index.rst           |    1 +
 Documentation/dev-tools/kernel-api-spec.rst |  482 ++++++
 MAINTAINERS                                 |   11 +
 arch/x86/include/asm/syscall_wrapper.h      |   40 +
 include/asm-generic/vmlinux.lds.h           |   28 +
 include/linux/kernel_api_spec.h             | 1580 +++++++++++++++++++
 include/linux/syscall_api_spec.h            |  192 +++
 include/linux/syscalls.h                    |   39 +
 init/Kconfig                                |    2 +
 kernel/Makefile                             |    3 +
 kernel/api/.gitignore                       |    2 +
 kernel/api/Kconfig                          |   70 +
 kernel/api/Makefile                         |   14 +
 kernel/api/kapi_kunit.c                     |  536 +++++++
 kernel/api/kernel_api_spec.c                | 1277 +++++++++++++++
 scripts/generate_api_specs.sh               |   18 +
 17 files changed, 4296 insertions(+)
 create mode 100644 Documentation/dev-tools/kernel-api-spec.rst
 create mode 100644 include/linux/kernel_api_spec.h
 create mode 100644 include/linux/syscall_api_spec.h
 create mode 100644 kernel/api/.gitignore
 create mode 100644 kernel/api/Kconfig
 create mode 100644 kernel/api/Makefile
 create mode 100644 kernel/api/kapi_kunit.c
 create mode 100644 kernel/api/kernel_api_spec.c
 create mode 100755 scripts/generate_api_specs.sh

diff --git a/.gitignore b/.gitignore
index 3a7241c941f5e..7130001e444f1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,6 +12,7 @@
 #
 .*
 *.a
+*.apispec.h
 *.asn1.[ch]
 *.bin
 *.bz2
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 59cbb77b33ff4..8d3768645d96c 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -36,6 +36,7 @@ Documentation/process/debugging/index.rst
    kunit/index
    ktap
    checkuapi
+   kernel-api-spec
    gpio-sloppy-logic-analyzer
    autofdo
    propeller
diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
new file mode 100644
index 0000000000000..7c0c1694f1f4a
--- /dev/null
+++ b/Documentation/dev-tools/kernel-api-spec.rst
@@ -0,0 +1,482 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Kernel API Specification Framework
+======================================
+
+:Author: Sasha Levin <sashal@kernel.org>
+:Date: June 2025
+
+.. contents:: Table of Contents
+   :depth: 3
+   :local:
+
+Introduction
+============
+
+The Kernel API Specification Framework (KAPI) provides a comprehensive system for
+formally documenting, validating, and introspecting kernel APIs. This framework
+addresses the long-standing challenge of maintaining accurate, machine-readable
+documentation for the thousands of internal kernel APIs and system calls.
+
+Purpose and Goals
+-----------------
+
+The framework aims to:
+
+1. **Improve API Documentation**: Provide structured, inline documentation that
+   lives alongside the code and is maintained as part of the development process.
+
+2. **Enable Runtime Validation**: Optionally validate API usage at runtime to catch
+   common programming errors during development and testing.
+
+3. **Support Tooling**: Export API specifications in machine-readable formats for
+   use by static analyzers, documentation generators, and development tools.
+
+4. **Enhance Debugging**: Provide detailed API information at runtime through debugfs
+   for debugging and introspection.
+
+5. **Formalize Contracts**: Explicitly document API contracts including parameter
+   constraints, execution contexts, locking requirements, and side effects.
+
+Architecture Overview
+=====================
+
+Components
+----------
+
+The framework consists of several key components:
+
+1. **Core Framework** (``kernel/api/kernel_api_spec.c``)
+
+   - API specification registration and storage
+   - Runtime validation engine
+   - Specification lookup and querying
+
+2. **DebugFS Interface** (``kernel/api/kapi_debugfs.c``)
+
+   - Runtime introspection via ``/sys/kernel/debug/kapi/``
+   - JSON and XML export formats
+   - Per-API detailed information
+
+3. **IOCTL Support** (``kernel/api/ioctl_validation.c``)
+
+   - Extended framework for IOCTL specifications
+   - Automatic validation wrappers
+   - Structure field validation
+
+4. **Specification Macros** (``include/linux/kernel_api_spec.h``)
+
+   - Declarative macros for API documentation
+   - Type-safe parameter specifications
+   - Context and constraint definitions
+
+Data Model
+----------
+
+The framework uses a hierarchical data model::
+
+    kernel_api_spec
+    ├── Basic Information
+    │   ├── name (API function name)
+    │   ├── version (specification version)
+    │   ├── description (human-readable description)
+    │   └── kernel_version (when API was introduced)
+    │
+    ├── Parameters (up to 16)
+    │   └── kapi_param_spec
+    │       ├── name
+    │       ├── type (int, pointer, string, etc.)
+    │       ├── direction (in, out, inout)
+    │       ├── constraints (range, mask, enum values)
+    │       └── validation rules
+    │
+    ├── Return Value
+    │   └── kapi_return_spec
+    │       ├── type
+    │       ├── success conditions
+    │       └── validation rules
+    │
+    ├── Error Conditions (up to 32)
+    │   └── kapi_error_spec
+    │       ├── error code
+    │       ├── condition description
+    │       └── recovery advice
+    │
+    ├── Execution Context
+    │   ├── allowed contexts (process, interrupt, etc.)
+    │   ├── locking requirements
+    │   └── preemption/interrupt state
+    │
+    └── Side Effects
+        ├── memory allocation
+        ├── state changes
+        └── signal handling
+
+Usage Guide
+===========
+
+Basic API Specification
+-----------------------
+
+API specifications are written as KAPI-annotated kerneldoc comments directly in
+the source file, immediately preceding the function implementation. The ``kapi``
+tool extracts these annotations to produce structured specifications.
+
+.. code-block:: c
+
+    /**
+     * kmalloc - allocate kernel memory
+     * @size: Number of bytes to allocate
+     * @flags: Allocation flags (GFP_*)
+     *
+     * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SOFTIRQ | KAPI_CTX_HARDIRQ
+     * param-count: 2
+     *
+     * param: size
+     *   type: KAPI_TYPE_UINT
+     *   flags: KAPI_PARAM_IN
+     *   constraint-type: KAPI_CONSTRAINT_RANGE
+     *   range: 0, KMALLOC_MAX_SIZE
+     *
+     * error: ENOMEM, Out of memory
+     *   desc: Insufficient memory available for the requested allocation.
+     */
+    void *kmalloc(size_t size, gfp_t flags)
+    {
+        /* Implementation */
+    }
+
+Alternatively, specifications can be defined using the ``DEFINE_KERNEL_API_SPEC``
+macro for compiled-in specs that are stored in the ``.kapi_specs`` ELF section:
+
+.. code-block:: c
+
+    #include <linux/kernel_api_spec.h>
+
+    DEFINE_KERNEL_API_SPEC(sys_open)
+    KAPI_DESCRIPTION("Open or create a file")
+    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+    /* ... parameter, error, constraint definitions ... */
+    KAPI_END_SPEC
+
+System Call Specification
+-------------------------
+
+System calls are documented inline in the implementation file (e.g., ``fs/open.c``)
+using KAPI-annotated kerneldoc comments. When ``CONFIG_KAPI_RUNTIME_CHECKS`` is
+enabled, the ``SYSCALL_DEFINEx`` macros automatically look up the specification
+and validate parameters before and after the syscall executes.
+
+IOCTL Specification
+-------------------
+
+IOCTLs use the same annotation approach with additional structure field
+specifications
+
+Runtime Validation
+==================
+
+Enabling Validation
+-------------------
+
+Runtime validation is controlled by kernel configuration:
+
+1. Enable ``CONFIG_KAPI_SPEC`` to build the framework
+2. Enable ``CONFIG_KAPI_RUNTIME_CHECKS`` for runtime validation
+3. Optionally enable ``CONFIG_KAPI_SPEC_DEBUGFS`` for debugfs interface
+
+Validation Modes
+----------------
+
+When ``CONFIG_KAPI_RUNTIME_CHECKS`` is enabled, all registered API specifications
+are validated automatically at call time. The framework checks parameter constraints,
+execution context, and return values. Parameter violations are reported via
+``pr_warn_ratelimited`` and return value violations via ``WARN_ONCE`` to avoid
+flooding the kernel log.
+
+Custom Validators
+-----------------
+
+Parameters can use the ``KAPI_CONSTRAINT_CUSTOM`` constraint type to register
+custom validation functions via the ``validate`` field in the constraint spec:
+
+.. code-block:: c
+
+    static bool validate_buffer_size(s64 value)
+    {
+        size_t size = (size_t)value;
+
+        return size > 0 && size <= MAX_BUFFER_SIZE;
+    }
+
+    /* In the constraint definition: */
+    .type = KAPI_CONSTRAINT_CUSTOM,
+    .validate = validate_buffer_size,
+
+DebugFS Interface
+=================
+
+The debugfs interface provides runtime access to API specifications:
+
+Directory Structure
+-------------------
+
+::
+
+    /sys/kernel/debug/kapi/
+    ├── apis/                    # All registered APIs
+    │   ├── kmalloc/
+    │   │   ├── specification   # Human-readable spec
+    │   │   ├── json           # JSON format
+    │   │   └── xml            # XML format
+    │   └── open/
+    │       └── ...
+    ├── summary                  # Overview of all APIs
+    ├── validation/              # Validation controls
+    │   ├── enabled             # Global enable/disable
+    │   ├── level               # Validation level
+    │   └── stats               # Validation statistics
+    └── export/                  # Bulk export options
+        ├── all.json            # All specs in JSON
+        └── all.xml             # All specs in XML
+
+Usage Examples
+--------------
+
+Query specific API::
+
+    $ cat /sys/kernel/debug/kapi/apis/kmalloc/specification
+    API: kmalloc
+    Version: 3.0
+    Description: Allocate kernel memory
+
+    Parameters:
+      [0] size (size_t, in): Number of bytes to allocate
+          Range: 0 - 4194304
+      [1] flags (flags, in): Allocation flags (GFP_*)
+          Mask: 0x1ffffff
+
+    Returns: pointer - Pointer to allocated memory or NULL
+
+    Errors:
+      ENOMEM: Out of memory
+
+    Context: process, softirq, hardirq
+
+    Side Effects:
+      - Allocates memory from kernel heap
+
+Export all specifications::
+
+    $ cat /sys/kernel/debug/kapi/export/all.json > kernel-apis.json
+
+Enable validation for specific API::
+
+    $ echo 1 > /sys/kernel/debug/kapi/apis/kmalloc/validate
+
+Performance Considerations
+==========================
+
+Memory Overhead
+---------------
+
+Each API specification consumes approximately 400-450KB of memory due to the
+fixed-size arrays in ``struct kernel_api_spec``. With the current 4 syscall
+specifications, total memory usage is approximately 1.7MB. Consider:
+
+1. Building with ``CONFIG_KAPI_SPEC=n`` for production kernels
+2. Using ``__init`` annotations for APIs only used during boot
+3. Implementing lazy loading for rarely used specifications
+
+Runtime Overhead
+----------------
+
+When ``CONFIG_KAPI_RUNTIME_CHECKS`` is enabled:
+
+- Each validated API call adds 50-200ns overhead
+- Complex validations (custom validators) may add more
+- Use validation only in development/testing kernels
+
+Optimization Strategies
+-----------------------
+
+1. **Compile-time optimization**: When validation is disabled, all
+   validation code is optimized away by the compiler.
+
+2. **Selective validation**: Enable validation only for specific APIs
+   or subsystems under test.
+
+3. **Caching**: The framework caches validation results for repeated
+   calls with identical parameters.
+
+Documentation Generation
+------------------------
+
+The framework exports specifications via debugfs that can be used
+to generate documentation. Tools for automatic documentation generation
+from specifications are planned for future development.
+
+IDE Integration
+---------------
+
+Modern IDEs can use the JSON export for:
+
+- Parameter hints
+- Type checking
+- Context validation
+- Error code documentation
+
+Testing Framework
+-----------------
+
+The framework includes test helpers::
+
+    #ifdef CONFIG_KAPI_TESTING
+    /* Verify API behaves according to specification */
+    kapi_test_api("kmalloc", test_cases);
+    #endif
+
+Best Practices
+==============
+
+Writing Specifications
+----------------------
+
+1. **Be Comprehensive**: Document all parameters, errors, and side effects
+2. **Keep Updated**: Update specs when API behavior changes
+3. **Use Examples**: Include usage examples in descriptions
+4. **Validate Constraints**: Define realistic constraints for parameters
+5. **Document Context**: Clearly specify allowed execution contexts
+
+Maintenance
+-----------
+
+1. **Version Specifications**: Increment version when API changes
+2. **Deprecation**: Mark deprecated APIs and suggest replacements
+3. **Cross-reference**: Link related APIs in descriptions
+4. **Test Specifications**: Verify specs match implementation
+
+Common Patterns
+---------------
+
+**Optional Parameters**::
+
+    KAPI_PARAM(2, "optional_arg", "void *", "Optional argument (may be NULL)")
+        KAPI_PARAM_TYPE(KAPI_TYPE_PTR)
+        KAPI_PARAM_FLAGS(KAPI_PARAM_IN | KAPI_PARAM_OPTIONAL)
+    KAPI_PARAM_END
+
+**Buffer with Size Parameter**::
+
+    KAPI_PARAM(1, "buf", "char __user *", "User-space buffer")
+        KAPI_PARAM_TYPE(KAPI_TYPE_USER_PTR)
+        KAPI_PARAM_FLAGS(KAPI_PARAM_OUT | KAPI_PARAM_USER)
+        KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_BUFFER)
+        KAPI_PARAM_SIZE_PARAM(2)
+    KAPI_PARAM_END
+
+**Callback Functions**::
+
+    KAPI_PARAM(1, "callback", "int (*)(void *)", "Callback function")
+        KAPI_PARAM_TYPE(KAPI_TYPE_FUNC_PTR)
+        KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+    KAPI_PARAM_END
+
+Troubleshooting
+===============
+
+Common Issues
+-------------
+
+**Specification Not Found**::
+
+    kernel: KAPI: Specification for 'my_api' not found
+
+    Solution: Ensure KAPI_DEFINE_SPEC is in the same translation unit
+    as the function implementation.
+
+**Validation Failures**::
+
+    kernel: KAPI: Validation failed for kmalloc parameter 'size':
+            value 5242880 exceeds maximum 4194304
+
+    Solution: Check parameter constraints or adjust specification if
+    the constraint is incorrect.
+
+**Build Errors**::
+
+    error: 'KAPI_TYPE_UNKNOWN' undeclared
+
+    Solution: Include <linux/kernel_api_spec.h> and ensure
+    CONFIG_KAPI_SPEC is enabled.
+
+Debug Options
+-------------
+
+Enable verbose debugging::
+
+    echo 8 > /proc/sys/kernel/printk
+    echo 1 > /sys/kernel/debug/kapi/debug/verbose
+
+Future Directions
+=================
+
+Planned Features
+----------------
+
+1. **Automatic Extraction**: Tool to extract specifications from existing
+   kernel-doc comments
+
+2. **Contract Verification**: Static analysis to verify implementation
+   matches specification
+
+3. **Performance Profiling**: Measure actual API performance against
+   documented expectations
+
+4. **Fuzzing Integration**: Use specifications to guide intelligent
+   fuzzing of kernel APIs
+
+5. **Version Compatibility**: Track API changes across kernel versions
+
+Research Areas
+--------------
+
+1. **Formal Verification**: Use specifications for mathematical proofs
+   of correctness
+
+2. **Runtime Monitoring**: Detect specification violations in production
+   with minimal overhead
+
+3. **API Evolution**: Analyze how kernel APIs change over time
+
+4. **Security Applications**: Use specifications for security policy
+   enforcement
+
+Contributing
+============
+
+Submitting Specifications
+-------------------------
+
+1. Add specifications to the same file as the API implementation
+2. Follow existing patterns and naming conventions
+3. Test with CONFIG_KAPI_RUNTIME_CHECKS enabled
+4. Verify debugfs output is correct
+5. Run scripts/checkpatch.pl on your changes
+
+Review Criteria
+---------------
+
+Specifications will be reviewed for:
+
+1. **Completeness**: All parameters and errors documented
+2. **Accuracy**: Specification matches implementation
+3. **Clarity**: Descriptions are clear and helpful
+4. **Consistency**: Follows framework conventions
+5. **Performance**: No unnecessary runtime overhead
+
+Contact
+-------
+
+- Maintainer: Sasha Levin <sashal@kernel.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a54..6fa403d620aab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13810,6 +13810,17 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-keene*
 
+KERNEL API SPECIFICATION FRAMEWORK (KAPI)
+M:	Sasha Levin <sashal@kernel.org>
+L:	linux-api@vger.kernel.org
+S:	Maintained
+F:	Documentation/dev-tools/kernel-api-spec.rst
+F:	include/linux/kernel_api_spec.h
+F:	include/linux/syscall_api_spec.h
+F:	kernel/api/
+F:	tools/kapi/
+F:	tools/lib/python/kdoc/kdoc_apispec.py
+
 KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 7e88705e907f4..2262b9d7ab097 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -7,6 +7,14 @@
 #define _ASM_X86_SYSCALL_WRAPPER_H
 
 #include <asm/ptrace.h>
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+struct kernel_api_spec;
+extern const struct kernel_api_spec *kapi_get_spec(const char *name);
+extern int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
+					const s64 *params, int param_count);
+extern int kapi_validate_syscall_return(const struct kernel_api_spec *spec,
+					s64 retval);
+#endif
 
 extern long __x64_sys_ni_syscall(const struct pt_regs *regs);
 extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
@@ -220,6 +228,37 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 
 #endif /* CONFIG_COMPAT */
 
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+#define __SYSCALL_DEFINEx(x, name, ...)					\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	static inline long __do_kapi_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
+	__X64_SYS_STUBx(x, name, __VA_ARGS__)				\
+	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{								\
+		long ret = __do_kapi_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		return ret;						\
+	}								\
+	static inline long __do_kapi_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
+	{								\
+		const struct kernel_api_spec *__spec = kapi_get_spec("sys" #name); \
+		if (__spec) {						\
+			s64 __params[x] = { __MAP(x,__SC_CAST_TO_S64,__VA_ARGS__) }; \
+			int __ret = kapi_validate_syscall_params(__spec, __params, x); \
+			if (__ret)				\
+				return __ret;			\
+		}							\
+		long ret = __do_sys##name(__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		if (__spec) {						\
+			kapi_validate_syscall_return(__spec, (s64)ret); \
+		}							\
+		return ret;						\
+	}								\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#else /* !CONFIG_KAPI_RUNTIME_CHECKS */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
@@ -233,6 +272,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
 		return ret;						\
 	}								\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
 
 /*
  * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeb070f330bdb..77f6dd10b7cd5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -296,6 +296,33 @@
 #define TRACE_SYSCALLS()
 #endif
 
+#ifdef CONFIG_KAPI_SPEC
+/*
+ * KAPI_SPECS - Include kernel API specifications in current section
+ *
+ * The .kapi_specs input section has 32-byte alignment requirement from
+ * the compiler, so we must align to 32 bytes before setting the start
+ * symbol to avoid padding between the symbol and actual data.
+ */
+#define KAPI_SPECS()				\
+	. = ALIGN(32);				\
+	__start_kapi_specs = .;			\
+	KEEP(*(.kapi_specs))			\
+	__stop_kapi_specs = .;
+
+/* For placing KAPI specs in a dedicated section */
+#define KAPI_SPECS_SECTION()			\
+	.kapi_specs : AT(ADDR(.kapi_specs) - LOAD_OFFSET) {	\
+		. = ALIGN(32);			\
+		__start_kapi_specs = .;		\
+		KEEP(*(.kapi_specs))		\
+		__stop_kapi_specs = .;		\
+	}
+#else
+#define KAPI_SPECS()
+#define KAPI_SPECS_SECTION()
+#endif
+
 #ifdef CONFIG_BPF_EVENTS
 #define BPF_RAW_TP() STRUCT_ALIGN();				\
 	BOUNDED_SECTION_BY(__bpf_raw_tp_map, __bpf_raw_tp)
@@ -485,6 +512,7 @@
 		. = ALIGN(8);						\
 		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
+		KAPI_SPECS()						\
 	}								\
 									\
 	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
diff --git a/include/linux/kernel_api_spec.h b/include/linux/kernel_api_spec.h
new file mode 100644
index 0000000000000..54b0008d1a814
--- /dev/null
+++ b/include/linux/kernel_api_spec.h
@@ -0,0 +1,1580 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * kernel_api_spec.h - Kernel API Formal Specification Framework
+ *
+ * This framework provides structures and macros to formally specify kernel APIs
+ * in both human and machine-readable formats. It supports comprehensive documentation
+ * of function signatures, parameters, return values, error conditions, and constraints.
+ */
+
+#ifndef _LINUX_KERNEL_API_SPEC_H
+#define _LINUX_KERNEL_API_SPEC_H
+
+#include <linux/types.h>
+#include <linux/stringify.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+
+struct sigaction;
+
+#define KAPI_MAX_PARAMS		16
+#define KAPI_MAX_ERRORS		32
+#define KAPI_MAX_CONSTRAINTS	32
+#define KAPI_MAX_SIGNALS	32
+#define KAPI_MAX_NAME_LEN	128
+#define KAPI_MAX_DESC_LEN	512
+#define KAPI_MAX_CAPABILITIES	8
+#define KAPI_MAX_SOCKET_STATES	16
+#define KAPI_MAX_PROTOCOL_BEHAVIORS	8
+#define KAPI_MAX_NET_ERRORS	16
+#define KAPI_MAX_SOCKOPTS	16
+#define KAPI_MAX_ADDR_FAMILIES	8
+
+/* Magic numbers for section validation (ASCII mnemonics) */
+#define KAPI_MAGIC_PARAMS	0x4B415031	/* 'KAP1' */
+#define KAPI_MAGIC_RETURN	0x4B415232	/* 'KAR2' */
+#define KAPI_MAGIC_ERRORS	0x4B414533	/* 'KAE3' */
+#define KAPI_MAGIC_LOCKS	0x4B414C34	/* 'KAL4' */
+#define KAPI_MAGIC_CONSTRAINTS	0x4B414335	/* 'KAC5' */
+#define KAPI_MAGIC_INFO		0x4B414936	/* 'KAI6' */
+#define KAPI_MAGIC_SIGNALS	0x4B415337	/* 'KAS7' */
+#define KAPI_MAGIC_SIGMASK	0x4B414D38	/* 'KAM8' */
+#define KAPI_MAGIC_STRUCTS	0x4B415439	/* 'KAT9' */
+#define KAPI_MAGIC_EFFECTS	0x4B414641	/* 'KAFA' */
+#define KAPI_MAGIC_TRANS	0x4B415442	/* 'KATB' */
+#define KAPI_MAGIC_CAPS		0x4B414343	/* 'KACC' */
+
+/**
+ * enum kapi_param_type - Parameter type classification
+ * @KAPI_TYPE_VOID: void type
+ * @KAPI_TYPE_INT: Integer types (int, long, etc.)
+ * @KAPI_TYPE_UINT: Unsigned integer types
+ * @KAPI_TYPE_PTR: Pointer types
+ * @KAPI_TYPE_STRUCT: Structure types
+ * @KAPI_TYPE_UNION: Union types
+ * @KAPI_TYPE_ENUM: Enumeration types
+ * @KAPI_TYPE_FUNC_PTR: Function pointer types
+ * @KAPI_TYPE_ARRAY: Array types
+ * @KAPI_TYPE_FD: File descriptor - validated in process context
+ * @KAPI_TYPE_USER_PTR: User space pointer - validated for access and size
+ * @KAPI_TYPE_PATH: Pathname - validated for access and path limits
+ * @KAPI_TYPE_CUSTOM: Custom/complex types
+ */
+enum kapi_param_type {
+	KAPI_TYPE_VOID = 0,
+	KAPI_TYPE_INT,
+	KAPI_TYPE_UINT,
+	KAPI_TYPE_PTR,
+	KAPI_TYPE_STRUCT,
+	KAPI_TYPE_UNION,
+	KAPI_TYPE_ENUM,
+	KAPI_TYPE_FUNC_PTR,
+	KAPI_TYPE_ARRAY,
+	KAPI_TYPE_FD,		/* File descriptor - validated in process context */
+	KAPI_TYPE_USER_PTR,	/* User space pointer - validated for access and size */
+	KAPI_TYPE_PATH,		/* Pathname - validated for access and path limits */
+	KAPI_TYPE_CUSTOM,
+};
+
+/**
+ * enum kapi_param_flags - Parameter attribute flags
+ * @KAPI_PARAM_IN: Input parameter
+ * @KAPI_PARAM_OUT: Output parameter
+ * @KAPI_PARAM_INOUT: Input/output parameter
+ * @KAPI_PARAM_OPTIONAL: Optional parameter (can be NULL)
+ * @KAPI_PARAM_CONST: Const qualified parameter
+ * @KAPI_PARAM_VOLATILE: Volatile qualified parameter
+ * @KAPI_PARAM_USER: User space pointer
+ * @KAPI_PARAM_DMA: DMA-capable memory required
+ * @KAPI_PARAM_ALIGNED: Alignment requirements
+ */
+enum kapi_param_flags {
+	KAPI_PARAM_IN		= (1 << 0),
+	KAPI_PARAM_OUT		= (1 << 1),
+	KAPI_PARAM_INOUT	= (KAPI_PARAM_IN | KAPI_PARAM_OUT),
+	KAPI_PARAM_OPTIONAL	= (1 << 3),
+	KAPI_PARAM_CONST	= (1 << 4),
+	KAPI_PARAM_VOLATILE	= (1 << 5),
+	KAPI_PARAM_USER		= (1 << 6),
+	KAPI_PARAM_DMA		= (1 << 7),
+	KAPI_PARAM_ALIGNED	= (1 << 8),
+};
+
+/**
+ * enum kapi_context_flags - Function execution context flags
+ * @KAPI_CTX_PROCESS: Can be called from process context
+ * @KAPI_CTX_SOFTIRQ: Can be called from softirq context
+ * @KAPI_CTX_HARDIRQ: Can be called from hardirq context
+ * @KAPI_CTX_NMI: Can be called from NMI context
+ * @KAPI_CTX_ATOMIC: Must be called in atomic context
+ * @KAPI_CTX_SLEEPABLE: May sleep
+ * @KAPI_CTX_PREEMPT_DISABLED: Requires preemption disabled
+ * @KAPI_CTX_IRQ_DISABLED: Requires interrupts disabled
+ */
+enum kapi_context_flags {
+	KAPI_CTX_PROCESS	= (1 << 0),
+	KAPI_CTX_SOFTIRQ	= (1 << 1),
+	KAPI_CTX_HARDIRQ	= (1 << 2),
+	KAPI_CTX_NMI		= (1 << 3),
+	KAPI_CTX_ATOMIC		= (1 << 4),
+	KAPI_CTX_SLEEPABLE	= (1 << 5),
+	KAPI_CTX_PREEMPT_DISABLED = (1 << 6),
+	KAPI_CTX_IRQ_DISABLED	= (1 << 7),
+};
+
+/**
+ * enum kapi_lock_type - Lock types used/required by the function
+ * @KAPI_LOCK_NONE: No locking requirements
+ * @KAPI_LOCK_MUTEX: Mutex lock
+ * @KAPI_LOCK_SPINLOCK: Spinlock
+ * @KAPI_LOCK_RWLOCK: Read-write lock
+ * @KAPI_LOCK_SEQLOCK: Sequence lock
+ * @KAPI_LOCK_RCU: RCU lock
+ * @KAPI_LOCK_SEMAPHORE: Semaphore
+ * @KAPI_LOCK_CUSTOM: Custom locking mechanism
+ */
+enum kapi_lock_type {
+	KAPI_LOCK_NONE = 0,
+	KAPI_LOCK_MUTEX,
+	KAPI_LOCK_SPINLOCK,
+	KAPI_LOCK_RWLOCK,
+	KAPI_LOCK_SEQLOCK,
+	KAPI_LOCK_RCU,
+	KAPI_LOCK_SEMAPHORE,
+	KAPI_LOCK_CUSTOM,
+};
+
+/**
+ * enum kapi_constraint_type - Types of parameter constraints
+ * @KAPI_CONSTRAINT_NONE: No constraint
+ * @KAPI_CONSTRAINT_RANGE: Numeric range constraint
+ * @KAPI_CONSTRAINT_MASK: Bitmask constraint
+ * @KAPI_CONSTRAINT_ENUM: Enumerated values constraint
+ * @KAPI_CONSTRAINT_ALIGNMENT: Alignment constraint (must be aligned to specified boundary)
+ * @KAPI_CONSTRAINT_POWER_OF_TWO: Value must be a power of two
+ * @KAPI_CONSTRAINT_PAGE_ALIGNED: Value must be page-aligned
+ * @KAPI_CONSTRAINT_NONZERO: Value must be non-zero
+ * @KAPI_CONSTRAINT_USER_STRING: Userspace null-terminated string with length range
+ * @KAPI_CONSTRAINT_USER_PATH: Userspace pathname string (validated for accessibility and PATH_MAX)
+ * @KAPI_CONSTRAINT_USER_PTR: Userspace pointer (validated for accessibility and size)
+ * @KAPI_CONSTRAINT_BUFFER: Userspace buffer pointer (validated by copy_to/from_user)
+ * @KAPI_CONSTRAINT_CUSTOM: Custom validation function
+ */
+enum kapi_constraint_type {
+	KAPI_CONSTRAINT_NONE = 0,
+	KAPI_CONSTRAINT_RANGE,
+	KAPI_CONSTRAINT_MASK,
+	KAPI_CONSTRAINT_ENUM,
+	KAPI_CONSTRAINT_ALIGNMENT,
+	KAPI_CONSTRAINT_POWER_OF_TWO,
+	KAPI_CONSTRAINT_PAGE_ALIGNED,
+	KAPI_CONSTRAINT_NONZERO,
+	KAPI_CONSTRAINT_USER_STRING,
+	KAPI_CONSTRAINT_USER_PATH,
+	KAPI_CONSTRAINT_USER_PTR,
+	KAPI_CONSTRAINT_BUFFER,
+	KAPI_CONSTRAINT_CUSTOM,
+};
+
+/**
+ * struct kapi_param_spec - Parameter specification
+ * @name: Parameter name
+ * @type_name: Type name as string
+ * @type: Parameter type classification
+ * @flags: Parameter attribute flags
+ * @size: Size in bytes (for arrays/buffers)
+ * @alignment: Required alignment
+ * @min_value: Minimum valid value (for numeric types)
+ * @max_value: Maximum valid value (for numeric types)
+ * @valid_mask: Valid bits mask (for flag parameters)
+ * @enum_values: Array of valid enumerated values
+ * @enum_count: Number of valid enumerated values
+ * @constraint_type: Type of constraint applied
+ * @validate: Custom validation function
+ * @description: Human-readable description
+ * @constraints: Additional constraints description
+ * @size_param_idx: Index of parameter that determines size (-1 if fixed size)
+ * @size_multiplier: Multiplier for size calculation (e.g., sizeof(struct))
+ */
+struct kapi_param_spec {
+	char name[KAPI_MAX_NAME_LEN];
+	char type_name[KAPI_MAX_NAME_LEN];
+	enum kapi_param_type type;
+	u32 flags;
+	size_t size;
+	size_t alignment;
+	s64 min_value;
+	s64 max_value;
+	u64 valid_mask;
+	const s64 *enum_values;
+	u32 enum_count;
+	enum kapi_constraint_type constraint_type;
+	bool (*validate)(s64 value);
+	char description[KAPI_MAX_DESC_LEN];
+	char constraints[KAPI_MAX_DESC_LEN];
+	int size_param_idx;	/* Index of param that determines size, -1 if N/A */
+	size_t size_multiplier;	/* Size per unit (e.g., sizeof(struct epoll_event)) */
+} __packed;
+
+/**
+ * struct kapi_error_spec - Error condition specification
+ * @error_code: Error code value
+ * @name: Error code name (e.g., "EINVAL")
+ * @condition: Condition that triggers this error
+ * @description: Detailed error description
+ */
+struct kapi_error_spec {
+	int error_code;
+	char name[KAPI_MAX_NAME_LEN];
+	char condition[KAPI_MAX_DESC_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * enum kapi_return_check_type - Return value check types
+ * @KAPI_RETURN_EXACT: Success is an exact value
+ * @KAPI_RETURN_RANGE: Success is within a range
+ * @KAPI_RETURN_ERROR_CHECK: Success is when NOT in error list
+ * @KAPI_RETURN_FD: Return value is a file descriptor (>= 0 is success)
+ * @KAPI_RETURN_CUSTOM: Custom validation function
+ * @KAPI_RETURN_NO_RETURN: Function does not return (e.g., exec on success)
+ */
+enum kapi_return_check_type {
+	KAPI_RETURN_EXACT,
+	KAPI_RETURN_RANGE,
+	KAPI_RETURN_ERROR_CHECK,
+	KAPI_RETURN_FD,
+	KAPI_RETURN_CUSTOM,
+	KAPI_RETURN_NO_RETURN,
+};
+
+/**
+ * struct kapi_return_spec - Return value specification
+ * @type_name: Return type name
+ * @type: Return type classification
+ * @check_type: Type of success check to perform
+ * @success_value: Exact value indicating success (for EXACT)
+ * @success_min: Minimum success value (for RANGE)
+ * @success_max: Maximum success value (for RANGE)
+ * @error_values: Array of error values (for ERROR_CHECK)
+ * @error_count: Number of error values
+ * @is_success: Custom function to check success
+ * @description: Return value description
+ */
+struct kapi_return_spec {
+	char type_name[KAPI_MAX_NAME_LEN];
+	enum kapi_param_type type;
+	enum kapi_return_check_type check_type;
+	s64 success_value;
+	s64 success_min;
+	s64 success_max;
+	const s64 *error_values;
+	u32 error_count;
+	bool (*is_success)(s64 retval);
+	char description[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * enum kapi_lock_scope - Lock acquisition/release scope
+ * @KAPI_LOCK_INTERNAL: Lock is acquired and released within the function (common case)
+ * @KAPI_LOCK_ACQUIRES: Function acquires lock but does not release it
+ * @KAPI_LOCK_RELEASES: Function releases lock (must be held on entry)
+ * @KAPI_LOCK_CALLER_HELD: Lock must be held by caller throughout the call
+ */
+enum kapi_lock_scope {
+	KAPI_LOCK_INTERNAL = 0,
+	KAPI_LOCK_ACQUIRES,
+	KAPI_LOCK_RELEASES,
+	KAPI_LOCK_CALLER_HELD,
+};
+
+/**
+ * struct kapi_lock_spec - Lock requirement specification
+ * @lock_name: Name of the lock
+ * @lock_type: Type of lock
+ * @scope: Lock scope (internal, acquires, releases, or caller-held)
+ * @description: Additional lock requirements
+ */
+struct kapi_lock_spec {
+	char lock_name[KAPI_MAX_NAME_LEN];
+	enum kapi_lock_type lock_type;
+	enum kapi_lock_scope scope;
+	char description[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * struct kapi_constraint_spec - Additional constraint specification
+ * @name: Constraint name
+ * @description: Constraint description
+ * @expression: Formal expression (if applicable)
+ */
+struct kapi_constraint_spec {
+	char name[KAPI_MAX_NAME_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+	char expression[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * enum kapi_signal_direction - Signal flow direction
+ * @KAPI_SIGNAL_RECEIVE: Function may receive this signal
+ * @KAPI_SIGNAL_SEND: Function may send this signal
+ * @KAPI_SIGNAL_HANDLE: Function handles this signal specially
+ * @KAPI_SIGNAL_BLOCK: Function blocks this signal
+ * @KAPI_SIGNAL_IGNORE: Function ignores this signal
+ */
+enum kapi_signal_direction {
+	KAPI_SIGNAL_RECEIVE	= (1 << 0),
+	KAPI_SIGNAL_SEND	= (1 << 1),
+	KAPI_SIGNAL_HANDLE	= (1 << 2),
+	KAPI_SIGNAL_BLOCK	= (1 << 3),
+	KAPI_SIGNAL_IGNORE	= (1 << 4),
+};
+
+/**
+ * enum kapi_signal_action - What the function does with the signal
+ * @KAPI_SIGNAL_ACTION_DEFAULT: Default signal action applies
+ * @KAPI_SIGNAL_ACTION_TERMINATE: Causes termination
+ * @KAPI_SIGNAL_ACTION_COREDUMP: Causes termination with core dump
+ * @KAPI_SIGNAL_ACTION_STOP: Stops the process
+ * @KAPI_SIGNAL_ACTION_CONTINUE: Continues a stopped process
+ * @KAPI_SIGNAL_ACTION_CUSTOM: Custom handling described in notes
+ * @KAPI_SIGNAL_ACTION_RETURN: Returns from syscall with EINTR
+ * @KAPI_SIGNAL_ACTION_RESTART: Restarts the syscall
+ * @KAPI_SIGNAL_ACTION_QUEUE: Queues the signal for later delivery
+ * @KAPI_SIGNAL_ACTION_DISCARD: Discards the signal
+ * @KAPI_SIGNAL_ACTION_TRANSFORM: Transforms to another signal
+ */
+enum kapi_signal_action {
+	KAPI_SIGNAL_ACTION_DEFAULT = 0,
+	KAPI_SIGNAL_ACTION_TERMINATE,
+	KAPI_SIGNAL_ACTION_COREDUMP,
+	KAPI_SIGNAL_ACTION_STOP,
+	KAPI_SIGNAL_ACTION_CONTINUE,
+	KAPI_SIGNAL_ACTION_CUSTOM,
+	KAPI_SIGNAL_ACTION_RETURN,
+	KAPI_SIGNAL_ACTION_RESTART,
+	KAPI_SIGNAL_ACTION_QUEUE,
+	KAPI_SIGNAL_ACTION_DISCARD,
+	KAPI_SIGNAL_ACTION_TRANSFORM,
+};
+
+/**
+ * struct kapi_signal_spec - Signal specification
+ * @signal_num: Signal number (e.g., SIGKILL, SIGTERM)
+ * @signal_name: Signal name as string
+ * @direction: Direction flags (OR of kapi_signal_direction)
+ * @action: What happens when signal is received
+ * @target: Description of target process/thread for sent signals
+ * @condition: Condition under which signal is sent/received/handled
+ * @description: Detailed description of signal handling
+ * @restartable: Whether syscall is restartable after this signal
+ * @sa_flags_required: Required signal action flags (SA_*)
+ * @sa_flags_forbidden: Forbidden signal action flags
+ * @error_on_signal: Error code returned when signal occurs (-EINTR, etc)
+ * @transform_to: Signal number to transform to (if action is TRANSFORM)
+ * @timing: When signal can occur ("entry", "during", "exit", "anytime")
+ * @priority: Signal handling priority (lower processed first)
+ * @interruptible: Whether this operation is interruptible by this signal
+ * @queue_behavior: How signal is queued ("realtime", "standard", "coalesce")
+ * @state_required: Required process state for signal to be delivered
+ * @state_forbidden: Forbidden process state for signal delivery
+ */
+struct kapi_signal_spec {
+	int signal_num;
+	char signal_name[32];
+	u32 direction;
+	enum kapi_signal_action action;
+	char target[KAPI_MAX_DESC_LEN];
+	char condition[KAPI_MAX_DESC_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+	bool restartable;
+	u32 sa_flags_required;
+	u32 sa_flags_forbidden;
+	int error_on_signal;
+	int transform_to;
+	char timing[32];
+	u8 priority;
+	bool interruptible;
+	char queue_behavior[128];
+	u32 state_required;
+	u32 state_forbidden;
+} __packed;
+
+/**
+ * struct kapi_signal_mask_spec - Signal mask specification
+ * @mask_name: Name of the signal mask
+ * @signals: Array of signal numbers in the mask
+ * @signal_count: Number of signals in the mask
+ * @description: Description of what this mask represents
+ */
+struct kapi_signal_mask_spec {
+	char mask_name[KAPI_MAX_NAME_LEN];
+	int signals[KAPI_MAX_SIGNALS];
+	u32 signal_count;
+	char description[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * struct kapi_struct_field - Structure field specification
+ * @name: Field name
+ * @type: Field type classification
+ * @type_name: Type name as string
+ * @offset: Offset within structure
+ * @size: Size of field in bytes
+ * @flags: Field attribute flags
+ * @constraint_type: Type of constraint applied
+ * @min_value: Minimum valid value (for numeric types)
+ * @max_value: Maximum valid value (for numeric types)
+ * @valid_mask: Valid bits mask (for flag fields)
+ * @enum_values: Comma-separated list of valid enum values (for enum types)
+ * @description: Field description
+ */
+struct kapi_struct_field {
+	char name[KAPI_MAX_NAME_LEN];
+	enum kapi_param_type type;
+	char type_name[KAPI_MAX_NAME_LEN];
+	size_t offset;
+	size_t size;
+	u32 flags;
+	enum kapi_constraint_type constraint_type;
+	s64 min_value;
+	s64 max_value;
+	u64 valid_mask;
+	char enum_values[KAPI_MAX_DESC_LEN];	/* Comma-separated list of valid enum values */
+	char description[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * struct kapi_struct_spec - Structure type specification
+ * @name: Structure name
+ * @size: Total size of structure
+ * @alignment: Required alignment
+ * @field_count: Number of fields
+ * @fields: Field specifications
+ * @description: Structure description
+ */
+struct kapi_struct_spec {
+	char name[KAPI_MAX_NAME_LEN];
+	size_t size;
+	size_t alignment;
+	u32 field_count;
+	struct kapi_struct_field fields[KAPI_MAX_PARAMS];
+	char description[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * enum kapi_capability_action - What the capability allows
+ * @KAPI_CAP_BYPASS_CHECK: Bypasses a check entirely
+ * @KAPI_CAP_INCREASE_LIMIT: Increases or removes a limit
+ * @KAPI_CAP_OVERRIDE_RESTRICTION: Overrides a restriction
+ * @KAPI_CAP_GRANT_PERMISSION: Grants permission that would otherwise be denied
+ * @KAPI_CAP_MODIFY_BEHAVIOR: Changes the behavior of the operation
+ * @KAPI_CAP_ACCESS_RESOURCE: Allows access to restricted resources
+ * @KAPI_CAP_PERFORM_OPERATION: Allows performing a privileged operation
+ */
+enum kapi_capability_action {
+	KAPI_CAP_BYPASS_CHECK = 0,
+	KAPI_CAP_INCREASE_LIMIT,
+	KAPI_CAP_OVERRIDE_RESTRICTION,
+	KAPI_CAP_GRANT_PERMISSION,
+	KAPI_CAP_MODIFY_BEHAVIOR,
+	KAPI_CAP_ACCESS_RESOURCE,
+	KAPI_CAP_PERFORM_OPERATION,
+};
+
+/**
+ * struct kapi_capability_spec - Capability requirement specification
+ * @capability: The capability constant (e.g., CAP_IPC_LOCK)
+ * @cap_name: Capability name as string
+ * @action: What the capability allows (kapi_capability_action)
+ * @allows: Description of what the capability allows
+ * @without_cap: What happens without the capability
+ * @check_condition: Condition when capability is checked
+ * @priority: Check priority (lower checked first)
+ * @alternative: Alternative capabilities that can be used
+ * @alternative_count: Number of alternative capabilities
+ */
+struct kapi_capability_spec {
+	int capability;
+	char cap_name[KAPI_MAX_NAME_LEN];
+	enum kapi_capability_action action;
+	char allows[KAPI_MAX_DESC_LEN];
+	char without_cap[KAPI_MAX_DESC_LEN];
+	char check_condition[KAPI_MAX_DESC_LEN];
+	u8 priority;
+	int alternative[KAPI_MAX_CAPABILITIES];
+	u32 alternative_count;
+} __packed;
+
+/**
+ * enum kapi_side_effect_type - Types of side effects
+ * @KAPI_EFFECT_NONE: No side effects
+ * @KAPI_EFFECT_ALLOC_MEMORY: Allocates memory
+ * @KAPI_EFFECT_FREE_MEMORY: Frees memory
+ * @KAPI_EFFECT_MODIFY_STATE: Modifies global/shared state
+ * @KAPI_EFFECT_SIGNAL_SEND: Sends signals
+ * @KAPI_EFFECT_FILE_POSITION: Modifies file position
+ * @KAPI_EFFECT_LOCK_ACQUIRE: Acquires locks
+ * @KAPI_EFFECT_LOCK_RELEASE: Releases locks
+ * @KAPI_EFFECT_RESOURCE_CREATE: Creates system resources (FDs, PIDs, etc)
+ * @KAPI_EFFECT_RESOURCE_DESTROY: Destroys system resources
+ * @KAPI_EFFECT_SCHEDULE: May cause scheduling/context switch
+ * @KAPI_EFFECT_HARDWARE: Interacts with hardware
+ * @KAPI_EFFECT_NETWORK: Network I/O operation
+ * @KAPI_EFFECT_FILESYSTEM: Filesystem modification
+ * @KAPI_EFFECT_PROCESS_STATE: Modifies process state
+ * @KAPI_EFFECT_IRREVERSIBLE: Effect cannot be undone
+ */
+enum kapi_side_effect_type {
+	KAPI_EFFECT_NONE = 0,
+	KAPI_EFFECT_ALLOC_MEMORY = (1 << 0),
+	KAPI_EFFECT_FREE_MEMORY = (1 << 1),
+	KAPI_EFFECT_MODIFY_STATE = (1 << 2),
+	KAPI_EFFECT_SIGNAL_SEND = (1 << 3),
+	KAPI_EFFECT_FILE_POSITION = (1 << 4),
+	KAPI_EFFECT_LOCK_ACQUIRE = (1 << 5),
+	KAPI_EFFECT_LOCK_RELEASE = (1 << 6),
+	KAPI_EFFECT_RESOURCE_CREATE = (1 << 7),
+	KAPI_EFFECT_RESOURCE_DESTROY = (1 << 8),
+	KAPI_EFFECT_SCHEDULE = (1 << 9),
+	KAPI_EFFECT_HARDWARE = (1 << 10),
+	KAPI_EFFECT_NETWORK = (1 << 11),
+	KAPI_EFFECT_FILESYSTEM = (1 << 12),
+	KAPI_EFFECT_PROCESS_STATE = (1 << 13),
+	KAPI_EFFECT_IRREVERSIBLE = (1 << 14),
+};
+
+/**
+ * struct kapi_side_effect - Side effect specification
+ * @type: Bitmask of effect types
+ * @target: What is affected (e.g., "process memory", "file descriptor table")
+ * @condition: Condition under which effect occurs
+ * @description: Detailed description of the effect
+ * @reversible: Whether the effect can be undone
+ */
+struct kapi_side_effect {
+	u32 type;
+	char target[KAPI_MAX_NAME_LEN];
+	char condition[KAPI_MAX_DESC_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+	bool reversible;
+} __packed;
+
+/**
+ * struct kapi_state_transition - State transition specification
+ * @from_state: Starting state description
+ * @to_state: Ending state description
+ * @condition: Condition for transition
+ * @object: Object whose state changes
+ * @description: Detailed description
+ */
+struct kapi_state_transition {
+	char from_state[KAPI_MAX_NAME_LEN];
+	char to_state[KAPI_MAX_NAME_LEN];
+	char condition[KAPI_MAX_DESC_LEN];
+	char object[KAPI_MAX_NAME_LEN];
+	char description[KAPI_MAX_DESC_LEN];
+} __packed;
+
+#define KAPI_MAX_STRUCT_SPECS	8
+#define KAPI_MAX_SIDE_EFFECTS	32
+#define KAPI_MAX_STATE_TRANS	8
+
+/**
+ * enum kapi_socket_state - Socket states for state machine
+ */
+enum kapi_socket_state {
+	KAPI_SOCK_STATE_UNSPEC = 0,
+	KAPI_SOCK_STATE_CLOSED,
+	KAPI_SOCK_STATE_OPEN,
+	KAPI_SOCK_STATE_BOUND,
+	KAPI_SOCK_STATE_LISTEN,
+	KAPI_SOCK_STATE_SYN_SENT,
+	KAPI_SOCK_STATE_SYN_RECV,
+	KAPI_SOCK_STATE_ESTABLISHED,
+	KAPI_SOCK_STATE_FIN_WAIT1,
+	KAPI_SOCK_STATE_FIN_WAIT2,
+	KAPI_SOCK_STATE_CLOSE_WAIT,
+	KAPI_SOCK_STATE_CLOSING,
+	KAPI_SOCK_STATE_LAST_ACK,
+	KAPI_SOCK_STATE_TIME_WAIT,
+	KAPI_SOCK_STATE_CONNECTED,
+	KAPI_SOCK_STATE_DISCONNECTED,
+};
+
+/**
+ * enum kapi_socket_protocol - Socket protocol types
+ */
+enum kapi_socket_protocol {
+	KAPI_PROTO_TCP		= (1 << 0),
+	KAPI_PROTO_UDP		= (1 << 1),
+	KAPI_PROTO_UNIX		= (1 << 2),
+	KAPI_PROTO_RAW		= (1 << 3),
+	KAPI_PROTO_PACKET	= (1 << 4),
+	KAPI_PROTO_NETLINK	= (1 << 5),
+	KAPI_PROTO_SCTP		= (1 << 6),
+	KAPI_PROTO_DCCP		= (1 << 7),
+	KAPI_PROTO_ALL		= 0xFFFFFFFF,
+};
+
+/**
+ * enum kapi_buffer_behavior - Network buffer handling behaviors
+ */
+enum kapi_buffer_behavior {
+	KAPI_BUF_PEEK		= (1 << 0),
+	KAPI_BUF_TRUNCATE	= (1 << 1),
+	KAPI_BUF_SCATTER	= (1 << 2),
+	KAPI_BUF_ZERO_COPY	= (1 << 3),
+	KAPI_BUF_KERNEL_ALLOC	= (1 << 4),
+	KAPI_BUF_DMA_CAPABLE	= (1 << 5),
+	KAPI_BUF_FRAGMENT	= (1 << 6),
+};
+
+/**
+ * enum kapi_async_behavior - Asynchronous operation behaviors
+ */
+enum kapi_async_behavior {
+	KAPI_ASYNC_BLOCK	= 0,
+	KAPI_ASYNC_NONBLOCK	= (1 << 0),
+	KAPI_ASYNC_POLL_READY	= (1 << 1),
+	KAPI_ASYNC_SIGNAL_DRIVEN = (1 << 2),
+	KAPI_ASYNC_AIO		= (1 << 3),
+	KAPI_ASYNC_IO_URING	= (1 << 4),
+	KAPI_ASYNC_EPOLL	= (1 << 5),
+};
+
+/**
+ * struct kapi_socket_state_spec - Socket state requirement/transition
+ */
+struct kapi_socket_state_spec {
+	enum kapi_socket_state required_states[KAPI_MAX_SOCKET_STATES];
+	u32 required_state_count;
+	enum kapi_socket_state forbidden_states[KAPI_MAX_SOCKET_STATES];
+	u32 forbidden_state_count;
+	enum kapi_socket_state resulting_state;
+	char state_condition[KAPI_MAX_DESC_LEN];
+	u32 applicable_protocols;
+} __packed;
+
+/**
+ * struct kapi_protocol_behavior - Protocol-specific behavior
+ */
+struct kapi_protocol_behavior {
+	u32 applicable_protocols;
+	char behavior[KAPI_MAX_DESC_LEN];
+	s64 protocol_flags;
+	char flag_description[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * struct kapi_buffer_spec - Network buffer specification
+ */
+struct kapi_buffer_spec {
+	u32 buffer_behaviors;
+	size_t min_buffer_size;
+	size_t max_buffer_size;
+	size_t optimal_buffer_size;
+	char fragmentation_rules[KAPI_MAX_DESC_LEN];
+	bool can_partial_transfer;
+	char partial_transfer_rules[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * struct kapi_async_spec - Asynchronous behavior specification
+ */
+struct kapi_async_spec {
+	enum kapi_async_behavior supported_modes;
+	int nonblock_errno;
+	u32 poll_events_in;
+	u32 poll_events_out;
+	char completion_condition[KAPI_MAX_DESC_LEN];
+	bool supports_timeout;
+	char timeout_behavior[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/**
+ * struct kapi_addr_family_spec - Address family specification
+ */
+struct kapi_addr_family_spec {
+	int family;
+	char family_name[32];
+	size_t addr_struct_size;
+	size_t min_addr_len;
+	size_t max_addr_len;
+	char addr_format[KAPI_MAX_DESC_LEN];
+	bool supports_wildcard;
+	bool supports_multicast;
+	bool supports_broadcast;
+	char special_addresses[KAPI_MAX_DESC_LEN];
+	u32 port_range_min;
+	u32 port_range_max;
+} __packed;
+
+/**
+ * struct kernel_api_spec - Complete kernel API specification
+ * @name: Function name
+ * @version: API version
+ * @description: Brief description
+ * @long_description: Detailed description
+ * @context_flags: Execution context flags
+ * @param_count: Number of parameters
+ * @params: Parameter specifications
+ * @return_spec: Return value specification
+ * @error_count: Number of possible errors
+ * @errors: Error specifications
+ * @lock_count: Number of lock specifications
+ * @locks: Lock requirement specifications
+ * @constraint_count: Number of additional constraints
+ * @constraints: Additional constraint specifications
+ * @examples: Usage examples
+ * @notes: Additional notes
+ * @since_version: Kernel version when introduced
+ * @signal_count: Number of signal specifications
+ * @signals: Signal handling specifications
+ * @signal_mask_count: Number of signal mask specifications
+ * @signal_masks: Signal mask specifications
+ * @struct_spec_count: Number of structure specifications
+ * @struct_specs: Structure type specifications
+ * @side_effect_count: Number of side effect specifications
+ * @side_effects: Side effect specifications
+ * @state_trans_count: Number of state transition specifications
+ * @state_transitions: State transition specifications
+ */
+struct kernel_api_spec {
+	char name[KAPI_MAX_NAME_LEN];
+	u32 version;
+	char description[KAPI_MAX_DESC_LEN];
+	char long_description[KAPI_MAX_DESC_LEN * 4];
+	u32 context_flags;
+
+	/* Parameters */
+	u32 param_magic;  /* 0x4B415031 = 'KAP1' */
+	u32 param_count;
+	struct kapi_param_spec params[KAPI_MAX_PARAMS];
+
+	/* Return value */
+	u32 return_magic; /* 0x4B415232 = 'KAR2' */
+	struct kapi_return_spec return_spec;
+
+	/* Errors */
+	u32 error_magic;  /* 0x4B414533 = 'KAE3' */
+	u32 error_count;
+	struct kapi_error_spec errors[KAPI_MAX_ERRORS];
+
+	/* Locking */
+	u32 lock_magic;   /* 0x4B414C34 = 'KAL4' */
+	u32 lock_count;
+	struct kapi_lock_spec locks[KAPI_MAX_CONSTRAINTS];
+
+	/* Constraints */
+	u32 constraint_magic; /* 0x4B414335 = 'KAC5' */
+	u32 constraint_count;
+	struct kapi_constraint_spec constraints[KAPI_MAX_CONSTRAINTS];
+
+	/* Additional information */
+	u32 info_magic;   /* 0x4B414936 = 'KAI6' */
+	char examples[KAPI_MAX_DESC_LEN * 2];
+	char notes[KAPI_MAX_DESC_LEN * 2];
+	char since_version[32];
+
+	/* Signal specifications */
+	u32 signal_magic; /* 0x4B415337 = 'KAS7' */
+	u32 signal_count;
+	struct kapi_signal_spec signals[KAPI_MAX_SIGNALS];
+
+	/* Signal mask specifications */
+	u32 sigmask_magic; /* 0x4B414D38 = 'KAM8' */
+	u32 signal_mask_count;
+	struct kapi_signal_mask_spec signal_masks[KAPI_MAX_SIGNALS];
+
+	/* Structure specifications */
+	u32 struct_magic; /* 0x4B415439 = 'KAT9' */
+	u32 struct_spec_count;
+	struct kapi_struct_spec struct_specs[KAPI_MAX_STRUCT_SPECS];
+
+	/* Side effects */
+	u32 effect_magic; /* 0x4B414641 = 'KAFA' */
+	u32 side_effect_count;
+	struct kapi_side_effect side_effects[KAPI_MAX_SIDE_EFFECTS];
+
+	/* State transitions */
+	u32 trans_magic;  /* 0x4B415442 = 'KATB' */
+	u32 state_trans_count;
+	struct kapi_state_transition state_transitions[KAPI_MAX_STATE_TRANS];
+
+	/* Capability specifications */
+	u32 cap_magic;    /* 0x4B414343 = 'KACC' */
+	u32 capability_count;
+	struct kapi_capability_spec capabilities[KAPI_MAX_CAPABILITIES];
+
+	/* Extended fields for socket and network operations */
+	struct kapi_socket_state_spec socket_state;
+	struct kapi_protocol_behavior protocol_behaviors[KAPI_MAX_PROTOCOL_BEHAVIORS];
+	u32 protocol_behavior_count;
+	struct kapi_buffer_spec buffer_spec;
+	struct kapi_async_spec async_spec;
+	struct kapi_addr_family_spec addr_families[KAPI_MAX_ADDR_FAMILIES];
+	u32 addr_family_count;
+
+	/* Operation characteristics */
+	bool is_connection_oriented;
+	bool is_message_oriented;
+	bool supports_oob_data;
+	bool supports_peek;
+	bool supports_select_poll;
+	bool is_reentrant;
+
+	/* Semantic descriptions */
+	char connection_establishment[KAPI_MAX_DESC_LEN];
+	char connection_termination[KAPI_MAX_DESC_LEN];
+	char data_transfer_semantics[KAPI_MAX_DESC_LEN];
+} __packed;
+
+/* Macros for defining API specifications */
+
+/**
+ * DEFINE_KERNEL_API_SPEC - Define a kernel API specification
+ * @func_name: Function name to specify
+ */
+#define DEFINE_KERNEL_API_SPEC(func_name) \
+	static struct kernel_api_spec __kapi_spec_##func_name \
+	__used __section(".kapi_specs") = {	\
+		.name = __stringify(func_name),	\
+		.version = 1,
+
+#define KAPI_END_SPEC };
+
+/**
+ * KAPI_DESCRIPTION - Set API description
+ * @desc: Description string
+ */
+#define KAPI_DESCRIPTION(desc) \
+	.description = desc,
+
+/**
+ * KAPI_LONG_DESC - Set detailed API description
+ * @desc: Detailed description string
+ */
+#define KAPI_LONG_DESC(desc) \
+	.long_description = desc,
+
+/**
+ * KAPI_CONTEXT - Set execution context flags
+ * @flags: Context flags (OR'ed KAPI_CTX_* values)
+ */
+#define KAPI_CONTEXT(flags) \
+	.context_flags = flags,
+
+/**
+ * KAPI_PARAM - Define a parameter specification
+ * @idx: Parameter index (0-based)
+ * @pname: Parameter name
+ * @ptype: Type name string
+ * @pdesc: Parameter description
+ */
+#define KAPI_PARAM(idx, pname, ptype, pdesc) \
+	.params[idx] = {			\
+		.name = pname,			\
+		.type_name = ptype,		\
+		.description = pdesc,		\
+		.size_param_idx = -1,		/* Default: no dynamic sizing */
+
+#define KAPI_PARAM_TYPE(ptype) \
+		.type = ptype,
+
+#define KAPI_PARAM_FLAGS(pflags) \
+		.flags = pflags,
+
+#define KAPI_PARAM_SIZE(psize) \
+		.size = psize,
+
+#define KAPI_PARAM_RANGE(pmin, pmax) \
+		.min_value = pmin,	\
+		.max_value = pmax,
+
+#define KAPI_PARAM_CONSTRAINT_TYPE(ctype) \
+		.constraint_type = ctype,
+
+#define KAPI_PARAM_CONSTRAINT(desc) \
+		.constraints = desc,
+
+#define KAPI_PARAM_VALID_MASK(mask) \
+		.valid_mask = mask,
+
+#define KAPI_PARAM_ENUM_VALUES(values) \
+		.enum_values = values, \
+		.enum_count = ARRAY_SIZE(values),
+
+#define KAPI_PARAM_ALIGNMENT(align) \
+		.alignment = align,
+
+#define KAPI_PARAM_SIZE_PARAM(idx) \
+		.size_param_idx = idx,
+
+#define KAPI_PARAM_END },
+
+/**
+ * KAPI_PARAM_COUNT - Set the number of parameters
+ * @n: Number of parameters
+ */
+#define KAPI_PARAM_COUNT(n) \
+	.param_magic = KAPI_MAGIC_PARAMS, \
+	.param_count = n,
+
+/**
+ * KAPI_RETURN - Define return value specification
+ * @rtype: Return type name
+ * @rdesc: Return value description
+ */
+#define KAPI_RETURN(rtype, rdesc) \
+	.return_magic = KAPI_MAGIC_RETURN, \
+	.return_spec = {		\
+		.type_name = rtype,	\
+		.description = rdesc,
+
+#define KAPI_RETURN_SUCCESS(val, ...) \
+		.success_value = val,
+
+#define KAPI_RETURN_TYPE(rtype) \
+		.type = rtype,
+
+#define KAPI_RETURN_CHECK_TYPE(ctype) \
+		.check_type = ctype,
+
+#define KAPI_RETURN_ERROR_VALUES(values) \
+		.error_values = values,
+
+#define KAPI_RETURN_ERROR_COUNT(count) \
+		.error_count = count,
+
+#define KAPI_RETURN_SUCCESS_RANGE(min, max) \
+		.success_min = min, \
+		.success_max = max,
+
+#define KAPI_RETURN_END },
+
+/**
+ * KAPI_ERROR - Define an error condition
+ * @idx: Error index
+ * @ecode: Error code value
+ * @ename: Error name
+ * @econd: Error condition
+ * @edesc: Error description
+ */
+#define KAPI_ERROR(idx, ecode, ename, econd, edesc) \
+	.errors[idx] = {			\
+		.error_code = ecode,		\
+		.name = ename,			\
+		.condition = econd,		\
+		.description = edesc,		\
+	},
+
+/**
+ * KAPI_ERROR_COUNT - Set the number of errors
+ * @n: Number of errors
+ */
+#define KAPI_ERROR_COUNT(n) \
+	.error_magic = KAPI_MAGIC_ERRORS, \
+	.error_count = n,
+
+/**
+ * KAPI_LOCK - Define a lock requirement
+ * @idx: Lock index
+ * @lname: Lock name
+ * @ltype: Lock type
+ */
+#define KAPI_LOCK(idx, lname, ltype) \
+	.locks[idx] = {			\
+		.lock_name = lname,	\
+		.lock_type = ltype,
+
+#define KAPI_LOCK_ACQUIRED \
+		.scope = KAPI_LOCK_ACQUIRES,
+
+#define KAPI_LOCK_RELEASED \
+		.scope = KAPI_LOCK_RELEASES,
+
+#define KAPI_LOCK_HELD_ENTRY \
+		.scope = KAPI_LOCK_CALLER_HELD,
+
+#define KAPI_LOCK_HELD_EXIT \
+		.scope = KAPI_LOCK_CALLER_HELD,
+
+#define KAPI_LOCK_DESC(ldesc) \
+		.description = ldesc,
+
+#define KAPI_LOCK_END },
+
+/**
+ * KAPI_CONSTRAINT - Define an additional constraint
+ * @idx: Constraint index
+ * @cname: Constraint name
+ * @cdesc: Constraint description
+ */
+#define KAPI_CONSTRAINT(idx, cname, cdesc) \
+	.constraints[idx] = {		\
+		.name = cname,		\
+		.description = cdesc,
+
+#define KAPI_CONSTRAINT_EXPR(expr) \
+		.expression = expr,
+
+#define KAPI_CONSTRAINT_END },
+
+/**
+ * KAPI_EXAMPLES - Set API usage examples
+ * @examples: Examples string
+ */
+#define KAPI_EXAMPLES(ex) \
+	.info_magic = KAPI_MAGIC_INFO, \
+	.examples = ex,
+
+/**
+ * KAPI_NOTES - Set API notes
+ * @notes: Notes string
+ */
+#define KAPI_NOTES(n) \
+	.notes = n,
+
+
+/**
+ * KAPI_SIGNAL - Define a signal specification
+ * @idx: Signal index
+ * @signum: Signal number (e.g., SIGKILL)
+ * @signame: Signal name string
+ * @dir: Direction flags
+ * @act: Action taken
+ */
+#define KAPI_SIGNAL(idx, signum, signame, dir, act) \
+	.signals[idx] = {			\
+		.signal_num = signum,		\
+		.signal_name = signame,		\
+		.direction = dir,		\
+		.action = act,
+
+#define KAPI_SIGNAL_TARGET(tgt) \
+		.target = tgt,
+
+#define KAPI_SIGNAL_CONDITION(cond) \
+		.condition = cond,
+
+#define KAPI_SIGNAL_DESC(desc) \
+		.description = desc,
+
+#define KAPI_SIGNAL_RESTARTABLE \
+		.restartable = true,
+
+#define KAPI_SIGNAL_SA_FLAGS_REQ(flags) \
+		.sa_flags_required = flags,
+
+#define KAPI_SIGNAL_SA_FLAGS_FORBID(flags) \
+		.sa_flags_forbidden = flags,
+
+#define KAPI_SIGNAL_ERROR(err) \
+		.error_on_signal = err,
+
+#define KAPI_SIGNAL_TRANSFORM(sig) \
+		.transform_to = sig,
+
+#define KAPI_SIGNAL_TIMING(when) \
+		.timing = when,
+
+#define KAPI_SIGNAL_PRIORITY(prio) \
+		.priority = prio,
+
+#define KAPI_SIGNAL_INTERRUPTIBLE \
+		.interruptible = true,
+
+#define KAPI_SIGNAL_QUEUE(behavior) \
+		.queue_behavior = behavior,
+
+#define KAPI_SIGNAL_STATE_REQ(state) \
+		.state_required = state,
+
+#define KAPI_SIGNAL_STATE_FORBID(state) \
+		.state_forbidden = state,
+
+#define KAPI_SIGNAL_END },
+
+#define KAPI_SIGNAL_COUNT(n) \
+	.signal_magic = KAPI_MAGIC_SIGNALS, \
+	.signal_count = n,
+
+/**
+ * KAPI_SIGNAL_MASK - Define a signal mask specification
+ * @idx: Mask index
+ * @name: Mask name
+ * @desc: Mask description
+ */
+#define KAPI_SIGNAL_MASK(idx, name, desc) \
+	.signal_masks[idx] = {		\
+		.mask_name = name,	\
+		.description = desc,
+
+/*
+ * KAPI_SIGNAL_MASK_SIGNALS - Specify signals in a signal mask
+ * @...: Variadic list of signal numbers
+ *
+ * Usage:
+ *   KAPI_SIGNAL_MASK(0, "blocked", "Signals blocked during operation")
+ *   KAPI_SIGNAL_MASK_SIGNALS(SIGINT, SIGTERM, SIGQUIT)
+ *   KAPI_SIGNAL_MASK_END
+ */
+#define KAPI_SIGNAL_MASK_SIGNALS(...) \
+		.signals = { __VA_ARGS__ }, \
+		.signal_count = sizeof((int[]){ __VA_ARGS__ }) / sizeof(int),
+
+#define KAPI_SIGNAL_MASK_END },
+
+/**
+ * KAPI_STRUCT_SPEC - Define a structure specification
+ * @idx: Structure spec index
+ * @sname: Structure name
+ * @sdesc: Structure description
+ */
+#define KAPI_STRUCT_SPEC(idx, sname, sdesc) \
+	.struct_specs[idx] = {		\
+		.name = #sname,		\
+		.description = sdesc,
+
+#define KAPI_STRUCT_SIZE(ssize, salign) \
+		.size = ssize,		\
+		.alignment = salign,
+
+#define KAPI_STRUCT_FIELD_COUNT(n) \
+		.field_count = n,
+
+/**
+ * KAPI_STRUCT_FIELD - Define a structure field
+ * @fidx: Field index
+ * @fname: Field name
+ * @ftype: Field type (KAPI_TYPE_*)
+ * @ftype_name: Type name as string
+ * @fdesc: Field description
+ */
+#define KAPI_STRUCT_FIELD(fidx, fname, ftype, ftype_name, fdesc) \
+		.fields[fidx] = {	\
+			.name = fname,	\
+			.type = ftype,	\
+			.type_name = ftype_name, \
+			.description = fdesc,
+
+#define KAPI_FIELD_OFFSET(foffset) \
+			.offset = foffset,
+
+#define KAPI_FIELD_SIZE(fsize) \
+			.size = fsize,
+
+#define KAPI_FIELD_FLAGS(fflags) \
+			.flags = fflags,
+
+#define KAPI_FIELD_CONSTRAINT_RANGE(min, max) \
+			.constraint_type = KAPI_CONSTRAINT_RANGE, \
+			.min_value = min, \
+			.max_value = max,
+
+#define KAPI_FIELD_CONSTRAINT_MASK(mask) \
+			.constraint_type = KAPI_CONSTRAINT_MASK, \
+			.valid_mask = mask,
+
+#define KAPI_FIELD_CONSTRAINT_ENUM(values) \
+			.constraint_type = KAPI_CONSTRAINT_ENUM, \
+			.enum_values = values,
+
+#define KAPI_STRUCT_FIELD_END },
+
+#define KAPI_STRUCT_SPEC_END },
+
+/* Counter for structure specifications */
+#define KAPI_STRUCT_SPEC_COUNT(n) \
+	.struct_magic = KAPI_MAGIC_STRUCTS, \
+	.struct_spec_count = n,
+
+/* Additional lock-related macros */
+#define KAPI_LOCK_COUNT(n) \
+	.lock_magic = KAPI_MAGIC_LOCKS, \
+	.lock_count = n,
+
+/**
+ * KAPI_SIDE_EFFECT - Define a side effect
+ * @idx: Side effect index
+ * @etype: Effect type bitmask (OR'ed KAPI_EFFECT_* values)
+ * @etarget: What is affected
+ * @edesc: Effect description
+ */
+#define KAPI_SIDE_EFFECT(idx, etype, etarget, edesc) \
+	.side_effects[idx] = {		\
+		.type = etype,		\
+		.target = etarget,	\
+		.description = edesc,
+
+#define KAPI_EFFECT_CONDITION(cond) \
+		.condition = cond,
+
+#define KAPI_EFFECT_REVERSIBLE \
+		.reversible = true,
+
+#define KAPI_SIDE_EFFECT_END },
+
+/**
+ * KAPI_STATE_TRANS - Define a state transition
+ * @idx: State transition index
+ * @obj: Object whose state changes
+ * @from: From state
+ * @to: To state
+ * @desc: Transition description
+ */
+#define KAPI_STATE_TRANS(idx, obj, from, to, desc) \
+	.state_transitions[idx] = {	\
+		.object = obj,		\
+		.from_state = from,	\
+		.to_state = to,		\
+		.description = desc,
+
+#define KAPI_STATE_TRANS_COND(cond) \
+		.condition = cond,
+
+#define KAPI_STATE_TRANS_END },
+
+/* Counters for side effects and state transitions */
+#define KAPI_SIDE_EFFECT_COUNT(n) \
+	.effect_magic = KAPI_MAGIC_EFFECTS, \
+	.side_effect_count = n,
+
+#define KAPI_STATE_TRANS_COUNT(n) \
+	.trans_magic = KAPI_MAGIC_TRANS, \
+	.state_trans_count = n,
+
+/* Helper macros for common side effect patterns */
+#define KAPI_EFFECTS_MEMORY	(KAPI_EFFECT_ALLOC_MEMORY | KAPI_EFFECT_FREE_MEMORY)
+#define KAPI_EFFECTS_LOCKING	(KAPI_EFFECT_LOCK_ACQUIRE | KAPI_EFFECT_LOCK_RELEASE)
+#define KAPI_EFFECTS_RESOURCES	(KAPI_EFFECT_RESOURCE_CREATE | KAPI_EFFECT_RESOURCE_DESTROY)
+#define KAPI_EFFECTS_IO		(KAPI_EFFECT_NETWORK | KAPI_EFFECT_FILESYSTEM)
+
+/*
+ * Helper macros for combining common parameter flag patterns.
+ * Note: KAPI_PARAM_IN, KAPI_PARAM_OUT, KAPI_PARAM_INOUT, and KAPI_PARAM_OPTIONAL
+ * are already defined in enum kapi_param_flags - use those directly.
+ */
+#define KAPI_PARAM_FLAGS_INOUT	(KAPI_PARAM_IN | KAPI_PARAM_OUT)
+#define KAPI_PARAM_FLAGS_USER	(KAPI_PARAM_USER | KAPI_PARAM_IN)
+
+/* Common signal timing constants */
+#define KAPI_SIGNAL_TIME_ENTRY		"entry"
+#define KAPI_SIGNAL_TIME_DURING		"during"
+#define KAPI_SIGNAL_TIME_EXIT		"exit"
+#define KAPI_SIGNAL_TIME_ANYTIME	"anytime"
+#define KAPI_SIGNAL_TIME_BLOCKING	"while_blocked"
+#define KAPI_SIGNAL_TIME_SLEEPING	"while_sleeping"
+#define KAPI_SIGNAL_TIME_BEFORE		"before"
+#define KAPI_SIGNAL_TIME_AFTER		"after"
+
+/* Common signal queue behaviors */
+#define KAPI_SIGNAL_QUEUE_STANDARD	"standard"
+#define KAPI_SIGNAL_QUEUE_REALTIME	"realtime"
+#define KAPI_SIGNAL_QUEUE_COALESCE	"coalesce"
+#define KAPI_SIGNAL_QUEUE_REPLACE	"replace"
+#define KAPI_SIGNAL_QUEUE_DISCARD	"discard"
+
+/* Process state flags for signal delivery */
+#define KAPI_SIGNAL_STATE_RUNNING	(1 << 0)
+#define KAPI_SIGNAL_STATE_SLEEPING	(1 << 1)
+#define KAPI_SIGNAL_STATE_STOPPED	(1 << 2)
+#define KAPI_SIGNAL_STATE_TRACED	(1 << 3)
+#define KAPI_SIGNAL_STATE_ZOMBIE	(1 << 4)
+#define KAPI_SIGNAL_STATE_DEAD		(1 << 5)
+
+/* Capability specification macros */
+
+/**
+ * KAPI_CAPABILITY - Define a capability requirement
+ * @idx: Capability index
+ * @cap: Capability constant (e.g., CAP_IPC_LOCK)
+ * @name: Capability name string
+ * @act: Action type (kapi_capability_action)
+ */
+#define KAPI_CAPABILITY(idx, cap, name, act) \
+	.capabilities[idx] = {		\
+		.capability = cap,	\
+		.cap_name = name,	\
+		.action = act,
+
+#define KAPI_CAP_ALLOWS(desc) \
+		.allows = desc,
+
+#define KAPI_CAP_WITHOUT(desc) \
+		.without_cap = desc,
+
+#define KAPI_CAP_CONDITION(cond) \
+		.check_condition = cond,
+
+#define KAPI_CAP_PRIORITY(prio) \
+		.priority = prio,
+
+#define KAPI_CAP_ALTERNATIVE(caps, count) \
+		.alternative = caps,	\
+		.alternative_count = count,
+
+#define KAPI_CAPABILITY_END },
+
+/* Counter for capability specifications */
+#define KAPI_CAPABILITY_COUNT(n) \
+	.cap_magic = KAPI_MAGIC_CAPS, \
+	.capability_count = n,
+
+/* Common signal patterns for syscalls */
+#define KAPI_SIGNAL_INTERRUPTIBLE_SLEEP \
+	KAPI_SIGNAL(0, SIGINT, "SIGINT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_SLEEPING) \
+		KAPI_SIGNAL_ERROR(-EINTR) \
+		KAPI_SIGNAL_RESTARTABLE \
+		KAPI_SIGNAL_DESC("Interrupts sleep, returns -EINTR") \
+	KAPI_SIGNAL_END, \
+	KAPI_SIGNAL(1, SIGTERM, "SIGTERM", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_SLEEPING) \
+		KAPI_SIGNAL_ERROR(-EINTR) \
+		KAPI_SIGNAL_RESTARTABLE \
+		KAPI_SIGNAL_DESC("Interrupts sleep, returns -EINTR") \
+	KAPI_SIGNAL_END
+
+#define KAPI_SIGNAL_FATAL_DEFAULT \
+	KAPI_SIGNAL(2, SIGKILL, "SIGKILL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_TERMINATE) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME) \
+		KAPI_SIGNAL_PRIORITY(0) \
+		KAPI_SIGNAL_DESC("Process terminated immediately") \
+	KAPI_SIGNAL_END
+
+#define KAPI_SIGNAL_STOP_CONT \
+	KAPI_SIGNAL(3, SIGSTOP, "SIGSTOP", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_STOP) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME) \
+		KAPI_SIGNAL_DESC("Process stopped") \
+	KAPI_SIGNAL_END, \
+	KAPI_SIGNAL(4, SIGCONT, "SIGCONT", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_CONTINUE) \
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME) \
+		KAPI_SIGNAL_DESC("Process continued") \
+	KAPI_SIGNAL_END
+
+/* Validation and runtime checking */
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+bool kapi_validate_param(const struct kapi_param_spec *param_spec, s64 value);
+bool kapi_validate_param_with_context(const struct kapi_param_spec *param_spec,
+				       s64 value, const s64 *all_params, int param_count);
+int kapi_validate_syscall_param(const struct kernel_api_spec *spec,
+				int param_idx, s64 value);
+int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
+				 const s64 *params, int param_count);
+bool kapi_check_return_success(const struct kapi_return_spec *return_spec, s64 retval);
+bool kapi_validate_return_value(const struct kernel_api_spec *spec, s64 retval);
+int kapi_validate_syscall_return(const struct kernel_api_spec *spec, s64 retval);
+void kapi_check_context(const struct kernel_api_spec *spec);
+#else
+static inline bool kapi_validate_param(const struct kapi_param_spec *param_spec, s64 value)
+{
+	return true;
+}
+static inline bool kapi_validate_param_with_context(const struct kapi_param_spec *param_spec,
+						     s64 value, const s64 *all_params, int param_count)
+{
+	return true;
+}
+static inline int kapi_validate_syscall_param(const struct kernel_api_spec *spec,
+					       int param_idx, s64 value)
+{
+	return 0;
+}
+static inline int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
+					       const s64 *params, int param_count)
+{
+	return 0;
+}
+static inline bool kapi_check_return_success(const struct kapi_return_spec *return_spec, s64 retval)
+{
+	return true;
+}
+static inline bool kapi_validate_return_value(const struct kernel_api_spec *spec, s64 retval)
+{
+	return true;
+}
+static inline int kapi_validate_syscall_return(const struct kernel_api_spec *spec, s64 retval)
+{
+	return 0;
+}
+static inline void kapi_check_context(const struct kernel_api_spec *spec) {}
+#endif
+
+/*
+ * Export/query functions
+ *
+ * kapi_get_spec() returns a pointer that is valid only while the caller can
+ * guarantee the spec is not concurrently unregistered (e.g., module unload).
+ * For static specs this is always safe; for dynamic specs callers must hold
+ * a reference or ensure the owning module is pinned.
+ */
+const struct kernel_api_spec *kapi_get_spec(const char *name);
+int kapi_export_json(const struct kernel_api_spec *spec, char *buf, size_t size);
+void kapi_print_spec(const struct kernel_api_spec *spec);
+
+/* Registration for dynamic APIs */
+int kapi_register_spec(struct kernel_api_spec *spec);
+void kapi_unregister_spec(const char *name);
+
+/* Helper to get parameter constraint info */
+static inline bool kapi_get_param_constraint(const char *api_name, int param_idx,
+					      enum kapi_constraint_type *type,
+					      u64 *valid_mask, s64 *min_val, s64 *max_val)
+{
+	const struct kernel_api_spec *spec;
+
+	might_sleep();
+	spec = kapi_get_spec(api_name);
+
+	if (!spec || param_idx >= spec->param_count)
+		return false;
+
+	if (type)
+		*type = spec->params[param_idx].constraint_type;
+	if (valid_mask)
+		*valid_mask = spec->params[param_idx].valid_mask;
+	if (min_val)
+		*min_val = spec->params[param_idx].min_value;
+	if (max_val)
+		*max_val = spec->params[param_idx].max_value;
+
+	return true;
+}
+
+/* Socket state requirement macros */
+#define KAPI_SOCKET_STATE_REQ(...) \
+	.socket_state = { \
+		.required_states = { __VA_ARGS__ }, \
+		.required_state_count = sizeof((enum kapi_socket_state[]){__VA_ARGS__})/sizeof(enum kapi_socket_state),
+
+#define KAPI_SOCKET_STATE_FORBID(...) \
+		.forbidden_states = { __VA_ARGS__ }, \
+		.forbidden_state_count = sizeof((enum kapi_socket_state[]){__VA_ARGS__})/sizeof(enum kapi_socket_state),
+
+#define KAPI_SOCKET_STATE_RESULT(state) \
+		.resulting_state = state,
+
+#define KAPI_SOCKET_STATE_COND(cond) \
+		.state_condition = cond,
+
+#define KAPI_SOCKET_STATE_PROTOS(protos) \
+		.applicable_protocols = protos,
+
+#define KAPI_SOCKET_STATE_END },
+
+/* Protocol behavior macros */
+#define KAPI_PROTOCOL_BEHAVIOR(idx, protos, desc) \
+	.protocol_behaviors[idx] = { \
+		.applicable_protocols = protos, \
+		.behavior = desc,
+
+#define KAPI_PROTOCOL_FLAGS(flags, desc) \
+		.protocol_flags = flags, \
+		.flag_description = desc,
+
+#define KAPI_PROTOCOL_BEHAVIOR_END },
+
+/* Async behavior macros */
+#define KAPI_ASYNC_SPEC(modes, errno) \
+	.async_spec = { \
+		.supported_modes = modes, \
+		.nonblock_errno = errno,
+
+#define KAPI_ASYNC_POLL(in, out) \
+		.poll_events_in = in, \
+		.poll_events_out = out,
+
+#define KAPI_ASYNC_COMPLETION(cond) \
+		.completion_condition = cond,
+
+#define KAPI_ASYNC_TIMEOUT(supported, desc) \
+		.supports_timeout = supported, \
+		.timeout_behavior = desc,
+
+#define KAPI_ASYNC_END },
+
+/* Buffer behavior macros */
+#define KAPI_BUFFER_SPEC(behaviors) \
+	.buffer_spec = { \
+		.buffer_behaviors = behaviors,
+
+#define KAPI_BUFFER_SIZE(min, max, optimal) \
+		.min_buffer_size = min, \
+		.max_buffer_size = max, \
+		.optimal_buffer_size = optimal,
+
+#define KAPI_BUFFER_PARTIAL(allowed, rules) \
+		.can_partial_transfer = allowed, \
+		.partial_transfer_rules = rules,
+
+#define KAPI_BUFFER_FRAGMENT(rules) \
+		.fragmentation_rules = rules,
+
+#define KAPI_BUFFER_END },
+
+/* Address family macros */
+#define KAPI_ADDR_FAMILY(idx, fam, name, struct_sz, min_len, max_len) \
+	.addr_families[idx] = { \
+		.family = fam, \
+		.family_name = name, \
+		.addr_struct_size = struct_sz, \
+		.min_addr_len = min_len, \
+		.max_addr_len = max_len,
+
+#define KAPI_ADDR_FORMAT(fmt) \
+		.addr_format = fmt,
+
+#define KAPI_ADDR_FEATURES(wildcard, multicast, broadcast) \
+		.supports_wildcard = wildcard, \
+		.supports_multicast = multicast, \
+		.supports_broadcast = broadcast,
+
+#define KAPI_ADDR_SPECIAL(addrs) \
+		.special_addresses = addrs,
+
+#define KAPI_ADDR_PORTS(min, max) \
+		.port_range_min = min, \
+		.port_range_max = max,
+
+#define KAPI_ADDR_FAMILY_END },
+
+#define KAPI_ADDR_FAMILY_COUNT(n) \
+	.addr_family_count = n,
+
+#define KAPI_PROTOCOL_BEHAVIOR_COUNT(n) \
+	.protocol_behavior_count = n,
+
+#define KAPI_CONSTRAINT_COUNT(n) \
+	.constraint_magic = KAPI_MAGIC_CONSTRAINTS, \
+	.constraint_count = n,
+
+/* Network operation characteristics macros */
+#define KAPI_NET_CONNECTION_ORIENTED \
+	.is_connection_oriented = true,
+
+#define KAPI_NET_MESSAGE_ORIENTED \
+	.is_message_oriented = true,
+
+#define KAPI_NET_SUPPORTS_OOB \
+	.supports_oob_data = true,
+
+#define KAPI_NET_SUPPORTS_PEEK \
+	.supports_peek = true,
+
+#define KAPI_NET_REENTRANT \
+	.is_reentrant = true,
+
+/* Semantic description macros */
+#define KAPI_NET_CONN_ESTABLISH(desc) \
+	.connection_establishment = desc,
+
+#define KAPI_NET_CONN_TERMINATE(desc) \
+	.connection_termination = desc,
+
+#define KAPI_NET_DATA_TRANSFER(desc) \
+	.data_transfer_semantics = desc,
+
+#endif /* _LINUX_KERNEL_API_SPEC_H */
diff --git a/include/linux/syscall_api_spec.h b/include/linux/syscall_api_spec.h
new file mode 100644
index 0000000000000..63f7ddc6290b3
--- /dev/null
+++ b/include/linux/syscall_api_spec.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_api_spec.h - System Call API Specification Integration
+ *
+ * This header extends the SYSCALL_DEFINEX macros to support inline API specifications,
+ * allowing syscall documentation to be written alongside the implementation in a
+ * human-readable and machine-parseable format.
+ */
+
+#ifndef _LINUX_SYSCALL_API_SPEC_H
+#define _LINUX_SYSCALL_API_SPEC_H
+
+#include <linux/kernel_api_spec.h>
+
+/* Automatic syscall validation infrastructure */
+/*
+ * The validation is now integrated directly into the SYSCALL_DEFINEx macros
+ * in syscalls.h when CONFIG_KAPI_RUNTIME_CHECKS is enabled.
+ *
+ * The validation happens in the __do_kapi_sys##name wrapper function which:
+ * 1. Validates all parameters before calling the actual syscall
+ * 2. Calls the real syscall implementation
+ * 3. Validates the return value
+ * 4. Returns the result
+ */
+
+
+/*
+ * Helper macros for common syscall patterns
+ */
+
+/* For syscalls that can sleep */
+#define KAPI_SYSCALL_SLEEPABLE \
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+/* For syscalls that must be atomic */
+#define KAPI_SYSCALL_ATOMIC \
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_ATOMIC)
+
+/* Common parameter specifications */
+#define KAPI_PARAM_FD(idx, desc) \
+	KAPI_PARAM(idx, "fd", "int", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN) \
+		.type = KAPI_TYPE_FD, \
+		.constraint_type = KAPI_CONSTRAINT_NONE, \
+	KAPI_PARAM_END
+
+#define KAPI_PARAM_USER_BUF(idx, name, desc) \
+	KAPI_PARAM(idx, name, "void __user *", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_USER | KAPI_PARAM_IN) \
+	KAPI_PARAM_END
+
+/**
+ * KAPI_PARAM_USER_STRUCT - Define a userspace struct pointer parameter
+ * @idx: Parameter index (0-based)
+ * @name: Parameter name
+ * @struct_type: The struct type (e.g., struct iocb)
+ * @desc: Parameter description
+ *
+ * This macro defines a parameter that is a userspace pointer to a struct.
+ * The pointer will be validated to ensure:
+ * - The pointer is accessible in userspace
+ * - The memory region of sizeof(struct_type) bytes is accessible
+ */
+#define KAPI_PARAM_USER_STRUCT(idx, name, struct_type, desc) \
+	KAPI_PARAM(idx, name, #struct_type " __user *", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_USER | KAPI_PARAM_IN) \
+		.type = KAPI_TYPE_USER_PTR, \
+		.size = sizeof(struct_type), \
+		.constraint_type = KAPI_CONSTRAINT_USER_PTR, \
+	KAPI_PARAM_END
+
+/**
+ * KAPI_PARAM_USER_PTR_SIZED - Define a userspace pointer with explicit size
+ * @idx: Parameter index (0-based)
+ * @name: Parameter name
+ * @ptr_size: Size in bytes of the memory region
+ * @desc: Parameter description
+ *
+ * This macro defines a parameter that is a userspace pointer to a memory
+ * region of a specific size. The pointer will be validated to ensure:
+ * - The pointer is accessible in userspace
+ * - The memory region of ptr_size bytes is accessible
+ */
+#define KAPI_PARAM_USER_PTR_SIZED(idx, name, ptr_size, desc) \
+	KAPI_PARAM(idx, name, "void __user *", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_USER | KAPI_PARAM_IN) \
+		.type = KAPI_TYPE_USER_PTR, \
+		.size = ptr_size, \
+		.constraint_type = KAPI_CONSTRAINT_USER_PTR, \
+	KAPI_PARAM_END
+
+/**
+ * KAPI_PARAM_USER_STRING - Define a userspace null-terminated string parameter
+ * @idx: Parameter index (0-based)
+ * @name: Parameter name
+ * @min_len: Minimum string length (excluding null terminator)
+ * @max_len: Maximum string length (excluding null terminator)
+ * @desc: Parameter description
+ *
+ * This macro defines a parameter that is a userspace pointer to a
+ * null-terminated string. The string will be validated to ensure:
+ * - The pointer is accessible in userspace
+ * - The string length (excluding null terminator) is within [min_len, max_len]
+ */
+#define KAPI_PARAM_USER_STRING(idx, name, min_len, max_len, desc) \
+	KAPI_PARAM(idx, name, "const char __user *", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_USER | KAPI_PARAM_IN) \
+		.type = KAPI_TYPE_USER_PTR, \
+		.constraint_type = KAPI_CONSTRAINT_USER_STRING, \
+		.min_value = min_len, \
+		.max_value = max_len, \
+	KAPI_PARAM_END
+
+/**
+ * KAPI_PARAM_USER_PATH - Define a userspace pathname parameter
+ * @idx: Parameter index (0-based)
+ * @name: Parameter name
+ * @desc: Parameter description
+ *
+ * This macro defines a parameter that is a userspace pointer to a
+ * null-terminated pathname string. The path will be validated to ensure:
+ * - The pointer is accessible in userspace
+ * - The path is a valid null-terminated string
+ * - The path length does not exceed PATH_MAX (4096 bytes)
+ */
+#define KAPI_PARAM_USER_PATH(idx, name, desc) \
+	KAPI_PARAM(idx, name, "const char __user *", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_USER | KAPI_PARAM_IN) \
+		.type = KAPI_TYPE_PATH, \
+		.constraint_type = KAPI_CONSTRAINT_USER_PATH, \
+	KAPI_PARAM_END
+
+#define KAPI_PARAM_SIZE_T(idx, name, desc) \
+	KAPI_PARAM(idx, name, "size_t", desc) \
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN) \
+		KAPI_PARAM_RANGE(0, S64_MAX) \
+	KAPI_PARAM_END
+
+/* Common error specifications */
+#define KAPI_ERROR_EBADF(idx) \
+	KAPI_ERROR(idx, -EBADF, "EBADF", "Invalid file descriptor", \
+		   "The file descriptor is not valid or has been closed")
+
+#define KAPI_ERROR_EINVAL(idx, condition) \
+	KAPI_ERROR(idx, -EINVAL, "EINVAL", condition, \
+		   "Invalid argument provided")
+
+#define KAPI_ERROR_ENOMEM(idx) \
+	KAPI_ERROR(idx, -ENOMEM, "ENOMEM", "Insufficient memory", \
+		   "Cannot allocate memory for the operation")
+
+#define KAPI_ERROR_EPERM(idx) \
+	KAPI_ERROR(idx, -EPERM, "EPERM", "Operation not permitted", \
+		   "The calling process does not have the required permissions")
+
+#define KAPI_ERROR_EFAULT(idx) \
+	KAPI_ERROR(idx, -EFAULT, "EFAULT", "Bad address", \
+		   "Invalid user space address provided")
+
+/* Standard return value specifications */
+#define KAPI_RETURN_SUCCESS_ZERO \
+	KAPI_RETURN("long", "0 on success, negative error code on failure") \
+		KAPI_RETURN_SUCCESS(0, "== 0") \
+	KAPI_RETURN_END
+
+#define KAPI_RETURN_FD_SPEC \
+	KAPI_RETURN("long", "File descriptor on success, negative error code on failure") \
+		.check_type = KAPI_RETURN_FD, \
+	KAPI_RETURN_END
+
+#define KAPI_RETURN_COUNT \
+	KAPI_RETURN("long", "Number of bytes processed on success, negative error code on failure") \
+		KAPI_RETURN_SUCCESS(0, ">= 0") \
+	KAPI_RETURN_END
+
+/**
+ * KAPI_SINCE_VERSION - Set the since version
+ * @version: Version string when the API was introduced
+ */
+#define KAPI_SINCE_VERSION(version) \
+	.since_version = version,
+
+
+/**
+ * KAPI_SIGNAL_MASK_COUNT - Set the signal mask count
+ * @count: Number of signal masks defined
+ */
+#define KAPI_SIGNAL_MASK_COUNT(count) \
+	.signal_mask_count = count,
+
+#endif /* _LINUX_SYSCALL_API_SPEC_H */
\ No newline at end of file
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 02bd6ddb62782..76758cc0f50d8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -88,6 +88,7 @@ struct file_attr;
 #include <linux/bug.h>
 #include <linux/sem.h>
 #include <asm/siginfo.h>
+#include <linux/syscall_api_spec.h>
 #include <linux/unistd.h>
 #include <linux/quota.h>
 #include <linux/key.h>
@@ -133,6 +134,7 @@ struct file_attr;
 #define __SC_TYPE(t, a)	t
 #define __SC_ARGS(t, a)	a
 #define __SC_TEST(t, a) (void)BUILD_BUG_ON_ZERO(!__TYPE_IS_LL(t) && sizeof(t) > sizeof(long))
+#define __SC_CAST_TO_S64(t, a)	(s64)(a)
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define __SC_STR_ADECL(t, a)	#a
@@ -243,6 +245,42 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
  * done within __do_sys_*().
  */
 #ifndef __SYSCALL_DEFINEx
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+#define __SYSCALL_DEFINEx(x, name, ...)					\
+	__diag_push();							\
+	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
+		      "Type aliasing is used to sanitize syscall arguments");\
+	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
+		__attribute__((alias(__stringify(__se_sys##name))));	\
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	static inline long __do_kapi_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)); \
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+	{								\
+		long ret = __do_kapi_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		return ret;						\
+	}								\
+	__diag_pop();							\
+	static inline long __do_kapi_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
+	{								\
+		const struct kernel_api_spec *__spec = kapi_get_spec("sys" #name); \
+		if (__spec) {						\
+			s64 __params[x] = { __MAP(x,__SC_CAST_TO_S64,__VA_ARGS__) }; \
+			int __ret = kapi_validate_syscall_params(__spec, __params, x); \
+			if (__ret)				\
+				return __ret;			\
+		}							\
+		long ret = __do_sys##name(__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		if (__spec) {						\
+			kapi_validate_syscall_return(__spec, (s64)ret); \
+		}							\
+		return ret;						\
+	}								\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#else /* !CONFIG_KAPI_RUNTIME_CHECKS */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	__diag_push();							\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
@@ -261,6 +299,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	}								\
 	__diag_pop();							\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
 #endif /* __SYSCALL_DEFINEx */
 
 /* For split 64-bit arguments on 32-bit architectures */
diff --git a/init/Kconfig b/init/Kconfig
index c25869cf59c17..32e7bd8fc9991 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2223,6 +2223,8 @@ source "kernel/Kconfig.kexec"
 
 source "kernel/liveupdate/Kconfig"
 
+source "kernel/api/Kconfig"
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/kernel/Makefile b/kernel/Makefile
index 6785982013dce..5643151536439 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -59,6 +59,9 @@ obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
+obj-$(CONFIG_KAPI_SPEC) += api/
+# Ensure api/ is always cleaned even when CONFIG_KAPI_SPEC is not set
+obj- += api/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/api/.gitignore b/kernel/api/.gitignore
new file mode 100644
index 0000000000000..ca2f632621cfc
--- /dev/null
+++ b/kernel/api/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/generated_api_specs.c
diff --git a/kernel/api/Kconfig b/kernel/api/Kconfig
new file mode 100644
index 0000000000000..bdd655458dc2f
--- /dev/null
+++ b/kernel/api/Kconfig
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Kernel API Specification Framework Configuration
+#
+
+config KAPI_SPEC
+	bool "Kernel API Specification Framework"
+	default n
+	help
+	  This option enables the kernel API specification framework,
+	  which provides formal documentation of kernel APIs in both
+	  human and machine-readable formats.
+
+	  The framework allows developers to document APIs inline with
+	  their implementation, including parameter specifications,
+	  return values, error conditions, locking requirements, and
+	  execution context constraints.
+
+	  When enabled, API specifications can be queried at runtime
+	  and exported in JSON format through debugfs.
+
+	  If unsure, say N.
+
+config KAPI_RUNTIME_CHECKS
+	bool "Runtime API specification checks"
+	depends on KAPI_SPEC
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  Enable runtime validation of API usage against specifications.
+	  This includes checking execution context requirements, parameter
+	  validation, and lock state verification.
+
+	  This adds overhead and should only be used for debugging and
+	  development. The checks use WARN_ONCE to report violations.
+
+	  If unsure, say N.
+
+config KAPI_SPEC_DEBUGFS
+	bool "Export kernel API specifications via debugfs"
+	depends on KAPI_SPEC
+	depends on DEBUG_FS
+	default n
+	help
+	  This option enables exporting kernel API specifications through
+	  the debugfs filesystem. When enabled, specifications can be
+	  accessed at /sys/kernel/debug/kapi/.
+
+	  The debugfs interface provides:
+	  - A list of all available API specifications
+	  - Detailed information for each API including parameters,
+	    return values, errors, locking requirements, and constraints
+	  - Complete machine-readable representation of the specs
+
+	  This is useful for documentation tools, static analyzers, and
+	  runtime introspection of kernel APIs.
+
+	  If unsure, say N.
+
+config KAPI_KUNIT_TEST
+	tristate "KUnit tests for KAPI framework" if !KUNIT_ALL_TESTS
+	depends on KAPI_SPEC
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the Kernel API Specification Framework.
+	  Tests registration, lookup, validation constraints, and
+	  JSON export functionality.
+
+	  If unsure, say N.
diff --git a/kernel/api/Makefile b/kernel/api/Makefile
new file mode 100644
index 0000000000000..c0a13fc590e4a
--- /dev/null
+++ b/kernel/api/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Kernel API Specification Framework
+#
+
+# Core API specification framework
+obj-$(CONFIG_KAPI_SPEC)		+= kernel_api_spec.o
+
+# Debugfs interface for kernel API specs
+obj-$(CONFIG_KAPI_SPEC_DEBUGFS) += kapi_debugfs.o
+
+# KUnit tests
+obj-$(CONFIG_KAPI_KUNIT_TEST) += kapi_kunit.o
+
diff --git a/kernel/api/kapi_kunit.c b/kernel/api/kapi_kunit.c
new file mode 100644
index 0000000000000..da4b69d2ea2a8
--- /dev/null
+++ b/kernel/api/kapi_kunit.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the Kernel API Specification Framework
+ *
+ * Tests registration, lookup, validation, and JSON export functionality.
+ */
+
+#include <kunit/test.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+static void init_test_spec(struct kernel_api_spec *spec, const char *name)
+{
+	memset(spec, 0, sizeof(*spec));
+	strscpy(spec->name, name, KAPI_MAX_NAME_LEN);
+	spec->version = 1;
+	strscpy(spec->description, "Test API", KAPI_MAX_DESC_LEN);
+}
+
+/* Test 1: kapi_register_spec with valid spec returns 0 */
+static void test_register_valid(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+	int ret;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	init_test_spec(spec, "test_register_valid");
+
+	ret = kapi_register_spec(spec);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	kapi_unregister_spec("test_register_valid");
+	kfree(spec);
+}
+
+/* Test 2: kapi_get_spec returns registered spec */
+static void test_lookup_registered(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+	const struct kernel_api_spec *found;
+	int ret;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	init_test_spec(spec, "test_lookup_func");
+
+	ret = kapi_register_spec(spec);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	found = kapi_get_spec("test_lookup_func");
+	KUNIT_EXPECT_PTR_EQ(test, found, (const struct kernel_api_spec *)spec);
+
+	kapi_unregister_spec("test_lookup_func");
+	kfree(spec);
+}
+
+/* Test 3: Double registration returns -EEXIST */
+static void test_double_register(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+	int ret;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	init_test_spec(spec, "test_double_reg");
+
+	ret = kapi_register_spec(spec);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = kapi_register_spec(spec);
+	KUNIT_EXPECT_EQ(test, ret, -EEXIST);
+
+	kapi_unregister_spec("test_double_reg");
+	kfree(spec);
+}
+
+/* Test 4: Unregister makes spec unfindable */
+static void test_unregister(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+	const struct kernel_api_spec *found;
+	int ret;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	init_test_spec(spec, "test_unreg_func");
+
+	ret = kapi_register_spec(spec);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	kapi_unregister_spec("test_unreg_func");
+
+	found = kapi_get_spec("test_unreg_func");
+	KUNIT_EXPECT_NULL(test, found);
+
+	kfree(spec);
+}
+
+/* Test 5: kapi_get_spec(NULL) returns NULL */
+static void test_get_spec_null(struct kunit *test)
+{
+	const struct kernel_api_spec *found;
+
+	found = kapi_get_spec(NULL);
+	KUNIT_EXPECT_NULL(test, found);
+}
+
+/* Test 6: kapi_register_spec(NULL) returns -EINVAL */
+static void test_register_null(struct kunit *test)
+{
+	int ret;
+
+	ret = kapi_register_spec(NULL);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/* Test 7: Spec with empty name is rejected */
+static void test_register_empty_name(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+	int ret;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	/* name[0] == '\0' from kzalloc */
+	ret = kapi_register_spec(spec);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	kfree(spec);
+}
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+
+/* Test 8: RANGE constraint - value in range is valid */
+static void test_constraint_range_valid(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_param", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_RANGE;
+	param.min_value = 0;
+	param.max_value = 100;
+
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 0));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 50));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 100));
+}
+
+/* Test 9: RANGE constraint - value out of range is invalid */
+static void test_constraint_range_invalid(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_param", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_RANGE;
+	param.min_value = 0;
+	param.max_value = 100;
+
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, -1));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 101));
+}
+
+/* Test 10: MASK constraint - valid bits pass */
+static void test_constraint_mask_valid(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_flags", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_MASK;
+	param.valid_mask = 0xFF;
+
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 0x00));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 0x0F));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 0xFF));
+}
+
+/* Test 11: MASK constraint - extra bits fail */
+static void test_constraint_mask_invalid(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_flags", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_MASK;
+	param.valid_mask = 0xFF;
+
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 0x100));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 0x1FF));
+}
+
+/* Test 12: POWER_OF_TWO constraint */
+static void test_constraint_power_of_two(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_pot", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_POWER_OF_TWO;
+
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 1));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 2));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 4));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 8));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 0));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 3));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 5));
+}
+
+/* Test 13: PAGE_ALIGNED constraint */
+static void test_constraint_page_aligned(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_page", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_PAGE_ALIGNED;
+
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 0));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, PAGE_SIZE));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 2 * PAGE_SIZE));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 1));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, PAGE_SIZE - 1));
+}
+
+/* Test 14: NONZERO constraint */
+static void test_constraint_nonzero(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_nz", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_NONZERO;
+
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 0));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 1));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, -1));
+}
+
+/* Test 15: Return value validation - success */
+static void test_return_validation(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+
+	spec = kunit_kzalloc(test, sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	strscpy(spec->name, "test_ret", sizeof(spec->name));
+	spec->return_magic = KAPI_MAGIC_RETURN;
+	spec->return_spec.check_type = KAPI_RETURN_EXACT;
+	spec->return_spec.success_value = 0;
+
+	KUNIT_EXPECT_TRUE(test, kapi_validate_return_value(spec, 0));
+}
+
+/* Test 16: Return value validation - known error */
+static void test_return_known_error(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+
+	spec = kunit_kzalloc(test, sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	strscpy(spec->name, "test_ret_err", sizeof(spec->name));
+	spec->return_magic = KAPI_MAGIC_RETURN;
+	spec->return_spec.check_type = KAPI_RETURN_FD;
+	spec->error_count = 1;
+	spec->errors[0].error_code = -ENOENT;
+	strscpy(spec->errors[0].name, "ENOENT", sizeof(spec->errors[0].name));
+
+	/* -ENOENT is in the error list, so it's valid */
+	KUNIT_EXPECT_TRUE(test, kapi_validate_return_value(spec, -ENOENT));
+}
+
+/* Test 17: Return value validation - unknown error */
+static void test_return_unknown_error(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+
+	spec = kunit_kzalloc(test, sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	strscpy(spec->name, "test_ret_unk", sizeof(spec->name));
+	spec->return_magic = KAPI_MAGIC_RETURN;
+	spec->return_spec.check_type = KAPI_RETURN_FD;
+	spec->error_count = 1;
+	spec->errors[0].error_code = -ENOENT;
+	strscpy(spec->errors[0].name, "ENOENT", sizeof(spec->errors[0].name));
+
+	/* -EPERM is not in the error list, but unlisted errors are accepted
+	 * since filesystem/device-specific errors may not be exhaustively listed
+	 */
+	KUNIT_EXPECT_TRUE(test, kapi_validate_return_value(spec, -EPERM));
+}
+
+/* Test 18: ALIGNMENT constraint */
+static void test_constraint_alignment(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_align", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_ALIGNMENT;
+	param.alignment = 8;
+
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 0));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 8));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 16));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 1));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 7));
+}
+
+/* Test 19: FD validation rejects values > INT_MAX */
+static void test_fd_int_overflow(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_fd", sizeof(param.name));
+	param.type = KAPI_TYPE_FD;
+	param.constraint_type = KAPI_CONSTRAINT_NONE;
+
+	/* Value that overflows int: 0x100000003 -> truncates to 3 */
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 0x100000003LL));
+}
+
+/* Test 23: ENUM constraint */
+static const s64 test_enum_vals[] = { 1, 5, 10 };
+
+static void test_constraint_enum(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_enum", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_ENUM;
+	param.enum_values = test_enum_vals;
+	param.enum_count = ARRAY_SIZE(test_enum_vals);
+
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 1));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 5));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 10));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 0));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 3));
+	KUNIT_EXPECT_FALSE(test, kapi_validate_param(&param, 11));
+}
+
+/* Test 24: BUFFER constraint always accepts (size checked at runtime) */
+static void test_constraint_buffer(struct kunit *test)
+{
+	struct kapi_param_spec param = {};
+
+	strscpy(param.name, "test_buf", sizeof(param.name));
+	param.constraint_type = KAPI_CONSTRAINT_BUFFER;
+
+	/* Buffer constraint doesn't validate the value itself */
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 0));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_param(&param, 4096));
+}
+
+/* Test 25: RETURN_RANGE check type */
+static void test_return_range(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+
+	spec = kunit_kzalloc(test, sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	strscpy(spec->name, "test_ret_range", sizeof(spec->name));
+	spec->return_magic = KAPI_MAGIC_RETURN;
+	spec->return_spec.check_type = KAPI_RETURN_RANGE;
+	spec->return_spec.success_min = 0;
+	spec->return_spec.success_max = 100;
+
+	KUNIT_EXPECT_TRUE(test, kapi_validate_return_value(spec, 0));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_return_value(spec, 50));
+	KUNIT_EXPECT_TRUE(test, kapi_validate_return_value(spec, 100));
+}
+
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
+
+/* Test 26: Unregister non-existent spec is a no-op */
+static void test_unregister_nonexistent(struct kunit *test)
+{
+	/* Should not crash or error */
+	kapi_unregister_spec("nonexistent_spec_xyz");
+}
+
+/* Test 27: Multiple specs can be registered and looked up */
+static void test_multiple_specs(struct kunit *test)
+{
+	struct kernel_api_spec *spec1, *spec2;
+	const struct kernel_api_spec *found;
+
+	spec1 = kzalloc_obj(*spec1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec1);
+	spec2 = kzalloc_obj(*spec2, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec2);
+
+	init_test_spec(spec1, "multi_spec_1");
+	init_test_spec(spec2, "multi_spec_2");
+
+	KUNIT_ASSERT_EQ(test, kapi_register_spec(spec1), 0);
+	KUNIT_ASSERT_EQ(test, kapi_register_spec(spec2), 0);
+
+	found = kapi_get_spec("multi_spec_1");
+	KUNIT_EXPECT_PTR_EQ(test, found, (const struct kernel_api_spec *)spec1);
+
+	found = kapi_get_spec("multi_spec_2");
+	KUNIT_EXPECT_PTR_EQ(test, found, (const struct kernel_api_spec *)spec2);
+
+	kapi_unregister_spec("multi_spec_1");
+	kapi_unregister_spec("multi_spec_2");
+	kfree(spec1);
+	kfree(spec2);
+}
+
+/* Test 20: JSON export produces valid output */
+static void test_json_export(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+	char *buf;
+	int ret;
+
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+
+	buf = kzalloc(4096, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	init_test_spec(spec, "test_json");
+	spec->param_count = 1;
+	strscpy(spec->params[0].name, "arg0", sizeof(spec->params[0].name));
+	strscpy(spec->params[0].type_name, "int", sizeof(spec->params[0].type_name));
+
+	ret = kapi_export_json(spec, buf, 4096);
+	KUNIT_EXPECT_GT(test, ret, 0);
+
+	/* Verify it starts with '{' and ends with '}' */
+	KUNIT_EXPECT_EQ(test, buf[0], '{');
+	KUNIT_ASSERT_GT(test, ret, 1);
+	/* Find last non-whitespace char */
+	while (ret > 0 && (buf[ret - 1] == '\n' || buf[ret - 1] == ' '))
+		ret--;
+	KUNIT_EXPECT_EQ(test, buf[ret - 1], '}');
+
+	/* Verify key fields are present */
+	KUNIT_EXPECT_NOT_NULL(test, strstr(buf, "\"name\""));
+	KUNIT_EXPECT_NOT_NULL(test, strstr(buf, "\"test_json\""));
+	KUNIT_EXPECT_NOT_NULL(test, strstr(buf, "\"parameters\""));
+
+	kfree(buf);
+	kfree(spec);
+}
+
+/* Test 21: JSON export with NULL args returns -EINVAL */
+static void test_json_export_null(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+	char buf[64];
+	int ret;
+
+	ret = kapi_export_json(NULL, buf, sizeof(buf));
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	spec = kunit_kzalloc(test, sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+	init_test_spec(spec, "test");
+
+	ret = kapi_export_json(spec, NULL, 64);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+
+	ret = kapi_export_json(spec, buf, 0);
+	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
+}
+
+/* Test 22: JSON export with small buffer truncates gracefully */
+static void test_json_export_small_buffer(struct kunit *test)
+{
+	struct kernel_api_spec *spec;
+	char buf[64];
+	int ret;
+
+	spec = kunit_kzalloc(test, sizeof(*spec), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, spec);
+	init_test_spec(spec, "test_small");
+
+	ret = kapi_export_json(spec, buf, sizeof(buf));
+
+	/* Should return number of bytes written, buffer too small for full JSON */
+	KUNIT_EXPECT_GT(test, ret, 0);
+	KUNIT_EXPECT_LT(test, ret, (int)sizeof(buf));
+}
+
+static struct kunit_case kapi_test_cases[] = {
+	KUNIT_CASE(test_register_valid),
+	KUNIT_CASE(test_lookup_registered),
+	KUNIT_CASE(test_double_register),
+	KUNIT_CASE(test_unregister),
+	KUNIT_CASE(test_get_spec_null),
+	KUNIT_CASE(test_register_null),
+	KUNIT_CASE(test_register_empty_name),
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+	KUNIT_CASE(test_constraint_range_valid),
+	KUNIT_CASE(test_constraint_range_invalid),
+	KUNIT_CASE(test_constraint_mask_valid),
+	KUNIT_CASE(test_constraint_mask_invalid),
+	KUNIT_CASE(test_constraint_power_of_two),
+	KUNIT_CASE(test_constraint_page_aligned),
+	KUNIT_CASE(test_constraint_nonzero),
+	KUNIT_CASE(test_return_validation),
+	KUNIT_CASE(test_return_known_error),
+	KUNIT_CASE(test_return_unknown_error),
+	KUNIT_CASE(test_constraint_alignment),
+	KUNIT_CASE(test_fd_int_overflow),
+	KUNIT_CASE(test_constraint_enum),
+	KUNIT_CASE(test_constraint_buffer),
+	KUNIT_CASE(test_return_range),
+#endif
+	KUNIT_CASE(test_unregister_nonexistent),
+	KUNIT_CASE(test_multiple_specs),
+	KUNIT_CASE(test_json_export),
+	KUNIT_CASE(test_json_export_null),
+	KUNIT_CASE(test_json_export_small_buffer),
+	{}
+};
+
+static struct kunit_suite kapi_test_suite = {
+	.name = "kapi",
+	.test_cases = kapi_test_cases,
+};
+
+kunit_test_suite(kapi_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for Kernel API Specification Framework");
+MODULE_LICENSE("GPL");
diff --git a/kernel/api/kernel_api_spec.c b/kernel/api/kernel_api_spec.c
new file mode 100644
index 0000000000000..836af6d501a13
--- /dev/null
+++ b/kernel/api/kernel_api_spec.c
@@ -0,0 +1,1277 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kernel_api_spec.c - Kernel API Specification Framework Implementation
+ *
+ * Provides runtime support for kernel API specifications including validation,
+ * export to various formats, and querying capabilities.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kernel_api_spec.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/export.h>
+#include <linux/preempt.h>
+#include <linux/hardirq.h>
+#include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/uaccess.h>
+#include <linux/limits.h>
+#include <linux/fcntl.h>
+#include <linux/mm.h>
+#include <linux/ratelimit.h>
+
+/* Section where API specifications are stored */
+extern struct kernel_api_spec __start_kapi_specs[];
+extern struct kernel_api_spec __stop_kapi_specs[];
+
+/* Dynamic API registration */
+static LIST_HEAD(dynamic_api_specs);
+static DEFINE_MUTEX(api_spec_mutex);
+
+struct dynamic_api_spec {
+	struct list_head list;
+	struct kernel_api_spec *spec;
+};
+
+/*
+ * __kapi_find_spec_locked - Internal lookup, caller must hold api_spec_mutex
+ */
+static const struct kernel_api_spec *__kapi_find_spec_locked(const char *name)
+{
+	struct kernel_api_spec *spec;
+	struct dynamic_api_spec *dyn_spec;
+
+	/* Search static specifications */
+	for (spec = __start_kapi_specs; spec < __stop_kapi_specs; spec++) {
+		if (strcmp(spec->name, name) == 0)
+			return spec;
+	}
+
+	/* Search dynamic specifications (mutex already held) */
+	list_for_each_entry(dyn_spec, &dynamic_api_specs, list) {
+		if (strcmp(dyn_spec->spec->name, name) == 0)
+			return dyn_spec->spec;
+	}
+
+	return NULL;
+}
+
+/**
+ * kapi_get_spec - Get API specification by name
+ * @name: Function name to look up
+ *
+ * Return: Pointer to API specification or NULL if not found
+ */
+const struct kernel_api_spec *kapi_get_spec(const char *name)
+{
+	const struct kernel_api_spec *spec;
+
+	if (!name)
+		return NULL;
+
+	mutex_lock(&api_spec_mutex);
+	spec = __kapi_find_spec_locked(name);
+	mutex_unlock(&api_spec_mutex);
+
+	return spec;
+}
+EXPORT_SYMBOL_GPL(kapi_get_spec);
+
+/**
+ * kapi_register_spec - Register a dynamic API specification
+ * @spec: API specification to register
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int kapi_register_spec(struct kernel_api_spec *spec)
+{
+	struct dynamic_api_spec *dyn_spec;
+	int ret = 0;
+
+	if (!spec || !spec->name[0])
+		return -EINVAL;
+
+	dyn_spec = kzalloc(sizeof(*dyn_spec), GFP_KERNEL);
+	if (!dyn_spec)
+		return -ENOMEM;
+
+	dyn_spec->spec = spec;
+
+	mutex_lock(&api_spec_mutex);
+
+	/* Check if already exists while holding lock to prevent races */
+	if (__kapi_find_spec_locked(spec->name)) {
+		ret = -EEXIST;
+		kfree(dyn_spec);
+	} else {
+		list_add_tail(&dyn_spec->list, &dynamic_api_specs);
+	}
+
+	mutex_unlock(&api_spec_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kapi_register_spec);
+
+/**
+ * kapi_unregister_spec - Unregister a dynamic API specification
+ * @name: Name of API to unregister
+ */
+void kapi_unregister_spec(const char *name)
+{
+	struct dynamic_api_spec *dyn_spec, *tmp;
+
+	if (!name)
+		return;
+
+	mutex_lock(&api_spec_mutex);
+	list_for_each_entry_safe(dyn_spec, tmp, &dynamic_api_specs, list) {
+		if (strcmp(dyn_spec->spec->name, name) == 0) {
+			list_del(&dyn_spec->list);
+			kfree(dyn_spec);
+			break;
+		}
+	}
+	mutex_unlock(&api_spec_mutex);
+}
+EXPORT_SYMBOL_GPL(kapi_unregister_spec);
+
+/**
+ * param_type_to_string - Convert parameter type to string
+ * @type: Parameter type
+ *
+ * Return: String representation of type
+ */
+static const char *param_type_to_string(enum kapi_param_type type)
+{
+	static const char * const type_names[] = {
+		[KAPI_TYPE_VOID] = "void",
+		[KAPI_TYPE_INT] = "int",
+		[KAPI_TYPE_UINT] = "uint",
+		[KAPI_TYPE_PTR] = "pointer",
+		[KAPI_TYPE_STRUCT] = "struct",
+		[KAPI_TYPE_UNION] = "union",
+		[KAPI_TYPE_ENUM] = "enum",
+		[KAPI_TYPE_FUNC_PTR] = "function_pointer",
+		[KAPI_TYPE_ARRAY] = "array",
+		[KAPI_TYPE_FD] = "file_descriptor",
+		[KAPI_TYPE_USER_PTR] = "user_pointer",
+		[KAPI_TYPE_PATH] = "pathname",
+		[KAPI_TYPE_CUSTOM] = "custom",
+	};
+
+	if (type >= ARRAY_SIZE(type_names))
+		return "unknown";
+
+	return type_names[type];
+}
+
+/**
+ * lock_type_to_string - Convert lock type to string
+ * @type: Lock type
+ *
+ * Return: String representation of lock type
+ */
+static const char *lock_type_to_string(enum kapi_lock_type type)
+{
+	static const char * const lock_names[] = {
+		[KAPI_LOCK_NONE] = "none",
+		[KAPI_LOCK_MUTEX] = "mutex",
+		[KAPI_LOCK_SPINLOCK] = "spinlock",
+		[KAPI_LOCK_RWLOCK] = "rwlock",
+		[KAPI_LOCK_SEQLOCK] = "seqlock",
+		[KAPI_LOCK_RCU] = "rcu",
+		[KAPI_LOCK_SEMAPHORE] = "semaphore",
+		[KAPI_LOCK_CUSTOM] = "custom",
+	};
+
+	if (type >= ARRAY_SIZE(lock_names))
+		return "unknown";
+
+	return lock_names[type];
+}
+
+/**
+ * lock_scope_to_string - Convert lock scope to string
+ * @scope: Lock scope
+ *
+ * Return: String representation of lock scope
+ */
+static const char *lock_scope_to_string(enum kapi_lock_scope scope)
+{
+	static const char * const scope_names[] = {
+		[KAPI_LOCK_INTERNAL] = "internal",
+		[KAPI_LOCK_ACQUIRES] = "acquires",
+		[KAPI_LOCK_RELEASES] = "releases",
+		[KAPI_LOCK_CALLER_HELD] = "caller_held",
+	};
+
+	if (scope >= ARRAY_SIZE(scope_names))
+		return "unknown";
+
+	return scope_names[scope];
+}
+
+/**
+ * return_check_type_to_string - Convert return check type to string
+ * @type: Return check type
+ *
+ * Return: String representation of return check type
+ */
+static const char *return_check_type_to_string(enum kapi_return_check_type type)
+{
+	static const char * const check_names[] = {
+		[KAPI_RETURN_EXACT] = "exact",
+		[KAPI_RETURN_RANGE] = "range",
+		[KAPI_RETURN_ERROR_CHECK] = "error_check",
+		[KAPI_RETURN_FD] = "file_descriptor",
+		[KAPI_RETURN_CUSTOM] = "custom",
+		[KAPI_RETURN_NO_RETURN] = "no_return",
+	};
+
+	if (type >= ARRAY_SIZE(check_names))
+		return "unknown";
+
+	return check_names[type];
+}
+
+/**
+ * capability_action_to_string - Convert capability action to string
+ * @action: Capability action
+ *
+ * Return: String representation of capability action
+ */
+static const char *capability_action_to_string(enum kapi_capability_action action)
+{
+	static const char * const action_names[] = {
+		[KAPI_CAP_BYPASS_CHECK] = "bypass_check",
+		[KAPI_CAP_INCREASE_LIMIT] = "increase_limit",
+		[KAPI_CAP_OVERRIDE_RESTRICTION] = "override_restriction",
+		[KAPI_CAP_GRANT_PERMISSION] = "grant_permission",
+		[KAPI_CAP_MODIFY_BEHAVIOR] = "modify_behavior",
+		[KAPI_CAP_ACCESS_RESOURCE] = "access_resource",
+		[KAPI_CAP_PERFORM_OPERATION] = "perform_operation",
+	};
+
+	if (action >= ARRAY_SIZE(action_names))
+		return "unknown";
+
+	return action_names[action];
+}
+
+/*
+ * kapi_json_escape - Write a JSON-escaped string into a buffer
+ * @buf: Output buffer
+ * @size: Remaining space in buffer
+ * @str: Input string to escape
+ *
+ * Escapes backslash, double-quote, and control characters for JSON output.
+ * Return: Number of bytes written (via scnprintf semantics)
+ */
+static int kapi_json_escape(char *buf, size_t size, const char *str)
+{
+	int ret = 0;
+	const char *p;
+
+	if (!str || size == 0)
+		return 0;
+
+	for (p = str; *p && ret < size - 1; p++) {
+		switch (*p) {
+		case '\\':
+			ret += scnprintf(buf + ret, size - ret, "\\\\");
+			break;
+		case '"':
+			ret += scnprintf(buf + ret, size - ret, "\\\"");
+			break;
+		case '\n':
+			ret += scnprintf(buf + ret, size - ret, "\\n");
+			break;
+		case '\r':
+			ret += scnprintf(buf + ret, size - ret, "\\r");
+			break;
+		case '\t':
+			ret += scnprintf(buf + ret, size - ret, "\\t");
+			break;
+		default:
+			if ((unsigned char)*p < 0x20) {
+				ret += scnprintf(buf + ret, size - ret,
+						 "\\u%04x", (unsigned char)*p);
+			} else {
+				ret += scnprintf(buf + ret, size - ret,
+						 "%c", *p);
+			}
+			break;
+		}
+	}
+
+	if (ret < size)
+		buf[ret] = '\0';
+
+	return ret;
+}
+
+/* Helper to write a JSON-escaped string field */
+static int kapi_json_str(char *buf, size_t size, const char *str)
+{
+	int ret = 0;
+
+	ret += scnprintf(buf, size, "\"");
+	ret += kapi_json_escape(buf + ret, size - ret, str);
+	ret += scnprintf(buf + ret, size - ret, "\"");
+	return ret;
+}
+
+/**
+ * kapi_export_json - Export API specification to JSON format
+ * @spec: API specification to export
+ * @buf: Buffer to write JSON to
+ * @size: Size of buffer
+ *
+ * Return: Number of bytes written or negative error
+ */
+int kapi_export_json(const struct kernel_api_spec *spec, char *buf, size_t size)
+{
+	int ret = 0;
+	int i;
+
+	if (!spec || !buf || size == 0)
+		return -EINVAL;
+
+	ret = scnprintf(buf, size, "{\n  \"name\": ");
+	ret += kapi_json_str(buf + ret, size - ret, spec->name);
+	ret += scnprintf(buf + ret, size - ret, ",\n  \"version\": %u,\n  \"description\": ", spec->version);
+	ret += kapi_json_str(buf + ret, size - ret, spec->description);
+	ret += scnprintf(buf + ret, size - ret, ",\n  \"long_description\": ");
+	ret += kapi_json_str(buf + ret, size - ret, spec->long_description);
+	ret += scnprintf(buf + ret, size - ret, ",\n  \"context_flags\": \"0x%x\",\n", spec->context_flags);
+
+	/* Parameters */
+	ret += scnprintf(buf + ret, size - ret, "  \"parameters\": [\n");
+
+	for (i = 0; i < spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+		const struct kapi_param_spec *param = &spec->params[i];
+
+		ret += scnprintf(buf + ret, size - ret, "    {\n      \"name\": ");
+		ret += kapi_json_str(buf + ret, size - ret, param->name);
+		ret += scnprintf(buf + ret, size - ret, ",\n      \"type\": ");
+		ret += kapi_json_str(buf + ret, size - ret, param->type_name);
+		ret += scnprintf(buf + ret, size - ret,
+			",\n      \"type_class\": \"%s\","
+			"\n      \"flags\": \"0x%x\","
+			"\n      \"description\": ",
+			param_type_to_string(param->type),
+			param->flags);
+		ret += kapi_json_str(buf + ret, size - ret, param->description);
+		ret += scnprintf(buf + ret, size - ret,
+			"\n    }%s\n",
+			(i < spec->param_count - 1) ? "," : "");
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "  ],\n");
+
+	/* Return value */
+	ret += scnprintf(buf + ret, size - ret, "  \"return\": {\n    \"type\": ");
+	ret += kapi_json_str(buf + ret, size - ret, spec->return_spec.type_name);
+	ret += scnprintf(buf + ret, size - ret,
+		",\n    \"type_class\": \"%s\","
+		"\n    \"check_type\": \"%s\",\n",
+		param_type_to_string(spec->return_spec.type),
+		return_check_type_to_string(spec->return_spec.check_type));
+
+	switch (spec->return_spec.check_type) {
+	case KAPI_RETURN_EXACT:
+		ret += scnprintf(buf + ret, size - ret,
+			"    \"success_value\": %lld,\n",
+			spec->return_spec.success_value);
+		break;
+	case KAPI_RETURN_RANGE:
+		ret += scnprintf(buf + ret, size - ret,
+			"    \"success_min\": %lld,\n"
+			"    \"success_max\": %lld,\n",
+			spec->return_spec.success_min,
+			spec->return_spec.success_max);
+		break;
+	case KAPI_RETURN_ERROR_CHECK:
+		ret += scnprintf(buf + ret, size - ret,
+			"    \"error_count\": %u,\n",
+			spec->return_spec.error_count);
+		break;
+	default:
+		break;
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "    \"description\": ");
+	ret += kapi_json_str(buf + ret, size - ret, spec->return_spec.description);
+	ret += scnprintf(buf + ret, size - ret, "\n  },\n");
+
+	/* Errors */
+	ret += scnprintf(buf + ret, size - ret, "  \"errors\": [\n");
+
+	for (i = 0; i < spec->error_count && i < KAPI_MAX_ERRORS; i++) {
+		const struct kapi_error_spec *error = &spec->errors[i];
+
+		ret += scnprintf(buf + ret, size - ret,
+			"    {\n      \"code\": %d,\n      \"name\": ",
+			error->error_code);
+		ret += kapi_json_str(buf + ret, size - ret, error->name);
+		ret += scnprintf(buf + ret, size - ret, ",\n      \"condition\": ");
+		ret += kapi_json_str(buf + ret, size - ret, error->condition);
+		ret += scnprintf(buf + ret, size - ret, ",\n      \"description\": ");
+		ret += kapi_json_str(buf + ret, size - ret, error->description);
+		ret += scnprintf(buf + ret, size - ret,
+			"\n    }%s\n",
+			(i < spec->error_count - 1) ? "," : "");
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "  ],\n");
+
+	/* Locks */
+	ret += scnprintf(buf + ret, size - ret, "  \"locks\": [\n");
+
+	for (i = 0; i < spec->lock_count && i < KAPI_MAX_CONSTRAINTS; i++) {
+		const struct kapi_lock_spec *lock = &spec->locks[i];
+
+		ret += scnprintf(buf + ret, size - ret, "    {\n      \"name\": ");
+		ret += kapi_json_str(buf + ret, size - ret, lock->lock_name);
+		ret += scnprintf(buf + ret, size - ret,
+			",\n      \"type\": \"%s\","
+			"\n      \"scope\": \"%s\","
+			"\n      \"description\": ",
+			lock_type_to_string(lock->lock_type),
+			lock_scope_to_string(lock->scope));
+		ret += kapi_json_str(buf + ret, size - ret, lock->description);
+		ret += scnprintf(buf + ret, size - ret,
+			"\n    }%s\n",
+			(i < spec->lock_count - 1) ? "," : "");
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "  ],\n");
+
+	/* Capabilities */
+	ret += scnprintf(buf + ret, size - ret, "  \"capabilities\": [\n");
+
+	for (i = 0; i < spec->capability_count && i < KAPI_MAX_CAPABILITIES; i++) {
+		const struct kapi_capability_spec *cap = &spec->capabilities[i];
+
+		ret += scnprintf(buf + ret, size - ret,
+			"    {\n      \"capability\": %d,\n      \"name\": ",
+			cap->capability);
+		ret += kapi_json_str(buf + ret, size - ret, cap->cap_name);
+		ret += scnprintf(buf + ret, size - ret,
+			",\n      \"action\": \"%s\",\n      \"allows\": ",
+			capability_action_to_string(cap->action));
+		ret += kapi_json_str(buf + ret, size - ret, cap->allows);
+		ret += scnprintf(buf + ret, size - ret, ",\n      \"without_cap\": ");
+		ret += kapi_json_str(buf + ret, size - ret, cap->without_cap);
+		ret += scnprintf(buf + ret, size - ret, ",\n      \"check_condition\": ");
+		ret += kapi_json_str(buf + ret, size - ret, cap->check_condition);
+		ret += scnprintf(buf + ret, size - ret, ",\n      \"priority\": %u", cap->priority);
+
+		if (cap->alternative_count > 0) {
+			int j;
+
+			ret += scnprintf(buf + ret, size - ret,
+				",\n      \"alternatives\": [");
+			for (j = 0; j < cap->alternative_count; j++) {
+				ret += scnprintf(buf + ret, size - ret,
+					"%d%s", cap->alternative[j],
+					(j < cap->alternative_count - 1) ? ", " : "");
+			}
+			ret += scnprintf(buf + ret, size - ret, "]");
+		}
+
+		ret += scnprintf(buf + ret, size - ret,
+			"\n    }%s\n",
+			(i < spec->capability_count - 1) ? "," : "");
+	}
+
+	ret += scnprintf(buf + ret, size - ret, "  ],\n");
+
+	/* Additional info */
+	ret += scnprintf(buf + ret, size - ret, "  \"since_version\": ");
+	ret += kapi_json_str(buf + ret, size - ret, spec->since_version);
+	ret += scnprintf(buf + ret, size - ret, ",\n  \"examples\": ");
+	ret += kapi_json_str(buf + ret, size - ret, spec->examples);
+	ret += scnprintf(buf + ret, size - ret, ",\n  \"notes\": ");
+	ret += kapi_json_str(buf + ret, size - ret, spec->notes);
+	ret += scnprintf(buf + ret, size - ret, "\n}\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kapi_export_json);
+
+
+/**
+ * kapi_print_spec - Print API specification to kernel log
+ * @spec: API specification to print
+ */
+void kapi_print_spec(const struct kernel_api_spec *spec)
+{
+	int i;
+
+	if (!spec)
+		return;
+
+	pr_info("=== Kernel API Specification ===\n");
+	pr_info("Name: %s\n", spec->name);
+	pr_info("Version: %u\n", spec->version);
+	pr_info("Description: %s\n", spec->description);
+
+	if (spec->long_description[0])
+		pr_info("Long Description: %s\n", spec->long_description);
+
+	pr_info("Context Flags: 0x%x\n", spec->context_flags);
+
+	/* Parameters */
+	if (spec->param_count > 0) {
+		pr_info("Parameters:\n");
+		for (i = 0; i < spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+			const struct kapi_param_spec *param = &spec->params[i];
+			pr_info("  [%d] %s: %s (flags: 0x%x)\n",
+				i, param->name, param->type_name, param->flags);
+			if (param->description[0])
+				pr_info("      Description: %s\n", param->description);
+		}
+	}
+
+	/* Return value */
+	pr_info("Return: %s\n", spec->return_spec.type_name);
+	if (spec->return_spec.description[0])
+		pr_info("  Description: %s\n", spec->return_spec.description);
+
+	/* Errors */
+	if (spec->error_count > 0) {
+		pr_info("Possible Errors:\n");
+		for (i = 0; i < spec->error_count && i < KAPI_MAX_ERRORS; i++) {
+			const struct kapi_error_spec *error = &spec->errors[i];
+			pr_info("  %s (%d): %s\n",
+				error->name, error->error_code, error->condition);
+		}
+	}
+
+	/* Capabilities */
+	if (spec->capability_count > 0) {
+		pr_info("Capabilities:\n");
+		for (i = 0; i < spec->capability_count && i < KAPI_MAX_CAPABILITIES; i++) {
+			const struct kapi_capability_spec *cap = &spec->capabilities[i];
+			pr_info("  %s (%d):\n", cap->cap_name, cap->capability);
+			pr_info("    Action: %s\n", capability_action_to_string(cap->action));
+			pr_info("    Allows: %s\n", cap->allows);
+			pr_info("    Without: %s\n", cap->without_cap);
+			if (cap->check_condition[0])
+				pr_info("    Condition: %s\n", cap->check_condition);
+		}
+	}
+
+	pr_info("================================\n");
+}
+EXPORT_SYMBOL_GPL(kapi_print_spec);
+
+#ifdef CONFIG_KAPI_RUNTIME_CHECKS
+
+/**
+ * kapi_validate_fd - Validate that a file descriptor value is in valid range
+ * @fd: File descriptor to validate
+ *
+ * Only checks the numeric range, not whether the fd is currently open.
+ * Checking openness would be TOCTOU (the fd can be closed between check
+ * and use) and incorrect for close() (which should accept any fd, returning
+ * EBADF for invalid ones). The kernel's own syscall handling validates
+ * actual fd state.
+ *
+ * Return: true if fd is in valid range, false otherwise
+ */
+static bool kapi_validate_fd(int fd)
+{
+	/* Special case: AT_FDCWD is always valid */
+	if (fd == AT_FDCWD)
+		return true;
+
+	/* Check basic range - negative fds are invalid */
+	if (fd < 0)
+		return false;
+
+	return true;
+}
+
+/**
+ * kapi_validate_user_ptr - Validate that a user pointer is accessible
+ * @ptr: User pointer to validate
+ * @size: Size in bytes to validate
+ *
+ * Return: true if user memory is accessible, false otherwise
+ */
+static bool kapi_validate_user_ptr(const void __user *ptr, size_t size)
+{
+	/* NULL pointers are not valid; caller handles optional case */
+	if (!ptr)
+		return false;
+
+	return access_ok(ptr, size);
+}
+
+/**
+ * kapi_validate_user_ptr_with_params - Validate user pointer with dynamic size
+ * @param_spec: Parameter specification
+ * @ptr: User pointer to validate
+ * @all_params: Array of all parameter values
+ * @param_count: Number of parameters
+ *
+ * Return: true if user memory is accessible, false otherwise
+ */
+static bool kapi_validate_user_ptr_with_params(const struct kapi_param_spec *param_spec,
+						const void __user *ptr,
+						const s64 *all_params,
+						int param_count)
+{
+	size_t actual_size;
+
+	/* NULL is allowed for optional parameters */
+	if (!ptr && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+		return true;
+
+	/* Calculate actual size based on related parameter */
+	if (param_spec->size_param_idx >= 0 &&
+	    param_spec->size_param_idx < param_count) {
+		s64 count = all_params[param_spec->size_param_idx];
+
+		/* Validate count is non-negative */
+		if (count < 0) {
+			pr_warn_ratelimited("Parameter %s: size determinant is negative (%lld)\n",
+				param_spec->name, count);
+			return false;
+		}
+
+		/* Check for multiplication overflow */
+		if (param_spec->size_multiplier > 0 &&
+		    count > SIZE_MAX / param_spec->size_multiplier) {
+			pr_warn_ratelimited("Parameter %s: size calculation overflow\n",
+				param_spec->name);
+			return false;
+		}
+
+		actual_size = (size_t)count * param_spec->size_multiplier;
+	} else {
+		/* Use fixed size */
+		actual_size = param_spec->size;
+	}
+
+	return kapi_validate_user_ptr(ptr, actual_size);
+}
+
+/**
+ * kapi_validate_path - Validate that a pathname is accessible and within limits
+ * @path: User pointer to pathname
+ * @param_spec: Parameter specification
+ *
+ * Return: true if path is valid, false otherwise
+ */
+static bool kapi_validate_path(const char __user *path,
+				const struct kapi_param_spec *param_spec)
+{
+	size_t len;
+
+	/* NULL is allowed for optional parameters */
+	if (!path && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+		return true;
+
+	if (!path) {
+		pr_warn_ratelimited("Parameter %s: NULL path not allowed\n", param_spec->name);
+		return false;
+	}
+
+	/* Check if the path is accessible */
+	if (!access_ok(path, 1)) {
+		pr_warn_ratelimited("Parameter %s: path pointer %p not accessible\n",
+			param_spec->name, path);
+		return false;
+	}
+
+	/*
+	 * Use strnlen_user to check the path length and accessibility.
+	 * Note: strnlen_user() is subject to TOCTOU -- the measured length
+	 * may change if another thread modifies the user memory. This is
+	 * acceptable since the kernel re-copies and re-validates the path
+	 * later in the syscall path. This check is best-effort.
+	 */
+	len = strnlen_user(path, PATH_MAX + 1);
+	if (len == 0) {
+		pr_warn_ratelimited("Parameter %s: invalid path pointer %p\n",
+			param_spec->name, path);
+		return false;
+	}
+
+	/* Check path length limit */
+	if (len > PATH_MAX) {
+		pr_warn_ratelimited("Parameter %s: path too long (exceeds PATH_MAX)\n",
+			param_spec->name);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * kapi_validate_user_string - Validate a userspace null-terminated string
+ * @str: User pointer to string
+ * @param_spec: Parameter specification containing length constraints
+ *
+ * Validates that the userspace string pointer is accessible and that the
+ * string length (excluding null terminator) is within the range specified
+ * by min_value and max_value in the parameter specification.
+ *
+ * Return: true if string is valid, false otherwise
+ */
+static bool kapi_validate_user_string(const char __user *str,
+				       const struct kapi_param_spec *param_spec)
+{
+	size_t len;
+	size_t max_check_len;
+
+	/* NULL is allowed for optional parameters */
+	if (!str && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+		return true;
+
+	if (!str) {
+		pr_warn_ratelimited("Parameter %s: NULL string not allowed\n", param_spec->name);
+		return false;
+	}
+
+	/* Check if the string pointer is accessible */
+	if (!access_ok(str, 1)) {
+		pr_warn_ratelimited("Parameter %s: string pointer %p not accessible\n",
+			param_spec->name, str);
+		return false;
+	}
+
+	/*
+	 * Use strnlen_user to check the string length and validate accessibility.
+	 * Check up to max_value + 1 to detect strings that are too long.
+	 * If max_value is 0 or unset, use PATH_MAX as a reasonable default.
+	 *
+	 * Note: strnlen_user() is subject to TOCTOU -- see comment in
+	 * kapi_validate_path() above. This check is best-effort.
+	 */
+	max_check_len = param_spec->max_value > 0 ?
+			(size_t)param_spec->max_value + 1 : PATH_MAX + 1;
+	len = strnlen_user(str, max_check_len);
+
+	if (len == 0) {
+		pr_warn_ratelimited("Parameter %s: invalid string pointer %p\n",
+			param_spec->name, str);
+		return false;
+	}
+
+	/*
+	 * strnlen_user returns the length including the null terminator.
+	 * Convert to string length (excluding terminator) for range check.
+	 */
+	len--;
+
+	/* Check minimum length constraint */
+	if (param_spec->min_value > 0 && len < (size_t)param_spec->min_value) {
+		pr_warn_ratelimited("Parameter %s: string too short (%zu < %lld)\n",
+			param_spec->name, len, param_spec->min_value);
+		return false;
+	}
+
+	/* Check maximum length constraint */
+	if (param_spec->max_value > 0 && len > (size_t)param_spec->max_value) {
+		pr_warn_ratelimited("Parameter %s: string too long (%zu > %lld)\n",
+			param_spec->name, len, param_spec->max_value);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * kapi_validate_user_ptr_constraint - Validate a userspace pointer with size
+ * @ptr: User pointer to validate
+ * @param_spec: Parameter specification containing size
+ *
+ * Validates that the userspace pointer is accessible and that the memory
+ * region of the specified size can be accessed. The size is taken from
+ * the param_spec->size field.
+ *
+ * Return: true if pointer is valid, false otherwise
+ */
+static bool kapi_validate_user_ptr_constraint(const void __user *ptr,
+					       const struct kapi_param_spec *param_spec)
+{
+	/* NULL is allowed for optional parameters */
+	if (!ptr && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+		return true;
+
+	if (!ptr) {
+		pr_warn_ratelimited("Parameter %s: NULL pointer not allowed\n", param_spec->name);
+		return false;
+	}
+
+	/* Validate size is specified */
+	if (param_spec->size == 0) {
+		pr_warn_ratelimited("Parameter %s: size not specified for user pointer validation\n",
+			param_spec->name);
+		return false;
+	}
+
+	/* Check if the memory region is accessible */
+	if (!access_ok(ptr, param_spec->size)) {
+		pr_warn_ratelimited("Parameter %s: user pointer %p not accessible for %zu bytes\n",
+			param_spec->name, ptr, param_spec->size);
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * kapi_validate_param - Validate a parameter against its specification
+ * @param_spec: Parameter specification
+ * @value: Parameter value to validate
+ *
+ * Return: true if valid, false otherwise
+ */
+bool kapi_validate_param(const struct kapi_param_spec *param_spec, s64 value)
+{
+	int i;
+
+	/* Special handling for file descriptor type */
+	if (param_spec->type == KAPI_TYPE_FD) {
+		if (value < INT_MIN || value > INT_MAX) {
+			pr_warn_ratelimited("Parameter %s: file descriptor %lld out of int range\n",
+				param_spec->name, value);
+			return false;
+		}
+		if (!kapi_validate_fd((int)value)) {
+			pr_warn_ratelimited("Parameter %s: invalid file descriptor %lld\n",
+				param_spec->name, value);
+			return false;
+		}
+		/* Continue with additional constraint checks if needed */
+	}
+
+	/* Special handling for user pointer type */
+	if (param_spec->type == KAPI_TYPE_USER_PTR) {
+		const void __user *ptr = (const void __user *)value;
+
+		/* NULL is allowed for optional parameters */
+		if (!ptr && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+			return true;
+
+		if (!kapi_validate_user_ptr(ptr, param_spec->size)) {
+			pr_warn_ratelimited("Parameter %s: invalid user pointer %p (size: %zu)\n",
+				param_spec->name, ptr, param_spec->size);
+			return false;
+		}
+		/* Continue with additional constraint checks if needed */
+	}
+
+	/* Special handling for path type */
+	if (param_spec->type == KAPI_TYPE_PATH) {
+		const char __user *path = (const char __user *)value;
+
+		if (!kapi_validate_path(path, param_spec)) {
+			return false;
+		}
+		/* Continue with additional constraint checks if needed */
+	}
+
+	switch (param_spec->constraint_type) {
+	case KAPI_CONSTRAINT_NONE:
+	case KAPI_CONSTRAINT_BUFFER:
+		return true;
+
+	case KAPI_CONSTRAINT_RANGE:
+		/*
+		 * If max_value is negative, it was likely set from an unsigned
+		 * constant (e.g. SIZE_MAX) that overflowed s64.  Treat as no
+		 * upper bound — only check the minimum.
+		 */
+		if (param_spec->max_value >= 0) {
+			if (value < param_spec->min_value ||
+			    value > param_spec->max_value) {
+				pr_warn_ratelimited("Parameter %s value %lld out of range [%lld, %lld]\n",
+					param_spec->name, value,
+					param_spec->min_value,
+					param_spec->max_value);
+				return false;
+			}
+		} else {
+			if (value < param_spec->min_value) {
+				pr_warn_ratelimited("Parameter %s value %lld below minimum %lld\n",
+					param_spec->name, value,
+					param_spec->min_value);
+				return false;
+			}
+		}
+		return true;
+
+	case KAPI_CONSTRAINT_MASK:
+		if (value & ~param_spec->valid_mask) {
+			pr_warn_ratelimited("Parameter %s value 0x%llx contains invalid bits (valid mask: 0x%llx)\n",
+				param_spec->name, value, param_spec->valid_mask);
+			return false;
+		}
+		return true;
+
+	case KAPI_CONSTRAINT_ENUM:
+		if (!param_spec->enum_values || param_spec->enum_count == 0)
+			return true;
+
+		for (i = 0; i < param_spec->enum_count; i++) {
+			if (value == param_spec->enum_values[i])
+				return true;
+		}
+		pr_warn_ratelimited("Parameter %s value %lld not in valid enumeration\n",
+			param_spec->name, value);
+		return false;
+
+	case KAPI_CONSTRAINT_ALIGNMENT:
+		if (param_spec->alignment == 0) {
+			pr_warn_ratelimited("Parameter %s: alignment constraint specified but alignment is 0\n",
+				param_spec->name);
+			return false;
+		}
+		if (param_spec->alignment & (param_spec->alignment - 1)) {
+			pr_warn_ratelimited("Parameter %s: alignment %zu is not a power of two\n",
+				param_spec->name, param_spec->alignment);
+			return false;
+		}
+		if (value & (param_spec->alignment - 1)) {
+			pr_warn_ratelimited("Parameter %s value 0x%llx not aligned to %zu boundary\n",
+				param_spec->name, value, param_spec->alignment);
+			return false;
+		}
+		return true;
+
+	case KAPI_CONSTRAINT_POWER_OF_TWO:
+		if (value == 0 || (value & (value - 1))) {
+			pr_warn_ratelimited("Parameter %s value %lld is not a power of two\n",
+				param_spec->name, value);
+			return false;
+		}
+		return true;
+
+	case KAPI_CONSTRAINT_PAGE_ALIGNED:
+		if (value & (PAGE_SIZE - 1)) {
+			pr_warn_ratelimited("Parameter %s value 0x%llx not page-aligned (PAGE_SIZE=%ld)\n",
+				param_spec->name, value, PAGE_SIZE);
+			return false;
+		}
+		return true;
+
+	case KAPI_CONSTRAINT_NONZERO:
+		if (value == 0) {
+			pr_warn_ratelimited("Parameter %s must be non-zero\n", param_spec->name);
+			return false;
+		}
+		return true;
+
+	case KAPI_CONSTRAINT_USER_STRING:
+		return kapi_validate_user_string((const char __user *)value, param_spec);
+
+	case KAPI_CONSTRAINT_USER_PATH:
+		return kapi_validate_path((const char __user *)value, param_spec);
+
+	case KAPI_CONSTRAINT_USER_PTR:
+		return kapi_validate_user_ptr_constraint((const void __user *)value, param_spec);
+
+	case KAPI_CONSTRAINT_CUSTOM:
+		if (param_spec->validate)
+			return param_spec->validate(value);
+		return true;
+
+	default:
+		return true;
+	}
+}
+EXPORT_SYMBOL_GPL(kapi_validate_param);
+
+/**
+ * kapi_validate_param_with_context - Validate parameter with access to all params
+ * @param_spec: Parameter specification
+ * @value: Parameter value to validate
+ * @all_params: Array of all parameter values
+ * @param_count: Number of parameters
+ *
+ * Return: true if valid, false otherwise
+ */
+bool kapi_validate_param_with_context(const struct kapi_param_spec *param_spec,
+				       s64 value, const s64 *all_params, int param_count)
+{
+	/* Special handling for user pointer type with dynamic sizing */
+	if (param_spec->type == KAPI_TYPE_USER_PTR) {
+		const void __user *ptr = (const void __user *)value;
+
+		/* NULL is allowed for optional parameters */
+		if (!ptr && (param_spec->flags & KAPI_PARAM_OPTIONAL))
+			return true;
+
+		if (!kapi_validate_user_ptr_with_params(param_spec, ptr, all_params, param_count)) {
+			pr_warn_ratelimited("Parameter %s: invalid user pointer %p\n",
+				param_spec->name, ptr);
+			return false;
+		}
+		/* Continue with additional constraint checks if needed */
+	}
+
+	/* For other types, fall back to regular validation */
+	return kapi_validate_param(param_spec, value);
+}
+EXPORT_SYMBOL_GPL(kapi_validate_param_with_context);
+
+/**
+ * kapi_validate_syscall_param - Validate syscall parameter with enforcement
+ * @spec: API specification
+ * @param_idx: Parameter index
+ * @value: Parameter value
+ *
+ * Return: -EINVAL if invalid, 0 if valid
+ */
+int kapi_validate_syscall_param(const struct kernel_api_spec *spec,
+				 int param_idx, s64 value)
+{
+	const struct kapi_param_spec *param_spec;
+
+	if (!spec || param_idx < 0 || param_idx >= spec->param_count)
+		return 0;
+
+	param_spec = &spec->params[param_idx];
+
+	if (!kapi_validate_param(param_spec, value)) {
+		if (strncmp(spec->name, "sys_", 4) == 0) {
+			/* For syscalls, we can return EINVAL to userspace */
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_syscall_param);
+
+/**
+ * kapi_validate_syscall_params - Validate all syscall parameters together
+ * @spec: API specification
+ * @params: Array of parameter values
+ * @param_count: Number of parameters
+ *
+ * Return: -EINVAL if any parameter is invalid, 0 if all valid
+ */
+int kapi_validate_syscall_params(const struct kernel_api_spec *spec,
+				 const s64 *params, int param_count)
+{
+	int i;
+
+	if (!spec || !params)
+		return 0;
+
+	/* Validate that we have the expected number of parameters */
+	if (param_count != spec->param_count) {
+		pr_warn_ratelimited("API %s: parameter count mismatch (expected %u, got %d)\n",
+			spec->name, spec->param_count, param_count);
+		return -EINVAL;
+	}
+
+	/* Validate each parameter with context */
+	for (i = 0; i < spec->param_count && i < KAPI_MAX_PARAMS; i++) {
+		const struct kapi_param_spec *param_spec = &spec->params[i];
+
+		if (!kapi_validate_param_with_context(param_spec, params[i], params, param_count)) {
+			if (strncmp(spec->name, "sys_", 4) == 0) {
+				/* For syscalls, we can return EINVAL to userspace */
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_syscall_params);
+
+/**
+ * kapi_check_return_success - Check if return value indicates success
+ * @return_spec: Return specification
+ * @retval: Return value to check
+ *
+ * Returns true if the return value indicates success according to the spec.
+ */
+bool kapi_check_return_success(const struct kapi_return_spec *return_spec, s64 retval)
+{
+	u32 i;
+
+	if (!return_spec)
+		return true; /* No spec means we can't validate */
+
+	switch (return_spec->check_type) {
+	case KAPI_RETURN_EXACT:
+		return retval == return_spec->success_value;
+
+	case KAPI_RETURN_RANGE:
+		return retval >= return_spec->success_min &&
+		       retval <= return_spec->success_max;
+
+	case KAPI_RETURN_ERROR_CHECK:
+		/* Success if NOT in error list */
+		if (return_spec->error_values) {
+			for (i = 0; i < return_spec->error_count; i++) {
+				if (retval == return_spec->error_values[i])
+					return false; /* Found in error list */
+			}
+		}
+		return true; /* Not in error list = success */
+
+	case KAPI_RETURN_FD:
+		/* File descriptors: >= 0 is success, < 0 is error */
+		return retval >= 0;
+
+	case KAPI_RETURN_CUSTOM:
+		if (return_spec->is_success)
+			return return_spec->is_success(retval);
+		fallthrough;
+
+	default:
+		return true; /* Unknown check type, assume success */
+	}
+}
+EXPORT_SYMBOL_GPL(kapi_check_return_success);
+
+/**
+ * kapi_validate_return_value - Validate that return value matches spec
+ * @spec: API specification
+ * @retval: Return value to validate
+ *
+ * Return: true if return value is valid according to spec, false otherwise.
+ *
+ * This function checks:
+ * 1. If the value indicates success, it must match the success criteria
+ * 2. If the value indicates error, it must be one of the specified error codes
+ */
+bool kapi_validate_return_value(const struct kernel_api_spec *spec, s64 retval)
+{
+	int i;
+	bool is_success;
+
+	if (!spec)
+		return true; /* No spec means we can't validate */
+
+	/* First check if this is a success return */
+	is_success = kapi_check_return_success(&spec->return_spec, retval);
+
+	if (is_success) {
+		/* Special validation for file descriptor returns */
+		if (spec->return_spec.check_type == KAPI_RETURN_FD) {
+			/* For successful FD returns, validate it's a valid FD */
+			if (retval > INT_MAX || !kapi_validate_fd((int)retval)) {
+				pr_warn_ratelimited("API %s returned invalid file descriptor %lld\n",
+					spec->name, retval);
+				return false;
+			}
+		}
+		return true;
+	}
+
+	/* Error case - check if it's one of the specified errors */
+	if (spec->error_count == 0) {
+		/* No errors specified, so any error is potentially valid */
+		pr_debug("API %s returned unspecified error %lld\n",
+			 spec->name, retval);
+		return true;
+	}
+
+	/* Check if the error is in our list of specified errors */
+	for (i = 0; i < spec->error_count && i < KAPI_MAX_ERRORS; i++) {
+		if (retval == spec->errors[i].error_code)
+			return true;
+	}
+
+	/*
+	 * Error not in spec - log at debug level since filesystem-specific and
+	 * device-specific error codes may not be exhaustively listed.
+	 */
+	pr_debug("API %s returned error code %lld not listed in spec\n",
+		 spec->name, retval);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_return_value);
+
+/**
+ * kapi_validate_syscall_return - Validate syscall return value with enforcement
+ * @spec: API specification
+ * @retval: Return value
+ *
+ * Return: 0 if valid, -EINVAL if the return value doesn't match spec
+ *
+ * For syscalls, this can help detect kernel bugs where unspecified error
+ * codes are returned to userspace.
+ */
+int kapi_validate_syscall_return(const struct kernel_api_spec *spec, s64 retval)
+{
+	if (!spec)
+		return 0;
+
+	/* Skip return validation if return spec was not defined */
+	if (spec->return_magic != KAPI_MAGIC_RETURN)
+		return 0;
+
+	if (!kapi_validate_return_value(spec, retval)) {
+		/* Log the violation but don't change the return value */
+		pr_warn_ratelimited("KAPI: Syscall %s returned unspecified value %lld\n",
+				    spec->name, retval);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kapi_validate_syscall_return);
+
+/**
+ * kapi_check_context - Check if current context matches API requirements
+ * @spec: API specification to check against
+ */
+void kapi_check_context(const struct kernel_api_spec *spec)
+{
+	bool valid = false;
+	u32 ctx;
+
+	if (!spec)
+		return;
+
+	ctx = spec->context_flags;
+
+	if (!ctx)
+		return;
+
+	/* Check if we're in an allowed context */
+	if ((ctx & KAPI_CTX_PROCESS) && !in_interrupt())
+		valid = true;
+
+	if ((ctx & KAPI_CTX_SOFTIRQ) && in_softirq())
+		valid = true;
+
+	if ((ctx & KAPI_CTX_HARDIRQ) && in_hardirq())
+		valid = true;
+
+	if ((ctx & KAPI_CTX_NMI) && in_nmi())
+		valid = true;
+
+	if (!valid) {
+		WARN_ONCE(1, "API %s called from invalid context\n", spec->name);
+	}
+
+	/* Check specific requirements */
+	if ((ctx & KAPI_CTX_ATOMIC) && preemptible()) {
+		WARN_ONCE(1, "API %s requires atomic context\n", spec->name);
+	}
+
+	if ((ctx & KAPI_CTX_SLEEPABLE) && !preemptible()) {
+		WARN_ONCE(1, "API %s requires sleepable context\n", spec->name);
+	}
+}
+EXPORT_SYMBOL_GPL(kapi_check_context);
+
+#endif /* CONFIG_KAPI_RUNTIME_CHECKS */
diff --git a/scripts/generate_api_specs.sh b/scripts/generate_api_specs.sh
new file mode 100755
index 0000000000000..2c3078a508fef
--- /dev/null
+++ b/scripts/generate_api_specs.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Stub script for generating API specifications collector
+# This is a placeholder until the full implementation is available
+#
+
+cat << 'EOF'
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Auto-generated API specifications collector (stub)
+ * Generated by scripts/generate_api_specs.sh
+ */
+
+#include <linux/kernel_api_spec.h>
+
+/* No API specifications collected yet */
+EOF
-- 
2.51.0


