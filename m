Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0DB50928
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 12:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfFXKoz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 06:44:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45654 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfFXKoz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 06:44:55 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so454380ioc.12
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 03:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCgJq21igY0KSeVe2g6442gqLYQ5ESADKLIyY02vYSc=;
        b=V7M/NXhOuQS4On+rDbNB9o5uk8KWw3IJiEcuRoBNI3C4ZrSFlbKZPocuyJJEGarSWX
         cXoI9v0l+onpcSKVWagUIjyKIN8GtAofup0sx+z6dQi5bw3Fkpvhtqf2B3UN7NZumdCV
         FNkLBLnkGrrVHn40gN5iwtfoN2CIYxom1jkhSzZAvgUfOBhU7kz39WgMw7zt4btd+Ihu
         R+Rqsxf8V/MDZmszMefCdpe1qFwmjbGiACkbI+n/XRb+/1PY5kYn6MHQ69b4e2c6pJ/z
         tIz0UR9kCuow4WSxyIELjArtfOrw0RKQcAT7GdLnliD5JBzKPKLmyZ+d6t3vN4kZi2Zk
         RSuA==
X-Gm-Message-State: APjAAAUXzC47Ol6E6T1+4SUlmDsZRirsTRGx6vwk0glcvlrvTPCyZCv6
        DLJdFOMXQ803GjkoMqxR7nQvp5LQJXIj06Kt960XRg==
X-Google-Smtp-Source: APXvYqyDcUV7/ft0Fe+wYR8jAaVZC48EZPDjC0/hFh9o1V9pGhwVl+uquTsaMxl4rwUCXSCbvah6+NItemUjJReLvCc=
X-Received: by 2002:a02:ccdc:: with SMTP id k28mr16948024jaq.41.1561373094455;
 Mon, 24 Jun 2019 03:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123019.30032-1-mszeredi@redhat.com> <20190619123019.30032-5-mszeredi@redhat.com>
 <1ea8ec52ce19499f021510b5c9e38be8d8ebe38f.camel@themaw.net>
 <CAOssrKcU2JKDYMDbW7V6jpM7_4WFSMA91h9AjpjoYmX=H4ybeg@mail.gmail.com> <30205.1561372589@warthog.procyon.org.uk>
In-Reply-To: <30205.1561372589@warthog.procyon.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 24 Jun 2019 12:44:43 +0200
Message-ID: <CAOssrKdGSRVSc38X1J0zCQQN+tUhiwPA4bCL0rHCZ-O8iVzzeQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] vfs: don't parse "silent" option
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 24, 2019 at 12:36 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> > What I'm saying is that with a new interface the rules need not follow
> > the rules of the old interface, because at the start no one is using
> > the new interface, so no chance of breaking anything.
>
> Er. No.  That's not true, since the old interface comes through the new one.

No, old interface sets SB_* directly from arg 4 of mount(2) and not
via parsing arg 5.

Thanks,
Miklos
