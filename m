Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81763436FEC
	for <lists+linux-api@lfdr.de>; Fri, 22 Oct 2021 04:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhJVC1Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Oct 2021 22:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhJVC1Q (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 21 Oct 2021 22:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A004360551;
        Fri, 22 Oct 2021 02:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634869499;
        bh=ba3gyIn2Qaclz/r/YcqNfTvZdQP29SgCT1X+NCF/gLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xlKO7/DGTNQ44ucClRz9f14c2t0IN5jZj2/SBtx+IgXvkDCj3wXOXzOrF152/Y8n9
         Mjvo3ezH0mryi0MeclaXi4j34fgfeoL7dbF0Dw7Gz2WfUZN9icZv26BHrjpylr5Fah
         1tgSHLAr6MPLBpwFxtrSfdbznmzYtwXpFZ5w1SlE=
Date:   Thu, 21 Oct 2021 19:24:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and
 exit_mmap
Message-Id: <20211021192454.72ada9b3d59460cc3c037d2c@linux-foundation.org>
In-Reply-To: <20211022014658.263508-1-surenb@google.com>
References: <20211022014658.263508-1-surenb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 21 Oct 2021 18:46:58 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Race between process_mrelease and exit_mmap, where free_pgtables is
> called while __oom_reap_task_mm is in progress, leads to kernel crash
> during pte_offset_map_lock call. oom-reaper avoids this race by setting
> MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> fix this race, however that would be considered a hack. Fix this race
> by elevating mm->mm_users and preventing exit_mmap from executing until
> process_mrelease is finished. Patch slightly refactors the code to adapt
> for a possible mmget_not_zero failure.
> This fix has considerable negative impact on process_mrelease performance
> and will likely need later optimization.

Has the impact been quantified?

And where's the added cost happening?  The changes all look quite
lightweight?

