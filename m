Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC500AE147
	for <lists+linux-api@lfdr.de>; Tue, 10 Sep 2019 00:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfIIW6C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Sep 2019 18:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfIIW6A (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 9 Sep 2019 18:58:00 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED095218DE
        for <linux-api@vger.kernel.org>; Mon,  9 Sep 2019 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568069879;
        bh=ieeg6N6SsihmRHhWQlCf1jmFz+Sgb4qasTIFr0xv6gA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wOkecgI6RV5u48hhm18hrdmLwRuIBtqKQvwSlxoVggDjsyRThZrK66u2E93WU72eJ
         18g74to+p/vEDPnTM1uZ8MNegAtf84hOMyg1KFpY26vJO32kjrQeq/7ummR/JH0Acw
         A3diqOt9xrXDecZUJaH1VITNcNHmEZg4Nc7KDxjc=
Received: by mail-wr1-f50.google.com with SMTP id w13so16310065wru.7
        for <linux-api@vger.kernel.org>; Mon, 09 Sep 2019 15:57:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVgfO9AAdkh19vAwUky5rpqmWVj7Uw/IxeIz3whVfuTcr1uvsnR
        6cNAHAWE9FRpgESy9MszxcR/aHoJDqeP7VxLXVs7Kw==
X-Google-Smtp-Source: APXvYqwkK4QYU7FXrwSlH8ZO670dJg2wunQHvsqAekznrEWS6XGJSzG1Dw13PoaDb1OrneVUtTBLg8BHjXXLm7S3QWQ=
X-Received: by 2002:adf:dcc4:: with SMTP id x4mr13767482wrm.221.1568069877467;
 Mon, 09 Sep 2019 15:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567126741.git.luto@kernel.org> <20190909094230.GB27626@amd>
In-Reply-To: <20190909094230.GB27626@amd>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 9 Sep 2019 15:57:46 -0700
X-Gmail-Original-Message-ID: <CALCETrXfDSjgNieM3Q9bVH-7gAePXT=SXWxvzOsyb8xp_2ymQA@mail.gmail.com>
Message-ID: <CALCETrXfDSjgNieM3Q9bVH-7gAePXT=SXWxvzOsyb8xp_2ymQA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rework random blocking
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Lutomirski <luto@kernel.org>, Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 9, 2019 at 2:42 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2019-08-29 18:11:35, Andy Lutomirski wrote:
> > This makes two major semantic changes to Linux's random APIs:
> >
> > It adds getentropy(..., GRND_INSECURE).  This causes getentropy to
> > always return *something*.  There is no guarantee whatsoever that
> > the result will be cryptographically random or even unique, but the
> > kernel will give the best quality random output it can.  The name is
> > a big hint: the resulting output is INSECURE.
> >
> > The purpose of this is to allow programs that genuinely want
> > best-effort entropy to get it without resorting to /dev/urandom.
> > Plenty of programs do this because they need to do *something*
> > during boot and they can't afford to wait.  Calling it "INSECURE" is
> > probably the best we can do to discourage using this API for things
> > that need security.
> >
> > This series also removes the blocking pool and makes /dev/random
> > work just like getentropy(..., 0) and makes GRND_RANDOM a no-op.  I
> > believe that Linux's blocking pool has outlived its usefulness.
> > Linux's CRNG generates output that is good enough to use even for
> > key generation.  The blocking pool is not stronger in any material
> > way, and keeping it around requires a lot of infrastructure of
> > dubious value.
>
> Could you give some more justification? If crng is good enough for
> you, you can use /dev/urandom...

Take a look at the diffstat.  The random code is extremely security
sensitive, and it's made considerably more complicated by the need to
support the blocking semantics for /dev/random.  My primary argument
is that there is no real reason for the kernel to continue to support
it.

>
>
> are
>
> > This series should not break any existing programs.  /dev/urandom is
> > unchanged.  /dev/random will still block just after booting, but it
> > will block less than it used to.  getentropy() with existing flags
> > will return output that is, for practical purposes, just as strong
> > as before.
>
> So what is the exact semantic of /dev/random after your change?

Reads return immediately if the CRNG is initialized, i.e reads return
immediately if and only if getentropy(..., 0) would succeed.
Otherwise reads block.

--Andy
