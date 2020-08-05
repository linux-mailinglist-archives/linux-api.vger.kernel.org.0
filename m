Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D6223C724
	for <lists+linux-api@lfdr.de>; Wed,  5 Aug 2020 09:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgHEHqH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Aug 2020 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgHEHqG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Aug 2020 03:46:06 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01EDC06179E
        for <linux-api@vger.kernel.org>; Wed,  5 Aug 2020 00:46:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o23so17884972ejr.1
        for <linux-api@vger.kernel.org>; Wed, 05 Aug 2020 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcRNpeqICVUMdW+eQV6cNmoTKrDCq48jfX1KaVHDvwQ=;
        b=Feg85hqy7+vcolCIrLFilOaGgrOtXj8thXykBp3Bp0XpYsuPfElOh4nm8I3SnyS62b
         64JD9H/zVxxGypHdTvYO2f1EJ0uPlTosWe53MpIC26xzA7XHbleGbFMLSSofhpx5X7gL
         6fThps3gz64rNFTjpg3m0BIu77PqTCGcRQciM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcRNpeqICVUMdW+eQV6cNmoTKrDCq48jfX1KaVHDvwQ=;
        b=HZZK7mpIodCG3qeCARhH8IceaerDR6qfY9oi7Gu5UMqcsrV/bCC2/sjKRjRvXRLJzc
         u5/ci7JOkuJEgAlob0aCYVhACc8XTNBhejSRdqtHvlICchyBwLYifsDoFl/1g4iQ6xLt
         r9BHj/rhyKkxY1/J66FOufD8JK+LlajjrHfgz39SlMD27lK4RRTgEvFa0W6qoh+iFJ36
         9z28KiTpjW8aW1a82Eo+UGgIAk4CMSZ4kRCJZR+KOhXtM2EQVmrLStk5RRGwsNHH3jrg
         FNSMyr4Rd+ETuvZDHHQB3LJpNkUftUJvfHHQp1HJEgVAkmu/cDnWvhZzyQDSdmS7GG4G
         8+mw==
X-Gm-Message-State: AOAM5322MYDF7wm3SB5DqvDY+gAzSI8gnvNNMQdLWsP5Yib+T4XJgQdx
        GbIBrE7l8ggqyqwCZKd8EPcTWlO/f9ULN/o59GhKSA==
X-Google-Smtp-Source: ABdhPJwSzf7ZyfM06Ap8zJ46vCH2qMZs0q/mJf/FF/mKV8B2cn3vTn5+kSxcusIr/7oVCz9jGqzaVrb7ONfCeuEjpiI=
X-Received: by 2002:a17:907:405f:: with SMTP id ns23mr1832194ejb.511.1596613563524;
 Wed, 05 Aug 2020 00:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
 <20200804135641.GE32719@miu.piliscsaba.redhat.com> <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
 <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
In-Reply-To: <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 09:45:52 +0200
Message-ID: <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 5, 2020 at 4:46 AM Ian Kent <raven@themaw.net> wrote:
>

> Coming back to an actual use case.
>
> What I said above is one aspect but, since I'm looking at this right
> now with systemd, and I do have the legacy code to fall back to, the
> "just reset everything" suggestion does make sense.
>
> But I'm struggling to see how I can identify notification buffer
> overrun in libmount, and overrun is just one possibility for lost
> notifications, so I like the idea that, as a library user, I can
> work out that I need to take action based on what I have in the
> notifications themselves.

Hmm, what's the other possibility for lost notifications?

Thanks,
Miklos
