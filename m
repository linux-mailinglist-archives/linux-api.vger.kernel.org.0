Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E34D28C4C6
	for <lists+linux-api@lfdr.de>; Tue, 13 Oct 2020 00:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbgJLWad (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Oct 2020 18:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389465AbgJLWaa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Oct 2020 18:30:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD5C0613D0
        for <linux-api@vger.kernel.org>; Mon, 12 Oct 2020 15:30:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a5so18351331ljj.11
        for <linux-api@vger.kernel.org>; Mon, 12 Oct 2020 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W9fvtl91ZorkZ0ga43XiISUsMGGK9PX5WUdwgTBh2vI=;
        b=Dvsb9R0uvANssCFhhDBM8ZUmMAdSRxV3jfJaAInjGEfCygFxKMbDlIV5j3pIUgg7Eu
         pE0AugZZMK7tqUgIPTLrRumLZSaWLINCODduTowGk1mNEDDJy0MRKRHtEJ/CuEv9FAL4
         PnvpkXXvZCKgBueBM/D99kpwIRoDd7FViwD+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W9fvtl91ZorkZ0ga43XiISUsMGGK9PX5WUdwgTBh2vI=;
        b=H3paTAwhXUcpGKFWdt4fUoF7ZAS2KJBW6sB9BXqBWMVChe4LD8jAU3VPDPeO7dIY1C
         aEMPScuEIBQZydvmZFm1bNU47HnXulqU9Snzln9K+CVZz8/ETHFJrEEvmsumVUIhDYhX
         CeHhxIk9uPVgXLULAEhuQL+3PaYArKtr6xBzsl+QyEG8OnHybG5AWl8gbUuPBsbieuzI
         Cj9+ZDtMtqrcsUkuYjfWSvNh2YL5xNIzP3MOkH+V5ruPKtym7jQue1Qsjpd74I2oWaOW
         BmknmQ1eN/qJPTKFAkGWidqVN/1nxlpYacSFMlO/fmoasyF1ut0P23mGmNl6AnktAcMc
         tEvA==
X-Gm-Message-State: AOAM5337reSKyENfTMUMD0o8GMvmweqWcOmKptVbZ+RapZ0fseoC7Nur
        mcZrQ5DJcbKSt93Db8HtNnaQnpdfEHghig==
X-Google-Smtp-Source: ABdhPJw1L/KJx3cHoheZdwWbcTuIlVwOEOXUoQ7bCC1vETjETuWOqPpCMDVjmqIzvOd/fkkJOGuCXg==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr1028833ljj.416.1602541826752;
        Mon, 12 Oct 2020 15:30:26 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id u6sm2261700lfu.32.2020.10.12.15.30.24
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 15:30:25 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id i2so18382889ljg.4
        for <linux-api@vger.kernel.org>; Mon, 12 Oct 2020 15:30:24 -0700 (PDT)
X-Received: by 2002:a2e:9152:: with SMTP id q18mr10367236ljg.421.1602541824540;
 Mon, 12 Oct 2020 15:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com> <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
In-Reply-To: <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 15:30:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYN_80i=9ALMwxZ77_TS_TMjkVyZ261xtuiMUaZsM4ng@mail.gmail.com>
Message-ID: <CAHk-=wjYN_80i=9ALMwxZ77_TS_TMjkVyZ261xtuiMUaZsM4ng@mail.gmail.com>
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Alexander Viro <aviro@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 12, 2020 at 1:30 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> I don't think this is correct. The epoll(7) manual page
> sill carries the text written long ago by Davide Libenzi,
> the creator of epoll:
>
>     Since  even with edge-triggered epoll, multiple events can be gen=E2=
=80=90
>     erated upon receipt of multiple chunks of data, the caller has the
>     option  to specify the EPOLLONESHOT flag, to tell epoll to disable
>     the associated file descriptor after the receipt of an event  with
>     epoll_wait(2).

Hmm.

The more I read that paragraph, the more I think the epoll man-page
really talks about something that _could_ happen due to internal
implementation details, but that isn't really something an epoll user
would _want_ to happen or depend on.

IOW, in that whole "even with edge-triggered epoll, multiple events
can be generated", I'd emphasize the *can* part (as in "might", not as
in "will"), and my reading is that the reason EPOLLONESHOT flag exists
is to avoid that whole "this is implementation-defined, and if you
absolutely _must_ get just a single event, you need to use
EPOLLONESHOT to make sure you remove yourself after you got the one
single event you waited for".

The corollary of that reading is that the new pipe behavior is
actually the _expected_ one, and the old pipe behavior where we would
generate multiple events is the unwanted implementation detail of
"this might still happen, and if you care, you will need to do extra
stuff".

Anyway, I don't absolutely hate that patch of mine, but it does seem
nonsensical and pointless, and I think I'll just hold off on applying
it until we hear of something actually breaking.

Which I suspect simply won't happen. Getting two epoll notifications
when the pipe state didn't really change in between is not something I
can see anybody really depending on.

You _will_ get the second notification if somebody actually emptied
the pipe in between, and you have a real new "edge".

But hey, I am continually surprised by what user space code then
occasionally does, despite my fairly low expectations.

              Linus
