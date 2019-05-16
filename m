Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB5202BC
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEPJmi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 05:42:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40793 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJmi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 05:42:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so2732336wmb.5
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 02:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gHm+iD7rZdl8yaphKTxHy2bQe/5CXij6G4rlYG4YYfI=;
        b=G7U85eZyDcMADjvViC2jWLbSLgsL9g+k/zr3VkuzGxIxcXd/z9Ab+G8zk9kQGw45BU
         E6tEWgzRSDzszef7l8cW72pjqCzcqMIJfQ9sueXTLzad4K+YIgqQFrXkcTVQkTNTMjks
         iGuPIZit4rFx7NNRymzJVtTTrGbfvqdB+KHY+Vgie2GV7XoS4qsknidJf47VTge6P5Jm
         C+gwR1X6PPfjlpMdKrTeoI653Y5J28AXgypgBmsW5362HaUEQ0BUZZhp2iFMsePkKQIE
         y53+pBcM2d8dX4LZSNM4n7Ez5LD6AX/zCFDSLZSjkX3aehO9FRrid26VsNzETamqxq1M
         Wpcg==
X-Gm-Message-State: APjAAAU5UBj8yN76jEfC5OwiM7jfAm0sokQ1fitxiMucBUW41tyZUsmE
        We7foo75pfsrjYvIuFbD2/E11Q==
X-Google-Smtp-Source: APXvYqywEZzpwr5DVxyQ7iBWpgzDQ3CVPDqgyLNgDwPWzSeCwIJ01Zq+QHt2fwTtyY5wN7IHt5QUxA==
X-Received: by 2002:a1c:e702:: with SMTP id e2mr13277260wmh.38.1557999756483;
        Thu, 16 May 2019 02:42:36 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h11sm5900942wrr.44.2019.05.16.02.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:35 -0700 (PDT)
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
Subject: [PATCH RFC 0/5] mm/ksm, proc: introduce remote madvise
Date:   Thu, 16 May 2019 11:42:29 +0200
Message-Id: <20190516094234.9116-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It all began with the fact that KSM works only on memory that is marked
by madvise(). And the only way to get around that is to either:

  * use LD_PRELOAD; or
  * patch the kernel with something like UKSM or PKSM.

(i skip ptrace can of worms here intentionally)

To overcome this restriction, lets implement a per-process /proc knob,
which allows calling madvise remotely. This can be used manually on a
task in question or by some small userspace helper daemon that will do
auto-KSM job for us.

Also, following the discussions from the previous submissions [2] and
[3], make the interface more generic, so that it can be used for other
madvise hints in the future. At this point, I'd like Android people to
speak up, for instance, and clarify in which form they need page
granularity or other things I've missed or have never heard about.

So, I think of three major consumers of this interface:

  * hosts, that run containers, especially similar ones and especially in
    a trusted environment, sharing the same runtime like Node.js;

  * heavy applications, that can be run in multiple instances, not
    limited to opensource ones like Firefox, but also those that cannot be
	modified since they are binary-only and, maybe, statically linked;

  * Android environment that wants to do tricks with
    MADV_WILLNEED/DONTNEED or something similar.

On to the actual implementation. The per-process knob is named "madvise",
and it is write-only. It accepts a madvise hint name to be executed.
Currently, only KSM hints are implemented:

* to mark all the eligible VMAs as mergeable, use:

   # echo merge > /proc/<pid>/madvise

* to unmerge all the VMAs, use:

   # echo unmerge > /proc/<pid>/madvise

I've implemented address space level granularity instead of VMA/page
granularity intentionally for simplicity. If the discussion goes in
other directions, this can be re-implemented to act on a specific VMA
(via map_files?) or page-wise.

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

The history of this patchset:

  * [2] was based on Timofey's submission [1], but it didn't use a
    dedicated kthread to walk through the list of tasks/VMAs. Instead,
	do_anonymous_page() was amended to implement fully automatic mode,
	but this approach was incorrect due to improper locking and not
	desired due to excessive complexity and being KSM-specific;
  * [3] implemented KSM-specific madvise hints via sysfs, leaving
    traversing /proc to userspace if needed. The approach was not
	desired due to the fact that sysfs shouldn't implement any
	per-process API. Also, the interface was not generic enough to
	extend it for other users.

I drop all the "Reviewed-by" tags from previous submissions because of
code changes and because the objective of this series is now somewhat
different.

Please comment!

Thanks.

[1] https://lore.kernel.org/patchwork/patch/1012142/
[2] http://lkml.iu.edu/hypermail/linux/kernel/1905.1/02417.html
[3] http://lkml.iu.edu/hypermail/linux/kernel/1905.1/05076.html

Oleksandr Natalenko (5):
  proc: introduce madvise placeholder
  mm/ksm: introduce ksm_madvise_merge() helper
  mm/ksm: introduce ksm_madvise_unmerge() helper
  mm/ksm, proc: introduce remote merge
  mm/ksm, proc: add remote madvise documentation

 Documentation/filesystems/proc.txt | 13 +++++
 fs/proc/base.c                     | 70 +++++++++++++++++++++++
 include/linux/ksm.h                |  4 ++
 mm/ksm.c                           | 92 +++++++++++++++++++-----------
 4 files changed, 145 insertions(+), 34 deletions(-)

-- 
2.21.0

