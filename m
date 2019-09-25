Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4913BE469
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408004AbfIYSNk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 14:13:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33002 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404847AbfIYSNj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 14:13:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so6678721ljd.0
        for <linux-api@vger.kernel.org>; Wed, 25 Sep 2019 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRbAjoylre9NlfBO8BTIZTcAtpx4/BimOoVlxjcab3A=;
        b=RgsNfsczHYhjvCLBROtPtLM/H6+B+uvZ0JZAmKUTL8vx5b+5Msq9BuI/ssv3TZeicD
         ZroPWSJXfD63y6d4x0mq/4x/A34lOMaYIBNZCaVCrazpWITBqw+LjtY7dX6fRMKxbco1
         5Q4v89fff+oZ1ZC0vffbhrIPOES+t8XyK7sRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRbAjoylre9NlfBO8BTIZTcAtpx4/BimOoVlxjcab3A=;
        b=umd6KV02ngSFNjstcbw6BtGIPL0uyVku0Zv05r2DKYBu4XRUgCyC6eEvh4j/lgarUS
         fwoDWlNqPpLbobuUz9KRxIZM6y7Ng3I68xXbmhKClMmjh6ysZAyrs5dZKSIsDWaw7UR9
         MlvDFfdIVgy00V1dRWwy4BiJjVg+voi56MkUlt70Gj1O9Q8z3s7F80JmFqcLITxnQTnf
         xFwB8mnIpILlVmKId2NsxhOhmBCDXm4rTMptA+l6s1jhotolZ97PR+TEAMGzwwF1CCAY
         IKH1Sn6uGqe3NkXuGh4WK5PnAjaMk+0ep5+3z9BW5fJaUxLjBZBS45EtwAwydNUmuwzR
         7GMQ==
X-Gm-Message-State: APjAAAVJnbAXa81RFZaVlC/jrpbL9U76AiX5NUIx7mb022RzPzBiH7Cq
        EMLlWrbQSx/XwlsNA7iEG29rEdQF5V8=
X-Google-Smtp-Source: APXvYqwn1VsXoL6ToqLKziFn2OxFSezfgRvQ8mJqm/Bwo1DLsBStMF/yCMV0rC+FYcVmB78dBh6LuA==
X-Received: by 2002:a05:651c:c4:: with SMTP id 4mr7470897ljr.111.1569435217290;
        Wed, 25 Sep 2019 11:13:37 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z14sm1364661ljz.10.2019.09.25.11.13.34
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 11:13:34 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id j19so6686900lja.1
        for <linux-api@vger.kernel.org>; Wed, 25 Sep 2019 11:13:34 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr7476687lji.52.1569435214002;
 Wed, 25 Sep 2019 11:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190925165915.8135-1-cyphar@cyphar.com> <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
 <20190925172049.skm6ohnnxpofdkzv@yavin> <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
 <20190925180412.GK26530@ZenIV.linux.org.uk>
In-Reply-To: <20190925180412.GK26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Sep 2019 11:13:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcHw-O1sXw2jfJEHSVa2xmJcP9dzUmy71Cqk7_wVLSFQ@mail.gmail.com>
Message-ID: <CAHk-=wgcHw-O1sXw2jfJEHSVa2xmJcP9dzUmy71Cqk7_wVLSFQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 25, 2019 at 11:04 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> IMO it's better to lift reading the first word out of the loop, like this:
>   ...
> Do you see any problems with that variant?

That looks fine to me too.

It's a bit harder for humans to read because of how it reads the word
from user space one iteration early, but from a code generation
standpoint it probably is better.

So slightly subtler source code, and imho harder to read, but it looks
correct to me.

             Linus
