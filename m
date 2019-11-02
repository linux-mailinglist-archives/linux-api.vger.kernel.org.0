Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58DDED04D
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2019 19:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKBSyA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 2 Nov 2019 14:54:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40344 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfKBSyA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 2 Nov 2019 14:54:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id q2so6909198ljg.7
        for <linux-api@vger.kernel.org>; Sat, 02 Nov 2019 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFZsrTxHj8UNSOV0MW3iX+ZNPh241BxYI9RJCfbRj4I=;
        b=fwWi36Cjm33TVpJsMKyyeNJuPa+EzO/w2jcz8N5ivZnB2LBgFElTwve7u7JUY1CQlk
         LBP3NYhj8mwMGDKFLZC3aAKJjtxEeb837zFLkONBVlInZ3n9BYz2CiSK5BYhQEqMplN+
         cxbruKuD+a9IFTjckV4CYWfQYTCffHao0G3wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFZsrTxHj8UNSOV0MW3iX+ZNPh241BxYI9RJCfbRj4I=;
        b=pLV24LMhFgqD/CiA6r87aupgC5HaFY/8F2SziVxY+lnSZbtNtSvYPPLPZls7R4fk4f
         XCDC/w8s1LKLyE1hI5hXbWp5V2d2SGpmaL+1x4tb+KzYoqWGmr7NOJZ6eVJr9xjF8u0u
         RDlLlic6dHbWvyJBOXsQnUfsgzm1H865M/l7TI3CYJiJZBH/xbFpLrdAMC+frKIlyf0B
         rcIPWs5+79K1OMNmaq9PkPaQ7t4Z5Tfpk+mJLH8yQ5UJ2FNDrW9vhHvBWPJtfxEh2rjg
         06tjQWpTPsHseueT38qjosYMzQL/ZVy+D6AWJTMsu5eDQQiieK+sek8yVZsULYCcepfU
         g/2w==
X-Gm-Message-State: APjAAAX8DcXHq0Hhk1cxY1KTvrUtn8fIffNEJNrUmr2bcdNA1gEc/7IQ
        dNVvG0YTQhgMIByR/Ne6RFka5h/6uu0=
X-Google-Smtp-Source: APXvYqw+pNumgAtHNHjaljc078CXBZKWdefYMQg1OVAI78RJHAI5gIa9gB3672EIyuKb/jIRiTuHVw==
X-Received: by 2002:a2e:3612:: with SMTP id d18mr13164801lja.222.1572720837473;
        Sat, 02 Nov 2019 11:53:57 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b23sm4368149lfj.49.2019.11.02.11.53.54
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 11:53:54 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v4so9436360lfd.11
        for <linux-api@vger.kernel.org>; Sat, 02 Nov 2019 11:53:54 -0700 (PDT)
X-Received: by 2002:ac2:4c86:: with SMTP id d6mr11465241lfl.106.1572720834124;
 Sat, 02 Nov 2019 11:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <30394.1571936252@warthog.procyon.org.uk> <c6e044cc-5596-90b7-4418-6ad7009d6d79@yandex-team.ru>
 <17311.1572534953@warthog.procyon.org.uk>
In-Reply-To: <17311.1572534953@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 11:53:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_X_7JSYT-a3qHrzvuWGMyffDWtQ4n7adBp_fe5w0BsA@mail.gmail.com>
Message-ID: <CAHk-=wg_X_7JSYT-a3qHrzvuWGMyffDWtQ4n7adBp_fe5w0BsA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
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

On Thu, Oct 31, 2019 at 8:16 AM David Howells <dhowells@redhat.com> wrote:
>
> Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
>
> > Similar synchronization is required for reusing memory after vmsplice()?
> > I don't see other way how sender could safely change these pages.
>
> Sounds like a point - if you have multiple parallel contributors to the pipe
> via vmsplice(), then FIONREAD is of no use.  To use use FIONREAD, you have to
> let the pipe become empty before you can be sure.

Well, the rules for vmsplice is simply to not change the source pages.
It's zero-copy, after all.

If you want to change the source pages, you need to just use write() instead.

That said, even then the right model isn't fsync(). If you really want
to have something like "notify me when this buffer has been used", it
should be some kind of sequence count thing, not a "wait for empty".

Which might be useful in theory, but would be something quite
different (and honestly, I wouldn't expect it to find all that
widespread use)

             Linus
