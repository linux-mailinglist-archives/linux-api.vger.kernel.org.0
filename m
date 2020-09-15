Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938D7269A9B
	for <lists+linux-api@lfdr.de>; Tue, 15 Sep 2020 02:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIOAoN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Sep 2020 20:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOAoM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Sep 2020 20:44:12 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED008C06174A
        for <linux-api@vger.kernel.org>; Mon, 14 Sep 2020 17:44:10 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z46so455133uac.13
        for <linux-api@vger.kernel.org>; Mon, 14 Sep 2020 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BoSlPGs10Ah7Ip1us1heQdTTSl7SgyITEYcV+Lqb3hY=;
        b=QwuTsUtXEVEQEtd5CP6AH1XNi03owaessppVcj6SJH0eQrzxs+Xrkrs/qHcRUrUIzN
         MbCJv0zJIPb+qZ9P7WBPB1x19A4EmP5nqLw40DclOPEckOKMyM0POkHD7PN+F9oOcSEW
         JDeMvdZZoPpicsCp7OlfuAbXYXqzXrzZToXVDXjC3FtPmjjFG7FgTBfkcxLuacyEaibw
         ZmpdUdIPBszGbU49OLOFRpExw5nP9gVOR+J7udmnGKo/a+vEkJdrMxqQLrwYEeEEDCD6
         wi+VKGhfe7+uZodGRRmlNqNyjijd6v2hXofW5F3qGSaEJDrk883KnUbMD62IjM1xHyq7
         jGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BoSlPGs10Ah7Ip1us1heQdTTSl7SgyITEYcV+Lqb3hY=;
        b=QfBu0/y1ttJihGCioEm1fKl7WEra9BUzsZnzKWVB0WOCOY8BGw6i2L2D/ZPljN+LXD
         i1MEpQxWLTgZ4C6BF+tX5wllzmLMG7TeZAf/wYyfEAkcRCOu7t0TmTKvfOHRIvdY2GTq
         Y3Jm7aGKQ3lyfkhGljPJ3Ia0x4eUtHxA+VXLAIWUljKbTBhuF1Zk1ZfJuIETE0c0ppks
         JDw93epn418M7BzO3zoQTWD6mHuBP6GEHzKojnmEcMdBlfu2W8SsOC7KdZTn+9y5KRJC
         ENpan5vVF8zdDnmYUT9wBuAtv/5MS1fdl05On2kFMaBg2ZLdfDgcFzqKAGwQUfPlTa/3
         fBJg==
X-Gm-Message-State: AOAM531NNz+GzrvF07/pN/m23joF4RpV2DOVILvI6+XRKFAvgWgvf0YC
        WZEPviK4Am3KchgNLTcstvKuomEGEaY6tppQ4ZXjpobPHiBUbx3u
X-Google-Smtp-Source: ABdhPJzLd5XT4Z6UjFNpFE2MstW6cSFyWufD3+ryPMHs8eeaF61LZuLpoS+zQE8ITWJN2v3pyWv3CyoHocnfA6Wj8h4=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr8179288uas.86.1600130649381;
 Mon, 14 Sep 2020 17:44:09 -0700 (PDT)
MIME-Version: 1.0
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 14 Sep 2020 17:43:58 -0700
Message-ID: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
Subject: [RFC]: userspace memory reaping
To:     linux-api@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Last year I sent an RFC about using oom-reaper while killing a
process: https://patchwork.kernel.org/cover/10894999. During LSFMM2019
discussion https://lwn.net/Articles/787217 a couple of alternative
options were discussed with the most promising one (outlined in the
last paragraph of https://lwn.net/Articles/787217) suggesting to use a
remote version of madvise(MADV_DONTNEED) operation to force memory
reclaim of a killed process. With process_madvise() making its way
through reviews (https://patchwork.kernel.org/patch/11747133/), I
would like to revive this discussion and get feedback on several
possible options, their pros and cons.

The need is similar to why oom-reaper was introduced - when a process
is being killed to free memory we want to make sure memory is freed
even if the victim is in uninterruptible sleep or is busy and reaction
to SIGKILL is delayed by an unpredictable amount of time. I
experimented with enabling process_madvise(MADV_DONTNEED) operation
and using it to force memory reclaim of the target process after
sending SIGKILL. Unfortunately this approach requires the caller to
read proc/pid/maps to extract the list of VMAs to pass as an input to
process_madvise(). This is a time consuming operation. I measured
times similar to what Minchan indicated in
https://lore.kernel.org/linux-mm/20190528032632.GF6879@google.com/ and
the reason reading proc/pid/maps consumes that much time is the number
of read syscalls required to read this file. proc/pid/maps file, being
a seq_file, can be read in chunks of up to 4096 bytes (1 page). Even
if userspace provides bigger buffer, only up to 4096 bytes will be
read with one syscall. Measured on Qualcomm=C2=AE Snapdragon 855=E2=84=A2 u=
sing its
Big core of 2.84GHz a single read syscall takes between 50 and 200us
(in case there was no contention on mmap_sem or some other lock during
the syscall). Taking one typical example from my tests, a 219232 bytes
long proc/pid/maps file describing 1623 VMAs required 55 read
syscalls. With mmap_sem contention proc/pid/maps read can take even
longer. In my tests I measured typical delays of 3-7ms with occasional
delays of up to 20ms when a read syscall was blocked and the process
got into uninterruptible sleep.

While the objective is to guarantee forward progress even when the
victim cannot terminate, we still want this mechanism to be efficient
because we perform these operations to relieve memory pressure before
it affects user experience.

Alternative options I would like your feedback are:
1. Introduce a dedicated process_madvise(MADV_DONTNEED_MM)
specifically for this case to indicate that the whole mm can be freed.
2. A new syscall to efficiently obtain a vector of VMAs (start,
length, flags) of the process instead of reading /proc/pid/maps. The
size of the vector is still limited by UIO_MAXIOV (1024), so several
calls might be needed to query larger number of VMAs, however it will
still be an order of magnitude more efficient than reading
/proc/pid/maps file in 4K or smaller chunks.
3. Use process_madvise() flags parameter to indicate a bulk operation
which ignores input vectors. Sample usage: process_madvise(pidfd,
MADV_DONTNEED, vector=3DNULL, vlen=3D0, flags=3DPMADV_FLAG_FILE |
PMADV_FLAG_ANON);
4. madvise()/process_madvise() handle gaps between VMAs, so we could
provide one vector element spanning the entire address space. There
are technical issues with this approach (process_madvise return value
can't handle such a large number of bytes and there is MAX_RW_COUNT
limit on max number of bytes one process_madvise call can handle) but
I would still like to hear opinions about it. If this option is
preferable maybe we can deal with these limitations.

We can also go back to reclaiming victim's memory asynchronously but
synchronous method has the following advantages:
- reaping will be performed in the caller's context and therefore with
caller's priority, CPU affinity, CPU bandwidth, reaping workload will
be charged to the caller and accounted for.
- reaping is a blocking/synchronous operation for the caller, so when
it's finished, the caller can be sure mm is freed (or almost freed
considering lazy freeing and batching mechanisms) and it can reassess
the memory conditions right away.
- for very large MMs (not really my case) caller could split the VMA
vector and perform reaping from multiple threads to make it faster.
This would not be possible with options (1) and (3).

Would really appreciate your feedback on these options for future developme=
nt.
Thanks,
Suren.
