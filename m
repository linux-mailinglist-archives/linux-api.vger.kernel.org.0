Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7569EF861F
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKLB2I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:28:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38050 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKLB2H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:28:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so1200372wmk.3
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLHfRBzVcQOMHPLFQbTm4vIzETfB2gC5g5OyUjlWFMs=;
        b=Zm4taa0fqd0V2OIXZGfR00pMrgYgTXiiHgFzMlmIqbxN/huuDCz3U9KuaY8ynXa1x8
         9ujrlsvAXomfGjZbrrYmE7DI4vF+74DBTmDTE1+zZ6O04UzJbB2AfeuK1mUOwuzlTr6w
         KpoYPGWTuyJBXCvuZp9BBKHiNoOUlGUHb4s0UEnymt0kZwkQc6KnsgcSCKvpVpsKAAC+
         9OQ3eG6TU1XnwLXNjt2JWj6nz5JkSHcF5HgUXS9jUI0T6Lu3QrCAT/dXYvn1GhnFUzeE
         CtLZDwDVcoEsMH/JM2s0fULANXi/V8GU+Te39xmjxdgpXPYBStujgoNdPs5NQXQwMvSF
         LM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLHfRBzVcQOMHPLFQbTm4vIzETfB2gC5g5OyUjlWFMs=;
        b=sf+Dc0PEt5l2uNxefMnNm16wN7unnbhrhZbh7cNdlvVrIEowzw/MWinQFwMYQBr/4h
         HKbgB64exFH13sUT3MN357v8KNq+jfnO6NWNWmLA8jXgGDYZLhCEpbVxCxriqFdyr2mP
         0hYTETgv2vMiOAGsqWqoJ4HvYbsFNE1tI6khHfRcbge90r6Svxg8dLSK3N9ZBjtJQ+/O
         CKw8xhR1GG0rYKYeuoSdL9bPyp24/iLaw7FCbTg+1ynJoptJTXZWFPGRGzHGo+B/qSdb
         ZpRlIIHbmSqPjALjbsns7kJSUPgwr2r6IH/YBWfeBj53fCSnz4r40OekqbSx+SZQdmzA
         hTyA==
X-Gm-Message-State: APjAAAU9oLdS9urnGQs6OgAhF+V8ppV0xeHhPPqdT40AYNOWHi7uUlhv
        2ZDBkVxz1Pq9pIzRKIRMHDAInw==
X-Google-Smtp-Source: APXvYqxrCn/GtTlwgZN4e+FAimd9glCR7wgRozyGrmAowLDgpRZPtbaoRrxR2LuUHfILHaOMe+gELQ==
X-Received: by 2002:a1c:2745:: with SMTP id n66mr1499686wmn.171.1573522085381;
        Mon, 11 Nov 2019 17:28:05 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:28:04 -0800 (PST)
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv8 25/34] x86/vdso: On timens page fault prefault also VVAR page
Date:   Tue, 12 Nov 2019 01:27:14 +0000
Message-Id: <20191112012724.250792-26-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As timens page has offsets to data on VVAR page VVAR is going
to be accessed shortly. Set it up with timens in one page fault
as optimization.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f6e13ab29d94..d6cb8a16f368 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -169,8 +169,23 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		 * offset.
 		 * See also the comment near timens_setup_vdso_data().
 		 */
-		if (timens_page)
+		if (timens_page) {
+			unsigned long addr;
+			vm_fault_t err;
+
+			/*
+			 * Optimization: inside time namespace pre-fault
+			 * VVAR page too. As on timens page there are only
+			 * offsets for clocks on VVAR, it'll be faulted
+			 * shortly by VDSO code.
+			 */
+			addr = vmf->address + (image->sym_timens_page - sym_offset);
+			err = vmf_insert_pfn(vma, addr, pfn);
+			if (unlikely(err & VM_FAULT_ERROR))
+				return err;
+
 			pfn = page_to_pfn(timens_page);
+		}
 
 		return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset == image->sym_pvclock_page) {
-- 
2.24.0

