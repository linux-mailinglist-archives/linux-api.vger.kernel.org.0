Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B232F4E60C2
	for <lists+linux-api@lfdr.de>; Thu, 24 Mar 2022 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349044AbiCXI7O (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Mar 2022 04:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345575AbiCXI7K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Mar 2022 04:59:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC899D0C7
        for <linux-api@vger.kernel.org>; Thu, 24 Mar 2022 01:57:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dr20so7739872ejc.6
        for <linux-api@vger.kernel.org>; Thu, 24 Mar 2022 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ6s65rDvN8Tqn0qDZEB8Ijp4jvPh0GyNpSk/ZtB3pI=;
        b=m8uvN3vl8Uzj9zAwWsZQwJeD4SgdTCd74DSTmwxQoZYwKcDUMIa06VjnueJ49ViSg6
         AH6m1oASGMxV+L7gbdqnZl0DsC1kLdBlx0tkhj9scA0ROyULs+xnhqKjG+EjiECTe9v9
         fHLplZ4INS5E2/hQbGf40wOuvgjoBCnl4uueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ6s65rDvN8Tqn0qDZEB8Ijp4jvPh0GyNpSk/ZtB3pI=;
        b=OMuVnlbFHAWBMxhoYE/pXhsVQgVbyIwaQLSyyPmyiCXZ1hf8tu4fpzB1qJRtsM/E3Y
         QMpR08qNscEOWYvGkWmaSrZ7cRUV0Nl6vTlMkI6B4patjIFvWY8g0gPojucwcEBXWtcv
         XlObeGdp1/yp1XV+k7WpAB1D+piggmIPdibuPu1zuIdwhikUblIHNVe/WZ7jBj1ceed5
         /Bnzim/SvTplGrTVIkX5+nG6SkCmhdu0L1cgASH4BlGgVi7lAzRwwvOnxGLFwSJBo3bB
         vOrytvHw2R7uMVCF3S0I+GSSX5Dxf9eIBOD24QL59Yj+XIS2ZgTPnb8JpOKYqUggj7bT
         TkYg==
X-Gm-Message-State: AOAM530lvXELlfjm76iWrs7jGECpVL1vWKg2Z1qSmjN99Y2Q2ttU8/HL
        CSLGkJZjpR9dtrhycfP5qprTJjClYFn3b31ZIoGJXw==
X-Google-Smtp-Source: ABdhPJz7TgZDeh0+kDj2ymXCRjzBF8dMmiYeu1yauoVqNwsy2kRkXd9LUCYEVYbpcsr51BEAZ9P7D4i0qDYXH2dm+jA=
X-Received: by 2002:a17:907:c16:b0:6db:1dfc:ca73 with SMTP id
 ga22-20020a1709070c1600b006db1dfcca73mr4602838ejc.192.1648112257373; Thu, 24
 Mar 2022 01:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323225843.GI1609613@dread.disaster.area>
In-Reply-To: <20220323225843.GI1609613@dread.disaster.area>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 24 Mar 2022 09:57:26 +0100
Message-ID: <CAJfpegv6PmZ_RXipBs9UEjv_WfEUtTDE1uNZq+9fBkCzWPvXkw@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 23 Mar 2022 at 23:58, Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Mar 22, 2022 at 08:27:12PM +0100, Miklos Szeredi wrote:

> > - Interfaces for getting various attributes and statistics are fragmented.
> >   For files we have basic stat, statx, extended attributes, file attributes
> >   (for which there are two overlapping ioctl interfaces).  For mounts and
> >   superblocks we have stat*fs as well as /proc/$PID/{mountinfo,mountstats}.
> >   The latter also has the problem on not allowing queries on a specific
> >   mount.
>
> https://xkcd.com/927/

Haha!

> I've said in the past when discussing things like statx() that maybe
> everything should be addressable via the xattr namespace and
> set/queried via xattr names regardless of how the filesystem stores
> the data. The VFS/filesystem simply translates the name to the
> storage location of the information. It might be held in xattrs, but
> it could just be a flag bit in an inode field.

Right, that would definitely make sense for inode attributes.

What about other objects' attributes, statistics?   Remember this
started out as a way to replace /proc/self/mountinfo with something
that can query individual mount.

> > mnt                    - list of mount parameters
> > mnt:mountpoint         - the mountpoint of the mount of $ORIGIN
> > mntns                  - list of mount ID's reachable from the current root
> > mntns:21:parentid      - parent ID of the mount with ID of 21
> > xattr:security.selinux - the security.selinux extended attribute
> > data:foo/bar           - the data contained in file $ORIGIN/foo/bar
>
> How are these different from just declaring new xattr namespaces for
> these things. e.g. open any file and list the xattrs in the
> xattr:mount.mnt namespace to get the list of mount parameters for
> that mount.

Okay.

> Why do we need a new "xattr in everything but name" interface when
> we could just extend the one we've already got and formalise a new,
> cleaner version of xattr batch APIs that have been around for 20-odd
> years already?

Seems to make sense. But...will listxattr list everyting recursively?
I guess that won't work, better just list traditional xattrs,
otherwise we'll likely get regressions, and anyway the point of a
hierarchical namespace is to be able to list nodes on each level.  We
can use getxattr() for this purpose, just like getvalues() does in the
above example.

Thanks,
Miklos
