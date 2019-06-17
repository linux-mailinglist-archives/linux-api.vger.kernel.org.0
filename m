Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21E948BA7
	for <lists+linux-api@lfdr.de>; Mon, 17 Jun 2019 20:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfFQSNk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Jun 2019 14:13:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35677 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfFQSNj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Jun 2019 14:13:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so7241887lfg.2
        for <linux-api@vger.kernel.org>; Mon, 17 Jun 2019 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J081FiTz/dcpmcwzq5O6GF0XKXf+1rYscrgrosKZT9c=;
        b=HBku58NGVAv95CcjvbfqVxo4zSvDzDkjpBqEa1eT1BUBn499MwtAVYnMb8KuIY8q1x
         tRdMVTbOCh2URPJ2ZL0QtQNOYWR65ySiiK8lBU7nvffrP+x6MGzSjtH5IXIMF7+XVEV/
         Dp3mtWFQ74+2UcMPuzNH0qKa44Gwg/tiwMvL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J081FiTz/dcpmcwzq5O6GF0XKXf+1rYscrgrosKZT9c=;
        b=kEfryGx2JAGlvLsvXBHjvV9Bfb5dFebJqQgtAgTsaNsT/7tBckNVjXl10C62nwuJ9m
         bjtdYFVSuokKN2whBkxskxkHH9YW5fjidX68wqxMct49agsvMy7MSfVpDHX/UuTHF+2U
         P2IMeAbgo41dwhzN/wEo4bhe3aaioVW8aKK7FdFfH7vc67xzSvCBCDmqGqAEqggezMEy
         FCvETdoyQmipc8ZLKByMUNMog2drNMlNYKEOpNJzlusPEm5ybIYkt6Q1rB2YJqkvVbZd
         ODoEk/kPCPl0JmWgzoowfgOyJt666Eu2dCc5nbrDj2VUNCR0ca04TyJmakzg8/P5ITPk
         yzvA==
X-Gm-Message-State: APjAAAXQt7Uy/ZLBimJn+elbIUGtyWR6iSA+o8E0J6h+uEuwQS/ZYGUD
        9LIbAMerSTL781PL0e2FYaSz61JFiVs=
X-Google-Smtp-Source: APXvYqy24+Of5+PDV1xA6dWO4MVs59tZQimyqBwFoUQby0u3Js6mkl3HWuRx1QK8n8U/GcyhkoSWSQ==
X-Received: by 2002:ac2:4d17:: with SMTP id r23mr691859lfi.130.1560795217549;
        Mon, 17 Jun 2019 11:13:37 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id i1sm1847677lfc.86.2019.06.17.11.13.36
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:13:36 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a21so10250352ljh.7
        for <linux-api@vger.kernel.org>; Mon, 17 Jun 2019 11:13:36 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr17483710ljj.156.1560795216288;
 Mon, 17 Jun 2019 11:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com> <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
 <87sgs8igfj.fsf@oldenburg2.str.redhat.com> <CAHk-=wjCwnk0nfgCcMYqqX6o9bBrutDtut_fzZ-2VwiZR1y4kw@mail.gmail.com>
 <87k1dkdr9c.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87k1dkdr9c.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:13:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
Message-ID: <CAHk-=wgiZNERDN7p-bsCzzYGRjeqTQw7kJxJnXAHVjqqO8PGrg@mail.gmail.com>
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

On Mon, Jun 17, 2019 at 11:03 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> There's also __kernel_fd_set in <linux/posix_types.h>.  I may have
> lumped this up with <asm/posix_types.h>, but it has the same problem.

Hmm.

That one we might be able to just fix by renaming "fds_bits" to "__fds_bits".

Unlike the "val[]" thing, I don't think anybody is supposed to access
those fields directly.

Of course, "supposed to" and "does" are two very very different things ;)

                  Linus
