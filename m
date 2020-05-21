Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E581DDACC
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 01:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgEUXOC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 May 2020 19:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbgEUXOB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 May 2020 19:14:01 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A0BC08C5C0
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 16:14:01 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id i16so3676320ybq.9
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 16:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prum5QcrbZCO0F65OHvFGChvc11UJdGytJaiM86CTfc=;
        b=EJO8LmragjkCPmJ41c+po3zpR8kk9FxzpYkfolWjsWm/p7Z1mDP1PIVanxntgtIjlu
         IIEJgNn+vOewvEKC794pIXsbPqh8K8K8K/z05EU22q84qbvWwXurP8L8pN2CTB1Lxn07
         wllQh86f2e/faYICaeOC4O1GSbyjHy6ie2HEZ5z7EIzd2FayPfgAoow1OdWChmponEJE
         qvX2TW9MTEBvPOGdbNguA6cGVH2G2Atn7Kta5orCn1jcJQ4/e2CD17+qZZDgy5e7Zgt7
         TvRbB7OI5BqzzfXt6+2b29plh5CGUZ4d80DMgmw4moH55QZMIUJEtiP0CnYYwk4t5Sck
         CiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prum5QcrbZCO0F65OHvFGChvc11UJdGytJaiM86CTfc=;
        b=eJTKTK0Vw9CMAcyg9iSH9hOF82F4sm3z2i1490RaK28p6YPrR3XZDcWnu5uNDSvTjv
         xpJ57A+N9Vwo/H1+y97+I2vItsJ4KYu1B/P8SAol3dwWyk99deEYQ1PdKJKUMdOvTXS1
         ijrCi5J2nAoxJTE5XvCJCkzVxFLU7ZpDwjRHJOngjhvPHypsvVbOj6ZU1RxMBN4VVL4y
         sCaHPNcObFWaVqNuZSkjwJMA8GkGy0jltgS1taaNAdJchtyOqaYh7y0r1NFo8OtXDNOh
         ObjdBvPNUgVUg/VEleKmKvzutqxn2qVpS3Zotfto+r7yFmTDhqEOyxX7kq7Qxo6KFYhV
         6jiw==
X-Gm-Message-State: AOAM531y79AAfE7MPDCOPlqRm4vlPd9s/j0GJaCwIziZeiiQ5o7J0rzN
        oQ+fm1ETwb379lyfWm2iSVc+uOP4ioLL5NHvDHPvuw==
X-Google-Smtp-Source: ABdhPJwyeBZVNqGDDn7EXqfUoPtnSiRN0M0U3xT9gYtJelmdRXVjJEVDRKm0e+Um+Naji4fd1bnb3ChFlyDdmcHH2Ts=
X-Received: by 2002:a25:bb42:: with SMTP id b2mr18715117ybk.383.1590102840392;
 Thu, 21 May 2020 16:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200521222551.259804-1-irogers@google.com>
In-Reply-To: <20200521222551.259804-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 21 May 2020 16:13:48 -0700
Message-ID: <CAP-5=fXjXgWEgp9gqReByrDBTvjDbPEsubeAFxrpxj_+FsFn6w@mail.gmail.com>
Subject: Re: [PATCH] proc.5: add "wf" to VmFlags in /proc/[pid]/smaps
To:     Rik van Riel <riel@redhat.com>, mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-api@vger.kernel.org, nilal@redhat.com,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Colm_MacC=C3=A1rtaigh?= <colm@allcosts.net>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 21, 2020 at 3:25 PM Ian Rogers <irogers@google.com> wrote:
>
> This patch documents a flag added in the following kernel commit:
>
> commit d2cd9ede6e193dd7d88b6d27399e96229a551b19
> Author: Rik van Riel <riel@redhat.com>
> Date:   Wed Sep 6 16:25:15 2017 -0700
>
>     mm,fork: introduce MADV_WIPEONFORK
>
> This was already documented in man2/madvise.2 in the commit:
>
> commit c0c4f6c29c494c466f3a2a6273c5b55b76a72927
> Author: Rik van Riel <riel@redhat.com>
> Date:   Tue Sep 19 20:32:00 2017 +0200
>
>     madvise.2: Document MADV_WIPEONFORK and MADV_KEEPONFORK
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Doing a quick audit of fs/proc/task_mmu.c having noticed this flag was
missing I note:
 - "mp" isn't documented, only possible with INTEL_MPX
 - "nl" is documented but not present in show_smap_vma_flags
 - "um" and "uw" aren't documented

Thanks,
Ian

> ---
>  man5/proc.5 | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/man5/proc.5 b/man5/proc.5
> index 46d603f28..3e5b91af0 100644
> --- a/man5/proc.5
> +++ b/man5/proc.5
> @@ -2020,6 +2020,7 @@ encoded using the following two-letter codes:
>      ht  - area uses huge tlb pages
>      nl  - non-linear mapping
>      ar  - architecture specific flag
> +    wf  - wipe on fork
>      dd  - do not include area into core dump
>      sd  - soft-dirty flag
>      mm  - mixed map area
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>
