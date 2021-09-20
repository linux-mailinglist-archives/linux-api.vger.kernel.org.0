Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AA041262A
	for <lists+linux-api@lfdr.de>; Mon, 20 Sep 2021 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354251AbhITSyF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Sep 2021 14:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385955AbhITSwy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F14861175
        for <linux-api@vger.kernel.org>; Mon, 20 Sep 2021 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632163023;
        bh=vQjBnhTwHmPMbbhl5uyt9zJIV9R7eGnAmOsYenFvtsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AGrJqMWLy5D8MwbrPjvH57/frMZS8S7h+L//qAV4bKFU+HlX8arcdT2Ob9ihnD8d2
         xeoCik8ycGNmI+WAlLIMnk4UP/i8ZX2K4bXfLFOY9xvc7belpMuLi+LplsX0af9QXh
         fi3HP54KCv36+hF/zA1NWiTlRgoHkgVSkGB5vfQSM/vJdBWnP2y43Z12j3DQjSHDWh
         Pg2xpmi6uJHtCWRteGH62j/5mJA3PYQNZyfYqYdhbFF6RYh6f0c11cxQbIenKAO9zT
         FrPQnqv4SezdW+iRpIg4NIXW0MEXCNMqXx80fJnEPY4W0qnZ349pBapAiS1DHTAKdJ
         nQVijGdTYNzpg==
Received: by mail-ed1-f44.google.com with SMTP id bx4so20456606edb.4
        for <linux-api@vger.kernel.org>; Mon, 20 Sep 2021 11:37:03 -0700 (PDT)
X-Gm-Message-State: AOAM533wNFuGDKBoGcFMF7J2dNBxPPoYybqyywQg4YBjrWwiEphbGSB/
        s1Kza2PP6JMquiNvFyqq29s05//wy0vpwUWEvGz2Tg==
X-Google-Smtp-Source: ABdhPJybR6N3U9WMW2cuE+TpvrIh2UZNl4YM1p+MlmtT3J1aFk/vnh+3IzRCGMqSBwkk5gktGNysKCQGbjYyhLubSuo=
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr30711354ejr.435.1632163021669;
 Mon, 20 Sep 2021 11:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein> <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de> <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
 <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de> <YUi95tFDWS7oceYP@bombadil.infradead.org>
In-Reply-To: <YUi95tFDWS7oceYP@bombadil.infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 20 Sep 2021 11:36:47 -0700
X-Gmail-Original-Message-ID: <CALCETrX9keVFxEZYUkKr7_dWb9Ubo9q4E2aTY_ZOWGSHyRph8g@mail.gmail.com>
Message-ID: <CALCETrX9keVFxEZYUkKr7_dWb9Ubo9q4E2aTY_ZOWGSHyRph8g@mail.gmail.com>
Subject: Re: [RFC] Expose request_module via syscall
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 20, 2021 at 11:16 AM Luis Chamberlain <mcgrof@kernel.org> wrote=
:
>
> On Mon, Sep 20, 2021 at 04:51:19PM +0200, Thomas Wei=C3=9Fschuh wrote:

> > > Do you mean it literally invokes /sbin/modprobe?  If so, hooking this
> > > at /sbin/modprobe and calling out to the container manager seems like
> > > a decent solution.
> >
> > Yes it does. Thanks for the idea, I'll see how this works out.
>
> Would documentation guiding you in that way have helped? If so
> I welcome a patch that does just that.

If someone wants to make this classy, we should probably have the
container counterpart of a standardized paravirt interface.  There
should be a way for a container to, in a runtime-agnostic way, issue
requests to its manager, and requesting a module by (name, Linux
kernel version for which that name makes sense) seems like an
excellent use of such an interface.

--Andy

>
>   Luis
