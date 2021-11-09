Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B262644B147
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 17:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhKIQex (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Nov 2021 11:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhKIQex (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 11:34:53 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D9DC061764
        for <linux-api@vger.kernel.org>; Tue,  9 Nov 2021 08:32:06 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 1so37427992ljv.2
        for <linux-api@vger.kernel.org>; Tue, 09 Nov 2021 08:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/8dhRfwJVa4DbGul2wXDZMaW1G+0u9Zho02c+0fbvg=;
        b=i1zsHWvak0Z48bvXbSLAUT9qTUMXTZ/9dt4BWp0/Q5HLRsomYkzEeQm2ZeJhdLWGCv
         Gs9JaLDadSe+Zj5Jy3m5Y12u+A80/Qko0FnXeWbpwqvcxei2dfio3K6a0wLJi9PLR+MD
         tPFd57zm+C6gXyXBKIxRFhG6NL7YkBV+JXggQGswjgXIuhL0iMK82zv6Fa+lvA5iDu3d
         bJrm67+kGoOb7M0RqYvkhRgXePsjif9FZhUzQ0Tc34ssVGmWyMDFg+vPoG1ZWZETxPjj
         rX5ke2p7xfpXQDLbQyYyNXn7fR5Wwn6Gs8A9vp2kO1C/C0caI4YqRTvYHSQ7Qwt6ZoFL
         eH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/8dhRfwJVa4DbGul2wXDZMaW1G+0u9Zho02c+0fbvg=;
        b=ZeVHPETjjunXRShHsx14XRH/13DB5zK3FnvofEatxPK12VBuLgSSUt/Wotek4NpGnK
         YAv3QoUyWMtxw736HiBfEey68e4SKDlMz0Qi14vd2snJOJPNBCb+2LR2tA4h/gR8AY7s
         Xy7/06cyqUvsZjhiLWxqFrPDs2EHgH8mRX/b8F95HeUptyZj4Glxw1W7WHjb1wl5O5kH
         V6cj9gCJiiLwb151ItcFCMTyCAWbSIkfcNdmRh3iLHBvspa1D9cyILBvP8NsubPXy6px
         BEHg279qYCmBOWmDR/h1If5w1q83E5kiBWrHppG2aKTiP5+OSmGC2xUG54WfZzcpgbFm
         yGFw==
X-Gm-Message-State: AOAM530XQN0kpZfUcFB7xKHFcCHMIdaPuaagnZpMtuE64v4stliiOt7X
        mtDaRoVnJ9bMun6GDR0Sw3xWa1gWQDu6wk7Nlamifw==
X-Google-Smtp-Source: ABdhPJzlzPHziQ7RTqVxchkRg4XOW7Q7HSp1BAF/VSiFuVRmTDjCPXv+cBjfftIRsY+yBCXKUVkRTXptkfRPlKkrijM=
X-Received: by 2002:a05:651c:1101:: with SMTP id d1mr9135458ljo.373.1636475524928;
 Tue, 09 Nov 2021 08:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20211104195804.83240-1-posk@google.com> <CAGsJ_4xRcu1P9EV0-9GF00n7Cg0=0=NRQ8dj1EAe4OZotWWfbQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xRcu1P9EV0-9GF00n7Cg0=0=NRQ8dj1EAe4OZotWWfbQ@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 9 Nov 2021 08:31:53 -0800
Message-ID: <CAPNVh5eKO7sdEQpCo+YELhGE2koKiDatg-toaHjd4BfvZWUKXg@mail.gmail.com>
Subject: Re: [PATCH v0.8 0/6] sched,mm,x86/uaccess: implement User Managed
 Concurrency Groups
To:     Barry Song <21cnbao@gmail.com>
Cc:     posk@posk.io, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Barry,

[...]
>
> Do you have a real workload or an example application using UMCG?
>
[...]

A google-internal variant of UMCG kernel patches is used extensively
to enable user-space scheduling of heterogeneous work items. The main
use case is services that need to ensure user isolation; in addition,
latency vs throughput workloads served by the same service are also
well addressed by user-space schedulers.

For example, a DBMS needs to ensure that one "hungry" user does not
adversely affect other well-behaved users; but at the same time if the
overall load is relatively low, users are allowed to go ahead and
consume as much CPU as possible, as long as this does not affect other
users negatively.

Services that treat their work uniformly, and care only about raw
throughput, usually do not benefit from custom user-space scheduling
that UMCG, or similar, enables.

Thanks,
Peter
