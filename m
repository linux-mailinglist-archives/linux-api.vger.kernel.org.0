Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF46239D7
	for <lists+linux-api@lfdr.de>; Thu, 10 Nov 2022 03:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiKJCiC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Nov 2022 21:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKJCiC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Nov 2022 21:38:02 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6812717C
        for <linux-api@vger.kernel.org>; Wed,  9 Nov 2022 18:38:01 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-333a4a5d495so3765707b3.10
        for <linux-api@vger.kernel.org>; Wed, 09 Nov 2022 18:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibmMgAXbjjaN11VFsHkJQSJq1cPDMl62aGHSM2/7Qz4=;
        b=TxXbGY6MqrUFhP1+BFe+fijdVfGlWxRoOvFMDVAndTKHK+26MsMdFCXQXMG2yxBXbi
         dlsSY6HPLQZpFRFSa/89Iport3Ifx1iHPE2Ektcf53rTAbBEodSOBD5MlH8u1GoxUw3P
         +s1PnQHOIxXg5x1+skjghrBiWJ0U0wPVZpWyENYf/r4hoSrS97IiIGv9xd0zBQYdVGhm
         D4F23tPM5gPlrlgTQVxR+lIVoTszar6901KoD4/WZfkIQ9neiXc+eYkQQ1Q/ybE4qx0G
         EsdINsnqfEdAzOwo94Ll3rsVlsxNQZWmMMu7+diqzKV/sRsBUGbf0hv1S27WLj9BIw0T
         bjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibmMgAXbjjaN11VFsHkJQSJq1cPDMl62aGHSM2/7Qz4=;
        b=3IaBepGIO++2KP3v5h/kJZ9VgFahPP1q2pWmctHh0BMOlvm8Yv6dLrnZWtfpO/x/3p
         GyK7yH0LWDbskLUC6QwrtW0Rrr8DERwXTOZIx77cbU7v27R6oIsJnMsUHQDSWheR6oBQ
         mKRZhvcFwdKCg5aqsdXw1uq3AVH+DRQQn5RjPix9ZJEwQ/I3BCbdV1tXyucInVtSrVEk
         8WP3Pz65tsvBM/PJEiFpHJaysWhTdmcmNWDe4gE7EhGj5GfF9mXoe8zzCiqofulPiM85
         3VtwdbqHBfzHKqlb89U49qXD+HyLa8eF94vQM6Jke28jwO38fRSEinI/GG3JOYQdQg8C
         0g3A==
X-Gm-Message-State: ACrzQf3v1RyLMc+7CgnB1Q4KF6kbBAsz+5dgeIFwniU02ZxXPAoEfZSA
        QjRsh8SLBje3dz5s63SqTuGXwabrCuP+nuJSFYoe
X-Google-Smtp-Source: AMsMyM68Q6DhzhnyZCPFpqsv/6KaI/umTZlXQ5XcOaYlET4DeZmtbpcInSNhrshaezKk91UO0aDy7ipBqiJ19zpHbmk=
X-Received: by 2002:a81:50d:0:b0:36a:6711:f7dc with SMTP id
 13-20020a81050d000000b0036a6711f7dcmr59100471ywf.276.1668047880011; Wed, 09
 Nov 2022 18:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com> <Y1jMeWl0oV4/2zyE@kroah.com>
 <5396ab1e-9b93-df33-ca49-58dc59459a76@schaufler-ca.com> <Y1olsHWnaEk6+b1L@kroah.com>
 <612c169c-2e11-13cf-9742-19714a247152@schaufler-ca.com> <CAHC9VhR8_aQFxBq4fG=q8FgVUEZAL6F_iSE9kFnO7Mf4tf52AQ@mail.gmail.com>
 <20cdb098-400e-25d0-f93e-98efb1095b68@schaufler-ca.com>
In-Reply-To: <20cdb098-400e-25d0-f93e-98efb1095b68@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 21:37:48 -0500
Message-ID: <CAHC9VhR50=d_pjoxOMX_a8oyKc572BqjJUZD5Mcd8snHHq5WHQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 9, 2022 at 7:57 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 11/9/2022 3:33 PM, Paul Moore wrote:

...

> >   My reason for
> > doing so is rather simple, we're going to treat the ID as a 32-bit
> > value so we have *plenty* of room (just the thought of supporting +4
> > billion unique LSMs is comically insane), and I'd like to try and
> > leave some space for yet-undetermined "special" things that we might
> > need to convey in the LSM syscalls.  For example, this would allow us
> > to convey additional information to userspace when an application
> > asked for labeling information using one of these reserved LSM IDs;
> > applications which did not know (or care) about the special ID would
> > continue to function normally but augmented/new applications would be
> > able to make sense of the additional information ... and we wouldn't
> > have to add a new syscall to do it.
>
> I don't see how
>
>         #define LSM_ID_SPECIAL  2
>
> is better than
>
>         #define LSM_ID_SPECIAL  13
>
> There's no reason to "group" LSM_ID values, nor have a range of them.
> Really, I don't care one way or the other. I will bend to whatever will
> is stronger.

The token values are not intended to be grouped in any sort of range,
it is just easier to say values 0-32 are reserved that create 33 macro
defines like LSM_ID_RESERVED1..LSM_ID_RESERVED32.  The actual token
values shouldn't really mean anything, we could randomly assign them
if that helps get my point across, I just want a few reserved numbers
in the token space to leave room for future unknowns.

It's not like I'm suggesting something that has never been done before :)

-- 
paul-moore.com
