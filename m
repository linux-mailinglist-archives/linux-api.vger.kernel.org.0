Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28876202C2
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 11:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfEPJmr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 05:42:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38557 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfEPJmq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 05:42:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so1397620wmh.3
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 02:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6Qf9WePQnjM1qP5GnvXQ6iGQgDn7ErWaVxKlruplAs=;
        b=kNlCwDBf2/qZJGSsor0rlTiPN2PGEZ4K2s2ds56FS0Hg6iSbcSXmN+ZNTkK+YLqwB9
         kcsVhD8EwmPh/CKfw4Oo9JDDiwQ4vIcRcuoOXom2o18ViatNYYzbX5eLKVEnMEqnUZTo
         t/rjt5DvQeC4hW5R8MFx39QZl6/+/NBH1FWbFr+pqvSq3LuCqWT9KNBpZse5YDMTnv32
         Zo4Azzo+HQ+TptOuwpxVgvzllENoYUukoffT3w9tQTws+8uyjELm6YRtzwgz5aC5/+zY
         40n81SJneSZLi87wsmDdGdye6tZETuA3+VNzqiIApsIfFRmT5W6h7NqpATmhNHjrTrWe
         AHVA==
X-Gm-Message-State: APjAAAUuIPhk4/80UI91a0eef9j10OrnORH8iFl+ll0XuLcjDe7WvtHF
        w5q3LJ0tlCBqkbeXTCAUDHhRCw==
X-Google-Smtp-Source: APXvYqwocKMkkFgpDNBPx7AOMP66gc9e2eLJvBHtDID7H77ayfvD2k23YyAA2hs51SHVNKxVSScv4w==
X-Received: by 2002:a1c:a695:: with SMTP id p143mr27260709wme.128.1557999764844;
        Thu, 16 May 2019 02:42:44 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t15sm4635388wmt.2.2019.05.16.02.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:44 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH RFC 5/5] mm/ksm, proc: add remote madvise documentation
Date:   Thu, 16 May 2019 11:42:34 +0200
Message-Id: <20190516094234.9116-6-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Document respective /proc/<pid>/madvise knob.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 Documentation/filesystems/proc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..17106e435bba 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -45,6 +45,7 @@ Table of Contents
   3.9   /proc/<pid>/map_files - Information about memory mapped files
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
+  3.12  /proc/<pid>/madvise - Remote madvise
 
   4	Configuring procfs
   4.1	Mount options
@@ -1948,6 +1949,18 @@ patched.  If the patch is being enabled, then the task has already been
 patched.  If the patch is being disabled, then the task hasn't been
 unpatched yet.
 
+3.12    /proc/<pid>/madvise - Remote madvise
+--------------------------------------------
+This write-only file allows executing madvise operation for another task.
+
+If CONFIG_KSM is enabled, the following actions are available:
+
+  * marking task's memory as mergeable:
+    # echo merge > /proc/<pid>/madvise
+
+  * unmerging all the task's memory:
+    # echo unmerge > /proc/<pid>/madvise
+
 
 ------------------------------------------------------------------------------
 Configuring procfs
-- 
2.21.0

