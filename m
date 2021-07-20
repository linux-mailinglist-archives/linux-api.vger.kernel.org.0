Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6AC3D04F9
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 01:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhGTW0g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Jul 2021 18:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231383AbhGTW0f (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Jul 2021 18:26:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66BCC60FF1;
        Tue, 20 Jul 2021 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626822429;
        bh=D+HKV7Qkc7sSxCBQNnUhhfRNvjEt6FJcBnhHP5hS/nY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kb7hl2ImOGbKzf94U3gwMhsP1J/2jggr8YeHM0sT6BJedQzoCDzcqQNcWOSqOgVpY
         qAeUw6u43nwMqfylfw1t/9mNnubpXzfd+mItSWOQ/j1EcA5Y2QNVCJZtVOQgmtNoJ4
         KFMl6E+J4ag26/04AuvEINm0vx1WZja6LjLDJf84=
Date:   Tue, 20 Jul 2021 16:07:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, mhocko@kernel.org,
        mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, riel@surriel.com,
        minchan@kernel.org, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file
 to be used in process_mrelease
Message-Id: <20210720160707.2332738708948f7d865d67c1@linux-foundation.org>
In-Reply-To: <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
References: <20210718214134.2619099-1-surenb@google.com>
        <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 20 Jul 2021 14:43:52 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 18.07.21 23:41, Suren Baghdasaryan wrote:
> > process_mrelease needs to be added in the CONFIG_MMU-dependent block which
> > comes before __task_will_free_mem and task_will_free_mem. Move these
> > functions before this block so that new process_mrelease syscall can use
> > them.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > changes in v2:
> > - Fixed build error when CONFIG_MMU=n, reported by kernel test robot. This
> > required moving task_will_free_mem implemented in the first patch
> > - Renamed process_reap to process_mrelease, per majority of votes
> > - Replaced "dying process" with "process which was sent a SIGKILL signal" in
> > the manual page text, per Florian Weimer
> > - Added ERRORS section in the manual page text
> > - Resolved conflicts in syscall numbers caused by the new memfd_secret syscall
> > - Separated boilerplate code wiring-up the new syscall into a separate patch
> > to facilitate the review process
> > 
> >   mm/oom_kill.c | 150 +++++++++++++++++++++++++-------------------------
> >   1 file changed, 75 insertions(+), 75 deletions(-)
> 
> TBH, I really dislike this move as it makes git blame a lot harder with 
> any real benefit.
> 
> Can't you just use prototypes to avoid the move for now in patch #2?
> 
> static bool task_will_free_mem(struct task_struct *task);

This change makes the code better - it's silly to be adding forward
declarations just because the functions are in the wrong place.

If that messes up git-blame then let's come up with better tooling
rather than suffering poorer kernel code because the tools aren't doing
what we want of them.  Surely?
