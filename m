Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D6B23CD26
	for <lists+linux-api@lfdr.de>; Wed,  5 Aug 2020 19:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHERWB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Aug 2020 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgHERTs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Aug 2020 13:19:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239F1C061756
        for <linux-api@vger.kernel.org>; Wed,  5 Aug 2020 10:19:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id di22so25939868edb.12
        for <linux-api@vger.kernel.org>; Wed, 05 Aug 2020 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggWm0T5pBn7JnigTAPRbmUTfRdvzxQl+mpQ72rR0fUs=;
        b=PoP10f4tjqT5dS5d/uwUo+sqOTBfpYa07l9Dp61aeW+rv082Wx5BtKN+1bCLsTJF1U
         nUbzGtQNIwu2lxwjJRDipJ2qANYW9dxqDIcqBjZ++7ZQUP3W/BTxTY/e3PVATg5z5PlD
         fovDZooeuStLnEv4MVI4Zsu2xoFIEnyOrC3BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggWm0T5pBn7JnigTAPRbmUTfRdvzxQl+mpQ72rR0fUs=;
        b=UARRnSwtsta6UkW2XM1CUTvvoZHtHSR3Mk1iXZmg+I4G35v42MoZyz2n+YYJ7VLrpz
         7mjt8q32UC2fNqvYEYtcownoPaoimXN452xT3BXoUgXXP+fjjb6Fw+lmMohvwuwbYtGh
         AvqLX/M638e7dvRYZPn1+XtFnSgyyZfesI8Lh3gIgJtJtzjJxRCC4FNMjxTjl9GHDHEO
         ccavuBQPKji5ncEesZCY4eduYik+OH7ModBymS9v/MItQmksCpcKnUCHgfPPiEa87m8q
         eR3/T9KODhJPE6DNvnaTI6lEPNV0QbKJvbI9vOoRZKTYltjkHWVc1C17iym2Per4FZhS
         8/ug==
X-Gm-Message-State: AOAM531bg2jZOLGwv0aCrGyhM5xu3xe+q30BNTzO066/B/uHpES4JAkW
        QL+OwbvcXvGjusM0fJfdur5H7QnBBZBbNAVgjV0uBA==
X-Google-Smtp-Source: ABdhPJxDf4TG2ZDbOcy/ueJc/nhD6cuCUKJp/4SEeu6p3T512+TCDX0Q15WYk1mR9VBwMmf6ImGgphnQt/h+li9HEKQ=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr288635edx.358.1596647986830;
 Wed, 05 Aug 2020 10:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646185371.1784947.14555585307218856883.stgit@warthog.procyon.org.uk>
 <20200804133817.GD32719@miu.piliscsaba.redhat.com> <2316806.1596641851@warthog.procyon.org.uk>
In-Reply-To: <2316806.1596641851@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 19:19:35 +0200
Message-ID: <CAJfpegvZqZBFb2--W315CXX40F=jLNxYK1EpVRRnn8crGUuLDw@mail.gmail.com>
Subject: Re: [PATCH 08/18] fsinfo: Allow mount topology and propagation info
 to be retrieved [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
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

On Wed, Aug 5, 2020 at 5:37 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > +   __u32   shared_group_id;        /* Shared: mount group ID */
> > > +   __u32   dependent_source_id;    /* Dependent: source mount group ID */
> > > +   __u32   dependent_clone_of_id;  /* Dependent: ID of mount this was cloned from */
> >
> > Another set of ID's that are currently 32bit *internally* but that doesn't
> > mean they will always be 32 bit.
> >
> > And that last one (apart from "slave" being obfuscated)
>
> I had "slave" in there.  It got objected to.  See
> Documentation/process/coding-style.rst section 4.
>
> > is simply incorrect.  It has nothing to do with cloning.  It's the "ID of
> > the closest peer group in the propagation chain that has a representative
> > mount in the current root".
>
> You appear to be in disagreement with others that I've asked.

Read the code.

Thanks,
Miklos
