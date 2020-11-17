Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984082B6DF5
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 19:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgKQS7D (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 13:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgKQS7D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 13:59:03 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EBDC0617A6
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 10:59:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a9so30591753lfh.2
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODbhvfMwQphzH4jjj2dKI3GxI6ydVmCWEWjM7c37R5I=;
        b=F3gE97FM15B9CJ7RG37/kfNooKntH/4DE1JPl+OQeAzflt0o2dyByO+LFfp46yAfHv
         HDiAX38UbHVZCxAzG3z+gbrpemQ7mdvGXTc/KQZPBNDIY+h9EckM4WlJPhLe+BeRHm2O
         4qpoG+ZdMxsorS1m9Z9YheQBXDqjy4lY/uMPoeFaFQQlfvU7ZHytJWgARUjTNezfXroR
         /Dkz50buc3rAuv97SUIAyNhA052zZ6VypKm9pmj+maDrYHqIPLe4d4QV/MKO+4mUQCX4
         OaIDWwXfqS93WfXrgOB9fsWgR1LIIztTK12BzAHBQgk9PGzEBJ8BHia4it7gl97WvIdY
         CxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODbhvfMwQphzH4jjj2dKI3GxI6ydVmCWEWjM7c37R5I=;
        b=t8fGLa73oZ3EBp2E13J0w/ItBGUEH/pImcSV5iff+NUtFeIjefzZe8LCqUkLyohph8
         QbCijUeWkZV6Ud/PMwme3bMGUdBF1WMSQ1hRJ00Jl2Zgu1p7IN42nv6Xx54KOYTZAjkF
         qIQhGaDj6LjTibUla47K4e6HEyyq8iYZ5LqlyxroPTHvpnaFWWgmYzFCm3YCO1q31wXF
         n3JlseiE5L7YMf3/UO6GD415f9pK0k26lgVtV9/rrmwkMNdi43BKJCzkWFJJlD9GTdVA
         wKEzcHOqHG9qvpsPimwKpxFASmo34HTnjjBOHl+dFKQusLgbPJ40D0f209ceT1gryaZ4
         C/zQ==
X-Gm-Message-State: AOAM531BFeAM8Eicmh9v9pWl4g7R2zSonfYfh97W5lSxJL5ZtUtVwQrx
        JXUP6RqhiGZalLbpbOIezdteOsXXWW9GOIIjKaAxuw==
X-Google-Smtp-Source: ABdhPJx/woAqkF74q9rSzKmewZ8VP9sPLzo+GDh6O7Yof7Ml/NiaABiCkUJdo003DJ8GO7S/+8vO+U0e49FHV75uwnc=
X-Received: by 2002:ac2:4ac7:: with SMTP id m7mr2138739lfp.572.1605639540932;
 Tue, 17 Nov 2020 10:59:00 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
 <87k0uj6h03.fsf@mid.deneb.enyo.de> <20201117183652.GD2672@gate.crashing.org> <87r1or4yct.fsf@mid.deneb.enyo.de>
In-Reply-To: <87r1or4yct.fsf@mid.deneb.enyo.de>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 17 Nov 2020 10:58:49 -0800
Message-ID: <CAPNVh5d2u84t9RV7kg6PYJc5eGFrEQV__aDX6AC2V4-s+msFvA@mail.gmail.com>
Subject: Re: Is adding an argument to an existing syscall okay?
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

My assumption here was that applications that are aware of the new API
will always provide three parameters, while older applications will
continue calling the syscall with two.

I can't think of a situation/architecture where this will break anything.

Thanks,
Peter


On Tue, Nov 17, 2020 at 10:44 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Segher Boessenkool:
>
> > But this isn't variadic in the sense of "..." -- on Power that always
> > passes the unspecified arguments in memory, while in this case it just
> > passes in either two or three registers.  I don't know any arg where
> > that would not work, given the Linux system call restrictions.
> >
> > This is similar to the "open" system call.
>
> Exactly.  You cannot call the open function through a non-variadic
> function pointer.  I've seen it cause stack corruption in practice:
>
> commit c7774174beffe9a8d29dd4fb38bbed43ece1cecd
> Author: Andreas Schneider <asn@samba.org>
> Date:   Wed Aug 2 13:21:59 2017 +0200
>
>     swrap: Fix prototype of open[64] to prevent segfault on ppc64le
>
>     The calling conventions for vaarg are different on ppc64le. The patch
>     fixes segfaults on that platform.
>
>     Thanks to Florian Weimer who helped debugging it!
>
>     Signed-off-by: Andreas Schneider <asn@samba.org>
>     Reviewed-by: Stefan Metzmacher <metze@samba.org>
>
> <https://git.samba.org/?p=socket_wrapper.git;a=commitdiff;h=c7774174beffe>
>
> It is possible to implement the open function in such a way that it
> does not have this problem (simply do not use the parameter save area,
> using assembler if necessary), but it's another obscure step that libc
> implementers would have to take.
