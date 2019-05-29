Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D73222D757
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfE2IJK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 04:09:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40123 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfE2IJK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 May 2019 04:09:10 -0400
Received: by mail-io1-f66.google.com with SMTP id n5so1042308ioc.7
        for <linux-api@vger.kernel.org>; Wed, 29 May 2019 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxXvclxvtLO6JmXKyzZz4TtfqD6qqSQQNDFUnK5EdOE=;
        b=dIAHLOYYCq5oAsIPqSqwXo7BO2qeHR7SZftiNljkQHJUJv80V0MatrM6Q3SkC/BoXo
         2yM1PXXNJy2qg2EtCGlpBmJsNHMoswxau4JRWvZ9Vi+wqjT0Vy1KAUu496HRxp8Z2wTT
         UipyxohvDO1db0DYXvIDnvgfESM3mBn8LbT8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxXvclxvtLO6JmXKyzZz4TtfqD6qqSQQNDFUnK5EdOE=;
        b=SpzcjsDPk8zQ8xxlEr0zRsvAQK1mbOk6QPXcJ/7H8T8kIKiFHmWNpU2XvimDWFwpn7
         b6jO03iAj6fF/alxd+1Z+USjnums5EvAiBycoortqHy6UZM3ad3+sCHafzCfzoe7s4U/
         YqMNG//AttL/+AvjfKqZA7zPpK3NLW6aKuM9amPnctlgoWylKZkqxPVErsJB/+2Eh6/n
         DZM16evGw1SM1jFjflV0dj9v68ASxAwUI/4unci5uyOyfjInJ/UK8eqh0onbL3UkV+cb
         fjF5kvMleSu4bp4FtxbVZXNH0zyaB/Z7UPsM9sr+otI9K9jeOzy+4+891azlRMiSRFE3
         3hRw==
X-Gm-Message-State: APjAAAVBfs+iqRD/WW5bSQvKtBBnMnMo7qh9LQQu4ESzXIv/FhvNUD9O
        MkGdIwPXzsbMUPo523lNmp4zd3qxaV17SI/TXFQUvg==
X-Google-Smtp-Source: APXvYqwhgOrotS8jlyEYFxpVCtEt1jaGqmJaJ2Q6ogp9Ky0GdDMgFIIk9nOCTBuYSmaAcZn2/UUVPBw0wO8G5MlhJtY=
X-Received: by 2002:a05:6602:2252:: with SMTP id o18mr5265330ioo.63.1559117349466;
 Wed, 29 May 2019 01:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
 <155905629702.1662.7233272785972036117.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905629702.1662.7233272785972036117.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 29 May 2019 10:08:58 +0200
Message-ID: <CAJfpegutheVtnmN6BFSjzrmz8p9+DpZxFoKa4CoShoh4MW+5gQ@mail.gmail.com>
Subject: Re: [PATCH 04/25] vfs: Implement parameter value retrieval with
 fsinfo() [ver #13]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 5:11 PM David Howells <dhowells@redhat.com> wrote:
>
> Implement parameter value retrieval with fsinfo() - akin to parsing
> /proc/mounts.
>
> This allows all the parameters to be retrieved in one go with:
>
>         struct fsinfo_params params = {
>                 .request        = FSINFO_ATTR_PARAMETER,
>         };

Ah, here it is.

>
> Each parameter comes as a pair of blobs with a length tacked on the front
> rather than using separators, since any printable character that could be
> used as a separator can be found in some value somewhere (including comma).
> In fact, cifs allows the separator to be set using the "sep=" option in
> parameter parsing.
>
> The length on the front of each blob is 1-3 bytes long.  Each byte has a
> flag in bit 7 that's set if there are more bytes and clear on the last
> byte; bits 0-6 should be shifted and OR'd into the length count.  The bytes
> are most-significant first.
>
> For example, 0x83 0xf5 0x06 is the length (0x03<<14 | 0x75<<7 | 0x06).

Sounds way too complicated.  What about fixed 4byte sizes?  Or using
the nul charater as separator (and binary blobs be damned)?

[...]

> +static void fsinfo_insert_sb_flag_parameters(struct path *path,
> +                                            struct fsinfo_kparams *params)
> +{
> +       int s_flags = READ_ONCE(path->dentry->d_sb->s_flags);
> +
> +       if (s_flags & SB_DIRSYNC)
> +               fsinfo_note_param(params, "dirsync", NULL);
> +       if (s_flags & SB_LAZYTIME)
> +               fsinfo_note_param(params, "lazytime", NULL);
> +       if (s_flags & SB_MANDLOCK)
> +               fsinfo_note_param(params, "mand", NULL);
> +       if (s_flags & SB_POSIXACL)
> +               fsinfo_note_param(params, "posixacl", NULL);
> +       if (s_flags & SB_RDONLY)
> +               fsinfo_note_param(params, "ro", NULL);
> +       if (s_flags & SB_SYNCHRONOUS)
> +               fsinfo_note_param(params, "sync", NULL);

Again, don't blindly transform s_flags into options, because some of
them may have been internally manipulated by the filesystem.

You could do a helper for filesystems that does the the common ones
(ro/sync/dirsync) but all of that *should* go through the filesystem.

Same goes for vfs_parse_sb_flag() btw.   It should be moved into each
filesystem's ->parse_param() and not be a mandatory thing.

Thanks,
Miklos
