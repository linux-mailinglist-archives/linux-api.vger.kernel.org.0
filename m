Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2A45B717
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2019 10:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfGAIqF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Jul 2019 04:46:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38468 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfGAIqF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Jul 2019 04:46:05 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so26965932ioa.5
        for <linux-api@vger.kernel.org>; Mon, 01 Jul 2019 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IYVjMNAPDPB3g4UgnPc8UGgFEx9QPCSimigO/GLHsBU=;
        b=h56oJXfRQo/o4lu+WGdXLsKdrbfT1gg0IRUA/DzTERPW1P4dBV2yyruiDQL8BTav47
         wrOiecYdejVIJq5nAQI7edyf0fimOhblJ3hRv4LkqJJDlzClAhfhYf6aHQ5by9ULg/Q2
         cKxSCxYgH5i4XaOHfEv0esDJwMFejLa49HSWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IYVjMNAPDPB3g4UgnPc8UGgFEx9QPCSimigO/GLHsBU=;
        b=GfSS8PSs+3gKTseUqfKpNmh9dC97DskX9TKNRoHL19J4buN/E4GPw52t/dId/ONDjM
         kWuAq08BkOH9R1azK85SHydGPq7eLOzR7EoIlC9mWJaKGOiwTPF2ro/uR9w8qnMpKgof
         JXJyoZ0XsyKaMHa46X/3x+1fahMbqt9GO3PkmBA4TShZTLywvWoVAik9RiNIuac7SiYN
         4DMcjl14Mu1gPTqn9U5xcuNzGnMoJuktFBNUqt4LQW7JDIC7bINsrlZHMgP8qCAYIzba
         c2wFHnJG5gJ60GskSh6G+bfs3bPJx4lqFPpjJZxtJBYLcOx+8WCwdHMSmao9FqToqpBT
         yDUQ==
X-Gm-Message-State: APjAAAWgm7shVt5aav+3t2EXr3+J7+t/LmHM2sGm4+xthukYmT7Gmf2B
        wbrV+G8LHnS1sGbbekTNgTyBo3XeGFLgjUydL/W0uA==
X-Google-Smtp-Source: APXvYqxxiZw+bGnK8YPjYZcf2sGoK8aDASylIc273wEuR0ihID6ic3gJk3WyoL35wKxKGn5mqfaNZ2WBpzy8GmFOi+4=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr23250663iok.252.1561970764796;
 Mon, 01 Jul 2019 01:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com>
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 1 Jul 2019 10:45:53 +0200
Message-ID: <CAJfpegv_ezsXOLV2f7yd07=T3MenJoMKhu=MBac1-80s0BFg9A@mail.gmail.com>
Subject: Re: [PATCH 01/13] vfs: verify param type in vfs_parse_sb_flag()
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi David,

Ping?  Have you had a chance of looking at this series?

K=C3=B6szi,
Miklos

On Wed, Jun 19, 2019 at 2:30 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> vfs_parse_sb_flag() accepted any kind of param with a matching key, not
> just a flag.  This is wrong, only allow flag type and return -EINVAL
> otherwise.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fs_context.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 103643c68e3f..e56310fd8c75 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -81,30 +81,29 @@ static const char *const forbidden_sb_flag[] =3D {
>  /*
>   * Check for a common mount option that manipulates s_flags.
>   */
> -static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
> +static int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter =
*param)
>  {
> -       unsigned int token;
> +       const char *key =3D param->key;
> +       unsigned int set, clear;
>         unsigned int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(forbidden_sb_flag); i++)
>                 if (strcmp(key, forbidden_sb_flag[i]) =3D=3D 0)
>                         return -EINVAL;
>
> -       token =3D lookup_constant(common_set_sb_flag, key, 0);
> -       if (token) {
> -               fc->sb_flags |=3D token;
> -               fc->sb_flags_mask |=3D token;
> -               return 0;
> -       }
> +       set =3D lookup_constant(common_set_sb_flag, key, 0);
> +       clear =3D lookup_constant(common_clear_sb_flag, key, 0);
> +       if (!set && !clear)
> +               return -ENOPARAM;
>
> -       token =3D lookup_constant(common_clear_sb_flag, key, 0);
> -       if (token) {
> -               fc->sb_flags &=3D ~token;
> -               fc->sb_flags_mask |=3D token;
> -               return 0;
> -       }
> +       if (param->type !=3D fs_value_is_flag)
> +               return invalf(fc, "%s: Unexpected value for '%s'",
> +                             fc->fs_type->name, param->key);
>
> -       return -ENOPARAM;
> +       fc->sb_flags |=3D set;
> +       fc->sb_flags &=3D ~clear;
> +       fc->sb_flags_mask |=3D set | clear;
> +       return 0;
>  }
>
>  /**
> @@ -130,7 +129,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct =
fs_parameter *param)
>         if (!param->key)
>                 return invalf(fc, "Unnamed parameter\n");
>
> -       ret =3D vfs_parse_sb_flag(fc, param->key);
> +       ret =3D vfs_parse_sb_flag(fc, param);
>         if (ret !=3D -ENOPARAM)
>                 return ret;
>
> --
> 2.21.0
>
