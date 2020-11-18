Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1782B7B65
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgKRKcw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 05:32:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53174 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgKRKcw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 05:32:52 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kfKlV-0005RK-Iu; Wed, 18 Nov 2020 10:32:41 +0000
Date:   Wed, 18 Nov 2020 11:32:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, mhocko@kernel.org,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        christian@brauner.io, oleg@redhat.com, timmurray@google.com,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
Message-ID: <20201118103240.hnggudihd3xmqty5@wittgenstein>
References: <20201113173448.1863419-1-surenb@google.com>
 <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 13, 2020 at 03:55:39PM -0800, Andrew Morton wrote:
> On Fri, 13 Nov 2020 09:34:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > When a process is being killed it might be in an uninterruptible sleep
> > which leads to an unpredictable delay in its memory reclaim. In low memory
> > situations, when it's important to free up memory quickly, such delay is
> > problematic. Kernel solves this problem with oom-reaper thread which
> > performs memory reclaim even when the victim process is not runnable.
> > Userspace currently lacks such mechanisms and the need and potential
> > solutions were discussed before (see links below).
> > This patch provides a mechanism to perform memory reclaim in the context
> > of the process that sends SIGKILL signal. New SYNC_REAP_MM flag for
> > pidfd_send_signal syscall can be used only when sending SIGKILL signal
> > and will lead to the caller synchronously reclaiming the memory that
> > belongs to the victim and can be easily reclaimed.
> 
> hm.
> 
> Seems to me that the ability to reap another process's memory is a
> generally useful one, and that it should not be tied to delivering a
> signal in this fashion.

I agree and I see you've already had some good ideas how to tie this to
process_madvise(). If that's workable for your use-case then I'd prefer
that approach. Signals are almost always not a great choice.

Christian
