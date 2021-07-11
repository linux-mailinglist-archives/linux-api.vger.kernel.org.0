Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C623C3DFD
	for <lists+linux-api@lfdr.de>; Sun, 11 Jul 2021 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhGKQiW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 11 Jul 2021 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGKQiW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 11 Jul 2021 12:38:22 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F143C0613DD
        for <linux-api@vger.kernel.org>; Sun, 11 Jul 2021 09:35:34 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id c20so6030797uar.12
        for <linux-api@vger.kernel.org>; Sun, 11 Jul 2021 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3f25szeD9waUmzEd9NsNG/voXya0DVJNKMcZvze03BY=;
        b=AxDW+nEimR3JS9jMsKxib/y9HraIdIH+Q9ai0rIiIrJ/8nCv+fpP7ILCnTboq4h38f
         2d5vQQMWvcBud1MSeE+L4Ug/CuJM7nZSATyTjqR+fRiZLR1PJ4Ifhaob7UBv8gmWljwH
         FpoBhBe5l8ONiP7FEVPAsqZFtga2RFTRUMepWqzbmx2nHKpsX7e4Xadqh+O/sYOogkV2
         Nv8Cwa3gupZHYSxQ2MtS4XUIWlt2SWICf3ax8s7tSEfyPz91I4jLpOvPV93afO/bxXIy
         pEhOePrjeHDzIIOa6s2DTK2nMjrgWvW1oBAiOampRS8OStvYXB0VxhH7l8wDpUKoYuDm
         ppKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3f25szeD9waUmzEd9NsNG/voXya0DVJNKMcZvze03BY=;
        b=BEe5FnCthzsUlGhBkxxWqUF/oV4Fs9otiYxduGXkzkbI1mcdnuxUKxv5B2YYWTDlhK
         nEXIld5QIg3CLgDzZ2pHlnyGYY3LeepJ7yVJx4GrvsYlD1YmlXIYLiH1vSBQYVj09hRt
         /Q2VgcX9fX8/lCunwl0ngllZNLSJ48mwfc6DvbcLyQwkAlKWocR5f4svTIuJZDQbnuGE
         9NGcz881RlPiBSqBuy7vDZELnzLAua4XU0uqCLIEm2nyn7G4Y1sooZUka8h9KjvA3U9X
         8nFKCNEtJYcL2dwF6nHWYO91P3l46z8DApf3Ipw7dDO1WQ4I+FasgvyoZEsGg043asZz
         LSPQ==
X-Gm-Message-State: AOAM5307ck3mYtM9BGk6q67oTTqixKrckJXw/96+W0Hx6Fi9AmMlcBP+
        +yfTwGNdAgV5Ukn/Wv9y5kvQ1EGA208gRNOLzA6vZg==
X-Google-Smtp-Source: ABdhPJwukCIjy4XliRlv7tFpC15wEftOR6xbpev6ksmG/apE4Rd1+adHWM0Z+XSX7RjybTN30nAVYW3S/noTa+F9Wzo=
X-Received: by 2002:ab0:494c:: with SMTP id a12mr46324347uad.17.1626021332827;
 Sun, 11 Jul 2021 09:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210708194638.128950-1-posk@google.com> <20210708194638.128950-4-posk@google.com>
In-Reply-To: <20210708194638.128950-4-posk@google.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Sun, 11 Jul 2021 09:35:22 -0700
Message-ID: <CAFTs51WV6AD+ev4=RxXExjT3=TtaOZdE1avEY_uWHmUTb87mJw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3 v0.2] sched/umcg: RFC: implement UMCG syscalls
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 8, 2021 at 12:46 PM Peter Oskolkov <posk@posk.io> wrote:
[...]

> Pretty much everything works, with one issue: when a worker
> blocks, we need to wake its server in umcg_wq_worker_sleeping
> called from sched_submit_work within preempt_disable block.
> As the server_tid is set by the userspace, it can point to
> a running/spinning task, and so wake_server will hang waiting
> for ttwu() to succeed. I do not think this is appropriate,
> but I am not sure at the moment how to resolve this. Any sugestions?

[...]

I think I can solve this by carefully ordering state changes (both
umcg state and task state) and maybe sending a signal to the wakee if
not enough. I'll try this approach in v0.3.
