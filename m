Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7548155F7F
	for <lists+linux-api@lfdr.de>; Fri,  7 Feb 2020 21:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGUVs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 7 Feb 2020 15:21:48 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:57215 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgBGUVs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 7 Feb 2020 15:21:48 -0500
Received: by mail-pf1-f202.google.com with SMTP id r29so375361pfl.23
        for <linux-api@vger.kernel.org>; Fri, 07 Feb 2020 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+f6B99g77KURDLWF0jG9B7rc7+G1Jyxo/PtYXlo3EKQ=;
        b=MuXfBDuK2Hk/EkqAJ60zYjzf93z6CNxNm426qL5FrmxphPUaEXf3WYROatjGu68r7h
         3gLxrmQy6VA/5ic+x8IxrqdeA49iaGfjoUnnlUi6/wT5wD4phJJro1exeBmzl3owxblv
         UeAVVtMr37MjTKtVPmsuqhhcdcmxbmKh6qRQ+mdY5+xe4ZOgcr+/u9JlYrxI9u+/fwBN
         7FxFAuKSIiNqr003zrEVB2NGpscq1G8j3xFIuoN2Ju0IVw1nXSq3hEDeL2ccndKrwFne
         uRq8M54rH+um4uGbNf4PG2YdaOxN10HKYCQt+zmHJt6HjbZATbMy73ojTOl3ZeQbrIEp
         DKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+f6B99g77KURDLWF0jG9B7rc7+G1Jyxo/PtYXlo3EKQ=;
        b=Vs2JcmwASUKxDSMpwh/myjiql7frBxdDQq4PYms4j6egTFzl1Oy6TQIgKOFQ4VPusf
         lmedOj80kyODrq5Thx4WPNCwDodtbCxvq5V41/f+GbdcoRWsEjjWvzgHRTHuiFFN1Jhj
         er3B+WbrcFp6kQ1kQuuhql7mAly2QliAm6YArPkgHMfWoKOWTc5Q44PqMvh9iunLjgzM
         Jt9aim6AUJfQmNAxyM+f899jFdozplC8AOZkac5hUG1/0tA4zZ08SzA56YJvpTnLfu6X
         Y6ZrwidPhZVj02VZTz2yyL1xqIe29t4Zjd2j5edWVGCOWuQuWLOhxnWoQ0mmhGtfwEra
         uTtA==
X-Gm-Message-State: APjAAAUahDzJMFSyU5BgsVZ5WlRsk+RqdjiUiqH85SeUdmcdDz3EXfZB
        r6qp0ZHHXMSovgvz0/SvrxCopDRXEOfx
X-Google-Smtp-Source: APXvYqx1U2Lrq+cO2dZtr2CupCBM/sOTbHK7qy0c5byUyPUEajDLI08oKejCN9iIGiyA6zxnyX6Dy2p1x4hj
X-Received: by 2002:a65:641a:: with SMTP id a26mr918780pgv.425.1581106906604;
 Fri, 07 Feb 2020 12:21:46 -0800 (PST)
Date:   Fri,  7 Feb 2020 12:21:24 -0800
In-Reply-To: <20200207201856.46070-1-bgeffon@google.com>
Message-Id: <20200207202124.68949-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20200207201856.46070-1-bgeffon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] mremap.2: Add information for MREMAP_DONTUNMAP.
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 man2/mremap.2 | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/man2/mremap.2 b/man2/mremap.2
index d73fb64fa..c660a45be 100644
--- a/man2/mremap.2
+++ b/man2/mremap.2
@@ -26,7 +26,8 @@
 .\" 1996-04-12 Tom Bjorkholm <tomb@mydata.se>
 .\"            Update for Linux 1.3.87 and later
 .\" 2005-10-11 mtk: Added NOTES for MREMAP_FIXED; revised EINVAL text.
-.\"
+.\" 2020-02-05 Brian Geffon <bgeffon@google.com>
+.\"            Update for MREMAP_DONTUNMAP.
 .TH MREMAP 2 2019-03-06 "Linux" "Linux Programmer's Manual"
 .SH NAME
 mremap \- remap a virtual memory address
@@ -129,6 +130,13 @@ If
 is specified, then
 .B MREMAP_MAYMOVE
 must also be specified.
+.TP
+.BR MREMAP_DONTUNMAP " (since Linux ?.?)"
+This flag which must be used in conjuction with
+.B MREMAP_MAYMOVE
+remaps a mapping to a new address and it does not unmap the mapping at \fIold_address\fP. This flag can only be used with private anonymous mappings. Any access to the range specified at \fIold_address\fP after completion will result in a page fault. If a
+.BR userfaultfd (2)
+was registered on the mapping specified by \fIold_address\fP it will continue to watch that mapping for faults.
 .PP
 If the memory segment specified by
 .I old_address
@@ -176,6 +184,8 @@ a value other than
 .B MREMAP_MAYMOVE
 or
 .B MREMAP_FIXED
+or
+.B MREMAP_DONTUNMAP
 was specified in
 .IR flags ;
 .IP *
@@ -197,9 +207,14 @@ and
 .IR old_size ;
 .IP *
 .B MREMAP_FIXED
+or
+.B MREMAP_DONTUNMAP
 was specified without also specifying
 .BR MREMAP_MAYMOVE ;
 .IP *
+.B MREMAP_DONTUNMAP
+was specified with an \fIold_address\fP that was not private anonymous;
+.IP *
 \fIold_size\fP was zero and \fIold_address\fP does not refer to a
 shareable mapping (but see BUGS);
 .IP *
@@ -209,10 +224,20 @@ flag was not specified.
 .RE
 .TP
 .B ENOMEM
+Not enough memory was available to complete the operation.
+Possible causes are:
+.RS
+.IP * 3
 The memory area cannot be expanded at the current virtual address, and the
 .B MREMAP_MAYMOVE
 flag is not set in \fIflags\fP.
 Or, there is not enough (virtual) memory available.
+.IP *
+.B MREMAP_DONTUNMAP
+was used without
+.B MREMAP_FIXED
+causing a new mapping to be created that would exceed the virtual memory available or it would exceed the maximum number of allowed mappings.
+.RE
 .SH CONFORMING TO
 This call is Linux-specific, and should not be used in programs
 intended to be portable.
-- 
2.25.0.341.g760bfbb309-goog

