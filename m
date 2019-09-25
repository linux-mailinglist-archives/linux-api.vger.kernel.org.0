Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5391FBE320
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437796AbfIYRLB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 13:11:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38393 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440080AbfIYRLA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 13:11:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id b20so6469458ljj.5
        for <linux-api@vger.kernel.org>; Wed, 25 Sep 2019 10:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/M6vs2MEAeMbwXL6x+MUmS0dJpTwUZl6jDdxP7DrDw=;
        b=QRNmKsS7UFvM5WS2hJvF/DKx2du7B20JglJZah0r/OncwmJDy/25GvjHNsK/+d8dtK
         1WVfiK+mnfI6/+EgrVxBfTTDFs9f/7e4VvW4hVap03eHhSSrdUZWnKE5p4p2VDg0GTRe
         al6XiM4ArkVPwy1MSvvlYIiUCokXZoc/Us5KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/M6vs2MEAeMbwXL6x+MUmS0dJpTwUZl6jDdxP7DrDw=;
        b=puXvZq3TQtK/kDhvdaiBv1dgD95Uprt3AjXvu+ART+dKWrNqCWahzPVDFFJWbSh+Bj
         Ye9vOODoe8Shz2yHRNJa07XqPnX5iCf4fYo9tGylypd3Gz60HBqS2RwKjiMJwLRot8c6
         R8TRtKRW9KmPqKaP4oUqRq3o5ZUWwaPL1+GhXHQeSGUC9SuNECdu/iqXz+1mBHTxXhB+
         Ykg3lKPhggtPKuQu8+PbBNM24/83annqE/TyZ/fBBQFQt/H2XsKsFjymj0dL3BgyoBPP
         HLfhQqBPHG9MuhOZoYBp7o5Eqi8o8rIpOgO/0ArgHpZoMpdZdAv54gBFBxxzvYt/Aczo
         SXvw==
X-Gm-Message-State: APjAAAXLzlyEdkP4wkUgjA7f+Vi9VD58gUmc9hXAhhiXKPcKtR+50RQb
        CQGg+NsAt0H6w7U4HYZxo1PPzptsnAs=
X-Google-Smtp-Source: APXvYqzUGCGsUtwHQvnuT9lOZoceGxeXBbOlg+znKCJ8UzGK+057dbH8qEJ1ahUXv9M7KqBrnj9gPQ==
X-Received: by 2002:a2e:1b5c:: with SMTP id b89mr7151053ljb.182.1569431456712;
        Wed, 25 Sep 2019 10:10:56 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 6sm1256324lfa.24.2019.09.25.10.10.54
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 10:10:54 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id j19so6490027lja.1
        for <linux-api@vger.kernel.org>; Wed, 25 Sep 2019 10:10:54 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr7454790ljs.156.1569431453769;
 Wed, 25 Sep 2019 10:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190925165915.8135-1-cyphar@cyphar.com> <20190925165915.8135-2-cyphar@cyphar.com>
In-Reply-To: <20190925165915.8135-2-cyphar@cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Sep 2019 10:10:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
Message-ID: <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 25, 2019 at 10:00 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> +int is_zeroed_user(const void __user *from, size_t size)

I like how you've done this, but it's buggy and only works on 64-bit.

All the "u64" and "8" cases need to be "unsigned long" and
"sizeof(unsigned long)".

Part of that requirement is:

> +               unsafe_get_user(val, (u64 __user *) from, err_fault);

This part works fine - although 64-bit accesses migth be much more
expensive and the win of unrolling might not be sufficient - but:

> +               if (align) {
> +                       /* @from is unaligned. */
> +                       val &= ~aligned_byte_mask(align);
> +                       align = 0;
> +               }

This part fundamentally only works on 'unsigned long'.

         Linus
