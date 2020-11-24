Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD92C1DA4
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 06:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgKXFjt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 00:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgKXFjs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 00:39:48 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3115C0613CF
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 21:39:48 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id v8so12915371ply.0
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 21:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mKYwXoA6RKca8Gj0Xk1sTxg7l//t2h1MecKeF/NRkRI=;
        b=XzkAfhjQjZIxPRVXwpA+vCIjhw5D1ZiRcns0Bc6KRsXecXgR6WE+UjIk/QsFUxgPEv
         qFKR0peCFZBJldWweVU8+NHwexec5RFx46+wmvFf4HLH41eapps4tWM0Ndu1aUb80c1+
         f5F6vLMfiDNxvAGfNSHYhn0vYmugKGHMnu8Ci8BIg1rDBsjxyH+CP+TmHcfJeYPymk5Q
         VCdIdtQichiTfQZst27cI85qMCj+GfANdP4VXQzBYQgxNHYX0qHFgwlYP7iRvEKtIZee
         yq0E5T1hQViO5kTU99IzxrrXTJxW++wms0tQQbOhW03Fb/jDJQXNZrbbFPvsufuvvhOt
         ZnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mKYwXoA6RKca8Gj0Xk1sTxg7l//t2h1MecKeF/NRkRI=;
        b=pOSta62KWOtZ19kc98whvJkzuNUzqrgqwmSJBXnlTWmW2Pi3rgST0QVmWJdAkADPyu
         c+K65hhcIwFMXUXFL+FiKV9846IjxxmLaMdEE29/xy1zk4AsOMcWyUU+34OOZDHIKGXw
         QAgOZ5H7GvctI89QPz/nq4CVuWHzh/3JgtaT4sQ3ktSSG4/+Oxub72qG4gW5TjQOYFfl
         j5HLp7zLTmeztkDJD6MC1Y5ek/3jguzBi+zy6yGqTiDLUvin9gXw59hJJYViEVnTXsD4
         JBeGAdzN+M1GL7H/AFiQHmRjvsYek4FjgaG3j8ODtHaX0kAyDwmw5gTCGfX/DwKSZ4Mu
         wdrg==
X-Gm-Message-State: AOAM533a26NaE35wWOgfSL0pgWKNISd/fWc5kmtUKEmKHJJVDcR8IzuK
        etEKbQZu1pnp6X39YotNJ8vI38ioLds=
X-Google-Smtp-Source: ABdhPJyBKvuaa4qpP38cFI9DjLi4nvNVC7tUSSFiYtk5IXXU0B/4MP5WiMXgroEOAmEtsn8LYawAQWNVU3Y=
Sender: "surenb via sendgmr" <surenb@surenb1.mtv.corp.google.com>
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:f693:9fff:fef4:2055])
 (user=surenb job=sendgmr) by 2002:aa7:978d:0:b029:197:fd52:ee48 with SMTP id
 o13-20020aa7978d0000b0290197fd52ee48mr2613356pfp.13.1606196388178; Mon, 23
 Nov 2020 21:39:48 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:39:41 -0800
Message-Id: <20201124053943.1684874-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 0/2] userspace memory reaping using process_madvise
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        christian@brauner.io, oleg@redhat.com, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When a process is being killed it might be in an uninterruptible sleep
which leads to an unpredictable delay in its memory reclaim. In low memory
situations, when it's important to free up memory quickly, such delay is
problematic. Kernel solves this problem with oom-reaper thread which
performs memory reclaim even when the victim process is not runnable.
Userspace currently lacks such mechanisms and the need and potential
solutions were discussed before (see links below).
This patchset provides a mechanism to perform memory reclaim of an
external process using process_madvise(MADV_DONTNEED). The chosen
mechanism is the result of the latest discussion at [4].
The first patch adds PMADV_FLAG_RANGE flag for process_madvise to operate
on large address ranges spanning multiple VMAs. Currently it supports only
the entire memory of a process. This is done to keep things simple and
since it's the only real usecase we currently know of. In the future this
can be developed further to support other large ranges. One way to do that
is suggested in [5].
The second patch enables MADV_DONTNEED behavior for process_madvise to
perform memory reclaim of an external process.

1. https://patchwork.kernel.org/cover/10894999
2. https://lwn.net/Articles/787217
3. https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
4. https://lkml.org/lkml/2020/11/13/849
5. https://lkml.org/lkml/2020/11/18/1076

Suren Baghdasaryan (2):
  mm/madvise: allow process_madvise operations on entire memory range
  mm/madvise: add process_madvise MADV_DONTNEER support

 arch/alpha/include/uapi/asm/mman.h           |  4 +
 arch/mips/include/uapi/asm/mman.h            |  4 +
 arch/parisc/include/uapi/asm/mman.h          |  4 +
 arch/xtensa/include/uapi/asm/mman.h          |  4 +
 fs/io_uring.c                                |  2 +-
 include/linux/mm.h                           |  3 +-
 include/uapi/asm-generic/mman-common.h       |  4 +
 mm/madvise.c                                 | 81 ++++++++++++++++++--
 tools/include/uapi/asm-generic/mman-common.h |  4 +
 9 files changed, 101 insertions(+), 9 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

