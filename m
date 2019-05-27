Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACA2BAAD
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfE0T1b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 15:27:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38412 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfE0T1b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 15:27:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so15552416ljj.5
        for <linux-api@vger.kernel.org>; Mon, 27 May 2019 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wd78z65uwhoM3ZRJNvBK+0h0z7TF6bqVWxLdc1NV2X4=;
        b=LGnbuv9FuD6KUsqZha7QN8hFiUBO8xRgmaS45CB4OxnREfVukEvDCgYO5N/0PHXnGF
         5h9pdEEPPY+noavybWPcq177D/0MwCxHqGQO/kg9yHPrJJjqZW0W1OmvLZZuVocaYAoe
         MsjOXzqUVioxHYj9DO5Ltrrc2cXtDVvivTa/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd78z65uwhoM3ZRJNvBK+0h0z7TF6bqVWxLdc1NV2X4=;
        b=pQRUqRwoWTYxxAGDyJ2bNxoNzo/HSW+/0BLjQRYnGoCAdnQK/v3aSlHdrBbamILxOh
         yPJJswFBbTJ6hbV3GipODd8I3SQgaL5LXGO4srsghi0jtb9e0sjenF0VNkm5BmiSk0av
         QJDbxe2fI1gXo/3B6esV+B3nkKG2AOKyhlvm/mZm4ArTtSKV40tZOI78o8H7BXbdSRhT
         fVCqhn9gGXlPJEP2FFgsHQ4YS6hR3zIzLGuKX5aAqj/Fxb+TLh0ENSYpVXNJHLdgKbBc
         WsfLik9O0K0r6V9I4jWpECqiicJbaUNA5xw89yfNlI4FZozR+SG+JCDNA7s6ZC/0Xney
         J6pg==
X-Gm-Message-State: APjAAAWhjMaIrUEUeCQWP9nnBSUGV9KM8A7fndJ0g2GzGhLxjJZeefcm
        ZgLazQjZhdg19TIMWT5lj0An15RGT/A=
X-Google-Smtp-Source: APXvYqy4ji1rT2AWZlFzRC5PK8DUKw1cEmxCd6Up1oI3UIExl2fbEWTopyxaf1a10EvkIoMWas4s/w==
X-Received: by 2002:a2e:4701:: with SMTP id u1mr56257738lja.38.1558985248647;
        Mon, 27 May 2019 12:27:28 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k20sm2435218lfm.30.2019.05.27.12.27.25
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 12:27:28 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id e13so15490327ljl.11
        for <linux-api@vger.kernel.org>; Mon, 27 May 2019 12:27:25 -0700 (PDT)
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr52565527ljj.52.1558985244303;
 Mon, 27 May 2019 12:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
 <20190527104239.fbnjzfyxa4y4acpf@brauner.io>
In-Reply-To: <20190527104239.fbnjzfyxa4y4acpf@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 May 2019 12:27:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
Message-ID: <CAHk-=wjnbK5ob9JE0H1Ge_R4BL6D0ztsAvrM6DN+S+zyDWE=7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: add clone6
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 27, 2019 at 3:42 AM Christian Brauner <christian@brauner.io> wrote:
>
> Hm, still pondering whether having one unsigned int argument passed
> through registers that captures all the flags from the old clone() would
> be a good idea.

That sounds like a reasonable thing to do.

Maybe we could continue to call the old flags CLONE_XYZ and continue
to pass them in as "flags" argument, and then we have CLONE_EXT_XYZ
flags for a new 64-bit flag field that comes in through memory in the
new clone_args thing?

That would make the flag arguments less "unified", but might make for
a simpler patch, and might make it easier for the old interfaces to
just pass in the clone flags they already have in registers instead of
setting them up in the clone_args structure.

I don't think it's necessarily wrong for the interface to show some
effects of legacy models, as long as we don't have those kinds of "if
(is_clone6)" nasties.

                   Linus
