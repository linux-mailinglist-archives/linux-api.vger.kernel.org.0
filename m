Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8C1A454F
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2020 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJKlk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Apr 2020 06:41:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36146 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDJKlk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Apr 2020 06:41:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id u13so1387003wrp.3
        for <linux-api@vger.kernel.org>; Fri, 10 Apr 2020 03:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6QLdzKbUmCzenyVGneMFCV9bfKtlfDEGB2GO2r8hJWg=;
        b=RlDv/0oQA02ldjND6rBeHExH4DYeBwroQFO6VsXB7oPjn82aw7DE07jOJwamw79Dfw
         1QDYIJHtvE/Jz7D2sYlCZbKWpcYNbC66gpHtKKIgkZmE2trjcI6BzQZWIoMOCaFgEANN
         JFDUF2l696jXsGCPituOu4pCIg5LhTtzHohm0yYuQQ9niuDn0FTSOu0L2PJuM8kOtNs2
         glB3izUnxmDMea8RJxv2VXkUHVwUjLJei9XBOhihEWGkWvDFwvcJrZmlYEUaV5S3JQlp
         xy4spya55b7BFw5sZB+h11dt4sMgBOadYNHoGxRXu4dwA1jAq/nFyot69yPGoXllofPl
         Ky8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QLdzKbUmCzenyVGneMFCV9bfKtlfDEGB2GO2r8hJWg=;
        b=T/BHVMB0gDLWITD6R6GbWbekuFLEFAG0LvxmUPAWn6jV/Hs+08QKyqAJcyCtNnoxia
         HL9F7PBNrsiAtRS/WZOqLbLWw8eFLTcITakd/0+dV27ntcUXm9PVsb9Lcy/hItaI/Cft
         AZ2nVWoSwGQlm+XhDbcwfFqQRouddcG4BYemDkeu9w1pVZQngLaWWuLmkTpsdRrc4J8v
         5HMZnF+vZFJXQS9uH5ECDGyrsXfx12mB/7ollEszJwJisC5yZbN1BiERCnGk5VdPLVzf
         F1S0y1iJRUHb5klJb/ycQZBXmE0YVfsEFMVQCiBSI/jkZsaMqyRjhHNo2PNLeLCRyQjS
         I8EQ==
X-Gm-Message-State: AGi0PuaiePs1eunR21lGUO+30sCD2YSLX5FNBjhuyZ1juydCIWAtdpRv
        pVJctr5idD87RPgOB4EPD3abUg==
X-Google-Smtp-Source: APiQypJnyYw9Xx4D1lPATDBy+l4SIGQVgf2MNMD0X/0FRhYmNKG+qjDW7935nGlXVwfSRsc7tlplHg==
X-Received: by 2002:a5d:5045:: with SMTP id h5mr3844621wrt.86.1586515298588;
        Fri, 10 Apr 2020 03:41:38 -0700 (PDT)
Received: from wittgenstein.fritz.box (ip5f5bd698.dynamic.kabel-deutschland.de. [95.91.214.152])
        by smtp.gmail.com with ESMTPSA id u16sm2345546wro.23.2020.04.10.03.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 03:41:37 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     mtk.manpages@gmail.com
Cc:     cgroups@vger.kernel.org, christian.brauner@ubuntu.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, oleg@redhat.com, tj@kernel.org
Subject: [PATCH] clone.2: Document CLONE_INTO_CGROUP
Date:   Fri, 10 Apr 2020 12:41:32 +0200
Message-Id: <20200410104132.294639-1-christian@brauner.io>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 man2/clone.2 | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/man2/clone.2 b/man2/clone.2
index 39cec4c86..8d9aa9f99 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -197,6 +197,7 @@ struct clone_args {
     u64 tls;          /* Location of new TLS */
     u64 set_tid;      /* Pointer to a \fIpid_t\fP array */
     u64 set_tid_size; /* Number of elements in \fIset_tid\fP */
+    u64 cgroup;       /* Target cgroup file descriptor for the child process */
 };
 .EE
 .in
@@ -448,6 +449,25 @@ Specifying this flag together with
 .B CLONE_SIGHAND
 is nonsensical and disallowed.
 .TP
+.BR CLONE_INTO_CGROUP " (since Linux 5.7)"
+.\" commit ef2c41cf38a7559bbf91af42d5b6a4429db8fc68
+By default, the child process will belong to the same cgroup as its parent.
+If this flag is specified the child process will be created in a
+different cgroup than its parent.
+
+When using
+.RB clone3 ()
+the target cgroup can be specified by setting the
+.I cl_args.cgroup
+member to the file descriptor of the target cgroup. The cgroup file
+descriptor must refer to a cgroup in a cgroup v2 hierarchy
+(see
+.BR cgroup (2)).
+
+Note that all usual cgroup v2 process migration restrictions apply. See
+.BR cgroup (2)
+for detailed information.
+.TP
 .BR CLONE_DETACHED " (historical)"
 For a while (during the Linux 2.5 development series)
 .\" added in 2.5.32; removed in 2.6.0-test4

base-commit: ff5de6ecc4338f4b62c3459c99bd1a3a75ee2808
-- 
2.26.0

