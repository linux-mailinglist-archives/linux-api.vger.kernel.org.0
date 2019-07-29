Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C378079C0F
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfG2WBR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:01:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34682 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbfG2V6a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so63498841wrm.1
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hqwZO1zYMZbMHDNBtpMYOg7fTFxraqQn2eOANEclVY=;
        b=m3yFpZ8poaRzOa/MxADE5K5sL/TnKgMt4BEe+aPbbp8xHRDgN5aLl6Miohq5KIwQMB
         G+7Rad8bup04SNcaHQuvFDtcpH+h+RKHJ6cdoaLpI6iqv2yE8YU5RMb1T28NEc7vupeR
         x/o+VMnd7pXmwe5LR/+Ux0XFjw3nxAQzGttiZhO3t4A2nzeSHT2hNqngOTEIGwsXogNV
         99T52Ddl/ix0LFWVXSQT7hAXKfeoTmbWC7RXXAOnYJzEwH2ru0spwMiyxpNxYmU+ucR5
         q373gy7peX1g4cMgt/NDPrh/QhOJZBa5WXbOwvjHFkw0k7XEeqgNn2NJIr3F2qmFzFrV
         o7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hqwZO1zYMZbMHDNBtpMYOg7fTFxraqQn2eOANEclVY=;
        b=ucPi+Xz+cxokXoKE9iO7zZwnjzRLxIcqdaWt7bvWwmEBgd2nGfcJL5hp0hIDc4eeAG
         zJvNQUsdeUHpHAQfYv6XAxFjpjPi4SEvSfxXu3MKXY2+LBCkMP6pjOAN3oqZsbGmk36z
         e3pi9FtVRpI8OFGGZ226RRUrYIEz8R2XEgW0o3+vTovo3MVBXu/JJuWMYQaVH+naViN+
         +4BzkekxsmxbSSztp+/CqukJLdU40ydvBgFgXqPFZR6SWldm6/v9FWnUe87GqX36zFce
         /EG04APaCP/pHF8nviXv7ikyi99XJ4vczgBwSaLVprQT5XD5vLrx1yY5PWbjMkoTeW/z
         xMVQ==
X-Gm-Message-State: APjAAAU1SJQc9t6o2urQZYPtsLOPzZsUv0fs0sAAb06fJ40/NOM/tPEE
        C2YwP06G3/MkA4YplQ5Pwv2kSgq33ROx9uyK9Dr1ekb+GXuQqDJarTGZ1O1DdWsuXf9kzCSJAor
        Yw1/F3KuSl1DJgGmkJyxo/vEU0bOO+VeM5UY2sLXSRMdgP+VQFn3O7+BIqbdK17k4oKS0q0OTOz
        PYTrUV6Z8ZrTTivhA+/irKPPzaaQ==
X-Google-Smtp-Source: APXvYqxe140732//L/bynIz7NqQJ73mBM6Qqjk+350TEqAjF0B3mriLWFXVhnez+lkDIkgz5G7FeGA==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr50896110wrk.229.1564437507897;
        Mon, 29 Jul 2019 14:58:27 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:27 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 20/37] x86/vdso/Makefile: Add vobjs32
Date:   Mon, 29 Jul 2019 22:57:02 +0100
Message-Id: <20190729215758.28405-21-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Treat ia32/i386 objects in array the same As for 64-bit vdso objects.
This is a preparation ground to avoid code duplication on introduction
timens vdso.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 8df549138193..d4bffc4cabd1 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -24,6 +24,8 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
+vobjs32-y += vdso32/vclock_gettime.o
 
 # files to link into kernel
 obj-y				+= vma.o
@@ -37,10 +39,12 @@ vdso_img-$(VDSO32-y)		+= 32
 obj-$(VDSO32-y)			+= vdso32-setup.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.lds $(vobjs-y)
+targets += vdso32/vdso32.lds $(vobjs32-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -131,10 +135,6 @@ $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
-targets += vdso32/vdso32.lds
-targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-targets += vdso32/vclock_gettime.o
-
 KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
 $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 $(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) += -m32
@@ -159,12 +159,7 @@ endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
-$(obj)/vdso32.so.dbg: FORCE \
-		      $(obj)/vdso32/vdso32.lds \
-		      $(obj)/vdso32/vclock_gettime.o \
-		      $(obj)/vdso32/note.o \
-		      $(obj)/vdso32/system_call.o \
-		      $(obj)/vdso32/sigreturn.o
+$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso_and_check)
 
 #
-- 
2.22.0

