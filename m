Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3DD168544
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgBURm6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Feb 2020 12:42:58 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42798 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgBURm5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Feb 2020 12:42:57 -0500
Received: by mail-pf1-f201.google.com with SMTP id z26so1676540pfr.9
        for <linux-api@vger.kernel.org>; Fri, 21 Feb 2020 09:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/P+y5vx/TxaR6L3Exm4hXUShsr11bB8XrVre0/LSmjk=;
        b=Uuw/Lr1HgKiaclFFVM4QuMMSK19Lx7kar70t8O1hQH72+spUWb//A+ll1YvWDIBOH8
         tPFBeabj/Z1ysUHHoXOWGH2GVhPW0URCi1WklOpbT1vIs8OyT+5hRK+xLXk/2GAKs/v1
         Mp2UN2gS9jLRZSlggDsios49d04onl/1RWELhh/S0IWHPiyVLZxuKNSEQtnnfra4APto
         cJtP43KHMaYzzwC1gau4up6bLwGv2hOTKBof9H3uLIHyhWN05YqRn1VKlb+KF3fh9ur2
         oipqkOexMRzlCWGeatnaQUn1cD1dMz449QbytYmDlI68oDN30+KJ9wBY4FPrKwNAlOpP
         wEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/P+y5vx/TxaR6L3Exm4hXUShsr11bB8XrVre0/LSmjk=;
        b=owsREqHE7Um4uWdTEUpIUljRW/PJEVOOMZFzuTJDtjOzb5zuExcmiq6oOzcFdLFDni
         eLkDMPsIDbel35PKUJ5uAF4QOBgMaMYt9U7mYUHAMp/5cnGxXO1+BR6deOlJddgM6lzp
         5ovipzt/X5FsVPS8i9AtAZ/hJ0CBMtSKMB5R2PHe+GlCON2ijBwOoU7JLrWDN9m4lvK+
         OHVIXhBO+yUUsqTwyx83CH0iafApqVaMfb/CeDFtQinny0QgxPwWeFJ1Nc3Sa/1StJMD
         WJTOOcVCex70jMW3BadQfAs/yrLlQd2145lWuU9C3VaPAhsjCd4YxfBHGdclybwtuxZm
         4YgQ==
X-Gm-Message-State: APjAAAW5tXE+WYF07/eVwpzYLTbOtKL7Zk+Cgup/k4U8uDoxtXB9UGcr
        FyjZV6MCINi6p/QfndKfcVElxRPKs9r9
X-Google-Smtp-Source: APXvYqzOBT+mipzF7MvD+gaHRNmziAUAAa3agpZPSJC4Oxj2yqOyP5uevSOQcrFBRSZnIExGrmeub5QBA1cZ
X-Received: by 2002:a63:8f49:: with SMTP id r9mr39964734pgn.190.1582306976655;
 Fri, 21 Feb 2020 09:42:56 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:42:48 -0800
In-Reply-To: <20200221174248.244748-1-bgeffon@google.com>
Message-Id: <20200221174248.244748-3-bgeffon@google.com>
Mime-Version: 1.0
References: <20200221174248.244748-1-bgeffon@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7] mremap.2: Add information for MREMAP_DONTUNMAP.
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
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 man2/mremap.2 | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/man2/mremap.2 b/man2/mremap.2
index d73fb64fa..54ec67b20 100644
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
+.BR MREMAP_DONTUNMAP " (since Linux 5.7)"
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
@@ -197,9 +207,17 @@ and
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
+.B MREMAP_DONTUNMAP
+was specified and \fIold_size\fP was not equal to \fInew_size\fP;
+.IP *
 \fIold_size\fP was zero and \fIold_address\fP does not refer to a
 shareable mapping (but see BUGS);
 .IP *
@@ -209,10 +227,20 @@ flag was not specified.
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
2.25.0.265.gbab2e86ba0-goog

