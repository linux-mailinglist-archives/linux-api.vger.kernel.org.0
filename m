Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D6B7AD8AE
	for <lists+linux-api@lfdr.de>; Mon, 25 Sep 2023 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjIYNN7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 Sep 2023 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjIYNN6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Sep 2023 09:13:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E07100
        for <linux-api@vger.kernel.org>; Mon, 25 Sep 2023 06:13:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ad810be221so799601066b.2
        for <linux-api@vger.kernel.org>; Mon, 25 Sep 2023 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695647628; x=1696252428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1lwODLqUWlwVEvdiGIdLnyDf2x4p+uZT2UEpf4goid8=;
        b=Ov6jBBUGS6sz7LIqW+HTOsWvi1ubbU4C/zz0wJGiS4PxDxnqtvQBnolIAjMqZdueE3
         7KI8s6lSR2AdOiFjEre4JxlqvSFSEV4no+/v0i09WT1mPggR5PrhQExV/h1dliJG/l8m
         MlqI9w8OsrteEwbHMptTLxnAQaV6RltTbyobk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647628; x=1696252428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lwODLqUWlwVEvdiGIdLnyDf2x4p+uZT2UEpf4goid8=;
        b=wSGAiVdF5Db9U2qm71s5WZ55fJM9jWp6pGsfxE8b8nN+5gP02fz+FcvjNvTOv2Iiwq
         kx+dcMtICQ10IAp9ol4qMRBuc8/d4ie42s9S1J539mtEPu0WBWgTkSzLjrVS1AOO+nT5
         etLvO3kK4BNgrmFrZtwjlBougZ/8zUO7FffGiUzOsMLZ0227eUCU6HBLOIaFhNfrEuiV
         7E1NkyB8fIgK2CpV+DpuVKTbb4lJH8eibiTUXTQ/cHCfwr5iNK9ZuQbFyfKcZfV0P/de
         f/233ASqT1nQL7FcX4qV9nkzI32644oFRN1tOP/7SaN8h4Lb95T4HwGFnRxD2chMDXvW
         L+sQ==
X-Gm-Message-State: AOJu0Yyg8m/77xdVTmNYZVKbbjpf7CEVzSRWL0LrFbaiw1cT/bQnHCLN
        l0XKTs9+d2nawCSdN5gu5KQEWB/K/XQpqCKquoG12A==
X-Google-Smtp-Source: AGHT+IEaXC/MYFZc4Bs5n3km4WhW9nw/fElld1jUd7ViCoEE1UUfeMqKg4Zf45Aei2NXQvMUI8enGkZMqnsqJil51lg=
X-Received: by 2002:a17:906:97:b0:9a9:f042:dec0 with SMTP id
 23-20020a170906009700b009a9f042dec0mr5718418ejc.38.1695647628061; Mon, 25 Sep
 2023 06:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com> <20230925-total-debatten-2a1f839fde5a@brauner>
In-Reply-To: <20230925-total-debatten-2a1f839fde5a@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Sep 2023 15:13:36 +0200
Message-ID: <CAJfpegvUCoKebYS=_3eZtCH49nObotuWc=_khFcHshKjRG8h6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 25 Sept 2023 at 15:04, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Sep 25, 2023 at 02:57:31PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 13, 2023, at 17:22, Miklos Szeredi wrote:
> >
> > >  asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
> > >                             struct statfs64 __user *buf);
> > > +asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
> > > +                       struct statmnt __user *buf, size_t bufsize,
> > > +                       unsigned int flags);
> >
> > This definition is problematic on 32-bit architectures for two
> > reasons:
> >
> > - 64-bit register arguments are passed in pairs of registers
> >   on two architectures, so anything passing those needs to
> >   have a separate entry point for compat syscalls on 64-bit
> >   architectures. I would suggest also using the same one on
> >   32-bit ones, so you don't rely on the compiler splitting
> >   up the long arguments into pairs.
> >
> > - There is a limit of six argument registers for system call
> >   entry points, but with two pairs and three single registers
> >   you end up with seven of them.
> >
> > The listmnt syscall in patch 3 also has the first problem,
> > but not the second.
>
> Both fields could also just be moved into the struct itself just like we
> did for clone3() and others.

Let's not mix in and out args, please.

How about passing u64 *?

Thanks,
Miklos
