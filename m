Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20414005B
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2020 01:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbgAQAAM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 19:00:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36479 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgAQAAL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jan 2020 19:00:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so11046910pfb.3;
        Thu, 16 Jan 2020 16:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8HMvNtR0Yr/0G1kCuWPpE/efrXm+U1USbROvI8CFic=;
        b=f5kcC/lGcofak/wnm8eHOoKUvo+na2iOkPkZSKjqqaIzJ+5aVFD4TEUor6ereTvJ6p
         t5txXIGg3oxL68CnlMHNsUIX2WksBfEDXcHaS8xiID24bQSKYIR3BQRc5MAZx3DJh09r
         mar5HOv6MBzYpoE9rqTWdm5z8iYPIqzSRGhQvyqj5t+CyU8u99n7R2eF5f65n2wV9mFr
         HYud3Ysipql4mKy+NCvR2emo38TC7DKLI+V+/jC+F0cNWpve0fI+B91XUTvupOZCwSDh
         GwzYLNsi2UhYaxLj5j7SHKyI2lMlA+qCrxwUmV7K7yJZkuNIVpvj9MQs1AclKJy8DxbT
         ZV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=H8HMvNtR0Yr/0G1kCuWPpE/efrXm+U1USbROvI8CFic=;
        b=W7Smnw/LaotsMZaa/2dnaTTA5P/wOqjgS6c6Q6rF+bsZz95q8U268rPb3L6arLhQPl
         Aoypn55yhddZ9k9sBPoZXRpvSEDkFVICY7Vx2oN1OuOfp8TxN25gCmoxnvlm3rREc9IZ
         IfZ7wQinFpbqKRykCaEQ/l1fGodhtVJq4McrWBPjMlon90w8rrz1FwTri3YHGmEk4DIk
         51zxdSduHyoMtJH9VUjY5EjnhhiBOyxvDG9IdxDpDWZJLDIsggzzj2cANGIPg2iLRb2D
         lyrD/+IPbiFji/wUR2kIDR1AbRKQ5LaMmQdplSs+2yd32wuTi+r5pNW3khg5LDPXGR1R
         YvXw==
X-Gm-Message-State: APjAAAVpMrZuPZ4rQLmonZhQcccZ4yv0go3TGC3K2XHoTfijb3QEgkBg
        M7aekwJrX5hS5bp0FKi86ws=
X-Google-Smtp-Source: APXvYqzvDAAr4MbHD2POg6JtSQKZAHaHXfFxw1HvbzcRnW/RCA5AvGamnLqnrWS5xbRpI1SF+CmhKg==
X-Received: by 2002:a63:f202:: with SMTP id v2mr41667379pgh.420.1579219210884;
        Thu, 16 Jan 2020 16:00:10 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z4sm26584885pfn.42.2020.01.16.16.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 16:00:09 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de,
        Minchan Kim <minchan@kernel.org>,
        Minchan Kim <minchan@google.com>
Subject: [PATCH v2 4/5] mm/madvise: allow KSM hints for remote API
Date:   Thu, 16 Jan 2020 15:59:52 -0800
Message-Id: <20200116235953.163318-5-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200116235953.163318-1-minchan@kernel.org>
References: <20200116235953.163318-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Oleksandr Natalenko <oleksandr@redhat.com>

It all began with the fact that KSM works only on memory that is marked
by madvise(). And the only way to get around that is to either:

  * use LD_PRELOAD; or
  * patch the kernel with something like UKSM or PKSM.

(i skip ptrace can of worms here intentionally)

To overcome this restriction, lets employ a new remote madvise API. This
can be used by some small userspace helper daemon that will do auto-KSM
job for us.

I think of two major consumers of remote KSM hints:

  * hosts, that run containers, especially similar ones and especially in
    a trusted environment, sharing the same runtime like Node.js;

  * heavy applications, that can be run in multiple instances, not
    limited to opensource ones like Firefox, but also those that cannot be
    modified since they are binary-only and, maybe, statically linked.

Speaking of statistics, more numbers can be found in the very first
submission, that is related to this one [1]. For my current setup with
two Firefox instances I get 100 to 200 MiB saved for the second instance
depending on the amount of tabs.

1 FF instance with 15 tabs:

   $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
   410

2 FF instances, second one has 12 tabs (all the tabs are different):

   $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
   592

At the very moment I do not have specific numbers for containerised
workload, but those should be comparable in case the containers share
similar/same runtime.

[1] https://lore.kernel.org/patchwork/patch/1012142/

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 mm/madvise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 84cffd0900f1..89557998d287 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1000,6 +1000,8 @@ process_madvise_behavior_valid(int behavior)
 	switch (behavior) {
 	case MADV_COLD:
 	case MADV_PAGEOUT:
+	case MADV_MERGEABLE:
+	case MADV_UNMERGEABLE:
 		return true;
 	default:
 		return false;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

