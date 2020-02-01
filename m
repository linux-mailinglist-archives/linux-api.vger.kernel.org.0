Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4EF14FA98
	for <lists+linux-api@lfdr.de>; Sat,  1 Feb 2020 22:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgBAVEF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 1 Feb 2020 16:04:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36430 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBAVEF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 1 Feb 2020 16:04:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so11808926edp.3
        for <linux-api@vger.kernel.org>; Sat, 01 Feb 2020 13:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5xWGlvNfGW6R2a9oEMXO5Vtc+knDhZupxtbrwKUTXo=;
        b=bcQ8FHSYBBwSb81QiCF/CKbYbzpf1tXxm8vOpxbJAF12nriUjGMwkVIFbp0mq+2rZG
         7ruF44t2Z0ZSJLH2D/5kxkD17Zv66LgSg4AT4ERgBhAcALe4zS9ENkDobSB5jFoGejpC
         pQaI3ZXFRujxGKy665W4vaewcvoTNCGXu5WiO5DNXBDrHJj3QCyHYMVbfAkDLwa+/ENY
         kiFMORLakKwn7OrqDVWnjKtbwqeKx9W4jVQJiwmND89XzgFMJnztVcVqAx+mOUvXUgvp
         shvkhry3P/mJdC6lcxeQVqFmzSGh6vfViT5i8wIg1CbwMM5Na8ih7Ei5050pBuPCb3fw
         BsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5xWGlvNfGW6R2a9oEMXO5Vtc+knDhZupxtbrwKUTXo=;
        b=V1si/SBMZD2B27srfoQ0XrY9NRkzNj3aKCTKXsHX+HObxTQam3gOmpB0uGXhglAQe7
         aeaqItSMv9mnJHOnZkm6FINreFvqcW1eoQj3OpfNziJseHTHlYB3Gv/W5ciaYVPsoU1O
         vp1fCkqwG/5XUXVpvH0rtmZw8iIWsO3P4IiNFey/40NvlYkDn4oybkhZgG5QBjz7aGjQ
         BTXSnLfOJT+sdyQ2cgRmxAw12T8YPx/3/P4DuQdpJkEWe6nBzv18UxAN1yPzx6pfzmel
         T5RHfEKYzzqiRDOSMoMGk6FZeT5R9TdylNtLuGPuAVBNLy0e9yKSh9Yi1f7rJ2xEUKJt
         Uo/Q==
X-Gm-Message-State: APjAAAURKXxAT0EmEee72ERjswn5LMeBB2UnFfrF5Y6cTGoxTN8p3ATS
        1OIMbWKUrVNnrbmH6jjMIFIhN3dOzPgnNWKoetYoaA==
X-Google-Smtp-Source: APXvYqyeuHjcmV/Xzo4whsXR8bzA6nBXfklcpdG29SfmnlxREzB00zSM/PJfdcDHg+A5M772ODl1DKNwwX3tVsLcNjg=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr5935349edb.146.1580591043082;
 Sat, 01 Feb 2020 13:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box> <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box>
In-Reply-To: <20200129104655.egvpavc2tzozlbqe@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Sat, 1 Feb 2020 22:03:37 +0100
Message-ID: <CADyq12ysX9Ce+CUr=Cs-LcYrJDeYubDfZy2-GYFHAz111J8QBA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Kirill,

On Wed, Jan 29, 2020 at 11:46 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> And based on the use case you probably don't really need 'fixed'
> semantics all the time. The user should be fine with moving the mapping
> *somewhere*, not neccessary to the given address

This is true and and it simplifies things a bit as for the outlined
use cases the user would not be required to mmap the destination
before hand. Part of the reason I chose to require MREMAP_FIXED was
because mremap need not move the mapping if it can shrink/grow in
place and it seemed a bit awkward to have "MUSTMOVE" behavior without
MAP_FIXED. I'll make this change to drop the requirement on
MREMAP_FIXED in my next patch.

> BTW, name of the flag is confusing. My initial reaction was that it is
> variant of MREMAP_FIXED that does't anything at the target address.
> Like MAP_FIXED vs. MAP_FIXED_NOREPLACE.
>
> Any better options for the flag name? (I have none)

I see your point. Perhaps MREMAP_MOVEPAGES or MREMAP_KEEP_SOURCE? I
struggle to come up with a single name that encapsulates this behavior
but I'll try to think of other ideas before I mail the next patch.
Given that we will drop the requirement on MREMAP_FIXED, perhaps
MOVEPAGES is the better option as it captures that the mapping WILL be
moved?

Thanks again for taking the time to look at this.

Best,
Brian
