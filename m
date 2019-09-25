Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A7BE648
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfIYUXt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 16:23:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44029 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfIYUXs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Sep 2019 16:23:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so5198763lfl.10
        for <linux-api@vger.kernel.org>; Wed, 25 Sep 2019 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3ItCLkP0Wm4Ak+WGr3LTNj+4g3loXe1oyLTxRsQI8c=;
        b=hW5iXNvwQEuj3rT9IzVABGFeZs+xpuh7yW8suXDxSXXGJmlalPZbpXpj5zZHxO8o2h
         HCKtkg3kL0s9BxkQL1hAY/aXPMPIiZufFScpxUWfUWlQwP0BaCIeD26THZhs6rp5ZF5B
         ZT9ScEXwfZBf7u3fO0vG9M1bHCrFQHfGAS+O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3ItCLkP0Wm4Ak+WGr3LTNj+4g3loXe1oyLTxRsQI8c=;
        b=iu2IjKVD2Rce9YfVNRMjGe8xbWhnzk78CbEJLqhpSTf2hAYsyWTAoPcl3/fQrULvNE
         3MKtKDCLdXYKFmwjNco/zxsPiVQ0Zu4K/rq7ZzqWNJ7xCt5QelwIHZNkm++12k4oH/0C
         5KLXY7eVAFJPIGZrQwfAneGk6oZ0/W+1+J+WRa26Mr1ty2RHnHocMEGqJHuQbqSHz6+O
         BUPBrMl4gQr08XZ3RwcqjIBm5Imj6flbQ/QoY5N3E1KsnKyJV6atuvKFxEyO2sUmDaLl
         K7M0zutn45njRCdGhc+nbj0l2mZFsoKTrz2TZQfzVqAPi0F5s5tKXbse4OsrAmq9P7o8
         RzfA==
X-Gm-Message-State: APjAAAUxyQPOCw8wvzmczKvOAWuL2NSEy2IZjNVYanNYMRzmJkvd+8WQ
        N5n0CbnSSEvmTzEt8RxsttkxYmHAplQ=
X-Google-Smtp-Source: APXvYqzj6/gn4KshFzjg3iaMXRp1rU+DVkJJ606sRPygHyl87vNHY55VBkzKEqya9PbTJAXPPwijfg==
X-Received: by 2002:ac2:4427:: with SMTP id w7mr7284855lfl.143.1569443026353;
        Wed, 25 Sep 2019 13:23:46 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 28sm11245lfy.47.2019.09.25.13.23.43
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:23:44 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id v24so7067100ljj.3
        for <linux-api@vger.kernel.org>; Wed, 25 Sep 2019 13:23:43 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr126368lji.52.1569443023576;
 Wed, 25 Sep 2019 13:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190925165915.8135-1-cyphar@cyphar.com> <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
 <20190925172049.skm6ohnnxpofdkzv@yavin> <CAHk-=wjagt257WHiOr2v1Bx_3q7tuzogabw_1EnodKm0vt+-WQ@mail.gmail.com>
 <20190925180412.GK26530@ZenIV.linux.org.uk> <CAHk-=wgcHw-O1sXw2jfJEHSVa2xmJcP9dzUmy71Cqk7_wVLSFQ@mail.gmail.com>
 <20190925194331.GL26530@ZenIV.linux.org.uk>
In-Reply-To: <20190925194331.GL26530@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Sep 2019 13:23:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whSHi46gH-aE8bQsv7hvKDSHpWKQyLW3qF3caAB59cH+g@mail.gmail.com>
Message-ID: <CAHk-=whSHi46gH-aE8bQsv7hvKDSHpWKQyLW3qF3caAB59cH+g@mail.gmail.com>
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

On Wed, Sep 25, 2019 at 12:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, I would probably add a kernel-space analogue of that thing at the
> same time - check that an area is all-zeroes is not all that rare.

Hmm. Maybe.

> Another thing is that for s390 we almost certainly want something better
> than word-by-word.  IIRC, word-sized userland accesses really hurt there.
> It's nowhere near as critical as with strncpy_from_user(), but with the
> same underlying issue.

Well, s390 does have those magic "area" instructions, but part of why
it's expensive on s390 is that they haven't implemented the
"user_access_begin()/end()' stuff. I think s390 could use that to at
least minimize some of the costs.

With the common case presumably being just a couple of words, it migth
not be worth it doing anything more than that even on s390.

Interestingly (or perhaps not) if I read the internal s390
implementation correctly, they kind of _have_ that concept and they
use it internally. It's just that they call it "enable_sacf_uaccess()"
and "disable_sacf_uaccess()" instead.

           Linus
