Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F523AAD30
	for <lists+linux-api@lfdr.de>; Thu,  5 Sep 2019 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391316AbfIEUjW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Sep 2019 16:39:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37376 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390751AbfIEUjW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Sep 2019 16:39:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so3150982lff.4
        for <linux-api@vger.kernel.org>; Thu, 05 Sep 2019 13:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JszmXlgx1+xgmZVB9Ngs6u7Ky/QX8naYvJJhJ3ScXns=;
        b=dUEsT8ouSuhTdLO9XeIJ7j2pUQ/Jzy9iWK7dNbuhxCeiK9q0D7pXpiEMTKij3qFmLF
         /0ePwe6D4PLTWPKkntRM1vtWtPyFUYzwKF5X1Vep8dqqrs4xqpQeioJiw+0evrb+dVxs
         mvw4lOCfYV3TKiH7AH5TB6rlYwT5QQmegELDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JszmXlgx1+xgmZVB9Ngs6u7Ky/QX8naYvJJhJ3ScXns=;
        b=gdNlPCHmhtsNGUhAREcYPUMZtaqR08wsBPFnHwD5oWw0D+NkU/MQE6i29YvYLzadSw
         /SjaAoO21PrC/YgJs8HAVSqIlPkpj5gkCQgg0mgFjvoPm2J/xJCZ7w4y3daZFRfPCTcs
         GFi57YVI1BwrC5RJLecb2kNSVI7Ffq6AdiAGWuMnV7bUncnUjNyZGmhesgc3EmBt010D
         3Uaf07fnwGfw8vISYP0XsBeusblK6FMs3YrWdqMoBBWALkX2FY2Wa8zNLs8NRvilTKtJ
         JZYO5rNAo/JDkN4/qZajXBfcDzxRuOhx+LqPMRKs3CAlQkPvReguV+RHrTUoNRKWE+8o
         O3GQ==
X-Gm-Message-State: APjAAAVWMvlEUjEps/39MSsL3OdHmk74ILgaglxo8WHV6B0TvlB9rv5Z
        QedRfQQRvrkWLFPSKXa6W1k842O4BGc=
X-Google-Smtp-Source: APXvYqy6UM1gWlAwI0/n0Ibi3mSWePHeAgIKO+MH5BwFmuY6Rn+siP4KQIJ2BmFFJScYAZtOzIlcig==
X-Received: by 2002:a19:2d19:: with SMTP id k25mr3988590lfj.76.1567715958604;
        Thu, 05 Sep 2019 13:39:18 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t82sm640873lff.58.2019.09.05.13.39.17
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2019 13:39:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w6so3171323lfl.2
        for <linux-api@vger.kernel.org>; Thu, 05 Sep 2019 13:39:17 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr3791028lfp.134.1567715957179;
 Thu, 05 Sep 2019 13:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
 <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
In-Reply-To: <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Sep 2019 13:39:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
Message-ID: <CAHk-=wjcsxQ8QB_v=cwBQw4pkJg7pp-bBsdWyPivFO_OeF-y+g@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     Ray Strode <rstrode@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Ray, Debarshi" <debarshi.ray@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 5, 2019 at 11:33 AM Ray Strode <rstrode@redhat.com> wrote:
>
> Hi,
>
> On Thu, Sep 5, 2019 at 1:20 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > You've at least now answered part of the "Why", but you didn't
> > actually answer the whole "another developer" part.
> It's certainly something we've wanted in the GNOME world for a long time:
>
> See for instance
>
> https://bugzilla.redhat.com/show_bug.cgi?id=991110

That is *way* too specific to make for any kind of generic
notification mechanism.

Also, what is the security model here? Open a special character
device, and you get access to random notifications from random
sources?

That makes no sense. Do they have the same security permissions?

USB error reporting is one thing - and has completely different
security rules than some per-user key thing (or system? or namespace?
Or what?)

And why would you do a broken big-key thing in the kernel in the first
place? Why don't you just have a kernel key to indirectly encrypt
using a key and "additional user space data". The kernel should simply
not take care of insane 1MB keys.

Big keys just don't make sense for a kernel. Just use the backing
store THAT YOU HAVE TO HAVE ANYWAY. Introduce some "indirect key"
instead that is used to encrypt and authenticate the backing store.

And mix in /proc/mounts tracking, which has a namespace component and
completely different events and security model (likely "none" - since
you can always read your own /proc/mounts).

So honestly, this all just makes me go "user interfaces are hard, all
the users seem to have *completely* different requirements, and nobody
has apparently really tested this in practice".

Maybe a generic notification mechanism is sensible. But I don't see
how security issues could *possibly* be unified, and some of the
examples given (particularly "track changes to /proc/mounts") seem to
have obviously better alternatives (as in "just support poll() on
it").

All this discussion has convinced me of is that this whole thing is
half-baked and not ready even on a conceptual level.

So as far as I'm concerned, I think I want things like actual
"Tested-by:" lines from actual users, because it's not clear that this
makes sense. Gnome certainly should work as a regular user, if you
need a system daemon for it with root privileges you might as well
just do any notification entirely inside that daemon in user space.
Same goes for /proc/mounts - which as mentioned has a much more
obvious interface for waiting anyway.

User interfaces need a lot of thought and testing. They shouldn't be
ad-hoc "maybe this could work for X, Y and Z" theories.

                    Linus
