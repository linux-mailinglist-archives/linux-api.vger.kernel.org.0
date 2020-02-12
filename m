Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9AD15B26F
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 22:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgBLVDA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 16:03:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44774 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBLVC7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 16:02:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so3967029ljj.11
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WySKsoF25f/J4EpIF80nlYeN07mmY9MX1gph6T2llNA=;
        b=Q58W0NiVVgTX+oNnbx2yak8H3LqZJhOMXKR6Ng/loJu7bqEx0qJqJdUgYoD/Insl5V
         0bdfWlwpi7ZWdHerxvV1fP32PeO3Q+Sr+beCxumaLAw59xU5UE6TavPtsaLJeIdwxKCP
         /m8KW47+oG3MYjz8Wo+heg9mc0RztoSq3bL84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WySKsoF25f/J4EpIF80nlYeN07mmY9MX1gph6T2llNA=;
        b=S1N1WNhc+UoW1hrD1MgK81+lmB19Sc88X+p1bzzS1FoVAOUDoM/iubMxq2RrLC0gPN
         6Svf7wekzqK+FMZ3agqsNfw4HK/B4JJDi7/LTMcEuZSqCs+Hn9bCCMAwtLKvufeh4oME
         8066ZJ432Vf4Sz5bogl58xzf8ZJ4ORQ+GlmEtL4xsYvxQuimMi2GNPW4IH5aJjz95iHi
         CAPQCp4VBFo8MW/fYEuPqXJ/XGrXqlKLRZOGpMsPe1133Y/HsPbgfvDqtJOOPHwcNrMH
         c6sRAxpgiedOVlsvvCVl5kHp6J8WwMG1FcdufIEXjtDVWuRK67e23s1whG9wD+yAXha0
         KAZg==
X-Gm-Message-State: APjAAAXT6flVjd6oRKxubW6Q9//GrRdJukKhFP+l9Q4GCFRsjQgXEh/4
        lSv9ZWV41LY7rOZpcZ3wRE/uuogQ8C0=
X-Google-Smtp-Source: APXvYqzV/fmBGPKqnGEPKlyb+k3pCWbRPVx6l4Bqjl37l7gr7V0VP9sH/S6sbA/Ru0H2s+n1WJ97zQ==
X-Received: by 2002:a05:651c:38c:: with SMTP id e12mr8449911ljp.142.1581541377802;
        Wed, 12 Feb 2020 13:02:57 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f8sm129734lfc.22.2020.02.12.13.02.57
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 13:02:57 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e18so3957870ljn.12
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 13:02:57 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr8729073ljj.241.1581541376733;
 Wed, 12 Feb 2020 13:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200212204124.GR23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 13:02:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
Message-ID: <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Wed, Feb 12, 2020 at 12:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Feb 12, 2020 at 08:38:33PM +0000, Al Viro wrote:
> >
> > Wait, I thought the whole point of that had been to allow multiple
> > procfs instances for the same userns?  Confused...
>
> s/userns/pidns/, sorry

Right, but we still hold the ref to it here...

[ Looks more ]

Oooh. No we don't. Exactly because we don't hold the lock, only the
rcu lifetime, the ref can go away from under us. I see what your
concern is.

Ouch, this is more painful than I expected - the code flow looked so
simple. I really wanted to avoid a new lock during process shutdown,
because that has always been somewhat painful.

            Linus
