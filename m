Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2253B2C2560
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgKXMIf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 07:08:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387464AbgKXMIf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 07:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606219713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SR++nLqglvDf5ksxZvlzJRe0kfASzgJc07BCkIJGy4A=;
        b=Wtctg2x1ExY9iXfKzR9axR6qBOU1MX9WAUld0N1FfUtA6KOm9t2pH4nTcCZVO3pcXjJfGv
        ek6hP8g3RNL8ntiQ29PLEvf0oBXAcnogybXyahsQGj0oL/ZndsBKaR9RqE6xAH/PmREUAp
        ImpL31K26L3otmcXCfxeFWbG45bTArQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12--yVSxKi1PUCpoadMI73t6A-1; Tue, 24 Nov 2020 07:08:30 -0500
X-MC-Unique: -yVSxKi1PUCpoadMI73t6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F14A18C43C8;
        Tue, 24 Nov 2020 12:08:29 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-141.ams2.redhat.com [10.36.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C85DE5D9CD;
        Tue, 24 Nov 2020 12:08:22 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
Date:   Tue, 24 Nov 2020 13:08:20 +0100
Message-ID: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This documents a way to safely use new security-related system calls
while preserving compatibility with container runtimes that require
insecure emulation (because they filter the system call by default).
Admittedly, it is somewhat hackish, but it can be implemented by
userspace today, for existing system calls such as faccessat2,
without kernel or container runtime changes.

Signed-off-by: Florian Weimer <fweimer@redhat.com>

---
 Documentation/process/adding-syscalls.rst | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index a3ecb236576c..7d1e578a1df1 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -436,6 +436,40 @@ simulates registers etc).  Fixing this is as simple as adding a #define to
 
     #define stub_xyzzy sys_xyzzy
 
+Container Compatibility and seccomp
+-----------------------------------
+
+The Linux Foundation Open Container Initiative Runtime Specification
+requires that by default, implementations install seccomp system call
+filters which cause system calls to fail with ``EPERM``.  As a result,
+all new system calls in such containers fail with ``EPERM`` instead of
+``ENOSYS``.  This design is problematic because ``EPERM`` is a
+legitimate system call result which should not trigger fallback to a
+userspace emulation, particularly for security-related system calls.
+(With ``ENOSYS``, it is clear that a fallback implementation has to be
+used to maintain compatibility with older kernels or container
+runtimes.)
+
+New system calls should therefore provide a way to reliably trigger an
+error distinct from ``EPERM``, without any side effects.  Some ways to
+achieve that are:
+
+ - ``EBADFD`` for the invalid file descriptor -1
+ - ``EFAULT`` for a null pointer
+ - ``EINVAL`` for a contradictory set of flags that will remain invalid
+   in the future
+
+If a system call has such error behavior, upon encountering an
+``EPERM`` error, userspace applications can perform further
+invocations of the same system call to check if the ``EPERM`` error
+persists for those known error conditions.  If those also fail with
+``EPERM``, that likely means that the original ``EPERM`` error was the
+result of a seccomp filter, and should be treated like ``ENOSYS``
+(e.g., trigger an alternative fallback implementation).  If those
+probing system calls do not fail with ``EPERM``, the error likely came
+from a real implementation, and should be reported to the caller
+directly, without resorting to ``ENOSYS``-style fallback.
+
 
 Other Details
 -------------
@@ -575,3 +609,6 @@ References and Sources
  - Recommendation from Linus Torvalds that x32 system calls should prefer
    compatibility with 64-bit versions rather than 32-bit versions:
    https://lkml.org/lkml/2011/8/31/244
+ - Linux Configuration section of the Open Container Initiative
+   Runtime Specification:
+   https://github.com/opencontainers/runtime-spec/blob/master/config-linux.md

-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

