Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5014AD0F
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2020 01:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgA1ARG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jan 2020 19:17:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44440 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA1ARE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jan 2020 19:17:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id y5so2626286pfb.11;
        Mon, 27 Jan 2020 16:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byMHrtK1k5FQWktxNZKgpIEhIdZ+jOjWAb7BIyi4lBA=;
        b=gcx1AwE/bXt90sOnHE8tkitJggiidEQCzgaEc9elcFPregk1F09926WnR6sPAg3NHJ
         mIdBVj3BsjX81nGowuT7nAHRs/GrhviVJ0DG0ewbqf9nFz7NW9teL64pZ80eInjpolPq
         tt9YXVZIlEnxXxs3ICAKN+eSUjOOAUjpIiPgAi6cSZGda3zZyEN1/53WSOo3HCGu4l9/
         G0DIYIfxA5E7gL/I1DcIRTTnJgrEP+6HhyO/1n2jPWRNKAeF6JjqwMi/diaeEbctuQxz
         8C/6+fIHhoD0HaL7Cugo9ZHJUBLrc+HiU4S3OW9lz1c1njwkgnk1GWxa564lMnoHTJP9
         oNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=byMHrtK1k5FQWktxNZKgpIEhIdZ+jOjWAb7BIyi4lBA=;
        b=s7jNU4MDJ0eBy3ln9TBRXF93Ub1rMgaUL5L64QZp46qdVIE/Zdg6V6f7/C9YanSpMM
         pub4RzMZwwEOV1D+1YxYvDIkh7/m6j0/IFRc6rdG3pPGML5ctY3O6cICpZVDEuBMABci
         qGBKKdGe9IQsSKTY09mRROAQ4qKpBckoR8Q267IAWcAYLb+qJsPnBo5nCu6cjCDNHXcX
         4buCsc2r7vissgIsg5jADogjHh5dMDh3oGgMJu+n22JKlMraopH14aJEWZgisHiaio7b
         22GghpkO+dXKMvy1ai9GtWnCLoNs25bmT+wYqS+TyDIL72qyl8TQVFaq+CgHhKYkFTMq
         QzYA==
X-Gm-Message-State: APjAAAWCJBl6QtuLVdDpZQVM02LBXSq3yNunJqY/Yd5zhxBRSR9foZpJ
        isHoeBpZwyyv/tk8yXcfpdQxfAey
X-Google-Smtp-Source: APXvYqx9+zAHx+aMRolYkWKe8SUK4zOvH2qwG7qZk5YBG1aQfIomoeisjAxibGaMfQWIJ4KB7xfjJA==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr1189196pfi.210.1580170623768;
        Mon, 27 Jan 2020 16:17:03 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id q28sm11301461pfl.153.2020.01.27.16.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 16:17:02 -0800 (PST)
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
        Joel Fernandes <joel@joelfernandes.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 4/5] mm/madvise: allow KSM hints for remote API
Date:   Mon, 27 Jan 2020 16:16:40 -0800
Message-Id: <20200128001641.5086-5-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200128001641.5086-1-minchan@kernel.org>
References: <20200128001641.5086-1-minchan@kernel.org>
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
 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index bc0a72dbf80e..39c40cbb389e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1002,6 +1002,10 @@ process_madvise_behavior_valid(int behavior)
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
2.25.0.341.g760bfbb309-goog

