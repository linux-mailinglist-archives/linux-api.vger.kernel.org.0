Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0055047F
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 10:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfFXI0C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 04:26:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45166 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfFXI0B (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 04:26:01 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so556486ioc.12
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 01:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfyERo/qbyCrZtACfmY6e7oEdMDreZL5930Ld8MdyWA=;
        b=is9nAyNYELCGGwt24rEgFnS1/bQS/7bxpxexKvV1cBDTZTUUk3AwuingrKt/37du5M
         9BBzJcgiJEEfCOUGNJ5k/39asAtaj6kHztFHuvZk77+MBG1FrwmF+7Vni5pGuEQLQVfc
         2Deb+M6Gq88wXczSnbAsTufr4zL5s3t540SAsYwL3lsqoecKEpEInu8o1aoTa8EjsysS
         esoCFfYRjn045+k8ywainMFDcTuOHnxrBsfHrxVwFPF/E3ssnaJbdvj9c9qIt49XFkdV
         CYHSKDP5kLh+Sc3ok2sI53XXcI+t9VHw82uDhwdnOEmGFoygKnodauqLwV0Jucv3TZMT
         FWkw==
X-Gm-Message-State: APjAAAWNsNACWM4z9znrNsorCXjVew/kmIVKrxWghHKGxadYI02AV8wq
        rdw/Ff+uKDmqekQcxBXyTJ5lJt+kXD3B29T5xAP9LQ==
X-Google-Smtp-Source: APXvYqxWKVfvD82LkcUgZZSuaW7gHtIZNb3ThzXsHToF9uKf0p3weHT5YuTecAFti5V8yJGEHzcSv4flXMz9LzUVNyw=
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr8555199iof.6.1561364760754;
 Mon, 24 Jun 2019 01:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com> <20190619123019.30032-5-mszeredi@redhat.com>
 <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
In-Reply-To: <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 24 Jun 2019 10:25:49 +0200
Message-ID: <CAOssrKcU2JKDYMDbW7V6jpM7_4WFSMA91h9AjpjoYmX=H4ybeg@mail.gmail.com>
Subject: Re: [PATCH 05/13] vfs: don't parse "silent" option
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 6:40 AM Ian Kent <raven@themaw.net> wrote:
>
> On Wed, 2019-06-19 at 14:30 +0200, Miklos Szeredi wrote:
> > While this is a standard option as documented in mount(8), it is ignored by
> > most filesystems.  So reject, unless filesystem explicitly wants to handle
> > it.
> >
> > The exception is unconverted filesystems, where it is unknown if the
> > filesystem handles this or not.
> >
> > Any implementation, such as mount(8) that needs to parse this option
> > without failing should simply ignore the return value from fsconfig().
>
> In theory this is fine but every time someone has attempted
> to change the handling of this in the past autofs has had
> problems so I'm a bit wary of the change.
>
> It was originally meant to tell the file system to ignore
> invalid options such as could be found in automount maps that
> are used with multiple OS implementations that have differences
> in their options.
>
> That was, IIRC, primarily NFS although NFS should handle most
> (if not all of those) cases these days.
>
> Nevertheless I'm a bit nervous about it, ;)

What I'm saying is that with a new interface the rules need not follow
the rules of the old interface, because at the start no one is using
the new interface, so no chance of breaking anything.

Yes, there's a chance of making the interface difficult to use, but I
don't think this is one of those things.

For one, "silent" should not be needed on the new interface at all,
because error messages relating to the setup of the filesystem can be
redirected to a log buffer dedicated to the setup instance,
effectively enabling silent operation by default.

Thanks.,
Miklos
