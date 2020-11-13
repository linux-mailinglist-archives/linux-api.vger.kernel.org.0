Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B832B2965
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 00:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKMXzl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 18:55:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMXzl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Nov 2020 18:55:41 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A1120B80;
        Fri, 13 Nov 2020 23:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605311740;
        bh=Mh4yXLMcmZQt7AZnvC9pTq+YtBQJCLQlTJ6Hv2pRFNs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNoww2mH/7yh/oHYpz+Udrp4ex+Q74+w8jiJQDU4dVn3K2hg5gYJvbS2kOaYF/23C
         +PYWS6Yn2GH5pNQtu9u+G9TEXK2lGPqwp/vfmqN+k3AHGcdk+rPr+opX+YznNF8/bF
         OUjZ3RbCIj/XgQO43GcSiEYmIcvDL26r36p64Bas=
Date:   Fri, 13 Nov 2020 15:55:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@kernel.org, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, riel@surriel.com,
        minchan@kernel.org, christian@brauner.io, oleg@redhat.com,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
Message-Id: <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
In-Reply-To: <20201113173448.1863419-1-surenb@google.com>
References: <20201113173448.1863419-1-surenb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 13 Nov 2020 09:34:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> When a process is being killed it might be in an uninterruptible sleep
> which leads to an unpredictable delay in its memory reclaim. In low memory
> situations, when it's important to free up memory quickly, such delay is
> problematic. Kernel solves this problem with oom-reaper thread which
> performs memory reclaim even when the victim process is not runnable.
> Userspace currently lacks such mechanisms and the need and potential
> solutions were discussed before (see links below).
> This patch provides a mechanism to perform memory reclaim in the context
> of the process that sends SIGKILL signal. New SYNC_REAP_MM flag for
> pidfd_send_signal syscall can be used only when sending SIGKILL signal
> and will lead to the caller synchronously reclaiming the memory that
> belongs to the victim and can be easily reclaimed.

hm.

Seems to me that the ability to reap another process's memory is a
generally useful one, and that it should not be tied to delivering a
signal in this fashion.

And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
few changes and tweaks, but can't that be used to solve this problem?

