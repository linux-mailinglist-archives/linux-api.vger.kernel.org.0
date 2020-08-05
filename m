Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0744323C7B2
	for <lists+linux-api@lfdr.de>; Wed,  5 Aug 2020 10:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgHEIY4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Aug 2020 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgHEIYp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Aug 2020 04:24:45 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222CFC061757
        for <linux-api@vger.kernel.org>; Wed,  5 Aug 2020 01:24:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so19649145ejc.2
        for <linux-api@vger.kernel.org>; Wed, 05 Aug 2020 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRkoVvZyMZKrXPZJsbTSg0eFnj2VcDca+RKzJ60eyTc=;
        b=UYk0LJ7zSStHb1U495GvSSdmH6LUhiPYmcg6PAq1rMqY11Eyd7mimZZrA3M0EtvJUe
         vvHGhC/9MvozJfhIiIgBsFE7xq5Hm++FVNDlJ2kUw02Jto10O7BN/4nzlscTmBPJj7xg
         U2829Bced+hHMLcR8pAqx46/TL8W7/1KfFh6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRkoVvZyMZKrXPZJsbTSg0eFnj2VcDca+RKzJ60eyTc=;
        b=R3Nj74KKsMJ/V9HbWLwgjPLc8qJTeksKEJuXgdMmaj3VCzWg6/bRjQoAnADcDPUoAm
         j7Xbofcfgd3fbYRbZ/TmPFBO7Ci8b4vLmfceE2ZTHYjhehCV/eb03KJ+80kWnxyR/YLM
         nb5IHvuxKIOYd1Yjc6AI1w/mcZ1n66oNDH5EHpkWlTgSmd2QNbz5dTzEpUXRLFQnYKSM
         6ZU6wiKNLnodiZKK4GPbNVijwNUhCzDcGh5ngRzTyKXb9feJ3jbsZ+S3m9pliv4rGOhr
         N8kDl6D/uqfnYU9gzij7KEXPwF52ErlteatxyiDMeKzg416jZBZN8WNzV8oiexTbBYpy
         +Xsw==
X-Gm-Message-State: AOAM530lfgeCg/3HnypB+KAMuIZxCKV2Jfmx6+9sSzcdN/hLg3paPOq6
        VmL2sL1LziKT1ZEQpvVvwTLOZi8qAf1sjp1q744agw==
X-Google-Smtp-Source: ABdhPJxrLumgFgqYyoKDBG2k5IrM0kpKGeRUM6PbmX2nVN5dA62HAF0gWDOE78RgoqsR4O8I2bJbm1frFluN5es5kOU=
X-Received: by 2002:a17:906:22c1:: with SMTP id q1mr2028127eja.443.1596615874689;
 Wed, 05 Aug 2020 01:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net> <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
In-Reply-To: <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 10:24:23 +0200
Message-ID: <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
Subject: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 4, 2020 at 4:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:

> I think we already lost that with the xattr API, that should have been
> done in a way that fits this philosophy.  But given that we  have "/"
> as the only special purpose char in filenames, and even repetitions
> are allowed, it's hard to think of a good way to do that.  Pity.

One way this could be solved is to allow opting into an alternative
path resolution mode.

E.g.
  openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);

Yes, the implementation might be somewhat tricky, but that's another
question.  Also I'm pretty sure that we should be reducing the
POSIX-ness of anything below "//" to the bare minimum.  No seeking,
etc....

I think this would open up some nice possibilities beyond the fsinfo thing.

Thanks,
Miklos
