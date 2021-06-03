Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170AD39AABC
	for <lists+linux-api@lfdr.de>; Thu,  3 Jun 2021 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFCTPc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Jun 2021 15:15:32 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37871 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCTPc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Jun 2021 15:15:32 -0400
Received: by mail-lj1-f179.google.com with SMTP id e2so8524086ljk.4
        for <linux-api@vger.kernel.org>; Thu, 03 Jun 2021 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EDxCagl07bOh/Nv8oABAKO17kN+L9A+RY/dcpJKFLM=;
        b=UTljGEGQNYuxNXIn0v7XzxieUWCtnIsxzkRCecivfei0dzW5YoDgn0l5XlRffuAtRp
         9lRSLYrp3aHu78VwRpo49Xzw5AfLWYiO+J5j4JygA2mmEuyDFb9pNuPPxy5EAwi8/b+z
         1pN+oUWFghkmkRW6aHl9ejWgOUmra/8PfgAXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EDxCagl07bOh/Nv8oABAKO17kN+L9A+RY/dcpJKFLM=;
        b=ZGzEtRkCTF3O18cAlsMWQ0FelRSWmKLgCd9EO3tK2coxaGiljyvSocrxt28DdQvP8Q
         /3lITszJ2sedDArM8bbKogcm/bbW6yeEi4In4aKZvlgoWR/mTTRArnFaoA/MIyHs1dMs
         64aC+xBgBwmoWl96olO7rQ81oNcsPupaQJT6FmalvMd0Jzxx0TUE+AldZsYaQwo1M297
         Z2xDfaY9Gt+60ambirxRa3E5cDUG0vS82HYBMbcPZkWf8bv5SXLfoeQb25Vybd93q40a
         SvfYEJl33tDAnyY5McfBlJbAH5vqIXct4KkcEwF7+3/ZOyLX38lhNPhT1d6JbRW/pn6J
         gEPQ==
X-Gm-Message-State: AOAM533V+bjqiNaZBXlyXaLv7zpxmetwX0UOd9q4W/4qr1m+vXZnIDt2
        kot/LiPlQqnjZok8uInrs6M9lRloTjxCxZ9b
X-Google-Smtp-Source: ABdhPJyyTckk1Goe4/zqEaHqyRWPMKoiHIWFY0nRba2EpiFvsCpkR6XF0gPC3MRLDfha6ulQ9Jlr0A==
X-Received: by 2002:a2e:9947:: with SMTP id r7mr587539ljj.263.1622747551295;
        Thu, 03 Jun 2021 12:12:31 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w8sm395912lfp.209.2021.06.03.12.12.30
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:12:30 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id n12so3439345lft.10
        for <linux-api@vger.kernel.org>; Thu, 03 Jun 2021 12:12:30 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr260545lfc.201.1622747549926;
 Thu, 03 Jun 2021 12:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
 <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org> <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
 <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com> <alpine.LSU.2.11.2106031142250.11088@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106031142250.11088@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Jun 2021 12:12:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
Message-ID: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
To:     Hugh Dickins <hughd@google.com>
Cc:     Ming Lin <mlin@kernel.org>, Simon Ser <contact@emersion.fr>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 3, 2021 at 12:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> But the point that we've arrived at, that I'm actually now fairly
> happy with, is do *not* permit MAP_NOSIGBUS on MAP_SHARED mappings.

Yeah, if that's sufficient, then that original patch should just work as-is.

But there was some reason why people didn't like that patch
originally, and I think it was literally about how it only worked on
private mappings (the "we don't have a flag for it in the vm_flags"
part was just a small detail.

I guess that objection ended up changing over time.

            Linus
