Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE91DDA31
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 00:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgEUWZ5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 May 2020 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgEUWZ4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 May 2020 18:25:56 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CFCC061A0E
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 15:25:56 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id g6so8726563qvn.3
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IcMIWpTIuJhOXe3roKCgk3KWh3umIrVN5sjlOXmENmE=;
        b=n4N7mbnzd+X7RmLijocF1fab6W7WtoTITGMbGY3Qfn/byG9EcJvqHVnka2hmpyYVFs
         rrHb82CqiSaztzWuWl0w7CIIP8DtJXCCjTxqcM3hq5jGM3rBWTv5rANe3FfJKLNYxwot
         7eDFZbmuU2AtPzrRNgSiW0T2vIRfOnzNVfzTu4qo4fekYNBE/X9INuOeJb9+AeMBy6YY
         nvB4yQSetAr+59/y4rOaLDupbgJosev9HUrAX1n04wBq7Ubd7S309nMztfO9TSkHpmqO
         dQ82SxMi/0nL3nX6HoqKVmKBkqDmSlVI0Ny3VKBsV0YmRdXAIeC3EFMOMwKMf/5Y7ogg
         Ry+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IcMIWpTIuJhOXe3roKCgk3KWh3umIrVN5sjlOXmENmE=;
        b=rgZ7bgxLvZtp2KN2KijNCEVMjWSn7er0Hg9ELu3V23dR4qoBc8IQVgSTEozArowwCP
         ZS+xJRMBLgMUdmnITyWZpR8cSEGzkRk1aK+JrcCxLBSNm+qpLSZkxKAH8XJBrBUIl6me
         SgnuQFvVgSToTyynZpXgdgsiBYfpZwc6uQVlzRjl72b9+vXLtaHThg26877Uuk0kataH
         eokCDGve1JfOwfX5AlCXOY4lTqSG+jPU1qQdigXs1/wa955cnhhT6qECdj3ahnUkxOhN
         YsUKGroIYWk+kbWlZb+0I8jQ3MQL0OfHy/+MKH26l6858flLPmPfni/z+WAoGlSD7/hl
         n4Ww==
X-Gm-Message-State: AOAM531TiSzpAL8LHcAjPRBVOMgTbyUyJEtpyQMmrm7lKvuPliSEb2pn
        kGPF3NgaiT9HmcXegl8VSWybdZGT0v+Y
X-Google-Smtp-Source: ABdhPJy7zMpHMw3vtshTDzUFBDK8SKAjdIyya1+LREbYnNfVWw7HiFYhgZ5eGU1W+DninwgUHDkpcJ8rEx/b
X-Received: by 2002:ad4:43e3:: with SMTP id f3mr908752qvu.115.1590099955922;
 Thu, 21 May 2020 15:25:55 -0700 (PDT)
Date:   Thu, 21 May 2020 15:25:51 -0700
Message-Id: <20200521222551.259804-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] proc.5: add "wf" to VmFlags in /proc/[pid]/smaps
From:   Ian Rogers <irogers@google.com>
To:     Rik van Riel <riel@redhat.com>, mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, nilal@redhat.com,
        Florian Weimer <fweimer@redhat.com>,
        "=?UTF-8?q?Colm=20MacC=C3=A1rtaigh?=" <colm@allcosts.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch documents a flag added in the following kernel commit:

commit d2cd9ede6e193dd7d88b6d27399e96229a551b19
Author: Rik van Riel <riel@redhat.com>
Date:   Wed Sep 6 16:25:15 2017 -0700

    mm,fork: introduce MADV_WIPEONFORK

This was already documented in man2/madvise.2 in the commit:

commit c0c4f6c29c494c466f3a2a6273c5b55b76a72927
Author: Rik van Riel <riel@redhat.com>
Date:   Tue Sep 19 20:32:00 2017 +0200

    madvise.2: Document MADV_WIPEONFORK and MADV_KEEPONFORK

Signed-off-by: Ian Rogers <irogers@google.com>
---
 man5/proc.5 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/man5/proc.5 b/man5/proc.5
index 46d603f28..3e5b91af0 100644
--- a/man5/proc.5
+++ b/man5/proc.5
@@ -2020,6 +2020,7 @@ encoded using the following two-letter codes:
     ht  - area uses huge tlb pages
     nl  - non-linear mapping
     ar  - architecture specific flag
+    wf  - wipe on fork
     dd  - do not include area into core dump
     sd  - soft-dirty flag
     mm  - mixed map area
-- 
2.27.0.rc0.183.gde8f92d652-goog

