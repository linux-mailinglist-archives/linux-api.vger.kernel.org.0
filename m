Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997647975CA
	for <lists+linux-api@lfdr.de>; Thu,  7 Sep 2023 17:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjIGP5C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Sep 2023 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjIGPzx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Sep 2023 11:55:53 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C093F1
        for <linux-api@vger.kernel.org>; Thu,  7 Sep 2023 08:44:34 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d7b8d2631fdso1036259276.3
        for <linux-api@vger.kernel.org>; Thu, 07 Sep 2023 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694101404; x=1694706204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJwiLCwXL5rDx/3xJF3NTgzQyqb2GvdFqAIh7xl7cvo=;
        b=O99olysGvkdGHeVoQUzuCejBnIZeuWek2JQ6WIwVH1aSwiEZJrBbLpmeaydE7qEK6H
         Fqm23xq9AfnWmTof/Vv6S9ZNnIOZQIjzL4UCdamLMIq+5phfo/z4xNEndgNfp3s2p1wK
         ItM7rM26GxI8aQuOLWvkkwbhQHzedgXi0GwUO/iXvmrz6YDfQhkBaI9TvLVEJJXxub6N
         t7hbk2FU4bwlxtra/8MVXsJotfkhrRO64BmlgnKeP+gyBVXJJcFsHuGAri0MFeYUxc5W
         KZcvAA3eulwiE+LG1HNLvFBw3as0Zq++yWlD3vq4Qwp2BLnQqNzivgOApV9GruR5DVTj
         Cwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101404; x=1694706204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJwiLCwXL5rDx/3xJF3NTgzQyqb2GvdFqAIh7xl7cvo=;
        b=bI1TpYAlZfDtnYzlQ9o5cKKCuakfOpOyoxES1HdUj3NfFaN9FVLlyWgoO8ASTZbPI0
         IcBDZqs0ZgQJkzYPqKVZK33pKGMQh0wBtbp/f3PldcY3diuKGznLyuz6tg8jynUouDoi
         Y13awTxiZK9pDgLZJY74Wkqoyd+LaEc2ZXH4/ed8gMsC3YyMLqHZgGKIDq895Jolve0F
         QN7SlWKingwuxmYHVibsHV02Rz7sAjbyJ0hiKVkrO+lhK+x6kLpsJfcv147JTQC8uPq/
         PHTXdPdy6A8bsOH13ijMDHCw3Ov1ZQzfyNmGJpsPkiGB7L46t6KGnvP1OtATcbjBzihG
         TxVw==
X-Gm-Message-State: AOJu0YyMxkufKUzKj8ORT0hA9OkDZ/JVejTvaIFxXxetIVUxNzC8/voP
        qCbItGX/624cgjRk3KFpb10MDwP2651A3luKrG8p
X-Google-Smtp-Source: AGHT+IEUUqyNxdXyv9pcZLkajlIM1eHKnYW6/hIdYEFhtMKzXv4dpUIIS5Aq9n0oaOSorWiWPNDEAdRfVuOI8ysxqnU=
X-Received: by 2002:a25:ce93:0:b0:d7e:be01:baaa with SMTP id
 x141-20020a25ce93000000b00d7ebe01baaamr17438385ybe.11.1694101403948; Thu, 07
 Sep 2023 08:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230828195802.135055-5-casey@schaufler-ca.com>
 <6bdfc1b73926b16fc4eea848f25275ed.paul@paul-moore.com> <fd1981c0-3f64-adb5-dece-a25494119992@schaufler-ca.com>
 <20230907.eFie4boo3sei@digikod.net>
In-Reply-To: <20230907.eFie4boo3sei@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Sep 2023 11:43:13 -0400
Message-ID: <CAHC9VhSSRieK4tuVpOYkWT9UAwbkLZtVABZQFcsJrZnwCH9MhA@mail.gmail.com>
Subject: Re: [PATCH v14 4/11] LSM: syscalls for current process attributes
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
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

On Thu, Sep 7, 2023 at 11:37=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Sep 06, 2023 at 04:48:04PM -0700, Casey Schaufler wrote:
> > On 9/6/2023 4:22 PM, Paul Moore wrote:
> > > On Aug 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >> Create a system call lsm_get_self_attr() to provide the security
> > >> module maintained attributes of the current process.
> > >> Create a system call lsm_set_self_attr() to set a security
> > >> module maintained attribute of the current process.
> > >> Historically these attributes have been exposed to user space via
> > >> entries in procfs under /proc/self/attr.
> > >>
> > >> The attribute value is provided in a lsm_ctx structure. The structur=
e
> > >> identifies the size of the attribute, and the attribute value. The f=
ormat
> > >> of the attribute value is defined by the security module. A flags fi=
eld
> > >> is included for LSM specific information. It is currently unused and=
 must
> > >> be 0. The total size of the data, including the lsm_ctx structure an=
d any
> > >> padding, is maintained as well.
> > >>
> > >> struct lsm_ctx {
> > >>         __u64 id;
> > >>         __u64 flags;
> > >>         __u64 len;
> > >>         __u64 ctx_len;
> > >>         __u8 ctx[];
> > >> };
> > >>
> > >> Two new LSM hooks are used to interface with the LSMs.
> > >> security_getselfattr() collects the lsm_ctx values from the
> > >> LSMs that support the hook, accounting for space requirements.
> > >> security_setselfattr() identifies which LSM the attribute is
> > >> intended for and passes it along.
> > >>
> > >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > >> Reviewed-by: Kees Cook <keescook@chromium.org>
> > >> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > >> Reviewed-by: John Johansen <john.johansen@canonical.com>
> > >> ---
>
> > >> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *=
uctx,
> > >> +                   size_t __user *size, u32 flags)
> > >> +{
> > >> +  struct security_hook_list *hp;
> > >> +  struct lsm_ctx lctx =3D { .id =3D LSM_ID_UNDEF, };
> > >> +  u8 __user *base =3D (u8 __user *)uctx;
> > >> +  size_t total =3D 0;
> > >> +  size_t entrysize;
> > >> +  size_t left;
> > >> +  bool toobig =3D false;
> > >> +  bool single =3D false;
> > >> +  int count =3D 0;
> > >> +  int rc;
> > >> +
> > >> +  if (attr =3D=3D LSM_ATTR_UNDEF)
> > >> +          return -EINVAL;
> > >> +  if (size =3D=3D NULL)
> > >> +          return -EINVAL;
> > >> +  if (get_user(left, size))
> > >> +          return -EFAULT;
> > >> +
> > >> +  if (flags) {
> > >> +          /*
> > >> +           * Only flag supported is LSM_FLAG_SINGLE
> > >> +           */
> > >> +          if (flags & LSM_FLAG_SINGLE)
> > >> +                  return -EINVAL;
> > > Should this be something like the following?
> > >
> > >   if (flags & ~LSM_FLAG_SINGLE)
> > >     return -EINVAL;
> >
> > Yes. I have a fix ready. There are a couple other touch-ups, too.
>
> This is already part of patch 11. It should be squashed here.

So it is, yes, patch 11 should only be selftest code.

--=20
paul-moore.com
