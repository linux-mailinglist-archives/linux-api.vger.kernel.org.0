Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E38D4996
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfJKVBM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 17:01:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39123 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbfJKVBM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Oct 2019 17:01:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so7969962lfh.6
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKr4WHC3iR8iedd+96HoEDT1mA0iwz01QLINNBDqvTA=;
        b=AjD32CNEE5D2mrL1SxTGTAcIg8rDu5TsWXuC3JWTpw/d7RSutnwDdzYzC2ZDXXNEQs
         xbRUdI2G9Bdey7J+lF7C19PmyyR/h7paQAvoZ3B7DeLBGHQM7JosujRghPkyJaObtcaK
         WflPEvqjO32pHzc6ziczhzVrcfZHPdGY8qVxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKr4WHC3iR8iedd+96HoEDT1mA0iwz01QLINNBDqvTA=;
        b=uTFATHYKwaTVcB1MK7PCOXbUC/cl7aGxaacSIk6ZtOgwVue93BDeRxLqiEVhbefvVz
         KU7g0+aeLLkQdu9dWVRxa2EKkglW8liI57of/qKkTAKuH4/hBND48lHRi9jxMBTQnwy5
         brdyb2sZkicUra+HnVRxQ8oKsPGJcX+7N/AXf6dsZ3iB4yViaUSsh5MFzAX9n0C8gQAq
         DRy1hiUxJoIIZQqVFa92emJIumXfs/mIEtDZGpNe64Xg4RTcCMcllUmjEO4KIozyOaYB
         bm60awtS0eh0UI2JzwOriIwY5k1a8gRCKt9vLQlGys5Tf+iWF+j2ljJ/FFvrNKdBmGwU
         NR9A==
X-Gm-Message-State: APjAAAWYNV1+4qdYdfb36nlA4Z/MyPyItlcuqnH3wGLfLaCRUbGzzWi8
        TsvQ/qMwqPJRQ0sLzky/GEN2S3J8HoA=
X-Google-Smtp-Source: APXvYqzcwAwCz2i7WqsoNAZKOX8p5yyhH/WU5pRTqw0rogDwt7Rb6AUtcYpC1u/NHLPJMB6wjBBDNQ==
X-Received: by 2002:ac2:43d9:: with SMTP id u25mr10240083lfl.142.1570827668472;
        Fri, 11 Oct 2019 14:01:08 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t24sm2153014ljc.23.2019.10.11.14.01.07
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 14:01:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id r2so7947515lfn.8
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 14:01:07 -0700 (PDT)
X-Received: by 2002:ac2:5924:: with SMTP id v4mr9785397lfi.29.1570827666846;
 Fri, 11 Oct 2019 14:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011162518.2f8c99ca@gandalf.local.home> <20191011165455.32666d53@gandalf.local.home>
In-Reply-To: <20191011165455.32666d53@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 14:00:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGtEDhwJab7+tQzmjDssynBruRvgj9NJY2bzNrVzw+0Q@mail.gmail.com>
Message-ID: <CAHk-=wiGtEDhwJab7+tQzmjDssynBruRvgj9NJY2bzNrVzw+0Q@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 11, 2019 at 1:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I guess I can keep it this way. Thoughts?

That looks fine to me. I'm still not sure you actually need to do all
this, but it doesn't look _wrong_.

That said, I still do think that if things are locked down from the
very get-go, tracefs_create_file() shouldn't even create the files.

That's mostly an independent thing from the "what about if they exists
and things got locked down afterwards", though.

I do wonder about the whole "well, if you started tracing before
locking things down, don't you want to see the end results"?

             Linus
