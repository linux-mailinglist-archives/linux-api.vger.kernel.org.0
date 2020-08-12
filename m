Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5C5242E79
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHLSYq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 14:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLSYq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 14:24:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19499C061383
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 11:24:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so3359500ejc.2
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5NX6kMDP5qmBpQCPkWzwhmOd6ct20g0CcQwpleYHFc=;
        b=US2q3MwnTSjWfqpie9O3CRcizx9uSCz4S3vkL7p/ooj414+R066sTYC3Q4A4VD1OD6
         WbBdeRdiPaC//fSZsRo3WOoZpu8gTtAt7k7tMZ8hwJVqEhGHjLO4oOIslMbvG22T1LrR
         FvpBZZmDKWHcNGLeiM+6hKFDuuH8IvkNuF9T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5NX6kMDP5qmBpQCPkWzwhmOd6ct20g0CcQwpleYHFc=;
        b=X36Cd5mfKXj9BvOecCeWCyAlTScO+Jn6Fpx1Q1JQbdkLPa6qJGGZa3BSlX8BMtcvnK
         Y254ojmvXhUOY+drxqrP6TGfx7d2aV0i/O37uMT34oVtjbT8ZxhHXhXKGxYNAJGALKcn
         69T35oB5YpdQi0EOeggdjOyrDod536w+FVZdBiyOj4/lfiZ/cNJaatwaYgCG6Gm8S402
         75WIhoVJqBH1HuPn+l/HM4hm3YcsbvhCybkfgVgxg4vZSNJTZsU1X6CuIbYCI/yVurHO
         ECzPndtVKgK7/1HLmEOYP7LY/hhhWPVeiStnr/HhhZbBeA+SjoofCxyINzN9Qt7Trlbf
         FuYQ==
X-Gm-Message-State: AOAM532P76xMkQb2R7tZZ6SOzkaeLzAMaOQH0feJ1llImsCaP4WxIS9v
        q+2MusjRkTJQJEJfHKPBcg+pXmcAd28=
X-Google-Smtp-Source: ABdhPJy3hBNU+hEYx3wuvCaRT5B8ecaY3u8GAuEP3EPpUoPVec0lUzkunr8xo3v+4t9adokLMRXhig==
X-Received: by 2002:a17:906:fa0c:: with SMTP id lo12mr1149401ejb.390.1597256684341;
        Wed, 12 Aug 2020 11:24:44 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 89sm1996865eda.6.2020.08.12.11.24.43
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 11:24:44 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id ba10so2267332edb.3
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 11:24:43 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr315813lfa.192.1597256320205;
 Wed, 12 Aug 2020 11:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk>
In-Reply-To: <52483.1597190733@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 11:18:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Message-ID: <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 11, 2020 at 5:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Well, the start of it was my proposal of an fsinfo() system call.

Ugh. Ok, it's that thing.

This all seems *WAY* over-designed - both your fsinfo and Miklos' version.

What's wrong with fstatfs()? All the extra magic metadata seems to not
really be anything people really care about.

What people are actually asking for seems to be some unique mount ID,
and we have 16 bytes of spare information in 'struct statfs64'.

All the other fancy fsinfo stuff seems to be "just because", and like
complete overdesign.

Let's not add system calls just because we can.

             Linus
