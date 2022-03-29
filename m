Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAD4EA6B2
	for <lists+linux-api@lfdr.de>; Tue, 29 Mar 2022 06:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiC2Eva (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Mar 2022 00:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiC2Eva (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Mar 2022 00:51:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5690D7646
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 21:49:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq24so12287820lfb.5
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWLCAB1500HQsLrUixU/FnW8B7Hc4CJp8/73HN5IT2Y=;
        b=POOwnLqQHlCOU22V8lK/DyvfG13ektO9++0nIu55Ks337hYPiaUdBhqL4r6k4qzskO
         tsTH2/jIOm8Ln7911xEwcmfkNNzZR6TYlLsBbThIxQ60S1YHieiBgh+9lBGKSBG3xBX5
         WouBI37zmKvRLWHdcT3YFtg7ltiWUVFXq0rwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWLCAB1500HQsLrUixU/FnW8B7Hc4CJp8/73HN5IT2Y=;
        b=szNjsxStP9KrLx35bw7T2arUlPD1o0CddiMk4B9k1Kva8WTn4sZtwQ3C8XDpOOpZZG
         Ezz2hzxnRgKcJdKo4pE2RltClly0p8xVafJMalMRhVquHb2ZCnVgZ8c+hkBfouU9g/jM
         /XnsE34Gl9snsTjTlF93pvfgLJIIVFA/BZoccqnx1e2OdPbJ8XGHpgY/A5uhHKHRYWDv
         N12CVoLmD54a8EowYqxVaPvJojz85LC2bN5+roDVnCl/92RTVBfHkEYXxZuNzZaDKYNr
         QiwWMGFtL+9yCq5eYv1wwrJv7Ymh2uo+UTmp/O80ngmDAzd4ivZRCfgD7dlMUpKqFlk5
         MvdA==
X-Gm-Message-State: AOAM533M2+4d4sM2WJQcXBTiP4OhVOBD07hTX+Oi/vRJjbitnIXU8ygP
        54RqO+YZQRf2VmoZmmVOpLyyHWnsZXhuhtT5
X-Google-Smtp-Source: ABdhPJyYVLfqKj+WxOA7LD8qgRaGiHM8hoXLyibJDuwar4R/hl0dIrHkVVJvTeMrLfWqddMDaPkEQA==
X-Received: by 2002:a19:e209:0:b0:44a:51af:b3fd with SMTP id z9-20020a19e209000000b0044a51afb3fdmr906423lfg.560.1648529385252;
        Mon, 28 Mar 2022 21:49:45 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c7-20020a2e9d87000000b00247ebe11990sm1939207ljj.10.2022.03.28.21.49.43
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 21:49:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id m3so28207629lfj.11
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 21:49:43 -0700 (PDT)
X-Received: by 2002:a05:6512:2296:b0:44a:6aaf:b330 with SMTP id
 f22-20020a056512229600b0044a6aafb330mr898795lfu.531.1648529383200; Mon, 28
 Mar 2022 21:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org> <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org> <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org> <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
 <87r16lmnsq.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87r16lmnsq.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Mar 2022 21:49:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVB8npX4B3D48PjqHjKa8geRjMhcFSgmtYDPp05eZymA@mail.gmail.com>
Message-ID: <CAHk-=wiVB8npX4B3D48PjqHjKa8geRjMhcFSgmtYDPp05eZymA@mail.gmail.com>
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>, Kyle Huey <me@kylehuey.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 28, 2022 at 8:38 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Dumb question because this seems to burning a few extra creativity
> points.  Is there any way to create a signed tag and a branch with the
> same name?

Oh, absolutely.

But you may find it annoying, because as you noticed:

> Having a tag and a branch with the same name seems to completely confuse
> git and it just tells me no I won't push anything to another git tree,
> because what you are asking me to do is ambiguous.

Not at all.

git is not at all confused by the situation, git is in fact very aware
of it indeed.

But as git then tells you, exactly *because* it is aware that you have
picked the same name for both a branch and a tag, it will keep warning
you about the ambiguity of said name (but after warning, will
generally then preferentially use the tag of that name over the branch
of the same name).

So if you have both a branch and a tag named 'xyz', you generally need
to disambiguate them when you use them. That will make git happy,
because now it's not ambiguous any more.

(Technical detail: some git operations work on specific namespaces, so
"git branch -d xyz" should never remove a _tag_ called 'xyz', and as
such the name isn't ambiguous in the context of that git command)

And disambiguating them is simple, but I suspect you'll find it's
annoying enough that you simply don't want to use the same name for
tags and branches.

The full name of a tag 'x' is actually 'refs/tags/x', and the full
unambiguous name of a branch 'x' is 'refs/heads/x'.

So technically a tag and a branch can never _really_ have the same
name, because internally they have longer unambiguous names.

You would almost never actually use that full name, it's mostly an
internal git thing. Because even if you have ambiguous branch and tag
names, you'd then still shorten it to just 'tags/x' and 'heads/x'
respectively.

Git has other "namespaces" for these refs, too, notably
'refs/remotes/'. In fact, I guess you could make up your own namespace
too if you really wanted, although I don't think anybody really has
ever had a good reason for it.

(There is also the non-namespaced special refs like HEAD and
FETCH_HEAD and MERGE_HEAD for "current branch", "what you fetched" and
"what you are merging")

So you *can* do this:

    # create and check out the branch 'xyz'
    $ git checkout -b xyz master

    # create a tag called 'xyz', but to confuse everybody, make it
point somewhere else
    $ git tag xyz master~3

    # look at what 'xyz' means:
    $ git rev-parse xyz
    warning: refname 'xyz' is ambiguous.
    cffb2b72d3ed47f5093d128bd44d9ce136b6b5af

    # Hmm. it warned about it being ambiguous
    $ git rev-parse heads/xyz
    1930a6e739c4b4a654a69164dbe39e554d228915

    # Ok, it clearly took the tag, not the branch:
    $ git rev-parse tags/xyz
    cffb2b72d3ed47f5093d128bd44d9ce136b6b5af

so as you can see, yes, you can work with a tag and a branch that have
the same 'short name', but having to disambiguate them all the time
will likely just drive you mad.

And it's worth pointing out that the name does not imply a
relationship. So the branch called 'xyz' (ie refs/heads/xyz) has
absolutely *no* relationship to the tag called 'xyz' (ie
refs/tags/xyz) except for that ambiguous short name. So updating the
branch - by perhaps committing more to it - will in no way affect the
tag.

Also note that branches and tags are both "just refs" as far as git is
concerned, but git *does* give some semantic meaning to the
namespaces.

So the branch namespace (it those 'refs/heads/*' things) are things
that get updated automatically as you make new commits.

In contrast, the tag namespace is something you *can* update, but it's
considered odd, and if you want to overwrite an existing tag you
generally need to do something special (eg "git tag -f" to force
overwriting a new tag rather than telling you that you already have
one).

So in a very real way, to git a ref is a ref is a ref, with very
little to no real *technical* distinction. They are just ways to point
to the SHA1 hash of an object. But there are basically some common
semantic rules that are based on the namespaces, and all those git
operations that use certain namespaces by default.

            Linus
