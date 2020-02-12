Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF315B157
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 20:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgBLTuU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 14:50:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37795 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgBLTuT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 14:50:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so2480640lfc.4
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 11:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHXH6o1ncLcAF0HeWBgC/IvihmP9toR2+/NwDUguxaw=;
        b=F1RTR2Mk3atysxi94JEv4Vc5seMqqx02k5CmzRHPSL9IrjapbyqOHw2Fl4dXiCvUEV
         ncTWbgP69pZD/8vVK6OQciM9WRN9WfMjKk6TsKRj9cuZUdWmWVaikWPX14ZlXYji3kdw
         CWzsabp8eT8r94ZjWLxWvcikM9+qEZil4HvcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHXH6o1ncLcAF0HeWBgC/IvihmP9toR2+/NwDUguxaw=;
        b=kbtCrw0FYaQ5Titj2MJLiRLfC334fxMKc0tgyYmmVVUEhaIridpdKEyf8fuZa5oTCb
         0DJXweUixNZVcWcimgtsK5QmrDdTtaiIBddnHitIMBANWuVgoeUsR3SolywQpyTJ4htJ
         IX+er5TOYP+LHShmEDwpWmVL9TBMMMcbz2MMYllR/z6l5gEkrUeQlT5oRxrZpHHdf7og
         eedY4noi4onWcrijR1Jz2Zhcn92xFNflkuecdLhoOR8zJiKeh7XLDcveMS1ZW/9icwtR
         vYc4jZ0X5RUAG8E4VviPhGeSwIW8lJJ5hp+xQ6m7JejvspTXKzewsOVLNfM/o+OSjndv
         LIgQ==
X-Gm-Message-State: APjAAAXYG6XqKcvPTO4DNKWjSivp/srpFBri4O8ZUWJJzIzJ4TDQ369y
        q2ZMduhW6FmRTsk0X9bJwJKIicpS1fk=
X-Google-Smtp-Source: APXvYqyeNbw5QLfo01BZTkmTfDbUa+h8gsyJ32kaSWZZ3RB3dQQRi3wX2p2gaHYsAEKd0zORaG4VQw==
X-Received: by 2002:a19:84d:: with SMTP id 74mr7142287lfi.122.1581537016467;
        Wed, 12 Feb 2020 11:50:16 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c22sm53673lfc.93.2020.02.12.11.50.15
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:50:15 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id l18so2499933lfc.1
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 11:50:15 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr7333707lfm.152.1581537014849;
 Wed, 12 Feb 2020 11:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9obipk9.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 11:49:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
Message-ID: <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 12, 2020 at 11:18 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> > So it's just fs_info that needs to be rcu-delayed because it contains
> > that list. Or is there something else?
>
> The fundamental dcache thing we are playing with is:
>
>         dentry = d_hash_and_lookup(proc_root, &name);
>         if (dentry) {
>                 d_invalidate(dentry);
>                 dput(dentry);
>         }

Ahh. And we can't do that part under the RCU read lock. So it's not
the freeing, it's the list traversal itself.

Fair enough.

Hmm.

I wonder if we could split up d_invalidate(). It already ends up being
two phases: first the unhashing under the d_lock, and then the
recursive shrinking of parents and children.

The recursive shrinking of the parent isn't actually interesting for
the proc shrinking case: we just looked up one child, after all. So we
only care about the d_walk of the children.

So if we only did the first part under the RCU lock, and just
collected the dentries (can we perhaps then re-use the hash list to
collect them to another list?) and then did the child d_walk
afterwards?

             Linus
