Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D14A166A87
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 23:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBTWt4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 17:49:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37546 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgBTWt4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 17:49:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id q23so186134ljm.4
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 14:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsBAqEZQag0ypHqg0PyTqrCBxrLtLK/vf3m5Pbo+Q1I=;
        b=HocGqZaPvPbj2Rc3tHfIsXtvsU9ZExNqDhyGTd1FkLfg2CixXSIhWg+lhtFLFy7LH5
         Ll9ajjeSCLGyVGJFCP3pr8MzRIUlhdaSf4zT2trYK3NmUY7kfmF8q56qyO7AFc70i6vi
         mx1gRvncgXwtZTQp0OujHwfoGsQovufSXPaY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsBAqEZQag0ypHqg0PyTqrCBxrLtLK/vf3m5Pbo+Q1I=;
        b=tL5lUey3RYA/T2cV3TzsmNh+nOGlQcoOiKM3KSc7QVWJxf6MxPL7NT4k03DMJntWpb
         YP4LmqWD8tBY9+OXOXl4pgPFgcyl8pk1CaxfICcNT6uPdaeTYQ/G9qVgI/Mn4C978M8R
         Eq3Eun+ZzktF3WIlXFVNoP1q1px5lIMZoDTgA7GS6MrQ3lPiWyGWq7BDS3SlnsyfqLuS
         E7OCl3QYrmkPfBh1Wcl3kHpylEXuZfbCOHSKPcq3yoAh29PqZuTgViKb4ASce3uy4syG
         WZdJVixd3UZcAOfrhxtUYmj1/ZRrmsu9bWXmIsSX2ceSy3yyCzmcCYWpIpM6VtFVa1xB
         yFWQ==
X-Gm-Message-State: APjAAAV3wqCUIZDp/2eCSpI45lsjUx8tCqjV0sf7U58oBTtDsQVjnda1
        JdQNrHamLy3L3RpZHekC+4Y7t8+wJc8=
X-Google-Smtp-Source: APXvYqxPCXyEjDxhcjLpMROIfcEGpt1KWQiMjTV0qwzRMutaHyX6zwoMiTgzHBCN4pvciBadmL3gBw==
X-Received: by 2002:a2e:3504:: with SMTP id z4mr20193438ljz.273.1582238993940;
        Thu, 20 Feb 2020 14:49:53 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d9sm428750lja.73.2020.02.20.14.49.53
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:49:53 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 83so12141lfh.9
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 14:49:53 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20465844ljk.201.1582238633679;
 Thu, 20 Feb 2020 14:43:53 -0800 (PST)
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
 <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:43:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmwfv6zGwTRR8zTyTdfxgYoc7SE3Z0nKHu_srG_8NPWw@mail.gmail.com>
Message-ID: <CAHk-=whmwfv6zGwTRR8zTyTdfxgYoc7SE3Z0nKHu_srG_8NPWw@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
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
> To use d_invalidate replace d_prune_aliases with d_find_alias
> followed by d_invalidate and dput.  This is safe and complete
> because no inode in proc has any hardlinks or aliases.

Are you sure you can't create them some way?  This makes em go "what
if we had multiple dentries associated with that inode?" Then the code
would just invalidate the first one.

I guess we don't have export_operations or anything like that, but
this makes me worry...

            Linus
