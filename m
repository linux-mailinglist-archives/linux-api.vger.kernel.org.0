Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B448BBC
	for <lists+linux-api@lfdr.de>; Mon, 17 Jun 2019 20:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfFQSQX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Jun 2019 14:16:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33644 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFQSQX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Jun 2019 14:16:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so7279726lfe.0
        for <linux-api@vger.kernel.org>; Mon, 17 Jun 2019 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KbGZcl0Gi0jNy9coPKcSJr5heE7ZQLRdeNj3JGzwpA=;
        b=T15jTJllZ2uRduB3YrgRGX6wMT+z9NIUkv1VPJmC8yz0PENs8is1UxhM80bHpn8Wjc
         LHml4nVfexaFPrpvousJxFP6ZKHWn6WTtjuwP5+9yj+P/JOWZf04CZCjP8YosgpSq8m6
         YDg70VW3sT3LWCqjEU3XU9676uzdpl6cv7EhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KbGZcl0Gi0jNy9coPKcSJr5heE7ZQLRdeNj3JGzwpA=;
        b=C7DMnnS4H6XGM+AwjO7dlIQYXjD8yHPBK/fqbeexyJMDJKU8uuHkiYJxlWMQE3OsMK
         RgpQ9bmKTx5SQlynpTDfUxgarAuv4Hp6eT0SCqyS/IsfC2/7Rc6FFgZTZ1S0C7Yp9z9O
         W0itF+BDui3os71BJgtoIbe2Q1C3lNSUBhvDHFijJEReFglM+88eldf6SYIDE5hzWDSf
         cOdtB4FcKPKfUg7SJKj40NyRBdK3K2XVrD2il4QsP4rQ6xFVTXw6qJfvyaky9QGrD392
         kT5kjjWdz6+KPM/0SUb/K384JdHEENueRvOxvzVoVrzqTg+L/zZe09X3cm5a99YgYqq1
         PKwA==
X-Gm-Message-State: APjAAAXLpIDZ/Os/2/mxBz05QDt+x2BnVddY65C3v2hyOZPmzwHsecbz
        TRweC+UmUBJKm8Eob3UP8cGswjlFlqw=
X-Google-Smtp-Source: APXvYqyejvvV4GOdIHutLU5il4qFQltXBGCNTxvqeyELDzAngrnCsGvNuPlZWVYWirAuL7Zq+H9h0A==
X-Received: by 2002:a19:bec1:: with SMTP id o184mr26292116lff.86.1560795380607;
        Mon, 17 Jun 2019 11:16:20 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id i2sm2207451ljc.96.2019.06.17.11.16.19
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id i21so10282299ljj.3
        for <linux-api@vger.kernel.org>; Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr30169158ljm.180.1560795379164;
 Mon, 17 Jun 2019 11:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com> <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
 <87k1dkdr9c.fsf@oldenburg2.str.redhat.com> <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
In-Reply-To: <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:16:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkCOVzXeju8H8iWeh-vWorpWSZG6USFKcOWQ36XokZMA@mail.gmail.com>
Message-ID: <CAHk-=whkCOVzXeju8H8iWeh-vWorpWSZG6USFKcOWQ36XokZMA@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 17, 2019 at 11:13 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That one we might be able to just fix by renaming "fds_bits" to "__fds_bits".

That said, moving it to another file might be the better option anyway.

I think fd_set and friends are now supposed to be in <sys/select.h>
anyway, and the "it was in <sys/types.h>" is all legacy.

                 Linus
