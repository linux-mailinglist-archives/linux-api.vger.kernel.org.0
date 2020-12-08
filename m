Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0EF2D370D
	for <lists+linux-api@lfdr.de>; Wed,  9 Dec 2020 00:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgLHXlh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 8 Dec 2020 18:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbgLHXlg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 Dec 2020 18:41:36 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC204C061793
        for <linux-api@vger.kernel.org>; Tue,  8 Dec 2020 15:40:50 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id x23so249380lji.7
        for <linux-api@vger.kernel.org>; Tue, 08 Dec 2020 15:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiRldqdmzeS1Mv5WIXPh/peTbx9BtSi92k54Z67KE4M=;
        b=J8WFN1IBnvwJjf12CXxBMDGUB3Y35X5pWzS6o8L22oagYz7MBuIqKJ8M3+uxSnnwBm
         Qu19kBkNmE+C0LfknE96xiDXXmhtG+u8kyfhxt8dQ593nkLH3ITnJMkIWnK14JzgSBby
         DCJOmGaR1qXvUi9NfH0pd00gvvLN3R8OAMXFHW7RKsD945aTqQzk+FRpyxj5XmZ02K7b
         H0ggvh86gYSgUGmJ/tlOgvZWXLYkifZ+Pjzy8ucCtSVXYw+IQZZRqkNq9yMsqRYHmWYt
         9HJGf1WAYXzgov4yYFec1982+NIcdtZPBf8Sy/LRPsvlZ/P+y8WShE//ElA4TAFmLI+z
         ZzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiRldqdmzeS1Mv5WIXPh/peTbx9BtSi92k54Z67KE4M=;
        b=rSMOs+5Kz7qQxUcfjOc/Vgm/v3+6mLFq4HZtUL6XESfLjNLyVwI515YT8oRFLeOX82
         U6uEPUY3Tj/x2nHSR6ecExbwIXVun5uxgtiGHPclLaOqfOWI37ffI2i17Ie5VmHPsd4C
         JmvL1Jvpu2H/cnzk2FQCldRDgHbZbOLVf7d1Y5i7jLKH48hCMCPTMk4KV9mESiszyQQA
         tWyYKI++qwkagw4t8wWNIMJcqSfh2iNkts5knXukbnefl4W3ye8+REF6R9O1Z1WzbCb6
         YzlCnpDDtHcsgINRmUkgL4ApKBOWroH9vo3oM2PbuXzQZKSonwsZHX7hSU7AWFobFN8L
         hf0w==
X-Gm-Message-State: AOAM530r3qFTzdhksoOL0/v4kFDNDvy+lD1bPRY3IsPMEJfEnv/fbM2Q
        vsWrL8QQnKIl7jY7AJNa6RK9sss2t5k6HpGicbbwVA==
X-Google-Smtp-Source: ABdhPJzMw3FBB9dkB8UpPSjMu0vXES+Fd7QlsOOkEOw3dcInEyxdT6BtmJ4I838fJVgg/iRcwJCA3XFDJD8xaoO+mtg=
X-Received: by 2002:a2e:50c:: with SMTP id 12mr24546ljf.226.1607470848935;
 Tue, 08 Dec 2020 15:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-3-surenb@google.com>
In-Reply-To: <20201124053943.1684874-3-surenb@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 9 Dec 2020 00:40:22 +0100
Message-ID: <CAG48ez1M5tT=4T2RREhs1U3yMJH2N7HPWySBnMJyMSg0WtdD2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/madvise: add process_madvise MADV_DONTNEER support
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
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 6:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
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
> the process is running.
> In such situation it is desirable to be able to free up the memory of the
> process being killed in a more controlled way.
> Enable MADV_DONTNEED to be used with process_madvise when applied to a
> dying process to reclaim its memory. This would allow userspace system
> components like oomd and lmkd to free memory of the target process in
> a more predictable way.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
[...]
> @@ -1239,6 +1256,23 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>                 goto release_task;
>         }
>
> +       if (madvise_destructive(behavior)) {
> +               /* Allow destructive madvise only on a dying processes */
> +               if (!signal_group_exit(task->signal)) {
> +                       ret = -EINVAL;
> +                       goto release_mm;
> +               }

Technically Linux allows processes to share mm_struct without being in
the same thread group, so I'm not sure whether this check is good
enough? AFAICS the normal OOM killer deals with this case by letting
__oom_kill_process() always kill all tasks that share the mm_struct.
