Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1709F28C177
	for <lists+linux-api@lfdr.de>; Mon, 12 Oct 2020 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbgJLT26 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Oct 2020 15:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387797AbgJLT26 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Oct 2020 15:28:58 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10919C0613D0
        for <linux-api@vger.kernel.org>; Mon, 12 Oct 2020 12:28:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so17955141ljn.13
        for <linux-api@vger.kernel.org>; Mon, 12 Oct 2020 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBBv8x0EA+jyMbeGbj2AD5+EOk9EuJpVDyEvfsZ1FnQ=;
        b=Sg/dv0+6q/T5D5BigWu87HiS3Oyz1Gx2mRS8WRM0qJR+ZvzBax9hT9Li7FBVJE0ydo
         qxNsvOzo9+2aL74hch0pe/IBE/A3RgBB2mlynpMG99k3j8N5fOXAJq6TsU1kqDdSiWNJ
         88IXcUyrzO2MAL00aCNG8np3MdgE/b4+Tqkog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBBv8x0EA+jyMbeGbj2AD5+EOk9EuJpVDyEvfsZ1FnQ=;
        b=q4ubZXkH7ElQNGzt+Yss86iJCeXx81mRqzhCLMPjdcrsYlnqFOeSV2tTMkqX2I7sVK
         wPAq6rwDJuwxiIWijwahZDzeSpsoxbn3LkpBhCNVKJTmX3bddERrbzs0AxR4NQEwJgmh
         oVvbUa6I0qhXHKsE/nyQ3rsmLj19PON+C8e8qat/CU4LJcDQ8+5DDmrlgtLjXcD/x6Yo
         pzl9isPht7tNk5r9L+V7tFeVw2gWR4iDB0DUX8jO3yLf+tHUUWfV7kNwwWf9wAEIMJYx
         bEpaJeA8sybVNLM73psI9bvDMT+R4B3VVQuJZ/dp7vy9+yVZHkbgwITl3DPF2BfKbaXE
         aR/g==
X-Gm-Message-State: AOAM530hK/WqLi0ByIUgb0hbyYJ8BoRhUiPEQi6kBS1ObHm5f8oQu8+2
        ltWLCv9A/3c9MGpjUJCu932gC3/AAs7cDQ==
X-Google-Smtp-Source: ABdhPJzKDl6ifvH/KP74BYVHgAo4DVUpM+IOwFhqhCtoThOFa30UynNFVyjHqqQ6Lvo5YqQ8XZTe6w==
X-Received: by 2002:a2e:924d:: with SMTP id v13mr2528151ljg.375.1602530935583;
        Mon, 12 Oct 2020 12:28:55 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m19sm1508396lfl.38.2020.10.12.12.28.54
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f29so4130281ljo.3
        for <linux-api@vger.kernel.org>; Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
X-Received: by 2002:a2e:9152:: with SMTP id q18mr10194176ljg.421.1602530934167;
 Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
In-Reply-To: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 12:28:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfydyikU_KfHSLo1uMSs-vksDjYkdnyv1+89C32XwUOA@mail.gmail.com>
Message-ID: <CAHk-=wgfydyikU_KfHSLo1uMSs-vksDjYkdnyv1+89C32XwUOA@mail.gmail.com>
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
To:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Alexander Viro <aviro@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 12, 2020 at 12:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, the old pipe behavior was that it would wake up writers whether
> they needed it or not [..]

That "writers" should be "readers", of course.

Although yes, that commit changed it for both readers and writers: if
the pipe was readable from before, then a writer adding new data to it
doesn't make it "more readable". Similarly, if a pipe was writable
before, and a reader made even more room in it, the pipe didn't get
"more writable".

So that commit removes the pointless extra wakeup calls that don't
actually make any sense (and that gave incorrect edges to the some
EPOLL case that saw an edge that didn't actually exist).

              Linus
