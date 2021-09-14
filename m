Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E021040B579
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 18:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhINQ7R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhINQ7Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 12:59:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2FC061762
        for <linux-api@vger.kernel.org>; Tue, 14 Sep 2021 09:57:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o11so17698943ljp.8
        for <linux-api@vger.kernel.org>; Tue, 14 Sep 2021 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqQSMJ8RTVDNrryIulJY4YULkRA8eJdXQSnIYvRutRM=;
        b=bOyzoS6TBDReuHrgJ73iE7TVyyReZIJ23lD6wghw6vtmD+J/kmrNOL66GQYOZbGyn7
         iao01Np6tfD4fXrcNrsZrxBOr/kZX5yIUbmdB+WYDiu0fdw8WROJMqUheZBabwzRdzJc
         S3yRwWcdOIGT+DzwYKmX2UxKzOm/KZEdkUs05mHhxgTb7tT8S+PggPMcaJOWr8QkQVZp
         2Qf9lB+UKDuSz5Wjgt4QRgUgbvRbbZKpsTTT+Lqz04aeMN2mR0MNc4AdjPddJkHMDA/e
         cgtcfH+3u7tLbNezP8DCYXLw9I8RjlsQpv2s/843ZPjaMNl65AkJE4DHLWqd15d9ysK7
         mPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqQSMJ8RTVDNrryIulJY4YULkRA8eJdXQSnIYvRutRM=;
        b=5URcEsBA6Jyxz/saMvB6YcVXjlaKlADiFhycy/4HQsRtvzR+tO5c8Y97R1jMod+uUz
         1inwaSCmjY38IuZlaD6TEPB/s4mvSlrM+9LHHVLsTEH16nPo712XJ5tHkQosafzPVRFV
         0N/fKz9TlU2WNnOkcbIBHDse9SeKgQjCWRUfiJz8hzQwdEXcs2LqcCBneaGR2wJAMvGC
         J2m4GZCM8gYssOrPE95Oag/RyFz6j/3AhcWsVX1MD7+OM2B8Ojs4JFNvTvWPuJTXHQb0
         jn2Gwss1DtcgAe+RxEYkQBPgExtAilGNcemw/9rcXmmFsBr1sSonQO24MN6evrYq19SA
         HV8Q==
X-Gm-Message-State: AOAM530w9iSkYUP4AfbFfWtjy4986UnDXKVhEJULVmhDDABsAS7fd4et
        TTPtdBgrDP0FH7/sA+7asZbo+ChmiXC+tcD2G/cqmA==
X-Google-Smtp-Source: ABdhPJysNsvUDtxy30q4rx85+AbNCPtjDAx3HsUEPIj+nSsSwNY/e2GbTq6iwD8+O1eU5K92Jipb2fb7C5+7NUhYswM=
X-Received: by 2002:a2e:900c:: with SMTP id h12mr16782693ljg.263.1631638677287;
 Tue, 14 Sep 2021 09:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-5-posk@google.com>
 <YUDPWnsLRoU8StFi@geo.homenetwork>
In-Reply-To: <YUDPWnsLRoU8StFi@geo.homenetwork>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 14 Sep 2021 09:57:46 -0700
Message-ID: <CAPNVh5eY68FSWEFwQuqN69rx2gvAn6T04SvV6MA=uEhtdy-Uyw@mail.gmail.com>
Subject: Re: [PATCH 4/4 v0.5] sched/umcg: add Documentation/userspace-api/umcg.rst
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 14, 2021 at 9:34 AM Tao Zhou <tao.zhou@linux.dev> wrote:

[...]

> > +- worker to worker context switch:
> > +  ``W1:RUNNING+W2:IDLE => W1:IDLE+W2:RUNNING``:
> > +
> > +  - in the userspace, in the context of W1 running:
> > +
> > +    - ``W2:IDLE => W2:RUNNING|LOCKED`` (mark W2 as running)
> > +    - ``W1:RUNNING => W1:IDLE|LOCKED`` (mark self as idle)
> > +    - ``W2.next_tid := W1.next_tid; S.next_tid := W2.next_tid``
>                                                         ^^^^^^^^
> W2.next_tid is a server. S.next_tid should be a worker; say:
>
>   S.next_tid := W2.tid

You are definitely right here. I'll fix the doc in the next patchset.
