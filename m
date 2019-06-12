Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793CF42FFB
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfFLT1V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:27:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40738 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbfFLT1I (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:27:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so18145282wre.7
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gc99P+6N6+xSxQKHKwT0OD+Dx6Ni+QOkx9u56EzlVmA=;
        b=F2bLr6Usjp0SS+YH0qbHW4ub7lF+EA48coYkSUubqCXi4L86a8pbijVIRgDvpuSUsF
         ZrK1Shovt+bDl648RmoiYd0gtNwx38PveHrl2akp0/4gVW6L1gdnFMajsh3iPjGadno4
         0w+RVcfN1Az3gqf8b2lwzW/qAfl1AeEaqkzUE8yrXIb0ZD+g6RdrTckRWUM0PhWrh2oF
         jusm5g5Vb6YDoIbI3gf+RwyYIJ0n0S8J7fniaqQsd3uOABGpnTgA2gFyawsrYMQJbKbD
         hsRJOs43wENKcjTM9+yzTYzgj4XFg6jPN7rkBT7t0taep/aGmnhvlMKjsoLzm5ssPtn7
         fTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gc99P+6N6+xSxQKHKwT0OD+Dx6Ni+QOkx9u56EzlVmA=;
        b=SFnMZGxTeUYVOCwDTkbEartc/2rxTvd5sTsh/6GEYKgbP6DebWplU3Cvc5jgf2cqyM
         9sTGkA37cRVHCR52S+A+EqA5wH75QTgkRK0xKWPIpp9OhSbifVFthcdfDOVXyUpb1E2x
         If99zTfpohOY1ftM6eXg3yI4KhvKzI+P6Jo8Z7H7JsrS7OqlMW0LCS3FAN++4Ugc5/VB
         jxHeYZmeg29LlyVoaTi+XQFXQUj5ChvF4IBbnW1lmb6YOMlz6fd+HtqCqV/yJ7cFr2Wh
         LcunWQ6FOscSz8yoqlHrtm6CODrBb67LJcsi2bPDUWuv0cw3qW/DIADfuHOmFKuNQ2Zy
         H85g==
X-Gm-Message-State: APjAAAVo8f62cE3KzSK9ZBZ41vwBddH8HqII9LFrCp/niifr9dNnjLH1
        mdER/vuRfclz+R1cwszkXU0KPQ==
X-Google-Smtp-Source: APXvYqxIsPY4F76dTJDcOjFZdmSdKlq0GPIonqcAmCK2zG2wSLgAsYvCqwuGTkiuPGkT6q30d63hgw==
X-Received: by 2002:adf:ee42:: with SMTP id w2mr42257126wro.253.1560367627677;
        Wed, 12 Jun 2019 12:27:07 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.27.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:27:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: [PATCHv4 26/28] x86/vdso: Align VDSO functions by CPU L1 cache line
Date:   Wed, 12 Jun 2019 20:26:25 +0100
Message-Id: <20190612192628.23797-27-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

After performance testing VDSO patches a noticeable 20% regression was
found on gettime_perf selftest with a cold cache.
As it turns to be, before time namespaces introduction, VDSO functions
were quite aligned to cache lines, but adding a new code to adjust
timens offset inside namespace created a small shift and vdso functions
become unaligned on cache lines.

Add align to vdso functions with gcc option to fix performance drop.

Coping the resulting numbers from cover letter:

Hot CPU cache (more gettime_perf.c cycles - the better):
        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
cycles  | 139887013  | 139453003        | 139899785   | 128792458
diff (%)| 100        | 99.7             | 100         | 92

Cold cache (lesser tsc per gettime_perf_cold.c cycle - the better):
        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
tsc     | 6748       | 6718             | 6862        | 12682
diff (%)| 100        | 99.6             | 101.7       | 188

Measured on Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b58d34120fd8..c7bfd62d1fc3 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -4,6 +4,7 @@
 #
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_X86_L1_CACHE_SHIFT)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.22.0

