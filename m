Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC2619C3EB
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 16:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgDBOYC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 10:24:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43693 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgDBOYC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 10:24:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so1811821pfa.10
        for <linux-api@vger.kernel.org>; Thu, 02 Apr 2020 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKsdyJHMQOOGD0iN0cwvmSOHvAeupUh/gQgZtw9UX6s=;
        b=Au8mSb87D14H7Y6Oz2xrArStsBmCxE6pPs5joodDHlfwWbtu11X5F6jQU2MHcz1L8v
         vbZ80oBuIeDlTXds02bSA2HfuzroP1HcLreUmcxxtohujTQW3aniI4d+zVLydxcS5E81
         sSuKU8dQckYNT+GSa6tpMo5VVknxNUYCY8oPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKsdyJHMQOOGD0iN0cwvmSOHvAeupUh/gQgZtw9UX6s=;
        b=X4V66cOFHW+9ax5N6ZeW12BzzWZBilwrygtiJntNoXcACyl6ds57+166fNyMwJgN1f
         xPJhdQDBNQt5L7MWmH+qWw2uXLSc8H53VDIx4kr1heFaMoWAF6eRR0pa/6L/vDUOeFMJ
         cePwdMpTzFxejZ5l1/S0ZuopQ1e6VJJyIYWAPX8zIc7WDuyVZ3A+rOmSNaDrAMU4aKSj
         ycjUqXQyaHNeyKSZeZHL/XlaDGNMOUnmNTsoIZJemQXvrhk5OGi8Ha99OyYA9w3rhyxu
         P/XyuIIMhmJ2kEbPgR0drcE75t9gCRh7IA5Gc6t1wcypjHZ91ZCJOgqM63QzMhAeRIU6
         Qhgg==
X-Gm-Message-State: AGi0PuabbM94s2wVyy7dKsM31lQOSKe0mAKEaCrAakc5L/B+MYHNiSr8
        77zmd/vltfqKDRTFQwqP6LGwgVHcCHU=
X-Google-Smtp-Source: APiQypJKcXYFCdc9+7WRjMSg7cY/u6tT/yYMhCEC1xya6kl1p312x/Yj5tZR0Eu2qKnArtICLC54hg==
X-Received: by 2002:a63:7419:: with SMTP id p25mr3382733pgc.217.1585837441243;
        Thu, 02 Apr 2020 07:24:01 -0700 (PDT)
Received: from localhost (d154-5-233-134.bchsia.telus.net. [154.5.233.134])
        by smtp.gmail.com with ESMTPSA id o15sm3837044pjp.41.2020.04.02.07.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:24:00 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Thu, 02 Apr 2020 07:23:58 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     linux-man <linux-man@vger.kernel.org>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can return other errors
Date:   Thu,  2 Apr 2020 07:23:47 -0700
Message-Id: <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

See Linux source as of v5.4:
  kernel/time/posix-clock.c

Signed-off-by: Eric Rannaud <e@nanocritical.com>
---
 man2/clock_getres.2 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/man2/clock_getres.2 b/man2/clock_getres.2
index 0154f9d32473..71f7f8dfa662 100644
--- a/man2/clock_getres.2
+++ b/man2/clock_getres.2
@@ -260,6 +260,10 @@ specified in a call to
 .BR clock_settime ()
 is not a settable clock.
 .TP
+.B EOPNOTSUPP
+The operation is not supported by the dynamic POSIX clock device
+specified.
+.TP
 .BR EINVAL " (since Linux 4.3)"
 .\" commit e1d7ba8735551ed79c7a0463a042353574b96da3
 A call to
@@ -276,6 +280,11 @@ clock.
 .B EPERM
 .BR clock_settime ()
 does not have permission to set the clock indicated.
+.TP
+.B EACCES
+.BR clock_settime ()
+does not have write permission for the dynamic POSIX
+clock device indicated.
 .SH VERSIONS
 These system calls first appeared in Linux 2.6.
 .SH ATTRIBUTES
-- 
2.26.0

