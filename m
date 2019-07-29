Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1479BD2
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbfG2V7O (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:59:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35877 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389495AbfG2V7N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:59:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so63546719wrs.3
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aoCU6uPiHr0PzNNlgylsAXV9auaD7Fl9k+QB3VPTwmU=;
        b=lyIFFZOD5gGnj2VKFbxI8Hxm8GCuaJLZOdM1TyAWTYxIPvJazlmaSBv32iCYrkk9A5
         DfFEvqo6cOZTHKDRnFIdSlBt8YD/QZ8veboYXgj4rB+mpr//AYCUP4yKtAAzfbm+Nw14
         mJ03K6t68W5ENcS05b+wwnmCMlkOaDoX6b03Qe8GTZOa9fy7qFMb3+H7oFCig63RkBEn
         rlQ36OfCpIKR4G/fJWpg/Qs2MUcYqJTKypbbp4nl7UKrVyZwUDn559vkbLSVW6GIb2F9
         jHRXiTd2wswHPS5WdJTjC2JHRc9AQmguOe9J1Xz+EfKWXT4WtQree65HPLVX3qjngW3I
         o1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aoCU6uPiHr0PzNNlgylsAXV9auaD7Fl9k+QB3VPTwmU=;
        b=NsyNOBr9ATvxyboGX8/SZKthzI/RNybbPDP72iY8xFoFOTQyA5RuN0yu45PMyQ0TNr
         1Jmm7JEmwKA8EKJlBWodL8RuYlHdpLBKGF2kGw/oa2KPLIea6SjTY1OTH1Cv2r9A/9PP
         dePvujm/rStfAK4dANdvkgXYaJCoI7Y8/vtSY75vbY3s8Gfu5Lg7ziq1zQIXiKsH1Rd8
         NvpSrsuWL/8o2322tGynf3N4Z0Ny8m16+q8QPy19wblevczsBCkbKZf+tVc+T9kTdNei
         olijRZR49uUgiL4WZSC1YOpRmni0J0C+fRkyNvMluKxYv8ohMJSuL3FF3e7nDqsu4AdY
         466Q==
X-Gm-Message-State: APjAAAUZHVuyX0N357jyoZ9fSOLwWMqrCAss5rE/j5yxxV79RUZVMCBj
        WJAKeS7QwCGacu0nlbo9fcWoYat20eCAcnmknGc0ipkfs/cM0BXxgDIMZ2raw05Em6Oa3KT8AZ8
        FxJSL8kjSjYBBCaB3KEvdaNxsE9qZXRdolDXOGWOc84BLmxh/qU9h2Wn0g5O2HTLu2+3mTACm5P
        OXCGKIIdC5WBEwYfaZ7qKWil0/+A==
X-Google-Smtp-Source: APXvYqwo+T0JZn8gYaWYPlQ7YHb0W1CWyxIgG9rZ2SMtPY56m1Y6nTv2AwANMMtSkZjoHgHSB+0fqg==
X-Received: by 2002:adf:aac8:: with SMTP id i8mr17425wrc.56.1564437551664;
        Mon, 29 Jul 2019 14:59:11 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:11 -0700 (PDT)
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
Subject: [PATCHv5 13/37] posix-timers: Make timer_settime() time namespace aware
Date:   Mon, 29 Jul 2019 22:57:33 +0100
Message-Id: <20190729215758.28405-52-dima@arista.com>
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

From: Andrei Vagin <avagin@gmail.com>

Wire timer_settime() syscall into time namespace virtualization.

sys_timer_settime() calls the ktime->timer_set() callback. Right now,
common_timer_set() is the only implementation for the callback.

There user-supplied timer's value is converted from timespec64 to ktime
and then timens_ktime_to_host() can be used to convert namespace's time
to the host time.

Inside a time namespace kernel's time differ on a fixed offset from
a user-supplied, but only absolute values (TIMER_ABSTIME) must
be converted.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 265fbc816520..c979e720a5a1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -857,6 +857,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-- 
2.22.0

