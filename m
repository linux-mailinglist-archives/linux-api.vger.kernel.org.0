Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4F242DEE
	for <lists+linux-api@lfdr.de>; Wed, 12 Aug 2020 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgHLRQv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Aug 2020 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLRQu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Aug 2020 13:16:50 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B640C061385
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 10:16:50 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id v22so2131464edy.0
        for <linux-api@vger.kernel.org>; Wed, 12 Aug 2020 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2X1UTNYtxtD9AqiCPxyGHdXjAbLFgoKechHodwc0Uo=;
        b=nAulnfLe5uw3GGbI4m3Tum5zj3laHAl5lzMTlbg9w0RQxUXyfMRVW0PUksH7Rp6ZFN
         Yq1nSYnweoNegqNGWk3syhijVezp9QgoP5+S2Di2gSfqAOOXVBABYvP7X+VVxFs5wL3L
         ah3L2fnd4E2PFbne2qLQvAQDr2nPtHrCw32E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2X1UTNYtxtD9AqiCPxyGHdXjAbLFgoKechHodwc0Uo=;
        b=W32CB6TD+dk2PWlZbkXmwKgc9gZ+MUMb6LuwyBTG0caKqLT4302/XItpaz1n2nen+g
         /FYMgwtXheZDfMeCRJXnICO5poQ/fMmfNbUv35RbCZlzQ1gInh/GwabauiCyDQeooNv4
         Wd2a1DWJAcuLhO0HghrDPSS/weue+KPIWF/PClJBxgmnwP5tTFZLH3Tl+8E1mPx0rtDd
         AOkf6O8LYGtxNozlTrqQLyP00kYAupHDamCqffggPeiz36tYmDfaCwjJieVaqEuxEVEA
         bB76OVCGj+rKjlusGobRCIhYXYaneRLsZHgW0V0FfeXyZVg4fkj2Dnc8e0YoeU7xhsmK
         DkQw==
X-Gm-Message-State: AOAM531GS0PaljfWNhy3gQ2h1zMbouMkdUj66cP8uWpY+osLRFjkjn0p
        nEKiXx+ZxqCPNMSad65paPniQ3yM2feZ2KUi4ZPCGg==
X-Google-Smtp-Source: ABdhPJxug2NLkyVDrt4SDzElrjaxLcJAHADPULDoz4hIsy0nzQPyH+wfb4erX3M7q+SBR4y2ScqFzLhktBpqx/PV0jA=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr905858edx.358.1597252608671;
 Wed, 12 Aug 2020 10:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
 <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
 <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
 <CAJfpegtXtj2Q1wsR-3eUNA0S=_skzHF0CEmcK_Krd8dtKkWkGA@mail.gmail.com>
 <20200812143957.GQ1236603@ZenIV.linux.org.uk> <CAJfpegvFBdp3v9VcCp-wNDjZnQF3q6cufb-8PJieaGDz14sbBg@mail.gmail.com>
 <20200812150807.GR1236603@ZenIV.linux.org.uk> <CAJfpegsQF1aN4XJ_8j977rnQESxc=Kcn7Z2C+LnVDWXo4PKhTQ@mail.gmail.com>
 <20200812163347.GS1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200812163347.GS1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Aug 2020 19:16:37 +0200
Message-ID: <CAJfpegv8MTnO9YAiFUJPjr3ryeT82=KWHUpLFmgRNOcQfeS17w@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
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

On Wed, Aug 12, 2020 at 6:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Aug 12, 2020 at 05:13:14PM +0200, Miklos Szeredi wrote:

> > Why does it have to have a struct mount?  It does not have to use
> > dentry/mount based path lookup.
>
> What the fuck?  So we suddenly get an additional class of objects
> serving as kinda-sorta analogues of dentries *AND* now struct file
> might refer to that instead of a dentry/mount pair - all on the VFS
> level?  And so do all the syscalls you want to allow for such "pathnames"?

The only syscall I'd want to allow is open, everything else would be
on the open files themselves.

file->f_path can refer to an anon mount/inode, the real object is
referred to by file->private_data.

The change to namei.c would be on the order of ~10 lines.  No other
parts of the VFS would be affected.   Maybe I'm optimistic; we'll
see...

Now off to something completely different.  Back on Tuesday.

Thanks,
Miklos
