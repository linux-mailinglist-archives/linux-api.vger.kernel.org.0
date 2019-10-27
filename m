Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 690F1E62D2
	for <lists+linux-api@lfdr.de>; Sun, 27 Oct 2019 15:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfJ0OD5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 27 Oct 2019 10:03:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35803 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfJ0OD5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 27 Oct 2019 10:03:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so8570646lji.2
        for <linux-api@vger.kernel.org>; Sun, 27 Oct 2019 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUtxqBrTqUG2JQM67qlbeu/gWrmsCKLHs/nf3HjwR6o=;
        b=UBVoDLidxhGRZnO3t3s9odW+975NWscpsgyn72pMoIFtMXrLI8gYCDX8RoEk4dUGpu
         XShVkulYmvYa4f4vPiGJkAOAAjj/NBHXSLZISLlhGaOzl5SAbZ6BhT9CpKJEgEzb8LhN
         G2c7dQQvyPPapIvGT5FeHB9zbcHI3CN4A0Ff0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUtxqBrTqUG2JQM67qlbeu/gWrmsCKLHs/nf3HjwR6o=;
        b=Q7T9qr/j77TKIEyXF4yd4u/x/653iX653v10YcO8O+tmLTdNKkNByBD8eYRIpqjaYu
         ZNZYNpu8NQab5R+kzMTitqEmMM7Durf7xGhwXAIAKKEtTOC8D56QBKbruBPQbRUo5U+B
         Wvklo1YKOsgJAEO2kIGmS1pzR3senyxb9mt6NdeMVoJJ3TrObJPsA+MnHd8WuJCIErWt
         y5FJQHbQ65rFNalZAA8FkWJm890nHrOo6tCu7zHds2I874U6pBndG+c0dylJ8K1mY+oV
         4f2H5m7v4AOjTGKO9C09PYex4L4JvCMLwqDzT31P46O+Y+bn92/5zGDO681m+OecjY0K
         NkCw==
X-Gm-Message-State: APjAAAXfrv6ukcdQxN2AZobqpE2yNQiUFMvWdOtxcT4gd5ZdYBx3EPSr
        FkvKf/i/d31J0VMapphUJg7JL3RHH3hKOg==
X-Google-Smtp-Source: APXvYqwjTmIc5U8inTEbL4Kq8Uv+SHm7lmq5tGVoGK6+cY47EXXtGHkM3IsunHyWsjBXjM/3xVolFw==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr8807028lji.64.1572185034561;
        Sun, 27 Oct 2019 07:03:54 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a8sm2421028ljm.53.2019.10.27.07.03.52
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id w8so4043097lji.13
        for <linux-api@vger.kernel.org>; Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr8760744ljp.133.1572185032112;
 Sun, 27 Oct 2019 07:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Oct 2019 10:03:35 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
Message-ID: <CAHk-=wh7cf3ANq-G9MmwSQiUK2d-=083C0HV_8hTGe2Mb4X7JA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This still has signs of that earlier series:

On Wed, Oct 23, 2019 at 4:17 PM David Howells <dhowells@redhat.com> wrote:
>
>                 if (rem >= ibuf->len) {
>                         *obuf = *ibuf;
>                         ibuf->ops = NULL;
> -                       pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
> -                       pipe->nrbufs--;
> +                       tail++;
> +                       pipe_commit_read(pipe, tail);
>                 } else {
>                         if (!pipe_buf_get(pipe, ibuf))
>                                 goto out_free;

with those odd "pipe_commit_read/write()" helpers.

They make no sense, and they don't make things more legible.

It's shorter and more obvious to just write

   pipe->head = head;

than it is to write

   pipe_commit_write(pipe, head);

Even when the addition of the notifications,  it's all under the
pipe->wait.lock, so it's all just regular assignments.

Now, if at some point it starts doing fancy lockless things, at _that_
point the updates might become more complex, but that's a potential
future thing that wouldn't be relevant for a while, and isn't a reason
to make the code more obscure now.

Hmm?

             Linus
