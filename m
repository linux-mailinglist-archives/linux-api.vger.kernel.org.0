Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819972B2A45
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 02:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKNBAd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 20:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgKNBAd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Nov 2020 20:00:33 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B722225F;
        Sat, 14 Nov 2020 01:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605315633;
        bh=/g7VQTTa1MhzguD8LwMNerwXJbi3XB+cIOKhHOWMcO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RkdLIHRy00PiLjpLjMf210/PYhk/Mjjz9QcRHH2kCLyY8Tz6AufKfUpPmDC0bfuVE
         ObPyMBd7XxObOgs22n62k4vYl+j/8Wg2mHozQrU0OOOhf0AjAoWMnZHeyHp+trds70
         GlCoEodkx2jpsibyxM6udYH1U41wDg97rKy3WP+Y=
Date:   Fri, 13 Nov 2020 17:00:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
Message-Id: <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
In-Reply-To: <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
References: <20201113173448.1863419-1-surenb@google.com>
        <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
        <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 13 Nov 2020 16:06:25 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Fri, Nov 13, 2020 at 3:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 13 Nov 2020 09:34:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > When a process is being killed it might be in an uninterruptible sleep
> > > which leads to an unpredictable delay in its memory reclaim. In low memory
> > > situations, when it's important to free up memory quickly, such delay is
> > > problematic. Kernel solves this problem with oom-reaper thread which
> > > performs memory reclaim even when the victim process is not runnable.
> > > Userspace currently lacks such mechanisms and the need and potential
> > > solutions were discussed before (see links below).
> > > This patch provides a mechanism to perform memory reclaim in the context
> > > of the process that sends SIGKILL signal. New SYNC_REAP_MM flag for
> > > pidfd_send_signal syscall can be used only when sending SIGKILL signal
> > > and will lead to the caller synchronously reclaiming the memory that
> > > belongs to the victim and can be easily reclaimed.
> >
> > hm.
> >
> > Seems to me that the ability to reap another process's memory is a
> > generally useful one, and that it should not be tied to delivering a
> > signal in this fashion.
> >
> > And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
> > few changes and tweaks, but can't that be used to solve this problem?
> 
> Thank you for the feedback, Andrew. process_madvise(MADV_DONTNEED) was
> one of the options recently discussed in
> https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> . The thread describes some of the issues with that approach but if we
> limit it to processes with pending SIGKILL only then I think that
> would be doable.

Why would it be necessary to read /proc/pid/maps?  I'd have thought
that a starting effort would be

	madvise((void *)0, (void *)-1, MADV_PAGEOUT)

(after translation into process_madvise() speak).  Which is equivalent
to the proposed process_madvise(MADV_DONTNEED_MM)?

There may be things which trip this up, such as mlocked regions or
whatever, but we could add another madvise `advice' mode to handle
this?
