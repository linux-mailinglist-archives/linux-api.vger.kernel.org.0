Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7842FE9
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfFLT0t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40700 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfFLT0t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so18144387wre.7
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+1CEghJOdVJx1KMtcZOum2NpwBrMVg9LcIl76Brzvw=;
        b=RgStwM3FGRzdCf/mvhCnGOfULHZaHdkSvdHk8+3Xx6rlwxOeWt435wlZmHaBZcxFFu
         /iJ9oCEtHmKdX8ESzD0XTQqWKxSqyUXQ38w6lBJ/jydrGwY/lRYRu5zqhLT2/d+3W3M6
         Vnx0NUXPrWToOJjBu8VzWThQJlAuVgdQ3JuJ0ozDex/JanLidDUGTKTOjsYVds/jtfzg
         jZ4/zavy+bLPjV0e8CP+7AEhV5xV8lb4BLMnGBrJ40+cR0IuLWWT39gDbyzzdRNsb7j3
         hV5ydO1aexpglVmABTYbvBrvjrxSKeGYlOrQ0QFuZHgapByRAG16woCuuSPzSn/dDRtx
         rDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+1CEghJOdVJx1KMtcZOum2NpwBrMVg9LcIl76Brzvw=;
        b=DvI8fGITnktH91JSwQDdDm2YOykOqu8ZsWVMJxk275gvCmrIx3siQeWARI2z5MCwIp
         o6mOzikBuyrPA04EI9KcpNbhqJTEfND0P73Fixwa0OHDYensQox1SoW2aRn62aDZ0eFX
         n4d1XZo/g5nW0lOG2uZZxVqSBfpxcqKI+JiHp49V9tqrdFm5ezvo8wAw4djuPafFCyPh
         Wyls3gpYnLi7QYWFVP6k8f/IcjuZGPE8L32zJ7D1m1bh7qwlqh2cN8SR5kVACEmALXTd
         4Nm85HYMdPkBcJNSrcfTZ2BDCcic0RoZN62d/DzPKd/TJINMDks/CHmQ/o1LOgdaykDm
         3J4A==
X-Gm-Message-State: APjAAAWb+TzmgOyB8Bdnrg3FQpcN0E/VkWIWNsXxmsSDmwYYDSbW5wWA
        cpNQnTNIzvYY4DSiq5MKTDcX6A==
X-Google-Smtp-Source: APXvYqyPCNTB3qTUAqBTjh9VVAB8FdQppAuSzmkv5N47Ou/7X5w3THQsrWPOBSVxYOZuD1ZpzGO0XQ==
X-Received: by 2002:adf:f50c:: with SMTP id q12mr28231447wro.300.1560367607176;
        Wed, 12 Jun 2019 12:26:47 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:46 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 12/28] x86/vdso/Makefile: Add vobjs32
Date:   Wed, 12 Jun 2019 20:26:11 +0100
Message-Id: <20190612192628.23797-13-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 42fe42e82baf..b58d34120fd8 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -18,6 +18,8 @@ VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
+vobjs32-y += vdso32/vclock_gettime.o
 
 # files to link into kernel
 obj-y				+= vma.o
@@ -31,10 +33,12 @@ vdso_img-$(VDSO32-y)		+= 32
 obj-$(VDSO32-y)			+= vdso32-setup.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.lds $(vobjs-y)
+targets += vdso32/vdso32.lds $(vobjs32-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
@@ -125,10 +129,6 @@ $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
-targets += vdso32/vdso32.lds
-targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-targets += vdso32/vclock_gettime.o
-
 KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
 $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 $(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) += -m32
@@ -153,12 +153,7 @@ endif
 
 $(obj)/vdso32.so.dbg: KBUILD_CFLAGS = $(KBUILD_CFLAGS_32)
 
-$(obj)/vdso32.so.dbg: FORCE \
-		      $(obj)/vdso32/vdso32.lds \
-		      $(obj)/vdso32/vclock_gettime.o \
-		      $(obj)/vdso32/note.o \
-		      $(obj)/vdso32/system_call.o \
-		      $(obj)/vdso32/sigreturn.o
+$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 	$(call if_changed,vdso)
 
 #
-- 
2.22.0

