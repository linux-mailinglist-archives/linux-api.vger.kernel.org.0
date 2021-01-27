Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8249305197
	for <lists+linux-api@lfdr.de>; Wed, 27 Jan 2021 05:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhA0E7f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 23:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392323AbhA0Bli (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Jan 2021 20:41:38 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE3FC061786
        for <linux-api@vger.kernel.org>; Tue, 26 Jan 2021 17:40:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a10so376489ejg.10
        for <linux-api@vger.kernel.org>; Tue, 26 Jan 2021 17:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmG6RY7BcaGv1lUjf2k1d39NdU3p9zWFX78N7nxH8OY=;
        b=kxgKmFLoRAg8u7ZqzFVVRXWa+eYvi7tyiJnRbD+V3vbf7C11Ixv7YaG27sw70Rmm9Z
         eiqxUpYPYrKFaxhiD/P9m+mNcl6qNhfNB1NZBryr3pVnPp+XXPDdVpzm04J9evyZKCnT
         SmgxrBmVFGDM0wUkGtxwtq2IGGg7rUijXbrQtotudZLfM3xBFY3tT8fM7kb8v+3MMbaP
         qjA9wCTvI2+8/dl/gozUdOmwA3zkYwLf0al/LKr6TCuQqYg0zsrhGejEZIuk9HqUy6MJ
         kxNIUHnIASv9wObEtBOUIQgQCO4BaSQBarlWcWGu6JIrkw7c6M7cNyRuQdTiMwyCoNPs
         frPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmG6RY7BcaGv1lUjf2k1d39NdU3p9zWFX78N7nxH8OY=;
        b=iIPJhqn96UnCyWcb+T67RL6/ea3AFrMsfJr+5QjFvRKSoOixjWh6qUSIWES0L00GuF
         bUCuqlMZvAC7D+kqNm8p4lTIO6Mc66KxXKjKIgHDroPSCWzWDHj20smvLUaSvytliCTk
         rdF0xxKqM4k0BfgHhrLUPfoeoSr098diJ0bfFfcdi5DJ8cjggOrH7BNR/j5pGEdzpevw
         yLRLBed1cF5isNugYjZr6vu4cw/UUutpRvz7lAI//TvplioG0CG0qbziI770kFUmLrsU
         EfPYAo5B5H7NXm6BPJLv3Pm2QV9Xng8+dpnoWReIZodPS6TEsp0PSrLrzguHqHO0z8Mj
         J7DQ==
X-Gm-Message-State: AOAM530CJnaCLqkCqB3GkpPGhv83M/uUbSVvT5VhbGPzlGOxXdWNLbpj
        BRe6qV2rw2r2gYmTNvr/JDIyDqHsY1YOeziRZMs=
X-Google-Smtp-Source: ABdhPJwQp8zDSp8NHgkR/bu+tt/PuRRt99Gok7ZNnvDmSqlKILvGi5L0SmBS3QDtMLL532yqO8qbN6pPFigzw15lCf8=
X-Received: by 2002:a17:906:1719:: with SMTP id c25mr5362886eje.251.1611711657094;
 Tue, 26 Jan 2021 17:40:57 -0800 (PST)
MIME-Version: 1.0
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com>
 <20210124121845.38293-1-alx.manpages@gmail.com> <YA2ztHUATu1gOxoV@clue.drijf.net>
 <CAMMLpeSLbWtRrrzOjB6DJgZCem8KWpy7_pWmr6ecuGrSmg4Eng@mail.gmail.com> <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de>
In-Reply-To: <d0f93c40-c471-7ef7-fa9a-2f467d775d3e@bernhard-voelker.de>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 26 Jan 2021 18:40:45 -0700
Message-ID: <CAMMLpeRsvi+Gjdn2ypikNrc0uW6K_dqOChasqYJ7Fv+_TMuC4g@mail.gmail.com>
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not
 write to stdout
To:     Bernhard Voelker <mail@bernhard-voelker.de>
Cc:     Otto Moerbeek <otto@drijf.net>, Coreutils <coreutils@gnu.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>,
        Juli Mallett <juli@clockworksquid.com>,
        Jeffrey Walton <noloader@gmail.com>,
        freebsd-hackers@freebsd.org,
        William Ahern <william@25thandclement.com>,
        Roman Czyborra <roman@czyborra.com>, oshogbo@freebsd.org,
        tech@openbsd.org, Christian Groessler <chris@groessler.org>,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Ed Schouten <ed@nuxi.nl>, Eric Pruitt <eric.pruitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Jan 24, 2021 at 9:04 PM Bernhard Voelker
<mail@bernhard-voelker.de> wrote:
>
> An off-tech argument: ask a local plumber if he'd would ever use
> a tee piece instead of a pipe end piece.  I guess he would only
> if he wouldn't have anything else at hand.

According to POSIX, tee writes to "zero or more files."[1] So the
"local plumber" analogy already doesn't hold, because a plumber would
never put in a tee and then immediately cap it off so that the flow
can only go to one place, but commands like `echo foo | tee | tee |
tee` are already explicitly allowed.

> A word to the proposed patch: what should happen, if the user does
> not give a file?
>   A | B | tee -q
> The patch just silently ignored that situation which feels wrong.

Personally, I like the idea of only having to type `echo foo | tee -q`
instead of `echo foo > /dev/null`, so I think the patch indeed does
the right thing in that case.

-Alex

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/tee.html
