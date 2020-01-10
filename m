Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7813788E
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 22:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgAJVer (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jan 2020 16:34:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36232 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgAJVeq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jan 2020 16:34:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so1331470plm.3;
        Fri, 10 Jan 2020 13:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//Vec5skQW+H9IPGRTNbLtqR3goYkBV9ehrKBDaBk60=;
        b=rURmhW8wIF5KaQsftvbrXK/WNqEug54J5oUNqc7D2y8i0VNxKhfqtIIWkeKS+rI+rf
         ukFURwW9nBJzL2fIW5hQ/oFXNOgNWzwsvTw/Zoa4OQKmQ2U9pcNQZVzs+vMEOjHz8agB
         Yl76iCX6lKPXezdEACjEkV+oZgyKT5n5CoJNlvEbBDcVwI+u0Ol5QPl2AcmNyY7dzZIa
         8CC3O7wtMjWAPrJtm5srhBkqvguebPYp7vKuCR98SQeUQEutaxAfumTwgQe72TDSFy8d
         /0cIAWs2gl26s6vbbkPuKVU9i8VipkyIFZ9F7IE+gBRXE4s3I1JAEm0H7GnfYE2U969x
         VhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=//Vec5skQW+H9IPGRTNbLtqR3goYkBV9ehrKBDaBk60=;
        b=EDEU0XNUPoX/x5xZ/MNsY38AudWWGl3+KcbOkqcNRe/I9c3FRE8GukZc+rwYWD9B9Y
         Y7JI1KOhByRRwFLrIAxIkwaZK4yl0TkbfeJeDje8MmFQciN8Pc5M8wYd0s9Mn3MtiJd6
         mioBUM+y9fpLjhCn/t8yEtC9DBR4YM2WsPrg8gEIF8h2VHXOGvvh7UIXpZJY3wZp2F66
         zbNYl98Tu00+t2ufmfFohhX87v6x+1P7/jyWcghrDCl/7Ugz3vHKsWNJFV5FPYafV9s2
         slZYd9FEmtwzQY8r4ubpA/bvj15Fy+x7SVpR8hOtnor3vWgb91vb+PGZCpv9AWr7XfVw
         C1TQ==
X-Gm-Message-State: APjAAAXCWdwzqgrpqgKXvUwZZaUmSdtRVI+8HKbwQBWCnyN0Qenn/1nG
        g3Uj14yVr9Kr5PrgI35pjwg=
X-Google-Smtp-Source: APXvYqyiUD9sT7EtnveIa/vRKGHAVVn2/b7SMr8wdqziUFzg/6Noadwwq9c50Cg1S/0Q+GiUW7raUg==
X-Received: by 2002:a17:902:b104:: with SMTP id q4mr731201plr.132.1578692085293;
        Fri, 10 Jan 2020 13:34:45 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t137sm3692307pgb.40.2020.01.10.13.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:34:43 -0800 (PST)
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
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 4/4] mm/madvise: allow KSM hints for remote API
Date:   Fri, 10 Jan 2020 13:34:33 -0800
Message-Id: <20200110213433.94739-5-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
In-Reply-To: <20200110213433.94739-1-minchan@kernel.org>
References: <20200110213433.94739-1-minchan@kernel.org>
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
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index eb42b2b7f49b..3aa9aec6bfd9 100644
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

