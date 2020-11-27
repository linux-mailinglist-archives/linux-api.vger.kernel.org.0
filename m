Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C72C6B84
	for <lists+linux-api@lfdr.de>; Fri, 27 Nov 2020 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbgK0SXZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Nov 2020 13:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbgK0SXW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Nov 2020 13:23:22 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23370C0613D4
        for <linux-api@vger.kernel.org>; Fri, 27 Nov 2020 10:23:22 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f24so6836385ljk.13
        for <linux-api@vger.kernel.org>; Fri, 27 Nov 2020 10:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5KHpDtt5i2rR9LdUm+DCPfd8QCddCnGgU8lKoXRsc0=;
        b=k13XGK60aqGF8P+LZ5njqN9LkrUfUD2db3KBZtvlM/8c/m+Ar7Iaj3L9tzWBo8M07X
         SLsANqBnyZqRR6Y4soOGO3BasvLtrGteYICfbknYu6+sh6RI2ecZi3k8piaxa2oAkZ9r
         3r0E9YxnkK40upO2J0VCON60VP9A2pQg8FXc5xnBv6kNKFodimMOFDHidiR6CzUsbEFR
         loPKKh70S/Se5tUMMtUFbZCKu5Z+hj/H3WQX43nUvJytv6dzolyzWwSFRv5P6nDBJLoK
         qXUUk5BYiEe7ku9T/ezKgm1a+BRdDMxdD7inERGIrtnl3U0qHDisct5Mn5LnHgoH6V+P
         18tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5KHpDtt5i2rR9LdUm+DCPfd8QCddCnGgU8lKoXRsc0=;
        b=k5Vvo49HCz05wOYWvttFl8c9wWLL33+MdlMjGWyfbtyyaPP0fzjqjLr5hq7Fn0t4uv
         XBkgeiFD/Ip+UdlSxnkjmULjw6fsLSBmuZXSBbLea/6f8aCnj9nvmfmvxJ00XUPi8UFK
         ktWPcQoQOE7FtnPkd000+o3Mo0CwSpLKW9xcX1uNWslblmv/bXk231iC8l/FUUHSDaRe
         P4S3mgybOtWkvnHCosNNDkgGVFGcgsYW0IwPvKYewrsvsMHxC++k9qeDx42H8jLnAjXn
         mHfpnTOcGbkjy4DiBt8pnadE1R1YaxuhWGASsy9rQHCLvg90qSvmMFatg/NeaSZWQJEZ
         fF/Q==
X-Gm-Message-State: AOAM530qFeT+e+xgHBNprabzZtH1IEQ5MvdGbB7y0ew311sePaT9/GeH
        jyok4zt64Nj1gyO5lN/fckVERnT6r7G0S8TD9iXFAA==
X-Google-Smtp-Source: ABdhPJws0SUY2VfCWZwO1KgOCMLdvLLRf++rtY0jADZAsBpXkmgj4FmHl+qbGYochUFxuoYBMzoAHyDIowR/TJhi40s=
X-Received: by 2002:a2e:9216:: with SMTP id k22mr3959253ljg.138.1606501400078;
 Fri, 27 Nov 2020 10:23:20 -0800 (PST)
MIME-Version: 1.0
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com> <CAG48ez2VAu6oARGVZ+muDK9_6_38KVUTJf7utz5Nn=AsmN17nA@mail.gmail.com>
In-Reply-To: <CAG48ez2VAu6oARGVZ+muDK9_6_38KVUTJf7utz5Nn=AsmN17nA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 27 Nov 2020 19:22:53 +0100
Message-ID: <CAG48ez13ZAAOVmA89PRKRqr9UezV2_bj8Q6_6sSPzcqfzbsuQQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/virt: vmgenid: add vm generation id driver
To:     "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc:     "Graf (AWS), Alexander" <graf@amazon.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Willy Tarreau <w@1wt.eu>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "oridgar@gmail.com" <oridgar@gmail.com>,
        "ghammer@redhat.com" <ghammer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Qemu Developers <qemu-devel@nongnu.org>,
        KVM list <kvm@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linux API <linux-api@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "areber@redhat.com" <areber@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "gil@azul.com" <gil@azul.com>,
        "asmehra@redhat.com" <asmehra@redhat.com>,
        "dgunigun@redhat.com" <dgunigun@redhat.com>,
        "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[resend in the hope that amazon will accept my mail this time instead
of replying "550 Too many invalid recipients" again]

On Fri, Nov 20, 2020 at 11:29 PM Jann Horn <jannh@google.com> wrote:
> On Mon, Nov 16, 2020 at 4:35 PM Catangiu, Adrian Costin
> <acatan@amazon.com> wrote:
> > This patch is a driver that exposes a monotonic incremental Virtual
> > Machine Generation u32 counter via a char-dev FS interface that
> > provides sync and async VmGen counter updates notifications. It also
> > provides VmGen counter retrieval and confirmation mechanisms.
> >
> > The hw provided UUID is not exposed to userspace, it is internally
> > used by the driver to keep accounting for the exposed VmGen counter.
> > The counter starts from zero when the driver is initialized and
> > monotonically increments every time the hw UUID changes (the VM
> > generation changes).
> >
> > On each hw UUID change, the new hypervisor-provided UUID is also fed
> > to the kernel RNG.
>
> As for v1:
>
> Is there a reasonable usecase for the "confirmation" mechanism? It
> doesn't seem very useful to me.
>
> How do you envision integrating this with libraries that have to work
> in restrictive seccomp sandboxes? If this was in the vDSO, that would
> be much easier.
