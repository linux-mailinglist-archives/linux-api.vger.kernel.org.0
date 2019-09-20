Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0AB99CA
	for <lists+linux-api@lfdr.de>; Sat, 21 Sep 2019 00:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393881AbfITWo5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Sep 2019 18:44:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33274 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393794AbfITWo5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Sep 2019 18:44:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so6136265lfc.0
        for <linux-api@vger.kernel.org>; Fri, 20 Sep 2019 15:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKUuDO6YOo0r9Dt4w/cxI9Tu6lVFdn1V9F8DKhykytQ=;
        b=Kl/zSV5hhzVT49bbAiGHnAK2P122IBZjE+QpwN3a9ptugitLNiKFgEkjvUJAFPy4yA
         j1qvQnw5/ZusJG8Zxho5k5dtJV/gOUtrQJ0v2WclFfrSVNQ6IuFX1I+yu0eZpF6xMiU/
         /PwDzWilWgoTYlFoB6C14j2XRyqO+E101Fbs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKUuDO6YOo0r9Dt4w/cxI9Tu6lVFdn1V9F8DKhykytQ=;
        b=aFxD2alQ1aHqN/GOMQXSdGAXDQjqjex0AZOsFrVYAJNm10SMBp1UrpqhkmQ+gUFtGM
         1/HXD4g3fLKFrvo5iqpeqXDRS87N0Bjrfj3IYkK7PE4gi37gUs2ICBX6uGmb/5plxxO0
         uvlwV/CYJ1Tq6bH/o5qisSW3qbCq42U2lLWHLcp47Ip4ZYPqXDWLZ0AK9/Wyen4F6ELg
         pet6+xrpwVYvrwLvW6OCPV34ojT6CXNjjrBMacXeYy5apbhpxPXPmrqhWtuRhmOBJtyl
         4nYxx7wCfGvLS67VahM7GpcxinNS48IojG4IbCXVSVFGdJ9Z540Bk29ibCu5kPvLZOKX
         Hy/Q==
X-Gm-Message-State: APjAAAXyWNPj/b2V5reXr0OAFj69DjdD0LKf2LtR0X9ixduILYguGdpO
        IbndC59K4lypTdWedEpNv7YsB43+CnE=
X-Google-Smtp-Source: APXvYqxVU3yLcTZM9+JbZw2aknkjILf86xwD+yg/slcJ3MGv1Jc04CZqN6h784iNr8pKZichFftYjw==
X-Received: by 2002:a19:6748:: with SMTP id e8mr10274017lfj.136.1569019494171;
        Fri, 20 Sep 2019 15:44:54 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 196sm733948ljj.76.2019.09.20.15.44.52
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 15:44:53 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 7so8526666ljw.7
        for <linux-api@vger.kernel.org>; Fri, 20 Sep 2019 15:44:52 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr10397369lje.90.1569019492155;
 Fri, 20 Sep 2019 15:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc> <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
 <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
 <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com>
 <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com> <CALCETrXMp3dJaKDm+RQijQEUuPNPmpKWr8Ljf+RqycXChGnKrw@mail.gmail.com>
In-Reply-To: <CALCETrXMp3dJaKDm+RQijQEUuPNPmpKWr8Ljf+RqycXChGnKrw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 15:44:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whz7Okts01ygAP6GZWBvCV7s==CKjghmOp+r+LWketBYQ@mail.gmail.com>
Message-ID: <CAHk-=whz7Okts01ygAP6GZWBvCV7s==CKjghmOp+r+LWketBYQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 20, 2019 at 1:51 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> To be clear, when I say "blocking", I mean "blocks until we're ready,
> but we make sure we're ready in a moderately timely manner".

.. an I want a pony.

The problem is that you start from an assumption that we simply can't
seem to do.

> In other words, I want GRND_SECURE_BLOCKING and /dev/random reads to
> genuinely always work and to genuinely never take much longer than 5s.
> I don't want a special case where they fail.

Honestly, if that's the case and we _had_ such a methoc of
initializing the rng, then I suspect we could just ignore the flags
entirely, with the possible exception of GRND_NONBLOCK. And even that
is "possible exception", because once your worst-case is a one-time
delay of 5s at boot time thing, you might as well consider it
nonblocking in general.

Yes, there are some in-kernel users that really can't afford to do
even that 5s delay (not just may they be atomic, but more likely it's
just that we don't want to delay _everything_ by 5s), but they don't
use the getrandom() system call anyway.

> The exposed user APIs are, subject to bikeshedding that can happen
> later over the actual values, etc:

So the thing is, you start from the impossible assumption, and _if_
you hold that assumption then we might as well just keep the existing
"zero means blocking", because nobody mind.

I'd love to say "yes, we can guarantee good enough entropy for
everybody in 5s and we don't even need to warn about it, because
everybody will be comfortable with the state of our entropy at that
point".

It sounds like a _lovely_ model.

But honestly, it simply sounds unlikely.

Now, there are different kinds of unlikely.

In particular, if you actually have a CPU cycle counter that actually
runs at least on the same order of magnitude as the CPU frequency -
then I believe in the jitter entropy more than in many other cases.

Sadly, many platforms don't have that kind of cycle counter.

I've also not seen a hugely believable "yes, the jitter entropy is
real" paper. Alexander points to the existing jitterentropy crypto
code, and claims it can fill all our entropy needs in two seconds, but
there are big caveats:

 (a) that code uses get_random_entropy(), which on a PC is that nice
fast TSC that we want. On other platforms (or on really old PC's - we
technically support CPU's still that don't have rdtsc)? It might be
zero. Every time.

 (b) How was it tested? There are lots of randomness tests, but most
of them can be fooled with a simple counter through a cryptographic
hash - which you basically need to do anyway on whatever entropy
source you have in order to "whiten" it. It's simply _really_ hard to
decide on entropy.

So it's really easy to make the randomness of some input look really
good, without any real idea how good it truly is. And maybe it really
is very very good on one particular machine, and then on another one
(with either a simpler in-order core or a lower-frequency timestamp
counter) it might be horrendously bad, and you'll never know,

So I'd love to believe in your simple model. Really. I just don't see
how to get there reliably.

Matthew Garrettpointed to one analysis on jitterentropy, and that one
wasn't all that optimistic.

I do think jitterentropy would likely be good enough in practice - at
least on PC's with a TSC - for the fairly small window at boot and
getrandom(0). As I mentioned, I don't think it will make anybody
_happy_, but it might be one of those things where it's a compromise
that at least works for people, with the key generation people who are
really unhappy with it having a new option for their case.

And maybe Alexander can convince people that when you run the
jitterentropy code a hundred billion times, the end result (not the
random stream from it, but the jitter bits themselves - but I'm not
even sure how to boil it down) - really is random.

             Linus
