Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA894E5520
	for <lists+linux-api@lfdr.de>; Wed, 23 Mar 2022 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbiCWPZT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Mar 2022 11:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245104AbiCWPZS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Mar 2022 11:25:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83424DF7F
        for <linux-api@vger.kernel.org>; Wed, 23 Mar 2022 08:23:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o10so3572515ejd.1
        for <linux-api@vger.kernel.org>; Wed, 23 Mar 2022 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlS/fdRq6hH9/s3MjXNnayc2lVeeN15N6DspmLurFGc=;
        b=jNl4Povv1P5H6dTnpwFVsSxe3b46c3nud3i9Aj/69tJIIyEVuLAlkNlWc+scUTvntB
         uXj4WCJwCKQDrvi5WHHpsfydkbN38SdEHthpMbgM0jdgl/C1GDFTt3UhWR/6Kfa1J9Am
         rlyx19X9S2SwlH7Uq3aWcksl9m15lSuh6UoLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlS/fdRq6hH9/s3MjXNnayc2lVeeN15N6DspmLurFGc=;
        b=H+3Xn+DBLy/S99qyLdXK7Rzm/5wt+GiLfyG9VQfryk44Uy82Biso3SD6OSi9WBM9Xe
         1iOlV2p6+tWjA0XX+wemuGpXtl00Qkj8wCGaqW/G9cVC1UMICsd6Defi4PKsG1cPxr8B
         FJ7GVOKUPVKs/7P+E69ULvkiFcc9quh9BKEU/wKsj4ckrr+ZDFPHPJybCmI3gx2Whv5s
         FTzLOPUVueren0ME6cRW3sSrasfatue1KKvzX3La839Yo4Qf3bjgOas6nhIMWhdvQOLL
         av/JJmqqE8+d4ToZRQwY7xwwniwqONEho8psbgHFaA6ucpIaQG50y53I0bxPEle+6dII
         9vwQ==
X-Gm-Message-State: AOAM531WPlG3g5CrQUzDoVS9I9m6b0uTAmQiKhz2trBb6uHxhVUtzs2u
        QT+2+wqfKL3iw60oYdOyKhYdsu8zIbCadZHMulR+dA==
X-Google-Smtp-Source: ABdhPJynCIbGxWaH8VNgO7K5SrWmTQgikKoqtYUaFhM+Y0JZe0+LMfjLZkQj57fx03puzkf/rf2QsmRsUGBWm5AVktQ=
X-Received: by 2002:a17:906:c259:b0:6ce:a165:cd0d with SMTP id
 bl25-20020a170906c25900b006cea165cd0dmr546068ejb.270.1648049026221; Wed, 23
 Mar 2022 08:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com> <Yjsiv2XesJRzoeTW@kroah.com>
In-Reply-To: <Yjsiv2XesJRzoeTW@kroah.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Mar 2022 16:23:34 +0100
Message-ID: <CAJfpegsBmed6dchjgVeQ-OPGYBiU+2GPgsoJegjuPTrcLs6-8g@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
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

On Wed, 23 Mar 2022 at 14:38, Greg KH <gregkh@linuxfoundation.org> wrote:

> This has been proposed in the past a few times.  Most recently by the
> KVM developers, which tried to create a "generic" api, but ended up just
> making something to work for KVM as they got tired of people ignoring
> their more intrusive patch sets.  See virt/kvm/binary_stats.c for what
> they ended up with, and perhaps you can just use that same type of
> interface here as well?

So this looks like a fixed set of statistics where each one has a
descriptor (a name, size, offset, flags, ...) that tells about the
piece of data to be exported.  The stats are kept up to date in kernel
memory and copied to userspace on read.  The copy can be selective,
since the read can specify the offset and size of data it would like
to retrieve.

The interface is self descriptive and selective, but its structure is
fixed for a specific object type, there's no way this could be
extended to look up things like extended attributes.  Maybe that's not
a problem, but the lack of a hierarchical namespace could turn out to
be a major drawback.

I think people underestimate the usefulness of hierarchical
namespaces, even though we use them extensively in lots of well
established interfaces.

Thanks,
Miklos
