Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68A14FB61
	for <lists+linux-api@lfdr.de>; Sun,  2 Feb 2020 05:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBBESX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 1 Feb 2020 23:18:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45844 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgBBESW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 1 Feb 2020 23:18:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so12332146edw.12
        for <linux-api@vger.kernel.org>; Sat, 01 Feb 2020 20:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuEb10QAUcFcGwJKCFeGhLUYYwMKG3vOlYqSejkAJjc=;
        b=BZ9+x4AUIFJLiX/N1VBjRD80E1JAY6p+Ow1VTwbX6FGZWiklyuGDkrP0qeMciPsMUe
         8nTSaKr4Ho6/S7dW2SpMb/OZSIj7QcOWDEwMYH9REu0dT4ejNyJIPZbDM/NhReSGj4pW
         0F1tPaYk4DNXr3WnbLQ58PPhFJERk1lmkG/IK6NW0wEAsqpyEd1UQ7Ty1JL1Akh47bmN
         tF+Efol3wF29/cOHJt8lRHPpntXfHAZbLjNTGpINUaeSuWaHL5PYTdxO5Kg4v+zE+uWo
         aQd7vruF8DxQ/LOBHcs/1WTiM3K89c7fQpOzkqbwjA03mvKLkr+BDjefK9rnfrRqG2H5
         UqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuEb10QAUcFcGwJKCFeGhLUYYwMKG3vOlYqSejkAJjc=;
        b=lMvQfK6xusis33bFdB9dtkr3mbtxTrJwNtV/qrLZThLIMc1lANam4nbqJhHf1PEzBy
         0qqqsBsIs297BRyJC7haApEjjtcjaO2ISK8OmG75cPlzt78GvEfvG73viIHVJUFMpDQ3
         HKgWb/eM2T90ruld42FSkWex0rqjORUsiwU9rqUNLjITaGWPdhGvdkvlEYPGji65bFPN
         h3sZLFx4HtoSYoPEl6rlP5hDW5hSWTbPQsi8rIduQ+mO4zEmXYKX6/X4m04UMX5GcFzy
         IuJhaAoCls9Q0KzQG4jQif1Y8BPTaxT3hWXWMBsQYR4wwN4egl1jWZuQnTaTSxFVuUPg
         gocQ==
X-Gm-Message-State: APjAAAXcERuzX9hmxZZQLyO/TJ3SsB/ite/HGBpKnxHt4MJqoT+ix3RX
        7VdLoOVtEdC7SuvFt1chXw9nKuqGevHD9Af0DRGd5Q==
X-Google-Smtp-Source: APXvYqybtw5f2jTQcpV4gY36OnxNY8241JvcKkzJUpgAl0cx/UBNZIzQjpkYuf3EJT/Lyi67pPW/bR73IKtF1FLPUjE=
X-Received: by 2002:a17:906:82d6:: with SMTP id a22mr15774735ejy.242.1580617100799;
 Sat, 01 Feb 2020 20:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box> <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
 <20200129104655.egvpavc2tzozlbqe@box>
In-Reply-To: <20200129104655.egvpavc2tzozlbqe@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Sun, 2 Feb 2020 05:17:53 +0100
Message-ID: <CADyq12xgnVByYOkL=GcszYYKzDpg254QEOFoW8=e1y=bmOCcFQ@mail.gmail.com>
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

On Wed, Jan 29, 2020 at 11:46 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> Any better options for the flag name? (I have none)

The other option is that it's broken up into two new flags the first
MREMAP_MUSTMOVE which can be used regardless of whether or not you're
leaving the original mapping mapped. This would do exactly what it
describes: move the mapping to a new address with or without
MREMAP_FIXED, this keeps consistency with MAYMOVE.

The second flag would be the new MREMAP_DONTUNMAP flag which requires
MREMAP_MUSTMOVE, again with or without MREMAP_FIXED.

What are your thoughts on this?
