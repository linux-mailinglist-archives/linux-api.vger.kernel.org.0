Return-Path: <linux-api+bounces-5945-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NBzBIgrtGkEigAAu9opvQ
	(envelope-from <linux-api+bounces-5945-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:21:44 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441C1285D6A
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8AE731F076B
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93438C2CC;
	Fri, 13 Mar 2026 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5edCRGr"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EC39BFF6;
	Fri, 13 Mar 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414594; cv=none; b=lL/MXquIlfCt+oMqIyrdBZa186K11XjIk7Nz65NUcYchOGBM2nIgJNkVfiiSackTRxyMHFv3cUCwoCd+oClywKV/KaemXufABv0fAVfthUsfE671CS/d0HSdfHlfWMkRhLHN+RylaLpXLyKt2fA31TeoptRTu8MSvWcVNDwofHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414594; c=relaxed/simple;
	bh=bGe2CDufgadbzyRei01FCdr9S3y7RRoil9ng7I1zmDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY5uMydhfep5ZIVi1MS9jbZ99sMY1OZqZ6T/6kOPQMTnzuW1vVeC1WSpXc+Y+CtYjU70QymeNRyd4yZKnXmdEFjLR2TjAnPCWrsClor3De2jUvUcxkwwId8hrEk2bxib0qVzolZKcFNoYJNCwqhW2FrRC+L2ZuiIPjRsH9xuvJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5edCRGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D2FC2BC9E;
	Fri, 13 Mar 2026 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773414593;
	bh=bGe2CDufgadbzyRei01FCdr9S3y7RRoil9ng7I1zmDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5edCRGrT/OLprDCAun2mVsZ82ZXQ5yf6nvx5xhd5UC7DnxQyiU4fQtBAQkIy9Am/
	 C+/esElFjz3M52+F2GZf9E3A8cxRVcb6RrSVuBOK9RJZjJz6rtiOcQDYMesUGYH5CS
	 QlVYbLwva/eRtvzfSr5ub9RF9RJ8yDqSeMNVqGP4EYzfr+zyP4WWsxidvVtdzqoPHP
	 30wVGnB67H5xCXeFol28XVG4gRssT9qB4MMX1TkwML4icaznig2cvFP/tIWnBkBnUN
	 vzp7AEKmgLDl6udueCptf64jkSE9PbsCCzyz1MVMh2dNW+kW1KBRa8EbXSc80g6SwN
	 U7FiR2rO0SXSQ==
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
Subject: [PATCH 2/9] kernel/api: enable kerneldoc-based API specifications
Date: Fri, 13 Mar 2026 11:09:12 -0400
Message-ID: <20260313150928.2637368-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313150928.2637368-1-sashal@kernel.org>
References: <20260313150928.2637368-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-5945-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-doc.py:url,kdoc_apispec.py:url,makefile.build:url,self.data:url]
X-Rspamd-Queue-Id: 441C1285D6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch adds support for extracting API specifications from
kernel-doc comments and generating C macro invocations for the
kernel API specification framework.

Changes include:
- New kdoc_apispec.py module for generating API spec macros
- Updates to kernel-doc.py to support -apispec output format
- Build system integration in Makefile.build
- Generator script for collecting all API specifications
- Support for API-specific sections in kernel-doc comments

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Makefile.build                |  31 +
 scripts/Makefile.clean                |   3 +
 scripts/generate_api_specs.sh         |  18 -
 tools/docs/kernel-doc                 |   5 +
 tools/lib/python/kdoc/kdoc_apispec.py | 887 ++++++++++++++++++++++++++
 tools/lib/python/kdoc/kdoc_output.py  |   9 +-
 tools/lib/python/kdoc/kdoc_parser.py  |  86 ++-
 7 files changed, 1016 insertions(+), 23 deletions(-)
 delete mode 100755 scripts/generate_api_specs.sh
 create mode 100644 tools/lib/python/kdoc/kdoc_apispec.py

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 32e209bc7985c..7081884e3c528 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -174,6 +174,37 @@ ifneq ($(KBUILD_EXTRA_WARN),)
 endif
 endif
 
+# Generate API spec headers from kernel-doc comments
+ifeq ($(CONFIG_KAPI_SPEC),y)
+# Function to check if a file has API specifications
+has-apispec = $(shell grep -qE '^\s*\*\s*context-flags:' $(src)/$(1) 2>/dev/null && echo $(1))
+
+# Get base names without directory prefix
+c-objs-base := $(notdir $(real-obj-y) $(real-obj-m))
+# Filter to only .o files with corresponding .c source files
+c-files := $(foreach o,$(c-objs-base),$(if $(wildcard $(src)/$(o:.o=.c)),$(o:.o=.c)))
+# Also check for any additional .c files that contain API specs but are included
+extra-c-files := $(shell find $(src) -maxdepth 1 -name "*.c" -exec grep -l '^\s*\*\s*\(long-desc\|context-flags\|state-trans\):' {} \; 2>/dev/null | xargs -r basename -a)
+# Combine both lists and remove duplicates
+all-c-files := $(sort $(c-files) $(extra-c-files))
+# Only include files that actually have API specifications
+apispec-files := $(foreach f,$(all-c-files),$(call has-apispec,$(f)))
+# Generate apispec targets with proper directory prefix
+apispec-y := $(addprefix $(obj)/,$(apispec-files:.c=.apispec.h))
+always-y += $(apispec-y)
+targets += $(apispec-y)
+
+quiet_cmd_apispec = APISPEC $@
+      cmd_apispec = PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -apispec \
+                    $(KDOCFLAGS) $< > $@ || rm -f $@
+
+$(obj)/%.apispec.h: $(src)/%.c $(KERNELDOC) FORCE
+	$(call if_changed,apispec)
+
+# Source files that include their own apispec.h need to depend on it
+$(foreach f,$(apispec-files),$(eval $(obj)/$(f:.c=.o): $(obj)/$(f:.c=.apispec.h)))
+endif
+
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 6ead00ec7313b..f78dbbe637f27 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -35,6 +35,9 @@ __clean-files   := $(filter-out $(no-clean-files), $(__clean-files))
 
 __clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))
 
+# Also clean generated apispec headers (computed dynamically in Makefile.build)
+__clean-files   += $(wildcard $(obj)/*.apispec.h)
+
 # ==========================================================================
 
 # To make this rule robust against "Argument list too long" error,
diff --git a/scripts/generate_api_specs.sh b/scripts/generate_api_specs.sh
deleted file mode 100755
index 2c3078a508fef..0000000000000
--- a/scripts/generate_api_specs.sh
+++ /dev/null
@@ -1,18 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Stub script for generating API specifications collector
-# This is a placeholder until the full implementation is available
-#
-
-cat << 'EOF'
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Auto-generated API specifications collector (stub)
- * Generated by scripts/generate_api_specs.sh
- */
-
-#include <linux/kernel_api_spec.h>
-
-/* No API specifications collected yet */
-EOF
diff --git a/tools/docs/kernel-doc b/tools/docs/kernel-doc
index aed09f9a54dd1..e71e663d9b7c0 100755
--- a/tools/docs/kernel-doc
+++ b/tools/docs/kernel-doc
@@ -253,6 +253,8 @@ def main():
                          help="Output reStructuredText format (default).")
     out_fmt.add_argument("-N", "-none", "--none", action="store_true",
                          help="Do not output documentation, only warnings.")
+    out_fmt.add_argument("-apispec", "--apispec", action="store_true",
+                         help="Output C macro invocations for kernel API specifications.")
 
     #
     # Output selection mutually-exclusive group
@@ -323,11 +325,14 @@ def main():
     #
     from kdoc.kdoc_files import KernelFiles             # pylint: disable=C0415
     from kdoc.kdoc_output import RestFormat, ManFormat  # pylint: disable=C0415
+    from kdoc.kdoc_apispec import ApiSpecFormat         # pylint: disable=C0415
 
     if args.man:
         out_style = ManFormat(modulename=args.modulename)
     elif args.none:
         out_style = None
+    elif args.apispec:
+        out_style = ApiSpecFormat()
     else:
         out_style = RestFormat()
 
diff --git a/tools/lib/python/kdoc/kdoc_apispec.py b/tools/lib/python/kdoc/kdoc_apispec.py
new file mode 100644
index 0000000000000..1d83539548a42
--- /dev/null
+++ b/tools/lib/python/kdoc/kdoc_apispec.py
@@ -0,0 +1,887 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Generate C macro invocations for kernel API specifications from kernel-doc comments.
+
+This module creates C header files with API specification macros that match
+the kernel API specification framework introduced in commit 9688de5c25bed.
+"""
+
+from kdoc.kdoc_output import OutputFormat
+import re
+
+
+# Maximum string lengths (from kernel_api_spec.h)
+KAPI_MAX_DESC_LEN = 512
+KAPI_MAX_NAME_LEN = 128
+KAPI_MAX_SIGNAL_NAME_LEN = 32
+KAPI_MAX_LONG_DESC_LEN = KAPI_MAX_DESC_LEN * 4  # 2048 bytes
+KAPI_MAX_NOTES_LEN = KAPI_MAX_DESC_LEN * 2      # 1024 bytes
+KAPI_MAX_EXAMPLES_LEN = KAPI_MAX_DESC_LEN * 2   # 1024 bytes
+
+# Valid KAPI effect types
+VALID_EFFECT_TYPES = {
+    'KAPI_EFFECT_NONE', 'KAPI_EFFECT_MODIFY_STATE', 'KAPI_EFFECT_PROCESS_STATE',
+    'KAPI_EFFECT_IRREVERSIBLE', 'KAPI_EFFECT_SCHEDULE', 'KAPI_EFFECT_FILESYSTEM',
+    'KAPI_EFFECT_HARDWARE', 'KAPI_EFFECT_ALLOC_MEMORY', 'KAPI_EFFECT_FREE_MEMORY',
+    'KAPI_EFFECT_SIGNAL_SEND', 'KAPI_EFFECT_FILE_POSITION', 'KAPI_EFFECT_LOCK_ACQUIRE',
+    'KAPI_EFFECT_LOCK_RELEASE', 'KAPI_EFFECT_RESOURCE_CREATE', 'KAPI_EFFECT_RESOURCE_DESTROY',
+    'KAPI_EFFECT_NETWORK'
+}
+
+
+class ApiSpecFormat(OutputFormat):
+    """Generate C macro invocations for kernel API specifications"""
+
+    def __init__(self):
+        super().__init__()
+        self.header_written = False
+
+    def msg(self, fname, name, args):
+        """Handles a single entry from kernel-doc parser"""
+        if not self.header_written:
+            header = self._generate_header()
+            self.header_written = True
+        else:
+            header = ""
+
+        self.data = ""
+        result = super().msg(fname, name, args)
+        return header + (result if result else self.data)
+
+    def _generate_header(self):
+        """Generate the file header"""
+        return (
+            "/* SPDX-License-Identifier: GPL-2.0 */\n"
+            "/* Auto-generated from kerneldoc annotations - DO NOT EDIT */\n\n"
+            "#include <linux/kernel_api_spec.h>\n"
+            "#include <linux/errno.h>\n\n"
+        )
+
+    def _format_macro_param(self, value, max_len=KAPI_MAX_DESC_LEN):
+        """Format a value for use in C macro parameter, truncating if needed"""
+        if value is None:
+            return '""'
+        value = str(value).replace('\\', '\\\\').replace('"', '\\"')
+        value = value.replace('\n', ' ').replace('\t', ' ').replace('\r', '')
+        value = value.replace('\0', '')
+        # Truncate to fit within max_len, accounting for null terminator
+        if len(value) > max_len - 1:
+            value = value[:max_len - 4] + '...'
+        return f'"{value}"'
+
+    def _get_section(self, sections, key):
+        """Get first line from sections, checking with and without @ prefix and case variants"""
+        for variant in [key, key.capitalize(), key.title()]:
+            for prefix in ['', '@']:
+                full_key = prefix + variant
+                if full_key in sections:
+                    content = sections[full_key].strip()
+                    # Return only first line to avoid mixing sections
+                    return content.split('\n')[0].strip() if content else ''
+        return None
+
+    def _get_raw_section(self, sections, key):
+        """Get full section content, checking with and without @ prefix and case variants"""
+        for variant in [key, key.capitalize(), key.title()]:
+            for prefix in ['', '@']:
+                full_key = prefix + variant
+                if full_key in sections:
+                    return sections[full_key]
+        return ''
+
+    def _get_multiline_section(self, sections, key):
+        """Get full multi-line section content, joined into a single string.
+
+        This is used for fields like notes, long-desc, and examples that
+        can span multiple lines in the kerneldoc comment.
+        """
+        content = self._get_raw_section(sections, key)
+        if not content:
+            return None
+
+        # Split into lines, strip each, and join with space
+        lines = content.strip().split('\n')
+        # Join lines, preserving paragraph breaks (double newlines become single space)
+        result = ' '.join(line.strip() for line in lines if line.strip())
+        return result if result else None
+
+    def _parse_indented_items(self, section_content, item_parser):
+        """Generic parser for indented items.
+
+        Args:
+            section_content: Raw section content
+            item_parser: Function that takes (lines, start_index) and returns (item, next_index)
+
+        Returns:
+            List of parsed items
+        """
+        if not section_content:
+            return []
+
+        items = []
+        lines = section_content.strip().split('\n')
+        i = 0
+
+        while i < len(lines):
+            if not lines[i].strip():
+                i += 1
+                continue
+
+            # Check if this is a main item (not indented)
+            if not lines[i].startswith((' ', '\t')):
+                item, i = item_parser(lines, i)
+                if item:
+                    items.append(item)
+            else:
+                i += 1
+
+        return items
+
+    def _parse_subfields(self, lines, start_idx):
+        """Parse indented subfields starting from start_idx+1.
+
+        Returns: (dict of subfields, next index)
+        """
+        subfields = {}
+        i = start_idx + 1
+
+        while i < len(lines) and (lines[i].startswith((' ', '\t'))):
+            line = lines[i].strip()
+            if ':' in line:
+                key, value = line.split(':', 1)
+                subfields[key.strip()] = value.strip()
+            i += 1
+
+        return subfields, i
+
+    def _parse_signal_item(self, lines, i):
+        """Parse a single signal specification"""
+        signal = {'name': lines[i].strip()}
+        subfields, next_i = self._parse_subfields(lines, i)
+
+        # Map subfields to signal attributes
+        signal.update({
+            'direction': subfields.get('direction', 'KAPI_SIGNAL_RECEIVE'),
+            'action': subfields.get('action', 'KAPI_SIGNAL_ACTION_RETURN'),
+            'condition': subfields.get('condition'),
+            'desc': subfields.get('desc'),
+            'error': subfields.get('error'),
+            'timing': subfields.get('timing'),
+            'priority': subfields.get('priority'),
+            'interruptible': subfields.get('interruptible', '').lower() == 'yes',
+            'number': subfields.get('number', '0'),
+        })
+
+        return signal, next_i
+
+    def _parse_error_item(self, lines, i):
+        """Parse a single error specification"""
+        line = lines[i].strip()
+
+        # Skip desc: lines
+        if line.startswith('desc:'):
+            return None, i + 1
+
+        # Check for error pattern
+        if not re.match(r'^[A-Z][A-Z0-9_]+,', line):
+            return None, i + 1
+
+        error = {'line': line, 'desc': ''}
+
+        # Look for desc: continuation
+        i += 1
+        desc_lines = []
+        while i < len(lines):
+            next_line = lines[i].strip()
+            if next_line.startswith('desc:'):
+                desc_lines.append(next_line[5:].strip())
+                i += 1
+            elif not next_line:
+                break
+            elif not desc_lines and re.match(r'^[A-Z][A-Z0-9_]+,', next_line):
+                # New error entry, but only if we haven't started a desc block
+                break
+            else:
+                desc_lines.append(next_line)
+                i += 1
+
+        if desc_lines:
+            error['desc'] = ' '.join(desc_lines)
+
+        return error, i
+
+    def _parse_lock_item(self, lines, i):
+        """Parse a single lock specification"""
+        line = lines[i].strip()
+        if ':' not in line:
+            return None, i + 1
+
+        parts = line.split(':', 1)[1].strip().split(',', 1)
+        if len(parts) < 2:
+            return None, i + 1
+
+        lock = {
+            'name': parts[0].strip(),
+            'type': parts[1].strip()
+        }
+
+        subfields, next_i = self._parse_subfields(lines, i)
+
+        # Map boolean fields
+        for field in ['acquired', 'released', 'held-on-entry', 'held-on-exit']:
+            if subfields.get(field, '').lower() == 'true':
+                lock[field] = True
+
+        lock['desc'] = subfields.get('desc', '')
+
+        return lock, next_i
+
+    def _parse_constraint_item(self, lines, i):
+        """Parse a single constraint specification"""
+        line = lines[i].strip()
+
+        # Check for old format with comma
+        if ',' in line:
+            parts = line.split(',', 1)
+            constraint = {
+                'name': parts[0].strip(),
+                'desc': parts[1].strip() if len(parts) > 1 else '',
+                'expr': None
+            }
+        else:
+            constraint = {'name': line, 'desc': '', 'expr': None}
+
+        subfields, next_i = self._parse_subfields(lines, i)
+
+        if 'desc' in subfields:
+            constraint['desc'] = (constraint['desc'] + ' ' + subfields['desc']).strip()
+        constraint['expr'] = subfields.get('expr')
+
+        return constraint, next_i
+
+    def _parse_side_effect_item(self, lines, i):
+        """Parse a single side effect specification"""
+        line = lines[i].strip()
+
+        # Default to new format
+        effect = {
+            'type': line,
+            'target': '',
+            'desc': '',
+            'condition': None,
+            'reversible': False
+        }
+
+        # Check for old format with commas
+        if ',' in line:
+            # Handle condition and reversible flags
+            cond_match = re.search(r',\s*condition=([^,]+?)(?:\s*,\s*reversible=(yes|no)\s*)?$', line)
+            if cond_match:
+                effect['condition'] = cond_match.group(1).strip()
+                effect['reversible'] = cond_match.group(2) == 'yes'
+                line = line[:cond_match.start()]
+            elif ', reversible=yes' in line:
+                effect['reversible'] = True
+                line = line.replace(', reversible=yes', '')
+            elif ', reversible=no' in line:
+                line = line.replace(', reversible=no', '')
+
+            parts = line.split(',', 2)
+            if len(parts) >= 1:
+                effect['type'] = parts[0].strip()
+            if len(parts) >= 2:
+                effect['target'] = parts[1].strip()
+            if len(parts) >= 3:
+                effect['desc'] = parts[2].strip()
+        else:
+            # Multi-line format with subfields
+            subfields, next_i = self._parse_subfields(lines, i)
+            effect.update({
+                'target': subfields.get('target', ''),
+                'desc': subfields.get('desc', ''),
+                'condition': subfields.get('condition'),
+                'reversible': subfields.get('reversible', '').lower() == 'yes'
+            })
+            return effect, next_i
+
+        return effect, i + 1
+
+    def _parse_state_trans_item(self, lines, i):
+        """Parse a single state transition specification"""
+        line = lines[i].strip()
+
+        trans = {
+            'target': line,
+            'from': '',
+            'to': '',
+            'condition': '',
+            'desc': ''
+        }
+
+        # Check for old format with commas
+        if ',' in line:
+            parts = line.split(',', 3)
+            if len(parts) >= 1:
+                trans['target'] = parts[0].strip()
+            if len(parts) >= 2:
+                trans['from'] = parts[1].strip()
+            if len(parts) >= 3:
+                trans['to'] = parts[2].strip()
+            if len(parts) >= 4:
+                desc_part = parts[3].strip()
+                desc_parts = desc_part.split(',', 1)
+                if len(desc_parts) > 1:
+                    trans['condition'] = desc_parts[0].strip()
+                    trans['desc'] = desc_parts[1].strip()
+                else:
+                    trans['desc'] = desc_part
+            return trans, i + 1
+        else:
+            # Multi-line format with subfields
+            subfields, next_i = self._parse_subfields(lines, i)
+            trans.update({
+                'from': subfields.get('from', ''),
+                'to': subfields.get('to', ''),
+                'condition': subfields.get('condition', ''),
+                'desc': subfields.get('desc', '')
+            })
+            return trans, next_i
+
+    def _process_parameters(self, sections, parameterlist, parameterdescs, parametertypes):
+        """Process and output parameter specifications"""
+        param_count = len(parameterlist)
+        if param_count > 0:
+            self.data += f"\n\tKAPI_PARAM_COUNT({param_count})\n"
+
+        for param_idx, param in enumerate(parameterlist):
+            param_name = param.strip()
+            param_desc = parameterdescs.get(param_name, '')
+            param_ctype = parametertypes.get(param_name, '')
+
+            # Parse parameter specifications
+            param_section = self._get_raw_section(sections, 'param')
+            param_specs = {}
+            if param_section:
+                param_specs = self._parse_param_spec(param_section, param_name)
+
+            self.data += f"\n\tKAPI_PARAM({param_idx}, {self._format_macro_param(param_name)}, "
+            self.data += f"{self._format_macro_param(param_ctype)}, {self._format_macro_param(param_desc)})\n"
+
+            # Add parameter attributes
+            for key, macro in [
+                ('param-type', 'KAPI_PARAM_TYPE'),
+                ('param-flags', 'KAPI_PARAM_FLAGS'),
+                ('param-size', 'KAPI_PARAM_SIZE'),
+                ('param-alignment', 'KAPI_PARAM_ALIGNMENT'),
+            ]:
+                if key in param_specs:
+                    self.data += f"\t\t{macro}({param_specs[key]})\n"
+
+            # Handle constraint type
+            if 'param-constraint-type' in param_specs:
+                ctype = param_specs['param-constraint-type']
+                if ctype == 'KAPI_CONSTRAINT_BITMASK':
+                    ctype = 'KAPI_CONSTRAINT_MASK'
+                self.data += f"\t\tKAPI_PARAM_CONSTRAINT_TYPE({ctype})\n"
+
+            # Handle range
+            if 'param-range' in param_specs and ',' in param_specs['param-range']:
+                min_val, max_val = param_specs['param-range'].split(',', 1)
+                self.data += f"\t\tKAPI_PARAM_RANGE({min_val.strip()}, {max_val.strip()})\n"
+
+            # Handle mask
+            if 'param-mask' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_VALID_MASK({param_specs['param-mask']})\n"
+
+            # Handle enum values
+            if 'param-enum-values' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_ENUM_VALUES({param_specs['param-enum-values']})\n"
+
+            # Handle size parameter index
+            if 'param-size-param' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_SIZE_PARAM({param_specs['param-size-param']})\n"
+
+            # Handle constraint description
+            if 'param-constraint' in param_specs:
+                self.data += f"\t\tKAPI_PARAM_CONSTRAINT({self._format_macro_param(param_specs['param-constraint'])})\n"
+
+            self.data += "\tKAPI_PARAM_END\n"
+
+    def _parse_param_spec(self, section_content, param_name):
+        """Parse parameter specifications from indented format"""
+        specs = {}
+        lines = section_content.strip().split('\n')
+        current_item = None
+
+        # Map to expected keys
+        field_map = {
+            'type': 'param-type',
+            'flags': 'param-flags',
+            'size': 'param-size',
+            'constraint-type': 'param-constraint-type',
+            'constraint': 'param-constraint',
+            'cdesc': 'param-constraint',
+            'range': 'param-range',
+            'mask': 'param-mask',
+            'valid-mask': 'param-mask',
+            'valid-values': 'param-enum-values',
+            'alignment': 'param-alignment',
+            'size-param': 'param-size-param',
+            'struct-type': 'param-struct-type',
+        }
+
+        i = 0
+        while i < len(lines):
+            line = lines[i]
+            if not line.strip():
+                i += 1
+                continue
+
+            # Check if this is our parameter (non-indented line)
+            if not line.startswith((' ', '\t')):
+                parts = line.strip().split(',', 1)
+                current_item = param_name if parts[0].strip() == param_name else None
+                if current_item and len(parts) > 1:
+                    specs['param-type'] = parts[1].strip()
+                i += 1
+            elif current_item == param_name:
+                # Parse subfield
+                stripped = line.strip()
+                if ':' in stripped:
+                    key, value = stripped.split(':', 1)
+                    key = key.strip()
+                    value = value.strip()
+
+                    # Collect continuation lines (indented lines without a colon that
+                    # defines a new key, i.e., lines that are pure continuations)
+                    i += 1
+                    while i < len(lines):
+                        next_line = lines[i]
+                        # Stop if we hit a non-indented line (new param)
+                        if next_line.strip() and not next_line.startswith((' ', '\t')):
+                            break
+                        next_stripped = next_line.strip()
+                        # Stop if we hit a new key (contains colon with known key prefix)
+                        if next_stripped and ':' in next_stripped:
+                            potential_key = next_stripped.split(':', 1)[0].strip()
+                            if potential_key in field_map or potential_key in ['type', 'desc']:
+                                break
+                        # This is a continuation line
+                        if next_stripped:
+                            value = value + ' ' + next_stripped
+                        i += 1
+
+                    if key in field_map:
+                        # Clean up the value - remove excessive whitespace
+                        value = ' '.join(value.split())
+                        specs[field_map[key]] = value
+            else:
+                i += 1
+
+        return specs
+
+    def _validate_effect_type(self, effect_type):
+        """Validate and normalize effect type"""
+        if 'KAPI_EFFECT_SCHEDULER' in effect_type:
+            return effect_type.replace('KAPI_EFFECT_SCHEDULER', 'KAPI_EFFECT_SCHEDULE')
+
+        if 'KAPI_EFFECT_' in effect_type and effect_type not in VALID_EFFECT_TYPES:
+            if '|' in effect_type:
+                parts = [p.strip() for p in effect_type.split('|')]
+                valid_parts = []
+                for p in parts:
+                    if p in VALID_EFFECT_TYPES:
+                        valid_parts.append(p)
+                    else:
+                        import sys
+                        print(f"warning: unrecognized effect type '{p}', "
+                              f"defaulting to KAPI_EFFECT_MODIFY_STATE", file=sys.stderr)
+                        valid_parts.append('KAPI_EFFECT_MODIFY_STATE')
+                return ' | '.join(valid_parts)
+            import sys
+            print(f"warning: unrecognized effect type '{effect_type}', "
+                  f"defaulting to KAPI_EFFECT_MODIFY_STATE", file=sys.stderr)
+            return 'KAPI_EFFECT_MODIFY_STATE'
+
+        return effect_type
+
+    def _has_api_spec(self, sections):
+        """Check if this function has an API specification.
+
+        Returns True if at least 2 KAPI-specific section indicators are present.
+        We require 2+ indicators (not just 1) to avoid false positives from
+        regular kernel-doc comments that happen to use a common section name
+        like 'return' or 'error'. Having multiple KAPI sections strongly
+        suggests intentional API specification rather than coincidence.
+        """
+        indicators = [
+            'api-type', 'context-flags', 'param-type', 'error-code',
+            'capability', 'signal', 'lock', 'state-trans', 'constraint',
+            'side-effect', 'long-desc'
+        ]
+
+        count = sum(1 for ind in indicators
+                   if any(key.lower().startswith(ind.lower()) or
+                         key.lower().startswith('@' + ind.lower())
+                         for key in sections.keys()))
+
+        # Require 2+ indicators to distinguish from regular kernel-doc
+        return count >= 2
+
+    def out_function(self, fname, name, args):
+        """Generate API spec for a function"""
+        function_name = args.get('function', name)
+        sections = args.sections if hasattr(args, 'sections') else args.get('sections', {})
+
+        if not self._has_api_spec(sections):
+            return
+
+        parameterlist = args.parameterlist if hasattr(args, 'parameterlist') else args.get('parameterlist', [])
+        parameterdescs = args.parameterdescs if hasattr(args, 'parameterdescs') else args.get('parameterdescs', {})
+        parametertypes = args.parametertypes if hasattr(args, 'parametertypes') else args.get('parametertypes', {})
+        purpose = args.get('purpose', '')
+
+        # Start macro invocation
+        self.data += f"DEFINE_KERNEL_API_SPEC({function_name})\n"
+
+        # Basic info
+        if purpose:
+            self.data += f"\tKAPI_DESCRIPTION({self._format_macro_param(purpose)})\n"
+
+        long_desc = self._get_multiline_section(sections, 'long-desc')
+        if long_desc:
+            self.data += f"\tKAPI_LONG_DESC({self._format_macro_param(long_desc, KAPI_MAX_LONG_DESC_LEN)})\n"
+
+        # Context flags
+        context = self._get_section(sections, 'context-flags') or self._get_section(sections, 'context')
+        if context:
+            self.data += f"\tKAPI_CONTEXT({context})\n"
+
+        # Process parameters
+        self._process_parameters(sections, parameterlist, parameterdescs, parametertypes)
+
+        # Process return value
+        self._process_return(sections)
+
+        # Process errors
+        errors = self._parse_indented_items(
+            self._get_raw_section(sections, 'error'),
+            self._parse_error_item
+        )
+
+        if errors:
+            self.data += f"\n\tKAPI_ERROR_COUNT({len(errors)})\n"
+
+            for idx, error in enumerate(errors):
+                self._output_error(idx, error)
+
+        # Process signals
+        signals = self._parse_indented_items(
+            self._get_raw_section(sections, 'signal'),
+            self._parse_signal_item
+        )
+
+        if signals:
+            self.data += f"\n\tKAPI_SIGNAL_COUNT({len(signals)})\n"
+
+            for idx, signal in enumerate(signals):
+                self._output_signal(idx, signal)
+
+        # Process other specifications
+        self._process_locks(sections)
+        self._process_constraints(sections)
+        self._process_side_effects(sections)
+        self._process_state_transitions(sections)
+        self._process_capabilities(sections)
+
+        # Add examples and notes (use multiline extraction for full content)
+        for key, macro, max_len in [
+            ('examples', 'KAPI_EXAMPLES', KAPI_MAX_EXAMPLES_LEN),
+            ('notes', 'KAPI_NOTES', KAPI_MAX_NOTES_LEN),
+        ]:
+            value = self._get_multiline_section(sections, key)
+            if value:
+                self.data += f"\n\t{macro}({self._format_macro_param(value, max_len)})\n"
+
+        self.data += "\nKAPI_END_SPEC;\n\n"
+
+    def _process_return(self, sections):
+        """Process the return value specification from kerneldoc annotations"""
+        raw = self._get_raw_section(sections, 'return')
+        if not raw:
+            return
+
+        # Parse subfields from the return section, handling continuation lines
+        lines = raw.strip().split('\n')
+        subfields = {}
+        current_key = None
+        for line in lines:
+            stripped = line.strip()
+            if ':' in stripped and not stripped.startswith(' '):
+                key, value = stripped.split(':', 1)
+                current_key = key.strip()
+                subfields[current_key] = value.strip()
+            elif current_key and stripped:
+                # Continuation line
+                subfields[current_key] += ' ' + stripped
+
+        ret_type = subfields.get('type', '')
+        check_type = subfields.get('check-type', '')
+        desc = subfields.get('desc', '')
+        success = subfields.get('success', '')
+
+        if not ret_type and not desc:
+            return
+
+        self.data += f"\n\tKAPI_RETURN({self._format_macro_param(ret_type)}, "
+        self.data += f"{self._format_macro_param(desc)})\n"
+
+        if ret_type:
+            self.data += f"\t\tKAPI_RETURN_TYPE({ret_type})\n"
+
+        if check_type:
+            self.data += f"\t\tKAPI_RETURN_CHECK_TYPE({check_type})\n"
+
+        if success and check_type == 'KAPI_RETURN_RANGE':
+            self.data += f"\t\tKAPI_RETURN_SUCCESS_RANGE(0, S64_MAX)\n"
+
+        self.data += "\tKAPI_RETURN_END\n"
+
+    def _output_error(self, idx, error):
+        """Output a single error specification"""
+        line = error['line']
+        if line.startswith('-'):
+            line = line[1:].strip()
+
+        parts = line.split(',', 2)
+        if len(parts) == 2:
+            # Format: NAME, description
+            name = parts[0].strip()
+            short_desc = parts[1].strip()
+            code = f"-{name}"
+        elif len(parts) >= 3:
+            # Format: code, name, description
+            code = parts[0].strip()
+            name = parts[1].strip()
+            short_desc = parts[2].strip()
+            if not code.startswith('-'):
+                code = f"-{code}"
+        else:
+            return
+
+        long_desc = error.get('desc', '') or short_desc
+
+        self.data += f"\n\tKAPI_ERROR({idx}, {code}, {self._format_macro_param(name)}, "
+        self.data += f"{self._format_macro_param(short_desc)},\n\t\t   {self._format_macro_param(long_desc)})\n"
+
+    def _output_signal(self, idx, signal):
+        """Output a single signal specification"""
+        self.data += f"\n\tKAPI_SIGNAL({idx}, {signal['number']}, "
+        self.data += f"{self._format_macro_param(signal['name'], KAPI_MAX_SIGNAL_NAME_LEN)}, "
+        self.data += f"{signal['direction']}, {signal['action']})\n"
+
+        for key, macro in [
+            ('condition', 'KAPI_SIGNAL_CONDITION'),
+            ('desc', 'KAPI_SIGNAL_DESC'),
+            ('error', 'KAPI_SIGNAL_ERROR'),
+            ('timing', 'KAPI_SIGNAL_TIMING'),
+            ('priority', 'KAPI_SIGNAL_PRIORITY'),
+        ]:
+            if signal.get(key):
+                # Priority field is numeric
+                if key == 'priority':
+                    self.data += f"\t\t{macro}({signal[key]})\n"
+                else:
+                    self.data += f"\t\t{macro}({self._format_macro_param(signal[key])})\n"
+
+        if signal.get('interruptible'):
+            self.data += "\t\tKAPI_SIGNAL_INTERRUPTIBLE\n"
+
+        self.data += "\tKAPI_SIGNAL_END\n"
+
+    def _process_locks(self, sections):
+        """Process lock specifications"""
+        locks = self._parse_indented_items(
+            self._get_raw_section(sections, 'lock'),
+            self._parse_lock_item
+        )
+
+        if locks:
+            self.data += f"\n\tKAPI_LOCK_COUNT({len(locks)})\n"
+
+            for idx, lock in enumerate(locks):
+                self.data += f"\n\tKAPI_LOCK({idx}, {self._format_macro_param(lock['name'])}, {lock['type']})\n"
+
+                for flag in ['acquired', 'released']:
+                    if lock.get(flag):
+                        self.data += f"\t\tKAPI_LOCK_{flag.upper()}\n"
+
+                if lock.get('desc'):
+                    self.data += f"\t\tKAPI_LOCK_DESC({self._format_macro_param(lock['desc'])})\n"
+
+                self.data += "\tKAPI_LOCK_END\n"
+
+    def _process_constraints(self, sections):
+        """Process constraint specifications"""
+        constraints = self._parse_indented_items(
+            self._get_raw_section(sections, 'constraint'),
+            self._parse_constraint_item
+        )
+
+        if constraints:
+            self.data += f"\n\tKAPI_CONSTRAINT_COUNT({len(constraints)})\n"
+
+            for idx, constraint in enumerate(constraints):
+                self.data += f"\n\tKAPI_CONSTRAINT({idx}, {self._format_macro_param(constraint['name'])},\n"
+                self.data += f"\t\t\t{self._format_macro_param(constraint['desc'])})\n"
+
+                if constraint.get('expr'):
+                    self.data += f"\t\tKAPI_CONSTRAINT_EXPR({self._format_macro_param(constraint['expr'])})\n"
+
+                self.data += "\tKAPI_CONSTRAINT_END\n"
+
+    def _process_side_effects(self, sections):
+        """Process side effect specifications"""
+        effects = self._parse_indented_items(
+            self._get_raw_section(sections, 'side-effect'),
+            self._parse_side_effect_item
+        )
+
+        if effects:
+            self.data += f"\n\tKAPI_SIDE_EFFECT_COUNT({len(effects)})\n"
+
+            for idx, effect in enumerate(effects):
+                effect_type = self._validate_effect_type(effect['type'])
+
+                self.data += f"\n\tKAPI_SIDE_EFFECT({idx}, {effect_type},\n"
+                self.data += f"\t\t\t {self._format_macro_param(effect['target'])},\n"
+                self.data += f"\t\t\t {self._format_macro_param(effect['desc'])})\n"
+
+                if effect.get('condition'):
+                    self.data += f"\t\tKAPI_EFFECT_CONDITION({self._format_macro_param(effect['condition'])})\n"
+
+                if effect.get('reversible'):
+                    self.data += "\t\tKAPI_EFFECT_REVERSIBLE\n"
+
+                self.data += "\tKAPI_SIDE_EFFECT_END\n"
+
+    def _process_state_transitions(self, sections):
+        """Process state transition specifications"""
+        transitions = self._parse_indented_items(
+            self._get_raw_section(sections, 'state-trans'),
+            self._parse_state_trans_item
+        )
+
+        if transitions:
+            self.data += f"\n\tKAPI_STATE_TRANS_COUNT({len(transitions)})\n"
+
+            for idx, trans in enumerate(transitions):
+                desc = trans['desc']
+                if trans.get('condition'):
+                    desc = trans['condition'] + (', ' + desc if desc else '')
+
+                self.data += f"\n\tKAPI_STATE_TRANS({idx}, {self._format_macro_param(trans['target'])}, "
+                self.data += f"{self._format_macro_param(trans['from'])}, {self._format_macro_param(trans['to'])},\n"
+                self.data += f"\t\t\t {self._format_macro_param(desc)})\n"
+                self.data += "\tKAPI_STATE_TRANS_END\n"
+
+    def _process_capabilities(self, sections):
+        """Process capability specifications"""
+        cap_section = self._get_raw_section(sections, 'capability')
+        if not cap_section:
+            return
+
+        lines = cap_section.strip().split('\n')
+        capabilities = []
+        i = 0
+
+        while i < len(lines):
+            line = lines[i].strip()
+            # Skip empty lines and subfield lines (they'll be parsed with their parent)
+            if not line or line.startswith(('allows:', 'without:', 'condition:', 'priority:', 'type:', 'desc:')):
+                i += 1
+                continue
+
+            cap_info = {'line': line}
+
+            # Parse subfields
+            subfields, next_i = self._parse_subfields(lines, i)
+            cap_info.update(subfields)
+            capabilities.append(cap_info)
+            i = next_i
+
+        if capabilities:
+            # Filter out "none" capabilities (no capability required)
+            valid_caps = [cap for cap in capabilities if cap['line'].strip().lower() != 'none']
+
+            if not valid_caps:
+                return
+
+            self.data += f"\n\tKAPI_CAPABILITY_COUNT({len(valid_caps)})\n"
+
+            for idx, cap in enumerate(valid_caps):
+                line = cap['line']
+                parts = line.split(',', 2)
+
+                # Handle both formats:
+                # 1. New format: "CAP_NAME" with type/desc as subfields
+                # 2. Old format: "CAP_NAME, TYPE, description"
+                if len(parts) >= 2:
+                    # Old comma-separated format
+                    cap_name = parts[0].strip()
+                    cap_type = parts[1].strip()
+                    cap_desc = parts[2].strip() if len(parts) > 2 else cap.get('desc', cap_name)
+                else:
+                    # New subfield format - capability name on main line
+                    cap_name = line.strip()
+                    cap_type = cap.get('type', 'KAPI_CAP_PERFORM_OPERATION')
+                    cap_desc = cap.get('desc', cap_name)
+
+                # Map capability type to valid kernel enum values
+                cap_type_map = {
+                    'KAPI_CAP_REQUIRED': 'KAPI_CAP_PERFORM_OPERATION',
+                    'required': 'KAPI_CAP_PERFORM_OPERATION',
+                    'bypass': 'KAPI_CAP_BYPASS_CHECK',
+                    'grant': 'KAPI_CAP_GRANT_PERMISSION',
+                    'override': 'KAPI_CAP_OVERRIDE_RESTRICTION',
+                    'access': 'KAPI_CAP_ACCESS_RESOURCE',
+                    'modify': 'KAPI_CAP_MODIFY_BEHAVIOR',
+                    'limit': 'KAPI_CAP_INCREASE_LIMIT',
+                }
+                cap_type = cap_type_map.get(cap_type, cap_type)
+
+                # Fix common type issues
+                if 'BYPASS' in cap_type and cap_type != 'KAPI_CAP_BYPASS_CHECK':
+                    cap_type = 'KAPI_CAP_BYPASS_CHECK'
+
+                # Ensure cap_type is a valid enum
+                valid_types = [
+                    'KAPI_CAP_BYPASS_CHECK', 'KAPI_CAP_INCREASE_LIMIT',
+                    'KAPI_CAP_OVERRIDE_RESTRICTION', 'KAPI_CAP_GRANT_PERMISSION',
+                    'KAPI_CAP_MODIFY_BEHAVIOR', 'KAPI_CAP_ACCESS_RESOURCE',
+                    'KAPI_CAP_PERFORM_OPERATION'
+                ]
+                if cap_type not in valid_types:
+                    cap_type = 'KAPI_CAP_PERFORM_OPERATION'
+
+                self.data += f"\n\tKAPI_CAPABILITY({idx}, {cap_name}, {self._format_macro_param(cap_desc)}, {cap_type})\n"
+
+                for key, macro in [
+                    ('allows', 'KAPI_CAP_ALLOWS'),
+                    ('without', 'KAPI_CAP_WITHOUT'),
+                    ('condition', 'KAPI_CAP_CONDITION'),
+                    ('priority', 'KAPI_CAP_PRIORITY'),
+                ]:
+                    if cap.get(key):
+                        value = self._format_macro_param(cap[key]) if key != 'priority' else cap[key]
+                        self.data += f"\t\t{macro}({value})\n"
+
+                self.data += "\tKAPI_CAPABILITY_END\n"
+
+    # Skip output methods for non-function types
+    def out_enum(self, fname, name, args): pass
+    def out_typedef(self, fname, name, args): pass
+    def out_struct(self, fname, name, args): pass
+    def out_doc(self, fname, name, args): pass
diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index 4210b91dde5f1..cd91a4f59f275 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -129,8 +129,13 @@ class OutputFormat:
         Output warnings for identifiers that will be displayed.
         """
 
-        for log_msg in args.warnings:
-            self.config.warning(log_msg)
+        warnings = getattr(args, 'warnings', [])
+
+        for log_msg in warnings:
+            # Skip numeric warnings (line numbers) which are false positives
+            # from parameter-specific sections like "param-constraint: name, value"
+            if not isinstance(log_msg, int):
+                self.config.warning(log_msg)
 
     def check_doc(self, name, args):
         """Check if DOC should be output."""
diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index ca00695b47b31..9468f91c07597 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -28,6 +28,23 @@ from kdoc.kdoc_item import KdocItem
 # Allow whitespace at end of comment start.
 doc_start = KernRe(r'^/\*\*\s*$', cache=False)
 
+# Sections that are allowed to be duplicated for API specifications
+# These represent lists of items (multiple errors, signals, etc.)
+ALLOWED_DUPLICATE_SECTIONS = {
+    'param', '@param',
+    'error', '@error',
+    'signal', '@signal',
+    'lock', '@lock',
+    'side-effect', '@side-effect',
+    'state-trans', '@state-trans',
+    'capability', '@capability',
+    'constraint', '@constraint',
+    'validation-group', '@validation-group',
+    'validation-rule', '@validation-rule',
+    'validation-flag', '@validation-flag',
+    'struct-field', '@struct-field',
+}
+
 doc_end = KernRe(r'\*/', cache=False)
 doc_com = KernRe(r'\s*\*\s*', cache=False)
 doc_com_body = KernRe(r'\s*\* ?', cache=False)
@@ -40,10 +57,71 @@ doc_decl = doc_com + KernRe(r'(\w+)', cache=False)
 #         @{section-name}:
 # while trying to not match literal block starts like "example::"
 #
+# Base kernel-doc section names
 known_section_names = 'description|context|returns?|notes?|examples?'
-known_sections = KernRe(known_section_names, flags = re.I)
+
+# API specification section names (for KAPI spec framework)
+# Format: (base_name, has_count_variant, has_other_variants)
+# Sections with has_count_variant=True need negative lookahead in doc_sect
+# to avoid matching 'error' when 'error-count' is intended
+_kapi_base_sections = [
+    # (name, needs_lookahead, additional_variants)
+    ('api-type', False, []),
+    ('api-version', False, []),
+    ('param', True, []),  # has param-count
+    ('struct', True, ['struct-type', 'struct-field', 'struct-field-[a-z\\-]+']),
+    ('validation-group', False, []),
+    ('validation-policy', False, []),
+    ('validation-flag', False, []),
+    ('validation-rule', False, []),
+    ('error', True, ['error-code', 'error-condition']),
+    ('capability', True, []),
+    ('signal', True, []),
+    ('lock', True, []),
+    ('since', False, ['since-version']),
+    ('context-flags', False, []),
+    ('return', True, ['return-type', 'return-check', 'return-check-type',
+                      'return-success', 'return-desc']),
+    ('long-desc', False, []),
+    ('constraint', True, []),
+    ('side-effect', True, []),
+    ('state-trans', True, []),
+]
+
+def _build_kapi_patterns():
+    """Build KAPI section patterns from the base definitions."""
+    validation_parts = []  # For known_sections (simple validation)
+    parsing_parts = []     # For doc_sect (with negative lookaheads)
+
+    for name, has_count, variants in _kapi_base_sections:
+        # Add base name (with optional @ prefix)
+        validation_parts.append(f'@?{name}')
+        if has_count:
+            # Need negative lookahead to not match 'name-count' or 'name-*'
+            parsing_parts.append(f'@?{name}(?!-)')
+            validation_parts.append(f'@?{name}-count')
+            parsing_parts.append(f'@?{name}-count')
+        else:
+            parsing_parts.append(f'@?{name}')
+
+        # Add variants
+        for variant in variants:
+            validation_parts.append(f'@?{variant}')
+            parsing_parts.append(f'@?{variant}')
+
+    # Add catch-all for kapi-* extensions
+    validation_parts.append(r'@?kapi-.*')
+    parsing_parts.append(r'@?kapi-.*')
+
+    return '|'.join(validation_parts), '|'.join(parsing_parts)
+
+_kapi_validation_pattern, _kapi_parsing_pattern = _build_kapi_patterns()
+
+known_sections = KernRe(known_section_names + '|' + _kapi_validation_pattern,
+                        flags=re.I)
 doc_sect = doc_com + \
-    KernRe(r'\s*(@[.\w]+|@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
+    KernRe(r'\s*(@[.\w\-]+|@\.\.\.|' + known_section_names + '|' +
+           _kapi_parsing_pattern + r')\s*:([^:].*)?$',
            flags=re.I, cache=False)
 
 doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
@@ -349,7 +427,9 @@ class KernelEntry:
         else:
             if name in self.sections and self.sections[name] != "":
                 # Only warn on user-specified duplicate section names
-                if name != SECTION_DEFAULT:
+                # Skip warning for sections that are expected to have duplicates
+                # (like error, param, signal, etc. for API specifications)
+                if name != SECTION_DEFAULT and name not in ALLOWED_DUPLICATE_SECTIONS:
                     self.emit_msg(self.new_start_line,
                                   f"duplicate section name '{name}'")
                 # Treat as a new paragraph - add a blank line
-- 
2.51.0


