Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68083280E7
	for <lists+linux-api@lfdr.de>; Mon,  1 Mar 2021 15:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhCAObW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Mar 2021 09:31:22 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:56123 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbhCAObS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Mar 2021 09:31:18 -0500
X-Greylist: delayed 754 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Mar 2021 09:31:14 EST
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 121ET4aL009547;
        Mon, 1 Mar 2021 23:29:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 121ET4aL009547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614608945;
        bh=56y6q7JbwT+YjWbSDS/+lUJzjy4Z/yzQHSNKlUgAILk=;
        h=From:To:Cc:Subject:Date:From;
        b=Vdbgmp06WlqfbpbcfsJ12iB3jy++RMvt+VjaWs4bId7wqyjmlRXiDonJvALBEo5iU
         rJV6iyZk1oy1XUZi4rDUX7+VXVPKejzlMUXl2O+fKZWkmorQlrzdo1Fr+o/YkeIoXr
         Md/drKcYRM1HT2HATpgA6LqRJhqV81btQATsYelftXlNajy38ck2G+oP++Hbs00c3r
         zBs7SKeGJmC51gmsBXcf9AMYA323JWMIcMWgizraxCLWx0kkxMz5VfYhtQxHF0yOfN
         SyaG4EZZrsZE/O9j5NQw2YE/sWsQYQNAxk5KdTbEv8DkN725ztObj+lPndHO8z8CS7
         jZEveIyW7rTNw==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: syscalls: switch to generic syscallhdr.sh
Date:   Mon,  1 Mar 2021 23:29:03 +0900
Message-Id: <20210301142903.345278-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Many architectures duplicate similar shell scripts.

This commit converts ARM to use scripts/syscallhdr.sh, and also
collects OABI/OEBI syscalls into unistd-eabi.h/unistd-oabi.h,
removing unistd-common.h.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.12-rc1

 arch/arm/include/uapi/asm/Kbuild   |  1 -
 arch/arm/include/uapi/asm/unistd.h |  1 -
 arch/arm/tools/Makefile            | 17 +++++-----------
 arch/arm/tools/syscallhdr.sh       | 31 ------------------------------
 4 files changed, 5 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm/tools/syscallhdr.sh

diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index ce8573157774..63748af8bc9d 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-generated-y += unistd-common.h
 generated-y += unistd-oabi.h
 generated-y += unistd-eabi.h
 generic-y += kvm_para.h
diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index 93ecf8aa4fe5..ae7749e15726 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -24,7 +24,6 @@
 #include <asm/unistd-oabi.h>
 #endif
 
-#include <asm/unistd-common.h>
 #define __NR_sync_file_range2		__NR_arm_sync_file_range
 
 /*
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index d8be90f2bb41..87de1f63f649 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -8,7 +8,7 @@
 gen := arch/$(ARCH)/include/generated
 kapi := $(gen)/asm
 uapi := $(gen)/uapi/asm
-syshdr := $(srctree)/$(src)/syscallhdr.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
 sysnr := $(srctree)/$(src)/syscallnr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 syscall := $(src)/syscall.tbl
@@ -17,7 +17,6 @@ gen-y := $(gen)/calls-oabi.S
 gen-y += $(gen)/calls-eabi.S
 kapi-hdrs-y := $(kapi)/unistd-nr.h
 kapi-hdrs-y += $(kapi)/mach-types.h
-uapi-hdrs-y := $(uapi)/unistd-common.h
 uapi-hdrs-y += $(uapi)/unistd-oabi.h
 uapi-hdrs-y += $(uapi)/unistd-eabi.h
 
@@ -41,10 +40,8 @@ $(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
 	$(call if_changed,gen_mach)
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@' \
-		   '$(syshdr_abi_$(basetarget))' \
-		   '$(syshdr_pfx_$(basetarget))' \
-		   '__NR_SYSCALL_BASE'
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis $(abis) \
+		   --offset __NR_SYSCALL_BASE $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis) $< $@
@@ -53,15 +50,11 @@ quiet_cmd_sysnr  = SYSNR   $@
       cmd_sysnr  = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@' \
 		   '$(syshdr_abi_$(basetarget))'
 
-syshdr_abi_unistd-common := common
-$(uapi)/unistd-common.h: $(syscall) $(syshdr) FORCE
-	$(call if_changed,syshdr)
-
-syshdr_abi_unistd-oabi := oabi
+$(uapi)/unistd-oabi.h: abis := common,oabi
 $(uapi)/unistd-oabi.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-syshdr_abi_unistd-eabi := eabi
+$(uapi)/unistd-eabi.h: abis := common,eabi
 $(uapi)/unistd-eabi.h: $(syscall) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
diff --git a/arch/arm/tools/syscallhdr.sh b/arch/arm/tools/syscallhdr.sh
deleted file mode 100644
index 6b2f25cdd721..000000000000
--- a/arch/arm/tools/syscallhdr.sh
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_ASM_ARM_`basename "$out" | sed \
-    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-if echo $out | grep -q uapi; then
-    fileguard="_UAPI$fileguard"
-fi
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-    echo "#ifndef ${fileguard}"
-    echo "#define ${fileguard} 1"
-    echo ""
-
-    while read nr abi name entry ; do
-	if [ -z "$offset" ]; then
-	    echo "#define __NR_${prefix}${name} $nr"
-	else
-	    echo "#define __NR_${prefix}${name} ($offset + $nr)"
-        fi
-    done
-
-    echo ""
-    echo "#endif /* ${fileguard} */"
-) > "$out"
-- 
2.27.0

