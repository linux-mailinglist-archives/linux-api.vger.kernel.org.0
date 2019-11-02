Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DD7ED0F2
	for <lists+linux-api@lfdr.de>; Sun,  3 Nov 2019 00:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfKBXJH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 2 Nov 2019 19:09:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33957 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfKBXJG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 2 Nov 2019 19:09:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id 139so13810753ljf.1
        for <linux-api@vger.kernel.org>; Sat, 02 Nov 2019 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYWG+PndMaavSEZTx4tAuPjrZgeMNS1BkWduXMUhlSE=;
        b=NAZiBqRMuLwp18H/qmyeCQUJQSMxLgfDNPb3RDjIM2NaIkVQsPt1S/xuDnF8dcUBgf
         3fZo55nc7Bm/xxbjy/0YjqR9D8Xzg3aKB55yv1y8UMISn+S9dO18XBNHs4wlB45hKZ6I
         TFCoEmlRYzmfAjujVacuTPfMhwBZ5xf+j+Mkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYWG+PndMaavSEZTx4tAuPjrZgeMNS1BkWduXMUhlSE=;
        b=KCinpnhuXdUa+B340qjbSjm7OPueSmZWhqePE8heQJgrxwEB7J4WCoSG6kJ2aMguoC
         4vX668KBDEDAITHCFxkdOeZZswx41lelzJ/nK4wf9eJvLcA1r51UkhNaVNpHxUI0p7Z1
         6gybVql2j0Tkzyo1KxwmkWxlwbz6oFEEYpOXuOLgOT4QMQpZEQKEs2e3eipVewmJSYmN
         PgVCrLJV/atffYQikgX80FbCehiD395mu5fpvEyB0QBREmCayjoUKUnHuWh9Q7MtOvTW
         pNPWbCTfll2p6ijpk8fxC4mM3AaF5vWDe7WNsQcuVtoYkD+glwp3Pc9Bi0pJkZC8p8ci
         WqZA==
X-Gm-Message-State: APjAAAW+aJ6U+RfK1MBjnXaSGHksyUTZgFi5fyaJG78vOk93TLFQl4uW
        dcn/REL/mLtxI062QWs08DjKVE0CON8=
X-Google-Smtp-Source: APXvYqwTTyNBMaPKC3PrXZeu4zXU5znt4YCm5vtJ/fdGOqa3Ii4npu6W1zOQvZewpjfUy+xWlWJwxg==
X-Received: by 2002:a2e:b604:: with SMTP id r4mr6272043ljn.134.1572736143087;
        Sat, 02 Nov 2019 16:09:03 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m21sm4199881lfh.39.2019.11.02.16.09.02
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 16:09:02 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q2so7211350ljg.7
        for <linux-api@vger.kernel.org>; Sat, 02 Nov 2019 16:09:02 -0700 (PDT)
X-Received: by 2002:a2e:819a:: with SMTP id e26mr10124866ljg.26.1572735749049;
 Sat, 02 Nov 2019 16:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
In-Reply-To: <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 16:02:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
Message-ID: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 2, 2019 at 3:30 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> So you allocate memory, vmsplice, and munmap() without reusing it?

You can re-use it as much as you want. Just don't write to it.

So the traditional argument for this was "I do a caching http server".
If you don't ever load the data into user space at all and just push
file data out, you just use splice() from the file to the target. But
if you generate some of the data in memory, and you cache it, you use
vmsplice().

And then it really is very easy to set up: make sure you generate your
caches with a new clean private mmap, and you can throw them out with
munmap (or just over-mmap it with the new cache, of course).

If you don't cache it, then there's no advantage to vmsplice() - just
write() it and forget about it. The whole (and only) point of
vmsplice() is when you want to zero-copy the data, and that's
generally likely only an advantage if you can do it multiple times.

But I don't think anybody actually _did_ any of that. But that's
basically the argument for the three splice operations:
write/vmsplice/splice(). Which one you use depends on the lifetime and
the source of your data. write() is obviously for the copy case (the
source data might not be stable), while splice() is for the "data from
another source", and vmsplace() is "data is from stable data in my
vm".

There's the reverse op, of course, but we never implemented that:
mmap() on the pipe could do the reverse of a vmsplice() (moving from
the pipe to the vm), but it would only work if everything was
page-aligned, which it effectively never is. It's basically a
benchmark-only operation.

And the existence of vmsplice() is because we actually had code to
play games with making write() do a zero-copy but mark the source as
being COW. It was _wonderful_ for benchmarks, and was completely
useless for real world case because in the real world you always took
the COW fault. So vmsplice() is basically a "hey, I know what I'm
doing, and you can just take the page as-is because the source is
stable".

             Linus
