Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873F5241E6D
	for <lists+linux-api@lfdr.de>; Tue, 11 Aug 2020 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgHKQjG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Aug 2020 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgHKQjG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Aug 2020 12:39:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08B4C06174A
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 09:39:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o23so13806575ejr.1
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7traUqX1fM13wKjAbxkcSlNBWmdCV6QJf9i7XpWydE=;
        b=WPJKoAqHiSl/tMI6ux9ZyiwFZyLZeSf9IYnGPT6aXv5JxD0edUrsFyfwibupSRZPli
         sRgA0IHx4UhfQY9IUr+rb1b91G/QJ4IOfgHOH9XwY0IGnWNZoZAF+orZ9O7vZ9YyH60H
         QN4mw78jv4VsrakmBralo6Vc4sNZK78skPMUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7traUqX1fM13wKjAbxkcSlNBWmdCV6QJf9i7XpWydE=;
        b=SQKVOAnm0ZRsjDniuQb1CZCggj31h7o9PSZpK8bsfIYIkBtlG6PQULc0e5aZb7yw/0
         WmriAfkFK8xeNogEqzTwI5n/Lq4ZmeqU4+LU6ppDMjkTbORXCvb1HykHa4ry/bm2RiuC
         lg9X9SZt5Mpm9V0HWfGEQD3kAJa+J+W3O5AuwCvfU7Q+pSZIJ1Sxrz5Vu8Y+PNj0w+1A
         zYrOuq9k4Hw0RtbLKhmX9xh5GGScvm94mj7gJCp+Jya0FCjBLTXFeYxKX0Fz1v36rXEd
         0KdewuEYEkeVNovKR7OQlOwehCMyb/FaAW6NmacSk3D1ZuIMtzchVp4eQ6kX8yE/7shw
         unFQ==
X-Gm-Message-State: AOAM531j0EBw82nHwJ7zi+1SoLFjtSGsuwT3BfASp+Pg6pCs92AaL9rj
        cwN7yL914Ez7Gedfx31PTuiGaEo+pOw=
X-Google-Smtp-Source: ABdhPJxobDJfiWEOMC8Xke/mQSC54Gk2fBhkd4DTdC/zg6AyE8NTrf1H6YwLwSL5qri7TTkzem4L6w==
X-Received: by 2002:a17:906:6d91:: with SMTP id h17mr26153326ejt.531.1597163944316;
        Tue, 11 Aug 2020 09:39:04 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id qk30sm15283992ejb.125.2020.08.11.09.39.03
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:39:04 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id a15so12058804wrh.10
        for <linux-api@vger.kernel.org>; Tue, 11 Aug 2020 09:39:03 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr3282002lji.314.1597163463666;
 Tue, 11 Aug 2020 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
In-Reply-To: <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:30:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNwsV6PYrB=MB6y8AJ00GO70CGVUcgKxZHZybhcNp_6w@mail.gmail.com>
Message-ID: <CAHk-=whNwsV6PYrB=MB6y8AJ00GO70CGVUcgKxZHZybhcNp_6w@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 11, 2020 at 9:17 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> This doesn't work so well for setxattr(), which we want to be atomic.

Well, it's not like the old interfaces could go away. But yes, doing

        metadatafd = openat(fd, "metadataname", O_ALT | O_CREAT | O_EXCL)

to create a new xattr (and then write to it) would not act like
setxattr(). Even if you do it as one atomic write, a reader would see
that zero-sized xattr between the O_CREAT and the write.

Of course, we could just hide zero-sized xattrs from the legacy
interfaces and avoid things like that, but another option is to say
that only the legacy interfaces give that particular atomicity
guarantee.

> Since a////////b has known meaning, and lots of applications
> play loose with '/', its really dangerous to treat the string as
> special. We only get away with '.' and '..' because their behavior
> was defined before many of y'all were born.

Yeah, I really don't think it's a good idea to play with "//".

POSIX does allow special semantics for a pathname with "//" at the
*beginning*, but even that has been very questionable (and Linux has
never supported it).

                   Linus
