Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170B01D8B72
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 01:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgERXG6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 19:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgERXG6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 18 May 2020 19:06:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E43932067D;
        Mon, 18 May 2020 23:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589843217;
        bh=PK1V3Ku0yGM4DEfZQJfpSkYoFD5xqA30biO82kKQTyg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H3Y3A6nQEoHkOSbZz1IrzxA67bJtW3EK2PrUX2dvj+WcPFfXeeeFLSiDIsjqFM2+6
         AoDFaDumm3o0hqXzWlR6moqQ94rO4UInBdKG+B6B2IL0f+9vqeGfN3n21meA/awxfW
         5c6b+85KxidUgz4birZgOy7bjh/654owYJ42QtPE=
Date:   Mon, 18 May 2020 16:06:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sjpark@amazon.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH] mm: use only pidfd for process_madvise syscall
Message-Id: <20200518160656.b9651ef7393db8e0614a1175@linux-foundation.org>
In-Reply-To: <20200518211350.GA50295@google.com>
References: <20200516012055.126205-1-minchan@kernel.org>
        <CAJuCfpGbPUpWLDgwt5ZP4Uf8fp6ht_6eqUypMVYYh3btJdz_8Q@mail.gmail.com>
        <20200518211350.GA50295@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 18 May 2020 14:13:50 -0700 Minchan Kim <minchan@kernel.org> wrote:

> Andrew, I sent this patch without folding into previous syscall introducing
> patches because it could be arguable. If you want to fold it into each
> patchset(i.e., introdcuing process_madvise syscall and introducing
> compat_syscall), let me know it. I will send partial diff to each
> patchset.

It doesn't seem necessary - I believe we'll get a clean result if I
squish all of these:

mm-support-vector-address-ranges-for-process_madvise-fix.patch
mm-support-vector-address-ranges-for-process_madvise-fix-fix.patch
mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix.patch
mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix-fix.patch
mm-support-vector-address-ranges-for-process_madvise-fix-fix-fix-fix-fix.patch
mm-use-only-pidfd-for-process_madvise-syscall.patch

into mm-support-vector-address-ranges-for-process_madvise.patch and
make the appropriate changelog adjustments?

