Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35283782EA9
	for <lists+linux-api@lfdr.de>; Mon, 21 Aug 2023 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjHUQoB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Aug 2023 12:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjHUQoA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 Aug 2023 12:44:00 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED8E8
        for <linux-api@vger.kernel.org>; Mon, 21 Aug 2023 09:43:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58fba83feb0so23784627b3.3
        for <linux-api@vger.kernel.org>; Mon, 21 Aug 2023 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692636237; x=1693241037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEjD/AU1mAJeRfhZIstUaBuufPMB+eCFCGb0gsqx2K4=;
        b=e/fljHM5IKab4bwCG1qJZjMl1EdYPDisy5PuxXxKuc9lDhOydnOuCnDQqfvG2xe+L6
         k7fwLgzPn5MRWSpTSS7DWJJLICoFgwGSRBTNu+i9RqAJeXjNEY07ysFOtQcv2dAp3WgA
         aWxiuvMltKpXaN5b46LFPwc2GwslYeaXhSA8x3VeP2HnR+eB9pdI7o1m114AhVcjgqUf
         Di2MBfcTOYveghp/yk5rUV8wqFoWTuWw6sUSyoYJJKUeKgCfD5YnKhtU1oMzow1Zs6Mt
         U2375T2IA+uo27m1Y2U7h9GGFaBZSKfkpJi7CtFidyCEX/jtuTiND5dYYIP198K1lC2i
         GrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636237; x=1693241037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEjD/AU1mAJeRfhZIstUaBuufPMB+eCFCGb0gsqx2K4=;
        b=IzgSM4m5jWJUmUzyokh+YaY1l535FyI/WyJ8bLXJZQC7rWRkJsaxjcmOfR3URELXba
         2uYqD4HDSAooSjAtQLR1X7o+66qZTrwnE/hk3m7I5Nc3aBVzkrKiuiSE11/1OeQenKGy
         7p+Y7FaGdOROHQsjV9SqvHCm1odcSxNW6HDyYdoPKZVqCBQE8+ovce0hRk6p/g/8j++c
         maVUv2Rz9NkKPvSR3zU3/rqhczTOxF8Uh1C9IosY4nusffyesUQ4gmXpq9fmVRALPDNb
         V1myp/gZBMylG9TZC6unPF8js3TTRvhXUPnaAijl4czMFvp7e363tG1a0apqzKiRZngk
         Ai6A==
X-Gm-Message-State: AOJu0Yy5Ir8J4g0LcOKCd7yBUSYo2vTd0WOWj+uqRUF6OrxvsR01IHnm
        UOmWKp8YYuZiTDzVZDkZjrTV87tPxBPuUhYdctWX
X-Google-Smtp-Source: AGHT+IFC5jriDqIEqds1bFUlasgKfzxVpx6c15GAraTz0Da6iHbAu2CtBrlCUKHV6YdY1VqSSccVr3ANUqzpYgoAo4g=
X-Received: by 2002:a81:7384:0:b0:577:3fb4:f245 with SMTP id
 o126-20020a817384000000b005773fb4f245mr6182153ywc.19.1692636237673; Mon, 21
 Aug 2023 09:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAP2_zdp=oGKVfuAYUSXb_42yU-8-86AtS27TiXpibS4mj8wrfg@mail.gmail.com>
In-Reply-To: <CAP2_zdp=oGKVfuAYUSXb_42yU-8-86AtS27TiXpibS4mj8wrfg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Aug 2023 12:43:47 -0400
Message-ID: <CAHC9VhSre7fiAVNtbyVcjg3v3uUwzOm0grNbmo1ppKOyh1B=jg@mail.gmail.com>
Subject: Re: Watchdog bark! bark due to excessive logging from SELinux in Linux-modules;
To:     Aaditya raj <rajaditya073@gmail.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
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

On Mon, Aug 21, 2023 at 7:14=E2=80=AFAM Aaditya raj <rajaditya073@gmail.com=
> wrote:
>
> Hi Team ,
>
> There is an Watchdog bark issue seen due to excessive logging from SELinu=
x , I have attached a patch to restrict excessive logging , please review t=
he patch and please let me know if there is any issue.
>
> I have modified the file =E2=80=9Csecurity/selinux/hooks.c=E2=80=9D on li=
ne number 1353 , replaced pr_warn with pr_warn_ratelimited.
>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can you provide more information about what kernel you are using and
the filesystem(s) you have mounted which are causing this error,
including how they are mounted?  I wouldn't expect a normal system to
flood the logs with many of these warnings, so I'm wondering if
something else is wrong ...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..83f3e5a0ccc6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1350,7 +1350,7 @@ static int inode_doinit_use_xattr(struct inode *ino=
de, struct dentry *dentry,
>         if (rc < 0) {
>                 kfree(context);
>                 if (rc !=3D -ENODATA) {
> -                       pr_warn("SELinux: %s:  getxattr returned %d for d=
ev=3D%s ino=3D%ld\n",
> +                       pr_warn_ratelimited("SELinux: %s:  getxattr retur=
ned %d for dev=3D%s ino=3D%ld\n",
>                                 __func__, -rc, inode->i_sb->s_id, inode->=
i_ino);
>                         return rc;
>                 }

--=20
paul-moore.com
