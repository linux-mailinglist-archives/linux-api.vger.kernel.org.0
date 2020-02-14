Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16B15E95C
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394461AbgBNRGj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 12:06:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46176 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394142AbgBNRGi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 12:06:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id k29so5153792pfp.13;
        Fri, 14 Feb 2020 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QW1XPYsqgB39eZebwl/0zlcNp074EgOP5RJbtqrekRI=;
        b=tjv0/8H5C4Q/P1CI4cMR+BGXtWyW85rmKZmanW8HGhITwLhPbQWFNhHgGWNwfUZgbS
         Q3Ds+v9zX14E43xMVdfMkET1cjZr0SG6/okyVsha5tB67+3fCOgLaK9a/3zixj5dumXV
         EwkFFlBhntJR+z+QnAeuBU+WzLNCx921Oz12VOiunXgMR2idXeMVhUwFBww8Eky1hLYC
         gQdOIWHJa3AxDPvShHWfx1sbbHqQFjKQdjvezK9XlCZr+5kdh7Fg1Xx6vjqHkQfRNzra
         i/RgKelzECG0vCdgocqy1TBiiNxyeI3lz4ztEGQf6mnCztYzpPycUlxBjfSlRbHW8u+V
         SJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QW1XPYsqgB39eZebwl/0zlcNp074EgOP5RJbtqrekRI=;
        b=Os1YygolZuRpHaeUNCu11YqyD237t/1NdKqts9fSJpTozxmMXfoP968C1U7WfylrJj
         NvXnZUpPGVD34s2o0p/+k970PDf3fn65Vdx/EALgaQcGdljTAh9QnEV8aEh82mGud7hR
         0Dk2+IPfwxpnBrNMGjTbvy4MHVRHopGAZ6EL9ANeqDzt0GZWXqqUdts0TaInI6RHmy6M
         CSYrU0dG0YAcdy4FBAJaG42ov9j8qKAlpa5oejkiBy205mlGCXVojp9RaMrEahGyMIV0
         FS7KTI3h4spTprjkSzRU5SfHNvvnk92py4UNX2yeRnBGbPoqbkJfcbMTAsmkbO1EbcK+
         L/gw==
X-Gm-Message-State: APjAAAVId6r+tuLX4U8TKMFBM+WMJBdmXHeeJ4TWvL9bZkFM5obse70A
        w/4QRM/P7owblltJqkVjpqo=
X-Google-Smtp-Source: APXvYqzPa9D1Lmoi4ZgRT/Il+guBGFLg4E8qSkXjuDrKMdjBDKsbzorml+cGx3N3NMnTf7FbxXP7tw==
X-Received: by 2002:a63:4b65:: with SMTP id k37mr4615617pgl.46.1581699997969;
        Fri, 14 Feb 2020 09:06:37 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a13sm7662924pfg.65.2020.02.14.09.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 09:06:36 -0800 (PST)
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
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Minchan Kim <minchan@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v5 7/7] mm/madvise: allow KSM hints for remote API
Date:   Fri, 14 Feb 2020 09:05:20 -0800
Message-Id: <20200214170520.160271-8-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214170520.160271-1-minchan@kernel.org>
References: <20200214170520.160271-1-minchan@kernel.org>
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

Reviewed-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 762a68205e65..0ecacfe93166 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1004,6 +1004,10 @@ process_madvise_behavior_valid(int behavior)
 	switch (behavior) {
 	case MADV_COLD:
 	case MADV_PAGEOUT:
+#ifdef CONFIG_KSM
+	case MADV_MERGEABLE:
+	case MADV_UNMERGEABLE:
+#endif
 		return true;
 	default:
 		return false;
-- 
2.25.0.265.gbab2e86ba0-goog

