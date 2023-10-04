Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810A67B8D65
	for <lists+linux-api@lfdr.de>; Wed,  4 Oct 2023 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjJDTXN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Oct 2023 15:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjJDTXM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Oct 2023 15:23:12 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85F90
        for <linux-api@vger.kernel.org>; Wed,  4 Oct 2023 12:23:06 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d894b8b9b7cso217059276.1
        for <linux-api@vger.kernel.org>; Wed, 04 Oct 2023 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696447385; x=1697052185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/ns+6ihjkXsP/aV2Eqg7/uCCGKWdL+RZzqUracZZqM=;
        b=CBv93kLy16UJwkedMnfsXcxSCWst2FZsyzIpbWICB9Z8jLO2Kqktnl1kpB39xk7A9E
         1csNO4SqtVjPkHx0qYFS9L7qRI972DO0fMfXNULCeLZWfUi8PphJOjdPu2FCHLflgbK8
         6vjEwdSjpNPL8DPCECLZxLcbwqm8CQ84BPcfrvMLkpjr3eBAUQDXTGE6t8LaKUSj2PXv
         tRS5bvfjOpPynjD33bbpTlJB1L9+qswqiyAcLDBTNa/IIb4sR2V820HDVG9d919xYP9X
         fSy/8ZnpOME5ODFnEycpqLN3R30VGiNgIY8TvTZWba1nU5S0hDYxggNhDA8B2hXXtcUi
         G+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447385; x=1697052185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/ns+6ihjkXsP/aV2Eqg7/uCCGKWdL+RZzqUracZZqM=;
        b=f73q7wpN1R5C+HZbyi7lZ4VMBEMJW5MbfjJwwrYDIEZlq0pJ+/N7MnplseZKJdFn+U
         f85M3dFduVd2QFjTjlPvRTH2cb7Im/rplx1TTROtQU4v1KxyCAkZTV5mWf6X4meIc92E
         U8uWoVvKb5FcmQYijFeHubL1dLh6vo0sZuM3KX1/46/T+sfym8vsAm5m86gwPj3iwVoK
         dU5SM3sD2DBWM2Qag1r/nX++Xoavxja8AOtvYKY1asWgcHinZzO35/IMkVWk0c40ODC0
         f0cia+9Pb/JNpDYiyO0V0HcZFyX/zs2FYRVXK57gRiAhe7l6oaD7SGvk6gueVAnNkLS2
         QW+w==
X-Gm-Message-State: AOJu0YzX3OAdle7M5+WBCeTvYtqf85N/hNWSXGesSRKPQXVTY0gFvl6F
        6cYsz4vH/x8v0cC9qGMHlr7tfpXzmxMUkrZyPN5R
X-Google-Smtp-Source: AGHT+IEBtB1p2lsaO9xIDleJL0myphgAgvBS4Mq+KPupw6UrSl5kJOTBLtJcCni2AbLDyLbU8+wZxZHvnw7Ebc9NcjU=
X-Received: by 2002:a25:d381:0:b0:d81:89d4:ffd9 with SMTP id
 e123-20020a25d381000000b00d8189d4ffd9mr493720ybf.31.1696447385121; Wed, 04
 Oct 2023 12:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-4-mszeredi@redhat.com>
 <20230917005419.397938-1-mattlloydhouse@gmail.com> <CAOssrKcECS_CvifP1vMM8YOyMW7dkGXTDTKY2CRr-fPrJk76ZA@mail.gmail.com>
 <20230918-einblick-klaut-0a010e0abc70@brauner> <CAHC9VhQsChQO9aaY+NTtmvJgXBodvXO6rUN3d7ZyHGqitLBABw@mail.gmail.com>
 <CAJfpegtJwcS9=7dCAVCEoBwD_U2MX44a6B62iDsc78AZt6nM7Q@mail.gmail.com>
In-Reply-To: <CAJfpegtJwcS9=7dCAVCEoBwD_U2MX44a6B62iDsc78AZt6nM7Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Oct 2023 15:22:54 -0400
Message-ID: <CAHC9VhQvpGUVzv=6M9f4NNn_qi+kjHPMVoppmSitHs6HVgZDOg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 28, 2023 at 6:07=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
> On Tue, 19 Sept 2023 at 18:48, Paul Moore <paul@paul-moore.com> wrote:
>
> > > Ideally we avoid multiple capable(CAP_SYS_ADMIN) calls by only doing =
it
> > > once and saving the return value. capable() call's aren't that cheap.
> >
> > Agreed.  The capability check doesn't do any subject/object
> > comparisons so calling it for each mount is overkill.  However, I
> > would think we would want the LSM hook called from inside the loop as
> > that could involve a subject (@current) and object (individual mount
> > point) comparison.

My apologies, I was traveling and while I was quickly checking my
email each day this message was lost.  I'm very sorry for the delay in
responding.

> The security_sb_statfs() one?

Yes.

> Should a single failure result in a complete failure?

My opinion is that it should only result in the failure of that
listing/stat'ing that particular mount; if other mounts are allowed to
be queried than the operation should be allowed to continue.

> Why is it not enough to check permission on the parent?

Each mount has the potential to have a unique security identify in the
context of the LSM, and since the LSM access controls are generally
intended to support a subject-verb-object access control policy we
need to examine the subject and object together (the subject here is
@current, the object is the individual mount, and the verb is the
stat/list operation).

Does that make sense?

I'm looking at the v3 patchset right now, I've got some small nits,
but I'll add those to that thread.

--=20
paul-moore.com
