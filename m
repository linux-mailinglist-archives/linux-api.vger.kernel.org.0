Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6071E627DE2
	for <lists+linux-api@lfdr.de>; Mon, 14 Nov 2022 13:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiKNMgN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Nov 2022 07:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236734AbiKNMgK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Nov 2022 07:36:10 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016B248D9
        for <linux-api@vger.kernel.org>; Mon, 14 Nov 2022 04:36:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id y14so27942459ejd.9
        for <linux-api@vger.kernel.org>; Mon, 14 Nov 2022 04:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sU9x5ssg8XOYMe/rb8up2J+YLGp3IkvlIELqEyeyXlY=;
        b=NnWstm8DqlCqRdyMglLY7MPEfHjK68m/pRvlqV3oel5H8vqtXc3KtfhohAcqmB6ke5
         xIAoh3nDcghJ7DPQkq4B4QYfHnEbnKMgkpttObeK4MFq+jiRO5xIZJyJsZycus/ajUhU
         sEgbjUbiNBPFKDfWaa/cDrm/umRrNjbBJ3XBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU9x5ssg8XOYMe/rb8up2J+YLGp3IkvlIELqEyeyXlY=;
        b=sWdC+f19DPItMGKoX6S+cEGHswxXR3YZ/qu0REbhEqaOSc1DZj86rixNj28rjYjYEH
         8r/R2j0xLLuh4kOZgTxYnDSm8UIJ5/00STGin4eq9TC2zwvRJjx3gUCIXArD49Bv28yy
         N5/3+5C6SLfiraZ0C2rXUUWu1hOnQQQAv6ZpM8us+AkJob54wn9ll28qNBnWbw5gMbZB
         H8aFqwRNspvm8GNdHjdo0Z9UJkHorbS/1z8HUzSJ1xyQ925akMpgSSMBHD1nBnKPlaA6
         SiEtTZki0XymZjuP3cXP51KtzH16jqMwZkFRIxCCoW+buNOTor8O0rcaKyEK8qr+hJ0A
         e7Og==
X-Gm-Message-State: ANoB5pkIhmE5YOWwFWtL/6zeloOocPXYu51faJyd8ERsdfTU4lENyJ7C
        IO3SjFN5lpcq6PIXqqvp9JIBgl6Z1exesMQZHnIiEA==
X-Google-Smtp-Source: AA0mqf7xxaXCQcsg9ZYGxFJ3RjLGgBQ3wnQMAUrceAXa9Wi66rhSV8regTVEEtLmw7PnnQh0JiI+9kMluq/F6yfI28I=
X-Received: by 2002:a17:906:a044:b0:7a5:a671:8236 with SMTP id
 bg4-20020a170906a04400b007a5a6718236mr10321692ejb.187.1668429365397; Mon, 14
 Nov 2022 04:36:05 -0800 (PST)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
In-Reply-To: <e57733cd-364d-84e0-cfe0-fd41de14f434@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Nov 2022 13:35:54 +0100
Message-ID: <CAJfpegsVsnjUy2N+qO-j4ToScwev01AjwUA0Enp_DxroPQS30A@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 14 Nov 2022 at 10:00, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Hi Miklos and anyone interested in this proposal, is there any update on
> this? Sorry that I didn't find any..

No update.

Which part are you interested in?

Getting mount attributes?  Or a generic key-value retrieval and
storage interface?

For the first one there are multiple proposals, one of them is adding
a new system call using binary structs.  The fsinfo(2) syscall was
deemed overdesigned and rejected.  Something simpler would probably be
fairly uncontroversial.

As for the other proposal it seems like some people would prefer a set
of new syscalls, while some others would like to reuse the xattr
syscalls.  No agreement seems to have been reached.

Also I think a notification system for mount related events is also a
much needed component.   I've tried to explore using the fsnotify
framework for this, but the code is pretty convoluted and I couldn't
get prototype working.

Thanks,
Miklos
