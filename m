Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC677BFA7
	for <lists+linux-api@lfdr.de>; Mon, 14 Aug 2023 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHNSQU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Aug 2023 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjHNSQP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Aug 2023 14:16:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0129310F0
        for <linux-api@vger.kernel.org>; Mon, 14 Aug 2023 11:16:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so72255341fa.0
        for <linux-api@vger.kernel.org>; Mon, 14 Aug 2023 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1692036972; x=1692641772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVt4RUsuv4G99xwx94AYKyo6GYrDM5TMn+Hj2KeMtDg=;
        b=c4VSp7JRQ4R1ioLJSoOzg1kXe0Cu7+DGVdermvHPu8HUgAROvHtmaLZ7AZWRiSs9B0
         S+jUIy2tMlxpuocGCaKUHxdNm3y66320jUnj275yLiVtyRpCHscP6IyCGdmdsXfRn/bk
         9qHmI5owfa3L+6VnhXqqRFnx1NskiVcTqVR5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036972; x=1692641772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVt4RUsuv4G99xwx94AYKyo6GYrDM5TMn+Hj2KeMtDg=;
        b=DRr5sDMNGrDsny+xaNnvWHpHqAtWiMwhIs+pry3S/1qyRtKZociqet9FsS3SxVOlvu
         VqNqw5R44QhWIy8dHMTkDRV9XtIswwUcAxz36gL/dtmit46PZShpwVJn1dBQaPr0J81T
         aUVdiUi+A1fVtUS0skFwM6D1ccMIwX1PzflnzX31yviz9rasbsC35p/F0SuR76l5f/t5
         tgfKm2lPSw4XnxVAvaBwsMymMaWde2LHbHmK2+5WXO1BvBabmyhhRP9UlAjjY9/F7CNs
         PCpZUinjh3yF80e+cdMhyIOO+7auW+NuWM8kpTFPGLXFa0jG2VgPe2CoSvzSzo5K3G6V
         vYAA==
X-Gm-Message-State: AOJu0YwkOHOGyKk9dCSyqmbN9XmkgdyMUnzJyCPou4eZhdlpoPZ15SSQ
        u7ysu/roBzVDowRj0k6taHgz6u50qcFa3PgSvi1dVQ==
X-Google-Smtp-Source: AGHT+IFdy+D60p76IT0qbpqN7bgOHvvMCwZImqTu6sMDUN/sb6qBGEFKuBcEqoGOwxTYjvRG8OmdrSkbuO4kUK1kdr4=
X-Received: by 2002:a2e:95cf:0:b0:2bb:78ad:56cb with SMTP id
 y15-20020a2e95cf000000b002bb78ad56cbmr2295557ljh.37.1692036971945; Mon, 14
 Aug 2023 11:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230810090044.1252084-1-sargun@sargun.me> <20230810090044.1252084-2-sargun@sargun.me>
 <20230811.020617-buttery.agate.grand.surgery-EoCrXfehGJ8@cyphar.com>
In-Reply-To: <20230811.020617-buttery.agate.grand.surgery-EoCrXfehGJ8@cyphar.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 14 Aug 2023 12:15:35 -0600
Message-ID: <CAMp4zn-YfP1Bs_S4B55cbAtkbOg8Do1UK1tVe6K1a2-Bxprx-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] fs: Allow user to lock mount attributes with mount_setattr
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Aug 13, 2023 at 10:41=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
>
> It just occurred to me that the whole MNT_LOCK_* machinery has the
> unfortunate consequence of restricting the host root user from being
> able to modify the locked flags. Since this change will let you do this
> without creating a userns, do we want to make can_change_locked_flags()
> do capable(CAP_SYS_MOUNT)?
>
Doesn't mount_setattr already require that the user has CAP_SYS_ADMIN
in the mount's user namespace?

I'm not sure how this lets us bypass that.

Or are you saying we should check for
CAP_SYS_MOUNT && CAP_SYS_ADMIN?

> > +             if ((new_mount_flags & kattr->attr_lock) !=3D kattr->attr=
_lock) {
> > +                     err =3D -EINVAL;
> > +                     break;
> > +             }
>
> Since the MNT_LOCK_* flags are invisible to userspace, it seems more
> reasonable to have the attr_lock set be added to the existing set rather
> than requiring userspace to pass the same set of flags.
>
IMHO, it's nice to be able to use the existing set of flags. I don't mind
adding new flags though.

> Actually, AFAICS this implementation breaks backwards compatibility
> because with this change you now need to pass MNT_LOCK_* flags if
> operating on a mount that has locks applied already. So existing
> programs (which have .attr_lock=3D0) will start getting -EINVAL when
> operating on mounts with locked flags (such as those locked in the
> userns case). Or am I missing something?
I don't think so, because if attr_lock is 0, then
new_mount_flags & kattr->attr_lock is 0. kattr->attr_lock is only
flags to *newly lock*, and doesn't inherit the set of current locks.

>
> In any case, the most reasonable behaviour would be to OR the requested
> lock flags with the existing ones IMHO.
>
I can append this to the mount_attr_do_lock test in the next patch, and it
lets me flip the NOSUID bit on and off without attr_lock being set, unless
you're referring to something else. You shouldn't be able to attr_clr a
locked attribute (even as CAP_SYS_ADMIN in the init_user_ns).
attr_set will noop.


/* Make sure we can set NOSUID (not locked) */
memset(&attr, 0, sizeof(attr));
attr.attr_set =3D MOUNT_ATTR_NOSUID;
ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);

/* Make sure we can clear NOSUID (not locked) */
memset(&attr, 0, sizeof(attr));
attr.attr_clr =3D MOUNT_ATTR_NOSUID;
ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);
