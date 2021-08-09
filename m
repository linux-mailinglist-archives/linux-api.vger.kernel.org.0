Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A163E4899
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 17:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhHIPYT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhHIPYS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Aug 2021 11:24:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6EC061796
        for <linux-api@vger.kernel.org>; Mon,  9 Aug 2021 08:23:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m18so12912352ljo.1
        for <linux-api@vger.kernel.org>; Mon, 09 Aug 2021 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOzOKLELKEmWDNWHZODHt+66wBkXvfqlLeJRQn5bKh8=;
        b=EsSKEKNSguHCWHnNaZXAJdSFK+muDoE4BRpOTsq/R4/U7d6viU8oHOY08g+H9XSTcz
         0wc/4lAgmUsOV5wd0U48asPK9rfqwhO7bh4C3u2W6A5RScfRPmDmxweMPTWVGDRxDJX1
         YaXh2OOpWUoLtaoWDs9ePT6APQF6sDGeTEDPUSsSOpgFX7gcULCNVaOvqPSic0kXuBVb
         cEmjQSPaMGWtDpB/0pzWdklu953XFATM76RYUZVGJW8K8yJWphRAJ5Xwp/e5E1F/gxnq
         xnJDdsU1LsRlo/mAb/Qydj/IMZwbvzdIz7qcV7dX9bs6Ro99ElOM7Rg0WPXjlwYcyJhh
         NzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOzOKLELKEmWDNWHZODHt+66wBkXvfqlLeJRQn5bKh8=;
        b=HKuV3K5b1uVQYZ9Sh0y/YsLdUX2/E63g7BBnnglOivYtB0vEo4KEw/YvUz/GbHuavi
         YYlXjVsjrXgq0V9tUJ0+4tbdHpTwXw66tMlZlVbCmlW0Is21gZBe4MHILjXgetqW/PUD
         bee7YMqDsEMi5WymVdhi2uMEQkUHyvhFDhmcYM4G5atSBNKuuPoa7J69DaXYwASd9dmN
         Po1Vj5aDgvUIDt4GQPkVelIDPTD49L4FpkRpE6ZoqGVcYyAeUeChIEKWKrhRR0kjgP2J
         WWCzV6P2qMd64GFeSP8nMPMgqye1SOiodUdMVkni+xV190fFJtlvDJIqigupWZqMthxT
         XV0A==
X-Gm-Message-State: AOAM531upitV4P3iaV1CC9x8rl86eXD5TljzAEORLmNnnoIJKRTLu26y
        iJf2KfjEPWZEdrw+QS5Z5HgP5FpwmV8imbxoaPDKGg==
X-Google-Smtp-Source: ABdhPJz1Oe8RmLDeLve77AVbZ54H0TlwHpN0ZXkWDqLj5dCZXTF/CIiUalaGdYAimMOzE6jYQOhglk8Brgg8pM7Zf3Q=
X-Received: by 2002:a2e:9954:: with SMTP id r20mr5466500ljj.81.1628522635579;
 Mon, 09 Aug 2021 08:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210808160823.3553954-1-surenb@google.com>
In-Reply-To: <20210808160823.3553954-1-surenb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 9 Aug 2021 08:23:44 -0700
Message-ID: <CALvZod7cgW_-4GUi6__SoaQaha=DvNRbu-n-CGMvc4hFHvv_cA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Aug 8, 2021 at 9:08 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> In modern systems it's not unusual to have a system component monitoring
> memory conditions of the system and tasked with keeping system memory
> pressure under control. One way to accomplish that is to kill
> non-essential processes to free up memory for more important ones.
> Examples of this are Facebook's OOM killer daemon called oomd and
> Android's low memory killer daemon called lmkd.
> For such system component it's important to be able to free memory
> quickly and efficiently. Unfortunately the time process takes to free
> up its memory after receiving a SIGKILL might vary based on the state
> of the process (uninterruptible sleep), size and OPP level of the core
> the process is running. A mechanism to free resources of the target
> process in a more predictable way would improve system's ability to
> control its memory pressure.
> Introduce process_mrelease system call that releases memory of a dying
> process from the context of the caller. This way the memory is freed in
> a more controllable way with CPU affinity and priority of the caller.
> The workload of freeing the memory will also be charged to the caller.
> The operation is allowed only on a dying process.
>
> After previous discussions [1, 2, 3] the decision was made [4] to introduce
> a dedicated system call to cover this use case.
>
> The API is as follows,
>
>           int process_mrelease(int pidfd, unsigned int flags);
>
>         DESCRIPTION
>           The process_mrelease() system call is used to free the memory of
>           an exiting process.
>
>           The pidfd selects the process referred to by the PID file
>           descriptor.
>           (See pidfd_open(2) for further information)
>
>           The flags argument is reserved for future use; currently, this
>           argument must be specified as 0.
>
>         RETURN VALUE
>           On success, process_mrelease() returns 0. On error, -1 is
>           returned and errno is set to indicate the error.
>
>         ERRORS
>           EBADF  pidfd is not a valid PID file descriptor.
>
>           EAGAIN Failed to release part of the address space.
>
>           EINTR  The call was interrupted by a signal; see signal(7).
>
>           EINVAL flags is not 0.
>
>           EINVAL The memory of the task cannot be released because the
>                  process is not exiting, the address space is shared
>                  with another live process or there is a core dump in
>                  progress.
>
>           ENOSYS This system call is not supported, for example, without
>                  MMU support built into Linux.
>
>           ESRCH  The target process does not exist (i.e., it has terminated
>                  and been waited on).
>
> [1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
> [2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
> [3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
> [4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
