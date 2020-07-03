Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB12141DC
	for <lists+linux-api@lfdr.de>; Sat,  4 Jul 2020 00:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgGCW4d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 18:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGCW4d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 18:56:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D5C08C5DD
        for <linux-api@vger.kernel.org>; Fri,  3 Jul 2020 15:56:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s16so13889388lfp.12
        for <linux-api@vger.kernel.org>; Fri, 03 Jul 2020 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbgA4RzqidtZFEVtt5akl8++MP32OZjgKqPdlkBDgXs=;
        b=UeZlVA56DqwTv9Lh1HYTByyGxaiUrgbCpUb5wwS/W3ttQUa/nvZj+SlwPS35p4CYSP
         Dowgopsc43EYqpsAdDrA2Xpid3lkfppKMVYaEQf/e8bD3MGnuO2VKhSicJ5UMowB4JIv
         1EGmWrpPbBWxHHAF74B0p12xAwXZ89dk7RJo6xAoFLJ0ejv4EI2nlhY1B50UjO1cPtJ7
         nKtGAslCAzgcf2mxWINZ5sK/mtNkc7OeZe8Lkwg/U5dpuvCWk8FDTjU70/wcDwVNA6o0
         gSdzbay7w2WFaxVj7xbHwB0IyEehWpmOReepW9FeS88uEUObxDYUB7E8A0YxAmd/b9tG
         M72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbgA4RzqidtZFEVtt5akl8++MP32OZjgKqPdlkBDgXs=;
        b=K99TB82VhfZ8ni+Ey+y2jP2qTZgxq6ZUZcC7rM3iyY6rEPhYgS3/Tqb7qigx6L9gz6
         bbbOlVbkxoiwhkjgF5ttk8OoXY7IQnt2fhzJhJUhUlsg+ugSOC+fd9HqAVTwWywkCKem
         imtb6CdeUJKnDqLivYNiURlEYK2r180LOoLEWz1ZWxgol9oEuRBytRHuA2WVVo8SdXTG
         nc67mLM5QwE79IiUl+PhgMJke19CYlzeJTsoO4YkzbobvXp/8Mof0fxxrDe6wARcr/Cd
         p9XyUcLbJ0dndVUaQKxaW77ZCS5EHAGNB9LGyYTlB5Y9xWXqYAAV4V/W0YqzAzlCm5Rn
         y8WA==
X-Gm-Message-State: AOAM530PlQYgqtqACyzr1b5fEQwUvk2etrpVYrYy9x2Zut2CpzJCN5g4
        sdFVvt6Vh/I63b0upzIVTGsxPBlDFpqp82+oCLnfJg==
X-Google-Smtp-Source: ABdhPJwMLT+gN9QjK+IvxYNcKqOXF1CgkwQpOJdeVbidIY1M/NzUS4Gb23Gqi9y7RTbtdUpFyLm5YuABMHLAclQ1HnM=
X-Received: by 2002:a05:6512:752:: with SMTP id c18mr888011lfs.141.1593816989653;
 Fri, 03 Jul 2020 15:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com> <20200703224411.GC25072@amd>
In-Reply-To: <20200703224411.GC25072@amd>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 4 Jul 2020 00:56:03 +0200
Message-ID: <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jul 4, 2020 at 12:44 AM Pavel Machek <pavel@ucw.cz> wrote:
> > Cryptographic libraries carry pseudo random number generators to
> > quickly provide randomness when needed. If such a random pool gets
> > cloned, secrets may get revealed, as the same random number may get
> > used multiple times. For fork, this was fixed using the WIPEONFORK
> > madvise flag [1].
>
> > Unfortunately, the same problem surfaces when a virtual machine gets
> > cloned. The existing flag does not help there. This patch introduces a
> > new flag to automatically clear memory contents on VM suspend/resume,
> > which will allow random number generators to reseed when virtual
> > machines get cloned.
>
> Umm. If this is real problem, should kernel provide such rng in the
> vsdo page using vsyscalls? Kernel can have special interface to its
> vsyscalls, but we may not want to offer this functionality to rest of
> userland...

And then the kernel would just need to maintain a sequence
number in the vDSO data page that gets bumped on suspend, right?
