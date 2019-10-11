Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41073D4969
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 22:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJKUqf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 16:46:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44172 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJKUqe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Oct 2019 16:46:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so11034331ljj.11
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNABcTciGmLPgzKCUlHZRBRsyOpw5zPeOkeqEXDcIFc=;
        b=hiusd5bTKbuf8Io1VHhHhrY3WPkC8HiE+LZAmpWF8M5eNj+z1KEhXR6703FdJnh6Fn
         mco4+ZkYzjQTqICNRn9LKyFFsCB9Owxm8mZcigV5i+SgI22JVStBEVyyBrw4SLHSEXt2
         n8BsJjHPsRARgvmaaSQ1mbnYPbUvUTven4vcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNABcTciGmLPgzKCUlHZRBRsyOpw5zPeOkeqEXDcIFc=;
        b=LworMMAsBpA0rwQKggyH0F+gzPeMzY0jz1+1xE7Fb37DED6+0Bb8YtJhffNUY47Q81
         U0vAqY5fFtWUyYfshEG507nqwBR6HImMQvokmCM0Wl0EthErqqQXIrVy4aDsYipbdgq/
         78YfXUnLzI8vAuRvYaoYODrx0sWF61LuFOdkI3FVZPdCrkSsmUi8z5rBdwuHtpf4MlAR
         nG+z4rRL2Uj7sC57mLGTgkraZoYNfe7UisB0XXQZgRjTSGlV3Vpaf8Vp1f8LG0LdAEA5
         o3jWd1YZ4WK+6CD8nTukruAHcwNkFNSdmlVDJb4TrFid9rMWkqtp9eTIUTsJff9NQmmK
         VmIQ==
X-Gm-Message-State: APjAAAUgtVBYosGghgEmPeTpxdvb1NctLx1p3ty75pjuxGIqpgVbx1dU
        E9Aitt0lbQUzRueI1jh0rJiV30Gr2hI=
X-Google-Smtp-Source: APXvYqydFmxJVS54MvtGXurzsUWlAnqH8ZT+/MjDM1XhxiPHPcxEhUs1124XVIclRyRuVCh8XEBSiQ==
X-Received: by 2002:a2e:8945:: with SMTP id b5mr10537920ljk.215.1570826790836;
        Fri, 11 Oct 2019 13:46:30 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id i11sm2193968ljb.74.2019.10.11.13.46.28
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v24so11098280ljj.3
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr10481233ljr.1.1570826788212;
 Fri, 11 Oct 2019 13:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191011135458.7399da44@gandalf.local.home> <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
 <20191011162518.2f8c99ca@gandalf.local.home>
In-Reply-To: <20191011162518.2f8c99ca@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 13:46:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com>
Message-ID: <CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 11, 2019 at 1:25 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> OK, so I tried this approach, and there's a bit more than just a "few"
> extra cases that use tracing_open_generic().

Yeah, that's more than I would have expected.

That said, you also did what I consider a somewhat over-done conversion.

Just do

   static inline bool tracefs_lockdown_or_disabled(void)
   { return tracing_disabled || security_locked_down(LOCKDOWN_TRACEFS); }

and ignore the pointless return value (we know it's EPERM, and we
really don't care).

And then several of those conversions just turn into oneliner

-       if (tracing_disabled)
+       if (tracefs_lockdown_or_disabled())
                 return -ENODEV;

patches instead.

I'm also not sure why you bothered with a lot of the files that don't
currently even have that "tracing_disabled" logic at all. Yeah, they
show pre-existing tracing info, but even if you locked down _after_
starting some tracing, that's probably what you want. You just don't
want people to be able to add new trace events.

For example, maybe you want to have lockdown after you've booted, but
still show boot time traces?

I dunno. I feel like you re-did the original patch, and the original
patch was designed for "least line impact" rather than for anything
else.

I also suspect that if you *actually* do lockdown at early boot (which
is presumably one common case), then all you need is to do

    --- a/fs/tracefs/inode.c
    +++ b/fs/tracefs/inode.c
    @@ -418,6 +418,9 @@ struct dentry *tracefs_create_file(
        struct dentry *dentry;
        struct inode *inode;

    +   if (security_locked_down(LOCKDOWN_TRACEFS))
    +           return NULL;
    +
        if (!(mode & S_IFMT))
                mode |= S_IFREG;
        BUG_ON(!S_ISREG(mode));

and the "open-time check" is purely for "we did lockdown _after_ boot,
but then you might well want to be able to read the existing trace
information that you did before you locked down.

Again - I think trying to emulate exactly what that broken lockdown
patch did is not really what you should aim for.

That patch was not only buggy, it really wasn't about what people
really necessarily _want_, as about "we don't want to deal with
tracing, so here's a minimal patch that doesn't even work".

          Linus
