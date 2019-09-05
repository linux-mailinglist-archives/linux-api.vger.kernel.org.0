Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD0AAB12
	for <lists+linux-api@lfdr.de>; Thu,  5 Sep 2019 20:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbfIESdT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Sep 2019 14:33:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391292AbfIESdT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 5 Sep 2019 14:33:19 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B04E02D0FC7
        for <linux-api@vger.kernel.org>; Thu,  5 Sep 2019 18:33:18 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id r187so2106445wme.0
        for <linux-api@vger.kernel.org>; Thu, 05 Sep 2019 11:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkgFvZx1SpfRB54bm11+3DOumUuDokZW525XdQCPb+E=;
        b=Bht1xhKyWxScaF69a4pgAnCdVq9XO08n/8lxezIRWr0+yKm9eH7+fdrH3pvCGOm3Ap
         CELSnfZJh1FZYtAoNqvfs/J0j5pp/B93kmYilkvVFP64uEU/+j/N0WohMAdczg/1nD6m
         JjHeOQWJ57KEwP9ZPAZ12ZqJPYN3elkNiJLrCVL8wfbGv1fR6NJ4MNzTnYC22qG3oLLH
         Nf+5PxhyErBXlBLS/aqYYaknS2r/udKw4IhKuSR6W+AoxpRrQ+vB6BRNiSFnP5cgeO+C
         hGiqfDfPSJOmYVTPwdRsllM4y46bZ7maA7SUAFGcD847afekpUZG70l8S94bKBsPcXAt
         XibA==
X-Gm-Message-State: APjAAAWUwdlZYm6r69gfVRyufwo3BgHnj+934y8RkRhzZ2ABUeqCWbq9
        J1o/fOzQUhmnKkKncBJtRbba9CzB0pxn/WkpUEV6NATmGG1ubRYXEgeaaHD1+8+q8esv2IEsPXl
        4uptNG7ZWz9z6l8bkiTzUQVBUiwqrLlPaDt/6
X-Received: by 2002:a5d:568c:: with SMTP id f12mr3942165wrv.248.1567708397318;
        Thu, 05 Sep 2019 11:33:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmOECwYwtvafDfOc5sH/mM1xRRq5odIdcrX+xDOVM3wNnjyolmP+riNwHwlSKTnHua2vRyqquS9BP4i+1k7Ig=
X-Received: by 2002:a5d:568c:: with SMTP id f12mr3942141wrv.248.1567708396973;
 Thu, 05 Sep 2019 11:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <156763534546.18676.3530557439501101639.stgit@warthog.procyon.org.uk>
 <CAHk-=wh5ZNE9pBwrnr5MX3iqkUP4nspz17rtozrSxs5-OGygNw@mail.gmail.com>
 <17703.1567702907@warthog.procyon.org.uk> <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
In-Reply-To: <CAHk-=wjQ5Fpv0D7rxX0W=obx9xoOAxJ_Cr+pGCYOAi2S9FiCNg@mail.gmail.com>
From:   Ray Strode <rstrode@redhat.com>
Date:   Thu, 5 Sep 2019 14:32:40 -0400
Message-ID: <CAKCoTu7ms_Mr-q08d9XB3uascpzwBa5LF9JTT2aq8uUsoFE8aQ@mail.gmail.com>
Subject: Re: Why add the general notification queue and its sources
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

Hi,

On Thu, Sep 5, 2019 at 1:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> You've at least now answered part of the "Why", but you didn't
> actually answer the whole "another developer" part.
It's certainly something we've wanted in the GNOME world for a long time:

See for instance

https://bugzilla.redhat.com/show_bug.cgi?id=991110

and

https://bugzilla.gnome.org/show_bug.cgi?id=707402

from all the way back 2013.  These are the alternatives I can think of:

- poll? status quo, but not great for obvious wakeup reasons
- use a different credential cache collection type that does support
change notification?
some of the other types do support change notification, but have their
own set of
problems. But maybe we should just go back to DIR type credential
cache collections
and try to figure out the life cycle problems they pose, i don't
know... or get more
man power behind KCM...
- manage change notification entirely from userspace.  assume credentials will
always be put in place from krb5-libs entry points, and just skip
notification if
it happens out from under the libraries. maybe upstream kerberos guys would
be onboard with this, I don't know. This seems less robust than having
the kernel
in the loop, though.

> I really don't like how nobody else than you seems to even look at any
> of the key handling patches. Because nobody else seems to care.
I've got no insight here, so i'll just throw a dart...

viro, is this something you have any interest in watching closer?

> See what I'm saying? This whole "David Howells does his own features
> that nobody else uses" needs to stop. You need to have a champion. I
> just don't feel safe pulling these kinds of changes from you, because
> I get the feeling that ABSOLUTELY NOBODY ELSE ever really looked at it
> or really cared.
I get the "one man is not enough for proper maintenance" argument, and
maybe it's true.  I don't know.

But I just want to point out, I have been asking dhowells for this change
notification API for years, so it's not something he did on his own and for
no particularly good reason. It solves a real problem and has a real-world
use case.

He kindly did it because I (and Robbie Harwood and others) asked him about
it, off and on, and  he was able to fit it onto his priority list for us.
From this thread, it sounds like he solved a problem for Greg too, killing a
couple birds with one stone?

--Ray
