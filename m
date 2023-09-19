Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B336E7A6427
	for <lists+linux-api@lfdr.de>; Tue, 19 Sep 2023 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjISNAO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Sep 2023 09:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjISNAN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 Sep 2023 09:00:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2370125
        for <linux-api@vger.kernel.org>; Tue, 19 Sep 2023 06:00:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a64619d8fbso747718466b.0
        for <linux-api@vger.kernel.org>; Tue, 19 Sep 2023 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695128405; x=1695733205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mCwVe8KpOpCfcH7OtboVsrBBV5wJbNiJa5LJSES+O00=;
        b=p+n/Pj6fr8fjEaTIQSufW8KDCkYxN9h54wJ18ZAKBy9HIKLLg5OJ4BRHlknSvJ7blX
         7O+tW+VEFciYb2CyqXoCxptMv82IocM3L4HfGjwtMNPJwGff+GPfGmEVcAJkMg6Uml5O
         2JpNMQwo6Mb1qDDuyEeet502BBgcWlF98418o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128405; x=1695733205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCwVe8KpOpCfcH7OtboVsrBBV5wJbNiJa5LJSES+O00=;
        b=GK31O/plec9w8IwoUkF2nyHPJjoNRjAU4w0YTnpTk+ZtVDv/ffDiT/2cml5E/9A/4C
         mkyO5RFo9uIW4zeGaCQekj4X2YvFMzTKtwzmg8E9jSgdBHHqqNQfkLSUPbTVR2vsXa+G
         BdZArKNKOWfjHAz3KVkub01JgHqeTcVZ0QoB5TniRxkShwfrop7WqFw7SlNyBR6UEChF
         rwQ0DXLUL6T8f1sCLVCu12xqagbbtTDf1S1QjM6E+mawGnSmpjp2R6yRK8FhXV8Myza7
         9jdj+Rjr3HaSykuF+fRhCOGK7E82ezkeu5BZztGrl1U29VSsumjR0qs/I/3aRhK9v/fj
         edfQ==
X-Gm-Message-State: AOJu0YzymtESPgIyF8Fo82aOK+wG1qx06Q9ZNV6xmXMv408fzzXUxnK5
        MlgrHIna+lO5hwW6DTlDp/yPYv9+N2s19HMHkPNUvg==
X-Google-Smtp-Source: AGHT+IHwoRikybyWt8+rL4a6pcU5rd0ZRZjLkNEDHmNUJ985g1YGHrlb2S1LF8RGk4U05TZ7H0Z04WQ8UuSIlqbUZuQ=
X-Received: by 2002:a17:906:519b:b0:9ad:e298:a5d with SMTP id
 y27-20020a170906519b00b009ade2980a5dmr10879940ejk.19.1695128405076; Tue, 19
 Sep 2023 06:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
 <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
 <20230918-stuhl-spannend-9904d4addc93@brauner> <CAJfpegvxNhty2xZW+4MM9Gepotii3CD1p0fyvLDQB82hCYzfLQ@mail.gmail.com>
 <20230918-bestialisch-brutkasten-1fb34abdc33c@brauner> <CAJfpegvTiK=RM+0y07h-2vT6Zk2GCu6F98c=_CNx8B1ytFtO-g@mail.gmail.com>
 <20230919003800.93141-1-mattlloydhouse@gmail.com> <CAJfpegs6g8JQDtaHsECA_12ss_8KXOHVRH9gwwPf5WamzxXOWQ@mail.gmail.com>
 <20230919-abfedern-halfen-c12583ff93ac@brauner> <CAJfpegsjE_G4d-W2hCZc0y+PioRgvK5TxT7kFAVgBqX6zN2dKg@mail.gmail.com>
 <20230919-hackordnung-asketisch-331907800aa0@brauner>
In-Reply-To: <20230919-hackordnung-asketisch-331907800aa0@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 19 Sep 2023 14:59:53 +0200
Message-ID: <CAJfpeguv+Z6uys18_QYnHcbs_JpMNicRKGt50Scmp82kAOOFOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Matthew House <mattlloydhouse@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
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

On Tue, 19 Sept 2023 at 14:41, Christian Brauner <brauner@kernel.org> wrote:
>
> > >  with __u32 size for mnt_root and mnt_point
> >
> > Unnecessary if the strings are nul terminated.
>
> All ok by me so far but how does the kernel know the size of the buffer
> to copy into? Wouldn't it be better to allow userspace to specify that?
> I'm probably just missing something but I better ask.

Because size of the buffer is given as the syscall argument.

  long statmount(u64 mnt_id, u64 mask, struct statmnt __user *buf,
size_t bufsize, unsigned int flags);

If you are still hung up about this not being properly typed, how about this:

struct statmnt {
        __u64 mask;             /* What results were written [uncond] */
        __u32 sb_dev_major;     /* Device ID */
[...]
        __u64 fs_type;          /* [str] Filesystem type */
        __u64 __spare[49];
        char __string_buf[];
};

Such variable length structures are used all over the place, this
isn't some big invention.  The only new thing is that we set pointers
to within the tail part of the buffer, to make the interface work for
the multiple strings case.

Thanks,
Miklos
