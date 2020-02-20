Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 074BE166A61
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 23:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgBTWde (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 17:33:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34084 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgBTWdb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 17:33:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so169838ljc.1
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 14:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrNmlOpMVxzFXh2A2oJzXRWZK2fGDe1+SPIAN4gWybk=;
        b=QiMLUGsRq9HWg+G+gXiEaS3g8vcEPOTXS0nkdYQXIsCA2EjphiI1+TGu1HVJ3od+BY
         4nIUXqbNSwvfL1zzmPatevn6ccupRjp+aZGa5eL8bOeMqUiv7Bg7Hz5IKilERFOA99sS
         jMLLQ3OrRmjEMgFi9TJzZnDfd0rXWYetgu1bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrNmlOpMVxzFXh2A2oJzXRWZK2fGDe1+SPIAN4gWybk=;
        b=o66P2f6o8GlVpVVfKyNy8wEEUWs0zJVP/yBGzHzVqF5cBwSYkaDUTdTgSvVMrolDOU
         ZsdKACJGiZX4wDJIHtzCoWSaZRnW+YGz+MPyBDuUdTSni0fwiXjj++Hb4SYiibpi/pne
         HdoopQhqbVYaNsUB4Xs7cTBJZ81KI84S87N4o1iwOevS5t4iffawiPq+kEYRhFVRT5yA
         OqBgVU7/LsNIz0BqAYeqPJaMwD9egRsYpq4Nkthhu29VslMR+92rTaZdhp/WPn1icjil
         GnjJ401E2BX/Z4c1710Z0Zpdq+F/W000Gbcx3wCmyO5mlmAGeEhU58OHmME2XgZpIZ/F
         iViA==
X-Gm-Message-State: APjAAAXKIsEN6MNqJh1oYVWq1qoPi4VDu1hp552JvvYDvnyP2+19NBL+
        uLJBEXtsevcGTf03STfIRMcysNKtM8Y=
X-Google-Smtp-Source: APXvYqwmwNWxlo3/f6LbppRaCo6MW1915QWAX+7xbgEXOzW1823YSPEZllqnuCwQSAmdBe2HKDKlRw==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr20305050ljl.83.1582238008561;
        Thu, 20 Feb 2020 14:33:28 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id e30sm420385ljp.24.2020.02.20.14.33.26
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:33:27 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id a13so125045ljm.10
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 14:33:26 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr19716647ljj.241.1582238006401;
 Thu, 20 Feb 2020 14:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87h7zl9e7u.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87h7zl9e7u.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:33:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wht3ZWRaYs8QBXuftfuiFGOTjjZ9zj3-Dz7dkiBhJNBrQ@mail.gmail.com>
Message-ID: <CAHk-=wht3ZWRaYs8QBXuftfuiFGOTjjZ9zj3-Dz7dkiBhJNBrQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] proc: Mov rcu_read_(lock|unlock) in proc_prune_siblings_dcache
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
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

On Thu, Feb 20, 2020 at 12:51 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Don't make it look like rcu_read_lock is held over the entire loop
> instead just take the rcu_read_lock over the part of the loop that
> matters.  This makes the intent of the code a little clearer.

No, this is horrid.

Maybe it makes the intent clearer, but it also causes that "continue"
case to unlock and relock immediately.

And maybe that case never triggers, and that's ok. But then it needs a
big comment about it.

              Linus
