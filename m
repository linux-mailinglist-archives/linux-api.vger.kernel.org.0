Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493FC1683D4
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 17:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgBUQl6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Feb 2020 11:41:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43601 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgBUQl6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Feb 2020 11:41:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so2520179oth.10
        for <linux-api@vger.kernel.org>; Fri, 21 Feb 2020 08:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8MzCk9OwOPa97vO2O05j0c9kWBLJAm/QkTzXLv8BeU=;
        b=Doowzri/qjWvN5enbBTfhnuLRHkk4kje0+PTPJj+PR3X4oDZn7sF3iriUqDNqR8/PI
         OOnksEMCeYJc7svg25ckcRLmo1MHTk3uYWuiFjMOU0iBUvIVwFbuqfTa32hzgWGms6tY
         IyqkduEYw2LZv7swLMlyARmx1plXfqmA+FLzhnY+ipmXD4+ozrCxMB4Y9GhH3MRKPlMd
         BeVFozsTd2kF6x9oNde7HiVC74A3wPSjqGINyRkEX4H1uIyEboe2MHlOjhFv6XAd+f62
         e+k7csSsznEVOEJ3be54MVHd6vIU4Iv1dItJt1txTk2PsdBjP8fn5svlevyrAON5jjNH
         YWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8MzCk9OwOPa97vO2O05j0c9kWBLJAm/QkTzXLv8BeU=;
        b=busUUjF2rofaI27HwMscreW2lydrUWv+CM8zFK4B5aNGRsoLeZTLWf2Dn3+KWAsX8y
         hNqh6ab8SzsteFrpX4+NowGetdASamTdh9RZVCXPzeNkmd0fOGlUNR8WBkqruCPPJRZw
         iglZhFleSkdUQePI/L1lT13baN+Y8dHGoCKOvnSZQWFKxxRKtMGk+ifS7HBg+ncGguWs
         1tTDfqswOjfDBDQqSiM9KOgNL0wUq6jaRhbpZXtfDWBHxWSbE2SYiSOTAdlNBhqeeHiX
         auoIkn0wWj8nSqcpUxgW+1OT7hBctP0jaluJN4cxYQoXG7srUvUFoMjNho+PEK93JlsH
         jRMQ==
X-Gm-Message-State: APjAAAWsUnfLuMw9eZXkzQZzrAqG+uXfg4Ux4y4nnS3iQFk/YFk3PdSZ
        7DAbH1GIjq/p7jvWzi5ZnByC3nDKRWohbbNkIqg1QQ==
X-Google-Smtp-Source: APXvYqx0HGLTCbdTjv0nDBX10uWCVZSgjBknBgULwUuOc07vU8ZgOAq0qvlJewVmC7Wi5NEAW1+GZDssTDFqVlAh0uw=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr15510368otl.110.1582303317466;
 Fri, 21 Feb 2020 08:41:57 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204561120.3299825.5242636508455859327.stgit@warthog.procyon.org.uk>
 <CAG48ez2B2J_3-+EjR20ukRu3noPnAccZsOTaea0jtKK4=+bkhQ@mail.gmail.com>
 <1897788.1582295034@warthog.procyon.org.uk> <CAG48ez2nFks+yN1Kp4TZisso+rjvv_4UW0FTo8iFUd4Qyq1qDw@mail.gmail.com>
 <2031798.1582302800@warthog.procyon.org.uk>
In-Reply-To: <2031798.1582302800@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 Feb 2020 17:41:31 +0100
Message-ID: <CAG48ez2vzgVgJw7-WKa1GbyLw2nJGvAnS21w=gHV02rUNheYFw@mail.gmail.com>
Subject: Re: [PATCH 15/19] vfs: Add superblock notifications [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 21, 2020 at 5:33 PM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > (And as in the other case, the s->s_count increment will probably have
> > to be moved above the add_watch_to_object(), unless you hold the
> > sb_lock around it?)
>
> It shouldn't matter as I'm holding s->s_umount across the add and increment.
> That prevents the watch from being removed: watch_sb() would have to get the
> lock first to do that.  It also deactivate_locked_super() from removing all
> the watchers.

Can't the same thing I already pointed out on "[PATCH 13/19] vfs: Add
a mount-notification facility [ver #16]" also happen here?

If another thread concurrently runs close(watch_fd) before the
spin_lock(&sb_lock), pipe_release -> put_pipe_info -> free_pipe_info
-> watch_queue_clear will run, correct? And then watch_queue_clear()
will find the watch that we've just created and call its
->release_watch() handler, which causes put_super(), potentially
dropping the refcount to zero? And then stuff will blow up.

> I can move it before, but I probably have to drop s_umount before I can call
> put_super().
