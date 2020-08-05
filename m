Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA66823D17D
	for <lists+linux-api@lfdr.de>; Wed,  5 Aug 2020 22:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHEUBt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Aug 2020 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgHEQkH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Aug 2020 12:40:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87260C061A2A
        for <linux-api@vger.kernel.org>; Wed,  5 Aug 2020 04:27:44 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id df16so15895229edb.9
        for <linux-api@vger.kernel.org>; Wed, 05 Aug 2020 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PziUKsmF372rDIV3S+ngIfNzzFjadVBOy4PT2Nbdg9M=;
        b=ESNQC+z/Z1LEOCf9ToNZZagALOrvVY3U7nd5sdzRXPULMbM6xqR4+e9C/gBHdlhIK9
         32emkrytIlYO22Vqrx5sMWa/8mJm96fGLmkbTQlIXqJuDV0q+qoQmFjtgdryN+NXUGAE
         MLgsqwyTs/PUyDehIURdGhYrpGdnku/6azmIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PziUKsmF372rDIV3S+ngIfNzzFjadVBOy4PT2Nbdg9M=;
        b=Awig5wMFx1HJ7qbxVv3MgZpnJUZ9kT5HQNRsxOG0afC08T/7tpG6HIXD+dqWA5fCpA
         mBfNA3xWQ5UU9IA81Ogypz/dydZ+3x4jQuJZP6Ta+9ViyubzY+T32dUln+9QVK4SjtEQ
         KaKvfKhAo3qXwgr7UohirNti+vEgdztgKzAb1vrpQw4LFiPjVCnjchTeCfkhIVFGdYMD
         jWbYYMAscg3BB/XMIRvTogtLYoyuiSX+jNhcnEvBFVxW+D+XQ9CH0Z1Q/Ze+G7NbEi5r
         AF+ojMWz/3yU2bHDZ6FiDSH6x3u3bHYgf+FXiVZZG6Q2XoLZMra4hiwcEbKGHlIzNbe/
         5S3Q==
X-Gm-Message-State: AOAM532aMjNGxjoEuyACaSmMkWUg26d+wxTzwNdlsa8W6PRNU11bZA77
        JZKaT4m5tnmeCPu0wQt5XxCMx5iHc7ndgxw/6I8TbA==
X-Google-Smtp-Source: ABdhPJwSzAqAkDNRGBwPe3v9vu2XVDG8K6eixn5B+jSbX3QhBOxtZVeQ7GZvk7UuTYsR/liT1yvsvfZHUm//pGefN8E=
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr2258430eds.212.1596626862700;
 Wed, 05 Aug 2020 04:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
 <20200804135641.GE32719@miu.piliscsaba.redhat.com> <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
 <5078554c6028e29c91d815c63e2af1ffac2ecbbb.camel@themaw.net>
 <CAJfpegs1NLaamFA12f=EJRN4B3_iC+Uzi2NQKTV-fBSypcufLQ@mail.gmail.com> <e1caad2bff5faf9b24b59fe4ee51df255412cc56.camel@themaw.net>
In-Reply-To: <e1caad2bff5faf9b24b59fe4ee51df255412cc56.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 13:27:31 +0200
Message-ID: <CAJfpeguvTspY7pi52n1aznebCF2jYki40hy5idkgu1D2y6C6mg@mail.gmail.com>
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

On Wed, Aug 5, 2020 at 1:23 PM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2020-08-05 at 09:45 +0200, Miklos Szeredi wrote:

> > Hmm, what's the other possibility for lost notifications?
>
> In user space that is:
>
> Multi-threaded application races, single threaded applications and
> signal processing races, other bugs ...

Okay, let's fix the bugs then.

Thanks,
Miklos
