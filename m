Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D26F8614
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLB1f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:27:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38074 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKLB1e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so9771317wro.5
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qL4wj7459iPMRsDcnG3FORcSgu7Ph+oW/xXK95356Sc=;
        b=G7r3u/rB87jLdYr4OqGKjEMbPQtcfk0gSFY2u9wwNNI3pbSKuhF+0MU4buZFechCkc
         DsxTB5VERxqytRUNh3eZKldQPt5ixCKmVK/5K3I4QOcaqqPpn/VBOYEpi2NOKKXa6Gsk
         9WAQGUAIR7h++lD7CxYG2WIb65Y43eU6WTNHk5crYV7kjVjG1dGuTBmIwXTq3NplnCRQ
         7PtWDOcsYH4CgpJlrYdlk8d6r5Smb/TFHE7DQg5CJXihKqr9ZI6iSznJ4t7X32br5NxN
         IWWv6rLiFXpKaryep9t0dZ6OSgE2CAzXp99Qj2+tltMafeX9WWwOS5hA+Z7bbsM86mcM
         sQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qL4wj7459iPMRsDcnG3FORcSgu7Ph+oW/xXK95356Sc=;
        b=OsOYKqaiLH6gbGGElxOKs6I5zAmMWiCNZDmBySbsh8j865NoJYDjYCk2xR3hulS53M
         Kor+surK64c7it4b2EK2qzemNg6NZsYkFI/B1H49f6lZ6xGtMjkHcwg8l+KZJT4whmDF
         yWbbw01g/+dVNy167q1eT1hVaGHjt0eo7VWGEpQL7LhjJn4huTkdPovZ3qxAdWQ5EPHO
         D4Y4yyZHuxk1xAL2GPGKUQybfUW6/mRZmOkjZVL29oYBw1wjORzmIv8tat/anoQzIkSw
         jQFm6fp3wR8nkwwdPyWoabAHbw1MUYRGzlox5Um94cIedKfGQ34ofjVgNXJi+pusJCPb
         15jA==
X-Gm-Message-State: APjAAAXlka7QOVGWcHnNlNUSkys2HdtO6bCJNbzZQp3irL80+iqpGJdX
        ii6RVAGD2OIkiBSt7CTeaqwNTw==
X-Google-Smtp-Source: APXvYqwAz6W2ZVjazEo621wb27QOZgcXUHQ3oaRC0HT7QNLEASITqx547Su1jGibj6i1Q2O+7OLP/Q==
X-Received: by 2002:adf:f44a:: with SMTP id f10mr7773290wrp.63.1573522052545;
        Mon, 11 Nov 2019 17:27:32 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:31 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
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
Subject: [PATCHv8 01/34] lib/vdso: Add unlikely() hint into vdso_read_begin()
Date:   Tue, 12 Nov 2019 01:26:50 +0000
Message-Id: <20191112012724.250792-2-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Place the branch with no concurrent write before contended case.

Performance numbers for Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
(more clock_gettime() cycles - the better):
        | before    | after
-----------------------------------
        | 150252214 | 153242367
        | 150301112 | 153324800
        | 150392773 | 153125401
        | 150373957 | 153399355
        | 150303157 | 153489417
        | 150365237 | 153494270
-----------------------------------
avg     | 150331408 | 153345935
diff %  | 2	    | 0
-----------------------------------
stdev % | 0.3	    | 0.1

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/vdso/helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 01641dbb68ef..9a2af9fca45e 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -10,7 +10,7 @@ static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
 
-	while ((seq = READ_ONCE(vd->seq)) & 1)
+	while (unlikely((seq = READ_ONCE(vd->seq)) & 1))
 		cpu_relax();
 
 	smp_rmb();
-- 
2.24.0

