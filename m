Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D567E0DC8
	for <lists+linux-api@lfdr.de>; Tue, 22 Oct 2019 23:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfJVV2B (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Oct 2019 17:28:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38590 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbfJVV17 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Oct 2019 17:27:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id q28so11029066lfa.5
        for <linux-api@vger.kernel.org>; Tue, 22 Oct 2019 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sC7HSfb2VOkcipSqiZUGFtYaUxnR7Wt7cAUpMLN2oNc=;
        b=d/RTOx8b3U9xLKMNU8hgAwzgUFgP0wI0I78MgFGo5S9RxNwmUYga4vLUgMB+jV4e90
         JD0z80pZFg5atR7ZfnvDKTGRRXWKxvFCLzkjU4VpwJ0cVyHC7IJE/jenH9piaQ29f9y1
         6O7bbq+Py3xOllvFcTxsY48y8xWuHcYGlQJtgxFzWc3qms3t4t+4x285MPbC9an3ZcvK
         6KUKqwVQEX9c/uJ8QuiXxpKwfIImpNCTTWtFhvagyjvMyGJAbHnmXoNgx2ZIcUrz1Rl2
         1sADZVEtgWJI78llDswMxd+0BfIrHiRkqzBuXv+WBJ3teUdRsXb+THuZqZao+YTKtX9P
         1TFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sC7HSfb2VOkcipSqiZUGFtYaUxnR7Wt7cAUpMLN2oNc=;
        b=XozxQSBqHTkSbhZplyYkR1LIoGXYR4NNTIEMseKmu9yFOqFnhsj2qOIkae0rmiouzd
         AttuS7ScjTypmgIjqvgIrdGGZElPf6bR5Cb1Gg0QaSUF17bGyvgEY+KBr6U8uzjD787o
         jTeKrqSuK+7/26BQqJG68o97lxNYSg900ijMHIVDz/vnNdaluCdoRNcF2Bcrx1IEPB59
         UzP1+Dra8pVRsFz+SuJ8HfQjuNXpexMMIXPh6FNhbxehFKY0DOvb1y6+66gzWSg+dFg0
         wwD/ehQNaV6Ag4NnvG5Qn/hAVWt8mK8wGzZtjCD5R00fqcSe7rNo8pULkDdZokVVGbvJ
         rsig==
X-Gm-Message-State: APjAAAUEJTqL2bow9WJbLj5Y4Z2UbBLvHzXsGP/kHtPr0AAGlfDPfr3M
        NGxPwwFXCPfFO1V3Jpmz5wZgYRGOUqMj14FpcgZobg==
X-Google-Smtp-Source: APXvYqwFV8qXwJtM7cnjAnOyJyVn3NlRuVspzSfQ76qX4vGPHP7ckHVTpW+7szVpGRXWavpHfb0/Lto0ZQ2teHSplF8=
X-Received: by 2002:a19:ac48:: with SMTP id r8mr4712555lfc.181.1571779677332;
 Tue, 22 Oct 2019 14:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com> <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
In-Reply-To: <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 22 Oct 2019 14:27:20 -0700
Message-ID: <CAKOZueuhU05wXWcoAnfRM4rShuvQ8BteV32WTiWDmAA3-LBJfg@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 12, 2019 at 6:14 PM Andy Lutomirski <luto@kernel.org> wrote:
> [adding more people because this is going to be an ABI break, sigh]

Just pinging this thread. I'd like to rev my patch and I'm not sure
what we want to do about problem Andy identified. Are we removing
UFFD_EVENT_FORK?
