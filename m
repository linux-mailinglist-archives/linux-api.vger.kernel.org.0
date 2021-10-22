Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2543714F
	for <lists+linux-api@lfdr.de>; Fri, 22 Oct 2021 07:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhJVFZi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Oct 2021 01:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhJVFZi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Oct 2021 01:25:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E839C061766
        for <linux-api@vger.kernel.org>; Thu, 21 Oct 2021 22:23:21 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v200so4271754ybe.11
        for <linux-api@vger.kernel.org>; Thu, 21 Oct 2021 22:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/K7g7u2ztiiMpfLD3ufFGiu7hRc5OC0Hi+SvzjKN4Uk=;
        b=ly0FbEE9Cx2o0m+sLygjae/WePo6aZBdJEycwr+AxFGMCElMOUSKMnm3dNn6yydnFD
         IeCJVcOc0fhI8EOODak6bDjP5jmdEdrwK9klZmCv393MLULV2izorxk+R2zF2uUMOSTI
         6YHAOGEZWpBJ9UmRlHOot/gSWeRJezJYsWzq/3+5475yi8MeNEd4eKZgk1u2VnuCmxT+
         bR7iVcEuthyMWB1WNLejEWG+ylqhYCQUMq61fWB6+Tjz9iTbNOzbcTRjjMaGHPnqRnZY
         TEbIS3zdaAYvypoQ0D+jKp9Fgb6/OrurOSihIUF7xWw5s/3kX+Ywf9jM36iNmm+c8zxg
         JJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/K7g7u2ztiiMpfLD3ufFGiu7hRc5OC0Hi+SvzjKN4Uk=;
        b=uvu4EO65H4thi1fek6a40Jq1s9A5VWsRQmUC5gZWmvNDR7pibacUnaA5tLitHiZmJp
         BVrEVmodBCp30pFevd/oBQv2nKitr0RJpKEDInpeufB2M5jk+AYXseU6Kyu+SBmg6/gd
         IBIzjD4ZdM8CiDVgZp6xYW/+iViH03jeVcKDR52Sz92M0u2sU4QjbV/bOa3UmKCavWEn
         yWcegvBvdHrJaTFVgcR8dVcGAk/2/n3wPKE1z9xNZ7FFsTQCygUuENbdNIcMno6PETrt
         QS8A3lDI4uLX3f2ftrNZ5k5n4xGLNM0k7wjcrUhk1RXIRg6n7AuiwBtEXTGuowlRm0Ji
         vdNg==
X-Gm-Message-State: AOAM532rIRoFEdkysrEepB9QFXIWP3/2NuctGj0vPsGgk7p2eyMqWHE/
        VRGrwzJu3r/kVSzkZPthHNbVTCREqK/N65MVBev0Eg==
X-Google-Smtp-Source: ABdhPJyxZCUyr4sMHK+JfeiRtzhmYvXjKxyFRS/5VnhxOej5AiUTE/+OV68+Q8FkKKW+Dxu+8ENslNiFqTzqpBJ17+w=
X-Received: by 2002:a25:d1d3:: with SMTP id i202mr11392808ybg.487.1634880200329;
 Thu, 21 Oct 2021 22:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <20211021192454.72ada9b3d59460cc3c037d2c@linux-foundation.org>
In-Reply-To: <20211021192454.72ada9b3d59460cc3c037d2c@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 21 Oct 2021 22:23:09 -0700
Message-ID: <CAJuCfpEcvuYu5OhXMVz5g4OK+-a_jnF9MNtu17VP5V23r2oWtw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>,
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
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 21, 2021 at 7:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 21 Oct 2021 18:46:58 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Race between process_mrelease and exit_mmap, where free_pgtables is
> > called while __oom_reap_task_mm is in progress, leads to kernel crash
> > during pte_offset_map_lock call. oom-reaper avoids this race by setting
> > MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> > mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> > Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> > fix this race, however that would be considered a hack. Fix this race
> > by elevating mm->mm_users and preventing exit_mmap from executing until
> > process_mrelease is finished. Patch slightly refactors the code to adapt
> > for a possible mmget_not_zero failure.
> > This fix has considerable negative impact on process_mrelease performance
> > and will likely need later optimization.
>
> Has the impact been quantified?

A ball-park figure for a large process (6GB) it takes 4x times longer
for process_mrelease to exit.

>
> And where's the added cost happening?  The changes all look quite
> lightweight?

I think it's caused by the fact that exit_mmap and all other cleanup
routines happening on the last mmput are postponed until
process_mrelease finishes __oom_reap_task_mm and drops mm->mm_users. I
suspect all that cleanup is happening at the end of process_mrelease
now and that might be contributing to the regression. I didn't have
time yet to fully understand all the reasons for that regression but
wanted to fix the crash first. Will proceed with more investigation
and hopefully with a quick fix for the lost performance.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
