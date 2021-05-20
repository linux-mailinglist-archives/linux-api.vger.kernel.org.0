Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2538B90C
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 23:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhETVkM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 17:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhETVkL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 17:40:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBC8C061761
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 14:38:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a4so6792763ljd.5
        for <linux-api@vger.kernel.org>; Thu, 20 May 2021 14:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goseYwTkzgMm+FX+KCZopTYXh0tzEbkX4x36YfbUrsw=;
        b=EC5etK9i7fAPFZR2RrpV8bzGlnP0ytGmzkd7hkYjxPqb1E/JJAtuQXFeMofPFRcDHW
         TPq5jkxO+jZnj7CC1E/kNocAD+1S0fRowDF0LOnTYbhWVPj7S/wIHTf5MfZSrbMqb+8p
         4qoW9Fdgfss9Ruo6qfzHavqNe3aOeNjWyvu97aGzHVeVaIETa/yJYwkx7Qfahm1KLOes
         NAUoGN1pybuE2UD7uuvQg6kQSxAUZ15V/0yAF8iqs/0ntH2olPZfBXvvzNhuPw8d4LD5
         NWHpRb5OLMzCj8bb0YO1Wg8JXFcYByxSxl/kQDPA12IilD+EdlLjl9qL1m5nwLQEDAgJ
         8gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goseYwTkzgMm+FX+KCZopTYXh0tzEbkX4x36YfbUrsw=;
        b=GlHH9h9jHnVNqkod76CZCjmzGXbyrdaJVeQ35D1gIWDrUhMtQfXn1NJy1eraUx9BX1
         0YuC1RLUvfw5YcxcGSWIxcJzq8T73UVj1gZXm3/0o8BZrkDiBihxrPwmjHJ7kgkRe3C0
         7YtDpWGcilRaRaD6fMk1tRFc7LjooSnQebo5uji2Kgr4J+Krq9YvzBmRjLdvh4/BMeb8
         1HCKydPWlGZwOBsqeQnpZ1VRYNWTOh2YoIKGe38VEcpGe1XrEMt8E+Jw7WK+LGg4mrQV
         9UXWG2UlfWdYSBJvcM9Ccl0NlPhnjM1wQc3VPvpdksXAL9e3rzW79yiMNLyUMznnIGrW
         g6Gg==
X-Gm-Message-State: AOAM533VPM0pgymkk3zGC+0xctEucFcwNGCoDfXGcKVhW0Oagd7xt29y
        J/eD01U2eZ1YtLZ4NbuMCNZfXvxYEOpFaYgNcvrGwA==
X-Google-Smtp-Source: ABdhPJzwMrDBwob6pN+S2ilFdQh5N8EphMYiUtNUox7/axVceZ5jIphVm7b3994vHgkqA+TwbzuLpeYT6O39l9e/IaM=
X-Received: by 2002:a2e:a54d:: with SMTP id e13mr2982312ljn.266.1621546725312;
 Thu, 20 May 2021 14:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <87mtspm7fe.fsf@meer.lwn.net>
In-Reply-To: <87mtspm7fe.fsf@meer.lwn.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 20 May 2021 14:38:33 -0700
Message-ID: <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 2:17 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Peter Oskolkov <posk@google.com> writes:
>
> > As indicated earlier in the FUTEX_SWAP patchset:
> >
> > https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/
> >
> > "Google Fibers" is a userspace scheduling framework
> > used widely and successfully at Google to improve in-process workload
> > isolation and response latencies. We are working on open-sourcing
> > this framework, and UMCG (User-Managed Concurrency Groups) kernel
> > patches are intended as the foundation of this.
>
> So I have to ask...is there *any* documentation out there on what this
> is and how people are supposed to use it?  Shockingly, typing "Google
> fibers" into Google leads to a less than fully joyful outcome...  This
> won't be easy for anybody to review if they have to start by
> reverse-engineering what it's supposed to do.

Hi Jonathan,

There is this Linux Plumbers video: https://www.youtube.com/watch?v=KXuZi9aeGTw
And the pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf

I did not reference them in the patchset because links to sites other
than kernel.org are strongly discouraged... I will definitely add a
documentation patch.

Feel free to reach out to me directly or through this LKML thread if
you have any questions.

Do you think a documentation patch would be useful at this point, as
opposed to a free-form email discussion?

Thanks,
Peter

>
> Thanks,
>
> jon
