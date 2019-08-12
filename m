Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3BC89585
	for <lists+linux-api@lfdr.de>; Mon, 12 Aug 2019 05:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfHLDEw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 11 Aug 2019 23:04:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43249 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfHLDEw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 11 Aug 2019 23:04:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id h15so3317852ljg.10;
        Sun, 11 Aug 2019 20:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQiSQRNit1pwC9yi8sjcdyIjfy8y+tALvc4Wl2a4X6M=;
        b=tiYPxybzu8GIIn46WEKhu7lCRB7l7N8izZUpw/Oxeiz5uQNLSVcbaVw7m1AeyPuw3o
         btjJJSdY98vX9SO5ctbb2Tbb4Cp43k7kLTcRnwPeLb5Bm9+1AafnoAt6IwA+4RMN7L0/
         nu2OSPU7f6uwGlLA8kiGAQD3KbyyfSM7n++j7oxIX4YTmwIAp3DJghzarT4P9Ouej+9r
         Z6SmkmFr+XnUqyNFAmOrywSGttG5KRHwrmG45+YOp77gXXJsvK+NNXIOobiB7eIEgyZg
         Sfg3g1aYT+wxonfySvVKIqvHtCrIYvSp4O59tcCssnLDc9i5NbJn2lXaUia6lkqVA1Fu
         HlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQiSQRNit1pwC9yi8sjcdyIjfy8y+tALvc4Wl2a4X6M=;
        b=sQCfN9DUYPQLfhWTp3UkDsFL85RMu72Jki7Ghlm3MgPPNkIzCJWdd1zJePbiBGMS5O
         7s0hpfgenD14NzYgBzLdVQFbB33ThHfxNDVIiSrsJA/UPUVUq2Qsu+YokRjqgTAVGCHy
         9gvu+7PWbV6QfgbrDlJoTMonhXgJAC1wmEaNcKJlbVF0a/YkzgFr26IsGARirirLclTx
         vdvn0M/r7wwofzwojMV84b9R3l1Z/H8PSbDeE5Rq3LEwIlT+fc5FTOgjdaxE6KtC8yyG
         kbXlqLGVAc09sZyOv/6PyXBBTsm/FE4ys3NhayWZDMP+kxOvv9cE9WK8o4uypvdXoVz5
         zOmw==
X-Gm-Message-State: APjAAAXywBCbnrKT4ZGuzuJUnU8w3occ6qpWe0JABOqBtyd9uGUvduZM
        MRfWxdn6VeITIoj/J5PAWJ9rqjIUEv6zoYFKtfVZ7S2YZgs=
X-Google-Smtp-Source: APXvYqwc7JFeUTTkcSgKoeMJk5mKKbkw15fD85WlI/E++FNuUlFcT6t1H0ldF4qX9i8orVfgq+R+dxg16H4WVhR5N2c=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr17026609lja.94.1565579090393;
 Sun, 11 Aug 2019 20:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190810010758.16407-1-alistair.francis@wdc.com> <CALCETrVArr5TTbXayDZ9rz90iGoytGW2bnV5_ZOunhOsPR1u4g@mail.gmail.com>
In-Reply-To: <CALCETrVArr5TTbXayDZ9rz90iGoytGW2bnV5_ZOunhOsPR1u4g@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 11 Aug 2019 20:04:22 -0700
Message-ID: <CAKmqyKN58BfEr2R+W=08r795zRKAT1nK_G2v6U2kQSANr+90Vg@mail.gmail.com>
Subject: Re: [PATCH] syscalls: Update the syscall #defines to match uapi
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Aug 11, 2019 at 5:00 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Aug 9, 2019 at 6:11 PM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > Update the #defines around sys_fstat64() and sys_fstatat64() to match
> > the #defines around the __NR3264_fstatat and __NR3264_fstat definitions
> > in include/uapi/asm-generic/unistd.h. This avoids compiler failures if
> > one is defined.
>
> What do you mean by "if one is defined"?

Yeah, I guess that isn't clear. What I mean is that if
__ARCH_WANT_NEW_STAT is defined but __ARCH_WANT_STAT64 isn't currently
it will fail to build.

>
> The patch seems like it's probably okay, but I can't understand the changelog.

I can send a v2 with an updated commit message.

Alistair

>
> --Andy
