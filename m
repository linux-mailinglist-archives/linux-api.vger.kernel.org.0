Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0FF394FC
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2019 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfFGS4h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 7 Jun 2019 14:56:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40409 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732051AbfFGS4g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 7 Jun 2019 14:56:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id a9so2386785lff.7
        for <linux-api@vger.kernel.org>; Fri, 07 Jun 2019 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldUxE0mi4WaCkQbvj9tDP1Y3dc9QMW/mTJhHqgLzTEc=;
        b=RKAsnvIg7cohPa9ftFN/RAF3uODOQevDuoFKHSPc0Xl7WdRdmcZdyGnMNLHluRHbqx
         u1w+QeICOks1DEl+AX3rcan7uhfcKxu3t+qYGPITFJ/CPSgD+SwNUDgnEQevDh4687CE
         28hm9HoLaAqEQO2OQjx2RFtlsWUqCO4SqrVko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldUxE0mi4WaCkQbvj9tDP1Y3dc9QMW/mTJhHqgLzTEc=;
        b=av/CTGRu0rF8kAzxVYRVgJaspQrRY82No2qfyrYjXkE4ugu/if3YC0JWIziutB999R
         oC8Y9MgAsPFixYcxWyQWkkNXF4oB99EcQWG7UKHjLEhvd68KgAr7dTEKK335XxVkhBym
         JX5MG5/t9aPBSv8Ob0HDycslOU/B9nc+dnpd8+GqWQeD4NfJxlnNG4eyknKw8amgZff1
         bGIeHpvs+4ZN6+AC6x4ne1D3d5GRdPgIXZJRsaTYuq/jl/uGy0K4zP9NDNgoXtyIbov4
         tTWXvwfvg0gwI+IQXVllXek02bUchYyszzqnglu3CrhJfN5vSw+5hf1x6CgQO3pj8JhG
         4atw==
X-Gm-Message-State: APjAAAXI0/YOtHM+EbJrWqUlGfHvKwlbZO9mFG+aubLjhImGFIYUjXQ4
        rMBd8Dn+9YA3uzrTNNhL+IljEv8WKew=
X-Google-Smtp-Source: APXvYqyEqA3M7sNrssFXpdyiap8WMiRURUWcrC8iADKWvcFCpXGDaC+3dU6qCitFh/+lKsv3WoVMrw==
X-Received: by 2002:ac2:5a4b:: with SMTP id r11mr17581665lfn.9.1559933793752;
        Fri, 07 Jun 2019 11:56:33 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q2sm491393ljq.74.2019.06.07.11.56.32
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:56:33 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id k18so2614322ljc.11
        for <linux-api@vger.kernel.org>; Fri, 07 Jun 2019 11:56:32 -0700 (PDT)
X-Received: by 2002:a2e:635d:: with SMTP id x90mr19091410ljb.140.1559933792458;
 Fri, 07 Jun 2019 11:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <871s05fd8o.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 11:56:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
Message-ID: <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
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

On Fri, Jun 7, 2019 at 11:43 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> On the glibc side, we nowadays deal with this by splitting headers
> further.  (We used to suppress definitions with macros, but that tended
> to become convoluted.)  In this case, moving the definition of
> __kernel_long_t to its own header, so that
> include/uapi/asm-generic/socket.h can include that should fix it.

I think we should strive to do that on the kernel side too, since
clearly we shouldn't expose that "val[]" thing in the core posix types
due to namespace rules, but at the same time I think the patch to
rename val[] is fundamentally broken too.

Can you describe how you split things (perhaps even with a patch ;)?
Is this literally the only issue you currently have? Because I'd
expect similar issues to show up elsewhere too, but who knows.. You
presumably do.

                Linus
